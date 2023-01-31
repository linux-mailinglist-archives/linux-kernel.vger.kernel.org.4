Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7D7682D49
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 14:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbjAaNF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 08:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjAaNFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:05:52 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40B84C0DD
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 05:05:42 -0800 (PST)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6BC26414A7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 13:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1675170338;
        bh=cknCzfC+eidNxevjQ90DRMfzc86MKFXSFIXJJkqDiTE=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=TTJeMCsjaw/nF5Lv18bzKhjbm+PpJUom9htgJKc8wl3jHarDzVmZsfraaey2SJi4P
         ofA77He32kGTGYsLauhGLyxM/7cD+hroYtyCfJ+zpa1JlN2k5hO9rqrnO2NB9tXuPE
         7xQWfjOt0R1wqIFhQRNfAU/9fVHj+vyjdIEpr9MmD4dzXstDNashIetgZw35siqPmA
         5pjuvdLzsQZMoXhCuJJXEHc5XPC4LBUSEowNQ45ylFmvxcCtXEkNiCw7TNcLu4g37o
         olk+khciBhgLdV/p6rnyAz7hO/xt3nrXaggp2N0abWKYequPY009mLVDN7c7Oz1HuT
         tzeZQsaR243CA==
Received: by mail-wm1-f70.google.com with SMTP id h2-20020a1ccc02000000b003db1ded176dso5837547wmb.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 05:05:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cknCzfC+eidNxevjQ90DRMfzc86MKFXSFIXJJkqDiTE=;
        b=DgR5IS+059OqjIw6fdEHyWC0MKVlUhbM/mUEjsjMNcSiK0mitS35MtFLxuS/tz+83m
         5hNgolgkS7x44oXVDImu90FviTS4zplfU+ihQQMzn8JbRTotASb6I0XyxLys0wth7Erf
         ob88p/csueetvInqXHRtYKLxKy7bf4fJBfRwOL7qLDOsM+R2zgFuK4wjuM4PMqH8i88D
         YAeeyvekKk8DDwnrMxfU5d7otzI+xyKhrFEaJPfp58CmL1eFtoAIH3NWTukQEnoREkDe
         /KjrFMAZ7z4oNPqyHgcWH1LVj+Qz4q2hWHl9Np/4xLOVZKZ6q6tq904Px2Y1So/6+qQw
         56eQ==
X-Gm-Message-State: AO0yUKWy+fOW4R/6xcTqi9ilfpcb1OBMR8iEdNmbNPvDtX9B6mu7kifr
        z2xvIle7ZgCVj950iSraoT3Nk4kNrHPhhS+nQUEk+1BHCDQQRc0VZSqj9sAN7FKwNiC6wrYosqL
        Jq8CoQQXaN5qx7gxCRpXid3HbdVb8S9DFAxJHzBLVSA==
X-Received: by 2002:a05:6000:69b:b0:2bf:df72:fdfa with SMTP id bo27-20020a056000069b00b002bfdf72fdfamr3214605wrb.40.1675170336517;
        Tue, 31 Jan 2023 05:05:36 -0800 (PST)
X-Google-Smtp-Source: AK7set84uQ9tAkQa/KFTfyH55HgVWiAi7a90Odkg3hQqGTzB5NUa4s4qv0fVF09UC1ty6PxizysYdg==
X-Received: by 2002:a05:6000:69b:b0:2bf:df72:fdfa with SMTP id bo27-20020a056000069b00b002bfdf72fdfamr3214581wrb.40.1675170336238;
        Tue, 31 Jan 2023 05:05:36 -0800 (PST)
Received: from localhost.localdomain ([2001:67c:1560:8007::aac:c4dd])
        by smtp.gmail.com with ESMTPSA id f6-20020a5d50c6000000b002bfc24e1c55sm14741436wrt.78.2023.01.31.05.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 05:05:35 -0800 (PST)
From:   Andrei Gherzan <andrei.gherzan@canonical.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc:     Andrei Gherzan <andrei.gherzan@canonical.com>,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] selftests: net: udpgso_bench_rx/tx: Stop when wrong CLI args are provided
Date:   Tue, 31 Jan 2023 13:04:10 +0000
Message-Id: <20230131130412.432549-2-andrei.gherzan@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230131130412.432549-1-andrei.gherzan@canonical.com>
References: <20230131130412.432549-1-andrei.gherzan@canonical.com>
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

Leaving unrecognized arguments buried in the output, can easily hide a
CLI/script typo. Avoid this by exiting when wrong arguments are provided to
the udpgso_bench test programs.

Signed-off-by: Andrei Gherzan <andrei.gherzan@canonical.com>
---
 tools/testing/selftests/net/udpgso_bench_rx.c | 2 ++
 tools/testing/selftests/net/udpgso_bench_tx.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/tools/testing/selftests/net/udpgso_bench_rx.c b/tools/testing/selftests/net/udpgso_bench_rx.c
index d0895bd1933f..4058c7451e70 100644
--- a/tools/testing/selftests/net/udpgso_bench_rx.c
+++ b/tools/testing/selftests/net/udpgso_bench_rx.c
@@ -336,6 +336,8 @@ static void parse_opts(int argc, char **argv)
 			cfg_verify = true;
 			cfg_read_all = true;
 			break;
+		default:
+			exit(1);
 		}
 	}
 
diff --git a/tools/testing/selftests/net/udpgso_bench_tx.c b/tools/testing/selftests/net/udpgso_bench_tx.c
index f1fdaa270291..b47b5c32039f 100644
--- a/tools/testing/selftests/net/udpgso_bench_tx.c
+++ b/tools/testing/selftests/net/udpgso_bench_tx.c
@@ -490,6 +490,8 @@ static void parse_opts(int argc, char **argv)
 		case 'z':
 			cfg_zerocopy = true;
 			break;
+		default:
+			exit(1);
 		}
 	}
 
-- 
2.34.1

