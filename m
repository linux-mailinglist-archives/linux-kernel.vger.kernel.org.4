Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE316D4B09
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 16:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbjDCOv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 10:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234039AbjDCOvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 10:51:41 -0400
Received: from mail-ed1-x561.google.com (mail-ed1-x561.google.com [IPv6:2a00:1450:4864:20::561])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F76280ED
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 07:51:16 -0700 (PDT)
Received: by mail-ed1-x561.google.com with SMTP id ek18so118449551edb.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 07:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dectris.com; s=google; t=1680533475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4tucP9Q9FV6sU4BIjvtlK70WE+DVbPqhpqoYAULqHo=;
        b=r/AnxgwAwhh6VSompA7dNMcL9KWtj50wbiPuXbtOjokBZ2Y5sDUl5xoJK3IYoS77cT
         lTzfHriP/I88KuWP5Bb4WZqjD6ZsEklN8hnvGtd2aexn1VVZYA+UY1v9DWe4dNmgqP3v
         hE/Quhn12joCCaYenzEN8eh6fz3BoAPAmD5kU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680533475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w4tucP9Q9FV6sU4BIjvtlK70WE+DVbPqhpqoYAULqHo=;
        b=FECU8oFQFLY86S/fvzF7trSnGx6as+x2VUyjTIDVQW5RbU6KmAca20UCKEGjAvZLdh
         lcqNGOPq4nRBTVk1Rj3L3aWgMPfO9SEIL17g6oc5j2cWxDrPyUKQRIySi3jfHnjgNgzM
         ESBMWatd4ApkkUHAPmXmANTJQ39nUEQHjZeLpCdi1BPZhXvPZPlebg0piyT7xCmtNJwx
         UF5ly3zRjMmNpFCqcGmvTgZyiGQ+UsTdPjbllrqMOJ6dq44Gw33nzyeEDdc6aA4VJkTa
         5YsBPVNF2LH7RGO78NmPL01CaCsDCNVy/ZR8j9daXChzMerpsNvnf0G3zzvlouFkGIWA
         xDaA==
X-Gm-Message-State: AAQBX9dnyute6rdY+BYyweSoP4mxOYcS5203vftsnyH/SKdvL5rVq+q3
        Mm7ht1wr/Wj65LyLVL2jAHpQO7Rv2FW7dZOn3iuVQyacvhWy
X-Google-Smtp-Source: AKy350bIKMYbC/pZmNGQXdPKzsT+OlKFOO3FuIPWy76dbhgzUqq3R4CpUYPgF1umDkAoC7QOqlG69iC+9xKB
X-Received: by 2002:a17:906:184d:b0:8b1:e791:faef with SMTP id w13-20020a170906184d00b008b1e791faefmr34291387eje.67.1680533475390;
        Mon, 03 Apr 2023 07:51:15 -0700 (PDT)
Received: from fedora.dectris.local (dect-ch-bad-pfw.cyberlink.ch. [62.12.151.50])
        by smtp-relay.gmail.com with ESMTPS id i25-20020a17090685d900b00944010e0472sm3146122ejy.236.2023.04.03.07.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 07:51:15 -0700 (PDT)
X-Relaying-Domain: dectris.com
From:   Kal Conley <kal.conley@dectris.com>
To:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Cc:     Kal Conley <kal.conley@dectris.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 2/2] selftests: xsk: Add test case for packets at end of UMEM
Date:   Mon,  3 Apr 2023 16:50:47 +0200
Message-Id: <20230403145047.33065-3-kal.conley@dectris.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230403145047.33065-1-kal.conley@dectris.com>
References: <20230403145047.33065-1-kal.conley@dectris.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add test case to testapp_invalid_desc for valid packets at the end of
the UMEM.

Signed-off-by: Kal Conley <kal.conley@dectris.com>
---
 tools/testing/selftests/bpf/xskxceiver.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 3956f5db84f3..34a1f32fe752 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -1662,6 +1662,8 @@ static void testapp_invalid_desc(struct test_spec *test)
 		{-2, PKT_SIZE, 0, false},
 		/* Packet too large */
 		{0x2000, XSK_UMEM__INVALID_FRAME_SIZE, 0, false},
+		/* Up to end of umem allowed */
+		{umem_size - PKT_SIZE, PKT_SIZE, 0, true},
 		/* After umem ends */
 		{umem_size, PKT_SIZE, 0, false},
 		/* Straddle the end of umem */
@@ -1675,16 +1677,17 @@ static void testapp_invalid_desc(struct test_spec *test)
 
 	if (test->ifobj_tx->umem->unaligned_mode) {
 		/* Crossing a page boundrary allowed */
-		pkts[6].valid = true;
+		pkts[7].valid = true;
 	}
 	if (test->ifobj_tx->umem->frame_size == XSK_UMEM__DEFAULT_FRAME_SIZE / 2) {
 		/* Crossing a 2K frame size boundrary not allowed */
-		pkts[7].valid = false;
+		pkts[8].valid = false;
 	}
 
 	if (test->ifobj_tx->shared_umem) {
 		pkts[4].addr += umem_size;
 		pkts[5].addr += umem_size;
+		pkts[6].addr += umem_size;
 	}
 
 	pkt_stream_generate_custom(test, pkts, ARRAY_SIZE(pkts));
-- 
2.39.2

