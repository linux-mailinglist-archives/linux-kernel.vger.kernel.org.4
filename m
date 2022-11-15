Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28246628E29
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 01:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237481AbiKOASm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 19:18:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236635AbiKOASk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 19:18:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932E263E8;
        Mon, 14 Nov 2022 16:18:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4BEF7B810A8;
        Tue, 15 Nov 2022 00:18:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99199C433B5;
        Tue, 15 Nov 2022 00:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668471516;
        bh=UOGQoyCKo3XNkKtnl9+sB+VRkl2mOKRXguX0iYW8nF4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Phk0ny7PLtgAY/27DqHyuSCbkvRq9nxNcOzVv1jkFxv9OW74Y5xineUT+Os1KyjJS
         DnNAmYfuVZuvBzVyMWlWIVs4ai2JQpjsQP8+5fhjsw59XYmKKIHU0pjDS09EWWK7sJ
         2xueWCMpWlWSIFbHFumqxXzj4K25Ks7hrWKVJJOVjxmNZT4l7msYhV2Bc7evhmgvuB
         QXJ08gfIdrWcr/PdoQRGyiW6o2FGjr1EES4W/il48Bv7GHk93SI/aEAJqso8wCNQlT
         AFs1Xm+zNnSur8kx7mMkdLl5vEL0naWnVI/PClKZbEkUHyLGsAmZ6PUeQLxqR7Bhbc
         gwdYlLO6QE68Q==
Date:   Mon, 14 Nov 2022 17:18:34 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kbuild: revive parallel execution for .tmp_initcalls.lds
 rule
Message-ID: <Y3La2mwCgD8r/5PI@dev-arch.thelio-3990X>
References: <20221114174617.211980-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221114174617.211980-1-masahiroy@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 02:46:17AM +0900, Masahiro Yamada wrote:
> Prior to commit 5d45950dfbb1 ("kbuild: move vmlinux.o link to
> scripts/Makefile.vmlinux_o"), jobserver-exec was invoked from the shell
> script, link-vmlinux.sh. It can get access to the jobserver because
> Makefile adds '+' prefix, as in:
> 
>     +$(call if_changed_dep,link_vmlinux)
> 
> Since 5d45950dfbb1, jobserver-exec is invoked from Makefile, but the
> '+' prefix is missing, hence jobserver-exec has no access to the
> jobserver.
> 
> Fixes: 5d45950dfbb1 ("kbuild: move vmlinux.o link to scripts/Makefile.vmlinux_o")
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

At least it doesn't seem like compile times were majorly affected. I
benchmarked arm64 allmodconfig (worst case scenario with ThinLTO):

Benchmark 1: 094226ad94f4 ("Linux 6.1-rc5")
  Time (mean ± σ):     899.036 s ±  1.133 s    [User: 49314.495 s, System: 3840.796 s]
  Range (min … max):   898.118 s … 900.302 s    3 runs

Benchmark 2: 0f45cbb5399b ("kbuild: revive parallel execution for .tmp_initcalls.lds rule")
  Time (mean ± σ):     898.482 s ±  0.152 s    [User: 49329.703 s, System: 3836.408 s]
  Range (min … max):   898.306 s … 898.584 s    3 runs

Summary
  '0f45cbb5399b ("kbuild: revive parallel execution for .tmp_initcalls.lds rule")' ran
    1.00 ± 0.00 times faster than '094226ad94f4 ("Linux 6.1-rc5")'

> ---
> 
>  scripts/Makefile.vmlinux_o | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/Makefile.vmlinux_o b/scripts/Makefile.vmlinux_o
> index 0edfdb40364b..ae52d3b3f063 100644
> --- a/scripts/Makefile.vmlinux_o
> +++ b/scripts/Makefile.vmlinux_o
> @@ -19,7 +19,7 @@ quiet_cmd_gen_initcalls_lds = GEN     $@
>  
>  .tmp_initcalls.lds: $(srctree)/scripts/generate_initcall_order.pl \
>  		vmlinux.a $(KBUILD_VMLINUX_LIBS) FORCE
> -	$(call if_changed,gen_initcalls_lds)
> +	+$(call if_changed,gen_initcalls_lds)
>  
>  targets := .tmp_initcalls.lds
>  
> -- 
> 2.34.1
> 
