Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C7C706839
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 14:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjEQMeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 08:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbjEQMeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 08:34:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8673A3C3B
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 05:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684326797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=8z2vZD/Mt9cHAxNPllMtq5Gn202/y1MZsQVh5pJbJGM=;
        b=ib+M0AL8v9877lvme7UrMuz2yL57uu8VI6R7XiC8iAZxjn6GOAxWJY/R2BYZc69Pvs7jhA
        jOTrRuCpiOl/rvf21NMBL2xy/vUFWHHGWX9EZFa7WVma6B7gYCn7hME0YjrqOEzIWG5rUs
        Scx3GDsOhHg9Q1MbzS7Zw3CAsD6leq4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-YKb3YLolP4yhr5_cYSseyw-1; Wed, 17 May 2023 08:33:16 -0400
X-MC-Unique: YKb3YLolP4yhr5_cYSseyw-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6213569ba95so10570746d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 05:33:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684326795; x=1686918795;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8z2vZD/Mt9cHAxNPllMtq5Gn202/y1MZsQVh5pJbJGM=;
        b=clv7Pgjy/Rir9RviXLz74FPJ9VV/fg5uiK9+fc4mOAON6ygo2XkEi1NtM1WrSv92AR
         hLNKXlsRIRJ3pQayiBk6mATmc0vaqxJqy1htXTmHE4xEEwAlYkpJJaGfVPOhvnIilVBk
         BwQFDsDln/vlbntD8O7RYd2HU/ibjvTVfCUJkds2X8z35EJDezj4O4uaTpApU2inf84O
         n7Z7PT+z5B89H3CbdztaJHJHMMLtGnMd81H0/CJMpaL+wdOHQZz/0S3suKSXOb2sdga5
         2co/ImDsOj6KheGiC5sppeFG1z8ddrdi7V1K3UUEaZOHF6NJzCEAREOYJSJ3gi8RM+vh
         8tWw==
X-Gm-Message-State: AC+VfDw7runbiYMXTiR6M7YDmbutliUjvPdRQjmg4VYAhz/8xBAkdm9q
        pD/CEbxevO7l1f2XSFU8dOIb2J7wvUYfoTWwfT6UxYzGOi6rq9HvL3C2OWU0Oq8yl/IE4uCyFhG
        4kMoOXP5oxet0IRktqIdCFGBRIq2XmqQT
X-Received: by 2002:a05:6214:501b:b0:5ef:45a7:a3c0 with SMTP id jo27-20020a056214501b00b005ef45a7a3c0mr64278010qvb.27.1684326795650;
        Wed, 17 May 2023 05:33:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6lcwZCrP5ym6tgc0dTs+Pyybh7A+czybYSDpfRXvVjBpMBMbt7jNR80EZ4gMhVuD96wNBLdQ==
X-Received: by 2002:a05:6214:501b:b0:5ef:45a7:a3c0 with SMTP id jo27-20020a056214501b00b005ef45a7a3c0mr64277993qvb.27.1684326795438;
        Wed, 17 May 2023 05:33:15 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id j5-20020a37c245000000b007595df328dcsm564251qkm.115.2023.05.17.05.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 05:33:15 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     johannes@sipsolutions.net, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        nathan@kernel.org, ndesaulniers@google.com
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] lib80211: remove unused variables iv32 and iv16
Date:   Wed, 17 May 2023 08:33:10 -0400
Message-Id: <20230517123310.873023-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang with W=1 reports
net/wireless/lib80211_crypt_tkip.c:667:7: error: variable 'iv32'
  set but not used [-Werror,-Wunused-but-set-variable]
                u32 iv32 = tkey->tx_iv32;
                    ^
This variable not used so remove it.
Then remove a similar iv16 variable.
Remove the comment because the length is returned.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 net/wireless/lib80211_crypt_tkip.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/net/wireless/lib80211_crypt_tkip.c b/net/wireless/lib80211_crypt_tkip.c
index 1b4d6c87a5c5..9b411b6a7b5d 100644
--- a/net/wireless/lib80211_crypt_tkip.c
+++ b/net/wireless/lib80211_crypt_tkip.c
@@ -662,12 +662,6 @@ static int lib80211_tkip_get_key(void *key, int len, u8 * seq, void *priv)
 	memcpy(key, tkey->key, TKIP_KEY_LEN);
 
 	if (seq) {
-		/* Return the sequence number of the last transmitted frame. */
-		u16 iv16 = tkey->tx_iv16;
-		u32 iv32 = tkey->tx_iv32;
-		if (iv16 == 0)
-			iv32--;
-		iv16--;
 		seq[0] = tkey->tx_iv16;
 		seq[1] = tkey->tx_iv16 >> 8;
 		seq[2] = tkey->tx_iv32;
-- 
2.27.0

