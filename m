Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68CC160ED59
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 03:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiJ0BSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 21:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJ0BS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 21:18:27 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4413C543E1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 18:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666833507; x=1698369507;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=j4VTz3xAsPX1ykQZALKZMRU5knt+b8ZaK/+epWQA9oU=;
  b=FHohDeUkUzPmDv3W0InYd7UIkTv5IVIAyt6FgB8TDECQm8An6559NG20
   G0gh9DloaeER+6hmxrtjjs/cvoAHRGSRuU++I7/AbenXqOP5g6iiB7V+C
   FDPzX0ToLTdxkV+g31J0KaIjMHsCQ/pGEeH5wGaQjRv0/zsbd/U1QGrck
   ShZjkfPmlIYlrhNP9INb/lz40KCBPBu8AbGxAtI2uKQL3npD4M+TS0nev
   eBfw/2mUR8EfLCmTWj5bC2x8DYvaas8n4NHO4ZgnQniwekKPG8u2bDfmh
   1fAwJ6gPtv9rNL8SQlOCKagOvIOeFAUKEzaBRm7XpT8Fs+dJTYucgvKWV
   g==;
X-IronPort-AV: E=Sophos;i="5.95,215,1661788800"; 
   d="scan'208";a="214828250"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2022 09:18:25 +0800
IronPort-SDR: qlcQ8QodG1tTKnO22mI4+fL5AcQHO5rTOo+94bAOzXINgxQMwz8G7Xj1Coz8Q/qPmOPVLCNwWi
 gTXCSpcBU5wZkqid0t+4lf+1rDnfHBGGqYVKZaNM8Roo5YFXFaE4/spvlyKxIBN4hD6VlhvqD8
 0oRYqQdzXBRA/1fWgaR/4B6jWoOu98whtx+TSXR7Gu4VVWnoxbWjVMPyLq8fup4BjLnD8PE8c/
 11iIux4ruac93EweaKBBHV3YSy7El42sxRrB4DH89UvegKQGz039v5skVfhC9ZGJR4jlk61nY7
 9svBuD71YNHvxFG4jTji+m9i
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Oct 2022 17:32:05 -0700
IronPort-SDR: iSr94aw5ansyUO+LOq40Z45nHhMjKAMoDR9LN5FZdKO9M227f8vgUwE1lOuaQzbiNYnm16rp71
 HIlJYd43owHRU9tlvudZncZPjci9jCNfXCPxXl9XgCDTcXFEz/mlZo/ZNwh6ttq5kEg84fpvn+
 o1kQ/Rf7FsGtAWHlihY1i/Ba/9bEhiIxj+bzPIPtpB91G6LCR+V8lOQYVyJETaLO8of5HqU0NE
 D3HmHUPdA5eRoW8cYit7n4p2hJToJIxYmXAcSBixvQ3javJ+xW1s5MtuiMSXT78i4n6WACXKcr
 BSA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Oct 2022 18:18:25 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MySVT0VTmz1RwvT
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 18:18:25 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1666833503; x=1669425504; bh=j4VTz3xAsPX1ykQZALKZMRU5knt+b8ZaK/+
        epWQA9oU=; b=AlLTfLAZlMQuunUsaVrTOL6ArW6Bwtsjjj/dCIowQnsGO3Ny7IX
        8fETeWSg45iCdJ8qBnD5z9SzZ/rORSWbNt/6k6fIGNFSbPAqFXciPJsr2KkDWTYs
        4CAskUPPRb9upJ55xdDt6x1lGglffoeITJ/e0Hhgpz7w6fETMh1tf5n9pmIgVc8v
        0F2yXafbOJQOQydVy9vvvCtlzJyv7BxaoC6XYzj+DV/1MRedMmNCBjwu4SNfv/es
        lH9AOj8pyGJ0iSrnx/dhludNfuMK6I+54MpHK7PJNM8/QKrcsZxy+6vbMoml8zi+
        +BodTY/qmKOETxc9ZWmNtOvXjEpqOvOLMfA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7TK-8tE4eath for <linux-kernel@vger.kernel.org>;
        Wed, 26 Oct 2022 18:18:23 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MySVP4qbZz1RvLy;
        Wed, 26 Oct 2022 18:18:21 -0700 (PDT)
