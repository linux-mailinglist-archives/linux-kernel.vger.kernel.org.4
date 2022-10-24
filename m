Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E5E60BE1F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 01:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiJXXEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 19:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbiJXXD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 19:03:57 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A59BFF26A
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 14:24:28 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id a5so20471840edb.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 14:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZsnAEsVBgH1SY91CR++8td8qF2as+jKuxUWas/0RKs=;
        b=dzRCCrMq/BADC/Fq6uUj+xe4Hc2cbZBCsUhG9yVbyfUSS1a86aZsZ7fC8TIJmhqzfY
         ogPnqCKM91NWVfT8PK2+CgtZNrLhZPwQcsiw/CRCvT1q2cN3Z5CMaAQHlwPes9vGSNFo
         /xF5YfpSccFvTfAzr0DtKzQZhbnfAgNQOkdGZiVu0Cx6sdb9/Pu9W7+634yEGHSyE5ah
         5agHKO/fxUU975BV+2IYrrVPVTkvptgwuh7KLNpdnZ9L7NB98wMG0fILvtul28sqSPJv
         XB3n4hDyQfiXhvAK0+aD+k6fU7jHFFRUv+USAh+LNlJpzxNPePRDAfMWoakPD+rXIxWq
         Ckbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MZsnAEsVBgH1SY91CR++8td8qF2as+jKuxUWas/0RKs=;
        b=iAIV1G6L0PpruVCyrSBRLLLcVQMGXX0VYE9ro4ebj9iREDMNhWAq+W3qN4X6A9R9yE
         sTCA7wvcsTISEoxBu5H2nG0fPS5St9KgQlJIOUjV80gfTJZ3xCsOzgqdYPDCSNp56Kqm
         b6pBK+/kUFL7AvZEtgs78g1LkbVlHgoKNT1Ypug6AymCLnvBVTI28V6NTDiqisJxsyIv
         gGQ2MbZDOuZnyWh2siy2hfquDduqZhf/O4wXTjyTskO6MfIWyfAHQNNs6ufdOkYECw8d
         Y2hBeVlZwpRxxnjMgTwJ78YxhydVa5wGe38pWupURafWza6Ao52qLWBxp4KtNI3rtrRu
         MKYQ==
X-Gm-Message-State: ACrzQf3kkPX/BccnnPgw70nvKWQAa+2oAgSArRNL0uxI6o9Qlo0NsKSe
        yW0LPYKt88jJDe9uz9fNFdM=
X-Google-Smtp-Source: AMsMyM7RaR8vfj9qvimhwIoyMgNFL/0emWD7zwzvYCY0ojkY8rFMx9BmK8n9aBabFF67YVaGcDNeeA==
X-Received: by 2002:a05:6402:294f:b0:461:f5ce:31e8 with SMTP id ed15-20020a056402294f00b00461f5ce31e8mr2721525edb.363.1666646664984;
        Mon, 24 Oct 2022 14:24:24 -0700 (PDT)
Received: from localhost.localdomain (ip-217-105-46-178.ip.prioritytelecom.net. [217.105.46.178])
        by smtp.gmail.com with ESMTPSA id r1-20020a1709061ba100b007a9c3831409sm379354ejg.137.2022.10.24.14.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 14:24:24 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     namcaov@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] Revert "staging: r8712u: Tracking kmemleak false positives."
Date:   Mon, 24 Oct 2022 23:24:06 +0200
Message-Id: <0542c043702f4b44be90f84b39f46fd7de5d85ee.1666645510.git.namcaov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1666645510.git.namcaov@gmail.com>
References: <cover.1666645510.git.namcaov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 5d3da4a20a271e3cf5496a50cbb8118aa019374f.

This commit annotated false positive for kmemleak. The reasoning is that
the buffers are freed when the driver is unloaded. However, there is
actually potential memory leak when probe fails.

Signed-off-by: Nam Cao <namcaov@gmail.com>
---
 drivers/staging/rtl8712/rtl871x_recv.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_recv.c b/drivers/staging/rtl8712/rtl871x_recv.c
index de9a568eaffa..4db7eed64a03 100644
--- a/drivers/staging/rtl8712/rtl871x_recv.c
+++ b/drivers/staging/rtl8712/rtl871x_recv.c
@@ -17,9 +17,7 @@
 #define _RTL871X_RECV_C_
 
 #include <linux/ip.h>
-#include <linux/slab.h>
 #include <linux/if_ether.h>
-#include <linux/kmemleak.h>
 #include <linux/etherdevice.h>
 #include <linux/ieee80211.h>
 #include <net/cfg80211.h>
@@ -61,7 +59,6 @@ void _r8712_init_recv_priv(struct recv_priv *precvpriv,
 				GFP_ATOMIC);
 	if (!precvpriv->pallocated_frame_buf)
 		return;
-	kmemleak_not_leak(precvpriv->pallocated_frame_buf);
 	precvpriv->precv_frame_buf = precvpriv->pallocated_frame_buf +
 				    RXFRAME_ALIGN_SZ -
 				    ((addr_t)(precvpriv->pallocated_frame_buf) &
-- 
2.25.1

