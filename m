Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE8C66DFFC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 15:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjAQOJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 09:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbjAQOIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 09:08:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2BE3BDB0;
        Tue, 17 Jan 2023 06:08:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05A89B811D3;
        Tue, 17 Jan 2023 14:08:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CADBC433EF;
        Tue, 17 Jan 2023 14:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673964510;
        bh=eIuhZ2t7GHaGt8J8+DI3eJDdy374lZCmIPg23o8pegg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mmX3dk4vbIGXNEMkmKHwB4JGb/MG1VJnzUwJvGDThR21xxOPGsq+DnGl8KH4MN1Lo
         WtfbvDyyDMvEYdHtHnzYDSLWD3XPmpedZZTFU94EK0Vj7rht5DJ5qIJ8VniXD/Sdlp
         eWoPj+EouXPjTS0GyEVdOPz+abi43IfVXyg/y22Q=
Date:   Tue, 17 Jan 2023 15:08:23 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nipun Gupta <nipun.gupta@amd.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        rafael@kernel.org, eric.auger@redhat.com,
        alex.williamson@redhat.com, cohuck@redhat.com,
        song.bao.hua@hisilicon.com, mchehab+huawei@kernel.org,
        maz@kernel.org, f.fainelli@gmail.com, jeffrey.l.hugo@gmail.com,
        saravanak@google.com, Michael.Srba@seznam.cz, mani@kernel.org,
        yishaih@nvidia.com, jgg@ziepe.ca, jgg@nvidia.com,
        robin.murphy@arm.com, will@kernel.org, joro@8bytes.org,
        masahiroy@kernel.org, ndesaulniers@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        okaya@kernel.org, harpreet.anand@amd.com, nikhil.agarwal@amd.com,
        michal.simek@amd.com, git@amd.com
Subject: Re: [PATCH 04/19] bus/cdx: add MCDI protocol interface for firmware
 interaction
Message-ID: <Y8ar1+QfRR++YfKJ@kroah.com>
References: <20230117134139.1298-1-nipun.gupta@amd.com>
 <20230117134139.1298-5-nipun.gupta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117134139.1298-5-nipun.gupta@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 07:11:36PM +0530, Nipun Gupta wrote:
> +/** Request/Response structure */
> +#define MCDI_HEADER_OFST 0
> +#define MCDI_HEADER_CODE_LBN 0
> +#define MCDI_HEADER_CODE_WIDTH 7
> +#define MCDI_HEADER_RESYNC_LBN 7
> +#define MCDI_HEADER_RESYNC_WIDTH 1
> +#define MCDI_HEADER_DATALEN_LBN 8
> +#define MCDI_HEADER_DATALEN_WIDTH 8
> +#define MCDI_HEADER_SEQ_LBN 16
> +#define MCDI_HEADER_SEQ_WIDTH 4
> +#define MCDI_HEADER_RSVD_LBN 20
> +#define MCDI_HEADER_RSVD_WIDTH 1
> +#define MCDI_HEADER_NOT_EPOCH_LBN 21
> +#define MCDI_HEADER_NOT_EPOCH_WIDTH 1
> +#define MCDI_HEADER_ERROR_LBN 22
> +#define MCDI_HEADER_ERROR_WIDTH 1
> +#define MCDI_HEADER_RESPONSE_LBN 23
> +#define MCDI_HEADER_RESPONSE_WIDTH 1
> +#define MCDI_HEADER_XFLAGS_LBN 24
> +#define MCDI_HEADER_XFLAGS_WIDTH 8

<snip>

This whole file could use some tabs to align all of the values for the
defines to make it readable.  Any chance of doing that?

thanks,

greg k-h
