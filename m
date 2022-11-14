Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C504627763
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 09:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236337AbiKNIVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 03:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236321AbiKNIVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 03:21:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025341A80E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 00:20:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7E20B80D30
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 08:20:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91DD3C433C1;
        Mon, 14 Nov 2022 08:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668414056;
        bh=ihB3e8vu1WmRcZ4EVGW+DKA1UocA4mXLskW1iFweRDI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ASLijPJAC8F9b7QeDHbUv9IZ1QD1wkIxGPcJYD4r2FCbxyP2nJEig/d8I2QFFd/2R
         Ch6r13wCd/mukuosZxjVTRURj0CIcpiSZA5VxN+NdybJKXlEeeM8OGJpIkvZrrZx7h
         68eNsR8CWJvPp0AxG36OZdN1+3nPUHKA78A70vqI6BDEFgHqQT1bKa2J5R9LogOqYe
         QE9IrfKbacYBJUeV5nC32zsSAQdVP8/T4q8LkfgfLm3HWG7fN8Ws6cexlQT3qwv4CI
         Yti5BzH5yg02Gd+g5Ojf1qut8P50pgExWOxgYqfFS6yBSPgoBCDgorAxL4990ynXqf
         kyxuWqdnyinmQ==
Date:   Mon, 14 Nov 2022 16:20:44 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     "Wang, Xiaolei" <xiaolei.wang@windriver.com>,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: imx8m: Increase the clock enable before reading the
 register
Message-ID: <20221114082044.GR2649582@dragon>
References: <20221028041418.4033261-1-xiaolei.wang@windriver.com>
 <20221111024607.GH125525@dragon>
 <f0e35731-07df-bd80-329f-a5ad9818e1e8@windriver.com>
 <20221111035304.GL125525@dragon>
 <fda5dd3656ffa2d0a18fd4dbe6d5a0d4a50f4798.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fda5dd3656ffa2d0a18fd4dbe6d5a0d4a50f4798.camel@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 10:05:21AM +0100, Lucas Stach wrote:
> Am Freitag, dem 11.11.2022 um 11:53 +0800 schrieb Shawn Guo:
> > On Fri, Nov 11, 2022 at 11:01:15AM +0800, Wang, Xiaolei wrote:
> > > 
> > > On 11/11/2022 10:46 AM, Shawn Guo wrote:
> > > > CAUTION: This email comes from a non Wind River email account!
> > > > Do not click links or open attachments unless you recognize the sender and know the content is safe.
> > > > 
> > > > On Fri, Oct 28, 2022 at 12:14:18PM +0800, Xiaolei Wang wrote:
> > > > > When executing kdump to start the second kernel,
> > > > > since IMX-OCOTP has turned off the clock, the clock
> > > > > needs to be re-enabled, otherwise the system will hang.
> > > > > 
> > > > > Fixes: ac34de14ac30 ("Revert "soc: imx8m: change to use platform driver"")
> > > > Are you saying this fixes a regression caused by ac34de14ac30?
> > > 
> > > 
> > > Yes,
> > > 
> > > Although there is a problem with commit 7d981405d0fd, it also solves the
> > > kexec kernel hang, commit 7d981405d0fd is reverted, and the kexec kernel
> > > hang will also be introduced, so the clock needs to be enabled when the
> > > kexec kernel starts.
> > 
> > Ok.
> > 
> > Lucas,
> > 
> > Any comments here?
> 
> Yea, the explanation with kdump in the commit message is a tad too
> specific I think. The simple fact is: OCOTP register access needs the
> OCOTP clock to be running and this code peeks into this register
> region, so it needs to ensure the clock is active.
> 
> Other than this minor issue with the commit message, the change itself
> looks fine:
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

Thanks for the review and comment, Lucas!  I reworded the subject and
commit log a bit like below, and applied the patch, thanks!

---8<------
soc: imx8m: Enable OCOTP clock before reading the register

Commit 7d981405d0fd ("soc: imx8m: change to use platform driver") ever
removed the dependency on bootloader for enabling OCOTP clock.  It
helped to fix a kexec kernel hang issue.  But unfortunately it caused
a regression on CAAM driver and got reverted.

This is the second try to enable the OCOTP clock by directly calling
clock API instead of indirectly enabling the clock via nvmem API.

Fixes: ac34de14ac30 ("Revert "soc: imx8m: change to use platform driver"")
Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
