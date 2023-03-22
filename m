Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F086C53C9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 19:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjCVSfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 14:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjCVSff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 14:35:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528442B28B
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 11:35:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0684DB81D92
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 18:35:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FBB1C433D2;
        Wed, 22 Mar 2023 18:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679510131;
        bh=Elhv5mKGPuTN9tb82ch7Z8v7l2hA1kpDwRzCbhEVmOM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VURV87mcQN39K4QZRsysSH66EvTfDhdd7Ti8NQt+AWT2MFtM5/te7AG7EY+2zqnog
         kGQs/bDDtPcuuVVTIKy/OsmrheSHm8W7A6FYKXy4QpE7LF48XwZaEYDDrBdptLZYME
         wbncrahygwrvxOaJOK8ypkZWMyWd3Zh7OPtG/mprf7MdV9GN9DD4pKRLvS1t+WvuoI
         ao8ALKmRHqXsifFIPEmXbICnfwyfPVbeixb0JhfqCZxe2xj25dmX8lJxW7bVhJHaiv
         YQ6CPCqr9D1mp+8s6HuK6pitfcNapDwhsIxc0zKZARkorETDXvsrU5o4efrBOao+k7
         mJnQW4GvGf55g==
Date:   Wed, 22 Mar 2023 11:35:29 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Will McVicker <willmcvicker@google.com>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 09/11] static_call: Make NULL static calls consistent
Message-ID: <20230322183529.owu33xouz44sv4re@treble>
References: <cover.1679456900.git.jpoimboe@kernel.org>
 <7638861ae89606b1277ad4235654bba2b880f313.1679456900.git.jpoimboe@kernel.org>
 <20230322145918.GF2357380@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230322145918.GF2357380@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 03:59:18PM +0100, Peter Zijlstra wrote:
> On Tue, Mar 21, 2023 at 09:00:15PM -0700, Josh Poimboeuf wrote:
> > +void __static_call_nop(void)
> > +{
> > +}
> > +EXPORT_SYMBOL_GPL(__static_call_nop);
> 
> Kees, is this a ROP target? The above is basically ENDBR;RET, push
> something on the stack, jump there and you're in business or so.

I could add __noendbr, except for the !HAVE_STATIC_CALL + !CFI_CLANG
case which actually needs to indirect call it.

-- 
Josh
