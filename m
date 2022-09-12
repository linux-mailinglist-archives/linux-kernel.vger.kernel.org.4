Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02995B62FD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 23:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbiILVqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 17:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiILVqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 17:46:15 -0400
Received: from mail-vs1-xe49.google.com (mail-vs1-xe49.google.com [IPv6:2607:f8b0:4864:20::e49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCD14D24B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 14:46:10 -0700 (PDT)
Received: by mail-vs1-xe49.google.com with SMTP id c129-20020a671c87000000b0038ae002e7a6so979710vsc.14
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 14:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=MLnObt6zyGNlUZeZEFTlRwd6ME4C5crSaLu9fRVEkDk=;
        b=GijQYHGGKwWbSF23cH9ICaVQFmj05rI1nUVD/vvAx3qrpszfnliUJK7YyB08pOymye
         gZDtQa+BwsrYcuM+aLvqJcs3ZOWEdbsHfyTD353Zl0vIaMkZXxcwo26iJuNzV8uGhtej
         ccke7EreWF7PQiGsN44hoJRscVySyu6513ywj3HbPlZUtKWW39CSJgdjSYNRtUaln4Sd
         FD4jEUB11cGgjIDcfLHO3ch5Bu8BTw8JOepyrnk2D4r4N6Sp5Ysrb1ocp3fopx8LofQ0
         Z5xz1Xhfg25SR9/vkyYbMc2/NwwfYpEg52xlbfkolcTkZXD3hVNY+aVupqtvunA96OsR
         yWKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=MLnObt6zyGNlUZeZEFTlRwd6ME4C5crSaLu9fRVEkDk=;
        b=KBMTwImJMLu36CAK2DKkTlwLkvt7llzAixLO1yw/3VPSRarGLMaYmxv/iC2QKzh+wj
         mlecLdU6vZEDxe8tygGno8MPdEAWCUCy28qfZwAvhjNEPWD9p0wiyURTYtlkPY35w8se
         +xxY2PCbEIqPxC6vu4h8urGDWMk+pjiiFFi1SpK8GcWPpvGq6B3ADKC+I20Ma/A+CrLe
         gYUIX4cv2JG4C46oWpwEo+uoOuvgDJ717JkqK/Kr2muzo3cVhjFMzFY0n5YCXIM2D0cx
         G0NDCnDEJJTS+UhORvdV1g7E458jPyS65kYLyNHQPfOMqvCkQaokjxZd5IYVLrq2zLCx
         ezng==
X-Gm-Message-State: ACgBeo2npYOk0K8Albp9YLFdH9ZmtJtzeanIT38HQ+jOlAkJMnBDQvQC
        7BzU4uDXbVRxs7t2gSitZlmXLHvYUg==
X-Google-Smtp-Source: AA6agR5jsRUdlZ+bhJTNzFf9ZUErRQqlTOo1r7FaxXI7zoJ+qBN5MY8HjpaN4/oVyi/sNldrnOcuxSPJvw==
X-Received: from nhuck.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:39cc])
 (user=nhuck job=sendgmr) by 2002:a67:ad15:0:b0:398:6aef:316b with SMTP id
 t21-20020a67ad15000000b003986aef316bmr4372894vsl.17.1663019169572; Mon, 12
 Sep 2022 14:46:09 -0700 (PDT)
Date:   Mon, 12 Sep 2022 14:46:03 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220912214607.929211-1-nhuck@google.com>
Subject: [PATCH] staging: rtl8712: Fix return type of r8712_xmit_entry
From:   Nathan Huckleberry <nhuck@google.com>
Cc:     Nathan Huckleberry <nhuck@google.com>,
        Dan Carpenter <error27@gmail.com>, llvm@lists.linux.dev,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Sathish Kumar <skumark1902@gmail.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
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

The return type of r8712_xmit_entry should be changed from int to
netdev_tx_t.

Reported-by: Dan Carpenter <error27@gmail.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/1703
Cc: llvm@lists.linux.dev
Signed-off-by: Nathan Huckleberry <nhuck@google.com>
---
 drivers/staging/rtl8712/xmit_linux.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8712/xmit_linux.c b/drivers/staging/rtl8712/xmit_linux.c
index 4a93839bf947..e84b9fa231cd 100644
--- a/drivers/staging/rtl8712/xmit_linux.c
+++ b/drivers/staging/rtl8712/xmit_linux.c
@@ -140,7 +140,7 @@ void r8712_xmit_complete(struct _adapter *padapter, struct xmit_frame *pxframe)
 	pxframe->pkt = NULL;
 }
 
-int r8712_xmit_entry(_pkt *pkt, struct  net_device *netdev)
+netdev_tx_t r8712_xmit_entry(_pkt *pkt, struct  net_device *netdev)
 {
 	struct xmit_frame *xmitframe = NULL;
 	struct _adapter *adapter = netdev_priv(netdev);
@@ -165,11 +165,11 @@ int r8712_xmit_entry(_pkt *pkt, struct  net_device *netdev)
 	}
 	xmitpriv->tx_pkts++;
 	xmitpriv->tx_bytes += xmitframe->attrib.last_txcmdsz;
-	return 0;
+	return NETDEV_TX_OK;
 _xmit_entry_drop:
 	if (xmitframe)
 		r8712_free_xmitframe(xmitpriv, xmitframe);
 	xmitpriv->tx_drop++;
 	dev_kfree_skb_any(pkt);
-	return 0;
+	return NETDEV_TX_OK;
 }
-- 
2.37.2.789.g6183377224-goog

