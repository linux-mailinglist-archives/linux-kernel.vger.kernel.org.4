Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A366F67FD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 11:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjEDJIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 05:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjEDJIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 05:08:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFFE8F
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 02:08:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D83F26328C
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 09:08:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6BC3C433EF;
        Thu,  4 May 2023 09:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683191330;
        bh=A2Y8ocJewa9pRLM5TJJDkxuMMlwkyXdMFrnpas75cFY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HEkFsohFscDqkBUdcSNwm67WI6FDw1kaL77Ysg/Yo+ihNbMvH217bSmHIGhecOmE2
         MQUtBR5xuVSU8F9zMBWe0np6yKT4c8EJioeaXXuueauCZ/4+3y031h2FCxMaq4F1QD
         LCo4CzVMy71/IXpS8mKqK7bIRlbsOP1PM617R5FE=
Date:   Thu, 4 May 2023 18:08:46 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "saravanak@google.com" <saravanak@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "abel.vesa@linaro.org" <abel.vesa@linaro.org>
Subject: Re: [PATCH] devres: provide API devm_kstrndup
Message-ID: <2023050445-blizzard-splendid-cf1c@gregkh>
References: <20230504075754.372780-1-peng.fan@oss.nxp.com>
 <2023050413-margin-devotedly-468d@gregkh>
 <DU0PR04MB9417B76952E9B21E89946C09886D9@DU0PR04MB9417.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DU0PR04MB9417B76952E9B21E89946C09886D9@DU0PR04MB9417.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2023 at 08:59:41AM +0000, Peng Fan wrote:
> Hi Greg,
> 
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: 2023年5月4日 16:58
> > To: Peng Fan (OSS) <peng.fan@oss.nxp.com>
> > Cc: robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> > rafael@kernel.org; andriy.shevchenko@linux.intel.com;
> > hdegoede@redhat.com; jgg@ziepe.ca; saravanak@google.com;
> > keescook@chromium.org; tglx@linutronix.de; linux-kernel@vger.kernel.org;
> > abel.vesa@linaro.org; Peng Fan <peng.fan@nxp.com>
> > Subject: Re: [PATCH] devres: provide API devm_kstrndup
> > 
> > On Thu, May 04, 2023 at 03:57:54PM +0800, Peng Fan (OSS) wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > This patch introduces devm_kstrndup API so that the device's driver
> > > can allocate memory and copy string.
> > >
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >  drivers/base/devres.c  | 28 ++++++++++++++++++++++++++++
> > > include/linux/device.h |  1 +
> > >  2 files changed, 29 insertions(+)
> > 
> > We can not add apis with no users, please submit this at the same time a
> > driver needs it.
> > 
> > And what driver would need to copy a string?
> 
> https://lore.kernel.org/all/20230504085506.504474-1-peng.fan@oss.nxp.com/

Please never add new module parameters, ESPECIALLY for a driver.  This
is not the 1990's anymore, please use the correct apis instead (hint,
sysfs, configfs, DT, etc.)

> Should I submit V2 with the upper patch in a patchset?

I can't take this as-is, for the reason I said, so yes.  And again, your
dependant patch is not ok either, so I don't think this is needed
anymore.

thanks,

greg k-h
