Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5798172D67A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 02:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239025AbjFMAfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 20:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjFMAfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 20:35:05 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16181B0;
        Mon, 12 Jun 2023 17:35:01 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-33d269dd56bso21250705ab.1;
        Mon, 12 Jun 2023 17:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686616501; x=1689208501;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lcj3LTdqBYzQ+8iEp4pTaRpOWyZfI2CMA9mZFfHhQ/Y=;
        b=gjlqGloDt9uucOR7CHB7v7jp61ky4iS1uK8CdFNENeoC51SqSVyw1zhMnULxYU2103
         y7UuD/U/0KztPu2m7BEkfmDPIIcu75ZjmI/axFDhZs65MKe6QFJPBLKZhBQxcEYVGX1d
         Qf0WXvjJUwgPXBKufjXk5TnBPQ7MvHOcv4m9SR+Dsy65HRJcxf7xhMwn39XgNblDyZJD
         irK3qTDg7bLw7S12yY/mkeujlaHyuShkW9BSKqFfXXTPsKFbR9knzEjXksPlrmviQZjw
         TIAWiHMQnxxB5VXKTIl1OLlWyppDjrEMmrW2mFiCw3TpcUccZmVAZX54pH0hVG0lpV08
         3sfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686616501; x=1689208501;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lcj3LTdqBYzQ+8iEp4pTaRpOWyZfI2CMA9mZFfHhQ/Y=;
        b=cv73012xlkkK/Kna2Om9e4hH1T9+t7+rqdB3zVU5iwt8czA4bZyV7LkT1rjmhl4v8T
         BQyg/55EJlsaV9KgXa1FzigNTD9fOpiXwXuKQcjm15q12PHbFRQTuyhbOmbVY/SNgEOv
         138++SoJqhehKxSnZq9S7l5C4BbXqgmFVZ8zbezmAcmpbG0+3QePeYtx6QeRjilXh5DA
         i6bFr8eQ+pe7Q4sgyh97HJqrF/f1V2Y0bl26LZpvxyeAU13od+Qpgqxfo8MM8K98s+Cc
         +oSlOVio1WH58rifjC4qh8weGBG5YtiSPCC0PYTc4gMFnYcv9Hk+rcdUqHF95bbOF922
         m5wQ==
X-Gm-Message-State: AC+VfDxaEzpX6nRyXqy2t7FxSSle4ejVvnhp0IwdrL1/SjwG7Z3J0waR
        QOTN2y0OWeRIkJhhOpr6fxk=
X-Google-Smtp-Source: ACHHUZ5S0otA0gTmI5YQ9DrVHUh/f+5EYzrFFFgKbXTybv3eHjkkz52csVS8lxXgMUkXm52+uJ3m/Q==
X-Received: by 2002:a92:d94c:0:b0:338:af0b:f2bd with SMTP id l12-20020a92d94c000000b00338af0bf2bdmr8813893ilq.5.1686616500842;
        Mon, 12 Jun 2023 17:35:00 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id t7-20020a92c907000000b0032ab5a86443sm3475382ilp.74.2023.06.12.17.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 17:35:00 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kalle Valo <kvalo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] net/mediatek: strlcpy withreturn
Date:   Tue, 13 Jun 2023 00:34:57 +0000
Message-ID: <20230613003458.3538812-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strlcpy() reads the entire source buffer first.
This read may exceed the destination size limit.
This is both inefficient and can lead to linear read
overflows if a source string is not NUL-terminated [1].
In an effort to remove strlcpy() completely [2], replace
strlcpy() here with strscpy().

Direct replacement is safe here since DEV_ASSIGN is only used by
TRACE macros and the return values are ignored.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
 drivers/net/wireless/mediatek/mt7601u/trace.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt7601u/trace.h b/drivers/net/wireless/mediatek/mt7601u/trace.h
index 5a6ba015085f..07696b672161 100644
--- a/drivers/net/wireless/mediatek/mt7601u/trace.h
+++ b/drivers/net/wireless/mediatek/mt7601u/trace.h
@@ -16,7 +16,7 @@
 
 #define MAXNAME		32
 #define DEV_ENTRY	__array(char, wiphy_name, 32)
-#define DEV_ASSIGN	strlcpy(__entry->wiphy_name,			\
+#define DEV_ASSIGN	strscpy(__entry->wiphy_name,			\
 				wiphy_name(dev->hw->wiphy), MAXNAME)
 #define DEV_PR_FMT	"%s "
 #define DEV_PR_ARG	__entry->wiphy_name
-- 
2.41.0.162.gfafddb0af9-goog


