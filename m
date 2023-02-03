Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C81E689BA9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 15:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbjBCObO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 09:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbjBCObI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 09:31:08 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD0E918AE
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 06:30:40 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id dr8so15743428ejc.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 06:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diag.uniroma1.it; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c9/yht3OikKL+fz1dMURrWxLRY+qgX5Gigwcf5rk3MM=;
        b=RSzcTFAAUWSKVCbhm8aZ0/uk1Jne0xWrH+JQ8jOmB+TP/DIprOMhhF/Zo03aEbVcpP
         I6T4csW/JMHpJDsUwKojS3xnVWMKSCW6fU7oFnubirnZZsH8SqtqVE0TDi3+vja4l+Ck
         NV4MrMla7pc2KhVdWqLhOmgZTFjCKhrlc0w1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c9/yht3OikKL+fz1dMURrWxLRY+qgX5Gigwcf5rk3MM=;
        b=FtLtl/UH+s4r+Uoccl1kvzL62gCMEHXRieBcfLX9p9FFCkgFE3dfuycXgnKsJy+TV2
         EgTFbA+9EEnx6MaaFb6VGQHbzeap6hNUI3jSmpjX6cCxH9wJBCER+JXtgfMYA4hMHvCP
         OWrOPyzd/5l6AUcG9HYkvlAVDSQoVy2o5LzdM/NzZCQVW7aFdUb15RhTDo6VNU94jlK/
         DsQr3gLQ4+6Pi/yBiPS1pZB/jFy/iSFXYU4PoQ7EUSxP49zCb5nd0cIWzPA3jxLuJHnS
         kKWu0QmHcenleBn4gi8F35LNSx2eWGJHglUYRFbuYALjAn7ltZv671t0zsPrLut+eAEt
         3Szw==
X-Gm-Message-State: AO0yUKUQezHtPPpz1R3Zjav5Z20HRPsyjPGkuO1Z5C4unX21uJoxA8eW
        2NMWdEj9W0DK1VHcQRv6xYplEA==
X-Google-Smtp-Source: AK7set8ba+Vi2s4AY/qUznnRC8VJHFm0w/qrf0RebmRyMi2DqzCuyvrTWS740lc/oYEorvTKZ6bV9A==
X-Received: by 2002:a17:907:7ba9:b0:87b:d3dd:e0ca with SMTP id ne41-20020a1709077ba900b0087bd3dde0camr2412927ejc.26.1675434638615;
        Fri, 03 Feb 2023 06:30:38 -0800 (PST)
Received: from [192.168.17.2] (wolkje-127.labs.vu.nl. [130.37.198.127])
        by smtp.gmail.com with ESMTPSA id v17-20020a17090690d100b007b935641971sm1453388ejw.5.2023.02.03.06.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 06:30:38 -0800 (PST)
From:   Pietro Borrello <borrello@diag.uniroma1.it>
Date:   Fri, 03 Feb 2023 14:30:27 +0000
Subject: [PATCH net-next v2 1/2] tun: tun_chr_open(): correctly initialize
 socket uid
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230131-tuntap-sk-uid-v2-1-29ec15592813@diag.uniroma1.it>
References: <20230131-tuntap-sk-uid-v2-0-29ec15592813@diag.uniroma1.it>
In-Reply-To: <20230131-tuntap-sk-uid-v2-0-29ec15592813@diag.uniroma1.it>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1675434637; l=1470;
 i=borrello@diag.uniroma1.it; s=20221223; h=from:subject:message-id;
 bh=mzUofY832mKWZjsqrcRqLrj8musIg93nc9mNqQ6CM78=;
 b=oO8acvtlD+JwPhpXLLgyitydHBUuzKiSzYVlovE15LZ4Xi/Agl+38mQ3hPqse1tQW1DWHT0ENbtn
 EqmTSgafARmbBpjOAZgbumnEaq4vdOspvJyOXE6z5dCv1olk9zJF
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
However, tun_chr_open() passes a `struct socket` embedded in a `struct
tun_file` allocated with sk_alloc().
This causes a type confusion when issuing a container_of() with
SOCK_INODE() in sock_init_data() which results in assigning a wrong
sk_uid to the `struct sock` in input.
On default configuration, the type confused field overlaps with the
high 4 bytes of `struct tun_struct __rcu *tun` of `struct tun_file`,
NULL at the time of call, which makes the uid of all tun sockets 0,
i.e., the root one.  Fix the assignment by overriding it with the
correct uid.

Fixes: 86741ec25462 ("net: core: Add a UID field to struct sock.")
Signed-off-by: Pietro Borrello <borrello@diag.uniroma1.it>
---
 drivers/net/tun.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index a7d17c680f4a..ccffbc439c95 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -3450,6 +3450,11 @@ static int tun_chr_open(struct inode *inode, struct file * file)
 
 	sock_init_data(&tfile->socket, &tfile->sk);
 
+	/* Assign sk_uid from the inode argument, since tfile->socket
+	 * passed to sock_init_data() has no corresponding inode
+	 */
+	tfile->sk.sk_uid = inode->i_uid;
+
 	tfile->sk.sk_write_space = tun_sock_write_space;
 	tfile->sk.sk_sndbuf = INT_MAX;
 

-- 
2.25.1

