Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9B66ED344
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 19:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjDXRLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 13:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbjDXRLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 13:11:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9766199;
        Mon, 24 Apr 2023 10:11:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47FC162685;
        Mon, 24 Apr 2023 17:11:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A24C4339B;
        Mon, 24 Apr 2023 17:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682356293;
        bh=smjA4hS6kjat4I+K8s73W7U5nOnR31Km5dgxUUeyetQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CS70Hou3ncJvyNR23fyD381S2OkSeNAx3Zi6AkWYGkpoEjxYKDewUqlibkYeX8MiG
         EtydbevZZAfH+D7miTzn+1elb1EduaPxSo0dXMuXlZHr3Qaz1KUOlvQtEzHAwGdIGx
         Hin/1iuZifTSD2nxsU0a+/0txhzGALt8s/usoRnzNpjLmvDG/63uBES+ai4VJ7l0b0
         sSZwwj80dX/eH4tTb+nrvppleAQKh4mTDrSbXmJCF4k2QsiclJ/G4f9rzDcgssnoUm
         IDE+mCItZeoaGm6V/t88NsCmYLOkQ6sUr5W8bh4m4eNWBQw0whhkZ35+iL3YxUMLxz
         l7qEeMSQ1GPHg==
Date:   Mon, 24 Apr 2023 10:11:30 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Ruihan Li <lrh2000@pku.edu.cn>
Cc:     torvalds@linux-foundation.org, masahiroy@kernel.org, arnd@arndb.de,
        bp@alien8.de, dave.hansen@linux.intel.com, devel@acpica.org,
        lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, mingo@redhat.com, ndesaulniers@google.com,
        ojeda@kernel.org, rafael@kernel.org, robert.moore@intel.com,
        terrelln@fb.com, tglx@linutronix.de, trix@redhat.com,
        x86@kernel.org
Subject: Re: [PATCH] scripts: Remove ICC-related dead code
Message-ID: <20230424171130.GA2606535@dev-arch.thelio-3990X>
References: <20221016182349.49308-1-masahiroy@kernel.org>
 <20230424162110.11082-1-lrh2000@pku.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424162110.11082-1-lrh2000@pku.edu.cn>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 12:21:10AM +0800, Ruihan Li wrote:
> Intel compiler support has already been completely removed in commit
> 95207db8166a ("Remove Intel compiler support"). However, it appears that
> there is still some ICC-related code in scripts/cc-version.sh. There is
> no harm in leaving the code as it is, but removing the dead code makes
> the codebase a bit cleaner.
> 
> Hopefully all ICC-related stuff in the build scripts will be removed
> after this commit, given the grep output as below:
> 
> 	(linux/scripts) $ grep -i -w -R 'icc'
> 	cc-version.sh:ICC)
> 	cc-version.sh:	min_version=$($min_tool_version icc)
> 	dtc/include-prefixes/arm64/qcom/sm6350.dtsi:#include <dt-bindings/interconnect/qcom,icc.h>
> 
> Fixes: 95207db8166a ("Remove Intel compiler support")
> Signed-off-by: Ruihan Li <lrh2000@pku.edu.cn>

Thanks for the patch. I am not sure this patch really needs a fixes tag,
as I do not really think dead code is a bug (and the commit message even
mentions this), but who cares I guess? :) cleanups are always nice.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  scripts/cc-version.sh | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/scripts/cc-version.sh b/scripts/cc-version.sh
> index 0573c92e8..a7e28b6a5 100755
> --- a/scripts/cc-version.sh
> +++ b/scripts/cc-version.sh
> @@ -45,10 +45,6 @@ Clang)
>  	version=$2.$3.$4
>  	min_version=$($min_tool_version llvm)
>  	;;
> -ICC)
> -	version=$(($2 / 100)).$(($2 % 100)).$3
> -	min_version=$($min_tool_version icc)
> -	;;
>  *)
>  	echo "$orig_args: unknown C compiler" >&2
>  	exit 1
> -- 
> 2.40.0
> 
