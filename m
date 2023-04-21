Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218826EA3D6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 08:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjDUG33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 02:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjDUG30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 02:29:26 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2044233;
        Thu, 20 Apr 2023 23:29:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 090FA1FDDD;
        Fri, 21 Apr 2023 06:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1682058564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8LMGs8OgZhTiQIL7If/TwogM3aMQ0ZAQ/vhVCy32mQY=;
        b=0inpvk1NXaNGsFqI8R/9/QqQkeZZEbDsL9KIr++c78m4EuQ7tD6emwfIYogouqsqqHwOSZ
        NKz61VnyEgMrGsV/unZt4UPyQSGellfBsYod2flI/r/VVzMbAPUFntR9ulS0H0FC0DICVz
        TIAF5wILUW8QAp5GqumcIgBMr1KnNHA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1682058564;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8LMGs8OgZhTiQIL7If/TwogM3aMQ0ZAQ/vhVCy32mQY=;
        b=EfWmB8SfH3AIi4iI+n1CZoyVVOUXfMb7WAZeu0Lpv6l2M8enbwqPTSDkrU9jYajhPYl+hS
        ZNjfhzlMstLZtADg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D960B1390E;
        Fri, 21 Apr 2023 06:29:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EF8hNEMtQmREcQAAMHmgww
        (envelope-from <hare@suse.de>); Fri, 21 Apr 2023 06:29:23 +0000
Message-ID: <72ecc5fc-0ff4-5592-3293-f4204633fc8e@suse.de>
Date:   Fri, 21 Apr 2023 08:29:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH REPOST blktests v2 4/9] nvme: Use runtime fio background
 jobs
Content-Language: en-US
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>
References: <20230421060505.10132-1-dwagner@suse.de>
 <20230421060505.10132-5-dwagner@suse.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230421060505.10132-5-dwagner@suse.de>
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
> The fio jobs are supposed to run long in background during the test.
> Instead relying on a job size use explicit runtime for this.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   tests/nvme/032 | 2 +-
>   tests/nvme/040 | 3 ++-
>   2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/nvme/032 b/tests/nvme/032
> index 017d4a339971..81e074cc11bc 100755
> --- a/tests/nvme/032
> +++ b/tests/nvme/032
> @@ -39,7 +39,7 @@ test_device() {
>   
>   	# start fio job
>   	_run_fio_rand_io --filename="$TEST_DEV" --size=1g \
> -		--group_reporting  &> /dev/null &
> +		--group_reporting --time_based --runtime=1m &> /dev/null &
>   
>   	sleep 5
>   
> diff --git a/tests/nvme/040 b/tests/nvme/040
> index 04bd726cd309..8d29f905adb5 100755
> --- a/tests/nvme/040
> +++ b/tests/nvme/040
> @@ -38,7 +38,8 @@ test() {
>   	# start fio job
>   	echo "starting background fio"
>   	_run_fio_rand_io --filename="/dev/${nvmedev}n1" --size=1g \
> -		--group_reporting --ramp_time=5  &> /dev/null &
> +		--group_reporting --ramp_time=5 \
> +		--time_based --runtime=1m &> /dev/null &
>   	sleep 5
>   
>   	# do reset/remove operation

Wouldn't it be better to let _run_fio_rand_io pick the correct size?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

