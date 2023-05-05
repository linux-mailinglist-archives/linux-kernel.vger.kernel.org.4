Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A17C6F7BB6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 05:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjEED7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 23:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjEED7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 23:59:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F281208C
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 20:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683259128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tH+520r474W0EaWreOQEgyySbc0VeetwS26CDQJ8oaI=;
        b=KM4DQPlDJO8VNTAY/CdBTouQs1Kl4uoCa4W36WOsNeqWoLJ1TdLhvIwRThIfLTkuYkyFXm
        GtjA4pNP7w3AFPuaa0cdmidgFRahDJkOJ5DTL36veqEkHxF+qpj5wFiioqfprqc45yV60l
        YNDhQPzh/7JpKYVjWpfYE6PzZQOH0Lk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-EnjEk0-oMRCAsrApzikiFQ-1; Thu, 04 May 2023 23:58:47 -0400
X-MC-Unique: EnjEk0-oMRCAsrApzikiFQ-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-61e209243f7so6087896d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 20:58:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683259127; x=1685851127;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tH+520r474W0EaWreOQEgyySbc0VeetwS26CDQJ8oaI=;
        b=iLg+nMrwVGpF+VgnfQjiR9HzFnsxrZ/7EeTVhw3J0mzWWlIsh8MyOtbZRwG4cqZh6o
         jVc1fQIkn8U2jEAInhHBdKySBdUIDwN6D5YqSdJ30SQZ9cvvr6Wfex+LcpSeIUQIEKvZ
         Z78sF6W+gtm+gceeecbUtOBhsQWpssqFqZIKYA9f8iqNp1HVIa4TYNSENc/wP2UYl97j
         eaVgjFyVT0HL94mlNUmLLdXcs2zfucVNEnnhru9pLwbB+nGLpY1nUIBVa2qJXSyzxrHZ
         7qF0mf4zt4KdOIoVksawOKj3dnIWIxKk3/Rzdl3DxXCKFWdpsE/1f+E59XTMiDsUMBHQ
         8b3Q==
X-Gm-Message-State: AC+VfDzSLnrdINjlk9FA5ml5nqtQb/2fs1+EmIPKJcf+8/dkA7MFtZUh
        N4qA6t9+XJjsYQbctHBgoVPE34tw8QLTaGRWZUg9fRGljOLLuuZMDz0OEYpf9ejk1jlZdX/w21Y
        C52ns3J921MGnaR/InycPxOr14tbJiuB1
X-Received: by 2002:ac8:7dd0:0:b0:3d9:525d:f024 with SMTP id c16-20020ac87dd0000000b003d9525df024mr615921qte.28.1683259127006;
        Thu, 04 May 2023 20:58:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5HljWG5lKdnlv7HrzHEGfdqrCMyIpIUtW0Wyv9AWvnlrQpWhfgZvYO/v6iA+J6Gr157rfTCA==
X-Received: by 2002:ac8:7dd0:0:b0:3d9:525d:f024 with SMTP id c16-20020ac87dd0000000b003d9525df024mr615910qte.28.1683259126781;
        Thu, 04 May 2023 20:58:46 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id ca21-20020a05622a1f1500b003e68dfab0b4sm246722qtb.95.2023.05.04.20.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 20:58:46 -0700 (PDT)
Date:   Thu, 4 May 2023 20:58:44 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, jgg@nvidia.com, will@kernel.org,
        schnelle@linux.ibm.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] iommu: Make flush queues a proper capability
Message-ID: <nbkz5p4gvzzc5763j6iclsagjkf7jfmxlkcl5bmzfavigqu7wr@ey3ih27y2n2e>
References: <cover.1683233867.git.robin.murphy@arm.com>
 <ol6xsnchb5od2br6qor6mdm3b6jedtwlbivfvx46dwx5bwm56w@ub47yn62g4ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ol6xsnchb5od2br6qor6mdm3b6jedtwlbivfvx46dwx5bwm56w@ub47yn62g4ch>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2023 at 07:54:44PM -0700, Jerry Snitselaar wrote:
> On Thu, May 04, 2023 at 10:10:54PM +0100, Robin Murphy wrote:
> > Hi all,
> > 
> > Since it came up in discussion on the default domain series, it seemed
> > pertinent to dig this idea up, whcih I started a while ago, and finish
> > it off.
> > 
> > Cheers,
> > Robin.
> > 
> > 
> > Robin Murphy (2):
> >   iommu: Add a capability for flush queue support
> >   iommu: Use flush queue capability
> > 
> >  drivers/iommu/amd/iommu.c                   | 2 ++
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
> >  drivers/iommu/arm/arm-smmu/arm-smmu.c       | 4 ++--
> >  drivers/iommu/dma-iommu.c                   | 3 ++-
> >  drivers/iommu/intel/iommu.c                 | 2 +-
> >  drivers/iommu/iommu.c                       | 3 ++-
> >  include/linux/iommu.h                       | 6 ++++++
> >  7 files changed, 16 insertions(+), 6 deletions(-)
> > 
> > -- 
> > 2.39.2.101.g768bb238c484.dirty
> > 
> 

Tested-by: Jerry Snitselaar <jsnitsel@redhat.com> # amd, intel, smmu-v3

> Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> 

