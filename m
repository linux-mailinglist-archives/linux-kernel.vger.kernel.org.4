Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86B56EA3E0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 08:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjDUGdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 02:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjDUGdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 02:33:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13ABC270D;
        Thu, 20 Apr 2023 23:33:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B92AC1FDDD;
        Fri, 21 Apr 2023 06:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1682058828; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KK+u5+R/egTSimw32WYn/Ne5bItEuOFnTH1vigZ2+0c=;
        b=bdYqGl9n8C2SN2O7puLryrRoC/pqV/AKEw9QeuZfM9Z4VkhGxZhe5N0T2ZS/7X4GGHigig
        AccZDIMVql+GaS/2BemlBikJ4anu1kuW+dv2Sejg7jHl07NS3GKciII2oPBKArCV1xFnqA
        lDK4/b03pzPS3hcN/7tyZ3pJf+PBuTA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1682058828;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KK+u5+R/egTSimw32WYn/Ne5bItEuOFnTH1vigZ2+0c=;
        b=N0BvvsVf5xzsga2ykWWBFO5yEEV1rCLLu/zzZ9D7ZVQaDGUya6G3G/awO8GONZPmds/BeD
        dS2sS7WUqQXuj/DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 728D413456;
        Fri, 21 Apr 2023 06:33:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8QHAGEwuQmQocwAAMHmgww
        (envelope-from <hare@suse.de>); Fri, 21 Apr 2023 06:33:48 +0000
Message-ID: <6aa42bc9-e04e-cfc6-32cf-f1739944070b@suse.de>
Date:   Fri, 21 Apr 2023 08:33:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH REPOST blktests v2 7/9] nvme-rc: Calculate IO size for fio
 jobs
Content-Language: en-US
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>
References: <20230421060505.10132-1-dwagner@suse.de>
 <20230421060505.10132-8-dwagner@suse.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230421060505.10132-8-dwagner@suse.de>
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

