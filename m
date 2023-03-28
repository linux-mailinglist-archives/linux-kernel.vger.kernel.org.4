Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD8D56CCE1E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 01:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjC1Xfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 19:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjC1Xfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 19:35:38 -0400
Received: from mp-relay-02.fibernetics.ca (mp-relay-02.fibernetics.ca [208.85.217.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E43230D3;
        Tue, 28 Mar 2023 16:35:34 -0700 (PDT)
Received: from mailpool-fe-02.fibernetics.ca (mailpool-fe-02.fibernetics.ca [208.85.217.145])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mp-relay-02.fibernetics.ca (Postfix) with ESMTPS id 980D1763C8;
        Tue, 28 Mar 2023 23:35:33 +0000 (UTC)
Received: from localhost (mailpool-mx-02.fibernetics.ca [208.85.217.141])
        by mailpool-fe-02.fibernetics.ca (Postfix) with ESMTP id 817C360BE8;
        Tue, 28 Mar 2023 23:35:33 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at 
X-Spam-Score: -0.199
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=5.0 tests=NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
Received: from mailpool-fe-02.fibernetics.ca ([208.85.217.145])
        by localhost (mail-mx-02.fibernetics.ca [208.85.217.141]) (amavisd-new, port 10024)
        with ESMTP id I0MGNKfBzvuP; Tue, 28 Mar 2023 23:35:32 +0000 (UTC)
Received: from [192.168.48.17] (host-184-164-23-94.dyn.295.ca [184.164.23.94])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dgilbert@interlog.com)
        by mail.ca.inter.net (Postfix) with ESMTPSA id 765C160BE5;
        Tue, 28 Mar 2023 23:35:32 +0000 (UTC)
Message-ID: <44d3878a-363e-632c-8e7d-d8bb016ac8df@interlog.com>
Date:   Tue, 28 Mar 2023 19:35:30 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH v3 01/11] scsi: scsi_debug: Fix check for sdev queue full
Content-Language: en-CA
To:     John Garry <john.g.garry@oracle.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bvanassche@acm.org, kernel test robot <oliver.sang@intel.com>
References: <20230327074310.1862889-1-john.g.garry@oracle.com>
 <20230327074310.1862889-2-john.g.garry@oracle.com>
From:   Douglas Gilbert <dgilbert@interlog.com>
In-Reply-To: <20230327074310.1862889-2-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-27 03:43, John Garry wrote:
> There is a report that the blktests scsi/004 test for "TASK SET FULL" (TSF)
> now fails.
> 
> The condition upon we should issue this TSF is when the sdev queue is
> full. The check for a full queue has an off-by-1 error. Previously we
> would increment the number of requests in the queue after testing if the
> queue would be full, i.e. test if one less than full. Since we now use
> scsi_device_busy() to count the number of requests in the queue, this
> would already account for the current request, so fix the test for queue
> full accordingly.
> 
> Fixes: 151f0ec9ddb5 ("scsi: scsi_debug: Drop sdebug_dev_info.num_in_q")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Link: https://lore.kernel.org/oe-lkp/202303201334.18b30edc-oliver.sang@intel.com
> Signed-off-by: John Garry <john.g.garry@oracle.com>
Acked-by: Douglas Gilbert <dgilbert@interlog.com

Thanks.

> ---
>   drivers/scsi/scsi_debug.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
> index 7ed117e78bd4..782515abca2c 100644
> --- a/drivers/scsi/scsi_debug.c
> +++ b/drivers/scsi/scsi_debug.c
> @@ -5580,7 +5580,7 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
>   		int num_in_q = scsi_device_busy(sdp);
>   		int qdepth = cmnd->device->queue_depth;
>   
> -		if ((num_in_q == (qdepth - 1)) &&
> +		if ((num_in_q == qdepth) &&
>   		    (atomic_inc_return(&sdebug_a_tsf) >=
>   		     abs(sdebug_every_nth))) {
>   			atomic_set(&sdebug_a_tsf, 0);

