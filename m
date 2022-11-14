Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4826284CA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236515AbiKNQPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237378AbiKNQO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:14:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EAF1A3A9;
        Mon, 14 Nov 2022 08:14:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C284612AC;
        Mon, 14 Nov 2022 16:14:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38AEDC43140;
        Mon, 14 Nov 2022 16:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668442495;
        bh=Cc1eIBz+pYCTV16m3BvnLaFad44tEe0/JnnWJhh/Rio=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=URAeiTMm0IcYD22EXJiZXkkdOFvgMbSmD3fMChOhN+3OPYPbN8phjZAoLMafs0wk8
         doUgosGROeI4M1+yQber/QXxEmC6xkK+wrBlZ5N15xPLt2VzaGUh0omvry+pxHPaVN
         jdW47tAz1MyY90O8yAtHBszi342x7Do7tO2D+gCY=
Date:   Mon, 14 Nov 2022 17:14:52 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc:     sre@kernel.org, orsonzhai@gmail.com, baolin.wang@linux.alibaba.com,
        zhang.lyra@gmail.com, felipe.balbi@linux.intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com, linux-usb@vger.kernel.org,
        tony@atomide.com
Subject: Re: [PATCH] usb: phy: add dedicated notifier for charger events
Message-ID: <Y3JpfDU7T2Ks/H4m@kroah.com>
References: <1668430562-27114-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1668430562-27114-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 02:56:02PM +0200, Ivaylo Dimitrov wrote:
> usb_phy::notifier is already used by various PHY drivers (including
> phy_generic) to report VBUS status changes and its usage conflicts with
> charger current limit changes reporting.

How exactly does it conflict?

> Fix that by introducing a second notifier that is dedicated to usb charger
> notifications. Add usb_charger_XXX_notifier functions. Fix charger drivers
> that currently (ab)use usb_XXX_notifier() to use the new API.

Why not just set the notifier type to be a new one instead of adding a
whole new notifier list?  Or use a real callback?  notifier lists are
really horrid and should be avoided whenever possible.

> Fixes: a9081a008f84 ("usb: phy: Add USB charger support")
> 
> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>

You can't have a blank line between there, checkpatch.pl should have
complained.

thanks,

greg k-h
