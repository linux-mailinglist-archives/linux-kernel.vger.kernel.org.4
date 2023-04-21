Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86176EA3D0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 08:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjDUG1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 02:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjDUG1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 02:27:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3ED31BC2;
        Thu, 20 Apr 2023 23:27:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7E2F71FDDD;
        Fri, 21 Apr 2023 06:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1682058457; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DQ1TIUjZBt37bQT3IDeyvaR6HNDEso1wcf9Z0b1/4R0=;
        b=KrSGvzm0aJ7NKWy6YcWwiOy1TUnln6eP/6P8hSpErdf2vlTW9mKposaO2QEBtt3KbFTkJu
        7eu4zFDsmt2Szd5ZueWUPzFL9NhbQjX+i4o0V22W+scpLQaUJG0owmcv8CuK0mbGqeAatV
        Y5L+KOxeZ2PfxjC7uzqzoIYtO7ZZrJc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1682058457;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DQ1TIUjZBt37bQT3IDeyvaR6HNDEso1wcf9Z0b1/4R0=;
        b=12SBpOabNibg+e6LqMdE3+FbVoA5Ya66nsl5mRBFhaTy9S3uRtFLjW6fGvQIgFq5TjhUCs
        S1ajMbZV0dUZSzDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5BE221390E;
        Fri, 21 Apr 2023 06:27:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vgfQFNksQmSAcAAAMHmgww
        (envelope-from <hare@suse.de>); Fri, 21 Apr 2023 06:27:37 +0000
Message-ID: <1089a043-a40c-6b49-f0a0-38ca3bcd8f91@suse.de>
Date:   Fri, 21 Apr 2023 08:27:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH REPOST blktests v2 3/9] common-xfs: Make size argument
 optional for _xfs_run_fio_verify_io
Content-Language: en-US
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>
References: <20230421060505.10132-1-dwagner@suse.de>
 <20230421060505.10132-4-dwagner@suse.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230421060505.10132-4-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/23 08:04, Daniel Wagner wrote:
> Make the size argument optional by reading the filesystem info. The
> caller doesn't have to guess (or calculate) how big the max IO size.
> The log data structure of XFS is reducing the capacity.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   common/xfs     | 6 ++++++
>   tests/nvme/012 | 2 +-
>   tests/nvme/013 | 2 +-
>   tests/nvme/035 | 2 +-
>   4 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/common/xfs b/common/xfs
> index 2c5d96164ac1..ec35599e017b 100644
> --- a/common/xfs
> +++ b/common/xfs
> @@ -27,6 +27,12 @@ _xfs_run_fio_verify_io() {
>   
>   	_xfs_mkfs_and_mount "${bdev}" "${mount_dir}" >> "${FULL}" 2>&1
>   
> +	if [[ -z "${sz}" ]]; then
> +		local avail
> +		avail="$(df --output=avail "${mount_dir}" | awk 'NR==2 {print $1}')"

df --output=avail "${mount_dir}" | tail -1

> +		sz="$(printf "%d" $((avail / 1024 - 1 )))m"

sz=$((avail / 1024 - 1))

> +	fi
> +
>   	_run_fio_verify_io --size="$sz" --directory="${mount_dir}/"

_run_fio_verify_io --size="${sz}m" --directory="${mount_dir}/"

>   
>   	umount "${mount_dir}" >> "${FULL}" 2>&1
> diff --git a/tests/nvme/012 b/tests/nvme/012
> index e60082c2e751..c9d24388306d 100755
> --- a/tests/nvme/012
> +++ b/tests/nvme/012
> @@ -44,7 +44,7 @@ test() {
>   	cat "/sys/block/${nvmedev}n1/uuid"
>   	cat "/sys/block/${nvmedev}n1/wwid"
>   
> -	_xfs_run_fio_verify_io "/dev/${nvmedev}n1" "900m"
> +	_xfs_run_fio_verify_io "/dev/${nvmedev}n1"
>   
>   	_nvme_disconnect_subsys "${subsys_name}"
>   
> diff --git a/tests/nvme/013 b/tests/nvme/013
> index 9d60a7df4577..265b6968fd34 100755
> --- a/tests/nvme/013
> +++ b/tests/nvme/013
> @@ -41,7 +41,7 @@ test() {
>   	cat "/sys/block/${nvmedev}n1/uuid"
>   	cat "/sys/block/${nvmedev}n1/wwid"
>   
> -	_xfs_run_fio_verify_io "/dev/${nvmedev}n1" "900m"
> +	_xfs_run_fio_verify_io "/dev/${nvmedev}n1"
>   
>   	_nvme_disconnect_subsys "${subsys_name}"
>   
> diff --git a/tests/nvme/035 b/tests/nvme/035
> index eb1024edddbf..8b485bc8e682 100755
> --- a/tests/nvme/035
> +++ b/tests/nvme/035
> @@ -32,7 +32,7 @@ test_device() {
>   	port=$(_nvmet_passthru_target_setup "${subsys}")
>   	nsdev=$(_nvmet_passthru_target_connect "${nvme_trtype}" "${subsys}")
>   
> -	_xfs_run_fio_verify_io "${nsdev}" "900m"
> +	_xfs_run_fio_verify_io "${nsdev}"
>   
>   	_nvme_disconnect_subsys "${subsys}"
>   	_nvmet_passthru_target_cleanup "${port}" "${subsys}"

Otherwise looks good.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

