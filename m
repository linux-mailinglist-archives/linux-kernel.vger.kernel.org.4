Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2CC641049
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 22:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234799AbiLBV6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 16:58:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233561AbiLBV6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 16:58:34 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F2AF4EB7
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 13:58:33 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id k79so6101861pfd.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 13:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8yjeqd6Koufe4qTZvRhQnhZFfJ1y5qbmqZ7QZG+tZQU=;
        b=ivPcOYRK1NdgChB66zDMvb7VWcDjKkliBxnnUq6YWmj8wckt4Pb4FG87vPB66UKOgv
         xv8mVe6PnQdADgDRE7YQHIBvedXy5bpLa0HSdOjOTNBBq/YgT3mkO8CvA8tmf/cpUVkZ
         gHNVQu0qhiaEhbzzG/+nBGT3f+FgCcjAVhXGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8yjeqd6Koufe4qTZvRhQnhZFfJ1y5qbmqZ7QZG+tZQU=;
        b=hzJKgCPPZjEAqIZrzP2vZsqqop+euD+MumQB/vYApj3IOc9rPT+4FhUrq/r35qlvVS
         l4013RjdmR8XN4U59Ez7N4sF+hHZJGLJXYlb/prcVW4bkCovFlebgZPA263mBP/dnO0d
         GQPzELXKlGjoSJ2UYKroBiyoiKurcBG3uhwnMO8Sja1LfDy0cyZDUpoglnfD+rmuF3LL
         GrZBjxGiwDwcvuy291bj7+HqKdRqS1nNPciwiELG1lA2xqZWQNvIuXdVHyIHBaNkwIyH
         FN7bAuJ8PgfTNxNSmDnPnoFwpOiqe2FVKabt+OMfdPzQaeUjLENNLru7kXpUhaueMJd0
         5gUA==
X-Gm-Message-State: ANoB5pkfKxMJkxMALkhfD6r14FyXhuT+StVgwfrpJbzOZ8GHCHrjIAUD
        LXTh1HoX0fgXhSSQT6RAzsVRDA==
X-Google-Smtp-Source: AA0mqf5o0/pBvKgXcn0gxFd+v3J2yNrQJfZEbKNpSgG+xOC0q9SqNnXxMtCCE/dwQQkrAwC5dH9Sxw==
X-Received: by 2002:aa7:8d8f:0:b0:56b:b112:4a16 with SMTP id i15-20020aa78d8f000000b0056bb1124a16mr77220595pfr.66.1670018313432;
        Fri, 02 Dec 2022 13:58:33 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 32-20020a17090a09a300b00212735c8898sm7026718pjo.30.2022.12.02.13.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 13:58:32 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     ebiederm@xmission.com, liushixin2@huawei.com,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Kees Cook <keescook@chromium.org>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binfmt_misc: fix shift-out-of-bounds in check_special_flags
Date:   Fri,  2 Dec 2022 13:58:29 -0800
Message-Id: <167001830861.1882545.11740816202645494659.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221102025123.1117184-1-liushixin2@huawei.com>
References: <20221102025123.1117184-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Nov 2022 10:51:23 +0800, Liu Shixin wrote:
> UBSAN reported a shift-out-of-bounds warning:
> 
>  left shift of 1 by 31 places cannot be represented in type 'int'
>  Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:88 [inline]
>   dump_stack_lvl+0x8d/0xcf lib/dump_stack.c:106
>   ubsan_epilogue+0xa/0x44 lib/ubsan.c:151
>   __ubsan_handle_shift_out_of_bounds+0x1e7/0x208 lib/ubsan.c:322
>   check_special_flags fs/binfmt_misc.c:241 [inline]
>   create_entry fs/binfmt_misc.c:456 [inline]
>   bm_register_write+0x9d3/0xa20 fs/binfmt_misc.c:654
>   vfs_write+0x11e/0x580 fs/read_write.c:582
>   ksys_write+0xcf/0x120 fs/read_write.c:637
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x34/0x80 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
>  RIP: 0033:0x4194e1
> 
> [...]

Applied to for-next/execve, thanks!

[1/1] binfmt_misc: fix shift-out-of-bounds in check_special_flags
      https://git.kernel.org/kees/c/6a46bf558803

-- 
Kees Cook

