Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0F663A67F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 11:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbiK1K6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 05:58:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiK1K6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 05:58:10 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1352659F
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 02:58:05 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id v7so8177927wmn.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 02:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RJWW55YirRAop5qsW7MfjO2Cb/aqkPmNR9CcfbISB+E=;
        b=dQofxjLXnoc26i6nPlHarHAeQE6K5JdlUoYIAkYWqQ8OXVXhxrGTV0CsAzSp9FAFfc
         ljgf/9Z5HMDjT5FBdCeba0HMsdGRRUcITsxBBfxHvxrdvz1OBRvG7Pc8cy3yNY/ivjKm
         DkVNSkmq+PorGOWtELShs5PNDK5NTyTUlbQ/yAQP1KVme6tU24kh0jaJtUxU0mBtJHy3
         93wDB9IiAO6YRBk4zV1xntDX0jF8k6h3AyEQ5ol/bIKFtQiLif+b1bctn82MFVGYEO6R
         xgbD/zDRIbWvCPvO4xS6TRUNQYIjppGIMbBrqjD2EKDeboZ9xHFcWVdBZJTctIcyLns7
         7O1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJWW55YirRAop5qsW7MfjO2Cb/aqkPmNR9CcfbISB+E=;
        b=HBgqJFVQzkkAbArwWGJvYKWRLrC0Uv0jJb3H7Og2E/OewPtxei+viA/TbXqZAxMpZu
         Sbi5nBAyIpdfV8i+DsRhpfIvw8/FCWrhX7On5qcqd0Yr70ZoZX2JA3g/7NPR7/8NdXU2
         kDB8f/fT7y1hqUu4EEIK0bSfStEy7IuL5w5jAO9Yh/dq0lnnGqOtMot/KBgmURzQ+dlL
         JPAuGu4/5WylLeTe4LjFI6n3xbI6WwKO4ALA/embF+T5HX9HttDyL9NnYPyp4B/utyCG
         q9qbOpqQ5sxiGFDQf9GjKHqc87PBhMWnZk5efj7tCyDqpHXS5vBapwj1eR10NZWAXJC5
         TIWQ==
X-Gm-Message-State: ANoB5pnwYkKycxecLTWfNpxAhK1VWkSDWQMnR0a9H3jLhPIlCp9dBCwh
        tLaImGhyfnMp4AWl1H30V4o=
X-Google-Smtp-Source: AA0mqf5IuTik8Ro64P5r5SVtIhAVcxG64UqWcuZ3jHH4R3pdS13JJ8pHu6w6RIoMm8uCUUUYLeF6ig==
X-Received: by 2002:a05:600c:5406:b0:3d0:21f6:43ec with SMTP id he6-20020a05600c540600b003d021f643ecmr26996220wmb.162.1669633084216;
        Mon, 28 Nov 2022 02:58:04 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id j15-20020a5d452f000000b002416e383e1csm10601418wra.25.2022.11.28.02.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 02:58:03 -0800 (PST)
Date:   Mon, 28 Nov 2022 13:58:00 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        harshit.m.mogalapalli@gmail.com,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        Gautam Dawar <gautam.dawar@xilinx.com>,
        Parav Pandit <parav@nvidia.com>, Eli Cohen <elic@nvidia.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vduse: Validate vq_num in vduse_validate_config()
Message-ID: <Y4SUOPX2WRFiuB7n@kadam>
References: <20221128083627.1199512-1-harshit.m.mogalapalli@oracle.com>
 <20221128105312.3ajursuudvmysiie@sgarzare-redhat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128105312.3ajursuudvmysiie@sgarzare-redhat>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 11:53:12AM +0100, Stefano Garzarella wrote:
> On Mon, Nov 28, 2022 at 12:36:26AM -0800, Harshit Mogalapalli wrote:
> > Add a limit to 'config->vq_num' which is user controlled data which
> > comes from an vduse_ioctl to prevent large memory allocations.
> > 
> > This is found using static analysis with smatch.
> > 
> > Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> > ---
> > v1->v2: Change title of the commit and description, add a limit to
> > 	vq_num.
> > 
> > Note: I think here 0xffff is the max size of vring =  no: of vqueues.
> > Only compile and boot tested.
> > ---
> > drivers/vdpa/vdpa_user/vduse_dev.c | 3 +++
> > 1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> > index 35dceee3ed56..31017ebc4d7c 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -1440,6 +1440,9 @@ static bool vduse_validate_config(struct vduse_dev_config *config)
> > 	if (config->config_size > PAGE_SIZE)
> > 		return false;
> > 
> > +	if (config->vq_num > 0xffff)
> 
> What about using U16_MAX here?

Where is the ->vq_num stored in a u16?  I looked for this but didn't
see it.

regards,
dan carpenter

