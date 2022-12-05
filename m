Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8BBA6436DB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 22:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbiLEV1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 16:27:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233841AbiLEV1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 16:27:24 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D2F2AE3D
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 13:27:22 -0800 (PST)
Received: from zn.tnic (p200300ea9733e7ff329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7ff:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C4B831EC0523;
        Mon,  5 Dec 2022 22:27:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1670275640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=fRZy8tyBFfkUb/uE9c9XkYxCY4moAtCYP4EgqoQtF5U=;
        b=MDMnkWYRBBy7pppX9cOlpojDwwhChvBzNksgPaKZIGdI84QrtT2vm6capcbG71HI1+FiiF
        ecAWqky2rfc2Vt4qivwMb1hVCUhgLu/+KcWTlC01qRHGz9RvojDn/rkwKJaU1Z58M0g5a7
        qHVzg3URrdT8IAG9tEsx/3lLG+2TthY=
Date:   Mon, 5 Dec 2022 22:27:15 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     X86-kernel <x86@kernel.org>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>, alison.schofield@intel.com,
        reinette.chatre@intel.com
Subject: Re: [Patch V1 3/7] x86/microcode/core: Move microcode_check() to
 cpu/microcode/core.c
Message-ID: <Y45iM/jUjdYOPQrC@zn.tnic>
References: <20221129210832.107850-1-ashok.raj@intel.com>
 <20221129210832.107850-4-ashok.raj@intel.com>
 <Y44bbZMMf8I6Lzl/@zn.tnic>
 <Y44k8gXIG+usGkL1@a4bf019067fa.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y44k8gXIG+usGkL1@a4bf019067fa.jf.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 09:05:54AM -0800, Ashok Raj wrote:
> I was trying to move this similar to how x86_read_arch_cap_msr()
> moved from x86/kernel/cpu/cpu.h -> asm/cpu.h.

But that is only a function prototype - not the *actual* function.

> Keeping the usage local since there is just one caller to microcode_check()
> but there are other users of get_cpu_cap() like in
> arch/x86/xen/enlighten_pv.c which seems to be reaching out to
> ../kernel/cpu/cpu.h. 

Yah, that's the single use outside of kernel/cpu/. Looks like a hack to me. :)

But no worries, we will clean all that up sooner or later and
get_cpu_cap() will disappear someday soon hopefully.

> That said, what you say also makes sense. I'm fine with what you decide how
> this should look.

Yes pls.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
