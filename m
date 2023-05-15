Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D6C702A14
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 12:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240792AbjEOKIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 06:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240413AbjEOKI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 06:08:26 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3CD781FE2;
        Mon, 15 May 2023 03:08:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 765DB2F4;
        Mon, 15 May 2023 03:09:00 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CFD0E3F67D;
        Mon, 15 May 2023 03:08:12 -0700 (PDT)
Date:   Mon, 15 May 2023 11:08:10 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ayan Kumar Halder <ayankuma@amd.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        geert+renesas@glider.be, magnus.damm@gmail.com,
        konrad.dybcio@linaro.org, andersson@kernel.org,
        mazziesaccount@gmail.com, conor.dooley@microchip.com, j@jannau.net,
        mailingradian@gmail.com, me@iskren.info, lpieralisi@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, Julien Grall <julien@xen.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Michal Orzel <michal.orzel@amd.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: Re: Need suggestions for smp related properties in cpus.yaml to
 support smpboot for cortex-r52 based platform
Message-ID: <20230515100810.ctebdbqlienbcf7t@bogus>
References: <c5ed90c7-7126-0757-a0e3-e3d1fcab2ecc@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c5ed90c7-7126-0757-a0e3-e3d1fcab2ecc@amd.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 10:35:37AM +0100, Ayan Kumar Halder wrote:
> Hi Device Tree engineers,
>
> Recently I have ported Xen on Cortex-R52 (AArch32-V8R processor) for our AMD
> platform.
>

I remember that there was some exploration on feasibility of using PSCI
here. What happened to that ? Any summary why that was dropped ?

> I was discussing with xen-devel community about how we can properly support
> smpboot when I was suggested that this might be the correct forum for
> discussion.
>
> Please refer
> https://lists.xenproject.org/archives/html/xen-devel/2023-05/msg00224.html
> and the follow-ups for context.
>
>
> The way smpboot works on our platform is as follows:-
>
> 1. core0 writes to register (say regA) the address of the secondary core
> initialization routine.
>
> 2. core0 writes to another register (say regB) the value "0x1" to put the
> secondary core in reset mode.
>
> 3. core0 writes to regB the value "0x0" to pull the secondary core out of
> reset mode.
>
> regA, regB will differ for core1, core2, core3 and so on.
>

Sounds OK but will you ever need to support power management on these cores ?
If so, just start with PSCI or provide reasons as why it doesn't fit well
before exploring and extending the existing spin table bindings.

>
> Currently, I am trying to bringup core1 only.
>
>
> I am thinking to use "enable-method=spin-table" in the cpu node for core1. 
> So that I can use "cpu-release-address" for regA.
>
> For regB, I am thinking of introducing a new property "amd-cpu-reset-addr"
> in the cpu node.
>
> Please let me know your thoughts on this approach. I am also open to any
> alternative suggestions.
>
>
> Also I see that in https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/devicetree/bindings/arm/cpus.yaml#L87
> , "arm,cortex-r52" is missing.
>

Yes that should be fine IMO.

> Can I submit a patch (a one line change) to add this ?
>

Of course, it makes it easy to accept or reject rather than this question
hidden as part of other discussion.

--
Regards,
Sudeep
