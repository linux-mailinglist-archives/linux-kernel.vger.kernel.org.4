Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCEB69A5E7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 08:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjBQHF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 02:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjBQHFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 02:05:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7D0900C;
        Thu, 16 Feb 2023 23:05:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0AE66B829AC;
        Fri, 17 Feb 2023 07:05:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D325C433D2;
        Fri, 17 Feb 2023 07:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676617547;
        bh=O915DOYblEyhW+IM9kfJrC5Kx0YW+/xEUBLvVzqTRHk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DJF32EQ62vBBuE/ud1MiiQ+QL7F2YGbh57J/qyJGT36uXd3jQdoZuLGs2zQDnczBZ
         cTWwK1CzprnIwPHNvGO0yQQWkK4tJ8bSUCQvH4iUiwrdSUDGjeYf6q1/YadglkYiqg
         ljb04zIEYmzqWt98Z3cvUnAfx7i7+BHZRFZmIukRDZDFL5SP+Nh0m1JYgaxd10g/vf
         Vyk6xCO6ikrDID1CXoEItJC2YzTjrt7ck/B5hRXN6Um/yX9VRdd8DytdnT5LeQA33N
         rHmmXCE34tROYWOqagmoG8+m1FM6/ZQ5Mv9hR8gtzF9V2uCL6cmD6CHfIkAED2alF3
         Kuq1YFS/h4aIw==
Date:   Thu, 16 Feb 2023 23:05:44 -0800
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Sathvika Vasireddy <sv@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the powerpc tree
Message-ID: <20230217070544.uhe337i5xsgwsum4@treble>
References: <20230216144031.45b1fc12@canb.auug.org.au>
 <20230216180607.w666rnbtm5fumziq@treble>
 <87k00hysyy.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87k00hysyy.fsf@mpe.ellerman.id.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 12:35:17PM +1100, Michael Ellerman wrote:
> Josh Poimboeuf <jpoimboe@kernel.org> writes:
> > On Thu, Feb 16, 2023 at 02:40:31PM +1100, Stephen Rothwell wrote:
> >> Hi all,
> >> 
> >> After merging the powerpc tree, today's linux-next build (powerpc
> >> pseries_le_defconfig) produced this warning:
> >> 
> >> arch/powerpc/kernel/head_64.o: warning: objtool: .text+0x6128: unannotated intra-function call
> >> 
> >> I have no idea what caused this.
> >
> > Adding Sathvika and Christophe.
> >
> > The short term fix would be something like the below, but...
> >
> > If powerpc objtool is only doing mcount, does it even make sense to run
> > objtool on asm files?  If so, there are probably a lot more cleanups
> > needed for the asm code.
> 
> I would like to enable more of the objtool checks eventually, although I
> don't have a timeline for that. But I'd prefer to keep checking the asm
> code seeing as we've already enabled that.

Sounds good for now, though as you get more objtool features there will
need to be more changes.

For example a lot of the callable functions are annotated with _GLOBAL()
rather than SYM_FUNC_{START,END}.  The latter adds the function size,
which objtool needs in several cases.  It also has particular rules
about when to use SYM_FUNC_* vs SYM_CODE_*, etc to make the code more
structured.

> > So I'm thinking either we should cleanup all the powerpc asm code with
> > annotations like below, or we should try to make objtool mcount-mode
> > ignore asm files.
> 
> I think we have most of the code annotated already, this is a new
> warning because that code is newly refactored by a commit I applied.
> 
> I'll have to fix my build scripts to error out on objtool warnings.

Likewise, I'll need to add some powerpc cross-compiles to my testing.

If we get too many of these powerpc warnings, we may be looking to
recruit more objtool maintainers ;-)

-- 
Josh
