Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484EE7312D3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 10:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238540AbjFOI4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 04:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjFOI4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 04:56:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C846B1BDA;
        Thu, 15 Jun 2023 01:56:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD3BF1FB;
        Thu, 15 Jun 2023 01:57:17 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F2C0A3F71E;
        Thu, 15 Jun 2023 01:56:31 -0700 (PDT)
Date:   Thu, 15 Jun 2023 09:56:29 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Tushar Nimkar <quic_tnimkar@quicinc.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_lsrao@quicinc.com, quic_mkshah@quicinc.com,
        Sudeep Holla <sudeep.holla@arm.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: idle-states: Add
 idle-state-disabled property
Message-ID: <20230615085629.b2aaumhq7yqhs5lf@bogus>
References: <20230608085544.16211-1-quic_tnimkar@quicinc.com>
 <20230608085544.16211-2-quic_tnimkar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608085544.16211-2-quic_tnimkar@quicinc.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 02:25:42PM +0530, Tushar Nimkar wrote:
> This change adds idle-state-disabled property using which certain or all
> idle-states can be kept disabled during boot-up. Once boot-up is completed
> same can be enabled using below command.
>
> echo N > /sys/devices/system/cpu/cpuX/cpuidle/stateX/disable
>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Tushar Nimkar <quic_tnimkar@quicinc.com>
> ---
>  Documentation/devicetree/bindings/cpu/idle-states.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/cpu/idle-states.yaml b/Documentation/devicetree/bindings/cpu/idle-states.yaml
> index b8cc826c9501..f999bc666bbd 100644
> --- a/Documentation/devicetree/bindings/cpu/idle-states.yaml
> +++ b/Documentation/devicetree/bindings/cpu/idle-states.yaml
> @@ -358,6 +358,13 @@ patternProperties:
>            systems entry-latency-us + exit-latency-us will exceed
>            wakeup-latency-us by this duration.
>
> +      idle-state-disabled:
> +        description: |
> +          If present the idle state stays disabled. It can be enabled back from
> +          shell using below command.
> +          echo N > /sys/devices/system/cpu/cpuX/cpuidle/stateX/disable
> +        type: boolean
> +

This is clearly a policy and not a hardware or firmware feature to expose
in the device tree. So NACK, why can't you load it modules if you don't want
idle states in the boot.

It is same as choosing any default governor or performance states, will you
add those next ? It is simply policy not a feature/property to be exposed
in the device tree.

--
Regards,
Sudeep
