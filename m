Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6825E67E7C9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 15:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbjA0OJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 09:09:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbjA0OJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 09:09:53 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A341334C05
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 06:09:51 -0800 (PST)
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 746CD3F2F7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 14:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1674828589;
        bh=ThPASxkQPa8akyDheX0+gKydQu/0488KOg7wyMg90UM=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=A33JDy0p+EiigmA0nSmGKWTc6sMGANHsNpIiRvSvACUez5uorViZAcZr+qCNx+eyA
         DnIYKIfiwDMIpQi5kE0S6UXMnV13Ar/Mj4rmzmRQy0RcBND+C/m4qhuzVcHw4Mu0YB
         Hn7wygLCAJBOpdHasq8Mn2W4B7JRSSk5/W+/jLLQEflWAhApkctbvT0lN6kWb30q6U
         hHnwr6GQndB14Z0wsUr5k+w7nNWz4sCGoQh0VQdwPfYelJY6DLcdzQJ4tMWoueyza8
         fkYry74/2cpkcA7scqAOUQYY+XaUrpw4/DndTOtnSQO8paByaVlYZ+VtFSxGPwB6Xo
         pytVKfZX29ULg==
Received: by mail-wm1-f69.google.com with SMTP id m10-20020a05600c3b0a00b003dafe7451deso2839669wms.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 06:09:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ThPASxkQPa8akyDheX0+gKydQu/0488KOg7wyMg90UM=;
        b=WjCS3Fh81/s6kpkkbqJxiKBEnOfgGBHYi3KCZsh6jgCE98Wvzl2exZCIG1YW6wu/F8
         Q3lc4+2bm2v3MWx9T5wyC+dz6h0Mun5d1o7zsQAC3m9ICT7nUF30A/3MeZJ0wT77Qma/
         uipw8WWoSB1JB333U50+F/X4BMbMVKFMRf6ei1WK7z5SDUzQFpD4+TcJgNBfCThsHvDF
         +66SfDDiz0Sqv7PlrMJZl5Mwjyu06bxep68AH9F2NmfaRtdqk3xv751u/Wv37NrdJs1m
         LS4uZx86Mrq8ekcmL1/6wSfzwdfy25jJbBBKwO8HyFzAIwPlrCP/6KpebMFUiYsQFAgt
         uMSA==
X-Gm-Message-State: AFqh2kongzSEQX8x0mwpHclue2mbSMqoVWpCBuNfDLUN7gNyPfTaxMUu
        i1x7v6zCBFEolkds/rAQ41AIsKLuBAevvoJSEKHi7KcPul42QoCUl1XjVPcjG1RIXUBlFWHEyqj
        2EcZ7jX8Ym/hzHE1tTNXdAqAx4iYkkMKHJvf7h5hyig==
X-Received: by 2002:a05:600c:354a:b0:3da:1f6a:7b36 with SMTP id i10-20020a05600c354a00b003da1f6a7b36mr40128693wmq.0.1674828587949;
        Fri, 27 Jan 2023 06:09:47 -0800 (PST)
X-Google-Smtp-Source: AMrXdXs7b7lhU/Xr193ycZjTx4N8Y9Ik+fcCC7Uk9va/piM6WqgeOvJzsU8QQFjACQP4jx7hH+udxQ==
X-Received: by 2002:a05:600c:354a:b0:3da:1f6a:7b36 with SMTP id i10-20020a05600c354a00b003da1f6a7b36mr40128673wmq.0.1674828587759;
        Fri, 27 Jan 2023 06:09:47 -0800 (PST)
Received: from qwirkle.internal ([81.2.157.149])
        by smtp.gmail.com with ESMTPSA id f21-20020a5d58f5000000b00236883f2f5csm4105833wrd.94.2023.01.27.06.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 06:09:47 -0800 (PST)
From:   Andrei Gherzan <andrei.gherzan@canonical.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc:     Andrei Gherzan <andrei.gherzan@canonical.com>,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH v3 1/3] selftests: net: .gitignore the scratch directory of bpf
Date:   Fri, 27 Jan 2023 14:09:42 +0000
Message-Id: <20230127140944.265135-1-andrei.gherzan@canonical.com>
X-Mailer: git-send-email 2.34.1
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

