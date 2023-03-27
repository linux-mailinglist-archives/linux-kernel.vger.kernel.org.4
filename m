Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E02F6C9F74
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 11:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbjC0Jbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 05:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbjC0Jbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 05:31:49 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6503849E1;
        Mon, 27 Mar 2023 02:31:45 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1pgiQ7-0008H4-00; Mon, 27 Mar 2023 10:41:39 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id D8533C1B91; Mon, 27 Mar 2023 10:41:08 +0200 (CEST)
Date:   Mon, 27 Mar 2023 10:41:08 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mips tree
Message-ID: <20230327084108.GA6182@alpha.franken.de>
References: <20230327161217.7cc4b439@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230327161217.7cc4b439@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-0.7 required=5.0 tests=RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 04:12:17PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the mips tree, today's linux-next build (mips
> cavium_octeon_defconfig) failed like this:
> 
> arch/mips/cavium-octeon/octeon-irq.c:2893:35: error: assignment to ‘u64’ {aka ‘long long unsigned int’} from ‘void *’ makes integer from pointer without a cast [-Werror=int-conversion]
> 
> (reported here: https://linux.kernelci.org/build/id/6420fc4409ffd05fb69c951a/logs/)
> 
> Caused by commit
> 
>   ed6a0b6e9fd7 ("MIPS: octeon: Use of_address_to_resource()")

I've added below patch to fix the problem.

Thomas.

commit 101f26c72825c5dba1dfe826e4202a9a04b435c6
Author: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Date:   Mon Mar 27 10:35:22 2023 +0200

    MIPS: octeon: Fix compile error
    
    Commit ed6a0b6e9fd7 ("MIPS: octeon: Use of_address_to_resource()") lost
    a cast, which causes a compile error.
    
    Fixes: ed6a0b6e9fd7 ("MIPS: octeon: Use of_address_to_resource()")
    Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
index 064e2409377a..8425a6b38aa2 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -2890,7 +2890,7 @@ static int __init octeon_irq_init_ciu3(struct device_node *ciu_node,
 	if (WARN_ON(ret))
 		return ret;
 
-	ciu3_info->ciu3_addr = base_addr = phys_to_virt(res.start);
+	ciu3_info->ciu3_addr = base_addr = (u64)phys_to_virt(res.start);
 	ciu3_info->node = node;
 
 	consts.u64 = cvmx_read_csr(base_addr + CIU3_CONST);


-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
