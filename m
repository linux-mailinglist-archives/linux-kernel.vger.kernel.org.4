Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A08740447
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 22:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbjF0UGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 16:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjF0UGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 16:06:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96B12120;
        Tue, 27 Jun 2023 13:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=X69Ch/oAeacF2RzcUXPsx9JeM7nGU2SUlR9C8WX3gbU=; b=I+hzAQgRZkLwXYo0RNQgWI9q33
        ANHp+brDZuhwfMDmlzS8mGQukA6sUrM7kebofUds9HAL/CK1sOMzRmB5nukEIFVbnlM3Yh3bsVw9P
        wLHB0ZB7oXN/Mz0tFIrX4ItrHIKaUbMUdOKbosEv4y6yBTdsiCmutRmH0wEhO93kCqBm/QSlvQqg2
        VJu28RXTmakA3FyFp8g1mc/C1D9OFxSbS9z4LVGDjVREdVlHlSKMgVmq5EIta7eD5tlLVsiBf0LVi
        XX+7Wh14NZ/K94UQMIJmgHZgG3lTYETiL3gsrfrkcbFkQQMWGpyNxJLSa/HLA2VPeVQaoI//lasWx
        WnGrCAEA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qEEx7-00E1l9-0X;
        Tue, 27 Jun 2023 20:06:17 +0000
Message-ID: <a2280b4a-57cb-41ce-5208-c46492a1bf26@infradead.org>
Date:   Tue, 27 Jun 2023 13:06:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v1] intel_idle: Add __init annotation to
 matchup_vm_state_with_baremetal()
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>
References: <12236592.O9o76ZdvQC@kreacher>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <12236592.O9o76ZdvQC@kreacher>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/27/23 10:50, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The caller of (recently added) matchup_vm_state_with_baremetal() is an
> __init function and it uses some __initdata data structures, so add the
> __init annotation to it for consistency.
> 
> This addresses the following build warnings:
> 
> WARNING: modpost: vmlinux: section mismatch in reference: matchup_vm_state_with_baremetal+0x51 (section: .text) -> intel_idle_max_cstate_reached (section: .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: matchup_vm_state_with_baremetal+0x62 (section: .text) -> cpuidle_state_table (section: .init.data)
> WARNING: modpost: vmlinux: section mismatch in reference: matchup_vm_state_with_baremetal+0x79 (section: .text) -> icpu (section: .init.data)
> 
> Fixes: 0fac214bb75e ("intel_idle: Add a "Long HLT" C1 state for the VM guest mode")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/idle/intel_idle.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-pm/drivers/idle/intel_idle.c
> ===================================================================
> --- linux-pm.orig/drivers/idle/intel_idle.c
> +++ linux-pm/drivers/idle/intel_idle.c
> @@ -2147,7 +2147,7 @@ static void __init intel_idle_cpuidle_de
>   * All our short idle states are dominated by vmexit/vmenter latencies,
>   * not the underlying hardware latencies so we keep our values for these.
>   */
> -static void matchup_vm_state_with_baremetal(void)
> +static void __init matchup_vm_state_with_baremetal(void)
>  {
>  	int cstate;
>  
> 
> 
> 

-- 
~Randy
