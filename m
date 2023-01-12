Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35762667EC7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 20:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240258AbjALTLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 14:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237046AbjALTKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 14:10:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A2E68792
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 10:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673549731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jtq5mk2ZlcYdFm+jeVM9IkCUBXYGBGyXB70gjLkZDU4=;
        b=F/SCwAsZel3PQiBUqYVc3f0LBC+R3T0Op2XpiZ2uYMwYt4WT2A3FLI/AcjBAB52PDnfzSC
        j3XbKXWQyoCoVEM8lx2MlM6fhQdZhssN+BIKnHejxCyTQwvNeYF4ML2L0wAhw1gcHgl2ui
        IUQmLn9CWRdPpWst9UWpWQnQsp7+SN8=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-114-RGX5hrJ9MJKRl6BFUFtnnQ-1; Thu, 12 Jan 2023 13:55:30 -0500
X-MC-Unique: RGX5hrJ9MJKRl6BFUFtnnQ-1
Received: by mail-io1-f72.google.com with SMTP id u1-20020a5d8181000000b006ee29a8c421so11922088ion.19
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 10:55:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jtq5mk2ZlcYdFm+jeVM9IkCUBXYGBGyXB70gjLkZDU4=;
        b=b7FokGJ8YICs9Ne3JekDqBhmG5MVqM0K9qXpZH7xwLv+aQzDZukvETCl3O79o0zLai
         b6SMofkUSGjYzVMD0ze5Svz8SDiBJVhRFYunoC69NR08xO8Vho5gviaRus1DornSJWQP
         tX1brrHcrR6bJEHfIO4FnWczw4V+2Rrnm8nlnfr6Q71vsJs4nYFLx/3c8VBvE/KTnCLG
         ZehgraHKppDNY9W+ZUm3vI1d6Bst/RspTrjFPqzeMqQCkj5jCJWLTwXPyc0HKRRufubY
         orv1sxHuln+h6fDqDlshFvLQiuPJ5DG9h+KyRK/HtoialiOCatZRJSLZDYVPD8sFsQYw
         CtHQ==
X-Gm-Message-State: AFqh2kpiNaL09x1CmSYasYiGwfw4300wYOClslfgaD3bIpEwsrFT2rww
        WIHMzVDXaWOSOyRH0PC9IR7cgTUn7LZf3OqeROE6ux2Ach0wiZJzGAizlxiD8Laao9wb7bFA0kB
        HxOwqsixnBy/e3thym4OEhC4q
X-Received: by 2002:a6b:7310:0:b0:6e6:726a:bd80 with SMTP id e16-20020a6b7310000000b006e6726abd80mr5603558ioh.6.1673549729657;
        Thu, 12 Jan 2023 10:55:29 -0800 (PST)
X-Google-Smtp-Source: AMrXdXv2Omoym4TW6RhKNSuGY+azZ5RJJWKt9Sx5lS2g9n7QxoVXV5rnxv9X0KeND3aavwwXt7lEvA==
X-Received: by 2002:a6b:7310:0:b0:6e6:726a:bd80 with SMTP id e16-20020a6b7310000000b006e6726abd80mr5603547ioh.6.1673549729437;
        Thu, 12 Jan 2023 10:55:29 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id p2-20020a056638216200b0039e9628324csm2726266jak.20.2023.01.12.10.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 10:55:28 -0800 (PST)
Date:   Thu, 12 Jan 2023 11:55:27 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Cornelia Huck <cohuck@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        Christian =?UTF-8?B?Qm9ybnRyw6RnZXI=?= 
        <borntraeger@linux.ibm.com>
Subject: Re: [PATCH v3 1/1] vfio/type1: Respect IOMMU reserved regions in
 vfio_test_domain_fgsp()
Message-ID: <20230112115527.6d3e7026.alex.williamson@redhat.com>
In-Reply-To: <20230110164427.4051938-2-schnelle@linux.ibm.com>
References: <20230110164427.4051938-1-schnelle@linux.ibm.com>
        <20230110164427.4051938-2-schnelle@linux.ibm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jan 2023 17:44:27 +0100
Niklas Schnelle <schnelle@linux.ibm.com> wrote:

> Since commit cbf7827bc5dc ("iommu/s390: Fix potential s390_domain
> aperture shrinking") the s390 IOMMU driver uses reserved regions for the
> system provided DMA ranges of PCI devices. Previously it reduced the
> size of the IOMMU aperture and checked it on each mapping operation.
> On current machines the system denies use of DMA addresses below 2^32 for
> all PCI devices.
> 
> Usually mapping IOVAs in a reserved regions is harmless until a DMA
> actually tries to utilize the mapping. However on s390 there is
> a virtual PCI device called ISM which is implemented in firmware and
> used for cross LPAR communication. Unlike real PCI devices this device
> does not use the hardware IOMMU but inspects IOMMU translation tables
> directly on IOTLB flush (s390 RPCIT instruction). If it detects IOVA
> mappings outside the allowed ranges it goes into an error state. This
> error state then causes the device to be unavailable to the KVM guest.
> 
> Analysing this we found that vfio_test_domain_fgsp() maps 2 pages at DMA
> address 0 irrespective of the IOMMUs reserved regions. Even if usually
> harmless this seems wrong in the general case so instead go through the
> freshly updated IOVA list and try to find a range that isn't reserved,
> and fits 2 pages, is PAGE_SIZE * 2 aligned. If found use that for
> testing for fine grained super pages.
> 
> Fixes: af029169b8fd ("vfio/type1: Check reserved region conflict and update iova list")
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Applied to vfio for-linus branch for v6.2.  Thanks,

Alex

