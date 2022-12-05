Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCADF643821
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 23:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbiLEWao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 17:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233828AbiLEWah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 17:30:37 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05CBBF49
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 14:30:36 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id q17-20020a17090aa01100b002194cba32e9so16284795pjp.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 14:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ES2k5wJuZRctREsjiyUhiGb9OyDVGDDXD7SGJfpP1jQ=;
        b=i6Uw13yqFBGcuPiVXN0VWc5ozg7Z6Zebk/OzRXzynMRTiW8FAYVdHsYat9BYLZoyN4
         +1qvFvXPl4HGr11e5IW/tnZEvB7xKJKWWPmhyCblb1sC+DW/yoXxFl2CzuVVeuprUHR1
         WFG+9NWsEbcACIYRPzf9DbO0K8rtn8juuODqz5ET+m/sNU/1xzOtkyg2jQt2+3Hgjvmz
         BsCCBBedhi0EWCNmxaXmImKlW2eUdxfs5YRM5yMtK5txMCHugkSf2yqzZC5/sQNBdymb
         +/F9w2Qys4Ly9xz5ljQlDVqpHtRaE4KcEnB3U1p0nX5eI4DMEd0tkhzCQ9hE6WKKVSUh
         GflA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ES2k5wJuZRctREsjiyUhiGb9OyDVGDDXD7SGJfpP1jQ=;
        b=iipnPzkGKrWk5kFOHk2saeNWDDjWgI30d6jZ3MhSJpwjCb6fdb4w+Qn9TS+CjHiPXU
         ywcNgyybIJ2m2EN56isOlFiVSNhPTTVXRBj79wJwauiXdfX7gbvepuuqzNXk0J3lK5k3
         TQIjaEKctCg1U4y1n3YzcOlOKJqZhXuZJZHLvbrc+r1zwuPsKpOdqq0l3LUeSe2Ll1wH
         ocHbnonW940QyqxviXvsFlxqosjzxkv69ERjnC65UkTUhIGJtVvalHb3FOGkN3pUVOjv
         anqSIskYEgCLZ5VgZ7C8GmFyx1Umz7J5UxoT133L+bae+T0/ThQgBEFObwlz5nGWxFnJ
         9iNg==
X-Gm-Message-State: ANoB5pktQS1kSgYHdK0jQVFOBWtshi7w7UVAoGuvxUmtZbxVYw/lQmMl
        9QeXGvjZb5Pc8zjUdPj4UzreBAoZFmnPeQ2U
X-Google-Smtp-Source: AA0mqf403jjH6Od07domECqCLhAmdAmXlon4xMYzxQd+PtWi53Y8a1CH/kZX203Y4CwYWxNXRkiSjQ==
X-Received: by 2002:a17:90a:fd8c:b0:219:408c:a41e with SMTP id cx12-20020a17090afd8c00b00219408ca41emr39645073pjb.194.1670279436221;
        Mon, 05 Dec 2022 14:30:36 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id s3-20020a625e03000000b0056bf29c9ba3sm10650290pfb.146.2022.12.05.14.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 14:30:35 -0800 (PST)
In-Reply-To: <20221104095658.141222-1-lihuafei1@huawei.com>
References: <20221104095658.141222-1-lihuafei1@huawei.com>
Subject: Re: [PATCH 1/2] RISC-V: kexec: Fix memory leak of fdt buffer
Message-Id: <167027930833.25586.2671834159281320615.b4-ty@rivosinc.com>
Date:   Mon, 05 Dec 2022 14:28:28 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-e660e
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        kexec@lists.infradead.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     aou@eecs.berkeley.edu, liaochang1@huawei.com,
        rdunlap@infradead.org, u.kleine-koenig@pengutronix.de,
        Paul Walmsley <paul.walmsley@sifive.com>,
        lizhengyu3@huawei.com, Li Huafei <lihuafei1@huawei.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Nov 2022 17:56:57 +0800, Li Huafei wrote:
> This is reported by kmemleak detector:
> 
> unreferenced object 0xff60000082864000 (size 9588):
>   comm "kexec", pid 146, jiffies 4294900634 (age 64.788s)
>   hex dump (first 32 bytes):
>     d0 0d fe ed 00 00 12 ed 00 00 00 48 00 00 11 40  ...........H...@
>     00 00 00 28 00 00 00 11 00 00 00 02 00 00 00 00  ...(............
>   backtrace:
>     [<00000000f95b17c4>] kmemleak_alloc+0x34/0x3e
>     [<00000000b9ec8e3e>] kmalloc_order+0x9c/0xc4
>     [<00000000a95cf02e>] kmalloc_order_trace+0x34/0xb6
>     [<00000000f01e68b4>] __kmalloc+0x5c2/0x62a
>     [<000000002bd497b2>] kvmalloc_node+0x66/0xd6
>     [<00000000906542fa>] of_kexec_alloc_and_setup_fdt+0xa6/0x6ea
>     [<00000000e1166bde>] elf_kexec_load+0x206/0x4ec
>     [<0000000036548e09>] kexec_image_load_default+0x40/0x4c
>     [<0000000079fbe1b4>] sys_kexec_file_load+0x1c4/0x322
>     [<0000000040c62c03>] ret_from_syscall+0x0/0x2
> 
> [...]

Applied, thanks!

[1/2] RISC-V: kexec: Fix memory leak of fdt buffer
      https://git.kernel.org/palmer/c/96df59b1ae23
[2/2] RISC-V: kexec: Fix memory leak of elf header buffer
      https://git.kernel.org/palmer/c/cbc32023ddbd

These are on for-next.  They'd probably be fine fixes candidates had I gotten
to them in time, but it's pretty late and a leak during kexec doesn't seem like
a show-stopper.  They'll get backported anyway, but this way they get an extra
week in linux-next just to see.

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>
