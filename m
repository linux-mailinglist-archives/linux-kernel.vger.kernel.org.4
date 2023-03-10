Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056716B3FC4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 13:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjCJMz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 07:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCJMyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 07:54:54 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626D77A84
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 04:54:53 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id v16so4992033wrn.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 04:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678452892;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b0ospi7hAz+YOXFhrcdrmC0AaEAavOtedBIMfZumahw=;
        b=S/embe4vV/aUjhx0hf78tsuqzg4I9LW1TABo3WKf3Hn0NoAUycBwCqiaehEFyDTrbT
         sz484eR+p5i+W+sk8RE+Vxapu3B4oz9hr90IXE+/fJeCRjSbVDdj3sTf2k9KThyTu7Ma
         idPDGLY17oNRfsmL+0ulcaVgbziP85JUTfY7pbrOzIqtmQ68pbed5oD3KhYdw7I1Trb6
         a3z1KxDONrTwVY8IZKUI9EgPcv5nRyN+gLJet4b6fV9oENCuVXC/t3mYymJeqGmwAZfI
         zJbWsZ4Kw9y43Nm1ikrPXOpUcSL4iaQsRD7pmXRUaiZggPArQJMDWk5H6G7FZKSVIbDE
         vuFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678452892;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b0ospi7hAz+YOXFhrcdrmC0AaEAavOtedBIMfZumahw=;
        b=q3QK0EcuEaFwsQ0kKAq+xIn9Wt/zX26VPEf1+A3Q1ZJ2g6X8fp3dhkUOnjNAZLmYyi
         PPkVxMiPPkE0C6GxlyACKarlqrd+BEW+8TureMkwHLWgCcBxWZdyPPIP0htfJBPS4w86
         S9/jbckojBLVwsxDPGQ62TFO4WNpcCdCPAvCsCqPGVv+1pVj32eTU1PC2HV2p+PxTGSV
         BHIGLk/xSiVyWKZuIaT1Aj9qKTVVJyPryDIk/8ZeOEqVmemRMMuD/YSRBlYHBXw4m+OW
         gVEIjBK/GwW433/EnFscu5bhqkqMcghWdhpVJrhiH8ZTNsQCQ8XG4/69METTbzwexxSB
         EmwA==
X-Gm-Message-State: AO0yUKWEAUG4iJeYGfn33TDKECJLQiWRKrPrZ5Nq+/DDtKC66m6EW2jj
        NAc6H+TxUfrQQX8au2QKeTDbnA==
X-Google-Smtp-Source: AK7set9QopboGBXW0L86P0Njeyu3ao51+5KPjvl3aAAxvX6GWgngEgPHqEMQjQqR8jTfSWeVmOBXpg==
X-Received: by 2002:a5d:5344:0:b0:2cc:5ee8:fee5 with SMTP id t4-20020a5d5344000000b002cc5ee8fee5mr17048523wrv.71.1678452891891;
        Fri, 10 Mar 2023 04:54:51 -0800 (PST)
Received: from myrica (054592b0.skybroadband.com. [5.69.146.176])
        by smtp.gmail.com with ESMTPSA id t15-20020adfe10f000000b002c5526234d2sm2089144wrz.8.2023.03.10.04.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 04:54:51 -0800 (PST)
Date:   Fri, 10 Mar 2023 12:54:53 +0000
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, robin.murphy@arm.com,
        will@kernel.org, eric.auger@redhat.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, joro@8bytes.org,
        shameerali.kolothum.thodi@huawei.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, yi.l.liu@intel.com
Subject: Re: [PATCH v1 02/14] iommufd: Add nesting related data structures
 for ARM SMMUv3
Message-ID: <20230310125453.GB1745536@myrica>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <364cfbe5b228ab178093db2de13fa3accf7a6120.1678348754.git.nicolinc@nvidia.com>
 <20230309134217.GA1673607@myrica>
 <ZAnx0lUkw02cVTi+@nvidia.com>
 <ZAq3LJgbo8ApejvU@Asurada-Nvidia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAq3LJgbo8ApejvU@Asurada-Nvidia>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 08:50:52PM -0800, Nicolin Chen wrote:
> On Thu, Mar 09, 2023 at 10:48:50AM -0400, Jason Gunthorpe wrote:
> 
> > Nicolin, I think we should tweak the uAPI here so that the
> > invalidation opaque data has a format tagged on its own, instead of
> > re-using the HWPT tag. Ie you can have a ARM SMMUv3 invalidate type
> > tag and also a virtio-viommu invalidate type tag.
> 
> The invalidation tage is shared with the hwpt allocation. Does
> it mean that virtio-iommu won't have it's own allocation tag?

I'm not entirely sure what you mean by allocation tag. For example with
SMMU, when attaching page tables (SMMUv2), the guest passes an ASID at
allocation, and when it modifies that address space it passes the same
ASID for invalidation. When attaching PASID tables (SMMUv3), it writes the
ASID/PASID in the PASID table, and passes both in the invalidation.

Note that none of this is set in stone. It copies the Linux API we
originally discussed, but we were waiting for progress on that front
before committing to anything. Now we'll probably align to the new API
where possible, leaving out what doesn't work for virtio-iommu.

Thanks,
Jean

