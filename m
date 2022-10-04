Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4195F45BF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 16:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiJDOkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 10:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiJDOj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 10:39:56 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40122BC06;
        Tue,  4 Oct 2022 07:39:55 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id m81so14621082oia.1;
        Tue, 04 Oct 2022 07:39:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=C9mbynAWhlZLPcnxIkEkUheYSWevkrIWO3ImSHgFO3g=;
        b=aPWmumn63KfCi4DzqKxKDgUKewcEQJUhF5VuL+VWDaVTrgLIQeF99zC1sQzSdI2vVF
         zRNUC+MzjlfqWAgKGkQ7oH9+xhXzph9B82JMaq/HQvwF1kPW9PCJ+l+odz1JNYVMVab9
         BZ2fjBtxMX/qQ3d3vnXKN19OSPhKDomkrnsIMTMo/He08spWpmKeh75LS9gytIqcGBzV
         F5jQWMWji11GfqK3t5NH8EEdAiuERUtCOGaveyqTNKnZam5HlNvaIgf+PsRj1L+mf8lD
         WSIa3JecVgl9wJ0WIK9X/kUYUjO5a/BSUwIP1SvFOBiWpcxJ17zXpjJz0vo+fDGHEefW
         DdKw==
X-Gm-Message-State: ACrzQf3hduLZ5CK81c8J177SN9KPqYUXEt3FOQQtVK1trOAJkC1yt8dH
        GSTIk/bIFZ/mtb+PmEDvTA==
X-Google-Smtp-Source: AMsMyM4dYcbq8JBg1woswaO8pn7/MT/46qINQGQkx4GKIMhjqDJZvKjz8PjYZXzhbcBzLHD36o8Bgw==
X-Received: by 2002:a05:6808:23c5:b0:34f:bba7:2949 with SMTP id bq5-20020a05680823c500b0034fbba72949mr34434oib.101.1664894394472;
        Tue, 04 Oct 2022 07:39:54 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s37-20020a0568302aa500b00636a8dafdc9sm3059486otu.2.2022.10.04.07.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 07:39:54 -0700 (PDT)
Received: (nullmailer pid 1480570 invoked by uid 1000);
        Tue, 04 Oct 2022 14:39:54 -0000
Date:   Tue, 4 Oct 2022 09:39:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Christoph Hellwig <hch@lst.de>,
        Stefano Stabellini <stefanos@xilinx.com>,
        Bruce Ashfield <bruce.ashfield@xilinx.com>
Subject: Re: [PATCH v9 4/4] remoteproc: virtio: Create platform device for
 the remoteproc_virtio
Message-ID: <20221004143954.GA1479221-robh@kernel.org>
References: <20220921135044.917140-1-arnaud.pouliquen@foss.st.com>
 <20220921135044.917140-5-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921135044.917140-5-arnaud.pouliquen@foss.st.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 03:50:44PM +0200, Arnaud Pouliquen wrote:
> Define a platform driver to manage the remoteproc virtio device as
> a platform devices.
> 
> The platform device allows to pass rproc_vdev_data platform data to
> specify properties that are stored in the rproc_vdev structure.
> 
> Such approach will allow to preserve legacy remoteproc virtio device
> creation but also to probe the device using device tree mechanism.
> 
> remoteproc_virtio.c update:
>   - Add rproc_virtio_driver platform driver. The probe ops replaces
>     the rproc_rvdev_add_device function.
>   - All reference to the rvdev->dev has been updated to rvdev-pdev->dev.
>   - rproc_rvdev_release is removed as associated to the rvdev device.
>   - The use of rvdev->kref counter is replaced by get/put_device on the
>     remoteproc virtio platform device.
>   - The vdev device no longer increments rproc device counter.
>     increment/decrement is done in rproc_virtio_probe/rproc_virtio_remove
>     function in charge of the vrings allocation/free.
> 
> remoteproc_core.c update:
>   Migrate from the rvdev device to the rvdev platform device.
>   From this patch, when a vdev resource is found in the resource table
>   the remoteproc core register a platform device.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  drivers/remoteproc/remoteproc_core.c     |  12 +-
>  drivers/remoteproc/remoteproc_internal.h |   2 -
>  drivers/remoteproc/remoteproc_virtio.c   | 143 ++++++++++++-----------
>  include/linux/remoteproc.h               |   6 +-
>  4 files changed, 82 insertions(+), 81 deletions(-)

[...]

> +/* Platform driver */
> +static const struct of_device_id rproc_virtio_match[] = {
> +	{ .compatible = "virtio,rproc" },

This is not documented. Add a binding schema if you need DT support.

> +	{},
> +};
> +
> +static struct platform_driver rproc_virtio_driver = {
> +	.probe		= rproc_virtio_probe,
> +	.remove		= rproc_virtio_remove,
> +	.driver		= {
> +		.name	= "rproc-virtio",
> +		.of_match_table	= rproc_virtio_match,
> +	},
> +};
