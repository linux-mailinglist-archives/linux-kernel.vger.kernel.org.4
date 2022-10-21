Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE60E60786F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 15:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbiJUNbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 09:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiJUNbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 09:31:08 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BA1256D27
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 06:31:05 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e769329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e769:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BB4581EC072C;
        Fri, 21 Oct 2022 15:31:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1666359063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=YN31rTLLzz33ykVYcDoZ1yvGJK8u0KjthvBMNeW60xE=;
        b=KACJe1s9zqjLr2xNb8tla5s9UW3Q2G+vfn671x4eBEUER9VcJFw670Z0WN6fxRxKMZFzb0
        qxHnoXjNmY+c6OYaBTr19MjuMuSpPJYFQd3zS4FMWCaClDTwueU1Ao161dDYEvExVtL8F9
        TPq5B2EqZCNmv7rBabrrswToI/JHHuA=
Date:   Fri, 21 Oct 2022 15:30:59 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     Tony Luck <tony.luck@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Arjan van de Ven <arjan.van.de.ven@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] x86/microcode: Simplify init path even more
Message-ID: <Y1KfExy49uBNLmtL@zn.tnic>
References: <20221019175426.31025-1-bp@alien8.de>
 <20221019175426.31025-2-bp@alien8.de>
 <Y1BOkbXsQxCZK3U7@a4bf019067fa.jf.intel.com>
 <Y1BSF8ck0RD9UpLd@zn.tnic>
 <Y1EEObR7keIDJtVJ@zn.tnic>
 <Y1FjlfVQupDc7q1r@a4bf019067fa.jf.intel.com>
 <Y1Jl0tojpBzY2y/8@zn.tnic>
 <Y1Jyj/MjhzJjU0rb@a4bf019067fa.jf.intel.com>
 <Y1J7HC9j0o4oQNu+@zn.tnic>
 <Y1KFCwuf4LrSIBFY@a4bf019067fa.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y1KFCwuf4LrSIBFY@a4bf019067fa.jf.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 04:39:55AM -0700, Ashok Raj wrote:
> I tested just with only your patches

Yeah, it can't work:

[    1.365806] microcode: microcode_init: will request
[    1.365812] microcode: request_microcode_fw: name: intel-ucode/06-3a-09
[    1.365999] platform microcode: loading /lib/firmware/updates/6.1.0-rc1+/intel-ucode/06-3a-09 failed for no such file or directory.
[    1.366032] platform microcode: loading /lib/firmware/updates/intel-ucode/06-3a-09 failed for no such file or directory.
[    1.366061] platform microcode: loading /lib/firmware/6.1.0-rc1+/intel-ucode/06-3a-09 failed for no such file or directory.
[    1.366088] platform microcode: loading /lib/firmware/intel-ucode/06-3a-09 failed for no such file or directory.
[    1.366092] firmware_class: _request_firmware: fw_get_filesystem_firmware: retval: -2
[    1.366096] platform microcode: Direct firmware load for intel-ucode/06-3a-09 failed with error -2
[    1.366174] firmware_class: request_firmware_direct: ret: -2
[    1.366178] microcode: data file intel-ucode/06-3a-09 load failed
[    1.366248] microcode: sig=0x306a9, pf=0x10, revision=0x21
[    1.366380] microcode: Microcode Update Driver: v2.2.

because that happens before the hdd driver has even been loaded yet.

My assumption that late_initcall() is late enough was wrong.

But that's ok - it was a weird use case anyway. One is supposed to use
early loading anyway.

Ok, lemme remove that loading attempt and test them more.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
