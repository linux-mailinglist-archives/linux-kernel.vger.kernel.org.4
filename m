Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037E56CF798
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 01:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjC2XmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 19:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjC2XmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 19:42:05 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DC04C13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 16:42:02 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id cn12so13397244qtb.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 16:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1680133321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M7C+py6MtCoeCMOtw25BrlCO3RIdyKIetyPlMUWcAxQ=;
        b=or5zOdb0THcrHSRrNF/aWpqr5y5XACt17c51B2fuOW5sIxoj2mxKk9QPCHXd0weuMi
         hnjPrhDD9X00VxhDRyGWzEdQaeUnYGGNVBIvm9NdJ0z50h4PG9uK/AbqfIt+KuEViqwk
         JMM5cDJ2p6Ibr/BwfCk3C1SKBmRh1EslZACPJQ899Ch1m4XCYwbv+spFie8OO9H1NGMd
         dSWXfMR537z5wT9f+bGJgtTobSqzNyVbAqczhBYbiJ434wSDGKN+LAwp1+ntSjG3vP2F
         N7qWsyB3f+eC4E5HMMZTbKMLErH/sElNNBOzKtXz/YGwiDkAtAAhK+4KWLoTciVd0//H
         yxpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680133321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M7C+py6MtCoeCMOtw25BrlCO3RIdyKIetyPlMUWcAxQ=;
        b=M7I5IGS/k/P9tAbhojzBTmM9Q5h4IkItA3lDo0vgN/2FuqxX7wk7BYBq8LQDdIhWIS
         rfd563ytSvIFPEUqEeASKNuaUROuP4Cq+5owAqpP/big55wO8TzC+8ljBX4F6CXYHnvf
         yZIypVva/U9ggakpI81Sd5gNX4CNwdXlcMHnlsA5++nYY4WBWwIhLzqNW36IHUB7eTEY
         lLHfTsBvlLqU/1Fq9lbTyAeuiQdg5Zeqz5RQ2L4eEJvGiuQM5xSmAfx6LELoFEdEaQ56
         uN40lpODHtcR7q+Z4tayIyReNA+i3KWwoJWQmfrLefwVg2USABewy3pkGIg9cuE8URyC
         IhWw==
X-Gm-Message-State: AO0yUKUhF8K6wPQppeCLGBpafb+8r7Vn8Vkyr60veKW7OrYkwVFt9rnq
        DnE34chl8HY/oMl6Rlf0R6PQzf2tdEclP8U6pKg=
X-Google-Smtp-Source: AK7set/r+pGsJrPMn0D9D6pkZb7SUCn2k/XDNs/gApUMrPEx0RFz+B78D/mL8S9HzmDoO+y4IPCuSQ==
X-Received: by 2002:a05:622a:1ba3:b0:3e3:98b5:69c2 with SMTP id bp35-20020a05622a1ba300b003e398b569c2mr26020425qtb.62.1680133321368;
        Wed, 29 Mar 2023 16:42:01 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id h22-20020ac85056000000b003d5aae2182dsm8863730qtm.29.2023.03.29.16.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 16:42:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1phfQW-004hQQ-86;
        Wed, 29 Mar 2023 20:42:00 -0300
Date:   Wed, 29 Mar 2023 20:42:00 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Steven Price <steven.price@arm.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2] iommu/rockchip: Add missing set_platform_dma_ops
 callback
Message-ID: <ZCTMyHifYJfGZqRg@ziepe.ca>
References: <20230324111127.221640-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324111127.221640-1-steven.price@arm.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 11:11:27AM +0000, Steven Price wrote:
> Similar to exynos, we need a set_platform_dma_ops() callback for proper
> operation on ARM 32 bit after recent changes in the IOMMU framework
> (detach ops removal). But also the use of a NULL domain is confusing.
> 
> Rework the code to have a singleton rk_identity_domain which is assigned
> to domain when using an identity mapping rather than "detaching". This
> makes the code easier to reason about.
> 
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
> Changes since v1[1]:
> 
>  * Reworked the code to avoid a NULL domain, instead a singleton
>    rk_identity_domain is used instead. The 'detach' language is no
>    longer used.
> 
> [1] https://lore.kernel.org/r/20230315164152.333251-1-steven.price%40arm.com
> 
>  drivers/iommu/rockchip-iommu.c | 50 ++++++++++++++++++++++++++--------
>  1 file changed, 39 insertions(+), 11 deletions(-)

Aside from the pm stuff this looks OK to me

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Thanks,
Jason
