Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6C0725DC2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 13:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238574AbjFGL4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 07:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233152AbjFGL4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 07:56:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23A719BF;
        Wed,  7 Jun 2023 04:56:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5714B634FD;
        Wed,  7 Jun 2023 11:56:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A1DC433EF;
        Wed,  7 Jun 2023 11:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686138979;
        bh=odgATFUQ91mIunsnMGn0REHzM/M5+jkX/A+8ocFml6A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gWs4PtBO/cVAPQj2rPHQ3RFo+LU/PJP49yeOTDKKxyrrrU5B2MqeGcc1XbVeaupff
         Zk7gS1/VyBmJmBPnuK/FX8YLi8Br+2DspDYWmbRKMCRocGRZS5FbCdvo66t9/YpEer
         jK6mqKLHPe5DEkViCsB6b4TvesWKoizZwzF0tyrtyybk3/qTGHUp6UtKpN62VwjyrX
         6atIZp5lfLjPn3PVRkflLoMyACOFwLkLPaF/q2CN+hhvwg6cs53z04gX+FgqL3SKn+
         SUm8quSZ1tiN4dIePq6F/R47FgwJ2xcWgctoeklGIolbcRfnktNNvtEMHzdVLFDrqo
         PNqQhCvaaQs9Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1q6rmL-00007I-Ql; Wed, 07 Jun 2023 13:56:42 +0200
Date:   Wed, 7 Jun 2023 13:56:41 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "quic_pkondeti@quicinc.com" <quic_pkondeti@quicinc.com>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_harshq@quicinc.com" <quic_harshq@quicinc.com>,
        "ahalaney@redhat.com" <ahalaney@redhat.com>
Subject: Re: [PATCH v8 3/9] usb: dwc3: core: Access XHCI address space
 temporarily to read port info
Message-ID: <ZIBweVb8lUzehRXp@hovoldconsulting.com>
References: <20230514054917.21318-1-quic_kriskura@quicinc.com>
 <20230514054917.21318-4-quic_kriskura@quicinc.com>
 <ZGNy6FvVrBjYmorz@hovoldconsulting.com>
 <b2954b92-8b12-700a-af50-b914af7b0ace@quicinc.com>
 <cacc5813-404a-c2ef-e768-20f2acd696d9@quicinc.com>
 <20230517032124.rdh7ehnair3wjuvm@synopsys.com>
 <ZGSGc-X5Oir8wddK@hovoldconsulting.com>
 <20230517232147.4ds4rvvexwzqbzdx@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230517232147.4ds4rvvexwzqbzdx@synopsys.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 11:21:50PM +0000, Thinh Nguyen wrote:
> On Wed, May 17, 2023, Johan Hovold wrote:
> > On Wed, May 17, 2023 at 03:21:24AM +0000, Thinh Nguyen wrote:
> > > On Wed, May 17, 2023, Krishna Kurapati PSSNV wrote:
> > > > On 5/16/2023 8:32 PM, Krishna Kurapati PSSNV wrote:
> > > > > On 5/16/2023 5:41 PM, Johan Hovold wrote:
> > 
> > > > > > You should not make another copy of xhci_find_next_ext_cap(), but rather
> > > > > > use it directly.
> > > > > > 
> > > > > > We already have drivers outside of usb/host using this function so it
> > > > > > should be fine to do the same for now:
> > > > > > 
> > > > > >     #include "../host/xhci-ext-caps.h"
> > 
> > > > >    This was the approach which we followed when we first introduced the
> > > > > patch [1]. But Thinh suggested to duplicate code so that we can avoid
> > > > > any dependency on xhci (which seems to be right). So since its just one
> > > > > function, I duplicated it here.
> > 
> > > >   Would like to know your opinion here on how to proceed further.
> > 
> > > Please keep them separated. The xhci-ext-caps.h is for xhci driver only.
> > > It's not meant to be exposed to other drivers. Same with other *.h files
> > > under drivers/usb/host.
> > 
> > As I mentioned earlier, it is already used by the xdbc earlyprintk
> > driver which lives outside of drivers/usb/host, even if such a debug
> > driver could be considered a special case.
> > 
> > If it turns out that there's no way to avoid mapping those registers
> > from the qcom glue driver, then I think at least the register defines
> > need to be provided in a global header rather than being copied
> > verbatim.
> 
> It would be good to properly define the global header with common
> offset/interface that can be public for other drivers.

Yes, either drivers outside of xhci should be allowed to access this
registers and then the defines should go in a public header or we need
to find another way for drivers to get their hands on the corresponding
information.

I agree that accessing the header from inside the host directory is not
very nice, but it looked we already had drivers violating this.

If this turns out to be at all needed, it should even be possible to
share the implementation even if that means adding an explicit
dependency on xhci for host mode. The current inline function really is
just a hack.

Johan
