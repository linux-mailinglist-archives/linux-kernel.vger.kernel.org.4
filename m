Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE8A62C7C8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 19:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiKPSiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 13:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234541AbiKPSiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 13:38:18 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADA560370
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 10:38:17 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id b185so18263834pfb.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 10:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GUX+eoqhaobDYypHKDLNxQx2E4TU2UsOgUeGPD8Shhc=;
        b=cJggep3WypiFu97uTiQxi27LSCrirnxyXHR1b0Tlq9UyjOTwsrqeyXyPRiyKmMpKaz
         JVyruvxvHL05x4mz2fqb5ehUfzKfEZzYlqcnDt7m2BWt5G4qYSDeNTbreUG8gLmCU2PB
         7h8b1/gWj8FwFgM8b3qo3oeUpQ+txGN7/MW/lnAPtdwyrHjnQU2iG6F8PF8jBvweM9+1
         S2aNIjnsuzPzFKd5Jtqx+ERaqvI5dGpE2MYS+dfw+vHfrJnuSEco7cVn5WccChzFMKg5
         z31bFFxHxVzcsuGo/ug+1PVmQefish/hxuw4hJCr0Gw+fxy6aOobzyrCozx/LME2j/6A
         DdPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GUX+eoqhaobDYypHKDLNxQx2E4TU2UsOgUeGPD8Shhc=;
        b=q0QVJKOs1p5TbfZ1q+AyZMY3PydK3Z/dRqZCBXr7i6wWcwjoqCQ0rJe8jMFeIeAL3b
         MwUMHd1zxtnu/tZv2I522kI+3HkiFF5qQbwJYd76APXP++o9iTvB1tijvCZvlBU5TSJS
         SVt/vUWbMMCbPrZ3AXoYJYPA/JauUXFM3opa14BTwi7/e2nHCe+tg5Sau7CVY3l675Nj
         6O0iAHfJRSvuWquAW5lcnM4KVCxpffU+ywbKZMK8kRw59wmmXhmLjjTTP48vL3VoUsL2
         Mjs4o7s9JNX936cB8ZjFsj8D80mztAribfo4toEdTmTkRf3bZ5ledTD6L+s4KdN+IW5X
         8hTQ==
X-Gm-Message-State: ANoB5pnjBvV1lmB/gl4f3oaGltafW1Q6L/sgzzdZtT7Umjvvop3LMcKA
        0OKskwdWRAFcLN1LRaSAJohrAQ==
X-Google-Smtp-Source: AA0mqf47iRel6QWfF50NzK+cnQ+XtaZ1PjHo+WHMwlTuydaoRwswg2/AfVXLliBE1pkTGYoPzsupIg==
X-Received: by 2002:a63:1348:0:b0:46e:96b9:ed63 with SMTP id 8-20020a631348000000b0046e96b9ed63mr22003555pgt.258.1668623897065;
        Wed, 16 Nov 2022 10:38:17 -0800 (PST)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id f15-20020a62380f000000b0056c360af4e3sm11169963pfa.9.2022.11.16.10.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 10:38:16 -0800 (PST)
Date:   Wed, 16 Nov 2022 11:38:14 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Tanmay Shah <tanmay.shah@amd.com>
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, michal.simek@amd.com,
        bill.mills@linaro.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 0/6] Add Xilinx RPU subsystem support
Message-ID: <20221116183814.GD61935@p14s>
References: <20221114233940.2096237-1-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114233940.2096237-1-tanmay.shah@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tanmay,

I think this patchset is ready to be merged.  Two things are missing though:

Patches 1 and 2: We are missing a tag from one of the fellow in the DT brigade.
They handle a lot of patches so let's give them time.

Patches 4 and 5: Michal's ack.  He already reviewed that code in the previous
iteration but it wasn't added to this set, probably because you did some
modification to get the patches to apply.  In that case it is usually fine to
carry the tag since there isn't any modification to the code you are
introducing.  But you aired on the side of caution and that is also fine.
Please reach out to him again for another review.

