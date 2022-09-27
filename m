Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3455ECA3F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbiI0Q62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 12:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbiI0Q6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:58:11 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338D44D4F9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 09:58:08 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id p69so13046830yba.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 09:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=hhPOXB2wUeVzrfwDIvjzSR+8s1AqVlymI8mOISdLzEA=;
        b=Y6xHZxZgsxyrqP3X8kz+D8ze0RGAKFaf+lt0KNHOnSnydl+N90Lwbfn0pyB1sJuTHO
         ewXtDpnnYZqpcDT5ZvbwVFRl/WfOjRhfGzK+CPwaYBaCSSk48wXtC1XygXcZBBJ3MgSq
         IIl6pN2QONANpaX2DRCba8xFFcIn1RfiL08qzGDcCvnJg/w6hdZv9DSMuDLuQjLE4ErY
         AmisKSl9J4tUn7IOErfwPTOuRxlUN02jbTRIILRoWVxiS7ZAUh3aPnolwtUqYP5sN/R8
         w5hh0WD55XBV1VBLwrLCM4zR9Tg5+wj01h2PvWMF2NKrat7ve8CLTDxnaKz4OVxEg3C1
         vWPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=hhPOXB2wUeVzrfwDIvjzSR+8s1AqVlymI8mOISdLzEA=;
        b=tECOK88JTWcl90zBqPC6ufYzaR40l4Yv5XvPR06TglqQm8udX7JwwNwMfjE0ha4QPG
         +sXSlAhSMU6TEV/+IsQg1dzawkymrX05+E6bsbzqKh7/nJ8B58GoFB8qK+DW+yocWTsK
         rp5Y4GU1k1d2mfqRmLWAKs9MjmB2yMnKu5MyVOTnW4WHsAUjX8+/sw6IN5OCVB/mLIjW
         sYN6KDcRLxiaWNF45g6wE0hRfw2RaytSxtLhbwlXp/u84Urjqrcd8oAnU06L+/hGp9wA
         WapbsKvQhxOrHETIXkYRRPne6gi0oDHsL7/5b6G6QcwzY8SMF8AnARhKMZSKxZGlnfm2
         DASA==
X-Gm-Message-State: ACrzQf3R2PujpZvIrcU8WMdiyl2VdLGc2V/CiN6BWekV5RVWphkxxN8X
        rQ7YwjODEC08q92kF46zWQ5fD1oXf8N9Jv9ZtAmFI+Q787A=
X-Google-Smtp-Source: AMsMyM5o9Y1WlP4ufaXkQ6Fg40phomt1+mFOC8cncKiiBFcRtlkzsLAvxmELfCA4tfjDFN/LCaOoFUKFbUgIeej8c4A=
X-Received: by 2002:a25:e6d5:0:b0:6bc:8d4:d76f with SMTP id
 d204-20020a25e6d5000000b006bc08d4d76fmr5285690ybh.582.1664297887948; Tue, 27
 Sep 2022 09:58:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220922230114.3556322-1-dmatlack@google.com> <8d657bcf45b23dc634e8c6fc693c166360e6539e.camel@perches.com>
In-Reply-To: <8d657bcf45b23dc634e8c6fc693c166360e6539e.camel@perches.com>
From:   David Matlack <dmatlack@google.com>
Date:   Tue, 27 Sep 2022 09:57:42 -0700
Message-ID: <CALzav=fmkeE_QvasYTkzFrequ25ZVK97Um39JQc=s=xyoCnJtA@mail.gmail.com>
Subject: Re: [PATCH] get_maintainer: Gracefully handle files with authors but
 no signers
To:     Joe Perches <joe@perches.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 4:43 PM Joe Perches <joe@perches.com> wrote:
>
> On Thu, 2022-09-22 at 16:01 -0700, David Matlack wrote:
> > Gracefully handle the case where a file has no signers (e.g. has not
> > been modified within the last year) but does have authors (e.g. because
> > there are local commits that modifies the file without Signed-off-by
> > tags). This scenario could happen for developers whose workflow is to
> > add Signed-off-by tags as part of git-format-patch rather than as part
> > of git-commit.
>
> I think that's a poor process.

I don't disagree, and personally I have changed my own workflow to add
sign-offs at commit time.

>
> > Today this scenario results in the following non-sensical output from
> > get_maintainer.pl:
> >
> >   Bad divisor in main::vcs_assign: 0
> >   "GitAuthor: David Matlack" <dmatlack@google.com> (authored:1/1=100%,added_lines:9/9=100%,removed_lines:3/3=100%)
>
> Interesting...
>
> > There are two issues with this output: the "Bad divisor" error and the
> > garbled author name. Both stem from this line in vcs_find_signers():
> >
> >   return (0, \@signatures, \@authors, \@stats) if !@signatures;
> []
> > Returning 0 for the number of commits and a non-empty list for the
> > authors results in the "Bad divisor". The garbled author name comes from
> > the fact that @authors is the raw, unparsed, output line from git-log.
> > Code later in vcs_find_signers() actually parses out the name and drops
> > the "GitAuthor: " prefix.
> >
> > Fix this by returning an empty list instead of @authors and @stats to
> > make them coherent with the fact that commits is 0.
> []
> > diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
> []
> > @@ -1605,7 +1605,7 @@ sub vcs_find_signers {
> >
> >  #    print("stats: <@stats>\n");
> >
> > -    return (0, \@signatures, \@authors, \@stats) if !@signatures;
> > +    return (0, (), (), ()) if !@signatures;
>
> There's probably some better mechanism, not sure what it is though
> as I don't have equivalent commits in the actual tree.
>
> And I think you need \() and not () as what's returned is a reference
> to an array and not an array or maybe use undef.

Ack, will do in v2.

>
> >      save_commits_by_author(@lines) if ($interactive);
> >      save_commits_by_signer(@lines) if ($interactive);
>
