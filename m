Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976D971398B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 15:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjE1NVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 09:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjE1NVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 09:21:03 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CBDBD;
        Sun, 28 May 2023 06:21:01 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-75b1975ea18so135154785a.3;
        Sun, 28 May 2023 06:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685280061; x=1687872061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=akn0AE9vZX3RUwIDlCTRF2LZpWprpBuLBZTHq39XBig=;
        b=JBw3AojYSTklvJ6xiPAG2k+keaiXutzjPJbOl2oI0HkreXVMZ7dUwFaTxEMoRyM9hg
         nJFbQqhLpkRNkuC0MnnssGB4gme25TAdjuPMiLyTCSncytmlvE2jMPX3Z47zBQeQWCBB
         M9GAR/N6Q/0vIt1yfeXsi4XQ3xyXmBHCpNzfVwmPygZQlvDrRkl5mK/BfhaLYxcil5Jo
         PWV/xmdOrUlzxqHq9VCWJBvDyi6+vnJW9NnUQYMDrR+/2Ox2MOT9ljWFi8GCCRHBLYBH
         r1p1FBuUMWnCw5zSWAqgobYZz4JpCbuNCveq+Waju2EUSzwaB5MlEkKQqOkRZPuTb1PQ
         a4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685280061; x=1687872061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=akn0AE9vZX3RUwIDlCTRF2LZpWprpBuLBZTHq39XBig=;
        b=Zv1BgMn3yi/OutmgWwdhub1KilfKpuc6INszDGo5XCzFoHtqqx9QXsaHpWMQ9nf0lk
         d0/5QRFWTr3EV0C8iKtInXCRVjKz7dU3a6+ADRlmeKfSfvU82epgCOWysDcmI4sxaEF0
         ccrqA4TlHj338If5Lo+piKWXTZW5NI5CS3QNOELsWn823rxhuY7kAXTP3oI/HJfAu9gj
         czibHFe3f4PMzeUV1gttLnJ+gJCF1VQyBpToTo6MoE0DxAaOr2hJqRM0Gk5fBzwRU9s4
         RVgshYHhqnw0En3buX2nEYn5MmSoMK9yn3SK4xF66yTkqAhwV5jHGEX9yfeDDsSvbRGZ
         xp0g==
X-Gm-Message-State: AC+VfDzrTuXHJCMSnVHELU5zb12zDqzDX9OUa8pTWdyLNhWo+xqrAnmY
        kV/Q8d1xzZMB1sjZCFdipB0=
X-Google-Smtp-Source: ACHHUZ5XS2rAH9OMWmDO3CuoXmoGucKRX7XvOLPY2e5l3GbsmpudomJZrrkaQHpKd/Muy97e7/XMaA==
X-Received: by 2002:a05:6214:e62:b0:5ef:8ae8:9adb with SMTP id jz2-20020a0562140e6200b005ef8ae89adbmr7067556qvb.37.1685280060963;
        Sun, 28 May 2023 06:21:00 -0700 (PDT)
Received: from localhost.localdomain (2603-6000-8100-7fd4-0000-0000-0000-0619.res6.spectrum.com. [2603:6000:8100:7fd4::619])
        by smtp.gmail.com with ESMTPSA id x5-20020ad44585000000b005dd8b9345b9sm87190qvu.81.2023.05.28.06.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 06:21:00 -0700 (PDT)
From:   "Ethan D. Twardy" <ethan.twardy@gmail.com>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Miguel Cano <macanroj@gmail.com>,
        Finn Behrens <me@kloenk.de>, Tiago Lam <tiagolam@gmail.com>,
        rust-for-linux@vger.kernel.org (open list:RUST),
        linux-kernel@vger.kernel.org (open list),
        llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT)
Cc:     "Ethan D. Twardy" <ethan.twardy@gmail.com>
Subject: [PATCH v2 0/1] Fix libclang version check for rustavailable
Date:   Sun, 28 May 2023 08:18:01 -0500
Message-Id: <20230528131802.6390-1-ethan.twardy@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains just one two-line patch, to fix a small issue
in scripts/rust_is_available.sh. This issue is currently affecting
kernel builds with Rust on Gentoo Linux (and potentially other
distributions/workflows where the kernel source path contains a
version string).

Changes from v1:
* Patch formatting. I believe there were some serious issues with the
  formatting that caused it to be lost/ignored by the mailing list.
  I sincerely hope that the formatting of this patch is acceptable,
  this is my first contribution to the kernel so I haven't mastered
  the patch workflow yet.

Ethan D. Twardy (1):
  scripts/rust_is_available: Fix clang version check

 scripts/rust_is_available.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)


base-commit: ac9a78681b921877518763ba0e89202254349d1b
-- 
2.40.1

