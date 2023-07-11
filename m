Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC6B74F1AA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjGKOTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjGKOTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:19:30 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDF91FC6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:19:01 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-66f5faba829so3287159b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1689085137; x=1691677137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dv6dpDGQjr71q1bN/lbW9GuGtuBzZo7bmAZPkqqGTBo=;
        b=gmJTHGcXpbnuUZLGkDrhJQ47+LLzkVlh8slDsu3vUaO+hfYUiC9aXipQJc59x6IglI
         Ogg8RfX1gi3hSz4XZW00bsahw7U4DsKpZTUCSs2UN4wGAh4P7b0WWKQvAGTVr+7Kiqbt
         rzQO4aObFvDM0HcoFETQ7EZ32BIgDahJSpCx+mVXrMS5G//6MyT/3EuQNFLbzRUPelvf
         dnxunj59WVK/TSTp/2lqac81bxyaYdbjuq9R53PmJFG/VKB8DCMfOcSSTVJszFjrGEn3
         HoWEf1ggbzV7mW3YBVPff6FKScIXb84lETn/LFJ9SctBxkhBIhVEkBRsgfCxfAqPcS0q
         9LzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689085137; x=1691677137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dv6dpDGQjr71q1bN/lbW9GuGtuBzZo7bmAZPkqqGTBo=;
        b=fEzlwi2UmuP+qXDvhIkGaMkdsWOFCPPD8xRn/yjWuU0xXj1aFmTSVqk7zCHJo4CvkK
         xedN+TBIw+dcX3hBlSGsYiCAT3rclSsrC5RCr/Klx082udjexPrNMYFhOR8hCQeWRA1L
         U2E9T72wViVZSFzQfvDPl/LgaOjnk51LC2eFN+K0Vy417By4tG14lB+AHB+ZK/A6nxeY
         5QEoB2mmgRMgBqp98L8+ojZ6SZcAyHjOBOoGoENkeBjdArrP+iSTDmJcr6pelkgdPLWj
         0XfnMpi7JRsvCqhy9u1CwrgMtFuoC5thkV5QUu/i/qI/JW3rAVOi2CBiLbIbkY6mPrq1
         pN8w==
X-Gm-Message-State: ABy/qLaKOMf8I5t2rVbR5cfR6N3PYi8/8ubkaDNVQeuVQMIl+aV1z67x
        mggxjxqM4B5tAdi6QM5pkKPciw==
X-Google-Smtp-Source: APBJJlECZpsM7dUkJEiPSoM9Sbh/e5i6HlXOsuPwcIZztMyqTFWCyi9iFfM0i97yLHg+jHZgnctPlg==
X-Received: by 2002:a05:6a20:7da7:b0:132:7d4a:34b5 with SMTP id v39-20020a056a207da700b001327d4a34b5mr1028671pzj.37.1689085136930;
        Tue, 11 Jul 2023 07:18:56 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id i23-20020aa78b57000000b00662610cf7a8sm1798466pfd.172.2023.07.11.07.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 07:18:56 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qJECc-000AW6-Pr;
        Tue, 11 Jul 2023 11:18:54 -0300
Date:   Tue, 11 Jul 2023 11:18:54 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Tina Zhang <tina.zhang@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Michael Shavit <mshavit@google.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 5/6] iommu: Support mm PASID 1:1 with sva domain
Message-ID: <ZK1kzlAoGg8qayrT@ziepe.ca>
References: <20230707013441.365583-1-tina.zhang@intel.com>
 <20230707013441.365583-6-tina.zhang@intel.com>
 <ZKw/xS7wOoRvNfnH@ziepe.ca>
 <6e88db76-6903-cb7b-b608-811a97986592@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e88db76-6903-cb7b-b608-811a97986592@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 10:43:43AM +0800, Baolu Lu wrote:
> On 2023/7/11 1:28, Jason Gunthorpe wrote:
> > > @@ -88,31 +98,41 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
> > >   		goto out_unlock;
> > >   	}
> > > -	if (domain) {
> > > -		domain->users++;
> > > -		goto out;
> > > +	if (unlikely(domain)) {
> > > +		/* Re-attach the device to the same domain? */
> > > +		if (domain == sva_domain) {
> > > +			goto out;
> > > +		} else {
> > > +			/* Didn't get detached from the previous domain? */
> > > +			ret = -EBUSY;
> > > +			goto out_unlock;
> > > +		}
> > >   	}
> > And if we do all of this we should just get rid of the horrible
> > iommu_get_domain_for_dev_pasid() entirely.
> 
> At the core level, we have no idea about whether an sva domain allocated
> for one device is compatible with another device. Hence, we should loop
> the sva domains in the list and if the attach interface feeds back
> -EINVAL's (not compatible), we should allocate a new domain for the
> attached device and put it in the list if the new attachment is
> successful.

Yes, generally.

It would be good to undertand if the drivers desire one sva domain per
instance or one sva domain per driver - but with this approach it
becomes a driver choice which to use. I would guess that one sva
domain per instance is slightly simpler in the drivers..

iommu_get_domain_for_dev_pasid() turns into a check if the group
already has a SVA domain bound from a list, ie we turn it upside down
and have it search the list under the xa_lock instead of trying to
return a domain pointer back out.

Jason
