Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C296DDB4A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 14:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjDKMyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 08:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjDKMyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 08:54:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5AD9A4C1F;
        Tue, 11 Apr 2023 05:54:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5BC46D75;
        Tue, 11 Apr 2023 05:55:08 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BBC5C3F6C4;
        Tue, 11 Apr 2023 05:54:22 -0700 (PDT)
Date:   Tue, 11 Apr 2023 13:54:20 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Nikunj Kela <quic_nkela@quicinc.com>
Cc:     cristian.marussi@arm.com, robh+dt@kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkp@intel.com
Subject: Re: [PATCH v2 1/2] dt-bindings: firmware: arm,scmi: support
 parameter passing in smc/hvc
Message-ID: <20230411125420.lymhjf5chxdr7if7@bogus>
References: <20230409181918.29270-1-quic_nkela@quicinc.com>
 <20230410182058.8949-1-quic_nkela@quicinc.com>
 <20230410182058.8949-2-quic_nkela@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230410182058.8949-2-quic_nkela@quicinc.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 11:20:57AM -0700, Nikunj Kela wrote:
> Currently, smc/hvc calls are made with smc-id only. The parameters are
> all set to zeros. This patch defines two optional device tree bindings,
> that can be used to pass parameters in smc/hvc calls.
>

Why 2 values ?

> This is useful when multiple scmi instances are used with common smc-id.
>

I really would like to avoid this binding. Because of lack of standard
SMC/HVC FID for SCMI we had to add this binding. Extending for newer use
case like this in a vendor specific way is something I would like to avoid.

> Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
> ---
>  .../devicetree/bindings/firmware/arm,scmi.yaml | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> index 5824c43e9893..ecf76b763c8c 100644
> --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> @@ -115,6 +115,23 @@ properties:
>      description:
>        SMC id required when using smc or hvc transports
>  
> +  arm,smc32-params:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      An optional parameter list passed in smc32 or hvc32 calls
> +    default: 0
> +    minItems: 1
> +    maxItems: 6
> +
> +  arm,smc64-params:
> +    $ref: /schemas/types.yaml#/definitions/uint64-array
> +    description:
> +      An optional parameter list passed in smc64 or hvc64 calls.
> +      This is valid only on ARM64 machines.
> +    default: 0
> +    minItems: 1
> +    maxItems: 6
> +

Even if we end up adding(which I would very much like to avoid), I don't see
the need for 32 and 64 bit params like this. There must be ways to avoid that
used by some property in some other binding(I will look for one if we choose
this path)

-- 
Regards,
Sudeep
