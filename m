Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D55E733A72
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 22:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245658AbjFPUJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 16:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbjFPUJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 16:09:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8975830DD
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 13:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686946096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9FHIShx3ok7ttiJLXRHQNT2AZWHVgsob1KG47xjdjeI=;
        b=WtRbrUAyO+m3eICftPmvarLYZUAf7mkoXsDZ17qid9CGwz8ZomVIDweKN+OuBQGhaJajaN
        wdrAvOxqKA7PsN07qGZu0uHAVCmuyOZAgVCJ4mVgk3S+5sCuBeETSouHwDqnMByajBIMmY
        POHRAEdXncd8uRakzy7mLAwrq1tqscw=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-FdbquxTJNJGUPsSWP9s5jw-1; Fri, 16 Jun 2023 16:08:14 -0400
X-MC-Unique: FdbquxTJNJGUPsSWP9s5jw-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-76998d984b0so88354239f.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 13:08:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686946093; x=1689538093;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9FHIShx3ok7ttiJLXRHQNT2AZWHVgsob1KG47xjdjeI=;
        b=dMc2axFtFyD29hNYhzdXay+hTIEA9MruH/jZ0FsWQ83NQBiLnOW75sqhsLtkkB6YeW
         lBp8Y+L9bnfk5vNaNx3naRWkh1ymoa95ytJUDExCL+LannHrP86KfIt0dZ0IdCNb8x7Q
         kb9d7LlPAlM4XYD+YOCuM2a0df2H4l9I2DB+DBAJRWwF1qCYEYes7nzBqvPefmdVmnhy
         3oq2H3hQbwVwxp1ozWk0gX/njAeA/OQJMvIfCSutLTUalSkfFTk6A/2Ve+nc1Nqc3Ffy
         nw4O1kVvdh7vx4nywH5aqrIGbg9AfJz8GRDwg1cYWpCytkc3GyM1ooIjmgzwQu+eoIBZ
         JpPA==
X-Gm-Message-State: AC+VfDwIgXw/Wxn6pxXIBtG+yqvKhuvgxOjf777mNm4PwpbPSBbr4qwF
        HF6F7u9hZ4kORCh667OewaY1DQPo36K0c4tSY21ZxaOn9hoIY6YxhvXBLFGFRl/mBWRdX7QpEKb
        Uy4buYE2Tq6mahkoM/QSieCnZ
X-Received: by 2002:a5e:a918:0:b0:76c:785f:8f82 with SMTP id c24-20020a5ea918000000b0076c785f8f82mr215181iod.6.1686946093473;
        Fri, 16 Jun 2023 13:08:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ62AjDXsrpmoKuXzeKWjRip2U0KfskgmXJGtEvG25rkOe8Yfqf6qCIZQe8RWyPyKG/yPo2gRA==
X-Received: by 2002:a5e:a918:0:b0:76c:785f:8f82 with SMTP id c24-20020a5ea918000000b0076c785f8f82mr215166iod.6.1686946093279;
        Fri, 16 Jun 2023 13:08:13 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id s17-20020a6bdc11000000b007635e28bc11sm6820694ioc.6.2023.06.16.13.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 13:08:12 -0700 (PDT)
Date:   Fri, 16 Jun 2023 14:08:11 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Nipun Gupta <nipun.gupta@amd.com>
Cc:     <jgg@ziepe.ca>, <linux-kernel@vger.kernel.org>,
        <kvm@vger.kernel.org>, <masahiroy@kernel.org>, <nathan@kernel.org>,
        <ndesaulniers@google.com>, <nicolas@fjasle.eu>, <git@amd.com>,
        <harpreet.anand@amd.com>, <pieter.jansen-van-vuuren@amd.com>,
        <nikhil.agarwal@amd.com>, <michal.simek@amd.com>
Subject: Re: [PATCH v7] vfio/cdx: add support for CDX bus
Message-ID: <20230616140811.548d2c92.alex.williamson@redhat.com>
In-Reply-To: <20230531124557.11009-1-nipun.gupta@amd.com>
References: <20230531124557.11009-1-nipun.gupta@amd.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 May 2023 18:15:57 +0530
Nipun Gupta <nipun.gupta@amd.com> wrote:

> vfio-cdx driver enables IOCTLs for user space to query
> MMIO regions for CDX devices and mmap them. This change
> also adds support for reset of CDX devices. With VFIO
> enabled on CDX devices, user-space applications can also
> exercise DMA securely via IOMMU on these devices.
> 
> This change adds the VFIO CDX driver and enables the following
> ioctls for CDX devices:
>  - VFIO_DEVICE_GET_INFO:
>  - VFIO_DEVICE_GET_REGION_INFO
>  - VFIO_DEVICE_RESET
> 
> Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
> Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
> Tested-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
> ---
> 
> Changed to support driver managed dma in CDX bus has been
> submitted at:
> https://lore.kernel.org/lkml/20230117134139.1298-1-nipun.gupta@amd.com/T/
> 
> Changes v6->v7:
> - updated GFP_KERNEL to GFP_KERNEL_ACCOUNT in kcalloc
> - remove redundant error condition
> - updated return codes

Applied to vfio next branch for v6.5.  Thanks,

Alex

