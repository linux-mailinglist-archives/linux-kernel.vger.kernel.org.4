Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5B863A6DC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 12:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbiK1LOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 06:14:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiK1LOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 06:14:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAE52B9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 03:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669633999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n885n92m/I4LkalAJyIaZBFKS7m7GqbH7HaZ/6MYOpI=;
        b=i6JENAT8Gg8ho4Lp0ggAML+IyQscPHNSxrpOwX4COtkoaGql3vpJu1yWEV3Y3eZQRZ62xt
        LHLpEEYn5Cmln3nkUwWN7dNaeyhrOsyk2MEM4WtlXSHXrl/K0fvcFk++Hctq63ee5BqEb+
        9ifzyFNFMRNJ2pJQH0ot3Eu3FbilO7E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-381-OX9EsGfTN3iE_7P2TXUbjA-1; Mon, 28 Nov 2022 06:13:17 -0500
X-MC-Unique: OX9EsGfTN3iE_7P2TXUbjA-1
Received: by mail-wr1-f69.google.com with SMTP id l9-20020adfa389000000b00241f907e102so1768457wrb.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 03:13:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n885n92m/I4LkalAJyIaZBFKS7m7GqbH7HaZ/6MYOpI=;
        b=xU6n/LSQv+DwxxhKITsQevLGkdI3vjRJrQM4RvjTYvoGsjhY1ppG0GKEyODyIzym/H
         iqPQkm8FBcKQ1Rp6Llr7qe10DCB2jt3pc0efeD4qGM0VLEIP3KvUVVYpAlNigSwskPqu
         T1bdGSZUwXbgg0Za7L/1aYHamFqeYwSacn6whV1aCfrGLeucGekH+oWMIBJViwTxalXy
         /kT4fWgko5JzLdrF98ZBPtdW8TSWZ30Mb3SUfALv6kQKpaFmdfxehAL2tM6u7EWniY/Y
         UmDD8iVTzQcveEMjS/opS2cjOogG0EjjgudZ7WNNrJ4z8fcFb1VaKT04gd06n9FKy7TO
         bFgQ==
X-Gm-Message-State: ANoB5pmRf8pd8gH5ZuUlltZclWJsyLOThx/3EKpp+58dqiHh4wWWyrem
        Vh9jT9sFgPQ/oibQT11e3SCJF3wrcXMegJ3oL4Woqf05wovlNxM0bTAHhBQyAL4aTJqpO2dRZQV
        kVLYrnTsHc42vVJrYew69A4op
X-Received: by 2002:adf:dd07:0:b0:23a:2311:b72 with SMTP id a7-20020adfdd07000000b0023a23110b72mr23924290wrm.147.1669633996685;
        Mon, 28 Nov 2022 03:13:16 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5J2/sBKnl+vG7mrgkt/RBZFkd1JITHauZT0SPEGgQXNwoqP2YELKNPLOM2ZlRYFq0xcWA2kA==
X-Received: by 2002:adf:dd07:0:b0:23a:2311:b72 with SMTP id a7-20020adfdd07000000b0023a23110b72mr23924274wrm.147.1669633996453;
        Mon, 28 Nov 2022 03:13:16 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-234.retail.telecomitalia.it. [82.53.134.234])
        by smtp.gmail.com with ESMTPSA id e5-20020a05600c4e4500b003b492753826sm14305668wmq.43.2022.11.28.03.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 03:13:15 -0800 (PST)
Date:   Mon, 28 Nov 2022 12:13:10 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Dan Carpenter <error27@gmail.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     harshit.m.mogalapalli@gmail.com,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        Gautam Dawar <gautam.dawar@xilinx.com>,
        Parav Pandit <parav@nvidia.com>, Eli Cohen <elic@nvidia.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vduse: Validate vq_num in vduse_validate_config()
Message-ID: <20221128111310.6exrqi26grwspqcz@sgarzare-redhat>
References: <20221128083627.1199512-1-harshit.m.mogalapalli@oracle.com>
 <20221128105312.3ajursuudvmysiie@sgarzare-redhat>
 <Y4SUOPX2WRFiuB7n@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Y4SUOPX2WRFiuB7n@kadam>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 01:58:00PM +0300, Dan Carpenter wrote:
>On Mon, Nov 28, 2022 at 11:53:12AM +0100, Stefano Garzarella wrote:
>> On Mon, Nov 28, 2022 at 12:36:26AM -0800, Harshit Mogalapalli wrote:
>> > Add a limit to 'config->vq_num' which is user controlled data which
>> > comes from an vduse_ioctl to prevent large memory allocations.
>> >
>> > This is found using static analysis with smatch.
>> >
>> > Suggested-by: Michael S. Tsirkin <mst@redhat.com>
>> > Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
>> > ---
>> > v1->v2: Change title of the commit and description, add a limit to
>> > 	vq_num.
>> >
>> > Note: I think here 0xffff is the max size of vring =  no: of vqueues.
>> > Only compile and boot tested.
>> > ---
>> > drivers/vdpa/vdpa_user/vduse_dev.c | 3 +++
>> > 1 file changed, 3 insertions(+)
>> >
>> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
>> > index 35dceee3ed56..31017ebc4d7c 100644
>> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
>> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
>> > @@ -1440,6 +1440,9 @@ static bool vduse_validate_config(struct vduse_dev_config *config)
>> > 	if (config->config_size > PAGE_SIZE)
>> > 		return false;
>> >
>> > +	if (config->vq_num > 0xffff)
>>
>> What about using U16_MAX here?
>
>Where is the ->vq_num stored in a u16?  I looked for this but didn't
>see it.

I thought vq_num referred to the number of elements in the vq (like 
.get_vq_num_max), since this patch wants to limit to 0xffff.

But it actually refers to the number of virtqueue, so @Harshit why do we 
limit it to 0xffff?

Maybe we should explain it in the commit message or in a comment.

Thanks,
Stefano

