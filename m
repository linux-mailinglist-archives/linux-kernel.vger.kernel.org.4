Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4884E5EC0F4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbiI0LUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbiI0LUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:20:04 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93776BC3C
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 04:19:33 -0700 (PDT)
Received: from quatroqueijos.cascardo.eti.br (unknown [187.74.47.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 9C82F3F5D7;
        Tue, 27 Sep 2022 11:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1664277571;
        bh=AA6G+IEo7QP4LnD5kieh7vzYEn3vdQ7EcMpY5MsH8Z0=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=ewLOdU6QwF8RN38uE1ezSAaQxmWeMLzvD07eTYNpRahRDB5eki4tmKe+axMboxhaW
         FBSdIyJLgPiGQIAMg5MzRWf9qgQ0RoL8Je9yHUZmYdmExoRYzBwGpPfSF+5kX3LRvN
         N1xeDs/y/DlHxNWY57eTuJV1pywCWbJOmHW0r+EAfzCi9lr6arOSA+lggJ2FxTxGKf
         cRkI8ymxSGN7aq+mDbeBxzBQSdO8GwlGpooEHk6G5RydTFNseo5SoxKEjoArh8e55v
         dcTNaoCgAhStfFi1ZPs0E9pH5RkkesYZsjWmdEsrNYKqSxWMVTA+OA1cLoQW75/5IR
         lluJDUtrQwQPA==
Date:   Tue, 27 Sep 2022 08:19:25 -0300
From:   Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] scripts/faddr2line: Fix regression in name resolution on
 ppc64le
Message-ID: <YzLcPZYTWXfrU+K4@quatroqueijos.cascardo.eti.br>
References: <20220927075211.897152-1-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927075211.897152-1-srikar@linux.vnet.ibm.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 01:22:11PM +0530, Srikar Dronamraju wrote:
> Commit 1d1a0e7c5100 ("scripts/faddr2line: Fix overlapping text section failures")
> can cause scripts/faddr2line to fail on ppc64le machines on few
> distributions, while working on other distributions. The failure can be
> attributed to difference in readelf output on various distributions.
> 
> $ ./scripts/faddr2line vmlinux find_busiest_group+0x00
> no match for find_busiest_group+0x00
> 
> Expected output was:
> $ ./scripts/faddr2line vmlinux find_busiest_group+0x00
> find_busiest_group+0x00/0x3d0:
> find_busiest_group at kernel/sched/fair.c:9595
> 
> On ppc64le, readelf adds localentry tag before the symbol name on few
> distributions and adds the localentry tag after the symbol name on few
> other distributions. This problem has been discussed in the reference
> URL given below. This problem can be overcome by filtering out
> localentry tags in readelf output. Similar fixes are already present in
> kernel by way of commits:
> 
> 1fd6cee127e2 ("libbpf: Fix VERSIONED_SYM_COUNT number parsing")
> aa915931ac3e ("libbpf: Fix readelf output parsing for Fedora")
> 
> Fixes: 1d1a0e7c5100 ("scripts/faddr2line: Fix overlapping text section failures")
> Reference: https://lore.kernel.org/bpf/20191211160133.GB4580@calabresa/
> Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>

Reviewed-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>

The other instances of readelf --wide on faddr2line use --section-headers and
should not required the same mangling.

Cascardo.

> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
> Cc: LKML <linux-kernel@vger.kernel.org>
> Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> ---
>  scripts/faddr2line | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/faddr2line b/scripts/faddr2line
> index 5514c23f45c2..0e73aca4f908 100755
> --- a/scripts/faddr2line
> +++ b/scripts/faddr2line
> @@ -74,7 +74,8 @@ command -v ${ADDR2LINE} >/dev/null 2>&1 || die "${ADDR2LINE} isn't installed"
>  find_dir_prefix() {
>  	local objfile=$1
>  
> -	local start_kernel_addr=$(${READELF} --symbols --wide $objfile | ${AWK} '$8 == "start_kernel" {printf "0x%s", $2}')
> +	local start_kernel_addr=$(${READELF} --symbols --wide $objfile | sed 's/\[.*\]//' |
> +		${AWK} '$8 == "start_kernel" {printf "0x%s", $2}')
>  	[[ -z $start_kernel_addr ]] && return
>  
>  	local file_line=$(${ADDR2LINE} -e $objfile $start_kernel_addr)
> @@ -178,7 +179,7 @@ __faddr2line() {
>  				found=2
>  				break
>  			fi
> -		done < <(${READELF} --symbols --wide $objfile | ${AWK} -v sec=$sym_sec '$7 == sec' | sort --key=2)
> +		done < <(${READELF} --symbols --wide $objfile | sed 's/\[.*\]//' | ${AWK} -v sec=$sym_sec '$7 == sec' | sort --key=2)
>  
>  		if [[ $found = 0 ]]; then
>  			warn "can't find symbol: sym_name: $sym_name sym_sec: $sym_sec sym_addr: $sym_addr sym_elf_size: $sym_elf_size"
> @@ -259,7 +260,7 @@ __faddr2line() {
>  
>  		DONE=1
>  
> -	done < <(${READELF} --symbols --wide $objfile | ${AWK} -v fn=$sym_name '$4 == "FUNC" && $8 == fn')
> +	done < <(${READELF} --symbols --wide $objfile | sed 's/\[.*\]//' | ${AWK} -v fn=$sym_name '$4 == "FUNC" && $8 == fn')
>  }
>  
>  [[ $# -lt 2 ]] && usage
> 
> base-commit: bf682942cd26ce9cd5e87f73ae099b383041e782
> -- 
> 2.31.1
> 
