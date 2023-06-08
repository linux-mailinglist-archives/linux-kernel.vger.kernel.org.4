Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2352E727BBC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 11:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234914AbjFHJo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 05:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236040AbjFHJoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 05:44:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD8526AD;
        Thu,  8 Jun 2023 02:44:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2680E64B77;
        Thu,  8 Jun 2023 09:44:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62952C433A0;
        Thu,  8 Jun 2023 09:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686217456;
        bh=W7NMjnc+dhnyCpFKHFIFOZFZb+gFDdZ2hqitOzaHHOk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lBH/Tmj3yorBORdNglBBZ/bMCSZSK5Fiizq28MFW46kQkRnV7aFFhLC7dr4NO4qmy
         WteUZnAwJ+d0dBDMKxrgMHwkn2LbKqZoK/xxmTTmmgubNbaTPmGP8bV4Bbb43ijNwv
         +bcUBa3mjoZwJCZj0I3o9phmkYDziB1geI7hx4Mvk3+8P3X8Ew7l1srMOSVSaxfPU+
         9M1M+M0Lq3zCOi7lf4ELj7dmHjdz8wznwzNLpUw9pW2anlA/SOTxueAxGUPVYwpS+p
         TD3JJYqsAgXoWlhEqGNsYqzvlf/qVoZ8WggQmOetbn1gdhDMfbHhUR4nOYcCUcKUMi
         dXppHBOqJebfQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1q7CC9-0004Ad-Fq; Thu, 08 Jun 2023 11:44:41 +0200
Date:   Thu, 8 Jun 2023 11:44:41 +0200
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
Message-ID: <ZIGjCS-D7-kAQCJh@hovoldconsulting.com>
References: <20230514054917.21318-1-quic_kriskura@quicinc.com>
 <20230514054917.21318-7-quic_kriskura@quicinc.com>
 <20230515222730.7snn2i33gkg6ctd2@ripper>
 <20230526025554.ni527gsr2bqxadl3@ripper>
 <37fd026e-ecb1-3584-19f3-f8c1e5a9d20a@quicinc.com>
 <ZIBtnPp0oV6_GFFk@hovoldconsulting.com>
 <3010d855-86b0-f87a-5eb7-85204be9b4b0@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3010d855-86b0-f87a-5eb7-85204be9b4b0@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 01:25:25AM +0530, Krishna Kurapati PSSNV wrote:
> On 6/7/2023 5:14 PM, Johan Hovold wrote:
> > On Fri, May 26, 2023 at 08:55:22PM +0530, Krishna Kurapati PSSNV wrote:
> >> On 5/26/2023 8:25 AM, Bjorn Andersson wrote:
> > 
> >>> We need to fix the dwc3 glue design, so that the glue and the core can
> >>> cooperate - and we have a few other use cases where this is needed (e.g.
> >>> usb_role_switch propagation to the glue code).
> > 
> >>     Thanks for the comments on this patch. I had some suggestions come in
> >> from the team internally:
> >>
> >> 1. To use the notifier call available in drivers/usb/core/notify.c and
> >> make sure that host mode is enabled. That way we can access dwc or xhci
> >> without any issue.
> > 
> > I don't think this is a good idea and instead the callbacks should be
> > dedicated for the xhci and dwc3 drivers. A struct with callbacks can be
> > passed down to the child devices, which call back into the drivers of
> > their parents for notifications and when they need services from them
> > (e.g. during suspend or on role changes).

>    While I agree with you that these notifications are to be used during 
> role switch or suspend/resume, there is no restriction on using them for 
> checking whether we are in host mode or not. IMO, it would be cleaner as 
> we won't be dereferencing dwc driver data at all to check if we are in 
> host mode or not.

I'm not sure I understand what you're saying here. Could you try to
rephrase it?

Johan