Message-ID: <cd5df8e0-03d1-8f22-0367-eb7c76bc70e7@opensource.wdc.com>
Date:   Thu, 27 Oct 2022 10:18:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH RFC v3 03/22] scsi: core: Implement reserved command
 handling
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, axboe@kernel.dk,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        jinpu.wang@cloud.ionos.com, hare@suse.de, bvanassche@acm.org,
        hch@lst.de, ming.lei@redhat.com, niklas.cassel@wdc.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linuxarm@huawei.com
References: <1666693096-180008-1-git-send-email-john.garry@huawei.com>
 <1666693096-180008-4-git-send-email-john.garry@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1666693096-180008-4-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/22 19:17, John Garry wrote:
> From: Hannes Reinecke <hare@suse.de>
> 
> Quite some drivers are using management commands internally, which
> typically use the same hardware tag pool (ie they are being allocated
> from the same hardware resources) as the 'normal' I/O commands.
> These commands are set aside before allocating the block-mq tag bitmap,
> so they'll never show up as busy in the tag map.
> The block-layer, OTOH, already has 'reserved_tags' to handle precisely
> this situation.
> So this patch adds a new field 'nr_reserved_cmds' to the SCSI host
> template to instruct the block layer to set aside a tag space for these
> management commands by using reserved tags.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> #jpg: Set tag_set->queue_depth = shost->can_queue, and not
> = shost->can_queue + shost->nr_reserved_cmds;
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  drivers/scsi/hosts.c     |  3 +++
>  drivers/scsi/scsi_lib.c  |  2 ++
>  include/scsi/scsi_host.h | 15 ++++++++++++++-
>  3 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
> index 12346e2297fd..db89afc37bc9 100644
> --- a/drivers/scsi/hosts.c
> +++ b/drivers/scsi/hosts.c
> @@ -489,6 +489,9 @@ struct Scsi_Host *scsi_host_alloc(struct scsi_host_template *sht, int privsize)
>  	if (sht->virt_boundary_mask)
>  		shost->virt_boundary_mask = sht->virt_boundary_mask;
>  
> +	if (sht->nr_reserved_cmds)
> +		shost->nr_reserved_cmds = sht->nr_reserved_cmds;
> +

Nit: the if is not really necessary I think. But it does not hurt.

>  	device_initialize(&shost->shost_gendev);
>  	dev_set_name(&shost->shost_gendev, "host%d", shost->host_no);
>  	shost->shost_gendev.bus = &scsi_bus_type;
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index 39d4fd124375..a8c4e7c037ae 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -1978,6 +1978,8 @@ int scsi_mq_setup_tags(struct Scsi_Host *shost)
>  	tag_set->nr_hw_queues = shost->nr_hw_queues ? : 1;
>  	tag_set->nr_maps = shost->nr_maps ? : 1;
>  	tag_set->queue_depth = shost->can_queue;
> +	tag_set->reserved_tags = shost->nr_reserved_cmds;
> +

Why the blank line ?

>  	tag_set->cmd_size = cmd_size;
>  	tag_set->numa_node = dev_to_node(shost->dma_dev);
>  	tag_set->flags = BLK_MQ_F_SHOULD_MERGE;
> diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
> index 750ccf126377..91678c77398e 100644
> --- a/include/scsi/scsi_host.h
> +++ b/include/scsi/scsi_host.h
> @@ -360,10 +360,17 @@ struct scsi_host_template {
>  	/*
>  	 * This determines if we will use a non-interrupt driven
>  	 * or an interrupt driven scheme.  It is set to the maximum number
> -	 * of simultaneous commands a single hw queue in HBA will accept.
> +	 * of simultaneous commands a single hw queue in HBA will accept
> +	 * including reserved commands.
>  	 */
>  	int can_queue;
>  
> +	/*
> +	 * This determines how many commands the HBA will set aside
> +	 * for reserved commands.
> +	 */
> +	int nr_reserved_cmds;
> +
>  	/*
>  	 * In many instances, especially where disconnect / reconnect are
>  	 * supported, our host also has an ID on the SCSI bus.  If this is
> @@ -611,6 +618,12 @@ struct Scsi_Host {
>  	 */
>  	unsigned nr_hw_queues;
>  	unsigned nr_maps;
> +
> +	/*
> +	 * Number of reserved commands to allocate, if any.
> +	 */
> +	unsigned int nr_reserved_cmds;
> +
>  	unsigned active_mode:2;
>  
>  	/*

-- 
Damien Le Moal
Western Digital Research

