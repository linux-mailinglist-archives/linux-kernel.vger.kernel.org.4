Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49632629A65
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 14:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbiKONbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 08:31:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238130AbiKONbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 08:31:25 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BA3DFC5;
        Tue, 15 Nov 2022 05:31:24 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E57021F8C7;
        Tue, 15 Nov 2022 13:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668519082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6S/6qWoM9bvr/F9wymPHSwbtM7nJIyGIcCGcRNv81bo=;
        b=nRc2e39ELC7qec2QCbcBqak9znvCwWEA8u/ClgripvGSL3uCRohkLqqN4LZb/WbGYdn1yG
        lIg5pSeJLRmmiAGEmWBcXnKTp/eEXExg6sNDynNQTc6jT94JA84Ud6wzEhRHgVhe6Arz/g
        gszY/XtI64D+weNiedTmNo9bTFFXogE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668519082;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6S/6qWoM9bvr/F9wymPHSwbtM7nJIyGIcCGcRNv81bo=;
        b=TyVcir2l7dmmsK0P0RXY3Ts8NnEqnyvECLb0kSHuhsVbIksp9rtl1mDSiwsNmIZe8gsPM2
        qYAnPc36x++uuUAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8D62213273;
        Tue, 15 Nov 2022 13:31:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id F8OlIKqUc2MRZQAAMHmgww
        (envelope-from <mliska@suse.cz>); Tue, 15 Nov 2022 13:31:22 +0000
Message-ID: <858176b3-a70e-01ce-4a56-96cb031f16c5@suse.cz>
Date:   Tue, 15 Nov 2022 14:31:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 30/46] Kbuild, lto: Add Link Time Optimization support
Content-Language: en-US
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, Richard Biener <RGuenther@suse.com>,
        Jan Hubicka <jh@suse.de>, "H . J . Lu" <hjl.tools@gmail.com>,
        Don Zickus <dzickus@redhat.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jiri Slaby <jslaby@suse.cz>
References: <20221114114344.18650-1-jirislaby@kernel.org>
 <20221114114344.18650-31-jirislaby@kernel.org>
 <20221114185545.yobf3faky2njugfq@treble>
From:   =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
In-Reply-To: <20221114185545.yobf3faky2njugfq@treble>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/22 19:55, Josh Poimboeuf wrote:
> On Mon, Nov 14, 2022 at 12:43:28PM +0100, Jiri Slaby (SUSE) wrote:
>> +++ b/Documentation/kbuild/lto-build.rst
>> @@ -0,0 +1,76 @@
>> +=====================================================
>> +gcc link time optimization (LTO) for the Linux kernel
>> +=====================================================
>> +
>> +Link Time Optimization allows the compiler to optimize the complete program
>> +instead of just each file.
>> +
>> +The compiler can inline functions between files and do various other global
>> +optimizations, like specializing functions for common parameters,
>> +determing when global variables are clobbered, making functions pure/const,
>> +propagating constants globally, removing unneeded data and others.
>> +
>> +It will also drop unused functions which can make the kernel
>> +image smaller in some circumstances, in particular for small kernel
>> +configurations.
>> +
>> +For small monolithic kernels it can throw away unused code very effectively
>> +(especially when modules are disabled) and usually shrinks
>> +the code size.
>> +
>> +Build time and memory consumption at build time will increase, depending
>> +on the size of the largest binary. Modular kernels are less affected.
>> +With LTO incremental builds are less incremental, as always the whole
>> +binary needs to be re-optimized (but not re-parsed)
>> +
>> +Oopses can be somewhat more difficult to read, due to the more aggressive
>> +inlining: it helps to use scripts/faddr2line.
>> +
>> +It is currently incompatible with live patching.
> 
> ... because ?

There's no fundamental reason why live patching can't coexist with -flto.

We removed the sorry message for GCC 13.1 release:
https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=1a308905c1baf64d0ea4d09d7d92b55e79a2a339
when it comes to -flive-patching=inline-clone option.

But it seems Linux does not utilize the option (based on git grep):
https://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html#index-flive-patching

That said, I would remove this limitation as LTO can make creation of live patches
more complicated, but fundamentally there's no barrier.

Thanks,
Martin
