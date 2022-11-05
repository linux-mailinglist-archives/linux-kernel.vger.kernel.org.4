Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A6161A6B0
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 02:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiKEBgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 21:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiKEBg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 21:36:27 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6C93FBB2
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 18:36:27 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id l6so5993394pjj.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 18:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UlpIERxktULlh61Fyw4EChQNh/rwsViL1kaSCYfVIQ0=;
        b=bMVL7bS8QQ9MG2vqCoAIUVBnMLnPACYil2ZaTiMBZC8BmwZqDeVJ3yYOzSVz6lGQ2s
         YKYV3XBMu088T05AOFBeNqxQMcYvJ5ubln7mevmoWmjCutaFGy1JQpjez5ghSwUv7Dhd
         YJCkpSoK5/4Kta2AN+ri0uw12d5C8FU05Fiqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UlpIERxktULlh61Fyw4EChQNh/rwsViL1kaSCYfVIQ0=;
        b=nZcAXMNWFCM06MvD4DeyXcw7BLe4HxritsBIDh+N1AXihk3tzKFYq1i5r1B0z7n4+B
         gTVH0vvSKIoUI42iZaVfXNuxfa+qZuC38XAXXFmIDEn5RC2rD+8AH4mFxj9vML1jrJpy
         dl94m8mLGNCL9TXDtj21I9vfHslKD/cr/PzrEa7CgkBYVub3KppdmEcwURu2gAM5Ftuz
         ENXyYjAkE9954Z5wK8noVpN7tCAt2i7LawQrsXHGtU1O5BIIwBCeKhjIK1BFsGhSv8N8
         ff5iTkriWU/p9PIO3qiQV16ZRM2MYrpIj4gQrPbCdksT55TQVV6Hp1nc+wcgw51Fl6tH
         EOOA==
X-Gm-Message-State: ACrzQf3InmAGFAbLb2tSmaXRcA5vDR57jP2StsB4KS1T4T0DvZPGwrbo
        nz89SG0s4qdzx7RNvR2CnnBUemkqAixhZg==
X-Google-Smtp-Source: AMsMyM7egzA34TbfNzwbJXF9p4DvUQBXJw7NGr9dvOVIrtAR3OfhLz4m+niOS4RaB3jc18ab2REGYg==
X-Received: by 2002:a17:90b:4b09:b0:213:32e3:24ed with SMTP id lx9-20020a17090b4b0900b0021332e324edmr56209126pjb.109.1667612177698;
        Fri, 04 Nov 2022 18:36:17 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:db3:7e2d:1c04:dd29])
        by smtp.gmail.com with ESMTPSA id p27-20020aa79e9b000000b0056cc99862f8sm247398pfq.92.2022.11.04.18.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 18:36:17 -0700 (PDT)
Date:   Fri, 4 Nov 2022 18:36:15 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: Avoid races around device probe
Message-ID: <Y2W+DxePm8WcUn46@google.com>
References: <1946ef9f774851732eed78760a78ec40dbc6d178.1667591503.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1946ef9f774851732eed78760a78ec40dbc6d178.1667591503.git.robin.murphy@arm.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 07:51:43PM +0000, Robin Murphy wrote:
> We currently have 3 different ways that __iommu_probe_device() may be
> called, but no real guarantee that multiple callers can't tread on each
> other, especially once asynchronous driver probe gets involved. It would
> likely have taken a fair bit of luck to hit this previously, but commit
> 57365a04c921 ("iommu: Move bus setup to IOMMU device registration") ups
> the odds since now it's not just omap-iommu that may trigger multiple
> bus_iommu_probe() calls in parallel if probing asynchronously.
> 
> Add a lock to ensure we can't try to double-probe a device, and also
> close some possible race windows to make sure we're truly robust against
> trying to double-initialise a group via two different member devices.
> 
> Reported-by: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/iommu.c | 28 ++++++++++++++++++++++------
>  1 file changed, 22 insertions(+), 6 deletions(-)

If I've tested appropriately (there's always room for operator error),
this seems to resolve the problems I reported:

Tested-by: Brian Norris <briannorris@chromium.org>

I haven't reviewed closely enough to know how precisely this is a
regression (your description sounds like you think the bug existed some
time before that), but based on testing, this sounds like:

Fixes: 57365a04c921 ("iommu: Move bus setup to IOMMU device
registration")

But even if not, the report could probably use:

Link: https://lore.kernel.org/lkml/Y1CHh2oM5wyHs06J@google.com/

And most of all, thanks!

Brian
