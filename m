Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F526E9A44
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 19:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbjDTRFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 13:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbjDTRFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 13:05:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE5AB44BE;
        Thu, 20 Apr 2023 10:05:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4829B1480;
        Thu, 20 Apr 2023 10:06:08 -0700 (PDT)
Received: from pluto (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 425133F6C4;
        Thu, 20 Apr 2023 10:05:23 -0700 (PDT)
Date:   Thu, 20 Apr 2023 18:05:21 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
Cc:     "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        michal.simek@amd.com, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com
Subject: Re: [RFC v1 1/2] scmi: Introduce pinctrl SCMI protocol driver
Message-ID: <ZEFw0TYs3TEHuM1D@pluto>
References: <cover.1680793130.git.oleksii_moisieiev@epam.com>
 <54119b2cb43e29f69c5858a5320d3a58f23fed21.1680793130.git.oleksii_moisieiev@epam.com>
 <ZDcqx9JVMvqr2WYu@e120937-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDcqx9JVMvqr2WYu@e120937-lin>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 11:04:05PM +0100, Cristian Marussi wrote:
> On Fri, Apr 07, 2023 at 10:18:27AM +0000, Oleksii Moisieiev wrote:
> > Implementation of the SCMI client driver, which implements
> > PINCTRL_PROTOCOL. This protocol has ID 19 and is described
> > in the latest DEN0056 document.
> 
> Hi,
> 

Hi Oleksii,

one more thing that I missed in my previous review down below.

> > This protocol is part of the feature that was designed to
> > separate the pinctrl subsystem from the SCP firmware.
> > The idea is to separate communication of the pin control
> > subsystem with the hardware to SCP firmware
> > (or a similar system, such as ATF), which provides an interface
> > to give the OS ability to control the hardware through SCMI protocol.
> > This is a generic driver that implements SCMI protocol,
> > independent of the platform type.
> > 
> > DEN0056 document:
> > https://developer.arm.com/documentation/den0056/latest
> > 
> 

[snip]

> > +static int scmi_pinctrl_request_config(const struct scmi_handle *handle,
> > +				       u32 selector,
> > +				       enum scmi_pinctrl_selector_type type,
> > +				       u32 *config)
> > +{
> > +	struct scmi_xfer *t;
> > +	struct scmi_conf_tx *tx;
> > +	__le32 *packed_config;
> > +	u32 attributes = 0;
> > +	int ret;
> > +
> > +	if (!handle || !config || type == FUNCTION_TYPE)
> > +		return -EINVAL;
> > +
> > +	ret = scmi_pinctrl_validate_id(handle, selector, type);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = scmi_xfer_get_init(handle, PINCTRL_CONFIG_GET,
> > +				 SCMI_PROTOCOL_PINCTRL,
> > +				 sizeof(*tx), sizeof(*packed_config), &t);
> > +	if (ret)
> > +		return ret;
> > +
> > +	tx = t->tx.buf;
> > +	packed_config = t->rx.buf;
> > +	tx->identifier = cpu_to_le32(selector);
> > +	attributes = SET_TYPE_BITS(attributes, type);
> > +	attributes = SET_CONFIG(attributes, *config);
> > +

Looking at scmi_conf_tx and these pinctrl get/set functions, you do not
seem to consider the ConfigType field in the SCMI related messages, so
basically using always the Default 0 Type, and as a consequence you dont
either expose any way to choose a Different type in the related SCMI
protocol ops; I imagine this is because the pinctrl driver currently using
this protocol, at the end, does not need any of the other available types
(as in Table 23 of the spec).

This is fine for pinctrl driver as it is now, BUT the SCMI pinctrl
protocol implementation in the core SCMI stack and its related
protocol_operations as exposed in scmi_protocol.h should be generic
enough to serve any possible user of the SCMI pinctrl protocol (and there
is already a request to extend/amend the spec somehow to send multiple pin
setup of different types in one go as you may have seen), so I'd say it's
better if you add also a ConfigType param to the get/set_config scmi_pinctrl_ops
and expose the whole ConfigType enums (Table23) in scmi_protocol.h (like we do for
sensor classes on scmi_protocol.h) to address this; the pinctrl driver
can then anyway call such new protocol_ops with a Default type, but at
least the SCMI protocol_ops interface will remain generic and could be
reused iin other scenarios.

This is equally true for all the other protocol messages (should I have
miss something else for now...I'll review again you next V2 anyway).

Thanks,
Cristian

