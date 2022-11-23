Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65906634CF2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 02:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235300AbiKWBbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 20:31:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233984AbiKWBa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 20:30:59 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63CB8E084
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 17:30:58 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id v28so15976075pfi.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 17:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DKO5lR4cLz6p7NWkfnd0y6rPCWBH2+knxhaYnv/yN7g=;
        b=NXD0++W1grzconoV0x+G2IAlIiJtVCOGTMBnUhvmAstsMhj6jtOs7BcAJGgKzdSGxJ
         6WRKCQPUQQdVSYMLLzc9pngh3MZKR8YrFD8d/E9qcP1+rhgI4WqDBdm04K8qAIi5/dCs
         l/OF72+iUkIrkggctoMI3+D8SQLzptPdnkw+nsDBb4TjXNCOUZkK4+AEHFZDAycjlOeW
         mSZqXSpomAhvM2koEPenAJbEQl7m64YkqH7+NoPou3o3g13CGO3qQd3jpsYENN9pD+95
         KZWGcbJIpU5W+68tUnqzWFjs0R7CLIucsBRjr7AHpne6oOJ+/xKUwsr2KtjsxZjhRTVc
         Zt7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DKO5lR4cLz6p7NWkfnd0y6rPCWBH2+knxhaYnv/yN7g=;
        b=pXdYwx1VFCwCG5Zy5FyYsZv3BkVQ7kKxGZNzOlSAM9M3FrDHDYMFpwalkTGxyq/WPc
         lrV684tbQBXLwl58JjkdLKnM3Jz46omkVX0ZM8d/o6SD1Wg69r5bU4KQYrNgqwsQ34eW
         uW2WjyEXFPS403fDNUgykC+c5h+NLqjSXeq4dMTmvI/Q7v8efEbzmGP1VyBr6EzD8Cxr
         7im204IPGfSIuHSRTjBvpYqYGiTc5ZH7OojnZlbSRoaFC400RVhkh/35op8c3PPUnLWz
         gbRXZUk5BcsS71I7xp8kSWByJPGL4egGJJqO1YJtWJQwVYqawo5Ik9vVddO5Yl2l0pao
         4iRQ==
X-Gm-Message-State: ANoB5pmt1NNix2PowTUsMj/e1xUKSJZxtcscUrdLX/2CZTKCcHJRzEcR
        mTW6tFA8w2iYFhpcYa7Un/AF0w==
X-Google-Smtp-Source: AA0mqf7QekbcagrdW2ZDZzvV7seCNJVnDeErvb+ZQk78iSZep5oGbGV2XKOj4eOZEI3kIJGB0bxSpg==
X-Received: by 2002:a05:6a00:1a14:b0:572:5be2:505b with SMTP id g20-20020a056a001a1400b005725be2505bmr6959442pfv.52.1669167058288;
        Tue, 22 Nov 2022 17:30:58 -0800 (PST)
Received: from [2620:15c:29:203:2520:fc16:115d:2f43] ([2620:15c:29:203:2520:fc16:115d:2f43])
        by smtp.gmail.com with ESMTPSA id r8-20020a170902be0800b00176e6f553efsm12647970pls.84.2022.11.22.17.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 17:30:57 -0800 (PST)
Date:   Tue, 22 Nov 2022 17:30:57 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Kees Cook <keescook@chromium.org>
cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-mm@kvack.org, kasan-dev@googlegroups.com,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] mm: Make ksize() a reporting-only function
In-Reply-To: <20221118035656.gonna.698-kees@kernel.org>
Message-ID: <d49df494-7c42-1d2a-97c8-62972c0d6c03@google.com>
References: <20221118035656.gonna.698-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Nov 2022, Kees Cook wrote:

> With all "silently resizing" callers of ksize() refactored, remove the
> logic in ksize() that would allow it to be used to effectively change
> the size of an allocation (bypassing __alloc_size hints, etc). Users
> wanting this feature need to either use kmalloc_size_roundup() before an
> allocation, or use krealloc() directly.
> 
> For kfree_sensitive(), move the unpoisoning logic inline. Replace the
> some of the partially open-coded ksize() in __do_krealloc with ksize()
> now that it doesn't perform unpoisoning.
> 
> Adjust the KUnit tests to match the new ksize() behavior.
> 
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Cc: linux-mm@kvack.org
> Cc: kasan-dev@googlegroups.com
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: David Rientjes <rientjes@google.com>
