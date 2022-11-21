Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBFA76329F9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 17:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiKUQt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 11:49:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiKUQt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 11:49:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7EAD12082;
        Mon, 21 Nov 2022 08:49:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4530B61323;
        Mon, 21 Nov 2022 16:49:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A81C433D6;
        Mon, 21 Nov 2022 16:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669049364;
        bh=Y7EzEkCjg0VzU3xozsN87SNyuMOmrWVV0rDA/ESrahE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HBzvdV+8gnrPANpEspbbzNJIobMfMM+8AEeSmO09X9V23qPurR5hRva6+96nfD16O
         f3yyDzpRaXi4700WJC6vcgTM8ZS79szzTCBb5ASvB2/7cwhtbh3Vxz8TuZqanQdAC7
         N0j2GEC6xU4MpL44DH90KWOVVJ8ES9dxHCKtWhrcoznTJPcLafDvHCTxYFbfu+Fa0W
         uuNY9rtBM6G3ldD6gQfUn+MuhZWVHEdtp0LBORy8iTb+u/S61oEO5//O539xQ/vSCw
         YPtkmmGgWnpKbz8ekCWwEqEJOt0tbOShkV5SrKwylN6+5mSlv5n99//vrHTlZKWWO6
         C3y5LgvzajJ7A==
Message-ID: <db9eb075-de17-8b33-fb97-d14297b9006b@kernel.org>
Date:   Mon, 21 Nov 2022 18:49:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v6 0/8] J721S2: Add support for additional IPs
Content-Language: en-US
To:     Matt Ranostay <mranostay@ti.com>, nm@ti.com, vigneshr@ti.com,
        kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, s-vadapalli@ti.com,
        r-gunasekaran@ti.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221119040906.9495-1-mranostay@ti.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20221119040906.9495-1-mranostay@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/11/2022 06:08, Matt Ranostay wrote:
> The following series of patches add support for the following
> on J721S2 common processor board,
> 
> - USB
> - SerDes
> - OSPI
> - PCIe
> 
> Changes from v1:
> * Resolve issues with dt schema reporting
> * Minor changes related to consistency on node naming and value
> 
> Changes from v2:
> * Added PCIe RC + EP enablement patchsets
> * Added device-id for j722s2 PCIe host in dt documentation
> * Reworked SERDES + WIZ enablement patchset to use properies for clocks
>   defines versus entire devicetree nodes. Results in cleaner code that
>   doesn't break dt-schema or the driver functionality.
> 
> Changes from v3:
> * Rebased changes on top of '[PATCH 00/12] TI J7x Disable Incomplete DT Nodes'
> * Removed "dt-bindings: PCI: Add host mode device-id for j721s2 platform" patch and
>   send it own series to avoid a dependency that would hold up other patches in this
>   series
> 
> Changes from v4:
> * Add my Signed-off-by lines to all patchsets
> 
> Changes from v5:
> * Removed Cc from commit messages to reduce clutter
> * Squashed changes for device tree nodes that get modified latter in the patchset
>   series
> 
> Aswath Govindraju (7):
>   arm64: dts: ti: k3-j721s2-main: Add support for USB
>   arm64: dts: ti: k3-j721s2-mcu-wakeup: Add support of OSPI
>   arm64: dts: ti: k3-j721s2-common-proc-board: Enable SERDES0
>   arm64: dts: ti: k3-j721s2-common-proc-board: Add USB support
>   arm64: dts: ti: k3-j721s2: Add support for OSPI Flashes
>   arm64: dts: ti: k3-j721s2-main: Add PCIe device tree node
>   arm64: dts: ti: k3-j721s2-common-proc-board: Enable PCIe
> 
> Matt Ranostay (1):
>   arm64: dts: ti: k3-j721s2-main: Add SERDES and WIZ device tree node
> 
>  .../dts/ti/k3-j721s2-common-proc-board.dts    |  92 ++++++++++
>  arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi    | 157 ++++++++++++++++++
>  .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     |  40 +++++
>  arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi  |  42 +++++
>  4 files changed, 331 insertions(+)
> 

Reviewed-by: Roger Quadros <rogerq@kernel.org>

--
cheers,
-roger
