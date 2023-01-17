Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD9C66E036
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 15:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbjAQOUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 09:20:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbjAQOT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 09:19:56 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38ABA3C2AF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 06:19:52 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id g9so12582280qtu.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 06:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IS/YCAtDJfZYt4KhjJik/M0wgHMLxEYwy3qImzZ7s5o=;
        b=jt487WYlTBPy7KS7BW5/Xw7TwxhYvHsVXi9wgFVHv7nUupnlFGxUHww65F9PHNZSTK
         IiMziOlEHGUQKA+X/uwE/IGU9swVNLan25OD75e6aqVujD9SNYawp1ZVA/8C0nYksTKK
         2ITcoyjeBVbiZF5XTYLzhEJ+PcZSg0ViSwmLzlfpAk7AsBv9UBQNHAK1gBb9XLsJoce5
         Sxc0oTiD8MpbpUKbOcG/QIFEbMWZKFCKCAUdDlk4ccpmmvjKdZPB/cl0o6SAzW5KZfBg
         DFaL3TNnHsQ/FiJLRbfySLJ1+pRE8sH3yIFCcg0+K7tBlETWLSOFmkaLrzRliOE7Da9p
         Smbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IS/YCAtDJfZYt4KhjJik/M0wgHMLxEYwy3qImzZ7s5o=;
        b=Vdleq0I1zmavy5mf3rb0ymzFBGdapiJH22iUWye/rbDgkzsh1vy03MCx3yScvYZ30X
         nsNFB0PIHxnGf3WOOU4Y2uMWK+sJiaJWgHaX7I9wvlLazME2Q9h2Gd7HbwdcMOyVIAlG
         BYYWwbj0f80wREQlJUhDf3/3deh9VV8YxNKyjOE1JEwimBvGH2lPIZC6Ezw2rLpjZ2eV
         Oz1sDgS5gV4Mqy4V+j4ik3kFdJwoUZhkkd7Pr3AHgGNTywgmRhcsPWMEfIv3tqXBOPaD
         /rdzjWLOez+PO87lcpphEecTT8hIPOlJ1CM7n9Mf6V4baBAl4at47/TKZkir7bbU/Q89
         utbQ==
X-Gm-Message-State: AFqh2kouxE4GXaLU1TUvntg48HQ2ZwXAz7LGwOd+0+asaqgNqJ23aUKr
        C6iYmtRu4EpGyJleAeJEKF8eTg==
X-Google-Smtp-Source: AMrXdXvHjQ21F0zkg5M7NF1gtglTVRGFVCe3l6bOSzS4kEZrhWsWxR5T0lZij2vVT7JnCvQAlUgxgA==
X-Received: by 2002:ac8:45ce:0:b0:3b6:326f:b69c with SMTP id e14-20020ac845ce000000b003b6326fb69cmr3724557qto.1.1673965191362;
        Tue, 17 Jan 2023 06:19:51 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-50-193.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.50.193])
        by smtp.gmail.com with ESMTPSA id o5-20020a05620a2a0500b006f9e103260dsm20640820qkp.91.2023.01.17.06.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 06:19:50 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1pHmoY-00CnzW-07;
        Tue, 17 Jan 2023 10:19:50 -0400
Date:   Tue, 17 Jan 2023 10:19:49 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        joro@8bytes.org, robin.murphy@arm.com, ashish.kalra@amd.com,
        thomas.lendacky@amd.com, vasant.hegde@amd.com, jon.grimm@amd.com
Subject: Re: [PATCH 3/4] iommu: Introduce IOMMU call-back for processing
 struct KVM assigned to VFIO
Message-ID: <Y8auhTCZBJWkG/FL@ziepe.ca>
References: <20230110143137.54517-1-suravee.suthikulpanit@amd.com>
 <20230110143137.54517-4-suravee.suthikulpanit@amd.com>
 <Y8F6Uoi73BK6R+mc@ziepe.ca>
 <6d57350a-6d07-42d7-2b1d-153bf5847b0f@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d57350a-6d07-42d7-2b1d-153bf5847b0f@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 12:31:07PM +0700, Suthikulpanit, Suravee wrote:
> Hi Jason,
> 
> On 1/13/2023 10:35 PM, Jason Gunthorpe wrote:
> > On Tue, Jan 10, 2023 at 08:31:36AM -0600, Suravee Suthikulpanit wrote:
> > > Currently, VFIO provide an kvm_vfio_file_set_kvm() interface for assigning
> > > a KVM structure to a VFIO group. The information in struct KVM is also
> > > useful for IOMMU drivers when setting up VFIO domain.
> > > 
> > > Introduce struct iommu_domain_ops.set_kvm call-back function to allow
> > > IOMMU drivers to provide call-back to process the struct KVM
> > > assigned.
> > 
> > Also NAK
> > 
> > Connecting the iommu driver to KVM has to be properly architected
> > though iommufd.
> > 
> 
> My understanding is the kvm_vfio_file_set_kvm() from the following
> call-path:
> 
> * kvm_vfio_group_add()
> * kvm_vfio_group_del()
> * kvm_vfio_destroy()
> 
> to attach/detach KVM to/from a particular VFIO domain. 

No, it has nothing to do with a VFIO domain.

It is intended to connect the KVM to a VFIO device for use in
architecture specific ways (primarily s390), and to support
broken-by-design code in GVT's mdev.

We currenly have no connection between kvm and the iommu domain at
all.

> Could you please elaborate what you have in mind for a properly architected
> interface via iommufd?

You'd need to explain what this is trying to do. As I said, I want to
see a comprehensive VFIO solution for CC from the people interested in
it that supports all three major architectures currently available. I
really don't want to see three different almost-the-same but
unmaintainable different versions of this.

Frankly I'm really not clear what role the IOMMU driver should be
playing in CC at all, certainly not with details about what AMD's
design requires.

AFAIK ARM expects the the IOMMU will be controlled by the realm
manager. How can AMD be different from this and still be secure? The
translation of IOVA for DMA is a security critical operation. I would
expect the KVM page table and the IOMMU S2 to be hardwired together.

So if you need hypervisor involvment you need to start there by
defining what exactly your architecture needs for iommu programming
and create a special iommu_domain that encapsulates whatever that is.

> > > @@ -1652,6 +1652,7 @@ void vfio_file_set_kvm(struct file *file, struct kvm *kvm)
> > >   	mutex_lock(&group->group_lock);
> > >   	group->kvm = kvm;
> > > +	iommu_set_kvm(group->iommu_group, kvm);
> > >   	mutex_unlock(&group->group_lock);
> > >   }
> > 
> > This also has obvious lifetime bugs
> 
> Could you please also elaborate on this part? For detaching case, KVM is
> NULL, and the same information is passed to the IOMMU driver to handle the
> detaching case. Am I missing anything?

The kvm pointer is only valid so long as the group_lock is held.

Jason
