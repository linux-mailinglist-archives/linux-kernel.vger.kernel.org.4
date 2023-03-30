Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9AC6CFEE5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 10:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjC3IqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 04:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjC3Ipz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 04:45:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 488647D98;
        Thu, 30 Mar 2023 01:45:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9256D2F4;
        Thu, 30 Mar 2023 01:46:15 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 83F2E3F73F;
        Thu, 30 Mar 2023 01:45:29 -0700 (PDT)
Date:   Thu, 30 Mar 2023 09:45:19 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, nicola.mazzucato@arm.com,
        Tushar.Khandelwal@arm.com, viresh.kumar@linaro.org,
        jassisinghbrar@gmail.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: mailbox : arm,mhuv2: Allow for more RX
 interrupts
Message-ID: <ZCVL+zzCtItSPkr+@e120937-lin>
References: <20230329153936.394911-1-cristian.marussi@arm.com>
 <20230329153936.394911-2-cristian.marussi@arm.com>
 <7e93c0c9-0a84-c1ce-a978-c4743963012b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e93c0c9-0a84-c1ce-a978-c4743963012b@linaro.org>
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 09:36:06AM +0200, Krzysztof Kozlowski wrote:
> On 29/03/2023 17:39, Cristian Marussi wrote:
> > The ARM MHUv2 Receiver block can indeed support more interrupts, up to the
> > maximum number of available channels, but anyway no more than the maximum
> > number of supported interrupt for an AMBA device.
> > 
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> > Cc: devicetree@vger.kernel.org
> > 
> >  .../devicetree/bindings/mailbox/arm,mhuv2.yaml      | 13 +++++++++----
> >  1 file changed, 9 insertions(+), 4 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/mailbox/arm,mhuv2.yaml b/Documentation/devicetree/bindings/mailbox/arm,mhuv2.yaml
> > index a4f1fe63659a..5a57f4e2a623 100644
> > --- a/Documentation/devicetree/bindings/mailbox/arm,mhuv2.yaml
> > +++ b/Documentation/devicetree/bindings/mailbox/arm,mhuv2.yaml
> > @@ -69,10 +69,15 @@ properties:
> >  
> >    interrupts:
> >      description: |
> > -      The MHUv2 controller always implements an interrupt in the "receiver"
> > -      mode, while the interrupt in the "sender" mode was not available in the
> > -      version MHUv2.0, but the later versions do have it.
> > -    maxItems: 1
> > +      The MHUv2 controller always implements at least an interrupt in the
> > +      "receiver" mode, while the interrupt in the "sender" mode was not
> > +      available in the version MHUv2.0, but the later versions do have it.
> > +      In "receiver" mode, beside a single combined interrupt, there could be
> > +      multiple interrupts, up to the number of implemented channels but anyway
> > +      no more than the maximum number of interrupts potentially supported by
> > +      AMBA.
> 

Hi,

> Last sentence indicates that TX mode has something else, e.g. max 1
> interrupt. Either correct the sentence or add if:then: narrowing it for TX.
> 

By the spec really you can have up to 124 rx interrupt (one per channel) and
optionally 124 tx interrupt too. At least one RX is mandatory, while the TX
clear channel iterrupt is optional (and not supported at all for spec < 2.1)

In both cases you could just have one single combined interrupt, though,
and this is what the driver did, and still do (I have noot changed this), on
the TX side: it just supports one single combined tx interrupt.

So on the TX side, at the HW level, there could be really 124 interrupts
BUT the driver still only support a single combined one.

So I think my statement above is anyway ambiguos and I'll fix it, but how to
fix it, really depends if we want to describe fully what the HW potentially
supports OR what the driver really can cope with as of now.

Thanks,
Cristian