On 4/21/23 08:05, Daniel Wagner wrote:
> Introduce two new function to calculate the IO size for fio jobs.
> 
> _nvme_calc_io_size() returns the jobs size for _run_fio_verify_io()
> function. Reduce the max size of the job by one megabyte to make the
> test more robust not to run out of space by accident. Note these fio
> calls run with just one jobs.
> 
> _nvme_calc_run_io_size() returns the jobs size for _run_fio_rand_io()
> function. Again, the jobs size is not maxing out the space and most
> important it takes the number of jobs into account which are
> created (number of CPUs).
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   tests/nvme/010 |  5 +++--
>   tests/nvme/011 |  5 +++--
>   tests/nvme/032 |  6 ++++--
>   tests/nvme/034 |  4 +++-
>   tests/nvme/040 |  4 +++-
>   tests/nvme/045 |  4 +++-
>   tests/nvme/047 |  6 ++++--
>   tests/nvme/rc  | 20 ++++++++++++++++++++
>   8 files changed, 43 insertions(+), 11 deletions(-)
> 
> diff --git a/tests/nvme/010 b/tests/nvme/010
> index 805f80d40620..d209335c2158 100755
> --- a/tests/nvme/010
> +++ b/tests/nvme/010
> @@ -25,6 +25,7 @@ test() {
>   	local loop_dev
>   	local file_path="${TMPDIR}/img"
>   	local subsys_name="blktests-subsystem-1"
> +	local io_size
>   
>   	truncate -s "${nvme_img_size}" "${file_path}"
>   
> @@ -41,8 +42,8 @@ test() {
>   	cat "/sys/block/${nvmedev}n1/uuid"
>   	cat "/sys/block/${nvmedev}n1/wwid"
>   
> -	_run_fio_verify_io --size=${nvme_img_size} \
> -		--filename="/dev/${nvmedev}n1"
> +	io_size="$(_nvme_calc_io_size "${nvme_img_size}")"
> +	_run_fio_verify_io --size="${io_size}" --filename="/dev/${nvmedev}n1"
>   
>   	_nvme_disconnect_subsys "${subsys_name}"
>   
> diff --git a/tests/nvme/011 b/tests/nvme/011
> index da8cbac11124..294ba4333aff 100755
> --- a/tests/nvme/011
> +++ b/tests/nvme/011
> @@ -25,6 +25,7 @@ test() {
>   	local file_path
>   	local file_path="${TMPDIR}/img"
>   	local subsys_name="blktests-subsystem-1"
> +	local io_size
>   
>   	truncate -s "${nvme_img_size}" "${file_path}"
>   
> @@ -39,8 +40,8 @@ test() {
>   	cat "/sys/block/${nvmedev}n1/uuid"
>   	cat "/sys/block/${nvmedev}n1/wwid"
>   
> -	_run_fio_verify_io --size="${nvme_img_size}" \
> -		--filename="/dev/${nvmedev}n1"
> +	io_size="$(_nvme_calc_io_size "${nvme_img_size}")"
> +	_run_fio_verify_io --size="${io_size}" --filename="/dev/${nvmedev}n1"
>   
>   	_nvme_disconnect_subsys "${subsys_name}"
>   
> diff --git a/tests/nvme/032 b/tests/nvme/032
> index 9f9756b0f959..ad701cea877d 100755
> --- a/tests/nvme/032
> +++ b/tests/nvme/032
> @@ -33,13 +33,15 @@ test_device() {
>   	local sysfs
>   	local attr
>   	local m
> +	local rand_io_size
>   
>   	pdev="$(_get_pci_dev_from_blkdev)"
>   	sysfs="/sys/bus/pci/devices/${pdev}"
>   
>   	# start fio job
> -	_run_fio_rand_io --filename="$TEST_DEV" --size="${nvme_img_size}" \
> -		--group_reporting --time_based --runtime=1m &> /dev/null &
> +	rand_io_size="$(_nvme_calc_rand_io_size "${nvme_img_size}")"
> +	_run_fio_rand_io --filename="$TEST_DEV" --size="${rand_io_size}" \
> +		--group_reporting --time_based --runtime=1m > /dev/null &
>   
>   	sleep 5
>   
> diff --git a/tests/nvme/034 b/tests/nvme/034
> index e0ede717c373..0df8bef98e5e 100755
> --- a/tests/nvme/034
> +++ b/tests/nvme/034
> @@ -19,6 +19,7 @@ test_device() {
>   	local ctrldev
>   	local nsdev
>   	local port
> +	local io_size
>   
>   	echo "Running ${TEST_NAME}"
>   
> @@ -26,7 +27,8 @@ test_device() {
>   	port=$(_nvmet_passthru_target_setup "${subsys}")
>   	nsdev=$(_nvmet_passthru_target_connect "${nvme_trtype}" "${subsys}")
>   
> -	_run_fio_verify_io --size="${nvme_img_size}" --filename="${nsdev}"
> +	io_size="$(_nvme_calc_io_size "${nvme_img_size}")"
> +	_run_fio_verify_io --size="${io_size}" --filename="${nsdev}"
>   
>   	_nvme_disconnect_subsys "${subsys}"
>   	_nvmet_passthru_target_cleanup "${port}" "${subsys}"
> diff --git a/tests/nvme/040 b/tests/nvme/040
> index 31b7cafef4be..b033a2a866f2 100755
> --- a/tests/nvme/040
> +++ b/tests/nvme/040
> @@ -21,6 +21,7 @@ test() {
>   	local port
>   	local loop_dev
>   	local nvmedev
> +	local rand_io_size
>   
>   	echo "Running ${TEST_NAME}"
>   
> @@ -37,7 +38,8 @@ test() {
>   
>   	# start fio job
>   	echo "starting background fio"
> -	_run_fio_rand_io --filename="/dev/${nvmedev}n1" --size="${nvme_img_size}" \
> +	rand_io_size="$(_nvme_calc_rand_io_size "${nvme_img_size}")"
> +	_run_fio_rand_io --filename="/dev/${nvmedev}n1" --size="${rand_io_size}" \
>   		--group_reporting --ramp_time=5 \
>   		--time_based --runtime=1m &> /dev/null &
>   	sleep 5
> diff --git a/tests/nvme/045 b/tests/nvme/045
> index 99012f6bed8f..f50087cccb6a 100755
> --- a/tests/nvme/045
> +++ b/tests/nvme/045
> @@ -31,6 +31,7 @@ test() {
>   	local ctrlkey
>   	local new_ctrlkey
>   	local ctrldev
> +	local rand_io_size
>   
>   	echo "Running ${TEST_NAME}"
>   
> @@ -120,7 +121,8 @@ test() {
>   
>   	nvmedev=$(_find_nvme_dev "${subsys_name}")
>   
> -	_run_fio_rand_io --size=4m --filename="/dev/${nvmedev}n1"
> +	rand_io_size="$(_nvme_calc_rand_io_size 4m)"
> +	_run_fio_rand_io --size="${rand_io_size}" --filename="/dev/${nvmedev}n1"
>   
>   	_nvme_disconnect_subsys "${subsys_name}"
>   
> diff --git a/tests/nvme/047 b/tests/nvme/047
> index b5a8d469a983..6a7599bc2e91 100755
> --- a/tests/nvme/047
> +++ b/tests/nvme/047
> @@ -25,6 +25,7 @@ test() {
>   	local port
>   	local nvmedev
>   	local loop_dev
> +	local rand_io_size
>   	local file_path="$TMPDIR/img"
>   	local subsys_name="blktests-subsystem-1"
>   
> @@ -42,7 +43,8 @@ test() {
>   
>   	nvmedev=$(_find_nvme_dev "${subsys_name}")
>   
> -	_xfs_run_fio_verify_io /dev/"${nvmedev}n1" "1m" || echo FAIL
> +	rand_io_size="$(_nvme_calc_rand_io_size 4M)"
> +	_run_fio_rand_io --filename="/dev/${nvmedev}n1" --size="${rand_io_size}"
>   
>   	_nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1
>   
> @@ -50,7 +52,7 @@ test() {
>   		--nr-write-queues 1 \
>   		--nr-poll-queues 1 || echo FAIL
>   
> -	_xfs_run_fio_verify_io /dev/"${nvmedev}n1" "1m" || echo FAIL
> +	_run_fio_rand_io --filename="/dev/${nvmedev}n1" --size="${rand_io_size}"
>   
>   	_nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1
>   
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index b1f2dacae125..172f510527ed 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -150,6 +150,26 @@ _test_dev_nvme_nsid() {
>   	cat "${TEST_DEV_SYSFS}/nsid"
>   }
>   
> +_nvme_calc_io_size() {
> +	local img_size_mb
> +	local io_size_mb
> +
> +	img_size_mb="$(convert_to_mb "$1")"
> +	io_size_mb="$((img_size_mb - 1))"
> +
> +	echo "${io_size_mb}m"
> +}
> +
> +_nvme_calc_rand_io_size() {
> +	local img_size_mb
> +	local io_size_mb
> +
> +	img_size_mb="$(convert_to_mb "$1")"
> +	io_size_mb="$(printf "%d" $((((img_size_mb * 1024 * 1024) / $(nproc) - 1) / 1024)))"
> +

... ending with ridiculous small io sizes on machines with lots of CPUs.
Please cap nproc by something sane like 32.

> +	echo "${io_size_mb}k"
> +}
> +
>   _nvme_fcloop_add_rport() {
>   	local local_wwnn="$1"
>   	local local_wwpn="$2"

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

