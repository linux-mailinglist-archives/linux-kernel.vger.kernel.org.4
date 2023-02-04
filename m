Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F9C68ABB0
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 18:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbjBDRjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 12:39:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbjBDRjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 12:39:39 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBBC23647
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 09:39:37 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id mc11so23472552ejb.10
        for <linux-kernel@vger.kernel.org>; Sat, 04 Feb 2023 09:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diag.uniroma1.it; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=diRmWeCrr8oLC0zFkxgOTHjfxqbtb56o/4Jn3DMGHrU=;
        b=a/oiPRLN2voU6osfRxYBgHzhPMEkohEGki/USRxp8t65Yx8iQunogBOKJfJQvdxcvX
         4LSUiSE3KbLXZOBx4XsltL9BfdRBITtOuDL8yQxBVJ/LeBZG9BiIjRf8fS0NoerD+6l9
         Bn7/3OzE6+3a38BGMraO6zsEJnPFY/eB8TQqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=diRmWeCrr8oLC0zFkxgOTHjfxqbtb56o/4Jn3DMGHrU=;
        b=CgYcbe1HZ+7SnZfVsnJZfB8x93Q7lGxDLgMg1xwosvoOr+18DJu6G3LIc3cA5xLq1G
         aNk7FPR1+JEFFYkx/YWNdDzxMdcU6BcdrvhdRp/eoWp8ogdk2TwoSgpBWrZ0VdFR1UaL
         KvEb7l4xNRYDNWj9+dANARy5DRQVId1WLsBlsGTf6T1o1AuHgcUeDj+2MMBNHcK9uwpm
         h4qSCO0FcDwWryPmHmiMf3Z9zrcK6zL/1Yljl3xB0DcWsyDRNc0SwJshFVy9Q9x3FoUn
         3XIU+rjg7BMlHYfJ3gq5bD7xCmJTOHTRk7ZUCkTxMtzkDvamufASokgkGQm3CNb3OUfP
         Oseg==
X-Gm-Message-State: AO0yUKUDekQGo7OOiIffPcg1IMnoEtv5AEP9rXj+spMPL3mIm9KQ2cZ/
        q+umISiAz46gxi1JMjIC/pej3A==
X-Google-Smtp-Source: AK7set+O/fypeP/fHfMs6yS/2lN4ie/RPoXjNSSoCtm/01r+LWVzIvvCDwRptB5+M90D3SqnVRlcZg==
X-Received: by 2002:a17:906:c7cf:b0:88f:9445:f8df with SMTP id dc15-20020a170906c7cf00b0088f9445f8dfmr5823499ejb.21.1675532375619;
        Sat, 04 Feb 2023 09:39:35 -0800 (PST)
Received: from [192.168.17.2] (wolkje-127.labs.vu.nl. [130.37.198.127])
        by smtp.gmail.com with ESMTPSA id ot1-20020a170906ccc100b008897858bb06sm3039321ejb.119.2023.02.04.09.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Feb 2023 09:39:35 -0800 (PST)
From:   Pietro Borrello <borrello@diag.uniroma1.it>
Date:   Sat, 04 Feb 2023 17:39:22 +0000
Subject: [PATCH net-next v3 3/3] tap: tap_open(): correctly initialize
 socket uid
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230131-tuntap-sk-uid-v3-3-81188b909685@diag.uniroma1.it>
References: <20230131-tuntap-sk-uid-v3-0-81188b909685@diag.uniroma1.it>
In-Reply-To: <20230131-tuntap-sk-uid-v3-0-81188b909685@diag.uniroma1.it>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Lorenzo Colitti <lorenzo@google.com>
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jkl820.git@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pietro Borrello <borrello@diag.uniroma1.it>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1675532373; l=1467;
 i=borrello@diag.uniroma1.it; s=20221223; h=from:subject:message-id;
 bh=BevjpYXm4mBtNUkCZd9Z2Jro8meWCGFZ1iKL7fvrTDc=;
 b=0Dov0FXUUGwtocqIsuWBgoTVbYiz2+QJmrgCqWd22jBqxy1dSg6L4OFlnsrpIWHw+eSz0cT54C+q
 Fc0HpllIB+NfovpFMTaTbzjUNzlMI1SrbdYojgGuvi7RNeDA/AN0
X-Developer-Key: i=borrello@diag.uniroma1.it; a=ed25519;
 pk=4xRQbiJKehl7dFvrG33o2HpveMrwQiUPKtIlObzKmdY=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sock_init_data() assumes that the `struct socket` passed in input is
contained in a `struct socket_alloc` allocated with sock_alloc().
However, tap_open() passes a `struct socket` embedded in a `struct
tap_queue` allocated with sk_alloc().
This causes a type confusion when issuing a container_of() with
SOCK_INODE() in sock_init_data() which results in assigning a wrong
sk_uid to the `struct sock` in input.
On default configuration, the type confused field overlaps with
padding bytes between `int vnet_hdr_sz` and `struct tap_dev __rcu
*tap` in `struct tap_queue`, which makes the uid of all tap sockets 0,
i.e., the root one.
Fix the assignment by using sock_init_data_uid().

Fixes: 86741ec25462 ("net: core: Add a UID field to struct sock.")
Signed-off-by: Pietro Borrello <borrello@diag.uniroma1.it>
---
 drivers/net/tap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index a2be1994b389..8941aa199ea3 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -533,7 +533,7 @@ static int tap_open(struct inode *inode, struct file *file)
 	q->sock.state = SS_CONNECTED;
 	q->sock.file = file;
 	q->sock.ops = &tap_socket_ops;
-	sock_init_data(&q->sock, &q->sk);
+	sock_init_data_uid(&q->sock, &q->sk, inode->i_uid);
 	q->sk.sk_write_space = tap_sock_write_space;
 	q->sk.sk_destruct = tap_sock_destruct;
 	q->flags = IFF_VNET_HDR | IFF_NO_PI | IFF_TAP;

-- 
2.25.1

