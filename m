Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E70603942
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 07:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiJSFdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 01:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJSFdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 01:33:32 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025B973336
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 22:33:31 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-12c8312131fso19426855fac.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 22:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qMqM5geKQutqgXVVndbar/yZMqaBPuUDeVO1Kw96YAs=;
        b=kfyfCs9G7uLk0hlAo/EBvhJ4AaX33irvVzN95XDFPBKaPZHD5amSFpOgTpABjJF0Re
         KwhrYUGrVWopDd9rRrR09b+bGMSL3V9MoCv3XBZQlqEEO292f7sYaYJfax6oCKXBPTqQ
         jLaCzWpdkx8WPwLAIeUlHlQSsjXEFVBug9riU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qMqM5geKQutqgXVVndbar/yZMqaBPuUDeVO1Kw96YAs=;
        b=IaOz5ivtBvSRbuwn8h4Lpc/xUeK+f+Z56fLGxMNIWuaS8HqmTqnoJ6CMS8ExUecNc1
         MeNohXrProultIzb7N0rdFIFl4458bzCQpKYymr1jKvHTeFPzG7bV3sZkggkzd5HoESb
         A7QQLRARbMIZ4vSgbEBk74CPV7DmkWE7ItkXsZqALqPfup78kFbnPAKiKVjcTmckxX52
         klAaPI+7yux5leI/H3HJ7Sl88CNDhzvEAZ/HFLuqb8DlXLY1bGEvz8ke1WghoDEHpim3
         22z2sNX3YqpfJtb6IHp3P+O83dH3oWiSb5hKXFkQaYmqEU0I21J6Effc98F4MTuFqHEI
         zrTQ==
X-Gm-Message-State: ACrzQf0FjDQcZaJA59UNTXNOjnG3f1LYirafJO4eiq96fUqvsWHm3UfL
        iS1ikfJU0oyH35jjB9Azef/4k6uYILSdqg==
X-Google-Smtp-Source: AMsMyM7dvEABqdRMOswj0oG+vE3GeAfsBg5a93kLvKaqRVvDTbjVQ5rMXD1EqCn9H9FgdMCl+fr3KA==
X-Received: by 2002:a17:90b:4ac8:b0:20d:56c4:a892 with SMTP id mh8-20020a17090b4ac800b0020d56c4a892mr42084996pjb.19.1666157599452;
        Tue, 18 Oct 2022 22:33:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p184-20020a625bc1000000b005618189b0ffsm10312524pfb.104.2022.10.18.22.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 22:33:18 -0700 (PDT)
Date:   Tue, 18 Oct 2022 22:33:17 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joao Moreira <joao@overdrivepizza.com>
Cc:     David Laight <David.Laight@aculab.com>,
        'Peter Zijlstra' <peterz@infradead.org>, x86@kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/ibt: Implement FineIBT
Message-ID: <202210182232.FC83CB5@keescook>
References: <Y06rtoE9BsERG9uv@hirez.programming.kicks-ass.net>
 <9bb036e48580454b81e6de7224c5f006@AcuMS.aculab.com>
 <3edb387ea335085dcb6dd49f1d9c9ce6@overdrivepizza.com>
 <202210181013.923F8809@keescook>
 <24d4e2f277ecaa435075745817f2bd61@overdrivepizza.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24d4e2f277ecaa435075745817f2bd61@overdrivepizza.com>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URI_DOTEDU autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 01:09:25PM -0700, Joao Moreira wrote:
> On 2022-10-18 10:20, Kees Cook wrote:
> > On Tue, Oct 18, 2022 at 08:58:24AM -0700, Joao Moreira wrote:
> > > > Does the hash value for kCFI only depend on the function type?
> > > > Or is there something like a attribute that can also be included?
> > > 
> > > Hi David -- does this sound like what you are asking about?
> > > 
> > > https://github.com/ClangBuiltLinux/linux/issues/1736
> > > 
> > > If yes, then it is something in our todo list :) I think Sami is
> > > handling
> > > it.
> > 
> > I was hoping someone with prior experience with Call Graph Detaching to
> > solve Transitive Clustering Relaxation[1] could assist? ;)
> 
> Hi Kees, thanks for bringing these slides up.
> 
> Yeah, I would be glad to help out with automating this sort of analysis.
> CGD, as explained in these slides would not help much here, because it was
> more of an optimization to reduce the number of allowed targets on returns
> (we did not have an almighty shadow stack at the time). Yet there are lots
> of other things we might be able to do, both statically and dynamically.
> Recent relevant research about this is multi-layer type analysis [1], which
> I may find the time to look into more deeply soon.
> 
> 1 - https://www-users.cse.umn.edu/~kjlu/papers/mlta.pdf

Awesome! Yeah, getting the big "common" hashes broken up by separate
clusters would be lovely.

-- 
Kees Cook
