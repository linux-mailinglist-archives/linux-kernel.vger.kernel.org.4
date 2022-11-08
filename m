Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBB4621E41
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 22:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiKHVLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 16:11:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiKHVKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 16:10:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B2F3C6EE;
        Tue,  8 Nov 2022 13:10:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DB951B81B14;
        Tue,  8 Nov 2022 21:10:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28FBDC433D6;
        Tue,  8 Nov 2022 21:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667941847;
        bh=C103BVnc6HogXMutfEawBf8A4V2X3b7IA40Tl/iPp00=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZkIPU/nBWYyqNGgAURRo8hoMmV4wzZbLYm/euRetn6cgns6Cjmp0axVhHKzO7ES6N
         dXisV31jP1B76yaIbdu4fydhlJc2dl1oZpssr0sMSMH+pClpdJTds9YJY1LDByaf5K
         b+pnTDlWan6FAEI9jd6n1+M6tiBmk8XgXoJQEvDinGsxUClsRSobelj/l1/rA8Wp+H
         /JsYBFtNC9tXrzKJiTWXDjQpweyRYRGHfiDTWzsGmCtFIbgbsfMoXrsYjo54jrLhtA
         fbLMLy+3JmXha1tvH0465xOHBkz+qEu9Yaq2HEjWBDYYNcs2aZx/vYihckVTJL4GRy
         /ky+m8bz2Nwew==
Date:   Tue, 8 Nov 2022 13:10:45 -0800
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     coverity-bot <keescook@chromium.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Miroslav Benes <mbenes@suse.cz>, linux-kernel@vger.kernel.org,
        Mikulas Patocka <mpatocka@redhat.com>,
        Borislav Petkov <bp@suse.de>, Yujie Liu <yujie.liu@intel.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: Coverity: elf_create_prefix_symbol(): Resource leaks
Message-ID: <20221108211045.hba5t63xmo3wuej7@treble>
References: <202211041232.6071ACE@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202211041232.6071ACE@keescook>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 12:32:38PM -0700, coverity-bot wrote:
> Hello!
> 
> This is an experimental semi-automated report about issues detected by
> Coverity from a scan of next-20221104 as part of the linux-next scan project:
> https://scan.coverity.com/projects/linux-next-weekly-scan
> 
> You're getting this email because you were associated with the identified
> lines of code (noted below) that were touched by commits:
> 
>   Tue Nov 1 13:44:09 2022 +0100
>     9f2899fe36a6 ("objtool: Add option to generate prefix symbols")
> 
> Coverity reported the following:
> 
> *** CID 1527141:  Resource leaks  (RESOURCE_LEAK)
> tools/objtool/elf.c:833 in elf_create_prefix_symbol()
> 827     	struct symbol *sym = calloc(1, sizeof(*sym));
> 828     	size_t namelen = strlen(orig->name) + sizeof("__pfx_");
> 829     	char *name = malloc(namelen);
> 830
> 831     	if (!sym || !name) {
> 832     		perror("malloc");
> vvv     CID 1527141:  Resource leaks  (RESOURCE_LEAK)
> vvv     Variable "sym" going out of scope leaks the storage it points to.
> 833     		return NULL;
> 834     	}
> 835
> 836     	snprintf(name, namelen, "__pfx_%s", orig->name);
> 837
> 838     	sym->name = name;
> 
> If this is a false positive, please let us know so we can mark it as
> such, or teach the Coverity rules to be smarter. If not, please make
> sure fixes get into linux-next. :) For patches fixing this, please
> include these lines (but double-check the "Fixes" first):
> 
> Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> Addresses-Coverity-ID: 1527141 ("Resource leaks")
> Fixes: 9f2899fe36a6 ("objtool: Add option to generate prefix symbols")

Please disable resource leak checking in objtool.  It's a short-lived
userspace tool for which we generally don't care about memory leaks.

-- 
Josh
