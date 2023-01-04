Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9D765D517
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 15:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239528AbjADOJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 09:09:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239647AbjADOHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 09:07:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF1C395FD;
        Wed,  4 Jan 2023 06:06:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DEA2161749;
        Wed,  4 Jan 2023 14:06:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6624C433EF;
        Wed,  4 Jan 2023 14:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1672841202;
        bh=vgZ8jyPORTxp7nVG+aP42F9Ih1bxtrRVf5Gzhp+VlvM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cqh7FsxEt0Gi7kiylp0sh1Q2kOff21bQ1gwS6IdpzNDDG9xgd3ApCR1LjF7L6ptuN
         xqv5aR1ZPQp+c4VIAhHiZnTjf0YFiMjfXCzjW/krli1Ez616PR6WDLA4xZVCZKxbOw
         XtRC1Cx0NR4Ovyq9DFPLljCK4gCFcrA6eSpe/aG0=
Date:   Wed, 4 Jan 2023 15:06:02 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Martin =?utf-8?B?WmHFpW92acSN?= <m.zatovic1@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mani@kernel.org, hemantk@codeaurora.org, quic_jhugo@quicinc.com,
        andersson@kernel.org, Michael.Srba@seznam.cz, arnd@arndb.de,
        dipenp@nvidia.com, bvanassche@acm.org, iwona.winiarska@intel.com,
        ogabbay@kernel.org, tzimmermann@suse.de, fmdefrancesco@gmail.com,
        jason.m.bills@linux.intel.com, jae.hyun.yoo@linux.intel.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Subject: Re: [PATCH 2/3] bus: add Wiegand bus driver
Message-ID: <Y7WHyqJgXGvDfo+h@kroah.com>
References: <20230104133414.39305-1-m.zatovic1@gmail.com>
 <20230104133414.39305-3-m.zatovic1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230104133414.39305-3-m.zatovic1@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 02:34:13PM +0100, Martin Zaťovič wrote:
> Add a bus driver for Wiegand protocol. The bus driver handles
> Wiegand controller and Wiegand device managemement and driver
> matching. The bus driver defines the structures for Wiegand
> controllers and Wiegand devices. Wiegand controller structure
> contains the format and payload_len fields to add support for
> different format messages. This should be handled by the
> controller driver.
> 
> Each Wiegand controller should be associated with one Wiegand
> device, as Wiegand is typically a point-to-point bus.
> 
> Signed-off-by: Martin Zaťovič <m.zatovic1@gmail.com>
> ---
>  MAINTAINERS             |   2 +
>  drivers/bus/Kconfig     |   5 +
>  drivers/bus/Makefile    |   1 +
>  drivers/bus/wiegand.c   | 768 ++++++++++++++++++++++++++++++++++++++++

Why is this here, yet the driver in drivers/wiegand/ ?

Why not put the bus logic in there as well?

thanks,

greg k-h
