Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8037204C5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 16:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236188AbjFBOoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 10:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236109AbjFBOoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 10:44:07 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FD6E43
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 07:44:03 -0700 (PDT)
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C2FAD1EC026E;
        Fri,  2 Jun 2023 16:44:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1685717041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=2AOFicJwTPgUdcHfcpeKSndwQkStqIz6/wMMCYd0H1E=;
        b=ogLDfweyKnYTGaSj85WYz31gQ/v2w7nHloTwxh2YY6RBQVWC/SaOuntubLbpuc9p0svdWH
        LalG3+Q/DaurBrLWBXgV7Jgz6a8URUEYtts6cQJKS03Bf3kndHAjMh5+AW/8AL2g9ccS1X
        4UysctKv5AnrBwgPz7GnDYkdGF2kj/M=
Date:   Fri, 2 Jun 2023 16:43:57 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>, linux-kernel@vger.kernel.org,
        Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        drm-intel@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [RESUBMIT][PATCH] x86/mm: Fix PAT bit missing from page
 protection modify mask
Message-ID: <20230602144357.GCZHoALQjO+xx3YxAz@fat_crate.local>
References: <20230519183634.190364-1-janusz.krzysztofik@linux.intel.com>
 <20230531181412.GFZHeOdMHIGOXB2hwL@fat_crate.local>
 <cfd19da7-4148-f277-0cf8-507b94d214a3@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cfd19da7-4148-f277-0cf8-507b94d214a3@suse.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 10:47:39AM +0200, Juergen Gross wrote:
> As described in the commit message, this only works on bare metal due to the
> PAT bit not being needed for WC mappings.
>
> Making this patch Xen specific would try to cure the symptoms without fixing
> the underlying problem: _PAGE_PAT should be regarded the same way as the bits
> for caching mode (_PAGE_CHG_MASK).

So why isn't _PAGE_PAT part of _PAGE_CHG_MASK?

It says above it "Set of bits not changed in pte_modify."

And I don't see pte_modify() changing that bit either.

Right now this "fix" looks like, "let's OR these two masks so that we
can take care of _PAGE_PAT too". But it doesn't make a whole lotta sense
to me...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
