Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704875B62FE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 23:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbiILVq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 17:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbiILVqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 17:46:36 -0400
Received: from mail-ua1-x949.google.com (mail-ua1-x949.google.com [IPv6:2607:f8b0:4864:20::949])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258E54DB35
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 14:46:32 -0700 (PDT)
Received: by mail-ua1-x949.google.com with SMTP id a8-20020ab04948000000b003b5de1448d2so3099013uad.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 14:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=ZzsIuf2L8X0Hmdw3PgLf1qkJbNjw53kAM7GLfDn/6w4=;
        b=m+elMNqNnWLEd5kNCUD5IpaFS/ZkMMWc0X8niOARjMpxI/SNjXs+cKTSRihYCqThli
         t5nc81UCWnLFXV6OTIzRDXGkejhKbvlPWU1fz9X8M02LElDQdRswB3rW8N0OVQMFquKi
         +j1N90sq2aB2+2pKwbmT4o/k5/09zxG1A+/jB8fC5nkBEXtsGHpRSBl4jnt8oMJDFgT0
         OWm60o1+LsnG5+ZslbU0TI7iBscPsATHg+j3iM73lhhJw4f+RFmfoKbEu5YIodfjd2+Q
         +nkH7O+QFnU9P+uAPPiRjf6V6f7tOPD1P7kU07/mgw545fwodinJQ2/9X5xUNHGrTrmi
         yKYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=ZzsIuf2L8X0Hmdw3PgLf1qkJbNjw53kAM7GLfDn/6w4=;
        b=BRkP5rcUn8gZwauD/4ULdF5Dh6bQCbesD29NDqig6KK1znQnymNw5VycSvDlgZoOg3
         UkrL+EvWGwyACYeK5BFeRKGV60da/+GXEgdOTMUENlOQxiJ78+SbRWgmOTrfwleDhVFd
         UGB/VeNodPckJHO8yrurQMhcLtYj8i8FTOBzSr2PFzF/6AUBRoIuzLpNyzgCkSMr5A5L
         sNjTjOU1ADV3U2bV0MSs2X+XjPbTKNmy7eyKX2RSZYrkcYyIsauxHfHEqfaJbrXjLdGo
         MsmGcHF7z1w7AIY9ZnXcp4zpZK8bnJ86ye+7MNarSBRNXP8RX9U+5jdr0510vyOMq2Oq
         JCGA==
X-Gm-Message-State: ACgBeo2O+GzwuOFxGA/NvBr7QBN3vlREzii28ajF1pJBq9X1beuoIoEO
        jckNu96TD2M29S27dTyI+wxZ6ZE5vg==
X-Google-Smtp-Source: AA6agR5BRrFw/hDp3bp0PYSQ+93fns5/iKqfGLRQmOhU9pKj1FENW6Ed8n2oYJUC+0JJcVr5f4Ia+wOj1Q==
X-Received: from nhuck.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:39cc])
 (user=nhuck job=sendgmr) by 2002:a05:6102:d89:b0:379:2914:9cfa with SMTP id
 d9-20020a0561020d8900b0037929149cfamr9465559vst.18.1663019190827; Mon, 12 Sep
 2022 14:46:30 -0700 (PDT)
Date:   Mon, 12 Sep 2022 14:46:14 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220912214617.929240-1-nhuck@google.com>
Subject: [PATCH] staging: rtl8723bs: Fix rtw_xmit_entry return type
From:   Nathan Huckleberry <nhuck@google.com>
Cc:     Nathan Huckleberry <nhuck@google.com>,
        Dan Carpenter <error27@gmail.com>, llvm@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ndo_start_xmit field in net_device_ops is expected to be of type
netdev_tx_t (*ndo_start_xmit)(struct sk_buff *skb, struct net_device *dev).

The mismatched return type breaks forward edge kCFI since the underlying
function definition does not match the function hook definition.

The return type of rtw_xmit_entry should be changed from int to
netdev_tx_t.

Reported-by: Dan Carpenter <error27@gmail.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/1703
Cc: llvm@lists.linux.dev
Signed-off-by: Nathan Huckleberry <nhuck@google.com>
---
 drivers/staging/rtl8723bs/os_dep/xmit_linux.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/xmit_linux.c b/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
index 530e7a6c67c5..472d3ac0179b 100644
--- a/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
@@ -181,7 +181,7 @@ static int rtw_mlcst2unicst(struct adapter *padapter, struct sk_buff *skb)
 	return true;
 }
 
-int _rtw_xmit_entry(struct sk_buff *pkt, struct net_device *pnetdev)
+netdev_tx_t _rtw_xmit_entry(struct sk_buff *pkt, struct net_device *pnetdev)
 {
 	struct adapter *padapter = rtw_netdev_priv(pnetdev);
 	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
@@ -217,15 +217,12 @@ int _rtw_xmit_entry(struct sk_buff *pkt, struct net_device *pnetdev)
 	dev_kfree_skb_any(pkt);
 
 exit:
-	return 0;
+	return NETDEV_TX_OK;
 }
 
-int rtw_xmit_entry(struct sk_buff *pkt, struct net_device *pnetdev)
+netdev_tx_t rtw_xmit_entry(struct sk_buff *pkt, struct net_device *pnetdev)
 {
-	int ret = 0;
-
 	if (pkt)
-		ret = _rtw_xmit_entry(pkt, pnetdev);
-
-	return ret;
+		return _rtw_xmit_entry(pkt, pnetdev);
+	return NETDEV_TX_OK;
 }
-- 
2.37.2.789.g6183377224-goog

