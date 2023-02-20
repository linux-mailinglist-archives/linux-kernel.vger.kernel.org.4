Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDD0569C6E3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 09:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbjBTIlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 03:41:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjBTIlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 03:41:49 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 595D1FF10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 00:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=h/aAa
        aC7c/ohEfkD+Hrucvp+WtGSFaDOTasUGz6eYMw=; b=GFcpcbMh4+aKpffWokQKJ
        NauHrbiATP0mrbFB12fj6GFPLInrukSUb34FVgEs34isz93jPL1u17av1QwCtEYV
        YxGlQ/rgiHtB+hVvHYp5BnGE6Vu3LjoqI8oSqky+lEupQXBndMQ/Wkm9U2icm/Lp
        zxZwt7mj7N+NOKmCiU3Bes=
Received: from localhost (unknown [122.206.190.60])
        by zwqz-smtp-mta-g2-1 (Coremail) with SMTP id _____wCnzwckMvNj7WHyAQ--.60572S2;
        Mon, 20 Feb 2023 16:41:08 +0800 (CST)
From:   Shibo Li <zzutcyha@163.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Shibo Li <zzutcyha@163.com>
Subject: [PATCH] staging: rtl8712: Fix multiple line dereference
Date:   Mon, 20 Feb 2023 08:40:50 +0000
Message-Id: <20230220084050.18459-1-zzutcyha@163.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCnzwckMvNj7WHyAQ--.60572S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gw45AFW5Aw1ruF15Kw1rZwb_yoWDZrg_Cw
        n2vrnrGrnru3s3G3W7Arn3ZryvgFZ7Xwn29rW8KrykArsxZas8Ja4UtFyUCFWUZa4akr9r
        Aw1xKr1agr1kWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sR_Ta07UUUUU==
X-Originating-IP: [122.206.190.60]
X-CM-SenderInfo: x22x3ux1kdqiywtou0bp/1tbiZRwcbF8ZW-fPWQACs3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following warning in rtl871x_mlme.c

WARNING: Avoid multiple line dereference - prefer 'adapter->securitypriv.PrivacyAlgrthm'

Signed-off-by: Shibo Li <zzutcyha@163.com>
---
 drivers/staging/rtl8712/rtl871x_mlme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_mlme.c b/drivers/staging/rtl8712/rtl871x_mlme.c
index 63e12b157001..cc47c1cedd4e 100644
--- a/drivers/staging/rtl8712/rtl871x_mlme.c
+++ b/drivers/staging/rtl8712/rtl871x_mlme.c
@@ -773,8 +773,8 @@ void r8712_joinbss_event_callback(struct _adapter *adapter, u8 *pbuf)
 						adapter->securitypriv.busetkipkey = false;
 						adapter->securitypriv.bgrpkey_handshake = false;
 						ptarget_sta->ieee8021x_blocked = true;
-						ptarget_sta->XPrivacy = adapter->
-						securitypriv.PrivacyAlgrthm;
+						ptarget_sta->XPrivacy =
+							adapter->securitypriv.PrivacyAlgrthm;
 						memset((u8 *)&ptarget_sta->x_UncstKey,
 							 0,
 							 sizeof(union Keytype));
-- 
2.39.2

