Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2AB66062A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 19:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235017AbjAFSDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 13:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235584AbjAFSDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 13:03:46 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FBE76221
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 10:03:44 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-482363a1232so32613507b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 10:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eEZ+gYj0Aw+/KwbtFpG2nTsQkTPCh9mgBN01WMoyG9k=;
        b=OzVb12i+p6fOtM4DB2gKbTCs0cki5Fq0J8zbVCA9+s+IHVwl1v2mmg2tUA/kHlUeM5
         gcBf9BkwuXBfra9aw7I7qPxNWmrxVsGvsSTcYt5pN90lcNdU0LH4vR4vdKwXmqrkNEkB
         +7Porj92aplLQ7EHn/oUBeVP4iW3/97Oh9YiRMrZIWpVPHD8X8Sk9YNwEfxC9Yrn6OJ9
         hPFDDgCHhiK0K5LH75O2cjOc+ImE5x7gXfBCqHLXphTeiD1ODx384s3PExRjcoHS3UMc
         YtssPKyqW98lOUSghqORXRLNCgmVAkVRqRZg5Bqqt6nGR08THSoad7uCemzkmYOF7fE4
         I4Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eEZ+gYj0Aw+/KwbtFpG2nTsQkTPCh9mgBN01WMoyG9k=;
        b=xXKme1vnW5kyT+Ha6r6UNPWiFfpQsCpz5Ir/LPbZqHb3egWLGWtPitybG5IAEiza5C
         5Gujia2wQ/potmNjtQwV1cQ4OGKbhEDSxAlj+/Eq/e7GA54Adt7HBtVzzX7klBii36r0
         aQmX4zcKHWNKFp11dJmHy9/Q0udlpYOP9cPQjYW58Q5McOld5y0in1oX+jLQN1tLtzXh
         Hx7I574BSGGGwsPkekjyFmufmp16JnUjipUbtSnEJM6ptDkoY3h0DE6F+PRqNY7D5Dab
         Mx782myC84pvCR9BmaWGdc4t61nrYRWR+kLkrY0Pry6pX5MJ9sB0az0Uv9PbUaMp5ViX
         Gj7A==
X-Gm-Message-State: AFqh2kqdHyjMpJ6yddHko8CZE9B7Uh1iKnJYzrOn/3h1hfniRmtO5vSK
        h868cvjApFrLvY8W7VAU1vJkeQ==
X-Google-Smtp-Source: AMrXdXtnu9QwBw2wQNo31FczW5+WnhFlUNv8RYqwfNZOO2ksTfO54O6qmb9EFz86Ms57s9KHu+WGVg==
X-Received: by 2002:a05:7500:4c94:b0:ee:9be:ff3 with SMTP id la20-20020a0575004c9400b000ee09be0ff3mr3614532gab.68.1673028223580;
        Fri, 06 Jan 2023 10:03:43 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-50-193.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.50.193])
        by smtp.gmail.com with ESMTPSA id v14-20020a05620a0f0e00b006fbb4b98a25sm863965qkl.109.2023.01.06.10.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 10:03:43 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1pDr4A-006UoM-Fa;
        Fri, 06 Jan 2023 14:03:42 -0400
Date:   Fri, 6 Jan 2023 14:03:42 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        Christian =?utf-8?Q?Borntr=C3=A4ger?= <borntraeger@linux.ibm.com>
Subject: Re: [PATCH v2 1/1] vfio/type1: Respect IOMMU reserved regions in
 vfio_test_domain_fgsp()
Message-ID: <Y7hifk0RHT3tlqqW@ziepe.ca>
References: <20230104154202.1152198-1-schnelle@linux.ibm.com>
 <20230104154202.1152198-2-schnelle@linux.ibm.com>
 <20230106102450.2e6c70bb.alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230106102450.2e6c70bb.alex.williamson@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2023 at 10:24:50AM -0700, Alex Williamson wrote:

> > -	ret = iommu_map(domain->domain, 0, page_to_phys(pages), PAGE_SIZE * 2,
> > -			IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE);
> > -	if (!ret) {
> > -		size_t unmapped = iommu_unmap(domain->domain, 0, PAGE_SIZE);
> > +	list_for_each_entry(region, regions, list) {
> > +		if (region->end - region->start < PAGE_SIZE * 2 ||
> > +				region->start % (PAGE_SIZE*2))
> 
> Maybe this falls into the noise, but we don't care if region->start is
> aligned to a double page, so long as we can map an aligned double page
> within the region.  Maybe something like:

> 	dma_addr_t start = ALIGN(region->start, PAGE_SIZE * 2);
> 
> 	if (start >= region->end || (region->end - start < PAGE_SIZE * 2))
> 		continue;

Yeah, that is more technically correct

Jason
