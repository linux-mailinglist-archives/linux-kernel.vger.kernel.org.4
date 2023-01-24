Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE42679B15
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 15:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbjAXOFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 09:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234653AbjAXOFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 09:05:12 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB3844742D;
        Tue, 24 Jan 2023 06:04:44 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B86024B3;
        Tue, 24 Jan 2023 06:05:06 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C3F2E3F71E;
        Tue, 24 Jan 2023 06:04:22 -0800 (PST)
Date:   Tue, 24 Jan 2023 14:04:20 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Pierre Gondois <pierre.gondois@arm.com>,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Gavin Shan <gshan@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v4 6/6] arch_topology: Build cacheinfo from primary CPU
Message-ID: <20230124140420.4srnufcvamvff77v@bogus>
References: <20230104183033.755668-1-pierre.gondois@arm.com>
 <20230104183033.755668-7-pierre.gondois@arm.com>
 <CAMuHMdUjgxgOXf5He1x=PLn7MQTjZgFQUHj8JrwbyweT4uOALQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUjgxgOXf5He1x=PLn7MQTjZgFQUHj8JrwbyweT4uOALQ@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 02:50:16PM +0100, Geert Uytterhoeven wrote:
> Hi Pierre,
> 

[...]

> > @@ -840,6 +840,14 @@ void __init init_cpu_topology(void)
> >                 reset_cpu_topology();
> >                 return;
> >         }
> > +
> > +       for_each_possible_cpu(cpu) {
> > +               ret = fetch_cache_info(cpu);
> > +               if (ret) {
> > +                       pr_err("Early cacheinfo failed, ret = %d\n", ret);
> 
> This triggers on all my RV64 platforms (K210, Icicle, Starlight,
> RZ/Five).
> 
> This seems to be a respin of
> https://lore.kernel.org/all/CAMuHMdUBZ791fxCPkKQ6HCwLE4GJB2S35QC=SQ+X8w5Q4C_70g@mail.gmail.com
> which had the same issue.
>

I need to recollect my memories reading all the thread, but even after the
fixes there were few platforms that failed with so early allocation but were
fine with initcalls. Are these such platforms or am I mixing up things here ?
Do you still see all the cacheinfo in the sysfs with initcalls that happen
later in the boot ?

Conor might help me remember the details.

--
Regards,
Sudeep
