Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E153E6E1120
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 17:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbjDMP1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 11:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjDMP1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 11:27:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70288AF0E
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 08:27:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0329663FB1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 15:27:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33550C4339B;
        Thu, 13 Apr 2023 15:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681399646;
        bh=QrNBf+zDzBbeUbTMfN+pdTrdAgjIZ3z012J1oGdx7f8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fz0GV2p032erB/2j67q45POnAevIumFmRrKE89Cg3wzhteW51fwn7GpzCp+FdWCVd
         r6sCQQPe5GE76kqEFyHNOykee7Buof1bFZRb42NXIMK6UmpTl4qvCRfqAirwraXHnM
         P8EQD8T4JObNTl43wYeWSDjhL+kZ5FiDqgV3lLTdx5KkCkjnjU/RmmmHbe+4x48ZVT
         cIH0FQgQmDTHRMUNR7G0RM5jmvjtxc8dIj4Dx5826ppe3ixHUIxn9bwGSQ3HXHXh0P
         XaOr4rqqqvH8cWt/Ru+ivt+Nxn0YHmd9ueljiM/NpiztFXTQ8UlcGxUMjz2HNkPjQ5
         avhU3h6MECsAA==
Date:   Thu, 13 Apr 2023 08:27:24 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH 1/3] objtool: Separate prefix code from stack validation
 code
Message-ID: <20230413152724.rwakb3lxaptgc7e5@treble>
References: <cover.1681331135.git.jpoimboe@kernel.org>
 <d7f31ac2de462d0cd7b1db01b7ecb525c057c8f6.1681331135.git.jpoimboe@kernel.org>
 <20230413093031.GK4253@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230413093031.GK4253@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 11:30:31AM +0200, Peter Zijlstra wrote:
> On Wed, Apr 12, 2023 at 01:26:13PM -0700, Josh Poimboeuf wrote:
> > Simplify the prefix code and make it a standalone feature.
> 
> The main thing being that you moved it all after
> validate_reachable_instructions() ?

The main thing being that I extricated it from validate_symbol() so it's
a proper independent feature.

> > +static int add_prefix_symbols(struct objtool_file *file)
> > +{
> > +	struct section *sec;
> > +	struct symbol *func;
> > +	int ret, warnings = 0;
> > +
> > +	for_each_sec(file, sec) {
> > +		if (!(sec->sh.sh_flags & SHF_EXECINSTR))
> > +			continue;
> > +
> > +		list_for_each_entry(func, &sec->symbol_list, list) {
> 
> One of the other patches did a sec_for_each_symbol() thing.

Too many patch sets floating around ;-)

-- 
Josh
