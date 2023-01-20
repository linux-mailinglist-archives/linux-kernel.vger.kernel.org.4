Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5F3675836
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 16:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjATPLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 10:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjATPLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 10:11:32 -0500
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BEC5080BA6;
        Fri, 20 Jan 2023 07:11:31 -0800 (PST)
Received: from 8bytes.org (p5b006afb.dip0.t-ipconnect.de [91.0.106.251])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 7EDEB2628DF;
        Fri, 20 Jan 2023 16:11:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1674227490;
        bh=3kxvogQXz1g+FrZuw43iM0YtoqpaustpLZ6efuvtDwA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=idDsgB5UMdxJQ3U59ZwOvtVDRJuWYS8XDZKc1+KP1ItQtJjXCJFtlZfq7aEXgYHO1
         Fsslo77XyeqLHIC1VOb72jZ0kba1vj1m+ks6QHyKGXbO/tA13GOeOmlgeQ9/y3zNUr
         XrYBixWDQ4CakVXKrDbNqkSjc+eoZYRoSfsybOZV408NKrIIlF6sPLMSNES9QGLGk1
         zWFJnlDYrbrkTh3l7eaBGUrl5++0C9p2Yhk+AjpIcdmoxe22+LB0tqcVsQWPDp8XXM
         TvGGAxAd/6JTrLfKNHXZ+qiHHBd3On5DFQ2FX7JfjWrJT4KFgUQWv5bA4nM78kKGJE
         odchpgKWwtY0A==
Date:   Fri, 20 Jan 2023 16:11:29 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH v2 0/6] iommu/sun50i: Allwinner D1 support
Message-ID: <Y8qvIRXcCdLZjDCK@8bytes.org>
References: <20230103010903.11181-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103010903.11181-1-samuel@sholland.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Samuel,

On Mon, Jan 02, 2023 at 07:08:57PM -0600, Samuel Holland wrote:
> Samuel Holland (6):
>   dt-bindings: iommu: sun50i: Add compatible for Allwinner D1
>   iommu/sun50i: Track masters attached to the domain
>   iommu/sun50i: Keep the bypass register up to date
>   iommu/sun50i: Support variants without an external reset
>   iommu/sun50i: Add support for the D1 variant
>   riscv: dts: allwinner: d1: Add the IOMMU node

There is a conflict between these patches and changes in the IOMMU core
branch. With those merged in there is a compile warning about
sun50i_iommu_detach_domain() being unused. Fixing that requires removing
of 3-4 functions, which I am not sure is the right solution.

I pushed the arm/allwinner branch out to the iommu tree (with the core
branch merged in) and exluded it from next for now. Can you please have
a look and fix this up in a way that does not break the driver?

Once this is fixed I will include the arm/allwinner branch into my next
branch again.

Thanks,

	Joerg
