Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1DFA7461C8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 20:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjGCSIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 14:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbjGCSI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 14:08:28 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B929EE6B
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 11:08:27 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-666eba6f3d6so2234859b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 11:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688407707; x=1690999707;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3auGkEfHhpz3BrAdAF5f41VUjnbVwTpR8M5csxbDscI=;
        b=ZwP4nUR3WFNFmNuz2S9cZpy4kVhWdJRsayBoNlmnBRgP37jBLoGHam82DMmysAeGOQ
         k0oA2997jN0LqeFMiRZh5uwApco9D76BxHdR20QQjbWcjv7/X2UIge7fe/qM6o+0Ra3W
         wxVb5kWJd/pTpjL6Lie8eJ+Xo+u9MmSUUoLXXddYLjs2A9HSn51vZ3Tx0sIRlibTXQ3c
         851sIYyF3bhRvFpxVGU9GGbEKMXDbTC/pjFkGEjTMxWRlRlq6OBR+nVt+lC8WRYFdXGy
         LACACf8tg6xgXL7dBKkO642tA6yYZLoZBP0BxJ5w2XpGnyb1SeXnHWQh34pY7svq9xiV
         Zs9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688407707; x=1690999707;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3auGkEfHhpz3BrAdAF5f41VUjnbVwTpR8M5csxbDscI=;
        b=XKGjH619NdLebhotOJhsUQf8tsGbZD3/tXoFxBjLH3TRKtl9HBMuwt1xImW6NS9Bav
         sLJXDTv5+atgluO5hD8FKZpdmgJs1iiyswyW0tbPspyQvaKXdAUGNYi+WuFrfIB3kOQX
         Q1ewXKFZ1CFlYnkMnwJGYOhBJ0ZkRzuslOOT2hkDMxNw648HO1zJ2LYJ9uurwoc4u2Qj
         yKU/wMAnQ2y39t6Fmr7fr/OwCJFaoY5M7SwZatIv4jLDWYkasa4wTVqJJrE7p7arVvnJ
         EwPQk0pjij9ONxyUpdc46wKBLf3SYoOPhIfvB1zrky7RZt41C1UcStT4a2vc+kJr2S8C
         81Wg==
X-Gm-Message-State: ABy/qLZLxg9OVnawtRZ9prHvfC7gG2W3zRbqWAgogUfgBmZlCzjMbC8h
        mUJcjRCDQqTsLTY4Yn3FQomOVlMZ8Hk=
X-Google-Smtp-Source: APBJJlHKnFg5uQOqwjz14u73pV5nhgUG/mWtlPbgMR70wQTDnFDLs+sdeZ9z5DvSrbgZSaGdyyKF4g==
X-Received: by 2002:a62:7b0e:0:b0:682:3126:961a with SMTP id w14-20020a627b0e000000b006823126961amr9464622pfc.5.1688407706528;
        Mon, 03 Jul 2023 11:08:26 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:646:a201:19d0:feb2:139d:d966:84b8])
        by smtp.gmail.com with ESMTPSA id n13-20020aa7904d000000b0063a04905379sm14337172pfo.137.2023.07.03.11.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 11:08:25 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] xtensa: ISS: fix call to split_if_spec
Date:   Mon,  3 Jul 2023 11:08:22 -0700
Message-Id: <20230703180822.1346356-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

split_if_spec expects a NULL-pointer as an end marker for the argument
list, but tuntap_probe never supplied that terminating NULL. As a result
incorrectly formatted interface specification string may cause a crash
because for the random memory access. Fix that by adding NULL terminator
to the split_if_spec argument list.

Fixes: 7282bee78798 ("[PATCH] xtensa: Architecture support for Tensilica Xtensa Part 8")
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/platforms/iss/network.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/xtensa/platforms/iss/network.c b/arch/xtensa/platforms/iss/network.c
index 7b97e6ab85a4..85c82cd42188 100644
--- a/arch/xtensa/platforms/iss/network.c
+++ b/arch/xtensa/platforms/iss/network.c
@@ -237,7 +237,7 @@ static int tuntap_probe(struct iss_net_private *lp, int index, char *init)
 
 	init += sizeof(TRANSPORT_TUNTAP_NAME) - 1;
 	if (*init == ',') {
-		rem = split_if_spec(init + 1, &mac_str, &dev_name);
+		rem = split_if_spec(init + 1, &mac_str, &dev_name, NULL);
 		if (rem != NULL) {
 			pr_err("%s: extra garbage on specification : '%s'\n",
 			       dev->name, rem);
-- 
2.30.2

