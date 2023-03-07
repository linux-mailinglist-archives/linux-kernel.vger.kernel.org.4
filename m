Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391FE6AF6FE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 21:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjCGUzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 15:55:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjCGUzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 15:55:20 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C03A72B0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 12:55:17 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id a2so15520414plm.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 12:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1678222516;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uf09mUG+R3cX/yzWF7w4T1H/8lFUsiESqp6B01wlKC8=;
        b=aHvC+b+6LJcqH1ok2yKhUrDZ1Yx9qpIO/b4P0cUVs4B8W6FrjowSN5WgFQtiMi/xXa
         wmtbfquGHBNAjthpWIfXuw7k3opw0KXUr1WXdfASSmJHNJx1svgDoLIBV7JaFyRiExre
         8pXbT4BXM9NRrDoOjtJAcd/ekgqeWU6srZAGEWfW5oJx9gpyqHdAKU7uH9+QQrmX/dwT
         lZGTXXa9WboJOtEP7H8naXs3MhvbC7SIF0YwcruLtLVMxvmyXHz1XqXGXlnBW6pp9p6Z
         l7z0/yDcJbW/6RVkbT4jAnowPXKGfWuG7bi9p5ZW7msycELEZj55TliYBf2whAVCCZoZ
         kn3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678222516;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uf09mUG+R3cX/yzWF7w4T1H/8lFUsiESqp6B01wlKC8=;
        b=FGCRwinO3MK9PGoaVhjLO2ntmLHJx5bt9k/oKbq9Fg9u+FBC3p3XcnKTuzf2Wls2a2
         plQyQkt+qbPGgL6fYnQK03pmc0YvurAYANWJ7LBwXSEyIQcFK5WjsGXhNPewxyPW6a/w
         txIlwDyIhb75CeDkcXgj6fdCcqhNXFVA7Q1bAoPLYACwTuyBGnZ3/db74EosnZBaXtA5
         7lFz5qcTfoI43bLOFj6cGNSAcVU3lKgby7ppmg9J5xK7Ea3LDy1LwGnpaHv4FrH+LH9G
         wIu6YnKBGKWKYz4aBBrlyU8dypKc8weCoSYMCMn+DrB4ugJoYdAEczg6vRfhJLuL3nP0
         9n/Q==
X-Gm-Message-State: AO0yUKW/bDFSAt2Q3mcYvUJH+iKPmLYIdmNrv66WIdBhaantefg6et71
        TCEf1/Ht3qNqeJE+8Af8pVnrfQ==
X-Google-Smtp-Source: AK7set+x6oKhZIRPFyjR0qdrSFzoS0J8zZnOQwnnlSVQzz8XBnphl/qXZjv/mfwoOC5I7GgxRBJ2LA==
X-Received: by 2002:a17:902:e5cb:b0:19c:13d2:44c5 with SMTP id u11-20020a170902e5cb00b0019c13d244c5mr17394823plf.3.1678222516484;
        Tue, 07 Mar 2023 12:55:16 -0800 (PST)
Received: from [127.0.0.1] ([50.233.106.125])
        by smtp.gmail.com with ESMTPSA id d19-20020a170902aa9300b001932a9e4f2csm8775494plr.255.2023.03.07.12.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 12:55:15 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        io-uring Mailing List <io-uring@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20230307203830.612939-1-ammarfaizi2@gnuweeb.org>
References: <20230307203830.612939-1-ammarfaizi2@gnuweeb.org>
Subject: Re: [PATCH liburing v1 0/3] Small fixes and CI update
Message-Id: <167822251537.5425.8684184793523517350.b4-ty@kernel.dk>
Date:   Tue, 07 Mar 2023 13:55:15 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-ebd05
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 08 Mar 2023 03:38:27 +0700, Ammar Faizi wrote:
> Just a boring patchset.
> 
> - Address the recent io_uring-udp bug report on GitHub.
> - No more sign-compare warnings on the GitHub build bot.
> - Kill trailing whitespaces (manpage).
> 
> 
> [...]

Applied, thanks!

[1/3] io_uring-udp: Fix the wrong `inet_ntop()` argument
      commit: 4f1b8850dc1f18c0160917669c64eda879093304
[2/3] github: Append `-Wno-sign-compare` to the GitHub build bot CFLAGS
      commit: fe4d0be3a96e33aef265bfe8509b088846736fe7
[3/3] man/io_uring_register_{buffers,files}: Kill trailing whitespaces
      commit: 9e4190aed43f25b2986155a2f6019fc2fc89920f

Best regards,
-- 
Jens Axboe



