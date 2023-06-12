Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3676772C851
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 16:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238747AbjFLO0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 10:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238750AbjFLOYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 10:24:54 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2103B2971;
        Mon, 12 Jun 2023 07:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=7U3S3aDXoyTe2VWHCo8a2sFvGLCKSxzv9wHr91KGNO0=; b=mlMG+USSqkhzb3tGNwmjg/3lgb
        4s16zRKqyQci5db2fSOF3t8ekrg210WhvpedpUECrF0jpYaUTIqS6+3ePiRGv/Fw2FN1r3UAFprc4
        +Udzz3gZNf3f/jOU0IaBLMtOf0qnj/vsqg2XjzAFWLDDZsxwYClVql3A1TdzjEpTRTvk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1q8iQw-00Fc9V-I2; Mon, 12 Jun 2023 16:22:14 +0200
Date:   Mon, 12 Jun 2023 16:22:14 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Sarath Babu Naidu Gaddam <sarath.babu.naidu.gaddam@amd.com>
Cc:     richardcochran@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, vincent.cheng.xh@renesas.com,
        harini.katakam@amd.com, git@amd.com
Subject: Re: [PATCH] ptp: clockmatrix: Add Defer probe if firmware load fails
Message-ID: <9886bdc0-31be-4153-9b19-6dc53b0b8b5b@lunn.ch>
References: <20230612100044.979281-1-sarath.babu.naidu.gaddam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612100044.979281-1-sarath.babu.naidu.gaddam@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 03:30:44PM +0530, Sarath Babu Naidu Gaddam wrote:
> Clock matrix driver can be probed before the rootfs containing
> firmware/initialization .bin is available. The current driver
> throws a warning and proceeds to execute probe even when firmware
> is not ready. Instead, defer probe and wait for the .bin file to
> be available.
> 
> Signed-off-by: Sarath Babu Naidu Gaddam <sarath.babu.naidu.gaddam@amd.com>
> ---
>  drivers/ptp/ptp_clockmatrix.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ptp/ptp_clockmatrix.c b/drivers/ptp/ptp_clockmatrix.c
> index c9d451bf89e2..96328dfb7e55 100644
> --- a/drivers/ptp/ptp_clockmatrix.c
> +++ b/drivers/ptp/ptp_clockmatrix.c
> @@ -2424,9 +2424,13 @@ static int idtcm_probe(struct platform_device *pdev)
>  
>  	err = idtcm_load_firmware(idtcm, &pdev->dev);
>  
> -	if (err)
> +	if (err) {
>  		dev_warn(idtcm->dev, "loading firmware failed with %d", err);
>  
> +		if (err == -ENOENT)
> +			return -EPROBE_DEFER;
> +	}

Maybe move the dev_warn() after the test so you don't spam the logs
with failures which are not yet real failures?

     Andrew
