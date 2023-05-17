Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309C0706149
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 09:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjEQHgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 03:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjEQHfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 03:35:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461B3421A;
        Wed, 17 May 2023 00:35:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B62F560AC0;
        Wed, 17 May 2023 07:35:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A934C4339B;
        Wed, 17 May 2023 07:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684308911;
        bh=kQ+STROLZxpi6/xOup3AixMDQ+qLElZlsdCv2LR9o40=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eftgUgzVkEsog+Gvmi1NERj9IbBndaQUvhEgwGEK8ap7tubPEvuNOHRYi5mDjS+4O
         XUsRoIMK/3rctOCbkqb0BdHFrDwENwkq4Qp1Dnu3Vv2IcVBUp76gxUAk3OjUhU6lYj
         QUF96twgfa5y7gKG0XxEMXTeC0tOioZcyyx9H9nfbhhkky/QXkk42qgKHkqCIDgOWs
         kZiW8nAiZcHh2PW/S13OoeXVbuOB1HW6Q8qC+COflpH03y92shVuDxDmiEAF664ah8
         NKl2eGqODI7vh2TCJOLIEQfOTDG98ep6rhuvICgC4ZNQ12OCd+Dx2s1f9QWKPBj+tD
         ZknRpRCTkrY0w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pzBgl-0002Ni-3w; Wed, 17 May 2023 09:35:11 +0200
Date:   Wed, 17 May 2023 09:35:11 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, quic_pkondeti@quicinc.com,
        quic_ppratap@quicinc.com, quic_wcheng@quicinc.com,
        quic_jackp@quicinc.com, quic_harshq@quicinc.com,
        ahalaney@redhat.com
Subject: Re: [PATCH v8 3/9] usb: dwc3: core: Access XHCI address space
 temporarily to read port info
Message-ID: <ZGSDr08h3Go1Dk8C@hovoldconsulting.com>
References: <20230514054917.21318-1-quic_kriskura@quicinc.com>
 <20230514054917.21318-4-quic_kriskura@quicinc.com>
 <ZGNy6FvVrBjYmorz@hovoldconsulting.com>
 <b2954b92-8b12-700a-af50-b914af7b0ace@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2954b92-8b12-700a-af50-b914af7b0ace@quicinc.com>
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

Please try to remember to trim unneeded context when replying so that
it's easier to find your replies and also to catch up on threads (e.g.
when later reading the mail archives).

On Tue, May 16, 2023 at 08:32:00PM +0530, Krishna Kurapati PSSNV wrote:
> On 5/16/2023 5:41 PM, Johan Hovold wrote:
> > On Sun, May 14, 2023 at 11:19:11AM +0530, Krishna Kurapati wrote:

> > You should not make another copy of xhci_find_next_ext_cap(), but rather
> > use it directly.
> > 
> > We already have drivers outside of usb/host using this function so it
> > should be fine to do the same for now:
> > 
> > 	#include "../host/xhci-ext-caps.h"

>    This was the approach which we followed when we first introduced the 
> patch [1]. But Thinh suggested to duplicate code so that we can avoid 
> any dependency on xhci (which seems to be right). So since its just one 
> function, I duplicated it here.

Ok, fair enough. I still think we should not be duplicating the
xhci definitions like this even if we were to copy the helper to avoid
any future dependencies on xhci (it's currently an inline function,
which is also not very nice).

I'll take closer look at the rest of the series as there are a few more
of these layering violations which we should try to avoid.

> >> +	offset = dwc3_xhci_find_next_ext_cap(regs, 0,
> >> +					XHCI_EXT_CAPS_PROTOCOL);
> >> +	while (offset) {

> >> +		temp = readl(regs + offset);
> >> +		major_revision = XHCI_EXT_PORT_MAJOR(temp);
> >> +
> >> +		temp = readl(regs + offset + 0x08);

> >> +		if (major_revision == 0x03) {
> >> +			dwc->num_usb3_ports += XHCI_EXT_PORT_COUNT(temp);
> >> +		} else if (major_revision <= 0x02) {
> >> +			dwc->num_usb2_ports += XHCI_EXT_PORT_COUNT(temp);
> >> +		} else {
> >> +			dev_err(dwc->dev,
> >> +				"Unrecognized port major revision %d\n", major_revision);

> > Perhaps this should be handles as in xhci core by simply warning and
> > continuing instead.
> > 
> I broke the loop and went to unmap as we are not sure what values would 
> be read. Any use of continuing ?

Mostly to align with xhci core which currently handles this case. It
would not not work unless you get rid of the max-ports check below
though.
 
> >> +			ret = -EINVAL;
> >> +			goto unmap_reg;
> >> +		}
> >> +
> >> +		offset = dwc3_xhci_find_next_ext_cap(regs, offset,
> >> +						XHCI_EXT_CAPS_PROTOCOL);
> >> +	}
> >> +
> >> +	temp = readl(regs + DWC3_XHCI_HCSPARAMS1);
> >> +	if (HCS_MAX_PORTS(temp) != (dwc->num_usb3_ports + dwc->num_usb2_ports)) {
> >> +		dev_err(dwc->dev,
> >> +			"Mismatched reported MAXPORTS (%d)\n", HCS_MAX_PORTS(temp));
> >> +		ret = -EINVAL;
> >> +		goto unmap_reg;
> >> +	}
> > 
> > Not sure this is needed either.
> > 
> > Could this risk regressing platforms which does not have currently have
> > all PHYs described in DT?
> > 
> No, it doesn't. AFAIK, this only tells how many ports are present as per 
> the core consultant configuration of the device. I tried to explain what 
> would happen incase phy's are not present in DT in [2] & [3].

Right, whether the PHYs are described in DT is not directly related to
this.

As long as HCS_MAX_PORTS by definition (assumption) is always
(dwc->num_usb3_ports + dwc->num_usb2_ports) any such machines would
continue to work.

But if you want to catch machines where this assumption does not hold,
you could also end up regressing machines which have so far been working
despite these numbers not adding up.

That may be acceptable, but I'm still not sure what the value of this
check is (e.g. as xhci core will handle basic sanity checks like usb2 +
usb3 <= max_ports).

Johan
