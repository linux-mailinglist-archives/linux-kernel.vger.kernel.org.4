Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299406B1670
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 00:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjCHXW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 18:22:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjCHXWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 18:22:24 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174B930EA3
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 15:22:23 -0800 (PST)
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E31EC589;
        Thu,  9 Mar 2023 00:22:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1678317741;
        bh=OvYkLln4oTsPQT9Sd/Mtb18XUdL2TRipkagIUlKfwwg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oSvjQx+fEim2xkXtgmyed7ajvnP4E8RPlJk2FD1pm0Li0qaEQyj2OSKIWIEr586Fz
         pcdkF34t42GP8i9qtPkVVP/V6Xc7rVjrJNkM0Eu5IwYM2xoMqDXLAEcL8exJmF45Vb
         Fzeiaen0yfWREkvtGQjo91kQXbGCAjcTbALoxjFg=
Date:   Thu, 9 Mar 2023 01:22:24 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     David Binderman <dcb314@hotmail.com>
Cc:     "andrzej.hajda@intel.com" <andrzej.hajda@intel.com>,
        "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
        "rfoss@kernel.org" <rfoss@kernel.org>,
        "jonas@kwiboo.se" <jonas@kwiboo.se>,
        "jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: drivers/gpu/drm/bridge/fsl-ldb.c:101: possible loss of
 information.
Message-ID: <20230308232224.GG31765@pendragon.ideasonboard.com>
References: <DB6P189MB0568FCA97758B820EAC036989CB79@DB6P189MB0568.EURP189.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DB6P189MB0568FCA97758B820EAC036989CB79@DB6P189MB0568.EURP189.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 04:45:24PM +0000, David Binderman wrote:
> Hello there,
> 
> I just ran the static analyser "cppcheck" over the source code of
> linux-6.2-rc1. It said:
> 
> linux-6.3-rc1/drivers/gpu/drm/bridge/fsl-ldb.c:101:3: style: int
> result is returned as long value. If the return value is long to avoid
> loss of information, then you have loss of information.
> [truncLongCastReturn]
> 
> Source code is
> 
> static unsigned long fsl_ldb_link_frequency(struct fsl_ldb *fsl_ldb, int clock)
> {
>     if (fsl_ldb->lvds_dual_link)
>         return clock * 3500;
>     else
>         return clock * 7000;
> }
> 
> Depending on the range of the value of clock, maybe unsigned long
> literals, like 3500UL, should have been used ?

We could, but I don't think it will make any difference in practice as
the maximum pixel clock frequency supported by the SoC is 80MHz (per
LVDS channel). That would result in a 560MHz frequency returned by this
function, well below the 31 bits limit.

-- 
Regards,

Laurent Pinchart
