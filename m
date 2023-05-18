Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E93E707D40
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 11:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjERJub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 05:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjERJu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 05:50:26 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4E81720;
        Thu, 18 May 2023 02:50:24 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QMQ8Y1FwKz6J77c;
        Thu, 18 May 2023 17:46:05 +0800 (CST)
Received: from localhost (10.126.175.163) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 18 May
 2023 10:50:21 +0100
Date:   Thu, 18 May 2023 10:50:20 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] tools/testing/cxl: Document test configurations
Message-ID: <20230518105020.0000424a@Huawei.com>
In-Reply-To: <20230426-cxl-fixes-v1-3-870c4c8b463a@intel.com>
References: <20230426-cxl-fixes-v1-0-870c4c8b463a@intel.com>
        <20230426-cxl-fixes-v1-3-870c4c8b463a@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.175.163]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2023 14:28:12 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

> The devices created, their relationship, and intended testing purpose is
> not extremely clear, especially for those unfamiliar with cxl-test.
> 
> Document the purpose of each hierarchy.  Add ASCII art to show the
> relationship of devices.  Group the device declarations together based
> on the hierarchies.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Trivial nitpicks below :)

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  tools/testing/cxl/test/cxl.c | 75 ++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 73 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index bf00dc52fe96..bd38a5fb60ae 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -23,6 +23,31 @@ static int interleave_arithmetic;
>  #define NR_CXL_PORT_DECODERS 8
>  #define NR_BRIDGES (NR_CXL_HOST_BRIDGES + NR_CXL_SINGLE_HOST + NR_CXL_RCH)
>  
> +/*
> + * Interleave testing

Doesn't include the cfmws, which will be tricky to draw, but maybe you could
add something to indicate they interleave over the two HB sometimes?

> + *
> + *             +---------------+                            +---------------+
> + *             | host_bridge[0]|                            | host_bridge[1]|
> + *             +-/---------\---+                            +--/---------\--+
Text for host bridges is right aligned.
> + *             /-           -\                               /-           -\
> + *           /-               -\                           /-               -\
> + *   +-------------+         +-------------+       +-------------+      +-------------+
> + *   |root_port[0] |         |root_port[1] |       |root_port[2] |      |root_port[3] |
> + *   +------|------+         +------|------+       +------|------+      +------|------+
and root ports are left aligned.
I'd shrink both boxes so they are same as the switches below - or expand them to give
a space on either side of the text.


> + *          |                       |                     |                    |
> + *  +-------|-------+       +-------|-------+     +-------|-------+    +-------|-------+
> + *  |switch_uport[0]|       |switch_uport[1]|     |switch_uport[2]|    |switch_uport[3]|
> + *  +---|-------|---+       +---/-------|---+     +---/-------|---+    +---|-------\---+
> + *      |       \              /        \            /        \            /        \
> + * +----|----++--|------++---------++----|----++---------++----|----++----|----++---------+
> + * |switch   ||switch   ||switch   ||switch   ||switch   ||switch   ||switch   ||switch   |
> + * |_dport[0]||_dport[1]||_dport[2]||_dport[3]||_dport[4]||_dport[5]||_dport[6]||_dport[7]|
> + * +----|----++--|------++----|----++----|----++----|----++----|----++----|----++----|----+
> + *      |        |            |          |          |          |          |          |
> + *  +---|--+   +-|----+   +---|--+   +---|--+    +--|---+  +---|--+   +---|--+   +---|--+
> + *  |mem[0]|   |mem[1]|   |mem[2]|   |mem[3]|    |mem[4]|  |mem[5]|   |mem[6]|   |mem[7]|
> + *  +------+   +------+   +------+   +------+    +------+  +------+   +------+   +------+
> + */
>  static struct platform_device *cxl_acpi;
>  static struct platform_device *cxl_host_bridge[NR_CXL_HOST_BRIDGES];
>  #define NR_MULTI_ROOT (NR_CXL_HOST_BRIDGES * NR_CXL_ROOT_PORTS)
> @@ -31,16 +56,51 @@ static struct platform_device *cxl_switch_uport[NR_MULTI_ROOT];
>  #define NR_MEM_MULTI \
>  	(NR_CXL_HOST_BRIDGES * NR_CXL_ROOT_PORTS * NR_CXL_SWITCH_PORTS)
>  static struct platform_device *cxl_switch_dport[NR_MEM_MULTI];
> +struct platform_device *cxl_mem[NR_MEM_MULTI];
>  
> +/*
> + * 1) Preconfigured region support (Simulated BIOS configured region)
> + * 2) 'Pass-through' decoder
> + *
> + *       +---------------+
> + *       |  hb_single    |
> + *       +------|--------+
> + *              |
> + *       +------|--------+
> + *       | root_single   |
> + *       +------|--------+
> + *              |
> + *   +----------|----------+
> + *   |     swu_single      |
> + *   +-----|-----------|---+
> + *         |           |
> + *   +-----|-----+  +--|--------+
> + *   |swd_single |  | swd_single|
> + *   +-----|-----+  +----|------+
> + *         |             |
> + *  +------|-----+  +----|-------+
> + *  |mem_single  |  |mem_single  |
> + *  +------------+  +------------+
mem[0] etc?  Also swd_single[0] etc?

For consistency with above.

> + */
>  static struct platform_device *cxl_hb_single[NR_CXL_SINGLE_HOST];
>  static struct platform_device *cxl_root_single[NR_CXL_SINGLE_HOST];
>  static struct platform_device *cxl_swu_single[NR_CXL_SINGLE_HOST];
>  #define NR_MEM_SINGLE (NR_CXL_SINGLE_HOST * NR_CXL_SWITCH_PORTS)
>  static struct platform_device *cxl_swd_single[NR_MEM_SINGLE];
> -
> -struct platform_device *cxl_mem[NR_MEM_MULTI];
>  struct platform_device *cxl_mem_single[NR_MEM_SINGLE];
>  
> +/*
> + * 1) RCD
> + * 2) Type-2 (Accelerator)
> + *
> + *  +-----+
> + *  | rch |
> + *  +--|--+
> + *     |
> + *   +-|--+
> + *   |rcd |
> + *   +----+
> + */
>  static struct platform_device *cxl_rch[NR_CXL_RCH];
>  static struct platform_device *cxl_rcd[NR_CXL_RCH];
>  
> @@ -64,6 +124,17 @@ static inline bool is_single_bridge(struct device *dev)
>  	return false;
>  }
>  
> +/*
> + *  +---------------+ +---------------+
> + *  | host_bridge[0]| | host_bridge[1]|
> + *  +---------------+ +---------------+
> + *  +---------------+
> + *  |  hb_single    | (host_bridge[2])
> + *  +---------------+
> + *  +-----+
> + *  | rch | (host_bridge[3])
> + *  +-----+
> + */

Not sure what this diagram is illustrating...

>  static struct acpi_device acpi0017_mock;
>  static struct acpi_device host_bridge[NR_BRIDGES] = {
>  	[0] = {
> 

