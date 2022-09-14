Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682D55B86FB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 13:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiINLFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 07:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiINLE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 07:04:57 -0400
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BD11117E;
        Wed, 14 Sep 2022 04:04:51 -0700 (PDT)
Received: by soltyk.jannau.net (Postfix, from userid 1000)
        id 11B5426F050; Wed, 14 Sep 2022 13:04:49 +0200 (CEST)
Date:   Wed, 14 Sep 2022 13:04:49 +0200
From:   Janne Grunau <j@jannau.net>
To:     Rob Herring <robh@kernel.org>
Cc:     asahi@lists.linux.dev, Mark Kettenis <kettenis@openbsd.org>,
        Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sven Peter <sven@svenpeter.dev>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 06/10] arm64: dts: apple: Add initial
 t6000/t6001/t6002 DTs
Message-ID: <20220914110448.GF4024@jannau.net>
References: <20220909135103.98179-1-j@jannau.net>
 <20220909135103.98179-7-j@jannau.net>
 <20220913133207.GA3500192-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913133207.GA3500192-robh@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-13 08:32:07 -0500, Rob Herring wrote:
> On Fri, Sep 09, 2022 at 03:50:59PM +0200, Janne Grunau wrote:
> > From: Hector Martin <marcan@marcan.st>
> > 
> > These SoCs are found in Apple devices with M1 Pro (t6000), M1 Max
> > (t6001) and M1 Ultra (t6002).
> > 
> > t6000 is a cut-down version of t6001, so the former just includes the
> > latter and disables the missing bits (This is currently just one PMGR
> > node and all of its domains.
> > 
> > t6002 is two connected t6001 dies. The implementation seems to use
> > t6001 with blocks disabled (mostly on the second die). MMIO addresses on
> > the second die have a constant offset. The interrupt controller is
> > multi-die aware. This setup can be represented in the device tree with
> > two top level "soc" nodes. The MMIO offset is applied via "ranges" and
> > devices are included with preproceesor macros to make the node labels
> > unique and to specify the die number for the interrupt definition.
> > 
> > Device nodes are distributed over dtsi files based on whether they are
> > present on both dies or just on the first die. The only execption is the
> > NVMe controller which resides on the second die. Its nodes are in a
> > separate file.
> > 
> > Signed-off-by: Hector Martin <marcan@marcan.st>
> > Co-developed-by: Janne Grunau <j@jannau.net>
> > Signed-off-by: Janne Grunau <j@jannau.net>
> > 
> > ---
> > 
> > 
> > ---
> >  arch/arm64/boot/dts/apple/multi-die-cpp.h     |   23 +
> >  arch/arm64/boot/dts/apple/t6000.dtsi          |   18 +
> >  arch/arm64/boot/dts/apple/t6001.dtsi          |   63 +
> >  arch/arm64/boot/dts/apple/t6002.dtsi          |  173 ++
> >  arch/arm64/boot/dts/apple/t600x-common.dtsi   |  128 ++
> >  arch/arm64/boot/dts/apple/t600x-die0.dtsi     |  298 +++
> >  arch/arm64/boot/dts/apple/t600x-dieX.dtsi     |  103 +
> >  .../arm64/boot/dts/apple/t600x-gpio-pins.dtsi |   45 +
> >  arch/arm64/boot/dts/apple/t600x-nvme.dtsi     |   42 +
> >  arch/arm64/boot/dts/apple/t600x-pmgr.dtsi     | 2012 +++++++++++++++++
> >  10 files changed, 2905 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/apple/multi-die-cpp.h
> >  create mode 100644 arch/arm64/boot/dts/apple/t6000.dtsi
> >  create mode 100644 arch/arm64/boot/dts/apple/t6001.dtsi
> >  create mode 100644 arch/arm64/boot/dts/apple/t6002.dtsi
> >  create mode 100644 arch/arm64/boot/dts/apple/t600x-common.dtsi
> >  create mode 100644 arch/arm64/boot/dts/apple/t600x-die0.dtsi
> >  create mode 100644 arch/arm64/boot/dts/apple/t600x-dieX.dtsi
> >  create mode 100644 arch/arm64/boot/dts/apple/t600x-gpio-pins.dtsi
> >  create mode 100644 arch/arm64/boot/dts/apple/t600x-nvme.dtsi
> >  create mode 100644 arch/arm64/boot/dts/apple/t600x-pmgr.dtsi
> > 
> > diff --git a/arch/arm64/boot/dts/apple/multi-die-cpp.h b/arch/arm64/boot/dts/apple/multi-die-cpp.h
> > new file mode 100644
> > index 000000000000..153d89dd0ae1
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/apple/multi-die-cpp.h
> > @@ -0,0 +1,23 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ OR MIT
> > + *
> > + * C preprocessor macros for t600x multi die support.
> > + */
> > +
> > +#ifndef __DTS_APPLE_MULTI_DIE_CPP_H
> > +#define __DTS_APPLE_MULTI_DIE_CPP_H
> > +
> > +#ifndef __stringify
> > +/* copied from include/linux/stringify.h */
> 
> Which is dual licensed? Arguably, not big enough to matter.

include/linux/stringify.h has no license header at all. If that's 
acceptable I will drop it from this file as well.
I started from scratch with the SPDX header from other apple dts files.  
I should have paid more attention after replacing it with kernel 
__stringify (I probably would have updated it if stringify.h had a SPDX 
header). 

> > +#define __stringify_1(x...)     #x
> > +#define __stringify(x...)       __stringify_1(x)
> > +#endif
> > +
> > +#ifndef __concat
> > +#define __concat_1(x, y...)     x ## y
> > +#define __concat(x, y...)       __concat_1(x, y)
> > +#endif
> > +
> > +#define DIE_NODE(a) __concat(a, DIE)
> > +#define DIE_LABEL(a) __stringify(__concat(a, DIE))
> 
> Not a pattern we encourage in DT, but seems necessary here.

That is probably an arguments for keeping __concat/__stringify local 
instead of adding it to include/dt-bindings 

> > +
> > +#endif /* !__LINUX_STRINGIFY_H */
> > diff --git a/arch/arm64/boot/dts/apple/t6000.dtsi b/arch/arm64/boot/dts/apple/t6000.dtsi
> > new file mode 100644
> > index 000000000000..89c3b211b116
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/apple/t6000.dtsi
> > @@ -0,0 +1,18 @@
> > +// SPDX-License-Identifier: GPL-2.0+ OR MIT
> > +/*
> > + * Apple T6000 "M1 Pro" SoC
> > + *
> > + * Other names: H13J, "Jade Chop"
> > + *
> > + * Copyright The Asahi Linux Contributors
> > + */
> > +
> > +/* This chip is just a cut down version of t6001, so include it and disable the missing parts */
> > +
> > +#include "t6001.dtsi"
> > +
> > +/ {
> > +	compatible = "apple,t6000", "apple,arm-platform";
> > +};
> > +
> > +/delete-node/ &pmgr_south;
> > diff --git a/arch/arm64/boot/dts/apple/t6001.dtsi b/arch/arm64/boot/dts/apple/t6001.dtsi
> > new file mode 100644
> > index 000000000000..620b17e4031f
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/apple/t6001.dtsi
> > @@ -0,0 +1,63 @@
> > +// SPDX-License-Identifier: GPL-2.0+ OR MIT
> > +/*
> > + * Apple T6001 "M1 Max" SoC
> > + *
> > + * Other names: H13J, "Jade"
> > + *
> > + * Copyright The Asahi Linux Contributors
> > + */
> > +
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/interrupt-controller/apple-aic.h>
> > +#include <dt-bindings/interrupt-controller/irq.h>
> > +#include <dt-bindings/pinctrl/apple.h>
> > +
> > +#include "multi-die-cpp.h"
> > +
> > +#include "t600x-common.dtsi"
> > +
> > +/ {
> > +	compatible = "apple,t6001", "apple,arm-platform";
> > +
> > +	soc {
> > +		compatible = "simple-bus";
> > +		#address-cells = <2>;
> > +		#size-cells = <2>;
> > +
> > +		ranges;
> > +		nonposted-mmio;
> > +
> > +		// filled via templated includes at the end of the file
> > +	};
> > +};
> > +
> > +#define DIE
> > +#define DIE_NO 0
> > +
> > +&{/soc} {
> > +	#include "t600x-die0.dtsi"
> > +	#include "t600x-dieX.dtsi"
> > +	#include "t600x-nvme.dtsi"
> > +};
> > +
> > +#include "t600x-gpio-pins.dtsi"
> > +#include "t600x-pmgr.dtsi"
> > +
> > +#undef DIE
> > +#undef DIE_NO
> > +
> > +
> > +&aic {
> > +	affinities {
> > +		e-core-pmu-affinity {
> > +			apple,fiq-index = <AIC_CPU_PMU_E>;
> > +			cpus = <&cpu_e00 &cpu_e01>;
> > +		};
> > +
> > +		p-core-pmu-affinity {
> > +			apple,fiq-index = <AIC_CPU_PMU_P>;
> > +			cpus = <&cpu_p00 &cpu_p01 &cpu_p02 &cpu_p03
> > +				&cpu_p10 &cpu_p11 &cpu_p12 &cpu_p13>;
> > +		};
> > +	};
> > +};
> > diff --git a/arch/arm64/boot/dts/apple/t6002.dtsi b/arch/arm64/boot/dts/apple/t6002.dtsi
> > new file mode 100644
> > index 000000000000..32c971c0e191
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/apple/t6002.dtsi
> > @@ -0,0 +1,173 @@
> > +// SPDX-License-Identifier: GPL-2.0+ OR MIT
> > +/*
> > + * Apple T6002 "M1 Ultra" SoC
> > + *
> > + * Other names: H13J, "Jade 2C"
> > + *
> > + * Copyright The Asahi Linux Contributors
> > + */
> > +
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/interrupt-controller/apple-aic.h>
> > +#include <dt-bindings/interrupt-controller/irq.h>
> > +#include <dt-bindings/pinctrl/apple.h>
> > +
> > +#include "multi-die-cpp.h"
> > +
> > +#include "t600x-common.dtsi"
> > +
> > +/ {
> > +	compatible = "apple,t6002", "apple,arm-platform";
> > +
> > +	#address-cells = <2>;
> > +	#size-cells = <2>;
> > +
> > +	cpus {
> > +		cpu_e10: cpu@800 {
> > +			compatible = "apple,icestorm";
> > +			device_type = "cpu";
> > +			reg = <0x0 0x800>;
> > +			enable-method = "spin-table";
> > +			cpu-release-addr = <0 0>; /* To be filled by loader */
> > +		};
> > +
> > +		cpu_e11: cpu@801 {
> > +			compatible = "apple,icestorm";
> > +			device_type = "cpu";
> > +			reg = <0x0 0x801>;
> > +			enable-method = "spin-table";
> > +			cpu-release-addr = <0 0>; /* To be filled by loader */
> > +		};
> > +
> > +		cpu_p20: cpu@10900 {
> > +			compatible = "apple,firestorm";
> > +			device_type = "cpu";
> > +			reg = <0x0 0x10900>;
> > +			enable-method = "spin-table";
> > +			cpu-release-addr = <0 0>; /* To be filled by loader */
> > +		};
> > +
> > +		cpu_p21: cpu@10901 {
> > +			compatible = "apple,firestorm";
> > +			device_type = "cpu";
> > +			reg = <0x0 0x10901>;
> > +			enable-method = "spin-table";
> > +			cpu-release-addr = <0 0>; /* To be filled by loader */
> > +		};
> > +
> > +		cpu_p22: cpu@10902 {
> > +			compatible = "apple,firestorm";
> > +			device_type = "cpu";
> > +			reg = <0x0 0x10902>;
> > +			enable-method = "spin-table";
> > +			cpu-release-addr = <0 0>; /* To be filled by loader */
> > +		};
> > +
> > +		cpu_p23: cpu@10903 {
> > +			compatible = "apple,firestorm";
> > +			device_type = "cpu";
> > +			reg = <0x0 0x10903>;
> > +			enable-method = "spin-table";
> > +			cpu-release-addr = <0 0>; /* To be filled by loader */
> > +		};
> > +
> > +		cpu_p30: cpu@10a00 {
> > +			compatible = "apple,firestorm";
> > +			device_type = "cpu";
> > +			reg = <0x0 0x10a00>;
> > +			enable-method = "spin-table";
> > +			cpu-release-addr = <0 0>; /* To be filled by loader */
> > +		};
> > +
> > +		cpu_p31: cpu@10a01 {
> > +			compatible = "apple,firestorm";
> > +			device_type = "cpu";
> > +			reg = <0x0 0x10a01>;
> > +			enable-method = "spin-table";
> > +			cpu-release-addr = <0 0>; /* To be filled by loader */
> > +		};
> > +
> > +		cpu_p32: cpu@10a02 {
> > +			compatible = "apple,firestorm";
> > +			device_type = "cpu";
> > +			reg = <0x0 0x10a02>;
> > +			enable-method = "spin-table";
> > +			cpu-release-addr = <0 0>; /* To be filled by loader */
> > +		};
> > +
> > +		cpu_p33: cpu@10a03 {
> > +			compatible = "apple,firestorm";
> > +			device_type = "cpu";
> > +			reg = <0x0 0x10a03>;
> > +			enable-method = "spin-table";
> > +			cpu-release-addr = <0 0>; /* To be filled by loader */
> > +		};
> > +	};
> > +
> > +	die0: soc@0 {
> 
> Where does 0 come from? 
> 
> Unit address comes from 'reg' or 'ranges'. Empty ranges here means all 
> of the address space is part of this node which obviously is not true 
> given the next node. You need a 1:1 non-empty ranges entry.

fixed locally

> > +		compatible = "simple-bus";
> > +		#address-cells = <2>;
> > +		#size-cells = <2>;
> > +		ranges;
> > +		nonposted-mmio;
> > +
> > +		// filled via templated includes at the end of the file
> > +	};
> > +
> > +	die1: soc@1 {
> 
> soc@2200000000

fixed

> > +		compatible = "simple-bus";
> > +		#address-cells = <2>;
> > +		#size-cells = <2>;
> > +		ranges = <0x2 0x0 0x22 0x0 0x4 0x0>,
> > +				<0x7 0x0 0x27 0x0 0xf 0x80000000>;
> > +		nonposted-mmio;
> > +
> > +		// filled via templated includes at the end of the file
> > +	};
> > +};
> > +
> > +#define DIE
> > +#define DIE_NO 0
> > +
> > +&die0 {
> > +	#include "t600x-die0.dtsi"
> 
> Looks like this one is not templated, so it doesn't really need to be 
> here. But it's fine.

I added here to have all '#include' directives in a single place.  
t600x-gpio-pins.dtsi isn't templated either. 

> > +	#include "t600x-dieX.dtsi"
> > +};
> > +
> > +#include "t600x-pmgr.dtsi"
> > +#include "t600x-gpio-pins.dtsi"
> > +
> > +#undef DIE
> > +#undef DIE_NO
> > +
> > +#define DIE _die1
> > +#define DIE_NO 1
> > +
> > +&die1 {
> > +	#include "t600x-dieX.dtsi"
> > +	#include "t600x-nvme.dtsi"
> > +};
> > +
> > +#include "t600x-pmgr.dtsi"
> > +
> > +#undef DIE
> > +#undef DIE_NO

thanks

