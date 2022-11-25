Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591F3638E5E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 17:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiKYQli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 11:41:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiKYQlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 11:41:37 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE33E2BB10
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 08:41:36 -0800 (PST)
Received: from zn.tnic (p200300ea9733e784329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e784:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1B85A1EC0434;
        Fri, 25 Nov 2022 17:41:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1669394495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=PeFnFT9Grd/p7AAjLHGK8pXWkjmEHR0MThlrXWx5/UI=;
        b=gVJyLFyk5jQsb8J6/Q0dOr63UfIaEvz8cZfzUJHZLZFW4cxtisdc/qZik358qoJQwGlQBO
        zxmH+826LJjzA6qMLn9RBuRW0GzoNRyjspIF5OXsEYV4OVva9T1Pk78XuZgGGCyNPsx8zF
        Zom6zV8JyJXuLL7iMW5ICVPmbxbLxAk=
Date:   Fri, 25 Nov 2022 17:41:31 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Petr Pavlu <petr.pavlu@suse.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, nicolas@fjasle.eu,
        masahiroy@kernel.org, kirill.shutemov@linux.intel.com,
        tony.luck@intel.com, michael.roth@amd.com, nathan@kernel.org,
        ndesaulniers@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86: Avoid relocation information in final vmlinux
Message-ID: <Y4DwOzkN04uYIAox@zn.tnic>
References: <20220927084632.14531-1-petr.pavlu@suse.com>
 <Y34SXeU6JEk+UGfV@zn.tnic>
 <1af5ee66-5ab1-45b2-f229-182f89dc6b94@suse.com>
 <Y35CNdPVwq11NCYN@zn.tnic>
 <765e1e78-c540-0753-7a19-7d335bcc998b@suse.com>
 <Y39lwk3itVnsADrP@zn.tnic>
 <1cc97d84-da4d-c8cc-dbcd-fcdc34c6d11c@suse.com>
 <Y3+Ql1ETyO9FP2xU@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y3+Ql1ETyO9FP2xU@zn.tnic>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 04:41:11PM +0100, Borislav Petkov wrote:
> This is in both cases with your patch, once with RANDOMIZE_BASE=y and
> once with RANDOMIZE_BASE=n.
> 
> IOW, your patch actually makes my vmlinux bigger by 51K.
> 
> IOW, I cannot reproduce your
> 
> | Configuration      | With relocs | Stripped relocs |
> | x86_64_defconfig   |       70 MB |           43 MB |
> 
> claim, but not with a defconfig but with my specially tailored config.
> 
> I guess the next thing I'll try is without your patch.

Ok, I tried reproducing your defconfig numbers first:

defconfig:						vmlinux
- with patch: NEED_RELOCS=y				 48053656
- with patch, NEED_RELOCS=n, 				 48000696
- without patch, NEED_RELOCS=n, 			 48000696
- without patch: NEED_RELOCS=y				 83091744

So yes, I can reproduce your observation - defconfig *with* your patch
does slim down vmlinux, because, well, it is moving the reloc sections
into a separate file. Doh.

And with my .config too:

tailored config:
- with patch: 		NEED_RELOCS=y			377718768
- without patch, 	NEED_RELOCS=y			639952576

So I guess we can try it - let's see who complains.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
