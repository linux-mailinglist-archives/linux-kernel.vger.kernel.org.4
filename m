Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91CC9685C3D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 01:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjBAAg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 19:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjBAAgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 19:36:19 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF3420075
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 16:36:16 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id y11so16124419edd.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 16:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diag.uniroma1.it; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J+dsThb91dFX77M1CR1lt9G71sntKRC90bhPpPlMKOY=;
        b=0+L60dAbes1m0TecdIl4cuTTR3ridAucxThO81llXp+ycrJNzvPKhjo1wfmemO19sI
         Z08a4piBrcgTGTQ4ugwJVNoG7KZkPb8o0UvedaH+/4jljzuyAv2KNLYjkeTuBaxys7gQ
         0fQ5jESrMLzLRgtGCgTY5LzM8CptUYg4FdcDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J+dsThb91dFX77M1CR1lt9G71sntKRC90bhPpPlMKOY=;
        b=ousUBKwhk+1CZTNKzYWGUqnhaf/UKzme0PcyKWDIbZMveXNRoDMHpNt5B071vfj/RZ
         X6v+hgyjL7ZYXF6M2HRnGSlP5JCgUoDVplz/UReg7OGwMAuc4g395PwRrNjWrEH+CNFe
         T63ZzjKVYH6+VYmUUtPeQ0WykyJZZuvFSQqT3wPDWf4sfNRY3ilLJg0tZLuyDbSp/Gcv
         fuAfq/rCn2dWie00eknGo1bWGE1udYtLwE9vzMB/j5h0hpQ4yME2NVeAFYGuMY/r490V
         LE5pLPEONM6nycAkwfUG1+cPG/P116LlV/xrIy9I7o+2IXjrhdKH0XdVbBIEpLzO+/DE
         fK1A==
X-Gm-Message-State: AO0yUKVrmpE4Dawozq5e6ZUWe+RMPVl3twLIKsg7MUbmOLMjxFWJuWzq
        KgbGtkKbFVSgJ7v2cVYC4fDGNw==
X-Google-Smtp-Source: AK7set8xjlxJtSQsOclxdIfkCjJQRF+V0EXwD+YJFONT7domzFcLK+qriUY7Q/J1G6uKX1ix0alYtA==
X-Received: by 2002:aa7:da0f:0:b0:463:e2cd:a8b5 with SMTP id r15-20020aa7da0f000000b00463e2cda8b5mr61513eds.11.1675211775381;
        Tue, 31 Jan 2023 16:36:15 -0800 (PST)
Received: from [192.168.17.2] (wolkje-127.labs.vu.nl. [130.37.198.127])
        by smtp.gmail.com with ESMTPSA id x5-20020aa7cd85000000b00497d8613532sm9128306edv.5.2023.01.31.16.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 16:36:14 -0800 (PST)
From:   Pietro Borrello <borrello@diag.uniroma1.it>
Date:   Wed, 01 Feb 2023 00:35:46 +0000
Subject: [PATCH net-next 2/2] tap: tap_open(): correctly initialize socket uid
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230131-tuntap-sk-uid-v1-2-af4f9f40979d@diag.uniroma1.it>
References: <20230131-tuntap-sk-uid-v1-0-af4f9f40979d@diag.uniroma1.it>
In-Reply-To: <20230131-tuntap-sk-uid-v1-0-af4f9f40979d@diag.uniroma1.it>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Lorenzo Colitti <lorenzo@google.com>
Cc:     Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jkl820.git@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pietro Borrello <borrello@diag.uniroma1.it>
X-Mailer: b4 0.11.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1675211773; l=1624;
 i=borrello@diag.uniroma1.it; s=20221223; h=from:subject:message-id;
 bh=Z6sg5PWVn4wi3vauCxGt6FF/2swjbi5B1v2NTOuG/v8=;
 b=DUFeVtHlwYy/q5iLkkFTbwHGTBmFthbNSU6hMaIVpTET8UECYxsWr78owpUfFv5VgRxY6mrq+gXz
 9A7eQimEBmST1q32lbfAbwz0CS3LbpK4upAcxSZ5cR4N1TZmVgYI
X-Developer-Key: i=borrello@diag.uniroma1.it; a=ed25519;
 pk=4xRQbiJKehl7dFvrG33o2HpveMrwQiUPKtIlObzKmdY=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
i.e., the root one.  Fix the assignment by overriding it with the
correct uid.

Fixes: 86741ec25462 ("net: core: Add a UID field to struct sock.")
Signed-off-by: Pietro Borrello <borrello@diag.uniroma1.it>
---
 drivers/net/tap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index a2be1994b389..9a287363d695 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -538,6 +538,10 @@ static int tap_open(struct inode *inode, struct file *file)
 	q->sk.sk_destruct = tap_sock_destruct;
 	q->flags = IFF_VNET_HDR | IFF_NO_PI | IFF_TAP;
 	q->vnet_hdr_sz = sizeof(struct virtio_net_hdr);
+	// sock_init_data initializes sk.sk_uid assuming q->sock is embedded in a
+	// struct socket_alloc and reading its corresponding inode. Since we pass a
+	// socket contained in a struct tap_queue we have to fix this manually
+	q->sk.sk_uid = inode->i_uid;
 
 	/*
 	 * so far only KVM virtio_net uses tap, enable zero copy between

-- 
2.25.1
