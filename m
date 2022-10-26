Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6162960E58A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 18:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbiJZQjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 12:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232773AbiJZQjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 12:39:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88273120ED4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 09:39:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DCB561F8A
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 16:39:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07329C433C1;
        Wed, 26 Oct 2022 16:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666802343;
        bh=4gG/8lY0Eu0LFKD8NmUND/jh6Wol8H9kVyNLR1/Xkd0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lZ9s40w0PWSuBrI9jbQXsQpTGCfO0yEOQit3cPIl0dyiUVx+hOpGQ2xViPxxNpZro
         /Pe5sv2hxDtnY4ffLDegs8JA76zR/zxB2J+OE4SRQLDz/A3PwpL4+6+Ur1nFK9GEd/
         DAsgRnG6ZcP/wMoaTb5D/iXrw74lXvP+wj1lh+VVA4zJlIYF/+2O4XPaOPIhDmr4Kq
         Z4HbaBVr7tC3ZcYs6tgJy9X0Gvd2tiRbOClzgJt90ZUwNBgddah5SFdP8Ss/AqqlYY
         pzv1n0WZa7SoSlIQLb1LXpUqZz4in0SuPq/3IXRYJ3/oihNK8qYzHjLoENSZ9di7SI
         1axQsOAMs6bCQ==
Date:   Wed, 26 Oct 2022 09:39:01 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Gautam Menghani <gautammenghani201@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] mm/khugepaged: Initialize index and nr in collapse_file()
Message-ID: <Y1lipZXfRStgms/7@dev-arch.thelio-3990X>
References: <20221025173407.3423241-1-nathan@kernel.org>
 <20221025184802.7d4611caff603fecf98330b6@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025184802.7d4611caff603fecf98330b6@linux-foundation.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 06:48:02PM -0700, Andrew Morton wrote:
> On Tue, 25 Oct 2022 10:34:07 -0700 Nathan Chancellor <nathan@kernel.org> wrote:
> 
> > Clang warns (trimmed for brevity):
> > 
> >   mm/khugepaged.c:1729:7: warning: variable 'index' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
> >   mm/khugepaged.c:1716:6: warning: variable 'index' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
> >   mm/khugepaged.c:1729:7: warning: variable 'nr' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
> >   mm/khugepaged.c:1716:6: warning: variable 'nr' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
> > 
> > There are two goto statements that will use index and nr before they
> > have been properly initialized. Zero initialize them so that they can be
> > safely used by the tracepoint at the end of the function.
> 
> Thanks.  I've actually dropped the offending patch - I'd like a resend
> which includes a fix such as this and a good reason for making the
> change.

That certainly seems like a reasonable request. Thanks for letting me
know!

Cheers,
Nathan
