Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98A2616E0B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 20:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbiKBTyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 15:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbiKBTxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 15:53:44 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A33EA467
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 12:53:36 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id q9so2266931pfg.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 12:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QJsXsIB9UUIjgG4Y32tIIraS06kk83j43Jwm1/Uz9iI=;
        b=I0xZvH2KjFD7PC95HT4FcckR53yro4wwrzR5YBC85LS+DyRrCEiwyI6Roy/8C/T4m7
         MkBbXcRpTefR/9pa60rg8cHe+DSgMKyOlpXBOAA52ExH7jekmYUXVBwv5jaYowztjfFi
         3dSWoFlfm2pgkDZGL4KBTWVIm2ro01LW1Sv3494pSt12rh4uVJc0nnG3oTiSRqYuY1n3
         0c3SC4La6zyPfGuDlDeUz+3yD7Ffy5Q2kKu9OY9YZuNUGR7kIk4LXljImGLe/6DZrUhK
         zxzGcr3ui37mpBH/qn+tUL9zxk6jhMZcYaX4mLrWVPJ8v0WjQ/y+VFDWKsu5EZzUHvH6
         4gfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJsXsIB9UUIjgG4Y32tIIraS06kk83j43Jwm1/Uz9iI=;
        b=Ef6P6iMXmD27HUCm/6ayD3P2mWMywXmYnNj5ad56sBxaRtoC63RNlaanoK73AFkr5K
         bx/RSmjmXN6xL2coUFi3CqhjiI4sUbQMM7ZYs/SEuK8qRyicDwuqFxmw6FYOv1GeRm+a
         pshXQ3JErolsn4UQicDigZyZn6X7Gm9VHj8n7OQTTFpbDx3cUiK+BRf08KLqfiOE7L0S
         J6m657lxhGQyqRol69Zl6g6iT8DzDkdHG2i0lJRc9PnzZGK7RsIqb+AmDcaZSf4gSwHp
         7dXV/jWucoNUpBya4zu/beXqYR+Z1LYPdikWtHahJIBYykQnsBw3k+Xwfh7+YJ2t+1T1
         fd7w==
X-Gm-Message-State: ACrzQf3ftsuJ+0TORg7snEUpVLoW0AJuS6OJb/AGxeEHxFAu18okx0Jp
        mOKRpay5XRL7MbF6cPP6EMvnrg==
X-Google-Smtp-Source: AMsMyM53ebYvUgdz5+1V7nfv1iwrDX3L++Iyf/+QL9OUxvFnzVAoHc1t85WcrjsAlR54gPfE7+9OnQ==
X-Received: by 2002:a63:fc4b:0:b0:46f:ed8d:7087 with SMTP id r11-20020a63fc4b000000b0046fed8d7087mr8834348pgk.135.1667418815990;
        Wed, 02 Nov 2022 12:53:35 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id d1-20020a17090a114100b0020dc318a43esm1831178pje.25.2022.11.02.12.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 12:53:34 -0700 (PDT)
Date:   Wed, 2 Nov 2022 13:53:30 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Tanmay Shah <tanmay.shah@amd.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@amd.com>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v10 0/6]  Add Xilinx RPU subsystem support
Message-ID: <20221102195330.GB1733006@p14s>
References: <20221011212501.2661003-1-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011212501.2661003-1-tanmay.shah@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am done reviewing this set.  Other than the comments from yesterday things
look good.  There is also the fact that this set doesn't apply to the current
rproc-next.

I hope to see another patchset from you in the coming 2 weeks so that can get
this in for the v6.2 cycle.

Thanks,
Mathieu

On Tue, Oct 11, 2022 at 02:24:55PM -0700, Tanmay Shah wrote:
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
>  .../bindings/remoteproc/xlnx,r5f-rproc.yaml   |  135 +++
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |   32 +
>  drivers/firmware/xilinx/zynqmp.c              |   97 ++
>  drivers/remoteproc/Kconfig                    |   13 +
>  drivers/remoteproc/Makefile                   |    1 +
>  drivers/remoteproc/xlnx_r5_remoteproc.c       | 1070 +++++++++++++++++
>  include/dt-bindings/power/xlnx-zynqmp-power.h |    6 +
>  include/linux/firmware/xlnx-zynqmp.h          |   60 +
>  8 files changed, 1414 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
>  create mode 100644 drivers/remoteproc/xlnx_r5_remoteproc.c
> 
> 
> base-commit: abac55caaeaaabd31763a7c8a79c4cc096b415ae
> -- 
> 2.25.1
> 
