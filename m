Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F806128F5
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 09:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiJ3IKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 04:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiJ3IKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 04:10:34 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5478B879
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 01:10:33 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id u24so4282432edd.13
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 01:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PQ7i0JvA6S2JuLGZoRuDp03Ajf9dqeVkCmxRUIqVwsg=;
        b=UyCPntXNQ0ukh7YFw3calkwPkRS6ybko2jmJT21uHy39lfS76EE/6yKfl66uzOddhh
         TBu4dJscMNXjtTkG8SI6S5jMUV9z1672YCsOhjpCwnu37hvrE7aNh0Dv1yaxc2mhfaay
         XgcWt3MY3JCZTSVsoEPUMZrCsgiA25+8m6wAEQYd6bDimx+pHhOEsaIj6H/IkXX9DzaY
         +qnfqddVI4nABEHIvQdyZ9TPDGqNA/z73MrdVFyifBTSfQ1kUuC05IITq82iLnOptscN
         ptgpv09V8SZ8afUijdzJWSJUZ4vyOnrGCdWIZlaTxIKQXSocvztozYl67bMgrfLqluj6
         G0cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PQ7i0JvA6S2JuLGZoRuDp03Ajf9dqeVkCmxRUIqVwsg=;
        b=Ie7PCIXde85tRW0QRfmb1H/0RqgZQqqIg/JR+PwS/jAD8YNRQORoNw9iX7QH6nauDL
         vCnEW7o7etAWw8BaD27Rp0pkKiLMidRFb3mdXMYYDsiLLLLv/ub9frMn5AxEc0POAJgP
         SlUC91Q47At1eE95UPal2sGY9XwmvLWUDcsB8XFOMEeL51hbXBH32cR3K0wLyt97LyMl
         ZW8sw28ZQCzkbgHLM6IWOcCTVuGbTgrmD4c6n+OxcHpqOWx5xlmIWo04sXoibvG6igCd
         qCCMCIS9u+C/sAytDiPfYOE1Rbs13E2NOe6YEtKKQiFpLmp8dZkz9aSwWK6xAcgOb5xC
         KZpg==
X-Gm-Message-State: ACrzQf0x4FKGQfLuKj0tL5uoBUsVpSWzJ9FYXDRYSjq/5ns0hV/MotD+
        ziG4RBPwoHkeefUYTfBVr1CuTINtwA8=
X-Google-Smtp-Source: AMsMyM76qqm07bZab47IsZf4MMb1ozUN42P8iWvASUTA1VPGFcBGs0gzXWaDObygso6EVOOlGe5iNQ==
X-Received: by 2002:a05:6402:33c5:b0:447:e4a3:c930 with SMTP id a5-20020a05640233c500b00447e4a3c930mr7690017edc.401.1667117432262;
        Sun, 30 Oct 2022 01:10:32 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb7e.dynamic.kabel-deutschland.de. [95.90.187.126])
        by smtp.gmail.com with ESMTPSA id la10-20020a170907780a00b0079dbf06d558sm1567299ejc.184.2022.10.30.01.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 01:10:31 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: r8188eu: use min() instead of ternary operator
Date:   Sun, 30 Oct 2022 09:10:20 +0100
Message-Id: <20221030081020.8533-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.38.0
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

Replace a ternary operator usage with the min() macro to improve
readability.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 8516e253bb03..22aab3f986b4 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -3568,7 +3568,7 @@ static int rtw_wx_set_priv(struct net_device *dev,
 
 		if ((_VENDOR_SPECIFIC_IE_ == probereq_wpsie[0]) &&
 		    (!memcmp(&probereq_wpsie[2], wps_oui, 4))) {
-			cp_sz = probereq_wpsie_len > MAX_WPS_IE_LEN ? MAX_WPS_IE_LEN : probereq_wpsie_len;
+			cp_sz = min(probereq_wpsie_len, MAX_WPS_IE_LEN);
 
 			pmlmepriv->wps_probe_req_ie_len = 0;
 			kfree(pmlmepriv->wps_probe_req_ie);
-- 
2.38.0

