Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4BF6DDAF6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 14:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjDKMg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 08:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjDKMgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 08:36:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC49F46B3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 05:36:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 071CFD75;
        Tue, 11 Apr 2023 05:37:06 -0700 (PDT)
Received: from [10.57.20.231] (unknown [10.57.20.231])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F9513F6C4;
        Tue, 11 Apr 2023 05:36:20 -0700 (PDT)
Message-ID: <dea94484-797f-3034-7b86-6d88801c0d91@arm.com>
Date:   Tue, 11 Apr 2023 14:36:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 0/2] arch_topology: Pre-allocate cacheinfo from primary
 CPU
Content-Language: en-US
To:     Radu Rendec <rrendec@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <20230406233926.1670094-1-rrendec@redhat.com>
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20230406233926.1670094-1-rrendec@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Radu,
Some additional points:
1-
For the record, Will made a comment about adding weak functions
(cf. https://lore.kernel.org/all/20230327121734.GB31342@willie-the-truck/)
but I don't see how it could be done otherwise ...

2-
The patch-set needs to be rebased on top of v6.3-rc6,
otherwise there is a merge conflict.

3-
When trying the patch-set on an ACPI platform with no PPTT, it seems that
fetch_cache_info() is not called from init_cpu_topology() because
parse_acpi_topology() returns an error code. This result in a
'sleeping function called from invalid context' message. The following made
it work for me:

--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -838,7 +838,6 @@ void __init init_cpu_topology(void)
                  * don't use partial information.
                  */
                 reset_cpu_topology();
-               return;
         }
  
         for_each_possible_cpu(cpu) {

With 2 and 3 addressed:
Reviewed-by: Pierre Gondois <pierre.gondois@arm.com>

Also maybe wait for Sudeep to have a look before sending a v4,
Regards,
Pierre


On 4/7/23 01:39, Radu Rendec wrote:
> Commit 5944ce092b97 ("arch_topology: Build cacheinfo from primary CPU")
> tries to build the cacheinfo from the primary CPU prior to secondary
> CPUs boot, if the DT/ACPI description contains cache information.
> However, if such information is not present, it still reverts to the old
> behavior, which allocates the cacheinfo memory on each secondary CPU. On
> RT kernels, this triggers a "BUG: sleeping function called from invalid
> context" because the allocation is done before preemption is first
> enabled on the secondary CPU.
> 
> The solution is to add cache information to DT/ACPI, but at least on
> arm64 systems this can be avoided by leveraging automatic detection
> (through the CLIDR_EL1 register), which is already implemented but
> currently doesn't work on RT kernels for the reason described above.
> 
> This patch series attempts to enable automatic detection for RT kernels
> when no DT/ACPI cache information is available, by pre-allocating
> cacheinfo memory on the primary CPU.
> 
> The first patch adds an architecture independent infrastructure that
> allows architecture specific code to take an early guess at the number
> of cache leaves of the secodary CPUs, while it runs in preemptible
> context on the primary CPU. At the same time, it gives architecture
> specific code the opportunity to go back later, while it runs on the
> secondary CPU, and reallocate the cacheinfo memory if the initial guess
> proves to be wrong.
> 
> The second patch leverages the infrastructure implemented in the first
> patch and enables early cache depth detection for arm64.
> 
> The patch series is based on an RFC patch that was posted to the
> linux-arm-kernel mailing list and discussed with a smaller audience:
> https://lore.kernel.org/all/20230323224242.31142-1-rrendec@redhat.com/
> 
> Changes to v2:
> * Address minor coding style issue (unbalanced braces).
> * Move cacheinfo reallocation logic from detect_cache_attributes() to a
>    new function to improve code readability.
> * Minor fix to cacheinfo reallocation logic to avoid a new detection of
>    the cache level if/when detect_cache_attributes() is called again.
> 
> Radu Rendec (2):
>    cacheinfo: Add arch specific early level initializer
>    cacheinfo: Add arm64 early level initializer implementation
> 
>   arch/arm64/kernel/cacheinfo.c | 32 +++++++++++----
>   drivers/base/cacheinfo.c      | 75 +++++++++++++++++++++++++----------
>   include/linux/cacheinfo.h     |  2 +
>   3 files changed, 79 insertions(+), 30 deletions(-)
> 
