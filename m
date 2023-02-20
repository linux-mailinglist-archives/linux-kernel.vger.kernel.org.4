Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6435569D0F0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 16:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbjBTPvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 10:51:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjBTPvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 10:51:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A561EFC2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 07:51:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A5E01B80D3D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 15:51:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 996B5C433D2;
        Mon, 20 Feb 2023 15:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676908269;
        bh=wOTNmM/rz3jrTV1ds+AgaiAA4vZjdn8ItdA+1UsLrJw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IX7T7SfZfHgBLjetbffAQXt+9NN7ezi0KNeduFGeldn/T/vtz1g2Su9/Wi7bjPAbw
         KTZo5fECYY4Mo4rGRSdrbSoG1duju0nd3Go6FA9S7nRjcoud2BHiBXH0WS1POJxfpl
         pluLPBJD+VEWJIXp9l4yAWxQcHJftXjBMbCqjMWKmSBDqb4dxj1QKX94FgzDf63qSr
         k8wXWwdEAlW19pBHJli0Ek46N4YFCXE9liCaosUgOyk2N1VNKbn/FA5HXXttAZAChP
         /zWOVBCApciID7bjFxrlIjYSgOavfwtBo4Xblhv9DYDb0QS1cIV936kQ4GmDqk5TlO
         a0SViTeqjgLgQ==
Date:   Mon, 20 Feb 2023 08:51:06 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     npiggin@gmail.com, christophe.leroy@csgroup.eu,
        erhard_f@mailbox.org, ndesaulniers@google.com, trix@redhat.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev
Subject: Re: [PATCH 0/3] Allow CONFIG_PPC64_BIG_ENDIAN_ELF_ABI_V2 with ld.lld
 15+
Message-ID: <Y/OW6mRi3qDpVQkc@dev-arch.thelio-3990X>
References: <20230118-ppc64-elfv2-llvm-v1-0-b9e2ec9da11d@kernel.org>
 <87wn4cyifp.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wn4cyifp.fsf@mpe.ellerman.id.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 05:11:54PM +1100, Michael Ellerman wrote:
> Nathan Chancellor <nathan@kernel.org> writes:
> > Currently, CONFIG_PPC64_BIG_ENDIAN_ELF_ABI_V2 is not selectable with
> > ld.lld because of an explicit dependency on GNU ld, due to lack of
> > testing with LLVM.
> >
> > Erhard was kind enough to test this option on his hardware with LLVM 15,
> > which ran without any issues. This should not be too surprising, as
> > ld.lld does not have support for the ELFv1 ABI, only ELFv2, so it should
> > have decent support. With this series, big endian kernels can be built
> > with LLVM=1.
> >
> > This has seen our basic set of powerpc configurations with clang-15,
> > clang-16, and clang-17 but I will never be opposed to more testing :)
> >
> > The first two patches fix a couple of issues I noticed while build
> > testing and the final patch actually allows the option to be selected.
> 
> Thanks for this.
> 
> I thought about applying this last week but decided not to. I'll plan to
> pick it up for 6.4.

No worries, I sent this much later in the development cycle than I had
initially intended, so I figured that 6.3 was a long shot anyways. Plus
more soak time is never a bad thing :)

Thanks for taking the initial look, cheers!
Nathan
