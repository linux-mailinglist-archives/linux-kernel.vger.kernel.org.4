Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 500D85EFCF9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 20:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235766AbiI2SYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 14:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234863AbiI2SYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 14:24:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4017CBC2F
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 11:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664475874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BoITIusWH1pgiQYYyYgg2aTCkDBnXRgVNx9UWZzrGmA=;
        b=OqcMvHd+HH89EI8UXhMCTpgc95JY4q2oPDPDMHN+rG+xKoIKL6KQo3Q1ABrYRtnFvu41+l
        JiJvhpYBHgd7ITHa6cpubjXPTQdb3dxfutlcJURTUvmseF9waOP0/Zdcov0RCPcG3FaM2e
        gjF7RIegpRW3AWLNPVEbMpYzSyCj2xY=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-595-iobG7LLSPgeqOwTGfASlgQ-1; Thu, 29 Sep 2022 14:24:33 -0400
X-MC-Unique: iobG7LLSPgeqOwTGfASlgQ-1
Received: by mail-io1-f72.google.com with SMTP id j20-20020a6b3114000000b006a3211a0ff0so1222747ioa.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 11:24:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=BoITIusWH1pgiQYYyYgg2aTCkDBnXRgVNx9UWZzrGmA=;
        b=M60sh5vR308rwJbBZQkYXgDoDlsS47UL/zdYkMXcoKcrF3nliwwSRX91RsvtYm0YKt
         /pCNaTdJ/jq6V2oFxItGyR/R6W4FLNGKLBAm8gTgMWyvfo+JUB5uR8HmRvEyM9J5d4ax
         EF/Fs8WnoYEe6ApGH7P8T4AJWpv1H98zt2dFQh2cY/fun4A0LEu8rcoyg5si/q9OpbrE
         IXBaKq0uMaKnhxs2VDwaqzo4dgHVoVjveZcwbTHUROZR4Gn+RnW7kFjJUb4ZuAoHtlw/
         KzBL3wmu4vg92IkbWBwqwPJLBzXBGSavdy0NNafE8xO1UiW0R9OZNh3ZKXGIMlGh/BrP
         ozGg==
X-Gm-Message-State: ACrzQf3lXpyz68MQLw1yGvsCbhj80SNHd56JK7O+/y+/q/aKFIkMattj
        UXFYde74sl0sbQ7hQfgXu3GImjqc2wyY0/anhaxDjK9JCJ+YQ8+QZFWDQ6Ei3ifvRZ0ClhkjFKd
        NvW9oYPBD4rrTOSyvAY6oNPcw
X-Received: by 2002:a05:6e02:19ce:b0:2f1:68a6:3bec with SMTP id r14-20020a056e0219ce00b002f168a63becmr2392077ill.78.1664475872942;
        Thu, 29 Sep 2022 11:24:32 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7KUOQo8AbbarGobEgnbxdcS5bS2mn744LEcpjpU+rvkCIe35jyhAfEJ5Pm5FWlRH0iLBHEPg==
X-Received: by 2002:a05:6e02:19ce:b0:2f1:68a6:3bec with SMTP id r14-20020a056e0219ce00b002f168a63becmr2392060ill.78.1664475872712;
        Thu, 29 Sep 2022 11:24:32 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id f13-20020a05660215cd00b006a1fed36549sm96051iow.10.2022.09.29.11.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 11:24:31 -0700 (PDT)
Date:   Thu, 29 Sep 2022 12:24:27 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Kevin Tian <kevin.tian@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Longfang Liu <liulongfang@huawei.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Eric Auger <eric.auger@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Abhishek Sahu <abhsahu@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v4 15/15] vfio: Add struct device to vfio_device
Message-ID: <20220929122427.3a3bca9a.alex.williamson@redhat.com>
In-Reply-To: <YzXaxPpkc+90Xx+T@ziepe.ca>
References: <20220921104401.38898-1-kevin.tian@intel.com>
        <20220921104401.38898-16-kevin.tian@intel.com>
        <20220929105519.5c9ae1d8.alex.williamson@redhat.com>
        <YzXaxPpkc+90Xx+T@ziepe.ca>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Sep 2022 14:49:56 -0300
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Thu, Sep 29, 2022 at 10:55:19AM -0600, Alex Williamson wrote:
> > Hi Kevin,
> > 
> > This introduced the regression discovered here:
> > 
> > https://lore.kernel.org/all/20220928125650.0a2ea297.alex.williamson@redhat.com/
> > 
> > Seems we're not releasing the resources when removing an mdev.  This is
> > a regression, so it needs to be fixed or reverted before the merge
> > window.  Thanks,  
> 
> My guess at the fix for this:
> 
> https://lore.kernel.org/r/0-v1-013609965fe8+9d-vfio_gvt_unregister_jgg@nvidia.com

Indeed this seems to work  I'll look for acks and further reviews from
Intel folks. Thanks!

Alex

