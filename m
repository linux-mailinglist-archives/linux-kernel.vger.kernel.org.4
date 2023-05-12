Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59CE270034E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 11:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239907AbjELJFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 05:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240072AbjELJFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 05:05:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7D78B11548;
        Fri, 12 May 2023 02:04:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A57FCFEC;
        Fri, 12 May 2023 02:05:29 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C9B123F663;
        Fri, 12 May 2023 02:04:43 -0700 (PDT)
Date:   Fri, 12 May 2023 10:04:41 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
Cc:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Peng Fan <peng.fan@oss.nxp.com>,
        Michal Simek <michal.simek@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: Re: [RFC v2 2/3] pinctrl: Implementation of the generic scmi-pinctrl
 driver
Message-ID: <ZF4BKZkbLr2mKN0s@e120937-lin>
References: <cover.1682513390.git.oleksii_moisieiev@epam.com>
 <812ae71d017b115c55648dbf0a4c3502715b1955.1682513390.git.oleksii_moisieiev@epam.com>
 <ZFVoiWnvq7UXSBBw@surfacebook>
 <152bbad1-a759-df18-1efa-4e25c54847d9@epam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152bbad1-a759-df18-1efa-4e25c54847d9@epam.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 01:15:46PM +0000, Oleksii Moisieiev wrote:
> Hello Andy,
> 
> On 05.05.23 23:35, andy.shevchenko@gmail.com wrote:
> > Wed, Apr 26, 2023 at 01:26:37PM +0000, Oleksii Moisieiev kirjoitti:
> >> scmi-pinctrl driver implements pinctrl driver interface and using
> >> SCMI protocol to redirect messages from pinctrl subsystem SDK to
> >> SCP firmware, which does the changes in HW.
> >>
> >> This setup expects SCP firmware (or similar system, such as ATF)
> >> to be installed on the platform, which implements pinctrl driver
> >> for the specific platform.
> >>
> >> SCMI-Pinctrl driver should be configured from the device-tree and uses
> >> generic device-tree mappings for the configuration.
> > 
> > ...
> > 
> >> +#include <linux/device.h>
> >> +#include <linux/err.h>
> > 
> >> +#include <linux/of.h>
> > 
> > I do not see any user of this header. Do you?
> > 
> Yes, thanks. Removing
> 
> >> +#include <linux/module.h>
> >> +#include <linux/seq_file.h>
> >> +
> >> +#include <linux/pinctrl/machine.h>
> >> +#include <linux/pinctrl/pinconf.h>
> >> +#include <linux/pinctrl/pinconf-generic.h>
> >> +#include <linux/pinctrl/pinctrl.h>
> >> +#include <linux/pinctrl/pinmux.h>
> > 
> >> +#include <linux/scmi_protocol.h>
> >> +#include <linux/slab.h>
> > 
> > Please, move these two to the upper group of the generic headers.
> > 
> Thanks, fixed.
> 
> >> +struct scmi_pinctrl_funcs {
> >> +	unsigned int num_groups;
> >> +	const char **groups;
> >> +};
> > 
> > Please, use struct pinfunction.
> >
> I can't use pincfunction here because it has the following groups 
> definition:
> const char * const *groups;
> 
> Which is meant to be constantly allocated.
> So I when I try to gather list of groups in 
> pinctrl_scmi_get_function_groups I will receive compilation error.
> 

Maybe this is a further signal that we should re-evaluate the benefits of
the lazy allocations you now perform during protocol initialization
instead of querying and allocating statically all the info structs about
existing resources.

Not saying that is necessarily bad, I understood your points about reducing
the number of SCMI queries during boot and let pinctrl subsystem trigger only
the strictly needed one, just saying maybe good to reason a bit more about this
once V3 is posted. (i.e. I could bother you more :P ..)

Thanks,
Cristian

P.S. [off-topic]: remember to use get_maintainer.pl as advised elsewhere
to include proper maintainers (and their bots)
