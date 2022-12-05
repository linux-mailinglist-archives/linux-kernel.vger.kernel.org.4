Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF100642CBC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 17:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbiLEQZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 11:25:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbiLEQZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 11:25:24 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F14A1DDE9
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 08:25:23 -0800 (PST)
Received: from zn.tnic (p200300ea9733e72f329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e72f:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ADE5D1EC0674;
        Mon,  5 Dec 2022 17:25:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1670257521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=u/8q7IKW2/01CTBav2jPOwHr2XBf6TJfCZXjOCyErE0=;
        b=LJEbfxJg4EX5NT7mZBZ29X7gc/20e8bCJ8TryrYd/etq4n/YKZHzGoRIQ/74+sB8byPsms
        DT0MvV8fpK0sBDa1OIktH4Id8l98lK7/KXKhyDLNF222qC9pLgoD38OY80z6GjnBmGrz/Q
        yCnxRt0vZ1EDKD41hSbNO6dczj3dO+Y=
Date:   Mon, 5 Dec 2022 17:25:17 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     X86-kernel <x86@kernel.org>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>, alison.schofield@intel.com,
        reinette.chatre@intel.com
Subject: Re: [Patch V1 3/7] x86/microcode/core: Move microcode_check() to
 cpu/microcode/core.c
Message-ID: <Y44bbZMMf8I6Lzl/@zn.tnic>
References: <20221129210832.107850-1-ashok.raj@intel.com>
 <20221129210832.107850-4-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221129210832.107850-4-ashok.raj@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 01:08:28PM -0800, Ashok Raj wrote:
> microcode_check() is only called from microcode/core.c. Move it and make
> it static to prepare for upcoming fix of false negative when checking CPU
> features after a microcode update.

So this function is there in cpu/common.c because it uses CPU facilities
like cpuinfo_x86 and get_cpu_cap() so the logical place was there.
So that I don't have to export a bunch of things but rather have the
microcode loader call into it only.

Your next patch is using more of those CPU-specific facilities so
"bleeding" them into the microcode loader looks like the wrong way
around.

get_cpu_cap() deals with all those c->x86_capability arrays and other
functions which do that, should be there too.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
