Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE9B6172FA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 00:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbiKBXpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 19:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiKBXom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 19:44:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D3EDED7
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 16:41:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E849761CC5
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 23:41:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04BC3C433D7;
        Wed,  2 Nov 2022 23:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667432496;
        bh=Elx281auiEctWRIywMdSt+/LmUiEiXYSHJq06KjAgtI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OUHe6d1l+Sx2hhFkHr+aJpb8FBKalLQYK2ceOh2Wfo5uspChG/I0tZLw4BZi2LKXO
         tgpZ3DaOmESO54xgY43veuuTbmC7m8HLeF384mC6CP1smO+Q7OlgzY8xabhG/JaXc6
         luRElgX4kh6SBZn1+sQWlOJYMU0OniIu42WvjQ8OPaVuOu32JCJB8Gs8ta8ESKJ6oU
         hZCAIjLM64UKkcvlBKczRg/f2IE0tBduCtjzRJDOjEZP/R8aXa63jg8hOaKnuTkGbA
         WRUqI1HAOUTDGDWvQPqD7A9mKZeQOGkhmKAyB4i1CvKzupW57J1gLxS5sRMQzMTTaF
         +PqOxbK1xRKzQ==
Date:   Wed, 2 Nov 2022 16:41:34 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, djwong@kernel.org,
        yujie.liu@intel.com, tglx@linutronix.de, joao.moreira@intel.com,
        samitolvanen@google.com
Subject: Re: [PATCH 4/5] objtool: Add option to generate prefix symbols
Message-ID: <20221102234134.4rwc3uugj7hmz7cb@treble>
References: <20221028194022.388521751@infradead.org>
 <20221028194453.526899822@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221028194453.526899822@infradead.org>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 09:40:26PM +0200, Peter Zijlstra wrote:
> When code is compiled with:
> 
>   -fpatchable-function-entry=${PADDING_BYTES},${PADDING_BYTES}
> 
> functions will have PADDING_BYTES of NOP in front of them. Unwinders
> and other things that symbolize code locations will typically
> attribute these bytes to the preceding function.
> 
> Given that these bytes nominally belong to the following symbol this
> mis-attribution is confusing.
> 
> Inspired by the fact that CFI_CLANG emits __cfi_##name symbols to
> claim these bytes, allow objtool to emit __pfx_##name symbols to do
> the same.
> 
> Therefore add the objtool --prefix=N argument, to conditionally place
> a __pfx_##name symbol at N bytes ahead of symbol 'name' when: all
> these preceding bytes are NOP and name-N is an instruction boundary.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  tools/objtool/builtin-check.c           |    1 +
>  tools/objtool/check.c                   |   27 +++++++++++++++++++++++++++
>  tools/objtool/elf.c                     |   30 ++++++++++++++++++++++++++++++
>  tools/objtool/include/objtool/builtin.h |    1 +
>  tools/objtool/include/objtool/elf.h     |    2 ++
>  5 files changed, 61 insertions(+)
> 
> --- a/tools/objtool/builtin-check.c
> +++ b/tools/objtool/builtin-check.c
> @@ -75,6 +75,7 @@ const struct option check_options[] = {
>  	OPT_BOOLEAN('r', "retpoline", &opts.retpoline, "validate and annotate retpoline usage"),
>  	OPT_BOOLEAN(0,   "rethunk", &opts.rethunk, "validate and annotate rethunk usage"),
>  	OPT_BOOLEAN(0,   "unret", &opts.unret, "validate entry unret placement"),
> +	OPT_INTEGER(0,   "prefix", &opts.prefix, "generate prefix symbols"),

"generate prefix symbols for function padding with size 'n' bytes" ?

-- 
Josh
