Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0B45F1523
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 23:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbiI3Vod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 17:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbiI3Vo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 17:44:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D66218F910
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 14:44:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 17B3AB82A21
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 21:44:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 787F2C433D6;
        Fri, 30 Sep 2022 21:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664574259;
        bh=hQWzHsnuiI5lL1XcvJK+0kYjG9jtiCejLLU2jWqxGBs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ox2Gq2165KexFYlVsmfZqmB30FcTIWc67xNcdJF4AgfxXojEK73QGDemj6ntyYxi2
         dairUb/ZEMLE4+8Ssf7xCnC+Thgx0XueThTys1oOS1o/sLWojun8fi3XhdUmm2YGTk
         T/d9qHCjvm1Q93ZYq1sH6XfAFUz5TAx6V7KpXN6xiztW9T6mFFSeVAlhGz53l+Pmkw
         2WMDeFK9zpsN59ME8ABArazLoWMtC12ng3nEXKp/A2KplOlcxCKDD3a7Z9TavvkS9t
         4mTTx4PvuKdiK7UXRtP7gSOs/ubiha2mNk4QEvjtV+SVmU17C+2eoYCdxm7ypccBfZ
         bbf8DkM2qF0dA==
Date:   Sat, 1 Oct 2022 00:44:17 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Thomas Tai <thomas.tai@oracle.com>
Cc:     tony.luck@intel.com, dave.hansen@linux.intel.com,
        reinette.chatre@intel.co, naoya.horiguchi@nec.com,
        linmiaohe@huawei.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/sgx: Add code to inject hwpoison into SGX memory
Message-ID: <YzdjMeEjflRgfkdD@kernel.org>
References: <20220927183411.910077-1-thomas.tai@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927183411.910077-1-thomas.tai@oracle.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 02:34:11PM -0400, Thomas Tai wrote:
> Inspired by commit c6acb1e7bf46 (x86/sgx: Add hook to error injection
> address validation), add a similar code in hwpoison_inject function to
> check if the address is located in SGX Memory. The error will then be
> handled by the arch_memory_failure function in the SGX driver.
> 
> Signed-off-by: Thomas Tai <thomas.tai@oracle.com>
> ---
>  Documentation/mm/hwpoison.rst | 44 +++++++++++++++++++++++++++++++++++
>  mm/hwpoison-inject.c          |  3 +++
>  2 files changed, 47 insertions(+)
> 
> diff --git a/Documentation/mm/hwpoison.rst b/Documentation/mm/hwpoison.rst
> index b9d5253c1305..8a542aca4744 100644
> --- a/Documentation/mm/hwpoison.rst
> +++ b/Documentation/mm/hwpoison.rst
> @@ -162,6 +162,50 @@ Testing
>  
>    Some portable hwpoison test programs in mce-test, see below.
>  
> +* Special notes for injection into SGX enclaves
> +
> +  1) Determine physical address of enclave page
> +
> +	dmesg | grep "sgx: EPC"
> +
> +	sgx: EPC section 0x8000c00000-0x807f7fffff
> +	sgx: EPC section 0x10000c00000-0x1007fffffff
> +
> +  2) Convert the EPC address to page frame number.
> +
> +	For 4K page size, the page frame number for 0x8000c00000 is
> +	0x8000c00000 / 0x1000 = 0x8000c00.
> +
> +  3) Trace memory_failure
> +
> +	echo nop > /sys/kernel/tracing/current_tracer
> +	echo *memory_failure > /sys/kernel/tracing/set_ftrace_filter
> +	echo function > /sys/kernel/tracing/current_tracer
> +
> +  4) Inject a memory error
> +
> +	modprobe hwpoison-inject
> +	echo "0x8000c00" > /sys/kernel/debug/hwpoison/corrupt-pfn
> +
> +  5) Check the trace output
> +
> +	cat /sys/kernel/tracing/trace
> +
> +	# tracer: function
> +	#
> +	# entries-in-buffer/entries-written: 2/2   #P:128
> +	#
> +	#                            _-----=> irqs-off
> +	#                           / _----=> need-resched
> +	#                          | / _---=> hardirq/softirq
> +	#                          || / _--=> preempt-depth
> +	#                          ||| / _-=> migrate-disable
> +	#                          |||| /     delay
> +	#       TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> +	#          | |         |   |||||     |         |
> +	        bash-12167   [002] .....   113.136808: memory_failure<-simple_attr_write
> +	        bash-12167   [002] .....   113.136810: arch_memory_failure<-memory_failure
> +
>  References
>  ==========
>  
> diff --git a/mm/hwpoison-inject.c b/mm/hwpoison-inject.c
> index 65e242b5a432..8134dc983699 100644
> --- a/mm/hwpoison-inject.c
> +++ b/mm/hwpoison-inject.c
> @@ -21,6 +21,9 @@ static int hwpoison_inject(void *data, u64 val)
>  	if (!capable(CAP_SYS_ADMIN))
>  		return -EPERM;
>  
> +	if (arch_is_platform_page(pfn << PAGE_SHIFT))
> +		goto inject;
> +
>  	if (!pfn_valid(pfn))
>  		return -ENXIO;
>  
> -- 
> 2.31.1
> 

Hey, this is really useful addition. Thanks for doing this.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
