Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309EC70AE77
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 17:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjEUPHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 11:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjEUPDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 11:03:25 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699AEE3;
        Sun, 21 May 2023 07:59:36 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-510e682795fso6792204a12.3;
        Sun, 21 May 2023 07:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684681175; x=1687273175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QREnGxNFYnsuzG2DimJqntoa7qDXEYT8xgd2GHr2Lzw=;
        b=dZT13FABnnOIBYoFGqv7S5phfhw9svLlKV1tT2vpjJ8ChICYBbVhjCFvv5AnYE0/aQ
         ICwBXV2YL69CVm46NIceZAXGpnzlzllmBEbjmQqFCk4cSE52VlXrFjy0f52GBM6PNXfJ
         aTjHkwoG/Kg03/X/+OKD7+42vTb8RTA/7g1RhCm4CWdbnruB4xnPaqBDpxUXfi/tryNm
         y8CXPnJMgTESwJFljrrfXWq2/5+sgIldVR5skBXasw7BuwxFVnUr8OtvSFLDXH8CiBdu
         kADZibTpdei8u/nVA2Amdre2ngWlKU9RaaoElfs1fcJMoL2tZYUE4+EoZ7R1JQiRCNt/
         RXJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684681175; x=1687273175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QREnGxNFYnsuzG2DimJqntoa7qDXEYT8xgd2GHr2Lzw=;
        b=S8MGD+oj4jhWoiKx7dIcaDbEqy5sozhx3Muao1RrejTzLJQShK4Cwt+I/La8Kb456u
         mzJMgQTgyKc2NstpFL+ROyISEyshCikWoQUNhw6so5wwh1C0XGobP/FVGZbPtNnpT7Wr
         71a+c0FIT/IZlzi4Ual0RwU1PlFI8rpfIBUUB//g3CXewpnw4TtMX7V8K9At0lEQ2kLz
         YXps1MAcD+l7UBakiGC/O63CuIiSoQJYUErrobe81vYo/Yc52XnWwKbuqkgLeN60bSCg
         6eNsg34do4WE69pOnvPkeo5Q3qtJaZF71zhnIvhZe6D7F/AMgxipeFtMsaoI/V4FyOKO
         QeuA==
X-Gm-Message-State: AC+VfDz7m5kPMoSX1/dnsp0tt37a+JJ9qSM868giU9olbqhsTqMwbybJ
        /YtXkEj2Ws3GyP9sAe5Dk2E=
X-Google-Smtp-Source: ACHHUZ62/6kFGzijJv5+f62aIG2UXyHJe/sB6KPy/J9R7Mn9EThVdtyh4EPHTyAzYsgrUbAUWaRgnQ==
X-Received: by 2002:aa7:d5d3:0:b0:50b:f9d8:ff72 with SMTP id d19-20020aa7d5d3000000b0050bf9d8ff72mr7030385eds.31.1684681174622;
        Sun, 21 May 2023 07:59:34 -0700 (PDT)
Received: from localhost.my.domain (83.11.222.198.ipv4.supernova.orange.pl. [83.11.222.198])
        by smtp.gmail.com with ESMTPSA id f3-20020a056402160300b0050bca43ff55sm1912225edv.68.2023.05.21.07.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 07:59:34 -0700 (PDT)
From:   Artur Weber <aweber.kernel@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Artur Weber <aweber.kernel@gmail.com>
Subject: [PATCH 0/2] mms114: add support for touch keys
Date:   Sun, 21 May 2023 16:58:41 +0200
Message-Id: <20230521145843.19489-1-aweber.kernel@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MELFAS MMS114 and similar touchscreens have support for touch keys.
Enable support of them in the driver. The keycodes to emit can be
controlled by the linux,keycodes DT property.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>

Artur Weber (2):
  dt-bindings: mms114: Add linux,keycodes property for touch keys
  Input: mms114 - add support for touch keys

 .../input/touchscreen/melfas,mms114.yaml      |  5 ++
 drivers/input/touchscreen/mms114.c            | 88 +++++++++++++++++--
 2 files changed, 86 insertions(+), 7 deletions(-)


base-commit: f219050af06d83f436945880fc9c04db3bb2860f
-- 
2.40.1

