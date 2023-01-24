Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B178679CAC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 15:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235155AbjAXOzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 09:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235150AbjAXOzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 09:55:53 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1323E46D6C;
        Tue, 24 Jan 2023 06:55:46 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8BC7F4B3;
        Tue, 24 Jan 2023 06:56:27 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 983F83F5A1;
        Tue, 24 Jan 2023 06:55:43 -0800 (PST)
Date:   Tue, 24 Jan 2023 14:55:41 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Pierre Gondois <pierre.gondois@arm.com>,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gavin Shan <gshan@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v4 6/6] arch_topology: Build cacheinfo from primary CPU
Message-ID: <20230124145541.2xwtr7ro2bjnsjd7@bogus>
References: <20230104183033.755668-1-pierre.gondois@arm.com>
 <20230104183033.755668-7-pierre.gondois@arm.com>
 <CAMuHMdUjgxgOXf5He1x=PLn7MQTjZgFQUHj8JrwbyweT4uOALQ@mail.gmail.com>
 <20230124140420.4srnufcvamvff77v@bogus>
 <Y8/tl999NQwbPL/R@wendy>
 <20230124144839.2szjjv256j3pdaif@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124144839.2szjjv256j3pdaif@bogus>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 02:48:39PM +0000, Sudeep Holla wrote:
> 
> Ah, that thread, I remember that :).
> 
> I still need to understand how this is related to memory allocation.
> Pierre was suggesting(in private) if we need to keep fetch_cache_info()
> arch specific but I really don't want to go down that patch until I
> understand and there is no other option.
> 
> Thanks for your time. I will try to recall boot flow and see if I can
> gather the reasoning for the seen behaviour.
> 

OK, I must have atleast taken a look at the code before I replied.
smp_prepare_boot_cpu() is called quite early before page_alloc_init()
and mm_init()(in init_main.c) while smp_prepare_cpus() get called
quite late from kernel_init->kernel_init_freeable().

Geert, can you please try with the patch Conor pointed out and see if
that helps to fix the allocation failures[1]

-- 
Regards,
Sudeep

[1] https://lore.kernel.org/all/20230103035316.3841303-1-leyfoon.tan@starfivetech.com/
