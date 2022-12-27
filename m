Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661E1656FE7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 22:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbiL0VOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 16:14:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbiL0VOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 16:14:32 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119C6E3;
        Tue, 27 Dec 2022 13:14:31 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4D7A91EC0513;
        Tue, 27 Dec 2022 22:14:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1672175669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PKizlkbenA5JgN5QTgafvGE7l5kd436bqvEmQmYM1p4=;
        b=SRe70gX4tpSK0sk2zHwRnqiu4/ROwwU3/GEkPv160wW1tjH5dBjmai7+DuNKw5i8c9vpMG
        xAIpdsMRHPo3DYtyYdIqi8Uaf+yp1QkIvCylX3LrUyn503sV+oE1ibcYf8K9fl8UEIZqR9
        1Tf9qNC4YvtnUcZoLU9bh8cEU9MKtPU=
Date:   Tue, 27 Dec 2022 22:14:24 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Alexander Altman <alexanderaltman@me.com>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, rust-for-linux@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [bp:tip-x86-alternatives 1/1] error[E0588]: packed type cannot
 transitively contain a `#[repr(align)]` type
Message-ID: <Y6tgMM/qOnePXBQF@zn.tnic>
References: <202212272003.rgQDX8DQ-lkp@intel.com>
 <Y6r4mXz5NS0+HVXo@zn.tnic>
 <Y6r+UbfkXruwHU2v@zn.tnic>
 <76353487-736A-4470-AD31-77F47F8C08F6@me.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <76353487-736A-4470-AD31-77F47F8C08F6@me.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2022 at 12:31:17PM -0800, Alexander Altman wrote:
> That caused Rust’s bindgen (bindings generator) to generate a type for the
> altered field that indirectly included a representation of the
> bitfields...which have a greater-than-natural alignment because of their
> encoding (they’re represented as an array of 4 8-bit unsigned integers, but
> aligned as if they’re a single 16-bit unsigned integer).  This interacts
> badly with the top-level command to make the alt_instr struct packed, which
> bindgen faithfully translates from C __packed to Rust #[repr(packed)].

This sounds like a rust problem to me. Because, AFAICT, this is
perfectly valid C and both compilers haven't complained even with all
the possible warnings turned on.

> One way to resolve this temporarily would be to add the following line above
> the offending struct:
> /// <div rustbindgen hide></div>

Nah, I don't think I'll accept a fix for the shortcomings of yet another tool.

> This will cause bindgen to ignore the struct entirely and not translate it.  If it’s
> actually needed for Rust code, now or later, then we can’t do that and need
> to actually replace it with something translatable, or else leave it hidden and
> manually create its translation on the Rust side.  For the latter, just using a
> u32 for the entire bitfield-containing union would be sufficient.

Yap, that sounds like the right thing to do.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
