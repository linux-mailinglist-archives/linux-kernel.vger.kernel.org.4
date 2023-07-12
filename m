Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C4C750C27
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbjGLPRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233533AbjGLPRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:17:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7501733;
        Wed, 12 Jul 2023 08:16:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A97E6186A;
        Wed, 12 Jul 2023 15:16:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05DA4C433C9;
        Wed, 12 Jul 2023 15:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689175014;
        bh=tzjc3WfEvOWzGgi581kQfYcjNZdW4MPFLm5lMgb9iK8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gfO5cXA1MbBH9ib0CuSl0nAkoPIky1l3sXwTGOQRcbavPtBfzmX5wXTINYi9By1CQ
         LLjYH5BD5pNgnjuhmwAw0YgAL3yrRt0Yap0FX8jnRDwCuPYSCs8LcRgAMOiLrHa2FU
         /5Zy+B88rsy/BdRMH6+eoEZmnl4lfKIJhzOSvKOA=
Date:   Wed, 12 Jul 2023 17:16:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     stable@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [RFC PATCH v1 0/3] docs: stable-kernel-rules: add delayed
 backporting option and a few tweaks
Message-ID: <2023071221-blade-reactive-0707@gregkh>
References: <cover.1689008220.git.linux@leemhuis.info>
 <2023071002-phrasing-tranquil-49d6@gregkh>
 <a97a37bf-86b5-cd8e-a8ce-00e38720cee4@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a97a37bf-86b5-cd8e-a8ce-00e38720cee4@leemhuis.info>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 11:30:30AM +0200, Thorsten Leemhuis wrote:
> On 10.07.23 21:51, Greg KH wrote:
> > On Mon, Jul 10, 2023 at 07:10:10PM +0200, Thorsten Leemhuis wrote:
> >> This is a RFC and a bit rough for now. I only set down to create the
> >> first of the three patches. But while doing so I noticed a few things
> >> that seemed odd for me with my background on writing and editing texts.
> >> So I just quickly performed a few additional changes to fix those to see
> >> if the stable team would appreciate them, as this document is clearly
> >> their domain.
> >>
> >> If those changes or even the initial patch are not welcomed, I'll simply
> >> drop them. I'd totally understand this, as texts like these are delicate
> >> and it's easy to accidentlly change the intent or the meaning while
> >> adjusting things in good faith.
> >>
> >> At the same time I might be willing to do a few more changes, if people
> >> like the direction this takes and want a bit more fine tuning.
> > 
> > I do like it, many thanks for taking the time to do this work, it's much
> > appreciated.
> >
> > If you resend the first 2 as a non-RFC patch, 
> 
> BTW: thx again for your uplifting feedback! And in case anyone missed
> it, I send those two patches out yesterday here:
> https://lore.kernel.org/all/cover.1689056247.git.linux@leemhuis.info/
> 
> > the last one needs some more work as mentioned.
> 
> I have that one in a separate branch now and spitted into four patches;
> the first three basically move text around, which results in a much
> cleaner diff for the last patch that contains actual content changes.
> While working on the latter I noticed one more thing:
> 
> ```
>     .. warning::
>        The -stable-rc tree is a snapshot in time of the stable-queue
> tree and
>        will change frequently, hence will be rebased often. It should
> only be
>        used for testing purposes (e.g. to be consumed by CI systems).
> ```
> 
> That sounded a bit odd to me, as it will scare people away that want to
> test stable -rc's using git;

They are only there for people who _DO_ want to test stable -rc's using
git.

> and I think it doesn't match current practices.

No, it's pretty correct, what does not match?  It gets rebased all the
time.

> I'll thus likely
> change the text to something like this,
> unless I'm missing something or someone has a better idea:
> ```
>   .. warning::
>      The branches in the -stable-rc tree are rebased each time a new -rc
>      is released, as they are created by taking the latest release and
>      applying the patches from the stable-queue on top.

Yes, that is true, but they are also rebased sometimes in intermediate
places, before a -rc is released, just to give CI systems a chance to
test easier.

These are ONLY for CI systems to use, nothing else should be touching
them.  So I think the current text is correct, what am I missing?

thanks,

greg k-h
