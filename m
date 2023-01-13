Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5BD66A2B5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 20:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjAMTMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 14:12:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjAMTMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 14:12:25 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BE638AE
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:12:23 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-4d4303c9de6so147606957b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5iYIwF91luR1VZkU1kFZWYlc/TF+s0pTovA3mLd0lqA=;
        b=hddSQOS//qdQ19X2kZYXTd0mWRpEk4u7YwwDO4WLuBHsHLlzrUxcrDSaa5dHUimcjy
         s69l9mUWoN2A964v9h9Md6s9NAE/2+HeZj11EE8aks0f3Hd/dDQttfuOQCjyCmq7Pwrp
         vo0+OA8NXH7iIPW1T9GdGMCK+e/Ms4pU9PCu3b7ce76Y4sxCchUBERqfJgRoWuu8YLUR
         wuf3neZOPxtSixAes71yxvXuoKfayR7bH3zTuFs8YkuczGEWguYHIFKrxbg+/6/PE7nx
         Y46vvshIFKydrTwfeGYXo15MQuLMSq6k1xUK94rbLI9JGotaYrW0ENpex81ERXN3w/Rx
         +Cog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5iYIwF91luR1VZkU1kFZWYlc/TF+s0pTovA3mLd0lqA=;
        b=Yg3dWKwJD3Az2T9X9OEEybsgd7Ei6XBxIUsnZDv3JOCt0O5a4QEIes1yWMq4mtdS+n
         J6DPN/4CPWGViKYg+y4Izr5OhL14eknKWusjP+LYzBjsiOZsKxfXUMkVa0DiMxDL7mmn
         ahEOg8/OfbQtth4mJ7imIkJuVnyq5NCJTpRKv4ZqFGwpXM1bAqZqwzInEpDKf2LvtmMW
         onlWgKVCh1uNnk9gaapRnURwgcYwOX4UnT196UuWrjeCh++sTCLihSG1NEZZp9vRvz7D
         F4lPbj/6617JG+fjnTdB0R7GuhGeBv5nS99bAo7c8qYirhX/USA/3puBkKvWXCOADqV0
         cWqA==
X-Gm-Message-State: AFqh2kq6Wfsfmvw4Fb1JQOlh6bct3pUhGoSViOW9KzAg5WiRZO90iiVa
        CyNFNzI7BcQe74civzFxXybs3u8mtsD0bdc6
X-Google-Smtp-Source: AMrXdXsum8aqm1WNhNOBVlO48D1fGi+7wn4gYXl7+Vzmlg3sRxY54ROiPYFHuAbab2aFSRZT5DBGDw==
X-Received: by 2002:a81:4e0d:0:b0:4dc:6471:9bf1 with SMTP id c13-20020a814e0d000000b004dc64719bf1mr4705770ywb.32.1673637143071;
        Fri, 13 Jan 2023 11:12:23 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-50-193.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.50.193])
        by smtp.gmail.com with ESMTPSA id m15-20020a05620a24cf00b007055dce4cecsm13393336qkn.97.2023.01.13.11.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 11:12:22 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1pGPTR-00Afl3-V8;
        Fri, 13 Jan 2023 15:12:21 -0400
Date:   Fri, 13 Jan 2023 15:12:21 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Sven Peter <sven@svenpeter.dev>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] iommu/ipmmu-vmsa: Remove ipmmu_utlb_disable()
Message-ID: <Y8GtFcNq2jugBpI3@ziepe.ca>
References: <20230113185640.8050-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230113185640.8050-1-joro@8bytes.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 07:56:40PM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> The function is unused after commit 1b932ceddd19 ("iommu:
> Remove detach_dev callbacks") and so compilation fails with
> 
> drivers/iommu/ipmmu-vmsa.c:305:13: error: ‘ipmmu_utlb_disable’ defined but not used [-Werror=unused-function]
>   305 | static void ipmmu_utlb_disable(struct ipmmu_vmsa_domain *domain,
>       |             ^~~~~~~~~~~~~~~~~~
> 
> Remove the function to fix the compile error.
> 
> Fixes: 1b932ceddd19 ("iommu: Remove detach_dev callbacks")
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  drivers/iommu/ipmmu-vmsa.c | 12 ------------
>  1 file changed, 12 deletions(-)

I'm surprised the 0-day bot didn't notice?

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
