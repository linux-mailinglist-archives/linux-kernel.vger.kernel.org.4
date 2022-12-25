Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62DD0655D53
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 14:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbiLYNsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 08:48:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiLYNsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 08:48:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D1210A3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 05:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671976078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bmnZ8jD58MccGTom0aWQqAmajJcptTuHUgfU+1BPtUY=;
        b=KGFnptVqG6iMxJBGitY/Em5ZbcrX7kufr9hcvsXHuMYrg6EVVtJVBKOBsG2JF49n3bXIkn
        EUNwl/zMJIsqdwvbelYvZh6h5OYUVjcirj9vDv2yUs8d/Zem/m2LT89xqoPujsA25Klxbj
        +OvbbYSDxR+9x3y/di5OL20E6kVjr/M=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-533-sencZwkONwGgtjBQ_iRRmw-1; Sun, 25 Dec 2022 08:47:56 -0500
X-MC-Unique: sencZwkONwGgtjBQ_iRRmw-1
Received: by mail-pf1-f198.google.com with SMTP id s2-20020a056a00178200b005810f057e7cso475465pfg.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 05:47:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bmnZ8jD58MccGTom0aWQqAmajJcptTuHUgfU+1BPtUY=;
        b=y1cTLugQXF5Vb7JKykAeXYkBAyvUiIDWUkarSU714CeFKIy0JM/3dP1BPCzzuGW9Fg
         +x4FYAZoBQ7N0GsD2DB1LQTjNKVuSL7OdgXfjmuXTPVKqZnzxjyEgTGnGSd+74u2y34+
         3LWiXTH4f9FOUM/2T/+a08cCncW/3xtp1U5Jik7WjRMRayPyXN5glQzy75rGIeKtoBE6
         pf4+7HVJNrgvP/rBX0jlmwG6l2y2tW/j3OtWt6oYkO+KukAdyVQyiR4sg5wA0rZVo5Pl
         j8YUTrDjqef9+UpbC2q6aFFqIY1dF4hD2IpFwU8lrTShsC5Yo4dVSL+k9ULQzGEZ89qq
         5F2w==
X-Gm-Message-State: AFqh2koh2Yqvm6MSgVz2yaT5KJg6z8EHRop+T2REMjdH4pdgAAQWnvS2
        CyB2Jwcb3gSjPJeXtrquDvpp5RFi5azIaoPDf4k3kwWsKkbli0l8hAxLcHHt+JV3I28nSuMtRZM
        rRbhAjZJJyBl6ZAc/7mPnr6OA
X-Received: by 2002:a17:903:200b:b0:192:467e:7379 with SMTP id s11-20020a170903200b00b00192467e7379mr14138740pla.49.1671976075772;
        Sun, 25 Dec 2022 05:47:55 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtyhj0Xc/00+TwzlzO/wtuo5xC3g4dxs8us5h5p8x/RXbUdTZwjSHouok9zbQafG3fN7yJdPQ==
X-Received: by 2002:a17:903:200b:b0:192:467e:7379 with SMTP id s11-20020a170903200b00b00192467e7379mr14138725pla.49.1671976075350;
        Sun, 25 Dec 2022 05:47:55 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id q17-20020a170902f35100b00186b04776b0sm5449470ple.118.2022.12.25.05.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Dec 2022 05:47:54 -0800 (PST)
