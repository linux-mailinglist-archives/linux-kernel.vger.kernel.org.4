Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA5A706198
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 09:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjEQHrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 03:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbjEQHrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 03:47:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90E5E0;
        Wed, 17 May 2023 00:47:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62898642FE;
        Wed, 17 May 2023 07:47:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBC3EC433D2;
        Wed, 17 May 2023 07:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684309619;
        bh=CrxLp3AHsiBT9omthbkFjUwyEAb+XuvYsglQMZaTHkY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uL3TvCb7G2N4leJalPW+7SzBmp1qVn99MQN5zxSIWe4LmXtJdanQVSCI/6Vitmffi
         ezyE354obh8cYYNa1vEWEwJHOlp4asZGRgjCE6ppSk2UigLVS08SixnjVFlC0KqJSa
         Rreu/9K2T+TGcxrKhjqvPs1ou8dVyLichSKDofJJ+lg2XNMb3+5cwtNfTzmpMBCOIO
         O7zdkbPBNfMefF1SbkMUnzJS7edRwMQoGqSrwr0f/u3Dj+Bsf7FLyUkNZrKjll6z4Z
         sSbG91TR1AM5NFNba8qAAxkKBLig+MTLWbrx9JYVQ58VkqHxTRSniHIWVh5Ua75q35
         e0943MYgcIFww==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pzBsB-0002UC-7q; Wed, 17 May 2023 09:46:59 +0200
Date:   Wed, 17 May 2023 09:46:59 +0200
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
Message-ID: <ZGSGc-X5Oir8wddK@hovoldconsulting.com>
References: <20230514054917.21318-1-quic_kriskura@quicinc.com>
 <20230514054917.21318-4-quic_kriskura@quicinc.com>
 <ZGNy6FvVrBjYmorz@hovoldconsulting.com>
 <b2954b92-8b12-700a-af50-b914af7b0ace@quicinc.com>
 <cacc5813-404a-c2ef-e768-20f2acd696d9@quicinc.com>
 <20230517032124.rdh7ehnair3wjuvm@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230517032124.rdh7ehnair3wjuvm@synopsys.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 03:21:24AM +0000, Thinh Nguyen wrote:
> On Wed, May 17, 2023, Krishna Kurapati PSSNV wrote:
> > On 5/16/2023 8:32 PM, Krishna Kurapati PSSNV wrote:
> > > On 5/16/2023 5:41 PM, Johan Hovold wrote:

> > > > You should not make another copy of xhci_find_next_ext_cap(), but rather
> > > > use it directly.
> > > > 
> > > > We already have drivers outside of usb/host using this function so it
> > > > should be fine to do the same for now:
> > > > 
> > > >     #include "../host/xhci-ext-caps.h"

> > >    This was the approach which we followed when we first introduced the
> > > patch [1]. But Thinh suggested to duplicate code so that we can avoid
> > > any dependency on xhci (which seems to be right). So since its just one
> > > function, I duplicated it here.

> >   Would like to know your opinion here on how to proceed further.

> Please keep them separated. The xhci-ext-caps.h is for xhci driver only.
> It's not meant to be exposed to other drivers. Same with other *.h files
> under drivers/usb/host.

As I mentioned earlier, it is already used by the xdbc earlyprintk
driver which lives outside of drivers/usb/host, even if such a debug
driver could be considered a special case.

If it turns out that there's no way to avoid mapping those registers
from the qcom glue driver, then I think at least the register defines
need to be provided in a global header rather than being copied
verbatim.

But hopefully that can be avoided too as the xhci driver already parses
these registers and stores the port information, even if accessing that
data may require a bit more work currently.

Johan
