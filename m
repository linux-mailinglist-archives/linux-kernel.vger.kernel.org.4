Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149076CF151
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 19:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjC2RpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 13:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbjC2RpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 13:45:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3F1ED525E;
        Wed, 29 Mar 2023 10:45:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 295332F4;
        Wed, 29 Mar 2023 10:45:52 -0700 (PDT)
Received: from bogus (unknown [10.57.52.160])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3795D3F6C4;
        Wed, 29 Mar 2023 10:45:05 -0700 (PDT)
Date:   Wed, 29 Mar 2023 18:44:31 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        nicola.mazzucato@arm.com, Tushar.Khandelwal@arm.com,
        viresh.kumar@linaro.org, jassisinghbrar@gmail.com,
        Rob Herring <robh+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: mailbox : arm,mhuv2: Allow for more RX
 interrupts
Message-ID: <20230329174431.yga3c233sazimane@bogus>
References: <20230329153936.394911-1-cristian.marussi@arm.com>
 <20230329153936.394911-2-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329153936.394911-2-cristian.marussi@arm.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 04:39:35PM +0100, Cristian Marussi wrote:
> The ARM MHUv2 Receiver block can indeed support more interrupts, up to the
> maximum number of available channels, but anyway no more than the maximum
> number of supported interrupt for an AMBA device.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: devicetree@vger.kernel.org
> 
>  .../devicetree/bindings/mailbox/arm,mhuv2.yaml      | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/arm,mhuv2.yaml b/Documentation/devicetree/bindings/mailbox/arm,mhuv2.yaml
> index a4f1fe63659a..5a57f4e2a623 100644
> --- a/Documentation/devicetree/bindings/mailbox/arm,mhuv2.yaml
> +++ b/Documentation/devicetree/bindings/mailbox/arm,mhuv2.yaml
> @@ -69,10 +69,15 @@ properties:
>  
>    interrupts:
>      description: |
> -      The MHUv2 controller always implements an interrupt in the "receiver"
> -      mode, while the interrupt in the "sender" mode was not available in the
> -      version MHUv2.0, but the later versions do have it.
> -    maxItems: 1
> +      The MHUv2 controller always implements at least an interrupt in the
> +      "receiver" mode, while the interrupt in the "sender" mode was not
> +      available in the version MHUv2.0, but the later versions do have it.
> +      In "receiver" mode, beside a single combined interrupt, there could be
> +      multiple interrupts, up to the number of implemented channels but anyway
> +      no more than the maximum number of interrupts potentially supported by
> +      AMBA.
> +    minItems: 1
> +    maxItems: 9

I am not sure 9 is the correct value here. IIUC it is just what Linux defines
as AMBA_NR_IRQS. Looking at the history it was bumped from 2 to 9 for use
by PL330 DMA driver. I couldn't find anything to relate this 9 in any
AMBA or other related specification.

Ideally I would say we don't know what the max here. We just have a platform
implementing 2 interrupts now. Do we for with 2 for now and change it if some
new users require more in the future ?

I will leave that to the DT maintainers but 9 is simply random based on Linux
code so I would rather choose some other random number with a better reasoning
than 9 as AMBA code in the kernel is limiting it to 9.

-- 
Regards,
Sudeep
