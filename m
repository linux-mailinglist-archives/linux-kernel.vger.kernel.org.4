Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B737669CBA4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 14:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbjBTNKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 08:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbjBTNKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 08:10:35 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611B01CAE2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 05:10:29 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id eg37so685759edb.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 05:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=JYMrPsjykRPhmLbo9HjwMzJ9AhaI0qU7QxL4YH1ZCP0=;
        b=LEjMBRNxiZ4nDetu3PBn6CdFwJxfgQS7C7IjeijkYwrLRsZR6AAlGnoJGljv9oevpe
         LMYFD8iil6JAkwMTUZiAM3yoc2CL3TpVV4roUGxo+wkSq8i2VkZdNZSUfLlI0wQ0xVZB
         KIuEGrEb1mUpxXeT3FrP9BXKNcKF6msXsNDB+ihc5WxL05t6ZOoiJ6B8fUxn3nTn6PK/
         w38whXrtlLQ/SqtgQDvZjS7hEwrum6XJHKChLuoItwu+77SCa4hXWkKwsfSjxkSaSS/C
         dCZFfVt70ylie5NPY9jLwFrAiWd6dj26UevNJqlAMtZBhnN7Iy9xptMXM5LBLNFg+31V
         BB8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JYMrPsjykRPhmLbo9HjwMzJ9AhaI0qU7QxL4YH1ZCP0=;
        b=IjIg5POrttEyyhDwqF4NfSlxYbEhuzkLPQrJy6R04zMTXX4u4yep9Kxw1qc67JTjby
         19ACjYorUUJGxEtP1ZWZpSDcBS45b9zlx2DVNNXz/pnAwbGaqGaFK6cBW2Wg4fzuaUkj
         AmaMVHPFTc4Q56KA00PeYF5tjCspYJ+4hTW6J1CVdzaqdrY59iNMCxjxJmpsfFyJ7X/n
         bD1hdo9f3FhzT+/giSvfeqz2xU/UOVQmdSiYNCYu+DC8yKvhJU/HK3EYIdH8NVosw03h
         5PPwBb5KyillUByZ4GYZF70HLif2goO4UMeyWDyI6W2u4c60AXRT3vI3fg8VvOV43d0n
         PWMw==
X-Gm-Message-State: AO0yUKWedzERfMlDxv54rqd/WMBV4cRbChFscOPYqD1LpclrjSPhmOAx
        5lVJ+SjWG5ZS+IBUsaXPgEE=
X-Google-Smtp-Source: AK7set/tnZNmeqH85i/opPsmzx66FcdgvMUGmmrsiIUMS/xAOsg+tvq36p7NkrEprgLuuvveIQcxiQ==
X-Received: by 2002:a17:907:10c3:b0:8b1:bafe:6135 with SMTP id rv3-20020a17090710c300b008b1bafe6135mr10310968ejb.60.1676898627929;
        Mon, 20 Feb 2023 05:10:27 -0800 (PST)
Received: from gmail.com (1F2EF163.nat.pool.telekom.hu. [31.46.241.99])
        by smtp.gmail.com with ESMTPSA id rh16-20020a17090720f000b008b6aea4738esm3915991ejb.42.2023.02.20.05.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 05:10:27 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 20 Feb 2023 14:10:25 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/boot changes for v6.3
Message-ID: <Y/NxQfkj3P7DOBWl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86/boot git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-boot-2023-02-20

   # HEAD: e2869bd7af608c343988429ceb1c2fe99644a01f x86/acpi/boot: Do not register processors that cannot be onlined for x2APIC

Changes in this cycle:

 - Robustify/fix calling startup_{32,64}() from the decompressor code,
   and removing x86 quirk from scripts/head-object-list.txt as
   a result.

 - Do not register processors that cannot be onlined for x2APIC

 Thanks,

	Ingo

------------------>
Alexander Lobakin (2):
      x86/boot: Robustify calling startup_{32,64}() from the decompressor code
      scripts/head-object-list: Remove x86 from the list

Kishon Vijay Abraham I (1):
      x86/acpi/boot: Do not register processors that cannot be onlined for x2APIC


 arch/x86/boot/compressed/head_32.S |  2 +-
 arch/x86/boot/compressed/head_64.S |  2 +-
 arch/x86/boot/compressed/misc.c    | 18 +++++++++++-------
 arch/x86/kernel/acpi/boot.c        | 19 ++++++++++++++++---
 scripts/head-object-list.txt       |  6 ------
 5 files changed, 29 insertions(+), 18 deletions(-)
