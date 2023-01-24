Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39483679AF2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 15:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbjAXOBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 09:01:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234488AbjAXOBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 09:01:35 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C4DE470B5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 06:01:14 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 142C04B3;
        Tue, 24 Jan 2023 05:51:31 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A732A3F71E;
        Tue, 24 Jan 2023 05:50:47 -0800 (PST)
Date:   Tue, 24 Jan 2023 13:50:45 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Pierre Gondois <pierre.gondois@arm.com>,
        linux-kernel@vger.kernel.org, Dan Carpenter <error27@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        kernel test robot <lkp@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Gavin Shan <gshan@redhat.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH -next] cacheinfo: Correctly handle new
 acpi_get_cache_info() prototype
Message-ID: <20230124135045.ntl2nhf2oehdc7mu@bogus>
References: <20230124123450.321852-1-pierre.gondois@arm.com>
 <Y8/dmlR7p5rIbRLF@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8/dmlR7p5rIbRLF@wendy>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 01:31:06PM +0000, Conor Dooley wrote:
> Hey!
> 
> On Tue, Jan 24, 2023 at 01:34:46PM +0100, Pierre Gondois wrote:
> > commit bd500361a937 ("ACPI: PPTT: Update acpi_find_last_cache_level()
> > to acpi_get_cache_info()")
> > updates the function acpi_get_cache_info().
> > 
> > If CONFIG_ACPI_PPTT is not defined, acpi_get_cache_info() doesn't
> > update its *levels and *split_levels parameters and returns 0.
> > This can lead to a faulty behaviour.
> > 
> > Make acpi_get_cache_info() return an error code if CONFIG_ACPI_PPTT
> > is not defined. Initialize levels and split_levels before passing
> > their address to acpi_get_cache_info().
> > 
> > Also, in init_cache_level():
> 
> Hmm...
> 
> > - commit e75d18cecbb3 ("arm64: cacheinfo: Fix incorrect
> >   assignment of signed error value to unsigned fw_level")
> >   checks the fw_level value in init_cache_level() in case
> >   the value is negative. Remove this check as the error code
> >   is not returned through fw_level anymore.
> > - if no PPTT is present or CONFIG_ACPI_PPTT is not defined,
> >   it is still possible to use the cache information from clidr_el1.
> >   Instead of aborting if acpi_get_cache_info() returns an error
> >   code, just continue.
> 
> To be honest, these feel like entirely separate things that should be
> in different patches. You've got:
> - Dan's smatch fixes
> - a redundant check being removed
> - a behaviour change for if acpi_get_cache_info() returns an error
>

I am not too fussy about it, but for sure it would be cleaner for sure.

> > Reported-by: Dan Carpenter <error27@gmail.com>
> > Reported-by: kernel test robot <lkp@intel.com>
>
> How about Link: to the LKP/Dan's report?
> Link: https://lore.kernel.org/all/Y86iruJPuwNN7rZw@kili/
>
> I did a quick check but didn't don't see the LKP report...
>

Yes, LKP dropped all the cc when reported, even I saw after merging the
changes. I think this is the one:

https://lore.kernel.org/all/202301052307.JYt1GWaJ-lkp@intel.com/

> Also a Fixes: tag too, no?
>

+1, if you split make sure you tag fixes to the right one(mainly one
that changes return from acpi_get_cache_info())

> Thanks,
> Conor.



-- 
Regards,
Sudeep
