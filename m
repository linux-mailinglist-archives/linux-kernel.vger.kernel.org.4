Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8884682D4A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 14:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjAaNGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 08:06:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbjAaNFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:05:54 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619AB4ED11
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 05:05:41 -0800 (PST)
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BC5DD41ADA
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 13:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1675170338;
        bh=mke2sRYMF56da8SzcTS7xCmqUhLspqW5BWedBOJgZhs=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=VW304v+HiCqyrOiTcTiA/TyipL2yxS7pKZ8uyvbFTlad4ybGW5uB5sxXHCQ3LNqCN
         Wl1PSzS/Cqycqlg4XlGz7bSxg+gu/A+NpUahTW4DOubkNAxAwiMNDd+D0waY0L2FZo
         Hjye7JHCssTx4KMAiAtmnYHPS+c5kQaaMClGeW7M1QZXrM10IWa4SsLPCMoOM+C2kl
         X2gMecn0Uc/eCSHqDSnNACXlSrA54sGpwI8DHetrRDiWMAsEdgnIgOxV1BAW6td03J
         OX9JHGf0Z/sFMIQGPOa693iAxFdaJrzIrG014L7rWeSoDtKvIJOwpt9cieic0+3uMN
         /llSZtFnEsa+A==
Received: by mail-wm1-f69.google.com with SMTP id d14-20020a05600c34ce00b003dd07ce79c8so1909563wmq.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 05:05:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mke2sRYMF56da8SzcTS7xCmqUhLspqW5BWedBOJgZhs=;
        b=AiPOUn12fk+FVU6683e0h7h4j6Q7LPgeRWyE9ue7S8qPLLywZ2Y/6PvxC6WuRk2LMb
         L8mjoDTsHNJUq3fsiG1kBFvVfeGG/l1qFt6qlDbboqAN165YdjwzFcQcoV9g3UxdsWdB
         zlj9AYBnkcBh5WgJNVgbIm6LJi6+BFxUQADQWdT09CoA0eqhvsoOtU/qj9virV/JcLmt
         Kmz1U08xq6I2zwmPdLeP28wklglosV47wfiohZ71QpwC7DeGNTl6QJfwODD05GwFTSPB
         Bc5aNQGlEJUiKdNCyC+FD7gDd9GjAYfIOOnPAsqEISBzQHuNVINJqA80LbNNKG1NaF3w
         kyaA==
X-Gm-Message-State: AO0yUKUM9/1rhd/PFNIF9Mp4ULeSE5xeidv58E6Wh6M9ttxGGiTDIO9B
        8L4ou5OS/hFHwpZaWYjPSYV7T/rQEcjgyNjrSmCDUbavuvQLV8LyCjonvg54jQ6nmXywV6T318X
        wSoHi5UYJ8eYowou1EK6peF3UfSULe64guuI+Z4hTRg==
X-Received: by 2002:a05:6000:1b89:b0:2bf:d9e3:3e51 with SMTP id r9-20020a0560001b8900b002bfd9e33e51mr2460761wru.56.1675170337776;
        Tue, 31 Jan 2023 05:05:37 -0800 (PST)
X-Google-Smtp-Source: AK7set+XO9fLL7b6ivd1PyynxaJFa6hz5wTD4c9yx9nxWe7sftlJN0awPGBVQ2kLavYQs3KX7JlC3A==
X-Received: by 2002:a05:6000:1b89:b0:2bf:d9e3:3e51 with SMTP id r9-20020a0560001b8900b002bfd9e33e51mr2460739wru.56.1675170337473;
        Tue, 31 Jan 2023 05:05:37 -0800 (PST)
Received: from localhost.localdomain ([2001:67c:1560:8007::aac:c4dd])
        by smtp.gmail.com with ESMTPSA id f6-20020a5d50c6000000b002bfc24e1c55sm14741436wrt.78.2023.01.31.05.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 05:05:37 -0800 (PST)
From:   Andrei Gherzan <andrei.gherzan@canonical.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc:     Andrei Gherzan <andrei.gherzan@canonical.com>,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] selftests: net: udpgso_bench: Fix racing bug between the rx/tx programs
Date:   Tue, 31 Jan 2023 13:04:11 +0000
Message-Id: <20230131130412.432549-3-andrei.gherzan@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230131130412.432549-1-andrei.gherzan@canonical.com>
References: <20230131130412.432549-1-andrei.gherzan@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"udpgro_bench.sh" invokes udpgso_bench_rx/udpgso_bench_tx programs
subsequently and while doing so, there is a chance that the rx one is not
ready to accept socket connections. This racing bug could fail the test
with at least one of the following:

./udpgso_bench_tx: connect: Connection refused
./udpgso_bench_tx: sendmsg: Connection refused
./udpgso_bench_tx: write: Connection refused

This change addresses this by making udpgro_bench.sh wait for the rx
program to be ready before firing off the tx one - with an exponential back
off algorithm from 1s to 10s.

Signed-off-by: Andrei Gherzan <andrei.gherzan@canonical.com>
---
 tools/testing/selftests/net/udpgso_bench.sh | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/testing/selftests/net/udpgso_bench.sh b/tools/testing/selftests/net/udpgso_bench.sh
index dc932fd65363..20b5db8fcbde 100755
--- a/tools/testing/selftests/net/udpgso_bench.sh
+++ b/tools/testing/selftests/net/udpgso_bench.sh
@@ -7,6 +7,7 @@ readonly GREEN='\033[0;92m'
 readonly YELLOW='\033[0;33m'
 readonly RED='\033[0;31m'
 readonly NC='\033[0m' # No Color
+readonly TESTPORT=8000 # Keep this in sync with udpgso_bench_rx/tx
 
 readonly KSFT_PASS=0
 readonly KSFT_FAIL=1
@@ -56,10 +57,27 @@ trap wake_children EXIT
 
 run_one() {
 	local -r args=$@
+	local -r init_delay_s=1
+	local -r max_delay_s=10
+	local delay_s=0
+	local nr_socks=0
 
 	./udpgso_bench_rx &
 	./udpgso_bench_rx -t &
 
+	# Wait for the above test program to get ready to receive connections.
+	delay_s="${init_delay_s}"
+	while [ "$delay_s" -lt "$max_delay_s" ]; do
+		nr_socks="$(ss -lnHi | grep -c "\*:${TESTPORT}")"
+		[ "$nr_socks" -eq 2 ] && break
+		sleep "$delay_s"
+		delay="$((delay*2))"
+	done
+	if [ "$nr_socks" -ne 2 ]; then
+		echo "timed out while waiting for udpgso_bench_rx"
+		exit 1
+	fi
+
 	./udpgso_bench_tx ${args}
 }
 
-- 
2.34.1

