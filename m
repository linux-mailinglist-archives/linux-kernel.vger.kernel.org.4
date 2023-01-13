Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2969B669CAE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 16:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjAMPpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 10:45:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjAMPpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:45:15 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D16377AF2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 07:35:48 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id s5so14857939qtx.6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 07:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FYVvKGHEE+oYnjn9skOttBAneMTWe58z8SoKkGSeO2g=;
        b=AioQo+qFcyZG3CO2jiZc3Oky6EkI6b7DYFOaA5yUUD+57NQVLhlSpIYuX90mAKOkWn
         vZQEZ5Aivi6SFgc+gpMXuTS1GLAt8mfhj1UJjbi7uXRykqdIrhhjq/dc3b/jYL1OOZ6I
         mmA3n/Teh2lZPVQY1OV4p6XFNnhcLKLAVlhhssJA9E2oXosvGpIKSINbi0TjKQEPocQh
         1sBa3PhHSaCR1w7IB1KlLBSy1pEd56tnZgsztraOvMr6uc1BoGUpTyS31W7SBEJ/n0A+
         WrgqigH8xE4y9+qGZfuRssUMSfZCpJEixzgcrAaxpjYLWtp7TpAVZYNn3UMH9UpFf41m
         AmYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FYVvKGHEE+oYnjn9skOttBAneMTWe58z8SoKkGSeO2g=;
        b=cmRCWYIReoiGCj3IaShLScUo8DkUL8bBWtCafPvvyshST+fgGbP5ZdrCqFrMeQ2ZED
         l9ppNPp4jRJppAB9Y2Z3MhgQ/2/6pNsvH1HUaCT98UvodUo0hYrgekIETKSpRh963yZx
         aZFxFLE2rwF+0SCPiaguK+F7dDxg2RVkv7fP+6GrcWDlWxtbVSY7QVd599kxSFRxy6S4
         BaDZh0zANDrGgCo8EF1zD6qLiTh9UMAaywvj+Iu2lKqDtlNJc0kgzv4FiABj7YLS92E2
         n2gJMudwqxfIm8NVhj7wAr2bXiCHxCztrWZFNMk3CU2iOqlQoHj0+ma0FClpXXZWOL+d
         0FBw==
X-Gm-Message-State: AFqh2koi07ObTgu5gWvsch4B+wrq1MbbXc+1HQumIWNOmAtIMcyXTe0c
        JV9Ibq+iQlKppdVP9WKxQn7YZGvLxNMfuEPP
X-Google-Smtp-Source: AMrXdXv/q++WAk09vRl8JM5uJg5HSfaNv1rW3L1eILGDWoEFZU1DLcO+a+YmZ3RNsHsAmqh8/AdE0A==
X-Received: by 2002:ac8:6c7:0:b0:3a7:f424:d1bb with SMTP id j7-20020ac806c7000000b003a7f424d1bbmr19820385qth.21.1673624147503;
        Fri, 13 Jan 2023 07:35:47 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-50-193.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.50.193])
        by smtp.gmail.com with ESMTPSA id jt14-20020a05622aa00e00b003adc7f652a0sm7087732qtb.66.2023.01.13.07.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 07:35:46 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1pGM5q-00AJnI-CF;
        Fri, 13 Jan 2023 11:35:46 -0400
Date:   Fri, 13 Jan 2023 11:35:46 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        joro@8bytes.org, robin.murphy@arm.com, ashish.kalra@amd.com,
        thomas.lendacky@amd.com, vasant.hegde@amd.com, jon.grimm@amd.com
Subject: Re: [PATCH 3/4] iommu: Introduce IOMMU call-back for processing
 struct KVM assigned to VFIO
Message-ID: <Y8F6Uoi73BK6R+mc@ziepe.ca>
References: <20230110143137.54517-1-suravee.suthikulpanit@amd.com>
 <20230110143137.54517-4-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110143137.54517-4-suravee.suthikulpanit@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 08:31:36AM -0600, Suravee Suthikulpanit wrote:
> Currently, VFIO provide an kvm_vfio_file_set_kvm() interface for assigning
> a KVM structure to a VFIO group. The information in struct KVM is also
> useful for IOMMU drivers when setting up VFIO domain.
> 
> Introduce struct iommu_domain_ops.set_kvm call-back function to allow
> IOMMU drivers to provide call-back to process the struct KVM
> assigned.

Also NAK

Connecting the iommu driver to KVM has to be properly architected
though iommufd.

> @@ -1652,6 +1652,7 @@ void vfio_file_set_kvm(struct file *file, struct kvm *kvm)
>  
>  	mutex_lock(&group->group_lock);
>  	group->kvm = kvm;
> +	iommu_set_kvm(group->iommu_group, kvm);
>  	mutex_unlock(&group->group_lock);
>  }

This also has obvious lifetime bugs

Jason
