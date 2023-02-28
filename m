Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3F26A5EF7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 19:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjB1Sr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 13:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjB1Sr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 13:47:27 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9DE2B60A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 10:47:24 -0800 (PST)
Received: from [10.10.3.121] (unknown [10.10.3.121])
        by mail.ispras.ru (Postfix) with ESMTPS id 9CEE140770A0;
        Tue, 28 Feb 2023 18:47:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 9CEE140770A0
Date:   Tue, 28 Feb 2023 21:47:22 +0300 (MSK)
From:   Alexander Monakov <amonakov@ispras.ru>
To:     Borislav Petkov <bp@alien8.de>
cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Tavis Ormandy <taviso@gmail.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: x86: AMD Zen2 ymm registers rolling back
In-Reply-To: <Y/Xp73KJe3c/1jrn@zn.tnic>
Message-ID: <4737f149-c5b7-8a51-7cc5-8bda6e98308b@ispras.ru>
References: <Y/W4x7/KFqmDmmR7@thinkstation.cmpxchg8b.net> <Y/XTT59OrLw2as4R@zn.tnic> <Y/Xc+yMzI83WZ4V1@zn.tnic> <0371ec3d-0899-f94a-7f21-21d805df2927@citrix.com> <Y/Xp73KJe3c/1jrn@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 22 Feb 2023, Borislav Petkov wrote:

> On Wed, Feb 22, 2023 at 09:38:09AM +0000, Andrew Cooper wrote:
> > This sounds suspiciously like an errata which was fixed with a ucode
> > update last year.
> 
> Yes, it looks like it.
> 
> Alternatively, you can try booting with "clearcpuid=xsaves" - that
> should take care of your observation too but yeah, you should rather
> update your microcode.

Hi folks,

I can reproduce this bug on AMD Renoir SoC:

vendor_id       : AuthenticAMD
cpu family      : 23
model           : 96
model name      : AMD Ryzen 5 4600G with Radeon Graphics
stepping        : 1
microcode       : 0x8600104

for which there's no microcode update, the microcode_amd_fam17h.bin file
in the linux-firmware.git repo carries only the following patches:

$ ./amd_ucode_info.py microcode_amd_fam17h.bin
Microcode patches in microcode_amd_fam17h.bin:
  Family=0x17 Model=0x08 Stepping=0x02: Patch=0x0800820d Length=3200 bytes
  Family=0x17 Model=0x01 Stepping=0x02: Patch=0x0800126e Length=3200 bytes
  Family=0x17 Model=0x31 Stepping=0x00: Patch=0x08301055 Length=3200 bytes


I've seen microcode version increase after a BIOS update, so it seems like
internally microcode patches exist for Renoir too, but it's up to hardware
vendors to pick them up as part of a BIOS update. Is there any chance of
a conventional release like for the above three CPU models?

Thanks.
Alexander
