Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5586AD990
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 09:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjCGIu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 03:50:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjCGIuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 03:50:13 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC8B38EB5
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 00:50:10 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id cy23so49137341edb.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 00:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678179009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mBfKXBJBDHVK+Yn8iTiZud/hY3U7WgMo73YMptZicWs=;
        b=TOAuHtZjM3Ijc0PfNTcNtMrGRTmPJYiEm1CvHah72QXea4yC2xxYX1TNeuMNhRIGkj
         +lUwq3preMtRpKrJlkkuetb2G69HAiO1Ryr9AFLiFbY1LCEFiYzWyAyWYn8T6Bi0taRK
         bh+2KKVrQVXqPzbaQZyUdn9XD7X6QJL/5op9mBP93ruy+K0PSWhSOJpdOosJyfyA8yUN
         WMoYmuclPwU2wGd0UJhoTPt7NJ1R7pNTSr1FMW2a7SESYAGIFm5ahgK7vRuDa8v7RUM9
         stZoT83PLOeNfrytDNfQtSps3HuXvxa+OQOR7jNWSs2Cq0S2Gx8jCJj/Yzgw5yM5cwkN
         zmgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678179009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mBfKXBJBDHVK+Yn8iTiZud/hY3U7WgMo73YMptZicWs=;
        b=nkl0asPydh80q/QwLUCyeG3GsP4o8G7fTLfO23O2R34UGfp3U3+VtKgw6oKHFaHvBC
         wwkcuoSGQve/hY59fahQ8+6zOSynH8KbTfPHkXg3gkIwW7bBHr2SDGBXr8ldpoyxDKFw
         CeW5UrI+V9J8eZTwZFEl4DOOI2GFP+b3iYYpKfXa1DjsWdBAI+8QhA+I75fam3Nw6PnA
         0cTEIp6oTp6KbfdUXfNV/OvNwwUltCcB1kfhFIpJuu+wp5wRw6qcByNbciQoaLKbIYfw
         4ssuV1Zi350VyqRKQBxuutkJslFvUu6cCHOjYIFOJp6qCgbNxiEfPNa6YU3niQ0rvhRo
         8xEg==
X-Gm-Message-State: AO0yUKVgavvjFxjYWKtgvQqe3sVE267yj7nQQFUeALOX//0TCrTRKJCK
        Ec5GaZb5H5e8+Ucyy5539Kw=
X-Google-Smtp-Source: AK7set+d7BQhzAjk+VOU4jNGvOWZM9Pq8YoLYabn9OR+7Wyszv3kiRx9jH4I00B7UWgnMuD2/MYQNQ==
X-Received: by 2002:a17:907:8691:b0:8b1:3009:536b with SMTP id qa17-20020a170907869100b008b13009536bmr16987639ejc.29.1678179009200;
        Tue, 07 Mar 2023 00:50:09 -0800 (PST)
Received: from localhost.localdomain (ip5f5abbe7.dynamic.kabel-deutschland.de. [95.90.187.231])
        by smtp.gmail.com with ESMTPSA id o21-20020a170906289500b008ef42f9cf48sm5707402ejd.82.2023.03.07.00.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 00:50:09 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/2] staging: r8188eu: bgrpkey_handshake is set but never used
Date:   Tue,  7 Mar 2023 09:50:03 +0100
Message-Id: <20230307085003.5025-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307085003.5025-1-straube.linux@gmail.com>
References: <20230307085003.5025-1-straube.linux@gmail.com>
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

The field bgrpkey_handshake of struct security_priv is set but never
used. Remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme.c        | 1 -
 drivers/staging/r8188eu/include/rtw_security.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index fb7d0e161fdd..809ac0317db2 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -944,7 +944,6 @@ static struct sta_info *rtw_joinbss_update_stainfo(struct adapter *padapter, str
 		if (padapter->securitypriv.dot11AuthAlgrthm == dot11AuthAlgrthm_8021X) {
 			padapter->securitypriv.binstallGrpkey = false;
 			padapter->securitypriv.busetkipkey = false;
-			padapter->securitypriv.bgrpkey_handshake = false;
 			psta->ieee8021x_blocked = true;
 			psta->dot118021XPrivacy = padapter->securitypriv.dot11PrivacyAlgrthm;
 			memset((u8 *)&psta->dot118021x_UncstKey, 0, sizeof(union Keytype));
diff --git a/drivers/staging/r8188eu/include/rtw_security.h b/drivers/staging/r8188eu/include/rtw_security.h
index 783ae18a122a..8c187de7a522 100644
--- a/drivers/staging/r8188eu/include/rtw_security.h
+++ b/drivers/staging/r8188eu/include/rtw_security.h
@@ -116,7 +116,6 @@ struct security_priv {
 	u8	binstallGrpkey;
 	u8	busetkipkey;
 	u8	bcheck_grpkey;
-	u8	bgrpkey_handshake;
 	s32	sw_encrypt;/* from registry_priv */
 	s32	sw_decrypt;/* from registry_priv */
 	s32	hw_decrypted;/* if the rx packets is hw_decrypted==false,i
-- 
2.39.2

