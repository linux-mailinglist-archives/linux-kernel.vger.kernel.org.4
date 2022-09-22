Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8655E7044
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 01:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiIVXnt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 22 Sep 2022 19:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIVXnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 19:43:47 -0400
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB3BF3F85
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 16:43:46 -0700 (PDT)
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay06.hostedemail.com (Postfix) with ESMTP id F376DAB95B;
        Thu, 22 Sep 2022 23:43:44 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf03.hostedemail.com (Postfix) with ESMTPA id 843E16000D;
        Thu, 22 Sep 2022 23:43:43 +0000 (UTC)
Message-ID: <8d657bcf45b23dc634e8c6fc693c166360e6539e.camel@perches.com>
Subject: Re: [PATCH] get_maintainer: Gracefully handle files with authors
 but no signers
From:   Joe Perches <joe@perches.com>
To:     David Matlack <dmatlack@google.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Thu, 22 Sep 2022 16:43:42 -0700
In-Reply-To: <20220922230114.3556322-1-dmatlack@google.com>
References: <20220922230114.3556322-1-dmatlack@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 843E16000D
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Stat-Signature: gfinwzqc7ywnpfrput75684i5695qy77
X-Rspamd-Server: rspamout02
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+xrUJJqINxFge6EflARit7FT55Z7gRvy8=
X-HE-Tag: 1663890223-62242
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-09-22 at 16:01 -0700, David Matlack wrote:
> Gracefully handle the case where a file has no signers (e.g. has not
> been modified within the last year) but does have authors (e.g. because
> there are local commits that modifies the file without Signed-off-by
> tags). This scenario could happen for developers whose workflow is to
> add Signed-off-by tags as part of git-format-patch rather than as part
> of git-commit.

I think that's a poor process.

> Today this scenario results in the following non-sensical output from
> get_maintainer.pl:
> 
>   Bad divisor in main::vcs_assign: 0
>   "GitAuthor: David Matlack" <dmatlack@google.com> (authored:1/1=100%,added_lines:9/9=100%,removed_lines:3/3=100%)

Interesting...

> There are two issues with this output: the "Bad divisor" error and the
> garbled author name. Both stem from this line in vcs_find_signers():
> 
>   return (0, \@signatures, \@authors, \@stats) if !@signatures;
[]
> Returning 0 for the number of commits and a non-empty list for the
> authors results in the "Bad divisor". The garbled author name comes from
> the fact that @authors is the raw, unparsed, output line from git-log.
> Code later in vcs_find_signers() actually parses out the name and drops
> the "GitAuthor: " prefix.
> 
> Fix this by returning an empty list instead of @authors and @stats to
> make them coherent with the fact that commits is 0.
[]
> diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
[]
> @@ -1605,7 +1605,7 @@ sub vcs_find_signers {
>  
>  #    print("stats: <@stats>\n");
>  
> -    return (0, \@signatures, \@authors, \@stats) if !@signatures;
> +    return (0, (), (), ()) if !@signatures;

There's probably some better mechanism, not sure what it is though
as I don't have equivalent commits in the actual tree.

And I think you need \() and not () as what's returned is a reference
to an array and not an array or maybe use undef.

>      save_commits_by_author(@lines) if ($interactive);
>      save_commits_by_signer(@lines) if ($interactive);

