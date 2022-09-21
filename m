Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218FD5BF80B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 09:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbiIUHpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 03:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiIUHpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 03:45:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA9354C86
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 00:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663746315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dka7ikJW3cdVu+mfUaScxh1T5dkEGzUcye3LFm9YYq0=;
        b=Qb+pQTDG1RiT7SJ9ZHbGulL+FM2stGYJbSEQGMSTvUJ+T9+1f2HPSCNVx2T3LvPlh9T6sn
        bWg9sc+HX24I6s4tCJMg9zNqXfw63XVLaUeBk9gil9rzt7hOG8LsEA1o54J6nR/2juQcxQ
        9npo+1+Egs7PgWvvS75M7ULIxi4OII8=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-564-X0i2sbNYOUyMlpgJHkfUQA-1; Wed, 21 Sep 2022 03:45:14 -0400
X-MC-Unique: X0i2sbNYOUyMlpgJHkfUQA-1
Received: by mail-oo1-f69.google.com with SMTP id x22-20020a4a3956000000b004748ff8c4b4so2319527oog.13
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 00:45:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=dka7ikJW3cdVu+mfUaScxh1T5dkEGzUcye3LFm9YYq0=;
        b=a7B+3Q65OEavdDUsYef4/VuHCJslOnOJCba9hKf4ap6u+G8WqM21DqhRUbrCkcwNK0
         vSt0m4Psm+nB6DSLsQiu8GIYFfuesVm3tF9cBwcOzJRyQi7j8+TPfSGm1szY6zCwWjs1
         0WJ+HKlhDadWCwwj74e1dQmBjXrI298G3w3Wbc45P26f0/f10cUcczRNOyow4/LB+Q3z
         3bYmflrZ5OwJYl4vaRFErx/Paim99S6PI3ov+WNAfYgNWMn9mMt5AcCBj/R3mYlyW9mm
         bP9FLaX18qmUke3/TNXBdtDkTwTYuczg8od5HoAq5MkQp1Jp21FDz0H8kod23DMBjtai
         TOwg==
X-Gm-Message-State: ACrzQf3/09nzfcGD3YQJc+6WgNbO8qAwHCi3QOvv6r4azyda8a78CQ9s
        vswFUHdh022bSuQBZSiVMMqGPJ4f6oyV2HuDF2JpGF/VA/v++Zkxnad08kR+Y79FXSnC2T6VLxG
        0wART+S3t7yp2Sg5zQUtkYEGqPsrD6z+ejOD5ojCb
X-Received: by 2002:a05:6808:1b22:b0:350:c0f6:70ff with SMTP id bx34-20020a0568081b2200b00350c0f670ffmr3207372oib.35.1663746313485;
        Wed, 21 Sep 2022 00:45:13 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7/OA5L9rNQz8LUbTthCKywcVV8UKYEhEXKNNedafXnV7ZqB2YNPQyTkE+NzRi24V/LpyM8mNQyMkM0qS11xuU=
X-Received: by 2002:a05:6808:1b22:b0:350:c0f6:70ff with SMTP id
 bx34-20020a0568081b2200b00350c0f670ffmr3207365oib.35.1663746313279; Wed, 21
 Sep 2022 00:45:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220915085048.12840-1-jasowang@redhat.com> <PH0PR12MB548115F4597D409F94AB1E77DC4C9@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB548115F4597D409F94AB1E77DC4C9@PH0PR12MB5481.namprd12.prod.outlook.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 21 Sep 2022 15:45:02 +0800
Message-ID: <CACGkMEshK=GoBivM-mHbFBAtvqTQKF-WMwTKvDRxJ70WjVebdA@mail.gmail.com>
Subject: Re: [PATCH 0/3] vdpa: device feature provisioning
To:     Parav Pandit <parav@nvidia.com>
Cc:     "mst@redhat.com" <mst@redhat.com>, Eli Cohen <elic@nvidia.com>,
        "si-wei.liu@oracle.com" <si-wei.liu@oracle.com>,
        "wuzongyong@linux.alibaba.com" <wuzongyong@linux.alibaba.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "eperezma@redhat.com" <eperezma@redhat.com>,
        "lingshan.zhu@intel.com" <lingshan.zhu@intel.com>,
        "gdawar@xilinx.com" <gdawar@xilinx.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "xieyongji@bytedance.com" <xieyongji@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 3:17 AM Parav Pandit <parav@nvidia.com> wrote:
>
> Hi Jason,
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Thursday, September 15, 2022 4:51 AM
> > To: mst@redhat.com; jasowang@redhat.com
> > Cc: Eli Cohen <elic@nvidia.com>; si-wei.liu@oracle.com; Parav Pandit
> > <parav@nvidia.com>; wuzongyong@linux.alibaba.com;
> > virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org;
> > eperezma@redhat.com; lingshan.zhu@intel.com; gdawar@xilinx.com;
> > lulu@redhat.com; xieyongji@bytedance.com
> > Subject: [PATCH 0/3] vdpa: device feature provisioning
> >
> > Hi All:
> >
> > Virtio features are neogiated between the device and the drivers. This allows
> > the mediation layer like vDPA to hide some features from the driver to
> > faciliate the cross vendor live migration:
> >
> > vDPA on the source supports feature set X vDPA on the destination supports
> > feature set Y
> >
> > Management can simply provision the vDPA instance with features X&Y on
> > both source and destination to let the vDPA can be migrate-able between
> > the two vDPA devies with different features support.
> >
> > This series tries to allow the device features to be provisioned via netlink to
> > achieve this.
> Very useful series.
> Can you please add vdpa example command with and without -jp option in each of the commit logs?

Yes, I will do it in V2.

Thanks

>
> Thanks.
>

