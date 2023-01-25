Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38F667B811
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 18:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236088AbjAYRKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 12:10:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235610AbjAYRKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 12:10:15 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F3B5B5A2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 09:09:24 -0800 (PST)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BD66C3F2D8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 17:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1674666558;
        bh=1pZvzv+KflAf7vIEa8jpMx+2B8SROeL8aqXFHfenOiI=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=vFI/KKjqYsuAs63k+4BfD4iZOHsp1ueoiEY4Okr3exXgQG9ZXas3U6jfsyPHfqC+v
         FONpujZbkrX9DfVaXUpWUdPu7mkz+VQTnvFZYyAFRnn9iWyOok6AHkeWd10XAFNDUG
         fd40OyqK7ErgBjzKxRiasD6kR2jNEzpe7DwGCUNyaMr07ZL32XtSVWUarAPuDU48Yo
         d4htGFNqdzr2hI0GeDNHAsng7FHXn4C0dQ80pyyzyGXUuwf6h9OfJ1cEXwI/YyC3r2
         iLfrT6G+T4t05bfm6nPL9IFsg3Rv3wkAFTztN0Zbuqj+Q8ESaKSsvxHP1fmoh/zsJ7
         YPUHPRkzuzZnA==
Received: by mail-wm1-f72.google.com with SMTP id ay38-20020a05600c1e2600b003da7c41fafcso1379221wmb.7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 09:09:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1pZvzv+KflAf7vIEa8jpMx+2B8SROeL8aqXFHfenOiI=;
        b=dvCMRAqQD2thh/PVjeD7uU8qVqhR24D7LYn9y17CKWgWrxPIVpfBQIsnSDQQs248ss
         y8HJ6nxJTWjqK05ZIwn5+vP8leXr9GJqmkoFUwsOarsj6/32eZFWLXvxnnV2ExErn5xm
         IfSzznLQhGRs2Lci4vCjBnockV27lo2LFw/X/IiL4Gir4cnPGev1xZOEw8S+XHzK88VP
         L0vtd1R23STq0tMIwabdISPoRuPJzM73AXCbNiW5z6X04b8YVoWdKecwVIKEWYhGg+aW
         MLFD7UqEZEOAwCXG0Hi2IAJ/T/BVEinoDGK2HfPjFoCCRyqZMrQY+HF+PF3zB3qRWgbX
         Rh+g==
X-Gm-Message-State: AO0yUKXIDHoFZakwdT5FvbgiADkm5cdwYWK1P/dms36/dEfTfqL4QFnd
        vUOFDG9YQiRN4O4Wse98o7pJGAHXgK6cWv10sw+mSJWYO8/Fc4hPHpjpDGNaIgUTdzQ2Myl1SWJ
        K4ccFtLF9ZJHs94RU/zpaxGQGUnLyA/PKq8+1TnZm4w==
X-Received: by 2002:adf:eb12:0:b0:2bf:b1f6:7db7 with SMTP id s18-20020adfeb12000000b002bfb1f67db7mr4974007wrn.27.1674666558429;
        Wed, 25 Jan 2023 09:09:18 -0800 (PST)
X-Google-Smtp-Source: AK7set9Yau3RcyKrwSYnXVLJqxfF8rJF5bNvRjqoqFOjcS5MQWnt1HjAo3+zYU12Y7dMZhpvZJf3yg==
X-Received: by 2002:adf:eb12:0:b0:2bf:b1f6:7db7 with SMTP id s18-20020adfeb12000000b002bfb1f67db7mr4973985wrn.27.1674666558143;
        Wed, 25 Jan 2023 09:09:18 -0800 (PST)
Received: from qwirkle.internal ([81.2.157.149])
        by smtp.gmail.com with ESMTPSA id a3-20020adff7c3000000b002bdc3f5945dsm4793280wrq.89.2023.01.25.09.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 09:09:17 -0800 (PST)
From:   Andrei Gherzan <andrei.gherzan@canonical.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc:     Andrei <andrei.gherzan@canonical.com>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH 1/2] selftests: net: Fix missing nat6to4.o when running udpgro_frglist.sh
Date:   Wed, 25 Jan 2023 17:08:44 +0000
Message-Id: <20230125170845.85237-1-andrei.gherzan@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei <andrei.gherzan@canonical.com>

The udpgro_frglist.sh uses nat6to4.o which is tested for existence in
bpf/nat6to4.o (relative to the script). This is where the object is
compiled. Even so, the script attempts to use it as part of tc with a
different path (../bpf/nat6to4.o). As a consequence, this fails the script:

Error opening object ../bpf/nat6to4.o: No such file or directory
Cannot initialize ELF context!
Unable to load program

This change refactors these references to use a variable for consistency
and also reformats two long lines.

Signed-off-by: Andrei <andrei.gherzan@canonical.com>
---
 tools/testing/selftests/net/udpgro_frglist.sh | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/udpgro_frglist.sh b/tools/testing/selftests/net/udpgro_frglist.sh
index c9c4b9d65839..1fdf2d53944d 100755
--- a/tools/testing/selftests/net/udpgro_frglist.sh
+++ b/tools/testing/selftests/net/udpgro_frglist.sh
@@ -6,6 +6,7 @@
 readonly PEER_NS="ns-peer-$(mktemp -u XXXXXX)"
 
 BPF_FILE="../bpf/xdp_dummy.bpf.o"
+BPF_NAT6TO4_FILE="./bpf/nat6to4.o"
 
 cleanup() {
 	local -r jobs="$(jobs -p)"
@@ -40,8 +41,12 @@ run_one() {
 
 	ip -n "${PEER_NS}" link set veth1 xdp object ${BPF_FILE} section xdp
 	tc -n "${PEER_NS}" qdisc add dev veth1 clsact
-	tc -n "${PEER_NS}" filter add dev veth1 ingress prio 4 protocol ipv6 bpf object-file ../bpf/nat6to4.o section schedcls/ingress6/nat_6  direct-action
-	tc -n "${PEER_NS}" filter add dev veth1 egress prio 4 protocol ip bpf object-file ../bpf/nat6to4.o section schedcls/egress4/snat4 direct-action
+	tc -n "${PEER_NS}" filter add dev veth1 ingress prio 4 protocol \
+		ipv6 bpf object-file "$BPF_NAT6TO4_FILE" section \
+		schedcls/ingress6/nat_6 direct-action
+	tc -n "${PEER_NS}" filter add dev veth1 egress prio 4 protocol \
+		ip bpf object-file "$BPF_NAT6TO4_FILE" section \
+		schedcls/egress4/snat4 direct-action
         echo ${rx_args}
 	ip netns exec "${PEER_NS}" ./udpgso_bench_rx ${rx_args} -r &
 
@@ -88,7 +93,7 @@ if [ ! -f ${BPF_FILE} ]; then
 	exit -1
 fi
 
-if [ ! -f bpf/nat6to4.o ]; then
+if [ ! -f "$BPF_NAT6TO4_FILE" ]; then
 	echo "Missing nat6to4 helper. Build bpfnat6to4.o selftest first"
 	exit -1
 fi
-- 
2.34.1

