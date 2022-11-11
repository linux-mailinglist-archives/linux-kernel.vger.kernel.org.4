Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA8B626068
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 18:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbiKKRa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 12:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbiKKRa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 12:30:56 -0500
X-Greylist: delayed 420 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Nov 2022 09:30:54 PST
Received: from mp-relay-02.fibernetics.ca (mp-relay-02.fibernetics.ca [208.85.217.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EAEFAEA;
        Fri, 11 Nov 2022 09:30:54 -0800 (PST)
Received: from mailpool-fe-02.fibernetics.ca (mailpool-fe-02.fibernetics.ca [208.85.217.145])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mp-relay-02.fibernetics.ca (Postfix) with ESMTPS id 704576F8DD;
        Fri, 11 Nov 2022 17:23:52 +0000 (UTC)
Received: from localhost (mailpool-mx-01.fibernetics.ca [208.85.217.140])
        by mailpool-fe-02.fibernetics.ca (Postfix) with ESMTP id 5789B604F8;
        Fri, 11 Nov 2022 17:23:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at 
X-Spam-Score: -0.199
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Received: from mailpool-fe-02.fibernetics.ca ([208.85.217.145])
        by localhost (mail-mx-01.fibernetics.ca [208.85.217.140]) (amavisd-new, port 10024)
        with ESMTP id gs7efaBP5g_h; Fri, 11 Nov 2022 17:23:52 +0000 (UTC)
Received: from [192.168.48.17] (host-45-78-203-98.dyn.295.ca [45.78.203.98])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dgilbert@interlog.com)
        by mail.ca.inter.net (Postfix) with ESMTPSA id A788D601E4;
        Fri, 11 Nov 2022 17:23:51 +0000 (UTC)
Message-ID: <ffef9612-00da-43d2-caad-4f71a7ef7e44@interlog.com>
Date:   Fri, 11 Nov 2022 12:23:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH] scsi: scsi_debug: Fix a warning in resp_write_scat()
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     error27@gmail.com, harshit.m.mogalapalli@gmail.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221111100526.1790533-1-harshit.m.mogalapalli@oracle.com>
Content-Language: en-CA
From:   Douglas Gilbert <dgilbert@interlog.com>
In-Reply-To: <20221111100526.1790533-1-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-11 05:05, Harshit Mogalapalli wrote:
> As 'lbdof_blen' is coming from user, if the size in kzalloc()
> is >= MAX_ORDER then we hit a warning.
> 
> Call trace:
> 
> sg_ioctl
>   sg_ioctl_common
>     scsi_ioctl
>      sg_scsi_ioctl
>       blk_execute_rq
>        blk_mq_sched_insert_request
>         blk_mq_run_hw_queue
>          __blk_mq_delay_run_hw_queue
>           __blk_mq_run_hw_queue
>            blk_mq_sched_dispatch_requests
>             __blk_mq_sched_dispatch_requests
>              blk_mq_dispatch_rq_list
>               scsi_queue_rq
>                scsi_dispatch_cmd
>                 scsi_debug_queuecommand
>                  schedule_resp
>                   resp_write_scat
> 
> If you try to allocate a memory larger than(>=) MAX_ORDER, then kmalloc()
> will definitely fail.  It creates a stack trace and messes up dmesg.
> The user controls the size here so if they specify a too large size it
> will fail.
> 
> Add __GFP_NOWARN in order to avoid too large allocation warning.
> This is detected by static analysis using smatch.
> 
> Fixes: 481b5e5c7949 ("scsi: scsi_debug: add resp_write_scat function")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Acked-by: Douglas Gilbert <dgilbert@interlog.com>

Thanks.

> ---
>   drivers/scsi/scsi_debug.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
> index 697fc57bc711..273224d29ce9 100644
> --- a/drivers/scsi/scsi_debug.c
> +++ b/drivers/scsi/scsi_debug.c
> @@ -3778,7 +3778,7 @@ static int resp_write_scat(struct scsi_cmnd *scp,
>   		mk_sense_buffer(scp, ILLEGAL_REQUEST, INVALID_FIELD_IN_CDB, 0);
>   		return illegal_condition_result;
>   	}
> -	lrdp = kzalloc(lbdof_blen, GFP_ATOMIC);
> +	lrdp = kzalloc(lbdof_blen, GFP_ATOMIC | __GFP_NOWARN);
>   	if (lrdp == NULL)
>   		return SCSI_MLQUEUE_HOST_BUSY;
>   	if (sdebug_verbose)

