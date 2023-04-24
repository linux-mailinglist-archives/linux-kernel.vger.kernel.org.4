Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B68D6EC877
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 11:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjDXJJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 05:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbjDXJJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 05:09:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02048E55;
        Mon, 24 Apr 2023 02:09:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93BA461F31;
        Mon, 24 Apr 2023 09:09:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FEE1C433EF;
        Mon, 24 Apr 2023 09:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682327384;
        bh=yV2sGi32MWGtguiaQhYp/hYKcUQB0aF3VYck+w+tbHo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=aR9JKCwa+38DptzFFGWTd27h1DSRt0D2u1W9etisVGNmSnXYE5TGyj57VhkSal7P/
         pNGE1dU+Sm8nFJch/mQGMOkcNs1e+8R4bjj1sKEuulMlBrTmwSpwehAMJZ7HpbrvPr
         GXrh5ZCb+5vmyWvuUPiiFdWLQWbN9nzzNuXeOoTSeX2wHgS6WxdeP+TH4ezHPte518
         OT3nTDYE7QCPE/QcHBche51qat72KgluL81WuWdTEfYZWrvk484xZKoddhx6rledg6
         iBI1h7HPylKnBZuRkX8KOVW/HZaKS0159YknfeQGISzIHZglDli4PtaWr41jmd9Uva
         0VozqQQjyjY2A==
Message-ID: <a19df26e-7c0c-e48e-8611-6035c8c7f1a4@kernel.org>
Date:   Mon, 24 Apr 2023 11:09:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] rv: Fix addition on an uninitialized variable 'run'
To:     Colin Ian King <colin.i.king@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-devel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230417103946.29594-1-colin.i.king@gmail.com>
Content-Language: en-US
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20230417103946.29594-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/17/23 12:39, Colin Ian King wrote:
> The variable run is not initialized


Oops, that is a problem, it should be initialized as 0.

however it is being accumulated
> by the return value from the call to ikm_run_monitor.  Fix this by
> replacing the += with an assignment since this is the first point
> where run is being assigned.
> 
> Fixes: 4bc4b131d44c ("rv: Add rv tool")
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  tools/verification/rv/src/rv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/verification/rv/src/rv.c b/tools/verification/rv/src/rv.c
> index e601cd9c411e..da647ad4e733 100644
> --- a/tools/verification/rv/src/rv.c
> +++ b/tools/verification/rv/src/rv.c
> @@ -111,7 +111,7 @@ static void rv_mon(int argc, char **argv)
>  	 * Call all possible monitor implementations, looking
>  	 * for the [monitor].
>  	 */
> -	run += ikm_run_monitor(monitor_name, argc-1, &argv[1]);
> +	run = ikm_run_monitor(monitor_name, argc-1, &argv[1]);

So, in the future, there will be more monitors types, and so we will check
other functions to see if they find the monitor by name. Thus, the += is correct,
what is not correct the run not being initialized.

Mind sending a patch initializing the run = 0?

Thanks!
-- Daniel

  
>  	if (!run)
>  		err_msg("rv: monitor %s does not exist\n", monitor_name);

