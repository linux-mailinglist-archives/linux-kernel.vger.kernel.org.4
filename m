Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECA9690FE9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 19:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjBISFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 13:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjBISFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 13:05:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8806C458A1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 10:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675965902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rhk3TlguShJQwMaXhUewuGHiMRfSnuWlrCopi6dQf+I=;
        b=ebioQpybHPhe9cHyOAFTuwaxe7YU4BF3pWrroen+sw54Xzth7s8C3GVAr6vouoqP8uKVzs
        tsw/GWbiqRfgOHYUxpgGdMomU2EdQzlIMAZ02e0OKRYzpsaWprRBHhr8sB1DOkOXR2Xdrq
        r3I6GZgKBInqdO0k3/GItPwPiO4oaQw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-6-woJGnM90NluthcIxGFw_vw-1; Thu, 09 Feb 2023 13:05:00 -0500
X-MC-Unique: woJGnM90NluthcIxGFw_vw-1
Received: by mail-qt1-f200.google.com with SMTP id a24-20020ac87218000000b003bb7c7a82f7so1528142qtp.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 10:05:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rhk3TlguShJQwMaXhUewuGHiMRfSnuWlrCopi6dQf+I=;
        b=RdE+FdJ66rouGefHhcrcPw+FVE1YnBm80juRNksSWeLe43qRsZ7AmXVcOyvv7t89HL
         DyWrVN5ums84qy+7rnKvh6eTrioPpo87vZoBIXvMOaZxS2jDaa7NXP+m0aC8YuhM3x+2
         jp6/qGovzM7c4lpFA9Tc3YV4V1R7knCvbz1+8gNapuWU9+2mWag+5th36mx9IsJo7ox5
         3c/OGPn1kAD/RnaE8Rn4Fw9/JGTfyYO4VBie0RMyUej8FlsrVuntORH1eqKH6Z2WQmgL
         2ECTUF3ptwx4Q97JiW0jSbX7zkYuVjxUUFFS3Iscp+4CIi3LC3C8e6wine56PtaLx1ne
         tJLA==
X-Gm-Message-State: AO0yUKX4RhKJayiFo+xEofgDXJ8hkabHThnYZz1QNs39+9ImSZSY+Ir8
        iinricqJMrLTaKQiIExs5M5jsW1Rfz9//Df3c7pMEqjenrl421Ldixa7Afx0nL0amCDwCO+dwmd
        SMy540RPL/te2gGd02+jHQ0vl
X-Received: by 2002:a05:622a:47:b0:3b9:ed95:6aae with SMTP id y7-20020a05622a004700b003b9ed956aaemr22117106qtw.45.1675965898554;
        Thu, 09 Feb 2023 10:04:58 -0800 (PST)
X-Google-Smtp-Source: AK7set/0K4dY+HPduXfQzxnLy1bemJrhP+mF49PybkqnpNR363VjcRKVBMFULot/DTZZZj6c6Buorg==
X-Received: by 2002:a05:622a:47:b0:3b9:ed95:6aae with SMTP id y7-20020a05622a004700b003b9ed956aaemr22117017qtw.45.1675965897924;
        Thu, 09 Feb 2023 10:04:57 -0800 (PST)
Received: from localhost (pool-71-184-142-128.bstnma.fios.verizon.net. [71.184.142.128])
        by smtp.gmail.com with ESMTPSA id c5-20020ac85a85000000b003b84b92052asm1748086qtc.57.2023.02.09.10.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 10:04:57 -0800 (PST)
Date:   Thu, 9 Feb 2023 13:04:56 -0500
From:   Eric Chanudet <echanude@redhat.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v3 5/5] arm64: dts: qcom: add initial support for qcom
 sa8775p-ride
Message-ID: <20230209180456.eahx5fbcd2kax2au@echanude>
References: <20230201152038.203387-1-brgl@bgdev.pl>
 <20230201152038.203387-6-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201152038.203387-6-brgl@bgdev.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 04:20:38PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> This adds basic support for the Qualcomm sa8775p platform and the
