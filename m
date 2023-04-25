Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430BE6EE2BD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 15:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233857AbjDYNUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 09:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233255AbjDYNUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 09:20:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C266E210C;
        Tue, 25 Apr 2023 06:20:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DB5862E59;
        Tue, 25 Apr 2023 13:20:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E0FBC433D2;
        Tue, 25 Apr 2023 13:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682428799;
        bh=20NvAhi5Y8ZaEXQMQdcgv4D6xQGvY0Vs7+HtvFJXmX0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=uF3dpeoDKVbi1GBsS4gnHjenGSjJsXcMqypFqF/RrWbIhYC2RdtDjc3eCgFrb3/Pt
         1RkLXoRihKEaZUckkwFcrVMIKRY9gx5Cgx3Ao4F2GfLvgK7ut1G4HndN5GSfbdDAnk
         JgdbY5MyOKs2wpNyuWWKBcBFhsfVxRZxWBbLQVD2ZwQI+OHir7htTaEVtQG6nRdaOz
         D2zBPkPZDY/nuA/ZeXYX0+lECurAXHxC8nYOqVKaSe9/1+GwgtX2FlMVU564xBvrAy
         xXpbFbM7hyfaYMkqOolUln4IMWBUQowl0FMIN+TL3K+dH2UxakynkwhBvoIwM7syeZ
         PG1et9R4Ckm4w==
Message-ID: <f4fedc4a-bc45-31c7-1e2e-ed5fbcee2fdd@kernel.org>
Date:   Tue, 25 Apr 2023 16:19:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v14 0/8] arm64: j721s2: Add support for additional IPs
To:     Ravi Gunasekaran <r-gunasekaran@ti.com>, nm@ti.com, afd@ti.com,
        vigneshr@ti.com, kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, s-vadapalli@ti.com,
        vaishnav.a@ti.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230331090028.8373-1-r-gunasekaran@ti.com>
Content-Language: en-US
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230331090028.8373-1-r-gunasekaran@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31/03/2023 12:00, Ravi Gunasekaran wrote:
> The following series of patches add support for the following
> on J721S2 common processor board,
> 
> - USB
> - SerDes
> - OSPI
> - PCIe
> 
> Changes from v13:
> * Rebased on linux-next master as there were merge conflicts
> 
> Changes from v12:
> * Disabled only the nodes that need additonal info
> 
> Changes from v11:
> * Cleaned up comments for disabled nodes
> * Removed deprecated properties for flash node
> 
> Changes from v10:
> * Removed the ti,j721e-system-controller bindings document
>   patch introduced in v9
> * Updated mux-controller node with "reg" property to fix dtbs
>   warnings
> * For the nodes which are disabled by default, added comments to
>   provide the reason behind it
> * Dropped Link tags in all patches
> 
> Changes from v9:
> * Disabled nodes in main.dtsi and enable them in the board
>   specific DT file
> 
> Changes from v8:
> * Update the ti,j721e-system-controller bindings document
> * Fix dtbs warnings
> 
> Changes from v7:
> * Fix node names as per bindings document
> 
> Changes from v6:
> * Changes to ti,j721s2-wiz-10g compatible string from ti,am64-wiz-10g but
>   requires this series to be merged first
>   Ref: https://lore.kernel.org/linux-arm-kernel/20221122092203.762308-1-mranostay@ti.com/
> * Removed unused pcie1_ep based on feedback
> * Switch from incorrect "ti,j721e-system-controller", "syscon", "simple-mfd" compatible for
>   SPI node to "simple-bus"
> 
> Changes from v5:
> * Removed Cc from commit messages to reduce clutter
> * Squashed changes for device tree nodes that get modified latter in the patchset
>   series
> 
> Changes from v4:
> * Add my Signed-off-by lines to all patchsets
> 
> Changes from v3:
> * Rebased changes on top of '[PATCH 00/12] TI J7x Disable Incomplete DT Nodes'
> * Removed "dt-bindings: PCI: Add host mode device-id for j721s2 platform" patch and
>   send it own series to avoid a dependency that would hold up other patches in this
>   series.
> 
> Changes from v2:
> * Added PCIe RC + EP enablement patchsets
> * Added device-id for j722s2 PCIe host in dt documentation
> * Reworked SERDES + WIZ enablement patchset to use properies for clocks
>   defines versus entire devicetree nodes. Results in cleaner code that
>   doesn't break dt-schema or the driver functionality.
> 
> Changes from v1:
> * Resolve issues with dt schema reporting
> * Minor changes related to consistency on node naming and value
> 
> v13: https://lore.kernel.org/all/20230309082940.31535-1-r-gunasekaran@ti.com/
> v12: https://lore.kernel.org/all/20230301091136.17862-1-r-gunasekaran@ti.com/
> v11: https://lore.kernel.org/all/20230224102438.6541-1-r-gunasekaran@ti.com/
> v10: https://lore.kernel.org/all/20230221120612.27366-1-r-gunasekaran@ti.com/
> v9: https://lore.kernel.org/all/20230220111408.9476-1-r-gunasekaran@ti.com/
> v8: https://lore.kernel.org/all/20230123095733.31657-1-r-gunasekaran@ti.com/
> v7: https://lore.kernel.org/all/20221122101616.770050-1-mranostay@ti.com/
> v6: https://lore.kernel.org/all/20221119040906.9495-1-mranostay@ti.com/
> v5: https://lore.kernel.org/all/20221103044125.172864-1-mranostay@ti.com/
> v4: https://lore.kernel.org/all/20221101033204.33048-1-mranostay@ti.com/
> v3: https://lore.kernel.org/all/20220921031327.4135-1-mranostay@ti.com/
> v2: https://lore.kernel.org/all/20220908011911.3319-1-mranostay@ti.com/
> v1: https://lore.kernel.org/all/20220125131113.727-1-a-govindraju@ti.com/
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
>  .../dts/ti/k3-j721s2-common-proc-board.dts    |  87 +++++++++++
>  arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi    | 145 ++++++++++++++++++
>  .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     |  44 ++++++
>  arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi  |  41 +++++
>  4 files changed, 317 insertions(+)
> 
> 
> base-commit: 4b0f4525dc4fe8af17b3daefe585f0c2eb0fe0a5

For this series:

Reviewed-by: Roger Quadros <rogerq@kernel.org>
