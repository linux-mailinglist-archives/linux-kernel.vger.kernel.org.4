Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB38264DD3E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 16:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiLOPEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 10:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiLOPEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 10:04:41 -0500
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800592F65B;
        Thu, 15 Dec 2022 07:04:40 -0800 (PST)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 314C660293A85;
        Thu, 15 Dec 2022 16:04:39 +0100 (CET)
Message-ID: <dd73672b-2506-2529-7131-d94a61e06441@molgen.mpg.de>
Date:   Thu, 15 Dec 2022 16:04:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: Pine64 Pinebook Pro (rk3399): debugfs: File
 ':interrupt-controller@fee00000' in directory 'domains' already present!
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <a2420e60-b0da-d3b0-88b4-04fcac950285@molgen.mpg.de>
In-Reply-To: <a2420e60-b0da-d3b0-88b4-04fcac950285@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Attach output of `dmesg`

Am 15.12.22 um 16:03 schrieb Paul Menzel:
> Dear Linux folks,
> 
> 
> Starting Manjaro ARM on a Pine64 Pinebook Pro, Linux 6.0.7 logs:
> 
> ```
> [    0.000000] Linux version 6.0.7-2-MANJARO-ARM (builduser@fh-mjr-build-lon-xlarge) (gcc (GCC) 12.1.0, GNU ld (GNU Binutils) 2.38) #1 SMP PREEMPT Sun Nov 6 23:15:01 UTC 2022
> […]
> [    0.406267] debugfs: File ':interrupt-controller@fee00000' in directory 'domains' already present!
> [    0.406973] debugfs: File ':interrupt-controller@fee00000' in directory 'domains' already present!
> [    0.406992] debugfs: File ':interrupt-controller@fee00000' in directory 'domains' already present!
> [    0.406999] debugfs: File ':interrupt-controller@fee00000' in directory 'domains' already present!
> [    0.407007] debugfs: File ':interrupt-controller@fee00000' in directory 'domains' already present!
> [    0.407014] debugfs: File ':interrupt-controller@fee00000' in directory 'domains' already present!
> [    0.407024] debugfs: File ':interrupt-controller@fee00000' in directory 'domains' already present!
> [    0.407032] debugfs: File ':interrupt-controller@fee00000' in directory 'domains' already present!
> [    0.407039] debugfs: File ':interrupt-controller@fee00000' in directory 'domains' already present!
> [    0.407047] debugfs: File ':interrupt-controller@fee00000' in directory 'domains' already present!
> [    0.407054] debugfs: File ':interrupt-controller@fee00000' in directory 'domains' already present!
> [    0.407061] debugfs: File ':interrupt-controller@fee00000' in directory 'domains' already present!
> [    0.407068] debugfs: File ':interrupt-controller@fee00000' in directory 'domains' already present!
> [    0.407075] debugfs: File ':interrupt-controller@fee00000' in directory 'domains' already present!
> [    0.407082] debugfs: File ':interrupt-controller@fee00000' in directory 'domains' already present!
> ```
> 
> I found a corresponding definition in the devicetree 
> `arch/arm64/boot/dts/rockchip/rk3399.dtsi`:
> 
> ```
>          gic: interrupt-controller@fee00000 {
>                  compatible = "arm,gic-v3";
>                  #interrupt-cells = <4>;
>                  #address-cells = <2>;
>                  #size-cells = <2>;
>                  ranges;
>                  interrupt-controller;
> 
>                  reg = <0x0 0xfee00000 0 0x10000>, /* GICD */
>                        <0x0 0xfef00000 0 0xc0000>, /* GICR */
>                        <0x0 0xfff00000 0 0x10000>, /* GICC */
>                        <0x0 0xfff10000 0 0x10000>, /* GICH */
>                        <0x0 0xfff20000 0 0x10000>; /* GICV */
>                  interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH 0>;
>                  its: interrupt-controller@fee20000 {
>                          compatible = "arm,gic-v3-its";
>                          msi-controller;
>                          #msi-cells = <1>;
>                          reg = <0x0 0xfee20000 0x0 0x20000>;
>                  };
> 
>                  ppi-partitions {
>                          ppi_cluster0: interrupt-partition-0 {
>                                  affinity = <&cpu_l0 &cpu_l1 &cpu_l2 &cpu_l3>;
>                          };
> 
>                          ppi_cluster1: interrupt-partition-1 {
>                                  affinity = <&cpu_b0 &cpu_b1>;
>                          };
>                  };
>          };
> ```
> 
> 
> Kind regards,
> 
> Paul
