Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AABD7367A0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 11:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbjFTJYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 05:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbjFTJYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:24:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8A6D1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 02:24:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4AC5861034
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 09:24:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F120C433C0;
        Tue, 20 Jun 2023 09:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687253073;
        bh=9N6EIJ38Xk+9+ewliRVUBI3DulDbnvVkXDhlrDbSKFI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kBn50GNBszeGoHi+Y44dG5B218OG3oc1Ieqb86NZDmEckz0UkrdXEq1YD16W0OeZe
         ocWl4ntMap/XL6+QUsZagw6La/LVOW/Vihvm01pIjp748HGGWXYmd8H9qfmbIIXmm4
         RGa6oWj2VJi69vCgQLzSrABBIcQIxWl8GH8oUq70=
Date:   Tue, 20 Jun 2023 11:24:30 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Prathu Baronia <prathubaronia2011@gmail.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Khadija Kamran <kamrankhadijadj@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, dan.carpenter@linaro.org,
        error27@gmail.com, lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        oe-kbuild@lists.linux.dev
Subject: Re: [PATCH v6 1/2] axis-fifo: use devm_kasprintf() for allocating
 formatted strings
Message-ID: <2023062015-snipping-wanted-276b@gregkh>
References: <ZI/5H+GZU6/2osGT@redkillpc>
 <20230619162246.33007-1-prathubaronia2011@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619162246.33007-1-prathubaronia2011@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2023 at 09:52:44PM +0530, Prathu Baronia wrote:
> In various places, string buffers of a fixed size are allocated, and
> filled using snprintf() with the same fixed size, which is error-prone.
> 
> Replace this by calling devm_kasprintf() instead, which always uses the
> appropriate size.
> 
> Signed-off-by: Prathu Baronia <prathubaronia2011@gmail.com>
> ---
> V5 -> V6: Split into api change and name change commits
> V4 -> V5: Remove the dev_info() and use a unique identifier for dev name
> V3 -> V4: Split into warning fixing and cleanup commits
> V2 -> V3: Fix smatch warnings from kernel test robot
> V1 -> V2: Split into logical commits and fix commit message
> 
>  drivers/staging/axis-fifo/axis-fifo.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
> index 7a21f2423204..7d8da9ce2db8 100644
> --- a/drivers/staging/axis-fifo/axis-fifo.c
> +++ b/drivers/staging/axis-fifo/axis-fifo.c
> @@ -816,10 +816,6 @@ static int axis_fifo_probe(struct platform_device *pdev)
>  	 * ----------------------------
>  	 */
>  
> -	device_name = devm_kzalloc(dev, 32, GFP_KERNEL);
> -	if (!device_name)
> -		return -ENOMEM;
> -
>  	/* allocate device wrapper memory */
>  	fifo = devm_kzalloc(dev, sizeof(*fifo), GFP_KERNEL);
>  	if (!fifo)
> @@ -857,7 +853,11 @@ static int axis_fifo_probe(struct platform_device *pdev)
>  	dev_dbg(fifo->dt_device, "remapped memory to 0x%p\n", fifo->base_addr);
>  
>  	/* create unique device name */
> -	snprintf(device_name, 32, "%s_%pa", DRIVER_NAME, &r_mem->start);
> +	device_name = devm_kasprintf(dev, GFP_KERNEL, "%s_%p", DRIVER_NAME, &r_mem->start);

As Dan points out, you are changing the name here :(

