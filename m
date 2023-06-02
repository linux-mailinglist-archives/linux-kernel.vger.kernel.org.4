Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDDC720638
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 17:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236622AbjFBPcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 11:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235747AbjFBPcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 11:32:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005ED18C
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 08:32:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 847D064D44
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 15:32:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D0CDC433D2;
        Fri,  2 Jun 2023 15:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685719961;
        bh=SVkGyzyW8nD/mzC5YVIz+vKUiiAkmDQMqMj4UnkMOvY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a4LjYWTpbyhaOCA2bjWfV6TKsAgOy0MeWkpXwXMgRqQrO2fOpIwDxkpGCod6ev4ca
         4exLVAQJyOMXp3tiGzfhhJSoawY9lZ7CjmtbafYeUSEgx8zMoe+5cO8WLK7Ld1+U7Q
         B78Ybw4fArsHemqOhqq/BsAK0D1ZxmWYIek99Kjpv6Ub5LWPtmgP6Kj4SvPdGYoP/5
         z8sPMznaMNgOnEiietpuLDNEH+Z/KkQjUj/swTZ8CRoi1YRNSq9ZdVCzqHO8tLSMPR
         M+s9niZ/npdhaRbYZD+/6nk5+6OugCI/TRittqnyBK+2HgnC6DQkz7rhn8C66EWYMB
         mxs+26vWyM5ww==
Date:   Fri, 2 Jun 2023 08:32:39 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Zack Rusin <zackr@vmware.com>, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>, x86@kernel.org,
        VMware Graphics Reviewers 
        <linux-graphics-maintainer@vmware.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] drm/vmwgfx: Silence RBP clobber warnings
Message-ID: <20230602153239.fsug6rgvoxgnrea6@treble>
References: <e9388b1ad4d955b43b44e8a5dcd6cf6da7d260a0.1685717659.git.jpoimboe@kernel.org>
 <20230602151639.GK620383@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230602151639.GK620383@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2023 at 05:16:39PM +0200, Peter Zijlstra wrote:
> On Fri, Jun 02, 2023 at 07:56:34AM -0700, Josh Poimboeuf wrote:
> > VMware hypercalls take the RBP register as input.  This breaks basic
> > frame pointer convention, as RBP should never be clobbered.
> > 
> > So frame pointer unwinding is broken for the instructions surrounding
> > the hypercall with the clobbered RBP.  There's nothing that can be done
> > about that.  Just tell objtool to ignore it.
> > 
> 
> That's a pretty horrific ABI, one that violates the oldest x86 calling
> convention in existence.
> 
> VMware folks, shame!!

Agreed :-(

BTW, please ignore the patch, I'll be sending a v2.

I realized (with Peter's prodding on IRC) that reliable ORC unwinding
would be broken if the function has a frame pointer.  Which can
happen if the function needs an aligned stack.

-- 
Josh
