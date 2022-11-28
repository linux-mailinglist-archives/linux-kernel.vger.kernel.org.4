Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3551163A907
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbiK1NLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:11:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbiK1NLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:11:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D504C183A9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 05:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669641015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tG1zMiwdOY9O7mrEYW6ArphNZnozJi7hc/+tTcFVOb4=;
        b=GgYD3Xu9JlOPulNSxciGArnJ6KrpBIDrh9CfBLriFXcny+9XYjMsuWiNtYbxSBdbJYMDJn
        YEEpCLi7aRa/Cb5FOastXM7pYMVKaCQZaqNltDnILlxUpi5P1pIRpQZPu378tFS7dW6TPK
        woO3pzcjYVlFsGW1coMXGpwA2hGEGUs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-588-E4QuILjzPwyV8NwtopNhKw-1; Mon, 28 Nov 2022 08:10:14 -0500
X-MC-Unique: E4QuILjzPwyV8NwtopNhKw-1
Received: by mail-wr1-f71.google.com with SMTP id d8-20020adf9b88000000b0024207f09827so1285025wrc.20
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 05:10:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tG1zMiwdOY9O7mrEYW6ArphNZnozJi7hc/+tTcFVOb4=;
        b=7BH7dRk8zHPK/GXPuYTIwWIFlmwO2N+wiHnZPFbVAggFJ7zStzoqfMpn08XdVgFbLQ
         VRJTwtp4Q/9tmxQ5LYa/o+x2T4e060fWKncEwX/CJN9tHReTZSbr5SKqicRFp+KSlehO
         pExQZRXimABa5ZFsOpGFgoNhadAetd9mpcp0c5SZuJUkOT6FoqDXbBbMuqHKt7jON4V5
         4Y9UbAdrKkf25la5lyRrYkuSVWKi69mIFoGW7aCk4d5O9L3LFeNXUQBxq29YuDYvIUh8
         UHcV/GdtvQXA/hbgUc89B+X6QZY03dGXwdMWDNNW9NurvA7SOcZv/zjIceMmu0NzJM41
         UDkQ==
X-Gm-Message-State: ANoB5pltdyFulmEiWgrJfTnbbNneDFvRfLgyVzNFFGPVk09ihoaWnjrS
        Uck6Zl6KgugPg5KPoPufnnUJXjCunCRUW3pUMVAKVi2zkWVE+z31AoLzOWwjnSNNUR5aC2T1HE6
        JcHudh9AOEuWRfypwL3YT/BNg
X-Received: by 2002:a05:6000:105:b0:236:64e6:8c04 with SMTP id o5-20020a056000010500b0023664e68c04mr30902208wrx.579.1669641013394;
        Mon, 28 Nov 2022 05:10:13 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6dQQZXu6s2F8m0nrdL8TAKZisB38/fekquSxxxPYuklf3PUYQKVHFhVB063xtDQTa9/B3MgA==
X-Received: by 2002:a05:6000:105:b0:236:64e6:8c04 with SMTP id o5-20020a056000010500b0023664e68c04mr30902187wrx.579.1669641013140;
        Mon, 28 Nov 2022 05:10:13 -0800 (PST)
Received: from redhat.com ([2.52.149.178])
        by smtp.gmail.com with ESMTPSA id p7-20020adfe607000000b00241fea203b6sm10930244wrm.87.2022.11.28.05.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 05:10:12 -0800 (PST)
Date:   Mon, 28 Nov 2022 08:10:09 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     Dan Carpenter <error27@gmail.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        harshit.m.mogalapalli@gmail.com, Jason Wang <jasowang@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        Gautam Dawar <gautam.dawar@xilinx.com>,
        Parav Pandit <parav@nvidia.com>, Eli Cohen <elic@nvidia.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vduse: Validate vq_num in vduse_validate_config()
Message-ID: <20221128070238-mutt-send-email-mst@kernel.org>
References: <20221128083627.1199512-1-harshit.m.mogalapalli@oracle.com>
 <20221128105312.3ajursuudvmysiie@sgarzare-redhat>
 <Y4SUOPX2WRFiuB7n@kadam>
 <20221128111310.6exrqi26grwspqcz@sgarzare-redhat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128111310.6exrqi26grwspqcz@sgarzare-redhat>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 12:13:10PM +0100, Stefano Garzarella wrote:
> On Mon, Nov 28, 2022 at 01:58:00PM +0300, Dan Carpenter wrote:
> > On Mon, Nov 28, 2022 at 11:53:12AM +0100, Stefano Garzarella wrote:
> > > On Mon, Nov 28, 2022 at 12:36:26AM -0800, Harshit Mogalapalli wrote:
> > > > Add a limit to 'config->vq_num' which is user controlled data which
> > > > comes from an vduse_ioctl to prevent large memory allocations.
> > > >
> > > > This is found using static analysis with smatch.
> > > >
> > > > Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> > > > Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> > > > ---
> > > > v1->v2: Change title of the commit and description, add a limit to
> > > > 	vq_num.
> > > >
> > > > Note: I think here 0xffff is the max size of vring =  no: of vqueues.
> > > > Only compile and boot tested.
> > > > ---
> > > > drivers/vdpa/vdpa_user/vduse_dev.c | 3 +++
> > > > 1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > index 35dceee3ed56..31017ebc4d7c 100644
> > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > @@ -1440,6 +1440,9 @@ static bool vduse_validate_config(struct vduse_dev_config *config)
> > > > 	if (config->config_size > PAGE_SIZE)
> > > > 		return false;
> > > >
> > > > +	if (config->vq_num > 0xffff)
> > > 
> > > What about using U16_MAX here?
> > 
> > Where is the ->vq_num stored in a u16?  I looked for this but didn't
> > see it.
> 
> I thought vq_num referred to the number of elements in the vq (like
> .get_vq_num_max), since this patch wants to limit to 0xffff.
> 
> But it actually refers to the number of virtqueue, so @Harshit why do we
> limit it to 0xffff?
> 
> Maybe we should explain it in the commit message or in a comment.
> 
> Thanks,
> Stefano

This limit is somewhat arbitrary.
However, currently virtio pci and ccw are limited to a 16 bit vq number.
While MMIO isn't it is also isn't used with lots of VQs due to
current lack of support for per-vq interrupts.
Thus, the 0xffff limit on number of VQs corresponding
to a 16-bit VQ number seems sufficient for now.

Feel free to put the above in a code comment.

-- 
MST

