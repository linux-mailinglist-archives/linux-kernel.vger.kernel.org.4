Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1205B8CAC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 18:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiINQRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 12:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiINQQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 12:16:58 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577A875FCD;
        Wed, 14 Sep 2022 09:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=nxy9Jbp5GTwxPBiJKmfbVPecTADs9vQAWIAUvB3MVd4=; b=QU91CURp1MB5WBHbfGBG3nmJKB
        ilIW0hPaJgD6mS4C86zeb0WH9Gxy+JI6GKMq0depsoKkGiqCPFmJj6w0xuSgrLznAuJdkHBpYgXuj
        ve1MHZRBvO1TfzaBWz6776YDmWAqMhLKq/KqYn0yF83K/zHdRJVEysxlFD2piprqAAqtTN6nlI3CD
        t2p13ROrPfvfN/fuMd68TuF9phZLtEbzqVuJs0Jb6X+khfyRuk/NIo6IjGxDWDaLCwkU32ERnVz9w
        ds3TFOnWvF84joOESzJ8wLXoEVkcl/UZ5JmI7EpNaodG3XrwG48wyovmhOC7XKMSSMEMTDp1M0/b9
        sv+3yTKg==;
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1oYV3z-001g4o-Mb; Wed, 14 Sep 2022 10:16:36 -0600
Message-ID: <f0dd9208-05ec-b2fa-4b29-5fa140486fa3@deltatee.com>
Date:   Wed, 14 Sep 2022 10:16:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Content-Language: en-US
To:     Yu Kuai <yukuai1@huaweicloud.com>, song@kernel.org,
        guoqing.jiang@linux.dev, pmenzel@molgen.mpg.de
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com
References: <20220914014914.398712-1-yukuai1@huaweicloud.com>
 <20220914014914.398712-2-yukuai1@huaweicloud.com>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20220914014914.398712-2-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: yukuai1@huaweicloud.com, song@kernel.org, guoqing.jiang@linux.dev, pmenzel@molgen.mpg.de, linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH v2 1/4] md/raid10: cleanup wait_barrier()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-09-13 19:49, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Currently the nasty condition is wait_barrier() is hard to read. This
> patch factor out the condition into a function.
> 
> There are no functional changes.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/raid10.c | 56 ++++++++++++++++++++++++++-------------------
>  1 file changed, 32 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index 64d6e4cd8a3a..56458a53043d 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -957,44 +957,52 @@ static void lower_barrier(struct r10conf *conf)
>  	wake_up(&conf->wait_barrier);
>  }
>  
> +static bool stop_waiting_barrier(struct r10conf *conf)
> +{
> +	/* barrier is dropped */
> +	if (!conf->barrier)
> +		return true;
> +
> +	/*
> +	 * If there are already pending requests (preventing the barrier from
> +	 * rising completely), and the pre-process bio queue isn't empty, then
> +	 * don't wait, as we need to empty that queue to get the nr_pending
> +	 * count down.
> +	 */
> +	if (atomic_read(&conf->nr_pending)) {
> +		struct bio_list *bio_list = current->bio_list;

I'd probably just put the bio_list declaration at the top of this
function, then the nested if statements are not necessary. The compiler
should be able to optimize the access just fine.

>  	if (conf->barrier) {
> -		struct bio_list *bio_list = current->bio_list;
> -		conf->nr_waiting++;
> -		/* Wait for the barrier to drop.
> -		 * However if there are already pending
> -		 * requests (preventing the barrier from
> -		 * rising completely), and the
> -		 * pre-process bio queue isn't empty,
> -		 * then don't wait, as we need to empty
> -		 * that queue to get the nr_pending
> -		 * count down.
> -		 */
>  		/* Return false when nowait flag is set */
>  		if (nowait) {
>  			ret = false;
>  		} else {
> +			conf->nr_waiting++;

Technically speaking, I think moving nr_waiting counts as a functional
change. As best as I can see it is correct, but it should probably be at
least mentioned in the commit message, or maybe done as a separate
commit with it's own justification. That way if it causes problems down
the road, a bisect will make the issue clearer.

Thanks,

Logan
