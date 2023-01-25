Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74C667B813
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 18:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235758AbjAYRLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 12:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236120AbjAYRLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 12:11:08 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E765A5A36E
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 09:10:18 -0800 (PST)
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1A6873FD98
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 17:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1674666589;
        bh=ThPASxkQPa8akyDheX0+gKydQu/0488KOg7wyMg90UM=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=RL/7jLfoAqLeGP2NnKeMKCv7rHvcuwr9yDweqKR7K+vyXAQ+hGHvLaoPbtSUemGRE
         f39YQdm5lBBgOrVl6z8sGWszDFhPkhMvzskvWs2BG53Abvd9kkj8eOZ/I6QiBicLC9
         lyAfowStXx2yk90b/7U/mYtjNdAQdnueiZqoaxsfcu1TKwSYEhkK/DhwmnmA5QwDwC
         sQUtKjxxM+K49Che6v7Lj9sFtGK1NloL1UdLyTzwRnkGYpTVn2TyVjgMV/o9bv2xod
         a7Mi7rNcOgID5QZ7yef08/Mq0z9QtAl6EKID4B5PwsohB1WAnmb6gvjaOnKS1S9Zf0
         iNmmsHNm8hbng==
Received: by mail-wr1-f71.google.com with SMTP id l18-20020adfa392000000b002bbd5c680a3so3381103wrb.14
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 09:09:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ThPASxkQPa8akyDheX0+gKydQu/0488KOg7wyMg90UM=;
        b=1EcwFkAtD3iRk7fRuoBQ0r2DI195a/ewV7RUFLJjMU3qk1mqK2MifkwbIHdDgswG9N
         xBQUMBZqdt09LHgjLPXKTTObMl2ghLAFtefdR7F+SnBhWrMn+o5oFP8Rxy4mECb+IMKm
         M4Gnvzo9nNvnFJgyAiHZeOxdFW9P7D2RkwVAlu8BnnONQAMsSQnk2XNgBEQZzh9cBsY2
         lZDM4A5YU2zTqfztGmMCw3+32i4X1vPaZskPTgsLtVi9cXuZBTUF4S6GOJjm5KY4yqJ5
         n9loJIwLL1IxeIAI1P3yhaSRdF44LviBvlBpT/JqPJoRVdY7KMjjgkd2//BBkOWThwYV
         z8Tg==
X-Gm-Message-State: AFqh2kpPPgahWisdLbUijBGrgtdN4JZlBoQK5/qRBFm/seL8OpoOwvv/
        /aCG+R55M9Pf1ZU7YlR5z7L1KET1KJq4cf4f3rkUes7T3w5co54zeSnh9QkUWQHAakDyDJDKbSz
        PX/Fhw3mpzEGKMMuL9hy/dE4y6S8NOGoBK57jEFrK6A==
X-Received: by 2002:a05:600c:540d:b0:3d9:fb59:c16b with SMTP id he13-20020a05600c540d00b003d9fb59c16bmr29501091wmb.36.1674666588830;
        Wed, 25 Jan 2023 09:09:48 -0800 (PST)
X-Google-Smtp-Source: AMrXdXttpC9n/HLYXg7sMnJ5cCNz0V3VuvEsRb/sRdznLMTLa9UoYawtcdp3z0yJ9R5hGsEyyqW5hQ==
X-Received: by 2002:a05:600c:540d:b0:3d9:fb59:c16b with SMTP id he13-20020a05600c540d00b003d9fb59c16bmr29501071wmb.36.1674666588596;
        Wed, 25 Jan 2023 09:09:48 -0800 (PST)
Received: from qwirkle.internal ([81.2.157.149])
        by smtp.gmail.com with ESMTPSA id a3-20020adff7c3000000b002bdc3f5945dsm4793280wrq.89.2023.01.25.09.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 09:09:48 -0800 (PST)
From:   Andrei Gherzan <andrei.gherzan@canonical.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH 2/2] selftests: net: .gitignore the scratch directory of bpf
Date:   Wed, 25 Jan 2023 17:08:46 +0000
Message-Id: <20230125170845.85237-2-andrei.gherzan@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230125170845.85237-1-andrei.gherzan@canonical.com>
References: <20230125170845.85237-1-andrei.gherzan@canonical.com>
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

The net/bpf Makefile uses a similar build infrastructure to BPF[1] while
building libbpf as a dependency of nat6to4. This change adds a .gitignore
entry for SCRATCH_DIR where libbpf and its headers end up built/installed.

[1] Introduced in commit 837a3d66d698 ("selftests: net: Add
cross-compilation support for BPF programs")

Signed-off-by: Andrei Gherzan <andrei.gherzan@canonical.com>
---
 tools/testing/selftests/net/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
index a6911cae368c..0d07dd13c973 100644
--- a/tools/testing/selftests/net/.gitignore
+++ b/tools/testing/selftests/net/.gitignore
@@ -40,6 +40,7 @@ test_unix_oob
 timestamping
 tls
 toeplitz
+/tools
 tun
 txring_overwrite
 txtimestamp
-- 
2.34.1

