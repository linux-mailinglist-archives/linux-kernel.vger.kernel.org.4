Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B739737D06
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 10:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbjFUHiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 03:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbjFUHiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 03:38:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54A21712;
        Wed, 21 Jun 2023 00:38:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61748614A0;
        Wed, 21 Jun 2023 07:38:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B07F7C433C8;
        Wed, 21 Jun 2023 07:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687333081;
        bh=4q+VNAx3/4U3dPS2cJ39WDmzQvKH+mXBlgtx4JJ17xo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K7FhuYzboUErUWHkLjY0OGBN3srKFDw0COCk4eCwfEG7xTLbLLwSYaa40N0fAAieY
         zax19uhTlt5Sgk2Sla4nLOpW2toqGY1ndCRzJyqXAQx7BmMnYWUQMFbDzAtqlyNfgu
         x2bv+voPh2KkATLRVXOC32kaIU91h4IoagdSRtOYp7Lx9qEKTtrVCiJXXTJBeUw2dY
         w6eoC9U+PjtGgqc0Cuoa/f8PwBGsLbdyqT6F3PvyIDN8WqmFkktrhqq8KDty+M23pp
         fUuMEwD5ZauYeu1rmo1xT89fZln2gqb0a1hkr0N1zzjKbzLBw2knhk7IyatUWp0BbJ
         8GEB/86MUYzLg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1qBsPk-0005mQ-9F; Wed, 21 Jun 2023 09:38:04 +0200
Date:   Wed, 21 Jun 2023 09:38:04 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
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
Subject: Re: [PATCH v8 6/9] usb: dwc3: qcom: Add multiport controller support
 for qcom wrapper
Message-ID: <ZJKo3LyIMD1xr2ru@hovoldconsulting.com>
References: <82553597-ce0e-48f4-44d4-9eeaaf4cb1c4@quicinc.com>
 <ZIBsDQJtgDZRe7MG@hovoldconsulting.com>
 <99cded6f-6a71-ffce-8479-c7c0726bfb8e@quicinc.com>
 <ZIGihYS5EacISEFm@hovoldconsulting.com>
 <279fff8b-57e2-cfc8-cd6d-c69d00e71799@quicinc.com>
 <20230608175705.2ajrteztdeqdrkzg@synopsys.com>
 <ZILgW5CwfSlBxzNB@hovoldconsulting.com>
 <20230609181602.ljxdchgzl7kzk73n@synopsys.com>
 <acd46bb7-0708-d095-c3c6-53653f9e47d6@quicinc.com>
 <20230615210800.lvmekpvxjiszkrh4@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615210800.lvmekpvxjiszkrh4@synopsys.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 09:08:01PM +0000, Thinh Nguyen wrote:
> On Thu, Jun 15, 2023, Krishna Kurapati PSSNV wrote:

> >  How about we add compatible data indicating the number of usb2/usb3 ports.
> > That way we needn't parse the DT or read xhci registers atleast as a
> > temporary solution to unblock other patches. Once this series is merged, we
> > can get back to fixing the port count calculation. Does it seem fine ?
> > 
> 
> Temporary solution should not involve DT as it's not easily reverted or
> changed. Just include xhci-ext-caps.h and use the inline function. I
> think Johan is fine with that. If not, he can provide more feedback.

Yes, I already suggested that as a quick way forward since it is already
used this way by the xhci debug driver.

Johan
