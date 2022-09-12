Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C279E5B62F8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 23:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbiILVqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 17:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiILVpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 17:45:44 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8E04D25F
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 14:45:43 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id d82-20020a25e655000000b006a8fc4506c0so8382573ybh.18
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 14:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=+OAWo6obQA5uOmNqmxhrbmYCLRgr4K4PfskcsDIp7Sk=;
        b=FX70JtZctz087sDCP5WjmRQG8blEx7SV2OF/xqXqlxZ8xRvnNeAnSI5jvtTv6NxsSA
         vtE95GbpjKQHMakctvkQ/SqVsGI5fpepp3Y2QWcI8yCwmS5kd7Zk/Qj40rVhfhxKkRLw
         SZqA4duhEDWn6aNoRzzJ50Cx9TiIjd2sHKRx/8W7a7sVC6hBwehwQQibCwmuDO0XtN2A
         JPo+q8qwlkb74eyW82VZosMZ+lcWeiFnjEkyxEa9bwUzxzKijwyIFdggnkYByg9FI8hF
         9EdHBX/rOMwuJ0LHTPl5hCimKfAjjhT+fglGRi2z1JqHn0yJ8uvGGjdgzBgWdcCh/9k3
         2yVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=+OAWo6obQA5uOmNqmxhrbmYCLRgr4K4PfskcsDIp7Sk=;
        b=vVRIxYVqBWuD+N3eP5QXdnA9LEPBFad8Jhj537tzgGNt3Z38bLepvDzV4X/TTu7ozW
         /pnMSsPqg4q7gh/dqEJT76ElTSdnKNjVcsdsxOwQIGAKMzIdMOW4N1spTuVzxOegENze
         e8e6HfTg+hjcHMdyH+kzKQWqqN9iIkPmptt0Cx4AKa1N5eJzmBUuD9yU8HpVeH3vXsAP
         l73Jxc+lTLxehDq465xur7C4LsDksv38gP35rUwHg+LXsT+APKSElFKoN9iHQ3AXlB+p
         J1+snN12M/4sU1SlRTJuTgGxkeDcVg21ZSJ34VIDU/h2wHMipWf9dMNiqMxsx57qL2yK
         b21Q==
X-Gm-Message-State: ACgBeo3aJ+tv+JIN6LpJbMM/m7sX+g6TlCQLKa9GZoBJzjJZEorjZOAc
        CDxi58RohPEfBSp36enn86hbGBAt6Q==
X-Google-Smtp-Source: AA6agR4i1CEBghsid1Cfen84EGO8TUwI5lM4bZGhTEE5HnlAqt4yRYaPg+UVJjqLn9wyY4D6qL1/DESC1w==
X-Received: from nhuck.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:39cc])
 (user=nhuck job=sendgmr) by 2002:a25:230d:0:b0:6a9:1d4d:6594 with SMTP id
 j13-20020a25230d000000b006a91d4d6594mr24540953ybj.616.1663019142446; Mon, 12
 Sep 2022 14:45:42 -0700 (PDT)
Date:   Mon, 12 Sep 2022 14:45:32 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220912214535.929116-1-nhuck@google.com>
Subject: [PATCH] staging: r8188eu: Fix return type of rtw_xmit_entry
From:   Nathan Huckleberry <nhuck@google.com>
Cc:     Nathan Huckleberry <nhuck@google.com>,
        Dan Carpenter <error27@gmail.com>, llvm@lists.linux.dev,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Ivan Safonov <insafonov@gmail.com>,
        Nam Cao <namcaov@gmail.com>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        Vihas Makwana <makvihas@gmail.com>,
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

The return type of rtw_xmit_entry should be changed from int to
netdev_tx_t.

Reported-by: Dan Carpenter <error27@gmail.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/1703
Cc: llvm@lists.linux.dev
Signed-off-by: Nathan Huckleberry <nhuck@google.com>
---
 drivers/staging/r8188eu/os_dep/xmit_linux.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/xmit_linux.c b/drivers/staging/r8188eu/os_dep/xmit_linux.c
index 91a1e4e3219a..0b04010d6d82 100644
--- a/drivers/staging/r8188eu/os_dep/xmit_linux.c
+++ b/drivers/staging/r8188eu/os_dep/xmit_linux.c
@@ -198,7 +198,7 @@ static int rtw_mlcst2unicst(struct adapter *padapter, struct sk_buff *skb)
 	return true;
 }
 
-int rtw_xmit_entry(struct sk_buff *pkt, struct  net_device *pnetdev)
+netdev_tx_t rtw_xmit_entry(struct sk_buff *pkt, struct  net_device *pnetdev)
 {
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(pnetdev);
 	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
@@ -233,5 +233,5 @@ int rtw_xmit_entry(struct sk_buff *pkt, struct  net_device *pnetdev)
 
 exit:
 
-	return 0;
+	return NETDEV_TX_OK;
 }
-- 
2.37.2.789.g6183377224-goog

