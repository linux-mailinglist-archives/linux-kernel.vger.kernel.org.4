Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B7C6D6752
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 17:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235365AbjDDPaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 11:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234708AbjDDPaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 11:30:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE591984
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 08:30:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2169063603
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 15:30:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16458C433D2;
        Tue,  4 Apr 2023 15:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680622214;
        bh=i/w5GGBWoyeO6zs1YesUe2Rk58yoxoPxBwHISLrYctY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W+EL8IIlvhf2BKu/Eqf6hL2knF2luLeLru6p6SL9LJpASQ+Rde1pp0msZl8nttNt/
         RffZyaEFuU+pDwOnhMj7U0RfenhCx0IEhHCKLJ3hLJ+TK1HooqHLcrdpxlBW2/mbKp
         6e9YlntwG155BYF/vx5UATvXSoWov2OvGfo7c++fvfXiIsyEo2XGUwFcjC1f6COqdi
         2bGLDzX7cOiiHSfiYRWBlmSTKrVOk6PfF1bqQp1EECv9RulcDv1+Tk9dxpBOzGFRwY
         fkfYjHr3hvZr4jbqdrEfdjsTAORRn7eLt1rYoeqM4MYBwfGBb/KFr+6cZDKj81WYYY
         SK+t5Q+AUCkHQ==
Date:   Tue, 4 Apr 2023 08:30:12 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     kernel test robot <lkp@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH] prctl: Add PR_GET_AUXV to copy auxv to userspace
Message-ID: <20230404153012.GA1702188@dev-arch.thelio-3990X>
References: <b11a591e085f1cd06adb454b1f7cde676d317318.1680585798.git.josh@joshtriplett.org>
 <202304041715.c3b7aJd4-lkp@intel.com>
 <ZCwTHxzUAMOzXFi7@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCwTHxzUAMOzXFi7@localhost>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 09:07:59PM +0900, Josh Triplett wrote:
> On Tue, Apr 04, 2023 at 05:58:51PM +0800, kernel test robot wrote:
> > reproduce (this is a W=1 build):
> 
> Right, I *really* need to start doing W=1 builds. (Am I missing
> something, or did kernel builds once emit warnings about type mismatches
> on `min` by default?)

I see this warning in a normal ARCH=arm allmodconfig build (i.e.,
without W=1). Perhaps you never did a 32-bit build, since that is the
only way this warning would appear?

> > >> kernel/sys.c:2383:23: warning: comparison of distinct pointer types ('typeof (sizeof (mm->saved_auxv)) *' (aka 'unsigned int *') and 'typeof (len) *' (aka 'unsigned long *')) [-Wcompare-distinct-pointer-types]
> 
> Will fix in v2.
> 

Cheers,
Nathan
