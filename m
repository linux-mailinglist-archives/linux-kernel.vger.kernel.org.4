Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B6562562E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 10:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233523AbiKKJFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 04:05:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233553AbiKKJFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 04:05:35 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81D41F620
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 01:05:29 -0800 (PST)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1otPyV-0004XQ-En; Fri, 11 Nov 2022 10:05:23 +0100
Message-ID: <fda5dd3656ffa2d0a18fd4dbe6d5a0d4a50f4798.camel@pengutronix.de>
Subject: Re: [PATCH] soc: imx8m: Increase the clock enable before reading
 the register
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Shawn Guo <shawnguo@kernel.org>,
        "Wang, Xiaolei" <xiaolei.wang@windriver.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 11 Nov 2022 10:05:21 +0100
In-Reply-To: <20221111035304.GL125525@dragon>
References: <20221028041418.4033261-1-xiaolei.wang@windriver.com>
         <20221111024607.GH125525@dragon>
         <f0e35731-07df-bd80-329f-a5ad9818e1e8@windriver.com>
         <20221111035304.GL125525@dragon>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, dem 11.11.2022 um 11:53 +0800 schrieb Shawn Guo:
> On Fri, Nov 11, 2022 at 11:01:15AM +0800, Wang, Xiaolei wrote:
> > 
> > On 11/11/2022 10:46 AM, Shawn Guo wrote:
> > > CAUTION: This email comes from a non Wind River email account!
> > > Do not click links or open attachments unless you recognize the sender and know the content is safe.
> > > 
> > > On Fri, Oct 28, 2022 at 12:14:18PM +0800, Xiaolei Wang wrote:
> > > > When executing kdump to start the second kernel,
> > > > since IMX-OCOTP has turned off the clock, the clock
> > > > needs to be re-enabled, otherwise the system will hang.
> > > > 
> > > > Fixes: ac34de14ac30 ("Revert "soc: imx8m: change to use platform driver"")
> > > Are you saying this fixes a regression caused by ac34de14ac30?
> > 
> > 
> > Yes,
> > 
> > Although there is a problem with commit 7d981405d0fd, it also solves the
> > kexec kernel hang, commit 7d981405d0fd is reverted, and the kexec kernel
> > hang will also be introduced, so the clock needs to be enabled when the
> > kexec kernel starts.
> 
> Ok.
> 
> Lucas,
> 
> Any comments here?

Yea, the explanation with kdump in the commit message is a tad too
specific I think. The simple fact is: OCOTP register access needs the
OCOTP clock to be running and this code peeks into this register
region, so it needs to ensure the clock is active.

Other than this minor issue with the commit message, the change itself
looks fine:
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

Regards,
Lucas

