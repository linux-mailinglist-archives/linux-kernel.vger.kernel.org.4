Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB1D16DD925
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 13:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjDKLO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 07:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjDKLOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 07:14:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936BF1724;
        Tue, 11 Apr 2023 04:14:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 874F761F95;
        Tue, 11 Apr 2023 11:14:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA66BC433D2;
        Tue, 11 Apr 2023 11:13:58 +0000 (UTC)
Date:   Tue, 11 Apr 2023 12:13:55 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: drivers/acpi/acpica/tbfind.c:60:9: error: 'strncpy' specified
 bound 6 equals destination size
Message-ID: <ZDVA8ykiKaXSzJdM@arm.com>
References: <202304071552.CeeIBr5P-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202304071552.CeeIBr5P-lkp@intel.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2023 at 03:02:15PM +0800, kernel test robot wrote:
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   f2afccfefe7be1f7346564fe619277110d341f9b
> commit: 8f9e0a52810dd83406c768972d022c37e7a18f1f ACPI: Don't build ACPICA with '-Os'
> date:   2 months ago
> config: x86_64-sof-customedconfig-fuzz-defconfig (https://download.01.org/0day-ci/archive/20230407/202304071552.CeeIBr5P-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
> reproduce (this is a W=1 build):
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8f9e0a52810dd83406c768972d022c37e7a18f1f
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 8f9e0a52810dd83406c768972d022c37e7a18f1f
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=1 O=build_dir ARCH=x86_64 olddefconfig
>         make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202304071552.CeeIBr5P-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/acpi/acpica/tbfind.c: In function 'acpi_tb_find_table':
> >> drivers/acpi/acpica/tbfind.c:60:9: error: 'strncpy' specified bound 6 equals destination size [-Werror=stringop-truncation]
>       60 |         strncpy(header.oem_id, oem_id, ACPI_OEM_ID_SIZE);
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/acpi/acpica/tbfind.c:61:9: error: 'strncpy' specified bound 8 equals destination size [-Werror=stringop-truncation]
>       61 |         strncpy(header.oem_table_id, oem_table_id, ACPI_OEM_TABLE_ID_SIZE);
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    cc1: all warnings being treated as errors

I think the kernel test robot should filter out any reports related to
this commit. The warning has nothing to do with the -O2 vs -Os change.
It's simply that the compiler now warns if strncpy() has the destination
size equal to the bound parameter (for some reason it doesn't do this
with -Os). I mentioned it on a different report here:

https://lore.kernel.org/all/Y%2FdM77YdzDKRDdj1@arm.com/

A potential solution to silence the compiler is to go through the ACPI
code and change those strncpy() instances to memcpy(). I don't think
those strings are even null-terminated in the APCI spec, so using
strncpy() doesn't make sense.

-- 
Catalin
