Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8246E6DCF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 23:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbjDRVD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 17:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232773AbjDRVDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 17:03:25 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0E386B6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 14:03:23 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id z1so20271194qti.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 14:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1681851803; x=1684443803;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FNglwINUCAt3ccJJLEBkDRXVmh5q8gNpnI9SQ7Ogt5M=;
        b=RY9JXHbv9rd5w05TShsS2SJI+2H8HVRVwHe3oiSLlLehgGwOC8Zy4sgi43ailu9J0U
         LDxh6tNlr1l7dfdVd196B11QxWbTFSH0BWFwZU8paOlCPiVJYskmirZ0IPRm/2C9AXHA
         BF2Ms72rsrPnW4WjsIqt1vC0mfPJQZ/tXILUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681851803; x=1684443803;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FNglwINUCAt3ccJJLEBkDRXVmh5q8gNpnI9SQ7Ogt5M=;
        b=H5psrnwrDj2CgTgsfqLA4fkUbVRxjF3tDCsf34yFQDOH6dR/PXpS4HpAAfplh7Nvn5
         H1QF0MBlPOzG6pVworM+5g8/7xLka8qXKFNrK/VlE2wyZHZdE6cyNOTQv3AfZUYamZ6p
         +DEmtp3Wf6w4l3FHDYmLtrpXMGPjrVs13V0zd3sV2A+OYTmcWyG+36mRJWHtJOzkJyfL
         VMaUm89lqv2GqWSrSKVhJxNynlgRSUksMPXpwNkYfA/w4uYkONxUaTkT8w3cyZ9dpS3g
         Bq1k/ujKgQCUEA2VUpdjiaaLqGPcDWIMdOOcOAQ/R2NschgU9aHix7vmwGLiU/S8hjSX
         U+UA==
X-Gm-Message-State: AAQBX9fdKAWuskEYt6csqbHBi8aS61krLMRMEm0sGDvJ58nMs8vO7qxA
        5nYHt193H6mofoDNTd7aEWOMuA==
X-Google-Smtp-Source: AKy350aiunplJiCaf2PviZ0YofiOv/IlFis7nCJ/CUiB4SbkEn25Zy6/Pnck783zpuJMk93zOa+1JQ==
X-Received: by 2002:a05:622a:108:b0:3e8:d461:fae3 with SMTP id u8-20020a05622a010800b003e8d461fae3mr2111387qtw.55.1681851802595;
        Tue, 18 Apr 2023 14:03:22 -0700 (PDT)
Received: from localhost (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id i1-20020ac813c1000000b003ef13aa5b0bsm2121861qtj.82.2023.04.18.14.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 14:03:22 -0700 (PDT)
Date:   Tue, 18 Apr 2023 21:03:21 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     rcu@vger.kernel.org, nathan@kernel.org, trix@redhat.com,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        paulmck@kernel.org
Subject: Re: clangd cannot handle tree_nocb.h
Message-ID: <20230418210321.GA3648938@google.com>
References: <20230414005309.GA2198310@google.com>
 <CAKwvOd=yQS+0oDC46Hc5D_V0JET8=xbQmAJrpBdg7c4i2EyqHg@mail.gmail.com>
 <20230418203611.GA3640630@google.com>
 <CAKwvOdnxCJo-FoPfcNw=SBum6yRXOY7_meT8T6gsjV3c3FFm5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdnxCJo-FoPfcNw=SBum6yRXOY7_meT8T6gsjV3c3FFm5A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On Tue, Apr 18, 2023 at 01:46:40PM -0700, Nick Desaulniers wrote:
> On Tue, Apr 18, 2023 at 1:36 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > On Fri, Apr 14, 2023 at 03:47:51PM -0700, Nick Desaulniers wrote:
> > > On Thu, Apr 13, 2023 at 5:53 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> > > >
> > > > Hello!
> > > >
> > > > I have been trying to get clangd working properly with tree_nocb.h. clangd
> > > > trips quite badly when trying to build tree_nocb.h to generate ASTs.
> > >
> > > Hi Joel,
> > > Thanks for the report.  What are you using clangd for? I'll bet
> > > something interesting.
> >
> > Thanks for the response and sorry for the late reply. I am at the OSPM
> > conference. I use vim and vscode with clangd. In vim, YCM uses it to
> > highlight compiler errors live while editing, I am pretty happy with it so
> > far and has been a huge time saver. Enough that now I want to use it for
> > everything...
> 
> Cool! I use vim, can you share more info about your set up for this?
> I'll have to try it.

This is how I installed YCM:

# Install YouCompleteMe for vim
# cd ~/.vim/bundle
# git clone https://github.com/Valloric/YouCompleteMe.git
# cd YouCompleteMe/
# git submodule update --init --recursive
# python3 install.py --clang-completer

Then install and run bear in the kernel sources to generate
compile_compands.json:
bear -- make -j99 CC=clang

However, there's also the script:
scripts/clang-tools/gen_compile_commands.py

This generates the .json from an existing build. Thank God because we can
probably make this generate better .json files which may make clangd better.

You don't need YCM to reproduce the issue though if you just use vscode with
the clangd plugin.

> > I first came across clangd when developing Chrome userspace code which is C++
> > :). In Chrome, ninja builds can be made to output compile_commands.json.
> > However, now I noticed the support in the kernel and was like, wow I need to
> > try it. Further, YCM seems to work much better with it than without :)
> >
> > > I've never used it myself, so I don't know where to even begin with
> > > how to reproduce the issue.
> >
> > Ah ok. :). When I ran get_maintainer on the script, your name popped up and
> > someone also suggested that you're the goto person for clang on the kernel
> > (which I kind of already knew ;)
> 
> You've cc'ed the right set of folks.  We might not have the expertise
> related to clangd specifically, but we can point you in the right
> direction.

Sure, thanks! And thanks for CC'ing the right folks.

> > > It might be worth filing a bug upstream at
> > > https://github.com/llvm/llvm-project/issues
> > > or internally under the component
> > > Language Platforms > C++ > Clang > Tools > Clangd
> > > with detailed steps to reproduce (and what the observed error actually
> > > is). Feel free to cc me, though I don't know the first thing about
> > > clangd.
> >
> > Ok I will consider doing this if needed. One thing I do observe is lack of
> > good support for header files and it is a known clangd issue [1].
> >
> > However, the fixes I was proposing can purely be done in the kernel itself
> > since all it'd require is generating compile_compands.json with the -D<macro>
> > and editing files to keep clangd happy. I guess one question is, how welcome
> > would such changes to header files be since they're for tooling and isn't
> > code that will be compiled outside of clangd.
> 
> Specifically your patch sites some log print that doesn't look
> indicative of a failure:
> https://github.com/llvm/llvm-project/blob/53430bfd5c9d0074dd6de06dccea366e1d40bce4/clang-tools-extra/clangd/TUScheduler.cpp#L903-L906
> so something else is going on here. Just trying to make sure we root cause this.
> 

Right, so clangd's log does not show failure, the failure is when it displays
in the code editor that your code has compiler errors when in fact it does
not.

So if you open up tree_nocb.h in vscode, for example, you'll see squiggles
saying 'undefined reference to rcu_data', etc. That makes clangd stop working
at the error. Sorry to not make the failure mode clear earlier.

thanks,

 - Joel