Thanks,
Mathieu


On Mon, Nov 14, 2022 at 03:39:34PM -0800, Tanmay Shah wrote:
> This patch series adds bindings document for RPU subsystem found on Xilinx
> ZynqMP platforms. It also adds device nodes and driver to enable RPU
> subsystem in split mode and lockstep mode.
> 
> Xilinx ZynqMP platform contains Remote Processing Unit(RPU). RPU subsystem
> contains two arm cortex r5f cores. RPU subsystem can be configured in
> split mode, lockstep mode and single-cpu mode.
> 
> RPU subsystem also contains 4 Tightly Coupled Memory(TCM) banks.
> In lockstep mode, all 4 banks are combined and total of 256KB memory is
> made available to r5 core0. In split mode, both cores can access two
> TCM banks i.e. 128 KB.
> 
> RPU can also fetch data and execute instructions from DDR memory along with
> TCM memory.
> ---
> 
> Changes in v11:
>   - rename binding filename to match with compatible string
>   - change $id: value accordingly as well
>   - Rebase on latest rproc-next branch and resolve merge conflicts
>   - remove redundant < 0 check for function of_get_available_child_count()
>   - return 'ret' variable rather than masking the real error code when
>     parsing "xlnx,cluster-mode" property fails
>   - remove redundant use of devm_free()
>   - call  of_reserved_mem_device_release() to release reserved memory
>     in case driver probe fails or driver is removed.
> 
> Changes in v10:
>   - bindings: rename example node to remoteproc
>   - dts: Rename node name to remoteproc
>   - switch to AMD email ID 
>   - fix Kconfig unmet dependecy error reported by kernel test robot
>   - fix r5_rproc object mem leak in function zynqmp_r5_add_rproc_core
>   - add explanation of hardcoded TCM nodes
>   - remove redundant ToDo comment
>   - remove redundant check of tcm_bank_count and rmem_count
>   - remove explicit free reserved_mem in zynqmp_r5_get_mem_region_node
>   - fix leaked reference of child_dev during zynqmp_r5_cluster_init
>     Also fix possible crash in exit path release_r5_cores 
>   - do not remove mem-region and tcm carveouts explicitly in case of failure.
>     It will be deleted as part of rproc_del. This also simplifies logic to
>     use rproc_add_carveout
>   - fix documentation all over the driver
> 
> Changes in v9:
>   - bindings: remove power-domains property description
>   - bindings: fix nitpicks in description of properties
>   - dts: remove unused labels
>   - replace devm_rproc_alloc with rproc_alloc
>   - %s/until/while/r
>   - %s/i > -1/i >=0/r
>   - fix type of tcm_mode from int to enum rpu_tcm_comb
>   - release &child_pdev->dev references
>   - remove zynqmp_r5_core_exit()
>   - undefined memory-region property isn't failure
>   - remove tcm bank count check from ops
>   - fix tcm bank turn-off sequence
>   - fix parse_fw function documentation
>   - do not use rproc_mem_entry_init on vdev0buffers
>   - check tcm banks shouldn't be 0
>   - declare variabls in reverse xmas tree order
>   - remove extra line
> 
> Changes in v8:
>   - add 'items:' for sram property
> 
> Changes in v7:
>   - Add minItems in sram property
> 
> Changes in v6:
>   - Add maxItems to sram and memory-region property
> 
> Changes in v5:
>   - Add constraints of the possible values of xlnx,cluster-mode property
>   - fix description of power-domains property for r5 core
>   - Remove reg, address-cells and size-cells properties as it is not required
>   - Fix description of mboxes property
>   - Add description of each memory-region and remove old .txt binding link
>     reference in the description
>   - Remove optional reg property from r5fss node
>   - Move r5fss node out of axi node
> 
> Changes in v4:
>   - Add memory-region, mboxes and mbox-names properties in dt-bindings example
>   - Add reserved memory region node and use it in Xilinx dt RPU subsystem node
>   - Remove redundant header files
>   - use dev_err_probe() to report errors during probe
>   - Fix missing check on error code returned by zynqmp_r5_add_rproc_core()
>   - Fix memory leaks all over the driver when resource allocation fails for any core
>   - make cluster mode check only at one place
>   - remove redundant initialization of variable
>   - remove redundant use of of_node_put() 
>   - Fix Comment format problem
>   - Assign offset of zynqmp_tcm_banks instead of duplicating it
>   - Add tcm and memory regions rproc carveouts during prepare instead of parse_fw
>   - Remove rproc_mem_entry object from r5_core
>   - Use put_device() and rproc_del() APIs to fix memory leaks
>   - Replace pr_* with dev_*. This was missed in v3, fix now.
>   - Use "GPL" instead of "GPL v2" in MODULE_LICENSE macro. This was reported by checkpatch script.
> 
> Changes in v3:
>   - Fix checkpatch script indentation warning
>   - Remove unused variable from xilinx remoteproc driver
>   - use C style comments, i.e /*...*/
>   - Remove redundant debug information which can be derived using /proc/device-tree
>   - Fix multiline comment format
>   - s/"final fot TCM"/"final for TCM"
>   - Function devm_kzalloc() does not return an code on error, just NULL.
>     Remove redundant error check for this function throughout the driver.
>   - Fix RPU mode configuration and add documentation accordingly
>   - Get rid of the indentations to match function documentation style with rest of the driver
>   - Fix memory leak by only using r5_rproc->priv and not replace it with new instance
>   - Use 'i' for the outer loop and 'j' for the inner one as per convention
>   - Remove redundant error and NULL checks throughout the driver
>   - Use devm_kcalloc() when more than one element is required
>   - Add memory-regions carveouts during driver probe instead of parse_fw call
>     This removes redundant copy of reserved_mem object in r5_core structure.
>   - Fix memory leak by using of_node_put()
>   - Fix indentation of tcm_mem_map function args
>   - Remove redundant init of variables
>   - Initialize tcm bank size variable for lockstep mode
>   - Replace u32 with phys_addr_t for variable stroing memory bank address
>   - Add documentation of TCM behavior in lockstep mode
>   - Use dev_get_drvdata instead of platform driver API
>   - Remove info level messages
>   - Fix checkpatch.pl warnings
>   - Add documentation for the Xilinx r5f platform to understand driver design
> 
> Changes in v2:
>   - Remove proprietary copyright footer from cover letter
> 
> Ben Levinsky (3):
>   firmware: xilinx: Add ZynqMP firmware ioctl enums for RPU
>     configuration.
>   firmware: xilinx: Add shutdown/wakeup APIs
>   firmware: xilinx: Add RPU configuration APIs
> 
> Tanmay Shah (3):
>   dt-bindings: remoteproc: Add Xilinx RPU subsystem bindings
>   arm64: dts: xilinx: zynqmp: Add RPU subsystem device node
>   drivers: remoteproc: Add Xilinx r5 remoteproc driver
> 
>  .../remoteproc/xlnx,zynqmp-r5fss.yaml         |  135 +++
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |   33 +
>  drivers/firmware/xilinx/zynqmp.c              |   97 ++
>  drivers/remoteproc/Kconfig                    |   13 +
>  drivers/remoteproc/Makefile                   |    1 +
>  drivers/remoteproc/xlnx_r5_remoteproc.c       | 1067 +++++++++++++++++
>  include/dt-bindings/power/xlnx-zynqmp-power.h |    6 +
>  include/linux/firmware/xlnx-zynqmp.h          |   60 +
>  8 files changed, 1412 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
>  create mode 100644 drivers/remoteproc/xlnx_r5_remoteproc.c
> 
> 
> base-commit: 6eed169c7fefd9cdbbccb5ba7a98470cc0c09c63
> -- 
> 2.25.1
> 
