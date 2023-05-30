Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971A1715C62
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 12:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbjE3K7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 06:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbjE3K6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 06:58:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6FD1E118
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 03:58:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A5D3AB6;
        Tue, 30 May 2023 03:59:32 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 80DFA3F67D;
        Tue, 30 May 2023 03:58:45 -0700 (PDT)
Date:   Tue, 30 May 2023 11:58:43 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "lihuisong (C)" <lihuisong@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>,
        catalin.marinas@arm.com, will@kernel.org,
        rafael.j.wysocki@intel.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        wangkefeng.wang@huawei.com, liuyonglong@huawei.com
Subject: Re: [PATCH] arm64: acpi: Export symbol for acpi_os_ioremap
Message-ID: <20230530105843.ewgmwb3wyewqoqxo@bogus>
References: <20230526121751.41060-1-lihuisong@huawei.com>
 <CAMj1kXHgPbzgPm1Sq5hqqz7RX6sj2axze5F+fvMyfPY=d9=Hhw@mail.gmail.com>
 <d180192a-afad-00dc-426f-3d8d249cdd89@huawei.com>
 <CAMj1kXHk-HTmJzovMFiYStZeZiehS2n01rhGeyOYF_wCn0sHbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMj1kXHk-HTmJzovMFiYStZeZiehS2n01rhGeyOYF_wCn0sHbg@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 03:31:12PM +0200, Ard Biesheuvel wrote:
> On Fri, 26 May 2023 at 15:12, lihuisong (C) <lihuisong@huawei.com> wrote:
> >
> >
> > 在 2023/5/26 20:39, Ard Biesheuvel 写道:
> > > (cc Lorenzo)
> > >
> > > On Fri, 26 May 2023 at 14:20, Huisong Li <lihuisong@huawei.com> wrote:
> > >> The driver who calls the acpi_os_ioremap() cannot be compiled if the 'M'
> > >> is selected for the driver. The compiling log is as follows:
> > >> -->
> > >> MODPOST Module.symvers
> > >> ERROR: modpost: "acpi_os_ioremap" [drivers/soc/hisilicon/xxx.ko] undefined!
> > >> scripts/Makefile.modpost:136: recipe for target 'Module.symvers' failed
> > >> make[1]: *** [Module.symvers] Error 1
> > >>
> > >> So this patch exports symbol for acpi_os_ioremap.
> > >>
> > > That driver does not exist in mainline.
> >
> > We have an uploading driver [1] that may use it.
> >
> > [1]
> > https://patchwork.kernel.org/project/linux-soc/patch/20230522072211.8894-2-lihuisong@huawei.com/
> >
> > >
> > > Why does it need to use acpi_os_ioremap() instead of the ordinary
> > > memremap/ioremap routines?
> > This driver needs to ioremap the shared memory space of a PCC subspace.
> > And @Sudeep suggested that we use this interface.
> > It is suitable here.
> 
> I disagree. acpi_io_ioremap() is internal arch plumbing for the ACPI
> subsystem. I don't see why we should use it here.
>

Yes. One reason I suggested this was in past firmware authors had mixed
the memory allocated for PCC and using acpi_io_ioremap() made sense. But
I hear you and it make sense to avoid it especially if the driver must
know what type of memory it is and must be dealing with.

> On arm64, acpi_os_ioremap() cross references the EFI memory map to
> figure out whether a physical region is memory or device, but a driver
> should already know that.

Agreed.

-- 
Regards,
Sudeep
