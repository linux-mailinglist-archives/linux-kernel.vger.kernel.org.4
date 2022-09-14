Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087C15B8FFA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 23:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbiINVQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 17:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiINVQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 17:16:23 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C91086B45
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 14:16:12 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id x5-20020a056902102500b006af1376b813so9275085ybt.16
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 14:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=1qTbf9AeneJ+E0vsQj505sbaD/8VFWq9P44uV39tt6g=;
        b=NaoShQX0xB6ZSD3s/l2l8lUJHV8OlhoUIRJXBx9XMzxO4ISYASBDDL+6bgaKRwxwGa
         f0dKG1vN81GPaYIKzGTRwdvFnlg5Km7/n4zRahhCho5X3top90R1dU5MZW6Un6ipWHM6
         yPTWv97B07QcOxRYuD26rtbqzGKOGjOpUYchjTCoQOY5zRGGVYsC0ElnKF9W+Y//wTda
         eJcrs9jpvWVgK0EoHh0DjjUFjav87D7emCFvhb/qMorPp5CYB2HG4saqeQGxIAGjoqaj
         wacEa68UMGcSfzwqlpDYx1CAE7j3D3HnwVqG9s0wfTS2LsqvzXjeaPZntWOJ6cKkg6cM
         4MpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=1qTbf9AeneJ+E0vsQj505sbaD/8VFWq9P44uV39tt6g=;
        b=KhN5FfRRwWPf87fsuB3nAEq6HAo0kbJA6mOW47A2jDn5P0HPR2Fi8MjmxOav2DrUoF
         mVxzM6VhKig8v948pnh6pcgF4PFS2AtOz45pYd5rzAfTsHeqv2A04qelJw5RRfNt7sNn
         6ZuQc7ncM4tgx+X94Z4ardn2xKtKMf0pFm3mWogw9bxlTxFIN0RdGRr/97a+RyxOg717
         lmqly0alDntJ0dEfgj/AUfDqGrdQC9VBot4QOIzgqTRO3hcqIo+F7ENPe5N+0ZWikS84
         xkaWKcU+O954HZPIdZwV2aP2AJ+Or7PHXgSlpafCkNX4OupK5N/h+eyweNGAep+fM291
         Ou+A==
X-Gm-Message-State: ACgBeo0DENRjfiiReFZSpqPHdbkdif20l8h/O06J9jv3v0xbhz3xgPko
        zIfEC/Kp1SCDWJLiR92aUOS3VKZ5lg==
X-Google-Smtp-Source: AA6agR5pVF5gnh786/PeSQ3ck24+Vs242wAhkbehmJZ5cq2FVthE4UT/MDUK6JyMV4YbdAVQHFSUIj6UHA==
X-Received: from nhuck.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:39cc])
 (user=nhuck job=sendgmr) by 2002:a05:6902:150d:b0:6ad:2399:eaa7 with SMTP id
 q13-20020a056902150d00b006ad2399eaa7mr32621218ybu.413.1663190171406; Wed, 14
 Sep 2022 14:16:11 -0700 (PDT)
Date:   Wed, 14 Sep 2022 14:16:06 -0700
In-Reply-To: <YyEPaMVRmdGQdoql@dev-arch.thelio-3990X>
Mime-Version: 1.0
References: <YyEPaMVRmdGQdoql@dev-arch.thelio-3990X>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220914211606.423959-1-nhuck@google.com>
Subject: [PATCH v3] staging: r8188eu: Fix return type of rtw_xmit_entry
From:   Nathan Huckleberry <nhuck@google.com>
To:     nathan@kernel.org
Cc:     Larry.Finger@lwfinger.net, error27@gmail.com,
        gregkh@linuxfoundation.org, insafonov@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        llvm@lists.linux.dev, makvihas@gmail.com, namcaov@gmail.com,
        ndesaulniers@google.com, nhuck@google.com, paskripkin@gmail.com,
        phil@philpotter.co.uk, saurav.girepunje@gmail.com, trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
---

Changes v1 -> v2:
- Rebased onto linux-next/master

Changes v2 -> v3:
- Updated header file
- Add reviewed-by tag

 drivers/staging/r8188eu/core/rtw_xmit.c    | 4 ++--
 drivers/staging/r8188eu/include/rtw_xmit.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 98864fc55b25..ea13f11b231b 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -2289,7 +2289,7 @@ static int rtw_mlcst2unicst(struct adapter *padapter, struct sk_buff *skb)
 	return true;
 }
 
-int rtw_xmit_entry(struct sk_buff *pkt, struct net_device *pnetdev)
+netdev_tx_t rtw_xmit_entry(struct sk_buff *pkt, struct net_device *pnetdev)
 {
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(pnetdev);
 	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
@@ -2323,5 +2323,5 @@ int rtw_xmit_entry(struct sk_buff *pkt, struct net_device *pnetdev)
 	dev_kfree_skb_any(pkt);
 
 exit:
-	return 0;
+	return NETDEV_TX_OK;
 }
diff --git a/drivers/staging/r8188eu/include/rtw_xmit.h b/drivers/staging/r8188eu/include/rtw_xmit.h
index 8f54c41ba927..82efcd54af3f 100644
--- a/drivers/staging/r8188eu/include/rtw_xmit.h
+++ b/drivers/staging/r8188eu/include/rtw_xmit.h
@@ -368,6 +368,6 @@ int rtw_ack_tx_wait(struct xmit_priv *pxmitpriv, u32 timeout_ms);
 void rtw_ack_tx_done(struct xmit_priv *pxmitpriv, int status);
 
 void rtw_xmit_complete(struct adapter *padapter, struct xmit_frame *pxframe);
-int rtw_xmit_entry(struct sk_buff *pkt, struct net_device *pnetdev);
+netdev_tx_t rtw_xmit_entry(struct sk_buff *pkt, struct net_device *pnetdev);
 
 #endif	/* _RTL871X_XMIT_H_ */
-- 
2.37.2.789.g6183377224-goog