> reference board: sa8775p-ride. The dt files describe the basics of the
> SoC and enable booting to shell.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/Makefile         |   1 +
>  arch/arm64/boot/dts/qcom/sa8775p-ride.dts |  47 ++
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi     | 812 ++++++++++++++++++++++
>  3 files changed, 860 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sa8775p-ride.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sa8775p.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index b0423ca3e79f..968e07265959 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -71,6 +71,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= qrb5165-rb5-vision-mezzanine.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sa8155p-adp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sa8295p-adp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sa8540p-ride.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sa8775p-ride.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-idp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-coachz-r1.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-coachz-r1-lte.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> new file mode 100644
> index 000000000000..3adf7349f4e5
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> @@ -0,0 +1,47 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2023, Linaro Limited
> + */
> +
> +/dts-v1/;
> +
> +#include "sa8775p.dtsi"
> +
> +/ {
> +	model = "Qualcomm SA8775P Ride";
> +	compatible = "qcom,sa8775p-ride", "qcom,sa8775p";
> +
> +	aliases {
> +		serial0 = &uart10;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +};
> +
> +&qupv3_id_1 {
> +	status = "okay";
> +};
> +
> +&sleep_clk {
> +	clock-frequency = <32764>;
> +};
> +
> +&tlmm {
> +	qup_uart10_default: qup-uart10-state {
> +		pins = "gpio46", "gpio47";
> +		function = "qup1_se3";
> +	};
> +};
> +
> +&uart10 {
> +	compatible = "qcom,geni-debug-uart";
> +	pinctrl-0 = <&qup_uart10_default>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&xo_board_clk {
> +	clock-frequency = <38400000>;
> +};
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> new file mode 100644
> index 000000000000..dda80124ff3a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> @@ -0,0 +1,812 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2023, Linaro Limited
> + */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/qcom,rpmh.h>
> +#include <dt-bindings/clock/qcom,sa8775p-gcc.h>
> +#include <dt-bindings/interconnect/qcom,sa8775p-rpmh.h>
> +#include <dt-bindings/power/qcom-rpmpd.h>
> +#include <dt-bindings/soc/qcom,rpmh-rsc.h>
> +
> +/ {
> +	interrupt-parent = <&intc>;
> +
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	clocks {
> +		xo_board_clk: xo-board-clk {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +		};
> +
> +		sleep_clk: sleep-clk {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +		};
> +	};
> +
> +	cpus {
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		CPU0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo";
> +			reg = <0x0 0x0>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_0>;
> +			L2_0: l2-cache {
> +				compatible = "cache";
> +				next-level-cache = <&L3_0>;
> +				L3_0: l3-cache {
> +					compatible = "cache";
> +				};
> +			};
> +		};
> +
> +		CPU1: cpu@100 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo";
> +			reg = <0x0 0x100>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_1>;
> +			L2_1: l2-cache {
> +				compatible = "cache";
> +				next-level-cache = <&L3_0>;
> +			};
> +		};
> +
> +		CPU2: cpu@200 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo";
> +			reg = <0x0 0x200>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_2>;
> +			L2_2: l2-cache {
> +				compatible = "cache";
> +				next-level-cache = <&L3_0>;
> +			};
> +		};
> +
> +		CPU3: cpu@300 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo";
> +			reg = <0x0 0x300>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_3>;
> +			L2_3: l2-cache {
> +				compatible = "cache";
> +				next-level-cache = <&L3_0>;
> +			};
> +		};
> +
> +		CPU4: cpu@10000 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo";
> +			reg = <0x0 0x10000>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_4>;
> +			L2_4: l2-cache {
> +				compatible = "cache";
> +				next-level-cache = <&L3_1>;
> +				L3_1: l3-cache {
> +					compatible = "cache";
> +				};
> +
> +			};
> +		};
> +
> +		CPU5: cpu@10100 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo";
> +			reg = <0x0 0x10100>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_5>;
> +			L2_5: l2-cache {
> +				compatible = "cache";
> +				next-level-cache = <&L3_1>;
> +			};
> +		};
> +
> +		CPU6: cpu@10200 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo";
> +			reg = <0x0 0x10200>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_6>;
> +			L2_6: l2-cache {
> +				compatible = "cache";
> +				next-level-cache = <&L3_1>;
> +			};
> +		};
> +
> +		CPU7: cpu@10300 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo";
> +			reg = <0x0 0x10300>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_7>;
> +			L2_7: l2-cache {
> +				compatible = "cache";
> +				next-level-cache = <&L3_1>;
> +			};
> +		};
> +
> +		cpu-map {
> +			cluster0 {
> +				core0 {
> +					cpu = <&CPU0>;
> +				};
> +
> +				core1 {
> +					cpu = <&CPU1>;
> +				};
> +
> +				core2 {
> +					cpu = <&CPU2>;
> +				};
> +
> +				core3 {
> +					cpu = <&CPU3>;
> +				};
> +			};
> +
> +			cluster1 {
> +				core0 {
> +					cpu = <&CPU4>;
> +				};
> +
> +				core1 {
> +					cpu = <&CPU5>;
> +				};
> +
> +				core2 {
> +					cpu = <&CPU6>;
> +				};
> +
> +				core3 {
> +					cpu = <&CPU7>;
> +				};
> +			};
> +		};
> +	};
> +
> +	firmware {
> +		scm {
> +			compatible = "qcom,scm-sa8775p", "qcom,scm";
> +		};
> +	};
> +
> +	aggre1_noc: interconnect-aggre1-noc {
> +		compatible = "qcom,sa8775p-aggre1-noc";
> +		#interconnect-cells = <2>;
> +		qcom,bcm-voters = <&apps_bcm_voter>;
> +	};
> +
> +	aggre2_noc: interconnect-aggre2-noc {
> +		compatible = "qcom,sa8775p-aggre2-noc";
> +		#interconnect-cells = <2>;
> +		qcom,bcm-voters = <&apps_bcm_voter>;
> +	};
> +
> +	clk_virt: interconnect-clk-virt {
> +		compatible = "qcom,sa8775p-clk-virt";
> +		#interconnect-cells = <2>;
> +		qcom,bcm-voters = <&apps_bcm_voter>;
> +	};
> +
> +	config_noc: interconnect-config-noc {
> +		compatible = "qcom,sa8775p-config-noc";
> +		#interconnect-cells = <2>;
> +		qcom,bcm-voters = <&apps_bcm_voter>;
> +	};
> +
> +	dc_noc: interconnect-dc-noc {
> +		compatible = "qcom,sa8775p-dc-noc";
> +		#interconnect-cells = <2>;
> +		qcom,bcm-voters = <&apps_bcm_voter>;
> +	};
> +
> +	gem_noc: interconnect-gem-noc {
> +		compatible = "qcom,sa8775p-gem-noc";
> +		#interconnect-cells = <2>;
> +		qcom,bcm-voters = <&apps_bcm_voter>;
> +	};
> +
> +	gpdsp_anoc: interconnect-gpdsp-anoc {
> +		compatible = "qcom,sa8775p-gpdsp-anoc";
> +		#interconnect-cells = <2>;
> +		qcom,bcm-voters = <&apps_bcm_voter>;
> +	};
> +
> +	lpass_ag_noc: interconnect-lpass-ag-noc {
> +		compatible = "qcom,sa8775p-lpass-ag-noc";
> +		#interconnect-cells = <2>;
> +		qcom,bcm-voters = <&apps_bcm_voter>;
> +	};
> +
> +	mc_virt: interconnect-mc-virt {
> +		compatible = "qcom,sa8775p-mc-virt";
> +		#interconnect-cells = <2>;
> +		qcom,bcm-voters = <&apps_bcm_voter>;
> +	};
> +
> +	mmss_noc: interconnect-mmss-noc {
> +		compatible = "qcom,sa8775p-mmss-noc";
> +		#interconnect-cells = <2>;
> +		qcom,bcm-voters = <&apps_bcm_voter>;
> +	};
> +
> +	nspa_noc: interconnect-nspa-noc {
> +		compatible = "qcom,sa8775p-nspa-noc";
> +		#interconnect-cells = <2>;
> +		qcom,bcm-voters = <&apps_bcm_voter>;
> +	};
> +
> +	nspb_noc: interconnect-nspb-noc {
> +		compatible = "qcom,sa8775p-nspb-noc";
> +		#interconnect-cells = <2>;
> +		qcom,bcm-voters = <&apps_bcm_voter>;
> +	};
> +
> +	pcie_anoc: interconnect-pcie-anoc {
> +		compatible = "qcom,sa8775p-pcie-anoc";
> +		#interconnect-cells = <2>;
> +		qcom,bcm-voters = <&apps_bcm_voter>;
> +	};
> +
> +	system_noc: interconnect-system-noc {
> +		compatible = "qcom,sa8775p-system-noc";
> +		#interconnect-cells = <2>;
> +		qcom,bcm-voters = <&apps_bcm_voter>;
> +	};
> +
> +	/* Will be updated by the bootloader. */
> +	memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x0 0x80000000 0x0 0x0>;
> +	};
> +
> +	qup_opp_table_100mhz: opp-table-qup100mhz {
> +		compatible = "operating-points-v2";
> +
> +		opp-100000000 {
> +			opp-hz = /bits/ 64 <100000000>;
> +			required-opps = <&rpmhpd_opp_svs_l1>;
> +		};
> +	};
> +
> +	psci {
> +		compatible = "arm,psci-1.0";
> +		method = "smc";
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		sail_ss_mem: sail-ss@80000000 {
> +			reg = <0x0 0x80000000 0x0 0x10000000>;
> +			no-map;
> +		};
> +
> +		hyp_mem: hyp@90000000 {
> +			reg = <0x0 0x90000000 0x0 0x600000>;
> +			no-map;
> +		};
> +
> +		xbl_boot_mem: xbl-boot@90600000 {
> +			reg = <0x0 0x90600000 0x0 0x200000>;
> +			no-map;
> +		};
> +
> +		aop_image_mem: aop-image@90800000 {
> +			reg = <0x0 0x90800000 0x0 0x60000>;
> +			no-map;
> +		};
> +
> +		aop_cmd_db_mem: aop-cmd-db@90860000 {
> +			compatible = "qcom,cmd-db";
> +			reg = <0x0 0x90860000 0x0 0x20000>;
> +			no-map;
> +		};
> +
> +		uefi_log: uefi-log@908b0000 {
> +			reg = <0x0 0x908b0000 0x0 0x10000>;
> +			no-map;
> +		};
> +
> +		reserved_mem: reserved@908f0000 {
> +			reg = <0x0 0x908f0000 0x0 0xf000>;
> +			no-map;
> +		};
> +
> +		secdata_apss_mem: secdata-apss@908ff000 {
> +			reg = <0x0 0x908ff000 0x0 0x1000>;
> +			no-map;
> +		};
> +
> +		smem_mem: smem@90900000 {
> +			compatible = "qcom,smem";
> +			reg = <0x0 0x90900000 0x0 0x200000>;
> +			no-map;
> +			hwlocks = <&tcsr_mutex 3>;
> +		};
> +
> +		cpucp_fw_mem: cpucp-fw@90b00000 {
> +			reg = <0x0 0x90b00000 0x0 0x100000>;
> +			no-map;
> +		};
> +
> +		lpass_machine_learning_mem: lpass-machine-learning@93b00000 {
> +			reg = <0x0 0x93b00000 0x0 0xf00000>;
> +			no-map;
> +		};
> +
> +		adsp_rpc_remote_heap_mem: adsp-rpc-remote-heap@94a00000 {
> +			reg = <0x0 0x94a00000 0x0 0x800000>;
> +			no-map;
> +		};
> +
> +		pil_camera_mem: pil-camera@95200000 {
> +			reg = <0x0 0x95200000 0x0 0x500000>;
> +			no-map;
> +		};
> +
> +		pil_adsp_mem: pil-adsp@95c00000 {
> +			reg = <0x0 0x95c00000 0x0 0x1e00000>;
> +			no-map;
> +		};
> +
> +		pil_gdsp0_mem: pil-gdsp0@97b00000 {
> +			reg = <0x0 0x97b00000 0x0 0x1e00000>;
> +			no-map;
> +		};
> +
> +		pil_gdsp1_mem: pil-gdsp1@99900000 {
> +			reg = <0x0 0x99900000 0x0 0x1e00000>;
> +			no-map;
> +		};
> +
> +		pil_cdsp0_mem: pil-cdsp0@9b800000 {
> +			reg = <0x0 0x9b800000 0x0 0x1e00000>;
> +			no-map;
> +		};
> +
> +		pil_gpu_mem: pil-gpu@9d600000 {
> +			reg = <0x0 0x9d600000 0x0 0x2000>;
> +			no-map;
> +		};
> +
> +		pil_cdsp1_mem: pil-cdsp1@9d700000 {
> +			reg = <0x0 0x9d700000 0x0 0x1e00000>;
> +			no-map;
> +		};
> +
> +		pil_cvp_mem: pil-cvp@9f500000 {
> +			reg = <0x0 0x9f500000 0x0 0x700000>;
> +			no-map;
> +		};
> +
> +		pil_video_mem: pil-video@9fc00000 {
> +			reg = <0x0 0x9fc00000 0x0 0x700000>;
> +			no-map;
> +		};
> +
> +		hyptz_reserved_mem: hyptz-reserved@beb00000 {
> +			reg = <0x0 0xbeb00000 0x0 0x11500000>;
> +			no-map;
> +		};
> +
> +		tz_stat_mem: tz-stat@d0000000 {
> +			reg = <0x0 0xd0000000 0x0 0x100000>;
> +			no-map;
> +		};
> +
> +		tags_mem: tags@d0100000 {
> +			reg = <0x0 0xd0100000 0x0 0x1200000>;
> +			no-map;
> +		};
> +
> +		qtee_mem: qtee@d1300000 {
> +			reg = <0x0 0xd1300000 0x0 0x500000>;
> +			no-map;
> +		};
> +
> +		trusted_apps_mem: trusted-apps@d1800000 {
> +			reg = <0x0 0xd1800000 0x0 0x3900000>;
> +			no-map;
> +		};
> +	};
> +
> +	soc: soc@0 {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges = <0 0 0 0 0x10 0>;
> +
> +		gcc: clock-controller@100000 {
> +			compatible = "qcom,sa8775p-gcc";
> +			reg = <0x0 0x100000 0x0 0xc7018>;
> +			#clock-cells = <1>;
> +			#reset-cells = <1>;
> +			#power-domain-cells = <1>;
> +			clocks = <&rpmhcc RPMH_CXO_CLK>,
> +				 <&sleep_clk>,
> +				 <0>,
> +				 <0>,
> +				 <0>,
> +				 <0>,
> +				 <0>,
> +				 <0>,
> +				 <0>,
> +				 <0>,
> +				 <0>,
> +				 <0>,
> +				 <0>,
> +				 <0>,
> +				 <0>;
> +			power-domains = <&rpmhpd SA8775P_CX>;
> +		};
> +
> +		ipcc: mailbox@408000 {
> +			compatible = "qcom,sa8775p-ipcc", "qcom,ipcc";
> +			reg = <0x0 0x408000 0x0 0x1000>;
> +			interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-controller;
> +			#interrupt-cells = <3>;
> +			#mbox-cells = <2>;
> +		};
> +
> +		qupv3_id_1: geniqup@ac0000 {
> +			compatible = "qcom,geni-se-qup";
> +			reg = <0x0 0xac0000 0x0 0x6000>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +			clock-names = "m-ahb", "s-ahb";
> +			clocks = <&gcc GCC_QUPV3_WRAP_1_M_AHB_CLK>,
> +				 <&gcc GCC_QUPV3_WRAP_1_S_AHB_CLK>;
> +			iommus = <&apps_smmu 0x443 0x0>;
> +			status = "disabled";
> +
> +			uart10: serial@a8c000 {
> +				compatible = "qcom,geni-uart";
> +				reg = <0x0 0xa8c000 0x0 0x4000>;
> +				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP1_S3_CLK>;
> +				interconnect-names = "qup-core", "qup-config";
> +				interconnects = <&clk_virt MASTER_QUP_CORE_1 0
> +						 &clk_virt SLAVE_QUP_CORE_1 0>,
> +						<&gem_noc MASTER_APPSS_PROC 0
> +						 &config_noc SLAVE_QUP_1 0>;
> +				power-domains = <&rpmhpd SA8775P_CX>;
> +				operating-points-v2 = <&qup_opp_table_100mhz>;
> +				status = "disabled";
> +			};
> +		};
> +
> +		intc: interrupt-controller@17a00000 {
> +			compatible = "arm,gic-v3";
> +			reg = <0x0 0x17a00000 0x0 0x10000>,     /* GICD */
> +			      <0x0 0x17a60000 0x0 0x100000>;    /* GICR * 8 */
> +			interrupt-controller;
> +			#interrupt-cells = <3>;
> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +			#redistributor-regions = <1>;
> +			redistributor-stride = <0x0 0x20000>;
> +		};
> +
> +		watchdog@17c10000 {
> +			compatible = "qcom,apss-wdt-sa8775p", "qcom,kpss-wdt";
> +			reg = <0x0 0x17c10000 0x0 0x1000>;
> +			clocks = <&sleep_clk>;
> +			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
> +		};

Trying this DTS on sa8775p-ride with next-20230209, I get this splat
with the qcom_wdt:

[    2.667479] Internal error: synchronous external abort: 0000000096000010 [#1] PREEMPT SMP
[    2.675911] Modules linked in: qcom_wdt(+) crct10dif_ce socinfo fuse ipv6
[    2.675931] CPU: 5 PID: 155 Comm: systemd-udevd Not tainted 6.2.0-rc7-next-20230209-00011-g897899f9de9e #80
[    2.675936] Hardware name: Qualcomm SA8775P Ride (DT)
[    2.675938] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    2.675942] pc : qcom_wdt_probe+0x20c/0x388 [qcom_wdt]
[    2.675964] lr : qcom_wdt_probe+0x308/0x388 [qcom_wdt]
[    2.675970] sp : ffff80000a4db8e0
[    2.675971] x29: ffff80000a4db8e0 x28: 0000000000000000 x27: ffff80000a4dbd50
[    2.675975] x26: 0000000000000000 x25: ffff80000a4dbcd0 x24: ffff060041723680
[    2.675978] x23: ffff060040c2b400 x22: ffffdc111597c560 x21: ffff060040c2b410
[    2.675981] x20: ffff060040959e80 x19: 0000000000000000 x18: ffffffffffffffff
[    2.675984] x17: 0000000000000000 x16: ffffdc116777c59c x15: ffff80000a4db670
[    2.675987] x14: ffff80008a4db7cd x13: 007473696c5f7974 x12: 0000000000000001
[    2.675990] x11: 0000000000000040 x10: ffffdc1169893790 x9 : 0000000000000000
[    2.675994] x8 : ffff0600414ffd80 x7 : 0000000000000000 x6 : 0000000000000000
[    2.675997] x5 : ffff0600414ffc88 x4 : ffff060040c2b610 x3 : 0000000000007ffc
[    2.676001] x2 : 0000000000000001 x1 : 000000000000000c x0 : ffff800008f5d00c
[    2.676004] Call trace:
[    2.676006]  qcom_wdt_probe+0x20c/0x388 [qcom_wdt]
[    2.676013]  platform_probe+0x68/0xc4
[    2.676026]  really_probe+0x148/0x2ac
[    2.676038]  __driver_probe_device+0x78/0xe0
[    2.676042]  driver_probe_device+0x3c/0x15c
[    2.676045]  __driver_attach+0x94/0x19c
[    2.676048]  bus_for_each_dev+0x74/0xcc
[    2.676052]  driver_attach+0x24/0x30
[    2.676055]  bus_add_driver+0x104/0x204
[    2.676059]  driver_register+0x68/0x12c
[    2.676063]  __platform_driver_register+0x28/0x34
[    2.676065]  qcom_watchdog_driver_init+0x20/0x1000 [qcom_wdt]
[    2.676072]  do_one_initcall+0x80/0x1c4
[    2.676081]  do_init_module+0x58/0x1e8
[    2.676088]  load_module+0x19d4/0x1a18
[    2.676091]  __do_sys_finit_module+0xa8/0xfc
[    2.676095]  __arm64_sys_finit_module+0x20/0x2c
[    2.676098]  invoke_syscall+0x48/0x114
[    2.676107]  el0_svc_common.constprop.0+0xcc/0xec
[    2.676110]  do_el0_svc+0x38/0x98
[    2.676113]  el0_svc+0x2c/0x84
[    2.676121]  el0t_64_sync_handler+0xf4/0x120
[    2.676123]  el0t_64_sync+0x190/0x194
[    2.676129] Code: f94002c1 f9006a81 b9400821 8b010000 (b9400000) 
[    2.676135] ---[ end trace 0000000000000000 ]---

I most likely did not see it before as I either had qcom_wdt configured
out or disabled on the kernel cmdline.

> +
> +		memtimer: timer@17c20000 {
> +			compatible = "arm,armv7-timer-mem";
> +			reg = <0x0 0x17c20000 0x0 0x1000>;
> +			ranges = <0x0 0x0 0x0 0x20000000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			frame@17c21000 {
> +				reg = <0x17c21000 0x1000>,
> +				      <0x17c22000 0x1000>;
> +				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
> +				frame-number = <0>;
> +			};
> +
> +			frame@17c23000 {
> +				reg = <0x17c23000 0x1000>;
> +				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +				frame-number = <1>;
> +				status = "disabled";
> +			};
> +
> +			frame@17c25000 {
> +				reg = <0x17c25000 0x1000>;
> +				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
> +				frame-number = <2>;
> +				status = "disabled";
> +			};
> +
> +			frame@17c27000 {
> +				reg = <0x17c27000 0x1000>;
> +				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> +				frame-number = <3>;
> +				status = "disabled";
> +			};
> +
> +			frame@17c29000 {
> +				reg = <0x17c29000 0x1000>;
> +				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
> +				frame-number = <4>;
> +				status = "disabled";
> +			};
> +
> +			frame@17c2b000 {
> +				reg = <0x17c2b000 0x1000>;
> +				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
> +				frame-number = <5>;
> +				status = "disabled";
> +			};
> +
> +			frame@17c2d000 {
> +				reg = <0x17c2d000 0x1000>;
> +				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
> +				frame-number = <6>;
> +				status = "disabled";
> +			};
> +		};
> +
> +		apps_rsc: rsc@18200000 {
> +			compatible = "qcom,rpmh-rsc";
> +			reg = <0x0 0x18200000 0x0 0x10000>,
> +			      <0x0 0x18210000 0x0 0x10000>,
> +			      <0x0 0x18220000 0x0 0x10000>;
> +			reg-names = "drv-0", "drv-1", "drv-2";
> +			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
> +			      <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
> +			      <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
> +			qcom,tcs-offset = <0xd00>;
> +			qcom,drv-id = <2>;
> +			qcom,tcs-config = <ACTIVE_TCS 2>,
> +					  <SLEEP_TCS 3>,
> +					  <WAKE_TCS 3>,
> +					  <CONTROL_TCS 0>;
> +			label = "apps_rsc";
> +
> +			apps_bcm_voter: bcm-voter {
> +				compatible = "qcom,bcm-voter";
> +			};
> +
> +			rpmhcc: clock-controller {
> +				compatible = "qcom,sa8775p-rpmh-clk";
> +				#clock-cells = <1>;
> +				clock-names = "xo";
> +				clocks = <&xo_board_clk>;
> +			};
> +
> +			rpmhpd: power-controller {
> +				compatible = "qcom,sa8775p-rpmhpd";
> +				#power-domain-cells = <1>;
> +				operating-points-v2 = <&rpmhpd_opp_table>;
> +
> +				rpmhpd_opp_table: opp-table {
> +					compatible = "operating-points-v2";
> +
> +					rpmhpd_opp_ret: opp-0 {
> +						opp-level = <RPMH_REGULATOR_LEVEL_RETENTION>;
> +					};
> +
> +					rpmhpd_opp_min_svs: opp-1 {
> +						opp-level = <RPMH_REGULATOR_LEVEL_MIN_SVS>;
> +					};
> +
> +					rpmhpd_opp_low_svs: opp2 {
> +						opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
> +					};
> +
> +					rpmhpd_opp_svs: opp3 {
> +						opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
> +					};
> +
> +					rpmhpd_opp_svs_l1: opp-4 {
> +						opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
> +					};
> +
> +					rpmhpd_opp_nom: opp-5 {
> +						opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
> +					};
> +
> +					rpmhpd_opp_nom_l1: opp-6 {
> +						opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
> +					};
> +
> +					rpmhpd_opp_nom_l2: opp-7 {
> +						opp-level = <RPMH_REGULATOR_LEVEL_NOM_L2>;
> +					};
> +
> +					rpmhpd_opp_turbo: opp-8 {
> +						opp-level = <RPMH_REGULATOR_LEVEL_TURBO>;
> +					};
> +
> +					rpmhpd_opp_turbo_l1: opp-9 {
> +						opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
> +					};
> +				};
> +			};
> +		};
> +
> +		tcsr_mutex: hwlock@1f40000 {
> +			compatible = "qcom,tcsr-mutex";
> +			reg = <0x0 0x1f40000 0x0 0x20000>;
> +			#hwlock-cells = <1>;
> +		};
> +
> +		tlmm: pinctrl@f000000 {
> +			compatible = "qcom,sa8775p-tlmm";
> +			reg = <0x0 0xf000000 0x0 0x1000000>;
> +			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +			gpio-ranges = <&tlmm 0 0 149>;
> +		};
> +
> +		apps_smmu: iommu@15000000 {
> +			compatible = "qcom,sa8775p-smmu-500", "qcom,smmu-500", "arm,mmu-500";
> +			reg = <0x0 0x15000000 0x0 0x100000>;
> +			#iommu-cells = <2>;
> +			#global-interrupts = <2>;
> +
> +			interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 318 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 319 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 322 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 345 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 395 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 396 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 398 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 399 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 401 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 402 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 403 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 412 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 706 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 689 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 690 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 691 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 692 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 693 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 694 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 695 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 696 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 410 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 411 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 420 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 413 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 707 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 708 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 709 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 710 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 711 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 414 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 712 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 713 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 714 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 715 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 912 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 911 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 910 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 909 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 908 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 907 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 906 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 905 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 904 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 903 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 902 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 901 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 900 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 899 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 898 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 897 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 896 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 895 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 894 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 893 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 892 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 891 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +	};
> +
> +	arch_timer: timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 12 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
> +	};
> +};
> -- 
> 2.37.2
> 

-- 
Eric Chanudet

