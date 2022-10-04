Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04EF85F46CD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 17:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiJDPfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 11:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiJDPfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 11:35:43 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD2D3472C;
        Tue,  4 Oct 2022 08:35:42 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id b7so14309309wrq.9;
        Tue, 04 Oct 2022 08:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=Fnxz/FgbBcFq4rNqZeP0eKgDgySuZn3DQygIlWco2j8=;
        b=CtaHLELVve9x0A7M4dLcyD7n2V8rEhtcfmFiZAoD5is91S2xCNveQdtEASbT+c9ry2
         qejCWansKCrnDqDxPkMgY4Bkdc0AGKYgESdnjY9Nzrxp487vmshc55O2tTbrFJu4WzV6
         TRYyNSw6D64uqca2iKAhTM4cLCsyPdrw8Vy1kpDnsOaQ88hjpDs02okrYgdKTV4V4J33
         FR32o2ur803faw6h7OhUFJw7oXFgmBH4OUQqzK4G4vk6oKCIveTrgDxyeim9hSQESRov
         END+zdoFiPh4nVGrkp+U/27Lha5FwAYr6pSrs7JShJwSfQ6vidbq0/7NPdW/b7mxTpgn
         00+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Fnxz/FgbBcFq4rNqZeP0eKgDgySuZn3DQygIlWco2j8=;
        b=ozUxjD6h0eqjZYAc37QFoZgCmgI0SW+gDi10xQtWd5YOOeklTcMO05/xGZSvsD36o4
         E2DUS5HhNiYZBWJzncTSjl5BVxAEZjgK+PnxN6pEWXNXSj1/QcGBJ37j5KBgpkEB+G6C
         JVwPtfHnC9dEx6MSSVaLZyaiNp1jTny7iZDNzD4EsW9glY7qqFzbw51IjWRImVp3nFBf
         SbybKfOJTKn6dwE4mzkFKrzfkc2hVxJxAOVZVHJ1ZU9Uz4TnzX3YSNokWRkqIsvtHckg
         oR3SWTfrqkpxy5JcDVIyS8Hw6Ix5MztqKtt5G1xdFbLv2rpwiLO8eoQNApbxG6T5eFbf
         TZVA==
X-Gm-Message-State: ACrzQf06BIb96fFcjbofFhLEzr9FaxsLB1OkFsvwjW3jKXQvHTG3ZN4T
        mLNr315UPb5WekP7+QdYKRQ=
X-Google-Smtp-Source: AMsMyM4u+Eg/UjClIph3yU19zrsXuO9gz7e0Xl6gewESqCAluwQoVYTRmyh0IU8sHkfGI8LNK4OBsg==
X-Received: by 2002:a5d:59af:0:b0:22e:32be:60f1 with SMTP id p15-20020a5d59af000000b0022e32be60f1mr8897460wrr.81.1664897740920;
        Tue, 04 Oct 2022 08:35:40 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id fc9-20020a05600c524900b003b31c560a0csm16200200wmb.12.2022.10.04.08.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 08:35:40 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        linux-staging@lists.linux.dev
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: Remove redundant initialization of variable efuseValue
Date:   Tue,  4 Oct 2022 16:35:39 +0100
Message-Id: <20221004153539.150867-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

The variable efuseValue is being initialized with a value that is never
read. The variable is being re-assigned later on. The initialization is
redundant and can be removed.

Cleans up warning:
drivers/staging/rtl8723bs/core/rtw_efuse.c:285:6: warning: variable
'efuseValue' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_efuse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_efuse.c b/drivers/staging/rtl8723bs/core/rtw_efuse.c
index 06e727ce9cc2..eb848f9bbf2c 100644
--- a/drivers/staging/rtl8723bs/core/rtw_efuse.c
+++ b/drivers/staging/rtl8723bs/core/rtw_efuse.c
@@ -282,7 +282,7 @@ u8 efuse_OneByteWrite(struct adapter *padapter, u16 addr, u8 data, bool bPseudoT
 {
 	u8 tmpidx = 0;
 	u8 bResult = false;
-	u32 efuseValue = 0;
+	u32 efuseValue;
 
 	if (bPseudoTest)
 		return Efuse_Write1ByteToFakeContent(addr, data);
-- 
2.37.1

