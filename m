Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A245960D6F9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 00:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbiJYWZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 18:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbiJYWY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 18:24:58 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2883B3EA4C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 15:24:57 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id b5so12940182pgb.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 15:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/99i6m4qA9/U6AcuZauGoH2LpcZL8zBcOargGjTGOT0=;
        b=QZeiRAUyskKFwBFknGXeD3Yb/V7iOyO4JeTvIgr6K5t2kwC/qpXuFpFnWOHADDsU6R
         UmGxSB3cDJ8QZcgUApqjIukszWT1nZqmb662qTBF2SaE4wVJoYXj+JZVMXIh8pyBbrtX
         U7fywBoSw2MAvU5hs0oquoEPpEYt9hCBb2Zjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/99i6m4qA9/U6AcuZauGoH2LpcZL8zBcOargGjTGOT0=;
        b=pxN3oNdZ0q96SzkkSG3K3Y1Gk8XVXTUQzJvuvFggbZSU3Wqar9HEXZnHd53h06REJu
         qEhM/jM7nGdhMmF4dcgCKF3TDkzsAlyk0Fg3aFxHVEvrg1ucoymjz54tN8m0Bsz38C3e
         YqBtD4VwYMOBiFVjVNKBBFSQA1oyN5/Q1pGtZfUQQ5nSefXBn3QOdqetEI5hXpIBFZbn
         cHCdiO0K5IkJwit442n1PXPPZcsimvvqCwLEiO0F8kpxern8ZuePmNB5Skrtz0dC/bGI
         LtjXyIhXJhYq+unsNPrA00jHfiz3GtcwTojiX/3Xy38OA7U/o/kWaAhAnT91zr/oUfh8
         YjvA==
X-Gm-Message-State: ACrzQf0InQQGXQwhVX8+h113XCrD8VFNN/KBI6No37f/JWFwGdhmERIF
        JnvZlkDgSrpmwrOoo+ypRnFrbw==
X-Google-Smtp-Source: AMsMyM7Cekg1+h8kwQZmQbNIic9MNo7ctZTlKHM8mYqazCWD1Ml2A1BymNo4B5jHgsiVfPmnb9DXhQ==
X-Received: by 2002:a65:408b:0:b0:42a:55fb:60b0 with SMTP id t11-20020a65408b000000b0042a55fb60b0mr34906072pgp.431.1666736696690;
        Tue, 25 Oct 2022 15:24:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n13-20020a170902d2cd00b00176ae5c0f38sm1654422plc.178.2022.10.25.15.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 15:24:55 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Al Viro <viro@zeniv.linux.org.uk>, ebiederm@xmission.com,
        eb@emlix.com
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] binfmt_elf: fix documented return value for load_elf_phdrs()
Date:   Tue, 25 Oct 2022 15:24:35 -0700
Message-Id: <166673667324.2128117.2043189489693544116.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2359389.EDbqzprbEW@mobilepool36.emlix.com>
References: <2359389.EDbqzprbEW@mobilepool36.emlix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Oct 2022 09:43:01 +0200, Rolf Eike Beer wrote:
> This function has never returned anything but a plain NULL.

Applied to for-next/execve, thanks!

[1/1] binfmt_elf: fix documented return value for load_elf_phdrs()
      https://git.kernel.org/kees/c/cfc46ca4fdca

-- 
Kees Cook

