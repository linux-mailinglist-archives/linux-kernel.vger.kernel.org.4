Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22886E1096
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 17:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbjDMPFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 11:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjDMPFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 11:05:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3072F8A74
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 08:05:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0BCF63F65
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 15:05:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D9CC433EF;
        Thu, 13 Apr 2023 15:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681398318;
        bh=6KTrVSn/znOz9zCt4gAlEJAA5/QLW7OKTX3z2wZg0gs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VsjxHWvl61uq5o5o6iqrKj/TwFcloZIT2HSlazALpOVP2v3BYt196lGUGXH+CsvLI
         qtdwJAu2oKaE2gpwIJxh0gn3EP5TgYaNoln5dx6cYhdDaRvcZdzLuZwQ3nYKeu/Hd1
         FgGM0j+xmcS50rQxK8RpHodQrgdvUq6drCfg85iCiUGlcPNUY25G7qjdU4kLW12m6m
         gTKVkDTmAHWJPBxd8Mx/5mFuGhjfpxx7GgUoC8GnocJxtQ4bErnLrM4DYk4xkXtopJ
         YbaxMvwetM4JOLQTnbcvm+ZZB5Dli+nYSUl0eWoND8bQhM6VBRTwPOArgVIQBoO7Vt
         TwySrD02D6JRA==
Date:   Thu, 13 Apr 2023 08:05:16 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH v2 5/9] objtool: Add verbose option for disassembling
 affected functions
Message-ID: <20230413150516.obilsce2akxihri6@treble>
References: <cover.1681325924.git.jpoimboe@kernel.org>
 <4cadacc719db1e792c335309056960ca6f71139e.1681325924.git.jpoimboe@kernel.org>
 <20230413080527.GG4253@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230413080527.GG4253@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 10:05:27AM +0200, Peter Zijlstra wrote:
> > @@ -118,6 +119,10 @@ int cmd_parse_options(int argc, const char **argv, const char * const usage[])
> >  		parse_options(envc, envv, check_options, env_usage, 0);
> >  	}
> >  
> > +	env = getenv("OBJTOOL_VERBOSE");
> > +	if (env && !strcmp(env, "1"))
> > +		opts.verbose = true;
> > +
> >  	argc = parse_options(argc, argv, check_options, usage, 0);
> >  	if (argc != 1)
> >  		usage_with_options(usage, check_options);
> 
> No real objection; but I do feel obliged to point out that:
> OBJTOOL_ARGS="-v" achieves much the same.

But OBJTOOL_VERBOSE=1 just rolls off the fingers :-)

-- 
Josh
