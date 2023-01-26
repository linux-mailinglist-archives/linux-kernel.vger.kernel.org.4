Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF11567D23D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 17:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjAZQ5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 11:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjAZQ5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 11:57:10 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE20BCA16
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 08:57:08 -0800 (PST)
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 317E53FFEE
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 16:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1674752227;
        bh=AqdG7g/ZZSZ4pNA8kNsOLtm4cZ2nj059acclO2QHloQ=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=DclGZmfeAPz6NdPSTdjaoTnOHdAEMhU8ymwJKe4dVhqKTbNpq6/CVGpCG0TcFUx03
         1kWAakKEpUqev/VKc23Q6+ZQMM0d+xIzTbtkfUzk5VRK/WZAYcwDLabyrkSCpMbOrK
         MZ/ObcgZLGHWr7CIah1tvdy4cCI0tInZZeg0ojCFEcDS/xeYQgwkb3bh9K/Hwe8WE5
         YIFnTuxnpTOA2wkGu65urwlcKsh/Yk4tZWZEzUmUt14OZ1RRt9+32u+Mw4vlFFK2l+
         Gw4Ih2JusAHeFEUod/B61r1PfZD1awIDhJjvx+fjJgDvAynKMHbSlkVP2tsjb2OSs4
         LjcAgL3qQX5Mw==
Received: by mail-wr1-f72.google.com with SMTP id i8-20020a05600011c800b002bfb6712623so453844wrx.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 08:57:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AqdG7g/ZZSZ4pNA8kNsOLtm4cZ2nj059acclO2QHloQ=;
        b=gpwQQpcrVWaLBuKCw+Qu4b10CDGm7eG73ZzntIfvhVA0A54SsjKzahzQLBSHQo/0Ao
         5HTMJg/HZ6Z7PtyBeeGsYCaHax4gpzyje394ObzUZjAsjzx6M30cBYmZ4nCuMRfLtVEC
         iqdCDh6d+IouuG0yvX0SEvJqbCpLtye7XaZdgbwYGGaVLnndv5g1V1/tYkCTekovYYzn
         TEvRgoYihc/JzVoxV/Q55XS5IIXTqqkvJkjF+PMP42QpzXXjsTvzvj0+jnEqqXRUbPU8
         GoQpszT/2jCD8vhnqZXPmH5/Qyb7xWeYoNOe8lkPVR+wBiAYLIuhvXAWNVIm7cJB5Dn1
         L2/A==
X-Gm-Message-State: AO0yUKWT4fpMiCGi/B5vlarqfdWScZzMFocHXztCsdBma2QNEdidDlav
        pmiRdzD5aiVFfE4PqOJLqU2NU/Xq5CBlV2xpA19yu6xgrX0WqbkApf7nsR8hSIn8RVbvjNp5rR5
        FhWmeKSgGMT4n1kCU1eekxVw+QrLPKvJyPMP2lYrOnA==
X-Received: by 2002:a5d:4578:0:b0:2bf:c725:85 with SMTP id a24-20020a5d4578000000b002bfc7250085mr2088193wrc.12.1674752226311;
        Thu, 26 Jan 2023 08:57:06 -0800 (PST)
X-Google-Smtp-Source: AK7set+6H2kfXMT7ftWtKu40YIJWufbyLiNwAPLxiuN+FJ6q9L1RwkmEUjFPqgtZSaO3tmoiBUHB5w==
X-Received: by 2002:a5d:4578:0:b0:2bf:c725:85 with SMTP id a24-20020a5d4578000000b002bfc7250085mr2088187wrc.12.1674752226168;
        Thu, 26 Jan 2023 08:57:06 -0800 (PST)
Received: from qwirkle.internal ([81.2.157.149])
        by smtp.gmail.com with ESMTPSA id n1-20020a5d6b81000000b002bdc39849d1sm1701946wrx.44.2023.01.26.08.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 08:57:05 -0800 (PST)
From:   Andrei Gherzan <andrei.gherzan@canonical.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc:     Andrei Gherzan <andrei.gherzan@canonical.com>,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selftest: net: Improve IPV6_TCLASS/IPV6_HOPLIMIT tests apparmor compatibility
Date:   Thu, 26 Jan 2023 16:55:48 +0000
Message-Id: <20230126165548.230453-1-andrei.gherzan@canonical.com>
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

"tcpdump" is used to capture traffic in these tests while using a random,
temporary and not suffixed file for it. This can interfere with apparmor
configuration where the tool is only allowed to read from files with
'known' extensions.

The MINE type application/vnd.tcpdump.pcap was registered with IANA for
pcap files and .pcap is the extension that is both most common but also
aligned with standard apparmor configurations. See TCPDUMP(8) for more
details.

This improves compatibility with standard apparmor configurations by
using ".pcap" as the file extension for the tests' temporary files.

Signed-off-by: Andrei Gherzan <andrei.gherzan@canonical.com>
---
 tools/testing/selftests/net/cmsg_ipv6.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/cmsg_ipv6.sh b/tools/testing/selftests/net/cmsg_ipv6.sh
index 2d89cb0ad288..330d0b1ceced 100755
--- a/tools/testing/selftests/net/cmsg_ipv6.sh
+++ b/tools/testing/selftests/net/cmsg_ipv6.sh
@@ -6,7 +6,7 @@ ksft_skip=4
 NS=ns
 IP6=2001:db8:1::1/64
 TGT6=2001:db8:1::2
-TMPF=`mktemp`
+TMPF=$(mktemp --suffix ".pcap")
 
 cleanup()
 {
-- 
2.34.1

