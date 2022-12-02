Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193B464103E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 22:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234717AbiLBVzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 16:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiLBVzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 16:55:37 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66EFD80CD
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 13:55:36 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id l127so5466969pfl.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 13:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t/wakp1HXP8TMhCgpZ+F2SUDPBBbIjX7REGlztKJoc8=;
        b=URC9xhK7FKnFKW8fyyyNwQXIgHH0vadxT/JEPEGuyThkxxUmSSKQHwuzHDxJWAqF9s
         Wbc2rol+II/v+G3Pk8zz//vEk6FTA1vwgJFm2+vvBSEQnyiJHrIFeWx4DEQWC7v42caI
         m6pu5bcn99GGLqDxvY+8goxri1YqH4b1pEV14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/wakp1HXP8TMhCgpZ+F2SUDPBBbIjX7REGlztKJoc8=;
        b=anHCrAAz4p2eNXfxCAd81xQTwzZU1L6im41FZUzc5+rK01WAk4zLb4ZWJiauOzF5mG
         yHDx+gdqnRs243MDkXz3vuhr9IBR9X+5lS3HsSSCWT6NL8itqIyv35BL0gYPSerMK3zP
         R4kT198who5A022avmyJ0MQxjLto0jHp6qxz1MUcU8ce2bX9zI6Ec9frkNSmXU1WLmGZ
         3j1gtE+mmHjwk2vRIeBZOI3HqnBSrlzTAZOBwEOVHvjNv8vo3Tm/HltJIYosPwU2aG5y
         /EjZUFA0J/E67xLcrXyQghGvcgooqQGwOuRqvJR4JoSey+xYn72marX9PzSnZAIM36gs
         pXqQ==
X-Gm-Message-State: ANoB5pmjdTRfhVJLPgvrybTdeYanGYWrUIsAVGBZPnszkKzM6DqgFDfv
        uzsC2BSnHxEYTg4qOfHvOlVqkg==
X-Google-Smtp-Source: AA0mqf4idAsVzzBsnh5br+mYM/h6nKbQpq33CDvgMlmnMhaTye/RDJV7RzRjHysc7BnJYEf3yB36kw==
X-Received: by 2002:a65:4c85:0:b0:46f:59bd:6125 with SMTP id m5-20020a654c85000000b0046f59bd6125mr64842218pgt.147.1670018136199;
        Fri, 02 Dec 2022 13:55:36 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a7-20020aa78e87000000b005764c8f8f07sm2130601pfr.84.2022.12.02.13.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 13:55:35 -0800 (PST)
Date:   Fri, 2 Dec 2022 13:55:34 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Liu Shixin <liushixin2@huawei.com>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binfmt_misc: fix shift-out-of-bounds in
 check_special_flags
Message-ID: <202212021352.BF39C94C@keescook>
References: <20221102025123.1117184-1-liushixin2@huawei.com>
 <Y3hpslPymEBPmZCS@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3hpslPymEBPmZCS@ZenIV>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 19, 2022 at 05:29:22AM +0000, Al Viro wrote:
> On Wed, Nov 02, 2022 at 10:51:23AM +0800, Liu Shixin wrote:
> > UBSAN reported a shift-out-of-bounds warning:
> > 
> >  left shift of 1 by 31 places cannot be represented in type 'int'
> >  Call Trace:
> >   <TASK>
> >   __dump_stack lib/dump_stack.c:88 [inline]
> >   dump_stack_lvl+0x8d/0xcf lib/dump_stack.c:106
> >   ubsan_epilogue+0xa/0x44 lib/ubsan.c:151
> >   __ubsan_handle_shift_out_of_bounds+0x1e7/0x208 lib/ubsan.c:322
> >   check_special_flags fs/binfmt_misc.c:241 [inline]
> >   create_entry fs/binfmt_misc.c:456 [inline]
> >   bm_register_write+0x9d3/0xa20 fs/binfmt_misc.c:654
> >   vfs_write+0x11e/0x580 fs/read_write.c:582
> >   ksys_write+0xcf/0x120 fs/read_write.c:637
> >   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >   do_syscall_64+0x34/0x80 arch/x86/entry/common.c:80
> >   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> >  RIP: 0033:0x4194e1
> > 
> > Since the type of Node's flags is unsigned long, we should define these
> > macros with same type too.
> 
> We are limited to 32 bits anyway.  More interesting question here is what's
> the point of having those bits that high anyway?

Hm, looks like it was designed to avoid the enum just before the
defines:

enum {Enabled, Magic};
#define MISC_FMT_PRESERVE_ARGV0 (1 << 31)
#define MISC_FMT_OPEN_BINARY (1 << 30)
#define MISC_FMT_CREDENTIALS (1 << 29)
#define MISC_FMT_OPEN_FILE (1 << 28)

But both appear to be entirely internally defined bits. I think these
can all just be part of the enum, and we can quit mixing "&" tests and
test_bit() calls:

...
        if (e->flags & MISC_FMT_OPEN_FILE)
                *dp++ = 'F';
        *dp++ = '\n';

        if (!test_bit(Magic, &e->flags)) {
                sprintf(dp, "extension .%s\n", e->magic);
...


-- 
Kees Cook
