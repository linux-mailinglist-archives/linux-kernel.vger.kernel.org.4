Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1264A5B7B5A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 21:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiIMTgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 15:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiIMTfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 15:35:51 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8606E2F65C
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 12:34:13 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-348608c1cd3so111823187b3.10
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 12:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=ZrnfMcG0b0qdMa/HG9lWVFWiMRD2rFKVvj8aOqoB5NA=;
        b=jl+otp4drEgbzDYTQOVQCe/lGQ641MtaMVO7qinvKC5Z/Z0dR7bW2ruruvElf91Mza
         rWIG6jxnLFpbzjxYmb5hdLxpqCph4WGtedV0jYKug9pvcFi9GKMNHWYQ3MhV7Z1j88yk
         C6zM9+8uEYYRmMjCgT2yhu2soVB4o4GEEhV6Odeyn040LBTrLoxj9PC9Bi0MW8tbwkYI
         korKEqKCSvt1O5ysUgMORQ32kUTSRx8d6O3P6JSNr0CgxHOGMjDy+FKt3dd0tgXbyMJQ
         fFYaGkhOwh3jf1mzUPxBWJrYHZfFC32tZr/0bRlCZwAl2Snl3C6f92W1eOGwTq3xkwJJ
         cGAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=ZrnfMcG0b0qdMa/HG9lWVFWiMRD2rFKVvj8aOqoB5NA=;
        b=H9/cSWjqnGmeG3SnRbLcS3nj8yTbKXrovbYd90LHnYtShA+Gwp9zLddl1HPpcvddHi
         DGP/8Y0AhpxUoNJtyZZwKBjhyhduokpcjHrq451Ym+6r8TK47eR8NSDphq42TX+DysjV
         Zc4T5tdaM4tBJATDyHtDAlVRfLAfMAwZruNHYusOf1/tZDVIjPkqOSVj1dL9T9Kbwnhp
         IWdmEJ8J2D0ajHofEy7bKJ0UJUdpeAHYYioMKBB+PsbtWT7K6x4MnSHzxPa7oFIpXZAR
         D8Rifl/tDR4iIH7g3oDy23EGmzRBNNQ3oewuqo13xbYbZ+z9yAkvs+udl7CXYgLZhRzi
         A4lQ==
X-Gm-Message-State: ACgBeo2yllz4I4fHoSA9mp8nXHHgTCHqYiozqhHnqJarnZU6AH0NQWi5
        vazcrMguPkqOhDbJgSGqaCSngXAKHw==
X-Google-Smtp-Source: AA6agR4LglXqDawoel4yrWBMkm6qEgbPHBpN7FxtOlMNyNGMQNx6OftnLwFFbJ4OUngWXoBIeukihYgGyg==
X-Received: from nhuck.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:39cc])
 (user=nhuck job=sendgmr) by 2002:a05:6902:124d:b0:66d:5ce6:5924 with SMTP id
 t13-20020a056902124d00b0066d5ce65924mr28556708ybu.320.1663097652806; Tue, 13
 Sep 2022 12:34:12 -0700 (PDT)
Date:   Tue, 13 Sep 2022 12:33:22 -0700
In-Reply-To: <CA+sZ8B8RStBhofQ0=vvzH5FeQ66fj90DdCj9EQSaVErbVPLi7g@mail.gmail.com>
Mime-Version: 1.0
References: <CA+sZ8B8RStBhofQ0=vvzH5FeQ66fj90DdCj9EQSaVErbVPLi7g@mail.gmail.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220913193322.18776-1-nhuck@google.com>
Subject: [PATCH v2] staging: r8188eu: Fix return type of rtw_xmit_entry
From:   Nathan Huckleberry <nhuck@google.com>
To:     namcaov@gmail.com
Cc:     Larry.Finger@lwfinger.net, error27@gmail.com,
        gregkh@linuxfoundation.org, insafonov@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        llvm@lists.linux.dev, makvihas@gmail.com, nathan@kernel.org,
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

Changes v1 -> v2:
 - Rebased onto linux-next/master

---
 drivers/staging/r8188eu/core/rtw_xmit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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
-- 
2.37.2.789.g6183377224-goog

