Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F3F6364E5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 16:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238465AbiKWPz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 10:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238443AbiKWPzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:55:05 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C6313FA4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 07:54:32 -0800 (PST)
Received: from zn.tnic (p200300ea9733e747329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e747:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 52F471EC04CB;
        Wed, 23 Nov 2022 16:54:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1669218870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=pLH+i9i1kiRum32wiRUaHYap4GAndKu4vk7n7RNzaaI=;
        b=NTIzVahHzUNfqsdzKh/DYajdc/1Kae9VS6lbPZkMrLOi/8z52JQyISQToX1sIZhIMr5QxW
        +mzJFI8PV+L06GVqQ5BxKwY1a3YIxP35J1kaEefoSUyWzZPQJp+EPk/OzQz/OW6SIXWkOm
        ox151/T3GEnV/qy1xVjAt2eKEBIBhog=
Date:   Wed, 23 Nov 2022 16:54:29 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Petr Pavlu <petr.pavlu@suse.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, nicolas@fjasle.eu,
        masahiroy@kernel.org, kirill.shutemov@linux.intel.com,
        tony.luck@intel.com, michael.roth@amd.com, nathan@kernel.org,
        ndesaulniers@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86: Avoid relocation information in final vmlinux
Message-ID: <Y35CNdPVwq11NCYN@zn.tnic>
References: <20220927084632.14531-1-petr.pavlu@suse.com>
 <Y34SXeU6JEk+UGfV@zn.tnic>
 <1af5ee66-5ab1-45b2-f229-182f89dc6b94@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1af5ee66-5ab1-45b2-f229-182f89dc6b94@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 04:43:20PM +0100, Petr Pavlu wrote:
> The only post-link analysis tool in this case should be arch/x86/tools/relocs.
> It produces a vmlinux.relocs file which is appended to vmlinux.bin. This is
> all internal to the Linux build. I'm not aware of any external tooling, such
> as kernel debuggers, that would require this relocation information in
> vmlinux.

It would be good to know why --emit-relocs was added in the first place
- that might give us a hint. Lemme talk to Micha.

> The size command used in your example includes only allocatable code, data and
> bss sections. It does not show size of any relocation sections.

This:

361M vmlinux.before
361M vmlinux.after

is simple ls output.

Maybe I need something else enabled in my .config which would show this
significant difference *and* *explain* it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
