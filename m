Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E0974DE6F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 21:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbjGJTpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 15:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjGJTo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 15:44:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19B7136;
        Mon, 10 Jul 2023 12:44:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F87D611C1;
        Mon, 10 Jul 2023 19:44:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44864C433C7;
        Mon, 10 Jul 2023 19:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689018297;
        bh=ttOOkMow6s5KQXXyJNxx7++0ck4gYOki33RKODm6OPQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pMJde2fKzaeFPPxTiCtWGyJ+yv4osynJ7SCoRwRBzMel+RGvrE5kRhd1FZ8dQkfPA
         brEN5NhjjJds87r2PKscHOy8af99IY/h2lgRmJaJoG5t9wEuJKoYHY6dyMRkXAvikD
         xYEA1w8n9qzk+hzN+KTIS2CISHbXobpurnqedvkQ=
Date:   Mon, 10 Jul 2023 21:44:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     stable@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [RFC PATCH v1 2/3] docs: stable-kernel-rules: make rule section
 more straight forward
Message-ID: <2023071017-ferocity-chooser-427b@gregkh>
References: <cover.1689008220.git.linux@leemhuis.info>
 <420fc78dd7f3cd537143ebdb25a51ea58d3f031d.1689008220.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <420fc78dd7f3cd537143ebdb25a51ea58d3f031d.1689008220.git.linux@leemhuis.info>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 07:10:12PM +0200, Thorsten Leemhuis wrote:
> Tweak some of the rule text to make things more straight forward, with
> the goal to stick closely to the intend of the old text:
> 
> * put the "it or equivalent fix must be ustream" rule at the top, as
>   it's one of the most important ones that at the same time often seems
>   to be missed by developers.
> * "It must fix only one thing" was dropped, as that is almost always a
>   thing that needs to be handled earlier when the change is mainlined.
>   Furthermore, this is already indirectly covered by the "Separate your
>   changes" section in Documentation/process/submitting-patches.rst which
>   the rules already point to.
> * six other rules are in the end one rule with clarifications; structure
>   the text accordingly to make it a lot easier to follow and understand
>   the intend.
> 
> CC: Greg KH <gregkh@linuxfoundation.org>
> CC: Sasha Levin <sashal@kernel.org>
> CC: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> ---
>  Documentation/process/stable-kernel-rules.rst | 39 +++++++++----------
>  1 file changed, 19 insertions(+), 20 deletions(-)
> 
> diff --git a/Documentation/process/stable-kernel-rules.rst b/Documentation/process/stable-kernel-rules.rst
> index 6e4026dd6882..85d5d2368034 100644
> --- a/Documentation/process/stable-kernel-rules.rst
> +++ b/Documentation/process/stable-kernel-rules.rst
> @@ -6,31 +6,30 @@ Everything you ever wanted to know about Linux -stable releases
>  Rules on what kind of patches are accepted, and which ones are not, into the
>  "-stable" tree:
>  
> + - It or an equivalent fix must already exist in Linus' tree (upstream).
>   - It must be obviously correct and tested.
>   - It cannot be bigger than 100 lines, with context.
> - - It must fix only one thing.
> - - It must fix a real bug that bothers people (not a, "This could be a
> -   problem..." type thing).
> - - It must fix a problem that causes a build error (but not for things
> -   marked CONFIG_BROKEN), an oops, a hang, data corruption, a real
> -   security issue, or some "oh, that's not good" issue.  In short, something
> -   critical.
> - - Serious issues as reported by a user of a distribution kernel may also
> -   be considered if they fix a notable performance or interactivity issue.
> -   As these fixes are not as obvious and have a higher risk of a subtle
> -   regression they should only be submitted by a distribution kernel
> -   maintainer and include an addendum linking to a bugzilla entry if it
> -   exists and additional information on the user-visible impact.
> - - New device IDs and quirks are also accepted.
> - - No "theoretical race condition" issues, unless an explanation of how the
> -   race can be exploited is also provided.
> - - It cannot contain any "trivial" fixes in it (spelling changes,
> -   whitespace cleanups, etc).
>   - It must follow the
>     :ref:`Documentation/process/submitting-patches.rst <submittingpatches>`
>     rules.
> - - It or an equivalent fix must already exist in Linus' tree (upstream).
> -
> + - It must either fix a real bug that bothers people or just add a device ID.
> +   To elaborate on the former:
> +
> +   - It fixes a problem like an oops, a hang, data corruption, a real security
> +     issue, a hardware quirk, a build error (but not for things marked
> +     CONFIG_BROKEN), or some "oh, that's not good" issue. In short, something
> +     critical.
> +   - Serious issues as reported by a user of a distribution kernel may also
> +     be considered if they fix a notable performance or interactivity issue.
> +     As these fixes are not as obvious and have a higher risk of a subtle
> +     regression they should only be submitted by a distribution kernel
> +     maintainer and include an addendum linking to a bugzilla entry if it
> +     exists and additional information on the user-visible impact.
> +   - No "This could be a problem..." type of things like a "theoretical race
> +     condition", unless an explanation of how the bug can be exploited is also
> +     provided.
> +   - No "trivial" fixes without benefit for users (spelling changes, whitespace
> +     cleanups, etc).
>  
>  Procedure for submitting patches to the -stable tree
>  ----------------------------------------------------

Ah, it's nice to see that mainline also enforces the "must do one
thing", I think when I originally wrote this, it didn't :)

Again, all looks great to me, I'll be glad to take it.

thanks,

greg k-h
