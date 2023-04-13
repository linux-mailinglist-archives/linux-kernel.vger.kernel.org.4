Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 652C16E0F82
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 16:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbjDMODV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 10:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjDMODR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 10:03:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95DD1FFC
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 07:03:09 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3F4A3218BB;
        Thu, 13 Apr 2023 14:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681394588; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gSysC1iAzrWGzyyRkvP7TdkdCMQSjDJKYzQiTnEL8xs=;
        b=hjNfDkxRnbjBXxB5yx1yncszZS0UOSfH47dmzy+BOfnnBCv0a2+yhyKO4q50oeefi1vk4i
        8+pVWIX1gkZ3wIYdH8QveEf16WkQHQDfwJ1rpdkX1i/GROWcGyHYTznWK+ga1qskni1KLd
        sQeC4kbZgL6nGWI34+4sXlNvHtfwRQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681394588;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gSysC1iAzrWGzyyRkvP7TdkdCMQSjDJKYzQiTnEL8xs=;
        b=VHD5w2E1hEmYe7reKXo10J3EZhVfFEeQLAOvUwCDniSAElGJMSJtAAA9uOVmiEwCv46wjR
        nYMCz+IA4FYSJ4Bg==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 22C1F2C143;
        Thu, 13 Apr 2023 14:03:07 +0000 (UTC)
Date:   Thu, 13 Apr 2023 16:03:07 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/9] objtool: Add verbose option for disassembling
 affected functions
In-Reply-To: <20230413080822.GH4253@hirez.programming.kicks-ass.net>
Message-ID: <alpine.LSU.2.21.2304131602150.27633@pobox.suse.cz>
References: <cover.1681325924.git.jpoimboe@kernel.org> <4cadacc719db1e792c335309056960ca6f71139e.1681325924.git.jpoimboe@kernel.org> <20230413080822.GH4253@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Apr 2023, Peter Zijlstra wrote:

> On Wed, Apr 12, 2023 at 12:03:20PM -0700, Josh Poimboeuf wrote:
> > +	objdump_str = "%sobjdump -wdr %s | gawk -M -v _funcs='%s' '"
> > +			"BEGIN { split(_funcs, funcs); }"
> > +			"/^$/ { func_match = 0; }"
> > +			"/<.*>:/ { "
> > +				"f = gensub(/.*<(.*)>:/, \"\\\\1\", 1);"
> > +				"for (i in funcs) {"
> > +					"if (funcs[i] == f) {"
> > +						"func_match = 1;"
> > +						"base = strtonum(\"0x\" $1);"
> > +						"break;"
> > +					"}"
> > +				"}"
> > +			"}"
> > +			"{"
> > +				"if (func_match) {"
> > +					"addr = strtonum(\"0x\" $1);"
> > +					"printf(\"%%04x \", addr - base);"
> > +					"print;"
> > +				"}"
> > +			"}' 1>&2";
> 
> Do we want to have scripts/objdump-func.awk and use that to avoid the
> duplication and eventual divergence of these awk thingies?

I vote for that as well. To keep everything in sync can be a nightmare.

Miroslav
