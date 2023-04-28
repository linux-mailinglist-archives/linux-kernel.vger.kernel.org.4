Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757606F1111
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 06:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345071AbjD1EfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 00:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjD1EfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 00:35:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5BC9E
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 21:35:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E17463F67
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 04:35:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64DB7C433EF;
        Fri, 28 Apr 2023 04:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682656519;
        bh=m7AjJFVjT3PRLk++klDfbqigGbfinbYBjJ+9H3wDadk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OclBgbQyPgCHFpC3i01kIq2JVk6KWU7mnrn6hYE1y+LYO4pHkNCqqPMEV6ijlqF+r
         UyxN+nNJ4c7gY0EDUK4JwySf8sWfoDgujprstmLMn/eS+EZpyn1a9A+BGslmC/nBjh
         o64PxswOBczyQr9D+EJqMJJj7t29i2V5UcxYkEVeWG3pLg0Ny48fqWB1ks8OBaaL87
         I9Z82bKHuE58hEB4oXyOcoHnJV3b/L82PaXJj6sPI9jgTKP8LKCgupu8mcMBVx/TSV
         YbciP0hzR3sy0Gl4p+LEh8P8jDmyV5TkQwqfmeTVAS+nd1EonmPXNrgiiqWSE83OxA
         6xjY5+puKbMXg==
Date:   Thu, 27 Apr 2023 21:35:17 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: An objtool warning from mainline
Message-ID: <20230428043517.h5x4jkx2k26jyqoi@treble>
References: <02bd36cf-b2b8-4634-a70b-1476420188c8@paulmck-laptop>
 <20230427091421.GAZEo87ezQPLwLKiPF@fat_crate.local>
 <c7701c43-7b4a-46ad-b113-be0657e241dc@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c7701c43-7b4a-46ad-b113-be0657e241dc@paulmck-laptop>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2023 at 09:55:41AM -0700, Paul E. McKenney wrote:
> On Thu, Apr 27, 2023 at 11:14:21AM +0200, Borislav Petkov wrote:
> > On Wed, Apr 26, 2023 at 04:50:49PM -0700, Paul E. McKenney wrote:
> > > vmlinux.o: warning: objtool: exc_nmi+0x2b3: call to __const_udelay() leaves .noinstr.text section
> > 
> > What does
> > 
> > ./scripts/faddr2line vmlinux.o exc_nmi+0x2b3
> > 
> > say?
> 
> $ ./scripts/faddr2line vmlinux.o exc_nmi+0x2b3
> exc_nmi+0x2b3/0x3c0:
> exc_nmi at ??:?
> 
> Which might mean something to you, but does not look all that helpful
> to me.  :-/

This means DWARF is missing.  Can you enable one of the
CONFIG_DEBUG_INFO_DWARF* options and try that again?

And yes, we should improve the error message for faddr2line.

-- 
Josh
