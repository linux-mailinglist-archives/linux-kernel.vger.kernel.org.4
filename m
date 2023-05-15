Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDBDD702797
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 10:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238338AbjEOIxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 04:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238377AbjEOIwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 04:52:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4577FD
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 01:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684140723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=umr6Kvg3G3V2HlPXHiiPc5JVP/ZydQfgiuRpyByg02o=;
        b=GqnsfV4i+j6lkJvuSs07b6lMgrgPpuPtoLZkOQxAsMU1bL6TIjAcGkW+cmM8cTaEf2KL44
        7B8SypzJWWBdc+J06cS8zozDV7KpM/QsAagzQ6dpc0L3/mUrzdsSWe5P3YNajItoZoFaxu
        hZF1nQZSbBmb42iI0tQXybjfHr2VHw0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-621-lSEEbqF3NTO9HSgOtVc_9Q-1; Mon, 15 May 2023 04:52:00 -0400
X-MC-Unique: lSEEbqF3NTO9HSgOtVc_9Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D464285A5B1;
        Mon, 15 May 2023 08:51:59 +0000 (UTC)
Received: from ovpn-8-26.pek2.redhat.com (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A422E1121314;
        Mon, 15 May 2023 08:51:55 +0000 (UTC)
Date:   Mon, 15 May 2023 16:51:49 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Wenchao Hao <haowenchao2@huawei.com>
Cc:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linfeilong@huawei.com, louhongxiang@huawei.com
Subject: Re: [PATCH 2/2] scsi: core: decrease scsi_device's iorequest_cnt if
 dispatch failed
Message-ID: <ZGHypRXzI+JHVn1O@ovpn-8-26.pek2.redhat.com>
References: <20230515070156.1790181-1-haowenchao2@huawei.com>
 <20230515070156.1790181-3-haowenchao2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515070156.1790181-3-haowenchao2@huawei.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 03:01:56PM +0800, Wenchao Hao wrote:
> If scsi_dispatch_cmd() failed, the SCSI command was not sent to the target,
> scsi_queue_rq() would return BLK_STS_RESOURCE and the related request
> would be requeued. The timeout of this request would not fire, no one would
> increase iodone_cnt.
> 
> The above flow would result the iodone_cnt smaller than iorequest_cnt.
> So decrease the iorequest_cnt if dispatch failed to workaround the issue.
> 
> Link:https://lore.kernel.org/linux-scsi/8e0f2d31-e6ff-ec4a-3974-450560ad49c5@huawei.com/T/#t
> 
> Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
> ---
>  drivers/scsi/scsi_lib.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index 03964b26f3f2..0226c9279cef 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -1485,6 +1485,7 @@ static int scsi_dispatch_cmd(struct scsi_cmnd *cmd)
>  		 */
>  		SCSI_LOG_MLQUEUE(3, scmd_printk(KERN_INFO, cmd,
>  			"queuecommand : device blocked\n"));
> +		atomic_dec(&cmd->device->iorequest_cnt);
>  		return SCSI_MLQUEUE_DEVICE_BUSY;
>  	}
>  
> @@ -1517,6 +1518,7 @@ static int scsi_dispatch_cmd(struct scsi_cmnd *cmd)
>  	trace_scsi_dispatch_cmd_start(cmd);
>  	rtn = host->hostt->queuecommand(host, cmd);
>  	if (rtn) {
> +		atomic_dec(&cmd->device->iorequest_cnt);
>  		trace_scsi_dispatch_cmd_error(cmd, rtn);
>  		if (rtn != SCSI_MLQUEUE_DEVICE_BUSY &&
>  		    rtn != SCSI_MLQUEUE_TARGET_BUSY)

Looks fine, so the command is accounted in case that it is consumed by
scsi stack, otherwise the counter has to be undone.

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

