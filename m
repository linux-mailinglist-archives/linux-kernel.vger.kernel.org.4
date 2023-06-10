Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F78372ACF8
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 18:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjFJQM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 12:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbjFJQMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 12:12:34 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6699E30DD
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 09:12:13 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f7368126a6so20275895e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 09:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1686413523; x=1689005523;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Od7XJ6McPFlfq5BVWjPNQjjhHIXM4eR5h7tKrhJC2l8=;
        b=AG1l4DxAFRmzXMX0WAMATVJca9oFAqM/k34dReGnbtJtmbqt+oUm0ZOuAZxJFVIJtt
         gDMHDt44o7XZXaJqqkfl/8FHus6Ea44FFb45GVLbuq7v6t4TNHEUZwI44gzipSC9R1v+
         rF8jynoFAeJ6MmWQpSgTnAzO5JWwH6nOy11nURKEYLYtBLBu1Q3SIQOR7aocsnjp6Pzv
         z5uPjR1tuEpGZx10OS0UxWos+8UE+bTFswqhDMzKaaVzIAPR/pxLJzhn0XxW72qtTO2p
         BJAD+hzaJiRae9L/89UPeLHMjVfALK+3X6weOjla0PrExW683UpwpCe1yDL0pIHxdwU2
         OnQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686413523; x=1689005523;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Od7XJ6McPFlfq5BVWjPNQjjhHIXM4eR5h7tKrhJC2l8=;
        b=k1aB4HCewmkg3ciI3BvlOdmPC5bhFzI/6Wfc9Ps/6bpDokA+iFTa0tggY/FmyOQDMq
         FrIXtp27trQUW+wEmLeuKxHlBsGqEb3BXIHFS/KAzmG4PIA4qUJUOIBsdIrSOxitw2cY
         9Em+UFYQ9s5jAL6v9vUNMAPE6vBlZNIQl9t7YLxoAUHmkzc2OWSdUt040mDFSWlzxo/r
         8vnoU4P9bM4T8slgFpUFKPO5qdFB/21gZeQMg8L+4GSS+9cg5j5Xncqeie8/8zxwnFcr
         qNp+l0d1GVyfzq9wqXXE/5hJ3uCphu077ksWhBr5oHLnXZYSDvmgV68/p6263hkVvk92
         cPag==
X-Gm-Message-State: AC+VfDzE8DeoZq7ysIk3+9OWHWPUQuTsnRcTcInWAnjfV6ThJ6YNqf7n
        cM34FsL8v8q86Z5GXYXi/3Znyg==
X-Google-Smtp-Source: ACHHUZ6grhXr9hKvTkfHddjkVEcFAtkr3ZIU2fUb+rdyksEP/vi6ecpJdycjy5Qed7ZMG0JSwXrg0g==
X-Received: by 2002:a1c:f718:0:b0:3f7:3526:d96f with SMTP id v24-20020a1cf718000000b003f73526d96fmr2828491wmh.27.1686413522892;
        Sat, 10 Jun 2023 09:12:02 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id u9-20020a5d4349000000b003079c402762sm7431145wrr.19.2023.06.10.09.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 09:12:02 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Sat, 10 Jun 2023 18:11:48 +0200
Subject: [PATCH net 13/17] selftests: mptcp: join: skip fail tests if not
 supported
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230609-upstream-net-20230610-mptcp-selftests-support-old-kernels-part-3-v1-13-2896fe2ee8a3@tessares.net>
References: <20230609-upstream-net-20230610-mptcp-selftests-support-old-kernels-part-3-v1-0-2896fe2ee8a3@tessares.net>
In-Reply-To: <20230609-upstream-net-20230610-mptcp-selftests-support-old-kernels-part-3-v1-0-2896fe2ee8a3@tessares.net>
To:     mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Florian Westphal <fw@strlen.de>,
        Davide Caratti <dcaratti@redhat.com>,
        Christoph Paasch <cpaasch@apple.com>,
        Geliang Tang <geliangtang@gmail.com>,
        Geliang Tang <geliang.tang@suse.com>
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        stable@vger.kernel.org
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1309;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=/IBWHeyor9yWKvvK4XMwcSzwOR/XkUMWWIef4BnwJKM=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkhKC+1AHuF+8qskPv3iMOrnzCYwCBBR38BpkVc
 m4Lk/VVR12JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZISgvgAKCRD2t4JPQmmg
 czubD/9H8/pP3KWsx+e9hBmkboJqLVUAC+tnzLfxQtpt/FLS11K/ImZ0P/Hf3WoFJaKT7qfpwMF
 vt9Wk6GX7fF6WAfwqBexKj0jKvvWkw5yNYZ1Nmn5HAxO8rTbaH0NQXuSuASQerpEQNgYKyKf+e5
 9bAUrh0Z4Tr3FwC7JT8VqPRNH2tA6uUbiQ8whBlBFiB4z8yCVXF9RxfHjsQz+TUxzOOUJpdWqkb
 ilcr0xeIxPTfK/yuDNwLQsi6QiA0LAU5lgnUw/M9FZ3sjv4aBRpqw7oeOgIVI3cbA+KlOLh6t/I
 3DA8CSyWo6PtDZDu5UQicuRUqR7vVtaJio+CJJCxSGMBYLiUI36nDA6yRcYjVdKexNYFv7atFw5
 36abp3AGYKqTXSrDWe1FVjrh4+fzfKBDKzryEyDNLwYxyNnDvloVn3kbS1POW8tJGnWcvQPZrda
 sqNJooY2UjV4///p1GiIrJNFq86y+DiJFTHtN7ALv9l+qhHwMOnx0UCVEjHExiYlBtZ1yiYlliA
 POZwNt6o2h7IqF2Q1jeijUwOSxD9MPCjtetqXxiwXbXVk5FJe0/PcELXY3lEy6TUMGOXsy/wQdM
 jbrlyBt7ayZW0pTlBGWyV70gZnpj26oJ7xJA+yW/3giMUEtQkk0ZedfiWU4kleMRRFSUIeOSy1k
 OKHuKk8sJx6SW4Q==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

One of them is the support of the MP_FAIL / infinite mapping introduced
by commit 1e39e5a32ad7 ("mptcp: infinite mapping sending") and the
following ones.

It is possible to look for one of the infinite mapping counters to know
in advance if the this feature is available.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: b6e074e171bc ("selftests: mptcp: add infinite map testcase")
Cc: stable@vger.kernel.org
Fixes: 2ba18161d407 ("selftests: mptcp: add MP_FAIL reset testcase")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index f9161ed69b86..7867bad59253 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -384,7 +384,7 @@ setup_fail_rules()
 
 reset_with_fail()
 {
-	reset "${1}" || return 1
+	reset_check_counter "${1}" "MPTcpExtInfiniteMapTx" || return 1
 	shift
 
 	ip netns exec $ns1 sysctl -q net.mptcp.checksum_enabled=1

-- 
2.40.1

