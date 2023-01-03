Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B492E65CA3D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 00:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234165AbjACXNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 18:13:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233335AbjACXNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 18:13:00 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FDA14D1B
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 15:13:00 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id m12so16009400qvq.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 15:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tz3yFtNFzzGkwABV122YXiYemg/f9Py/y3zMd9l0kjs=;
        b=K8BFjmCv4SP0O1UgUJEke3gZvrhshL0Th//Uv3fh3mghbZpd19cfYKoqfId3IMB1jT
         i2QfvVbIpgA6oZwFgqWizRXZ2bMkJ/bcYDrMXJ0GeU+qj8vOuMMvW+/l74inPalTpnom
         U/rvIfD2Txzbn7s1ZqZzIbNi/H4p6t3cTuL5aiDQll/5aV3Xys6v/nlt8lN3Z5Qi+eRJ
         vvAfe/zLtGNxRAp1/J9tXuNlOMI8HUuDltGio3CMy6SWqv23HoFisneDWiGqypNO6TEn
         p6Ij9lLf3OyIC/6fHbOhy6/m2B3QVaWK/1uo+4fH8R8wm2uTtGi/l1NU/SJhr1A8K5KU
         Kh7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tz3yFtNFzzGkwABV122YXiYemg/f9Py/y3zMd9l0kjs=;
        b=jsqilZ3oFIiMVHdvkUzgBa2kuMrAyn4y7V8vrAxS/xCCtcOnt9Jz+gYCLiFaiPSSVg
         rHFFBKFh/ZvcLyBGcEhUY3DRRElqCucxzCNszkKc3C1WxS3BquGCEvBYfHUTRp10TLPs
         Tj8MHzmAhehH2dOOslHJTeOwWerWgro+4vCBeMY8AqAE3JzTw9zsl5G/I+5zuxaC8Tri
         LlhioJLFkhtyXLwgDY4nTIUEEoB7jwgFkFiYzdCsWeD6SHjCKaTqpBJGUeRH5roXMpfE
         NTCxjGNQqd5IebnLSuRja3CQCJhI65qGNL6n80w8ou2oqTNYpPDffk8p1jY3q4xjvzQI
         h+YA==
X-Gm-Message-State: AFqh2koUtUkcaP0kyRM3l6I3CZahW0fmZWtEG03vWze+/++9RuuLqEXB
        JxaZkcNyv4LtfujOs9DvhfzZkQ==
X-Google-Smtp-Source: AMrXdXv/9OQoPmXf9qQIzU8Hfku2rK3T4lvHGb+hsDicfH3LE9m63GWJi2ZtfV+32khLMrvgjJF3pA==
X-Received: by 2002:a0c:ab54:0:b0:4c7:7a7e:8067 with SMTP id i20-20020a0cab54000000b004c77a7e8067mr26074197qvb.18.1672787579124;
        Tue, 03 Jan 2023 15:12:59 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-50-193.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.50.193])
        by smtp.gmail.com with ESMTPSA id bp13-20020a05620a458d00b006fefa5f7fc9sm22747831qkb.134.2023.01.03.15.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 15:12:58 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1pCqSo-001c73-3B;
        Tue, 03 Jan 2023 19:12:58 -0400
Date:   Tue, 3 Jan 2023 19:12:58 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: Fix refcount leak in iommu_device_claim_dma_owner
Message-ID: <Y7S2erhj3xWUR6xH@ziepe.ca>
References: <20230103063017.4022393-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103063017.4022393-1-linmq006@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 10:30:17AM +0400, Miaoqian Lin wrote:
> iommu_group_get() returns the group with the reference incremented.
> Also an empty @owner is a more serious problem than refcount leak.
> Move iommu_group_get() after owner check to fix the refcount leak.
> 
> Fixes: 89395ccedbc1 ("iommu: Add device-centric DMA ownership interfaces")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
> changes in v2:
> - Remove set NULL to group as suggested by Baolu Lu.
> - Update commit message according to Lu's explanation.
> ---
>  drivers/iommu/iommu.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Joerg, can you pick this for rc?

Thanks,
Jason
