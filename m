Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C66E65658A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 23:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbiLZWmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 17:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbiLZWmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 17:42:11 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459E4273F
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 14:41:57 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0959720DF9;
        Mon, 26 Dec 2022 22:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1672094513; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+3lTW8ppgkCOp0GPcOsAwQlom3Z3C11B2XXX3v40pes=;
        b=bBNQjL4nZkVxtePpM0w/TOnQkaE3jmnN30jHrd4zG/W4M1fUAHxKjLNrnZw8AHBl93ed6B
        dqbSVnp4UrJL42a3JXkZ1399V4Sd2gR6MBfTwxCTBtluHPp1sJfE+rZWpAtar5DTQ4l+8K
        ZVSUx4kI1aeM9UonvT7EHDqtEWGdFUA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1672094513;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+3lTW8ppgkCOp0GPcOsAwQlom3Z3C11B2XXX3v40pes=;
        b=aLmjKm3Fl7SqWyexfOjYSsrLVYUC/5kmZPACaJZ4RdcRRZT4gSQMiP6alJBhuSH5wIgfNU
        j+/cc8EpnGgIkcBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C8FAC13456;
        Mon, 26 Dec 2022 22:41:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JBHwLzAjqmPJRgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 26 Dec 2022 22:41:52 +0000
Message-ID: <abeeda98-e6ed-fb88-f838-6b61d43e07e5@suse.cz>
Date:   Mon, 26 Dec 2022 23:41:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Linux 6.2-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Marco Elver <elver@google.com>
References: <CAHk-=wgf929uGOVpiWALPyC7pv_9KbwB2EAvQ3C4woshZZ5zqQ@mail.gmail.com>
 <20221226195206.GA2626419@roeck-us.net>
 <CAHk-=whD1zMyt4c7g6-+tWvVweyb-6oHMT_+ZVHqe1EXwtFpCQ@mail.gmail.com>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAHk-=whD1zMyt4c7g6-+tWvVweyb-6oHMT_+ZVHqe1EXwtFpCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/26/22 21:56, Linus Torvalds wrote:
> On Mon, Dec 26, 2022 at 11:52 AM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> fs/f2fs/inline.c: In function 'f2fs_move_inline_dirents':
>> include/linux/fortify-string.h:59:33: error: '__builtin_memset' pointer overflow between offset [28, 898293814] and size [-898293787, -1] [-Werror=array-bounds]
>> fs/f2fs/inline.c:430:9: note: in expansion of macro 'memset'
>>   430 |         memset(dst.bitmap + src.nr_bitmap, 0, dst.nr_bitmap - src.nr_bitmap);
>>       |         ^~~~~~
> 
> Well, that's unfortunate.
> 
>> kernel/kcsan/kcsan_test.c: In function '__report_matches':
>> kernel/kcsan/kcsan_test.c:257:1: error: the frame size of 1680 bytes is larger than 1536 bytes
>>
>> Bisect for both points to commit e240e53ae0abb08 ("mm, slub: add
>> CONFIG_SLUB_TINY").  Reverting it on its own is not possible, but
>> reverting the following two patches fixes the problem.
>>
>> 149b6fa228ed mm, slob: rename CONFIG_SLOB to CONFIG_SLOB_DEPRECATED
>> e240e53ae0ab mm, slub: add CONFIG_SLUB_TINY
> 
> No, I think CONFIG_SLUB_TINY should probably have a
> 
>      depends on !COMPILE_TEST
> 
> or something like that instead.

We can do that, although if things are on track to be fixed, maybe it's
unnecessary?

> It already has a
> 
>         depends on SLUB && EXPERT
> 
> which is basically supposed to disable it for any normal builds, but
> obviously allmodconfig will enable EXPERT etc anyway.
> 
> That said, that f2fs case also sounds like this code triggers the
> compiler being unhappy, so it might be worth having some clarification
> from the f2fs people.
> 
> I'm not sure what triggers that problem just on powerpc, and only with
> that CONFIG_SLUB_TINY option. Maybe those make_dentry_ptr_inline() and

I think it's because e240e53ae0ab makes KASAN depend on !SLUB_TINY, because
KASAN does "select SLUB_DEBUG" which depends on !SLUB_TINY; but kconfig will
still honor the select even with dependencies unmet and only warn about it
(and the build would fail) so I prevented it this way. (maybe instead
SLUB_TINY depend on !KASAN would have worked better in retrospect?) So now
allmodconfig will have SLUB_TINY enabled and KASAN thus disabled.

On the other hand there are configs like KCSAN and KMSAN that depend on
!KASAN, so with KASAN disabled, now those become enabled. KCSAN becoming
enabled would be relevant for the xtensa problem. For the powerpc issue I'm
not sure as the macro expansion lines for include/linux/fortify-string.h in
Guenter's report make no sense in my 6.2-rc1 checkout for some reason. But
the header does test for KASAN and KMSAN at several points, to perhaps it's
also related to that?

> make_dentry_ptr_block() functions don't get inlined in that case, and
> that then makes gcc not see the values for those bitmap sizes?
> 
> Does changing the "inline" to "always_inline" perhaps fix the compiler
> unpahhiness too?
> 

