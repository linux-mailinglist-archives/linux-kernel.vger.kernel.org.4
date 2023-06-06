Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6130B723933
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 09:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236345AbjFFHkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 03:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236280AbjFFHkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 03:40:06 -0400
X-Greylist: delayed 431 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 06 Jun 2023 00:40:03 PDT
Received: from mail.avm.de (mail.avm.de [212.42.244.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7903C118;
        Tue,  6 Jun 2023 00:40:03 -0700 (PDT)
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
        by mail.avm.de (Postfix) with ESMTPS;
        Tue,  6 Jun 2023 09:30:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
        t=1686036606; bh=Y1ukHoy8le+G2IITrKjxsRBoOvxabu3D5WQ/gt83/rM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r4gPdgljPlw8eolOY8//ldbHIOHnN/IoErbwiUiLN5rIRfPMTR5MsWQpPuUM2MKSn
         LBfjkTq6zDBgoJyHiLZyKGiVuw1swVXcDuqHk8tB19FlLnHlHx4RLk5nD8EQteaXb2
         yYIStY4uy5csba61xiiLKIOWPhZvViqHEZEce1N0=
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
        by mail-auth.avm.de (Postfix) with ESMTPA id 318EF821D4;
        Tue,  6 Jun 2023 09:30:06 +0200 (CEST)
Received: by buildd.core.avm.de (Postfix, from userid 1000)
        id 245D0181737; Tue,  6 Jun 2023 09:30:06 +0200 (CEST)
Date:   Tue, 6 Jun 2023 09:30:06 +0200
From:   Nicolas Schier <n.schier@avm.de>
To:     Benjamin Gray <bgray@linux.ibm.com>
Cc:     masahiroy@kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, Andrew Donnellan <ajd@linux.ibm.com>
Subject: Re: [PATCH v2] initramfs: Encode dependency on KBUILD_BUILD_TIMESTAMP
Message-ID: <ZH7gfjJYRezoj+AS@buildd.core.avm.de>
References: <20230606061741.69755-1-bgray@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230606061741.69755-1-bgray@linux.ibm.com>
X-purgate-ID: 149429::1686036605-FE7EAD8E-515F9AEB/0/0
X-purgate-type: clean
X-purgate-size: 3295
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 04:17:41PM +1000, Benjamin Gray wrote:
> gen_initramfs.sh has an internal dependency on KBUILD_BUILD_TIMESTAMP
> for generating file mtimes that is not exposed to make, so changing
> KBUILD_BUILD_TIMESTAMP will not trigger a rebuild of the archive.
> 
> Declare the mtime date as a new parameter to gen_initramfs.sh to encode
> KBUILD_BUILD_TIMESTAMP in the shell command, thereby making make aware
> of the dependency.
> 
> It will rebuild if KBUILD_BUILD_TIMESTAMP changes or is newly set/unset.
> It will _not_ rebuild if KBUILD_BUILD_TIMESTAMP is unset before and
> after. This should be fine for anyone who doesn't care about setting
> specific build times in the first place.
> 
> Reviewed-by: Andrew Donnellan <ajd@linux.ibm.com>
> Tested-by: Andrew Donnellan <ajd@linux.ibm.com>
> Signed-off-by: Benjamin Gray <bgray@linux.ibm.com>
> 
> ---
> 
> v2: Remove redundant comment, quote argument to shell script
> ---

Reviewed-by: Nicolas Schier <n.schier@avm.de>


>  usr/Makefile         |  1 +
>  usr/gen_initramfs.sh | 16 +++++++++-------
>  2 files changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/usr/Makefile b/usr/Makefile
> index 59d9e8b07a01..f8e1ad19e05c 100644
> --- a/usr/Makefile
> +++ b/usr/Makefile
> @@ -64,6 +64,7 @@ quiet_cmd_initfs = GEN     $@
>  	$(CONFIG_SHELL) $< -o $@ -l $(obj)/.initramfs_data.cpio.d \
>  	$(if $(CONFIG_INITRAMFS_ROOT_UID), -u $(CONFIG_INITRAMFS_ROOT_UID)) \
>  	$(if $(CONFIG_INITRAMFS_ROOT_GID), -g $(CONFIG_INITRAMFS_ROOT_GID)) \
> +	$(if $(KBUILD_BUILD_TIMESTAMP), -d "$(KBUILD_BUILD_TIMESTAMP)") \
>  	$(ramfs-input)
>  
>  # We rebuild initramfs_data.cpio if:
> diff --git a/usr/gen_initramfs.sh b/usr/gen_initramfs.sh
> index 63476bb70b41..14b5782f961a 100755
> --- a/usr/gen_initramfs.sh
> +++ b/usr/gen_initramfs.sh
> @@ -23,6 +23,7 @@ $0 [-o <file>] [-l <dep_list>] [-u <uid>] [-g <gid>] {-d | <cpio_source>} ...
>  	-g <gid>       Group ID to map to group ID 0 (root).
>  		       <gid> is only meaningful if <cpio_source> is a
>  		       directory.  "squash" forces all files to gid 0.
> +	-d <date>      Use date for all file mtime values
>  	<cpio_source>  File list or directory for cpio archive.
>  		       If <cpio_source> is a .cpio file it will be used
>  		       as direct input to initramfs.
> @@ -190,6 +191,7 @@ prog=$0
>  root_uid=0
>  root_gid=0
>  dep_list=
> +timestamp=
>  cpio_list=$(mktemp ${TMPDIR:-/tmp}/cpiolist.XXXXXX)
>  output="/dev/stdout"
>  
> @@ -218,6 +220,13 @@ while [ $# -gt 0 ]; do
>  			[ "$root_gid" = "-1" ] && root_gid=$(id -g || echo 0)
>  			shift
>  			;;
> +		"-d")	# date for file mtimes
> +			timestamp="$(date -d"$1" +%s || :)"
> +			if test -n "$timestamp"; then
> +				timestamp="-t $timestamp"
> +			fi
> +			shift
> +			;;
>  		"-h")
>  			usage
>  			exit 0
> @@ -237,11 +246,4 @@ done
>  
>  # If output_file is set we will generate cpio archive
>  # we are careful to delete tmp files
> -timestamp=
> -if test -n "$KBUILD_BUILD_TIMESTAMP"; then
> -	timestamp="$(date -d"$KBUILD_BUILD_TIMESTAMP" +%s || :)"
> -	if test -n "$timestamp"; then
> -		timestamp="-t $timestamp"
> -	fi
> -fi
>  usr/gen_init_cpio $timestamp $cpio_list > $output
> -- 
> 2.40.1
> 
