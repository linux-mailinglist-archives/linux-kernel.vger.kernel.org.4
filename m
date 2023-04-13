Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C896E10A6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 17:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjDMPJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 11:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbjDMPJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 11:09:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0A710DF
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 08:09:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B0FD63F74
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 15:09:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B43DC433D2;
        Thu, 13 Apr 2023 15:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681398565;
        bh=Jjj8p61XqjjGR9sdKI59lewPY6J2sswWXyRWpR2f+uU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sp4UXjVGmCawDks39R38ObN+kD/5zAwUhfV5Ul8BvHB4y5xw8/B5IUzK4kPP3w+iC
         IxBCGvK8LCKYp+j5GPKIhiY88avr2VWS6psHv8n0TpFsagGRXBxeVY5q2/T6RxwP/y
         mKsbJIPMCWok5vuS195fzl1XcIOcgEnNwOzGm9i8ecDss0wxuqKUo/0Em2K8wdtzBO
         Hydcfp04jX5sSTmYnru2V2ZlWfmcuzWdoTZRLGMU8HqlyHMlAOZOTBbXuJWm8hVgjo
         taF/A1EdKsWaCG16evPVk8a0+uYc9RyEuLwaPDvNwnwtyzH6ZP+kOfR0gEo3qw+Sx+
         cQBjZmHfDW1Yw==
Date:   Thu, 13 Apr 2023 08:09:23 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/9] objtool: Add verbose option for disassembling
 affected functions
Message-ID: <20230413150923.45uuaif4y2fclmyq@treble>
References: <cover.1681325924.git.jpoimboe@kernel.org>
 <4cadacc719db1e792c335309056960ca6f71139e.1681325924.git.jpoimboe@kernel.org>
 <20230413080822.GH4253@hirez.programming.kicks-ass.net>
 <alpine.LSU.2.21.2304131602150.27633@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.2304131602150.27633@pobox.suse.cz>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 04:03:07PM +0200, Miroslav Benes wrote:
> On Thu, 13 Apr 2023, Peter Zijlstra wrote:
> 
> > On Wed, Apr 12, 2023 at 12:03:20PM -0700, Josh Poimboeuf wrote:
> > > +	objdump_str = "%sobjdump -wdr %s | gawk -M -v _funcs='%s' '"
> > > +			"BEGIN { split(_funcs, funcs); }"
> > > +			"/^$/ { func_match = 0; }"
> > > +			"/<.*>:/ { "
> > > +				"f = gensub(/.*<(.*)>:/, \"\\\\1\", 1);"
> > > +				"for (i in funcs) {"
> > > +					"if (funcs[i] == f) {"
> > > +						"func_match = 1;"
> > > +						"base = strtonum(\"0x\" $1);"
> > > +						"break;"
> > > +					"}"
> > > +				"}"
> > > +			"}"
> > > +			"{"
> > > +				"if (func_match) {"
> > > +					"addr = strtonum(\"0x\" $1);"
> > > +					"printf(\"%%04x \", addr - base);"
> > > +					"print;"
> > > +				"}"
> > > +			"}' 1>&2";
> > 
> > Do we want to have scripts/objdump-func.awk and use that to avoid the
> > duplication and eventual divergence of these awk thingies?
> 
> I vote for that as well. To keep everything in sync can be a nightmare.

Reasons I did it this way for v2:

1) The awk implementation is slightly different (this one doesn't match
   *.cold, etc)

2) Objtool is self-sufficient (doesn't need any other files)

3) Any changes to the objdump-func interface might break objtool

4) It's clearly bug-free and self-contained and I don't expect the code
   to change much in the future

-- 
Josh