Date:   Sun, 25 Dec 2022 21:47:51 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     fstests@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fstests: update patien module remover usage
Message-ID: <20221225134751.qwwqjl2ddsuis3zt@zlang-mailbox>
References: <20221221002922.1528013-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221221002922.1528013-1-mcgrof@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 04:29:22PM -0800, Luis Chamberlain wrote:
> kmod now has support for the patient module remover but
> it uses --wait instead of -p, and it does not have an option
> to wait forever. So let's just deprecate the "forever" option,
> and use update our code to use --wait.
> 
> Since blktests is also getting support, and since they actually
> use 'make check' with consistent shellcheck checks, embrace the
> implementation there so we at least match solutions. That way if
> there are bugs in one we can fix them in the other project as well.
> The style changes are minor.
> 
> A few functional changes brought forward from the solution embraced
> by blktests
> 
>   * sanity check for the modules sysfs directory to replace "-" with
>     "_" and document why we do that
>   * do not run if the module does not exist or is not loaded, that's
>     the addition of:
>     [ ! -e "/sys/module/$module_sys" ] && return 0
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
> 
> Although the blktests patch is not yet merged its on its v3 now.
> I *have not tested* this patch yet on fstests... once I do I'll
> poke back here.
> 
>  README        |  3 +--
>  common/config | 31 +++++++++++++++++++------------
>  common/module | 28 ++++++++++++----------------
>  3 files changed, 32 insertions(+), 30 deletions(-)
> 
> diff --git a/README b/README
> index 4c4f22f853de..b2d4744593f3 100644
> --- a/README
> +++ b/README
> @@ -222,8 +222,7 @@ Kernel/Modules related configuration:
>     test invocations. This assumes that the name of the module is the same
>     as FSTYP.
>   - Set MODPROBE_PATIENT_RM_TIMEOUT_SECONDS to specify the amount of time we
> -   should try a patient module remove. The default is 50 seconds. Set this
> -   to "forever" and we'll wait forever until the module is gone.
> +   should try a patient module remove. The default is 50 seconds.
>   - Set KCONFIG_PATH to specify your preferred location of kernel config
>     file. The config is used by tests to check if kernel feature is enabled.
>  
> diff --git a/common/config b/common/config
> index b2802e5e0af1..8bc6b3d2ae3f 100644
> --- a/common/config
> +++ b/common/config
> @@ -256,11 +256,15 @@ if [[ "$UDEV_SETTLE_PROG" == "" || ! -d /proc/net ]]; then
>  fi
>  export UDEV_SETTLE_PROG
>  
> -# Set MODPROBE_PATIENT_RM_TIMEOUT_SECONDS to "forever" if you want the patient
> -# modprobe removal to run forever trying to remove a module.
> +_has_modprobe_patient()
> +{
> +	modprobe --help >& /dev/null || return 1
> +	modprobe --help | grep -q "\-\-wait" || return 1
                                   ^^^^

This might cause error output from grep, better to use "--", e.g:

  grep -q -- "--wait"


> +	return 0
> +}
> +
>  MODPROBE_REMOVE_PATIENT=""
> -modprobe --help >& /dev/null && modprobe --help | grep -q -1 "remove-patiently"
> -if [[ $? -ne 0 ]]; then
> +if ! _has_modprobe_patient; then
>  	if [[ -z "$MODPROBE_PATIENT_RM_TIMEOUT_SECONDS" ]]; then
>  		# We will open code our own implementation of patient module
>  		# remover in fstests. Use a 50 second default.
> @@ -268,22 +272,25 @@ if [[ $? -ne 0 ]]; then
>  	fi
>  else
>  	MODPROBE_RM_PATIENT_TIMEOUT_ARGS=""
> -	if [[ ! -z "$MODPROBE_PATIENT_RM_TIMEOUT_SECONDS" ]]; then
> -		if [[ "$MODPROBE_PATIENT_RM_TIMEOUT_SECONDS" != "forever" ]]; then
> -			MODPROBE_PATIENT_RM_TIMEOUT_MS="$((MODPROBE_PATIENT_RM_TIMEOUT_SECONDS * 1000))"
> -			MODPROBE_RM_PATIENT_TIMEOUT_ARGS="-t $MODPROBE_PATIENT_RM_TIMEOUT_MS"
> +	if [[ -n "$MODPROBE_PATIENT_RM_TIMEOUT_SECONDS" ]]; then
> +		MODPROBE_PATIENT_RM_TIMEOUT_MS="$((MODPROBE_PATIENT_RM_TIMEOUT_SECONDS * 1000))"
> +		MODPROBE_RM_PATIENT_TIMEOUT_ARGS="--wait $MODPROBE_PATIENT_RM_TIMEOUT_MS"
> +		if [[ "$MODPROBE_PATIENT_RM_TIMEOUT_SECONDS" == "forever" ]];

"then" missed.

Others make sense to me. Better to give it a basic test, to make sure it works :)

Thanks,
Zorro

