Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02AEE70E354
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237870AbjEWQ7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 12:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237894AbjEWQ7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 12:59:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D361B0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 09:58:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 439A060FCA
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 16:58:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390AFC433EF;
        Tue, 23 May 2023 16:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684861134;
        bh=JDNhv474FZcy4Lz73KwYrRLVpRvuJfnJCY1u9fi55UI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R5iPf7eDMXEm36imF/7Lfrki1iXUhd39+DaAYPVRf54gIckmQ8JRcWRwF0Jngyh0B
         EQTyXsY5NyFiFrcK5YjVEx5Y4yewaBWshDqufRtdsF3XKHzUk6tExU/VBQV1DRfVJt
         iLM2hk7Hxe67ds25FKhVLLtgCkBd9WaG3XFggNgk=
Date:   Tue, 23 May 2023 17:58:51 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Robert Marko <robert.marko@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] nvmem: core: Expose cells through sysfs
Message-ID: <2023052351-doze-purist-9780@gregkh>
References: <20230523100239.307574-1-miquel.raynal@bootlin.com>
 <20230523100239.307574-3-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523100239.307574-3-miquel.raynal@bootlin.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 12:02:39PM +0200, Miquel Raynal wrote:
> +/* Cell attributes will be dynamically allocated */
> +static struct attribute_group nvmem_cells_group = {
> +	.name		= "cells",
> +};
> +
>  static const struct attribute_group *nvmem_dev_groups[] = {
>  	&nvmem_bin_group,
> +	NULL, /* Reserved for exposing cells, if any */

Please don't do this, but rather use the is_visible callback to
determine if it should be shown or not.

thanks,

greg k-h
