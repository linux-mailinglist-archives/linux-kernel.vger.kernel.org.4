Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB47660F7A0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 14:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbiJ0MlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 08:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235731AbiJ0Mkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 08:40:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BDE50FAF
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 05:40:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1F43622CE
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 12:40:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C13C433C1;
        Thu, 27 Oct 2022 12:40:37 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="LkTirsK8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1666874436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pj9a76Gy5EIhvCgh1tn+VtUpUQsCC06v3G1EotgJVMo=;
        b=LkTirsK8nmkzFwQL0kKsg47ZKNB1kGianxNTTV0XlcMhv3oFXN4E9GwBAO5Z/MviCdXvVh
        J1bpLikrl1KoUR86EsLopow+WagD0UVWMMYmpZAXpgzlvu5v8igNbCtkeML1nCtpvAogGC
        WzLLRTcssPa6c/TnUdoggNsU8VAMl1A=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 51af9fd4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 27 Oct 2022 12:40:35 +0000 (UTC)
Date:   Thu, 27 Oct 2022 14:40:14 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Adam Langley <agl@google.com>,
        James Morse <james.morse@arm.com>
Subject: Re: [RFC PATCH] arm64: Enable data independent timing (DIT) in the
 kernel
Message-ID: <Y1p8LjXoAjPkWdL+@zx2c4.com>
References: <20221027112741.1678057-1-ardb@kernel.org>
 <Y1p1oKCE+paB8JUK@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y1p1oKCE+paB8JUK@FVFF77S0Q05N>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 01:12:16PM +0100, Mark Rutland wrote:
> I appreciate this is a simple way to rule out issues of that sort, but I think
> the "may" in that sentence is doing a lot of work, since:
> 
> * IIUC, we don't have a specific case in mind that we're concerned about. I can
>   believe that we think all the crypto code we intend to be constant time is
>   theoretically affected.
> 
> * IIUC we haven't gone an audited all constant-time code to check it doesn't
>   happen to use instructions with data-dependent-timing. So there might be more
>   work to do atop this to ensure theoretical correctness.
> 
> * AFAIK there are no contemporary implementations where the DIT is both
>   implemented and it being clear results in data-dependent-timing. i.e. we have
>   nothing to actually test on.
>  
> I have a slight fear that (as above) if there are future CPUs which do consider
> DIT, there's presumably a noticeable performance difference (or the CPU would
> just provide data-independent-timing regardless), but I'm not sure if that's
> just something we have to live with or could punt on until we notice such
> cases.

You're heading on a road to disaster reasoning like that.

You wrote, "we don't have a specific case in mind that we're concerned
about", but actually, all you can say here is that you're not personally
aware of a specific case in mind to be concerned about. As somebody who
actually works on this code, I do have specific cases I'm worried about,
and I know there are certain assumptions I've made about various coding
patterns being CT, resulting in various instructions that I assume to be
CT, which is something I tend to check by hand, while others have entire
frameworks to automatically verify this kind of thing. In other words,
one man's theory is another man's practice.

Then you write that there aren't any contemporary instructions where
this matters, but you fear they could come up in the future. Okay, good,
that's a perspective we can both share. The logical thing to do about
that would be Ard's patch here. However, you then conclude something
vague about performance and suggest punting this down the road. I guess
this makes sense to you because you don't think timing attacks are real
anyway. You're entitled to your opinion, of course, but I don't think
it's a popular one, and it certainly is contrary to that of most
implementers of the concerned code.

On the contrary, we should be proactive in ensuring the kernel remains
a suitable environment for CT code, preventing the problem *before* it
happens, rather than having to deal with vulnerability response down the
road, "punt[ing]" it, as you said. And perhaps if we handle this now,
CPU designers also won't feel like they can get away with silly
performance gains at the cost of CT instructions.

Jason
