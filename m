Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA17C6F0A4E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 18:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244142AbjD0Qzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 12:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjD0Qzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 12:55:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24EE270F
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 09:55:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DF2960F1D
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 16:55:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E540BC433EF;
        Thu, 27 Apr 2023 16:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682614541;
        bh=gIQhRd5szs2uIVRsalAsZomrEfyQV7eUYFAWPCeKLpU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=OVuOTWDy8uVjGkWe7MznXcH3yPFoDjOzBXI94AnFM5oNnfHDjWc54gj55+uFcVrve
         B2speQdu66w3qeW56+eiihR7Q7npE2Y6zyeOmGGJnolyVdrARDvykIVfFmQdQZ1iG/
         rDPJ/hxJ/0hysodRooeReM8oi3xQ/Hnjet/I9SSKWek8Rc1RpRGL24Oe3fU9kYZxbk
         A8woZKnojRv646J9d6FH0gADePY2YmhT0oi9cgVfGF++WIuG8kZ6kXi1LtI9x/5ntk
         TS9VgRSUKju3rCuelpTmfL5tmUKj966160RUjHqRhZdhyV4HByQBO7OC+MctQEzKKh
         ZW7dvyIWqaAtA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 7C7EA15405AD; Thu, 27 Apr 2023 09:55:41 -0700 (PDT)
Date:   Thu, 27 Apr 2023 09:55:41 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     jpoimboe@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: An objtool warning from mainline
Message-ID: <c7701c43-7b4a-46ad-b113-be0657e241dc@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <02bd36cf-b2b8-4634-a70b-1476420188c8@paulmck-laptop>
 <20230427091421.GAZEo87ezQPLwLKiPF@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230427091421.GAZEo87ezQPLwLKiPF@fat_crate.local>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2023 at 11:14:21AM +0200, Borislav Petkov wrote:
> On Wed, Apr 26, 2023 at 04:50:49PM -0700, Paul E. McKenney wrote:
> > vmlinux.o: warning: objtool: exc_nmi+0x2b3: call to __const_udelay() leaves .noinstr.text section
> 
> What does
> 
> ./scripts/faddr2line vmlinux.o exc_nmi+0x2b3
> 
> say?

$ ./scripts/faddr2line vmlinux.o exc_nmi+0x2b3
exc_nmi+0x2b3/0x3c0:
exc_nmi at ??:?

Which might mean something to you, but does not look all that helpful
to me.  :-/

> I guess it should point to io_check_error()'s udelay().
> 
> If so, it is noinline:
> 
> 81423c37415f ("x86/timer: Don't inline __const_udelay()")

I do have that commit, so it is noinline.

> > I see this with gcc version 11.3.0 (Ubuntu 11.3.0-1ubuntu1~22.04) and also with
> > gcc version 8.5.0 20210514 (Red Hat 8.5.0-18) (GCC).
> 
> I can't trigger it here with
> 
> gcc-11 (Debian 11.2.0-19) 11.2.0
> 
> Which is weird because the asm looks like it should warn.
> 
> Does it go away if you remove the noinline before __const_udelay()?

It stays.

No idea here.

							Thanx, Paul