> +			echo "Warning: deprecated MODPROBE_PATIENT_RM_TIMEOUT_SECONDS forever setting"
> +			echo "Just set this to a high value if you want this to linger for a long time"
> +			exit 1
>  		fi
>  	else
>  		# We export MODPROBE_PATIENT_RM_TIMEOUT_SECONDS here for parity
> -		# with environments without support for modprobe -p, but we
> +		# with environments without support for modprobe --wait, but we
>  		# only really need it exported right now for environments which
> -		# don't have support for modprobe -p to implement our own
> +		# don't have support for modprobe --wait to implement our own
>  		# patient module removal support within fstests.
>  		export MODPROBE_PATIENT_RM_TIMEOUT_SECONDS="50"
>  		MODPROBE_PATIENT_RM_TIMEOUT_MS="$((MODPROBE_PATIENT_RM_TIMEOUT_SECONDS * 1000))"
> -		MODPROBE_RM_PATIENT_TIMEOUT_ARGS="-t $MODPROBE_PATIENT_RM_TIMEOUT_MS"
> +		MODPROBE_RM_PATIENT_TIMEOUT_ARGS="--wait $MODPROBE_PATIENT_RM_TIMEOUT_MS"
>  	fi
> -	MODPROBE_REMOVE_PATIENT="modprobe -p $MODPROBE_RM_PATIENT_TIMEOUT_ARGS"
> +	MODPROBE_REMOVE_PATIENT="modprobe -r $MODPROBE_RM_PATIENT_TIMEOUT_ARGS"
>  fi
>  export MODPROBE_REMOVE_PATIENT
>  
> diff --git a/common/module b/common/module
> index 6efab71d348e..bd205dafeaff 100644
> --- a/common/module
> +++ b/common/module
> @@ -107,9 +107,9 @@ _patient_rmmod_check_refcnt()
>  # MODPROBE_PATIENT_RM_TIMEOUT_SECONDS prior to including this file.
>  # If you want this to try forever just set MODPROBE_PATIENT_RM_TIMEOUT_SECONDS
>  # to the special value of "forever". This applies to both cases where kmod
> -# supports the patient module remover (modrobe -p) and where it does not.
> +# supports the patient module remover (modrobe --wait) and where it does not.
>  #
> -# If your version of kmod supports modprobe -p, we instead use that
> +# If your version of kmod supports modprobe --wait, we instead use that
>  # instead. Otherwise we have to implement a patient module remover
>  # ourselves.
>  _patient_rmmod()
> @@ -119,6 +119,12 @@ _patient_rmmod()
>  	local max_tries=0
>  	local mod_ret=0
>  	local refcnt_is_zero=0
> +	# Since we are looking for a directory we must adopt the
> +	# specific directory used by scripts/Makefile.lib for
> +	# KBUILD_MODNAME
> +	local module_sys=${module//-/_}
> +
> +	[ ! -e "/sys/module/$module_sys" ] && return 0
>  
>  	if [[ ! -z $MODPROBE_REMOVE_PATIENT ]]; then
>  		$MODPROBE_REMOVE_PATIENT $module
> @@ -131,20 +137,13 @@ _patient_rmmod()
>  
>  	max_tries=$max_tries_max
>  
> -	# We must use a string check as otherwise if max_tries is set to
> -	# "forever" and we don't use a string check we can end up skipping
> -	# entering this loop.
>  	while [[ "$max_tries" != "0" ]]; do
> -		_patient_rmmod_check_refcnt $module
> -		if [[ $? -eq 0 ]]; then
> +		if _patient_rmmod_check_refcnt "$module_sys"; then
>  			refcnt_is_zero=1
>  			break
>  		fi
>  		sleep 1
> -		if [[ "$max_tries" == "forever" ]]; then
> -			continue
> -		fi
> -		let max_tries=$max_tries-1
> +		((max_tries--))
>  	done
>  
>  	if [[ $refcnt_is_zero -ne 1 ]]; then
> @@ -169,17 +168,14 @@ _patient_rmmod()
>  	# https://bugzilla.kernel.org/show_bug.cgi?id=212337
>  	# https://bugzilla.kernel.org/show_bug.cgi?id=214015
>  	while [[ $max_tries != 0 ]]; do
> -		if [[ -d /sys/module/$module ]]; then
> +		if [[ -d /sys/module/$module_sys ]]; then
>  			modprobe -r $module 2> /dev/null
>  			mod_ret=$?
>  			if [[ $mod_ret == 0 ]]; then
>  				break;
>  			fi
>  			sleep 1
> -			if [[ "$max_tries" == "forever" ]]; then
> -				continue
> -			fi
> -			let max_tries=$max_tries-1
> +			((max_tries--))
>  		else
>  			break
>  		fi
> -- 
> 2.35.1
> 

