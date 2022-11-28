Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A6B63B4C1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 23:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234554AbiK1WXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 17:23:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbiK1WXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 17:23:18 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F43DF94;
        Mon, 28 Nov 2022 14:23:17 -0800 (PST)
Received: from localhost (mdns.lwn.net [45.79.72.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 934CC2A0;
        Mon, 28 Nov 2022 22:23:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 934CC2A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1669674197; bh=g8xZ5Hq86pNGmIKbspglzsJBwfgaLPT3Mmoa0BOmMxs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Xtac6NDgRH+6OtE+74rPltFvlKjcgBrozSVf317lkByQAXhC2f1I3DhKb2QC1j7gH
         z7kbWSYzN1uo6zYT7yhy65J0PM9FDY8lsKI1B9mMeQuxjninzHyy5272sA2Gh08Euq
         KZ+LvWM6bkZF2CG9/MsvVa5s98gYtSEERuuniQWPqTEhs/mWdEqSYVbfe5Hkx1BBZ9
         4iK5d2t2cz/sr4C0NYELeDrJjaG3CMG+ahCWjJ2oGEjKnJp4qfe+tdVDJiF9DdKLqV
         8HG6HEYQwSHHHta2K5OZfTvwVoOnoPA/M+92ud7DY8bxUCCXv5JRK2Lia5UZV0hmAC
         /cklvX4wu+m6A==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Carlos Bilbao <carlos.bilbao@amd.com>, ojeda@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bilbao@vt.edu, Carlos Bilbao <carlos.bilbao@amd.com>
Subject: Re: [PATCH] docs: Integrate rustdoc-generated output to Rust docs
In-Reply-To: <20221128201932.168313-1-carlos.bilbao@amd.com>
References: <20221128201932.168313-1-carlos.bilbao@amd.com>
Date:   Mon, 28 Nov 2022 15:23:16 -0700
Message-ID: <87h6yi67mz.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Carlos Bilbao <carlos.bilbao@amd.com> writes:

> Include HTML output generated from rustdoc into the Linux kernel
> documentation on Rust. Add Makefile target `make htmlrust` to combine
> make htmldocs and the generation of Rust documentation.
>
> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
> ---
>  Documentation/Makefile         | 11 +++++++++++
>  Documentation/rust/index.rst   |  1 +
>  Documentation/rust/rustdoc.rst | 10 ++++++++++
>  Makefile                       |  2 +-
>  4 files changed, 23 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/rust/rustdoc.rst

Thanks for doing this.  I do have a number of comments; please let me
know if you think I'm missing something somewhere.

> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 64d44c1ecad3..02ed01fa3499 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -95,6 +95,17 @@ htmldocs:
>  	@$(srctree)/scripts/sphinx-pre-install --version-check
>  	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,html,$(var),,$(var)))
>  
> +ifdef CONFIG_RUST
> +htmlrust:
> +	@make rustavailable
> +	@make LLVM=1 rustdoc
> +	@cp -r rust/doc/* Documentation/output/
> +	@make htmldocs
> +else
> +htmlrust:
> +	@echo "Error: CONFIG_RUST must be defined (see .config)"
> +endif

First, if at all possible, the Rust documentation should just be built
along with the rest; no need for a separate make command.  We don't have
separate build commands for any other subsystem's docs, and Rust should
be a first-class citizen here too.

Second, I'm not a big fan of that "cp" command, for a couple of reasons:

- It dumps a bunch of stuff into the main output directory, which risks
  overwriting something someday.  It seems like
  Documentation/output/html/rust might be a better place.

- Rather than copying, I'd suggest changing the rustdoc command that
  generates that output to just put it in the place where it should be.
  Preferably it should work properly when people use separate build
  trees as well.

It would also be nice to set up proper dependencies so that the Rust
docs are only regenerated if something has changed.

Does this all make sense?  Sorry to come back with all this stuff...I
really do want to see this happen.

Thanks,

jon
