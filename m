Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D4E725D43
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 13:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240128AbjFGLhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 07:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235242AbjFGLh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 07:37:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A423C19BB;
        Wed,  7 Jun 2023 04:37:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E69A6363F;
        Wed,  7 Jun 2023 11:37:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98FAEC433EF;
        Wed,  7 Jun 2023 11:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686137846;
        bh=psQ6ZJZEg9wTqjwMcDW8jdk25A/rwYvSuf38fGXbSsk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nf4B2g9dgWK5Ne88r4xtXNZMc03GDSxQOpKbjYdENnhpsYVw9xgzB5z0VjUdZfxYc
         DslyFH6axp4IQIbJdsmCXyauVgH0aVEoX6z1WLMw0gBrWCEh8LMeoMrge3B+mGhYec
         V1eQZoruBNQd7YnD0aRiEgCgGViNf2Ix8jod1cPCZh7W0R5JleSnYHiZs4YhYFM0ER
         +LuANOyMPdMTkPECJlQXmLvJ8tJg8kCCKnPQpYKZy7lV8XSR7n2CuaD2EvsUSON1LP
         lZ5P7aWYu4h3+Kel/bafWBPybhCLYh4Vu9MES6wJAP7OHJ5KOl4Gwor+EfYWbCmUoe
         XRannDPLF5Z/w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1q6rU5-0008SO-CZ; Wed, 07 Jun 2023 13:37:49 +0200
Date:   Wed, 7 Jun 2023 13:37:49 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, quic_pkondeti@quicinc.com,
        quic_ppratap@quicinc.com, quic_wcheng@quicinc.com,
        quic_jackp@quicinc.com, quic_harshq@quicinc.com,
        ahalaney@redhat.com
Subject: Re: [PATCH v8 6/9] usb: dwc3: qcom: Add multiport controller support
 for qcom wrapper
Message-ID: <ZIBsDQJtgDZRe7MG@hovoldconsulting.com>
References: <20230514054917.21318-1-quic_kriskura@quicinc.com>
 <20230514054917.21318-7-quic_kriskura@quicinc.com>
 <20230515222730.7snn2i33gkg6ctd2@ripper>
 <bc347624-4539-4a3a-9399-9b4e272cdb32@quicinc.com>
 <ZGUCykpDFt9zgeTU@hovoldconsulting.com>
 <82553597-ce0e-48f4-44d4-9eeaaf4cb1c4@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82553597-ce0e-48f4-44d4-9eeaaf4cb1c4@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krishna,

and sorry about the delay in following up on this. As usual, there are
just way too many threads and this one in particular requires a bit of
thought.

On Sat, May 20, 2023 at 11:18:52PM +0530, Krishna Kurapati PSSNV wrote:
> On 5/17/2023 10:07 PM, Johan Hovold wrote:

> > I don't think we should be adding more of these layering violations. A
> > parent device driver has no business messing with the driver data for a
> > child device which may or may not even have probed yet.
> > 
> > I added a FIXME elsewhere in the driver about fixing up the current
> > instances that have already snuck in (which in some sense is even worse
> > by accessing driver data of a grandchild device).
> > 
> > We really need to try sort this mess out and how to properly handle the
> > interactions between these layers (e.g. glue, dwc3 core and xhci). This
> > will likely involve adding callbacks from the child to the parent, for
> > example, when the child is suspending.

>   I agree with you, but in this case I believe there is no other way we 
> can find the number of ports present. Unless its a dt property which 
> parent driver can access the child's of node and get the details. Like 
> done in v4 [1]. But it would be adding redundant data into DT as pointed 
> out by Rob and Krzysztof and so we removed these properties.

So there at least two issues with this series:

	1. accessing xhci registers from the dwc3 core
	2. accessing driver data of a child device

1. The first part about accessing xhci registers goes against the clear
separation between glue, core and xhci that Felipe tried to maintain.

I'm not entirely against doing this from the core driver before
registering the xhci platform device as the registers are unmapped
afterwards. But if this is to be allowed, then the implementation should
be shared with xhci rather than copied verbatim.

The alternative that avoids this issue entirely could indeed be to
simply count the number of PHYs described in DT as Rob initially
suggested. Why would that not work?

2. The driver is already accessing driver data of the child device so
arguably your series is not really making things much worse than they
already are.

I've just sent a couple of fixes to address some of the symptoms of
this layering violation here:

	https://lore.kernel.org/lkml/20230607100540.31045-1-johan+linaro@kernel.org/

Getting this fixed properly is going to take a bit of work, and
depending on how your multiport wake up implementation is going to look
like, adding support for multiport controllers may not make this much
harder to address.

So perhaps we can indeed merge support for multiport and then get back
to cleaning this up.

Johan
