Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCAE167B39C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 14:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235599AbjAYNn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 08:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235589AbjAYNnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 08:43:53 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 852085864B;
        Wed, 25 Jan 2023 05:43:52 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 741064B3;
        Wed, 25 Jan 2023 05:44:33 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A991C3F71E;
        Wed, 25 Jan 2023 05:43:50 -0800 (PST)
Date:   Wed, 25 Jan 2023 13:43:48 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: firmware: arm,scmi: Restrict protocol child
 node properties
Message-ID: <Y9EyB+OO7MyGy20w@e120937-lin>
References: <20230124222023.316089-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124222023.316089-1-robh@kernel.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 04:20:23PM -0600, Rob Herring wrote:
> The SCMI protocol child nodes are missing any constraints on unknown
> properties. Specifically, either 'unevaluatedProperties' or
> 'additionalProperties' is needed. The current structure with a regex
> match for all child nodes doesn't work for this purpose, so let's move
> the common properties '$defs' entry which each specific protocol node
> can reference and set 'unevaluatedProperties: false'.
> 

Hi Rob,

> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/firmware/arm,scmi.yaml           | 43 ++++++++++++++-----
>  1 file changed, 33 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> index 176796931a22..2f7c51c75e85 100644
> --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> @@ -100,7 +100,9 @@ properties:
>        Channel specifier required when using OP-TEE transport.
>  
>    protocol@11:
> -    type: object
> +    $ref: '#/$defs/protocol-node'
> +    unevaluatedProperties: false
> +
>      properties:
>        reg:
>          const: 0x11
> @@ -112,7 +114,9 @@ properties:
>        - '#power-domain-cells'
>  
>    protocol@13:
> -    type: object
> +    $ref: '#/$defs/protocol-node'
> +    unevaluatedProperties: false
> +
>      properties:
>        reg:
>          const: 0x13
> @@ -124,7 +128,9 @@ properties:
>        - '#clock-cells'
>  
>    protocol@14:
> -    type: object
> +    $ref: '#/$defs/protocol-node'
> +    unevaluatedProperties: false
> +
>      properties:
>        reg:
>          const: 0x14
> @@ -136,7 +142,9 @@ properties:
>        - '#clock-cells'
>  
>    protocol@15:
> -    type: object
> +    $ref: '#/$defs/protocol-node'
> +    unevaluatedProperties: false
> +
>      properties:
>        reg:
>          const: 0x15
> @@ -148,7 +156,9 @@ properties:
>        - '#thermal-sensor-cells'
>  
>    protocol@16:
> -    type: object
> +    $ref: '#/$defs/protocol-node'
> +    unevaluatedProperties: false
> +
>      properties:
>        reg:
>          const: 0x16
> @@ -160,20 +170,31 @@ properties:
>        - '#reset-cells'
>  
>    protocol@17:
> -    type: object
> +    $ref: '#/$defs/protocol-node'
> +    unevaluatedProperties: false
> +
>      properties:
>        reg:
>          const: 0x17
>  
>        regulators:
>          type: object
> +        additionalProperties: false
>          description:
>            The list of all regulators provided by this SCMI controller.
>  
> +        properties:
> +          '#address-cells':
> +            const: 1
> +
> +          '#size-cells':
> +            const: 0
> +
>          patternProperties:
> -          '^regulators@[0-9a-f]+$':
> +          '^regulator@[0-9a-f]+$':
>              type: object
>              $ref: "../regulator/regulator.yaml#"
> +            unevaluatedProperties: false
>  
>              properties:
>                reg:
> @@ -184,15 +205,17 @@ properties:
>                - reg
>  
>    protocol@18:
> -    type: object
> +    $ref: '#/$defs/protocol-node'
> +    unevaluatedProperties: false
> +
>      properties:
>        reg:
>          const: 0x18
>  
>  additionalProperties: false
>  
> -patternProperties:
> -  '^protocol@[0-9a-f]+$':
> +$defs:
> +  protocol-node:
>      type: object
>      description:

so now that the catch-all protocol@ patternProperty is gone in favour
of the 'protocol-node' definition and $refs, does that mean that any
current and future SCMI officially published protocol <N> has to be
added to the above explicit protocol list, even though it does not
have any special additional required property beside reg ?
(like protocol@18 above...)

As an example SystemPower protocol@12 is not listed above too and it
has nothing more than a reg=0x12 prop (liek 0x18), but before this patch
was 'covered' by the patternProperty (so Krzysztof shot down, rightly,
my recent attempt to add a distinct protocol@12 def), but now it does not
seem anymore the case...so will we need to add an explicit protocol node
for any future protocol addition ? (SCMI is extensible up to 255
protos..)

Thanks,
Cristian

