Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3251D6EF1A3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 12:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240380AbjDZKHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 06:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjDZKHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 06:07:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 259FC26A6;
        Wed, 26 Apr 2023 03:07:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C06D74B3;
        Wed, 26 Apr 2023 03:08:14 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.23.120])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8ADE33F5A1;
        Wed, 26 Apr 2023 03:07:28 -0700 (PDT)
Date:   Wed, 26 Apr 2023 11:07:25 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     =?utf-8?B?6L+Q6L6J5bSU?= <cuiyunhui@bytedance.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>, rafael@kernel.org,
        lenb@kernel.org, jdelvare@suse.com, cujomalainey@chromium.org,
        yc.hung@mediatek.com, angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, pierre-louis.bossart@linux.intel.com,
        tinghan.shen@mediatek.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, rminnich@gmail.com
Subject: Re: [External] Re: [PATCH] firmware: added a firmware information
 passing method FFI
Message-ID: <ZEj33QLZqEeL+/y4@FVFF77S0Q05N>
References: <20230426034001.16-1-cuiyunhui@bytedance.com>
 <CAMj1kXEKh9O-ndk3QFibJMYfMbG7vm-cLN2vVQM5eDsYK84NzQ@mail.gmail.com>
 <CAEEQ3wkJB5CKm33mHXUOPX5makYOHF8By6FYGnNzRkM-Mo72OQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEEQ3wkJB5CKm33mHXUOPX5makYOHF8By6FYGnNzRkM-Mo72OQ@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023 at 05:34:55PM +0800, 运辉崔 wrote:
> Hi Ard,
> 
> On Wed, Apr 26, 2023 at 3:09 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > Hello Yunhui,
> >
> > I am not sure this is a good idea: this is clearly intended for arm64,
> > which cannot use ACPI without the EFI memory map, which it uses to
> > cross reference memory opregion accesses, to determine the correct
> > memory type attributes.
> >
> Not only for arm64, but also other arches, such as riscv.
> For memory-related nodes, it will be done in the early scan of the device tree.

Ard's point is that the device tree doesn't have all the same information (e.g.
nothing in DT describes the memory type attributes), and so this isn't
sufficient.

We'd have to create entirely new ways to pass that information, which is not
very desirable.

> > What is the use case you are trying to accommodate here?
> >
> Some bootloaders do not support uefi, such as coreboot,
> but need to support acpi, smbios.

For arm64 at least, if you need ACPI you must have EFI, and trying to change
that will require significant work and long term maintenance.

Can you extend coreboot to provide EFI services, or to chain-load an EFI
payload?

Thanks,
Mark.
