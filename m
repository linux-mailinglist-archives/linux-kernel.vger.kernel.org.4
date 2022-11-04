Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0346194DE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 11:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbiKDKyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 06:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbiKDKyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 06:54:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41AC52BB21;
        Fri,  4 Nov 2022 03:54:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D10F462152;
        Fri,  4 Nov 2022 10:54:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30BA6C433C1;
        Fri,  4 Nov 2022 10:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667559246;
        bh=pvwG3Gm3N2eUyHgbPambsEuPVQ8R8/OOOxapou4YcUQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cbBnPnYUkVl8HlirmjDewnnffVKehLHqlm1obIGLgPClQn+N8qpt6kVVeRv7jmkO8
         pE7BDnwwVWraetTc50i8EYFTEP+BRLKvWFpiyw2Gs+LrYi2/9fCOWz7XWJBfFy+t+N
         VUPPPDL7PDYnompJUihMxfpqHpM5QT45oSZ5IzRkkx4uYzpbz7+Gv+BVjPcpGO6D0h
         EHGkwdAYVKkDvz+n0VT5S1PBTfxDR9q6nxMI2WHO3D8zYILp8VLd98rqj+kPqOMjW/
         q1XTDuI5pJ+IMVj8PdQoZ6+dd96tvrhGWkjqbmv2oVa552CjRmOl1p1ptyfl2jnXxh
         uWarmbCkIf6hg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oquKZ-0001I6-77; Fri, 04 Nov 2022 11:53:47 +0100
Date:   Fri, 4 Nov 2022 11:53:47 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, patches@lists.linux.dev,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH] clk: qcom: gdsc: Remove direct runtime PM calls
Message-ID: <Y2TvO875fYZTTNy9@hovoldconsulting.com>
References: <20221101233421.997149-1-swboyd@chromium.org>
 <Y2JL9/HFrb3E+CYY@hovoldconsulting.com>
 <CAE-0n51Wuc6gVmsTOu4Nf4yx+6Wp-Oi3XZy06syhCMVmePWPEw@mail.gmail.com>
 <Y2PAXX2oYL6iFTlB@hovoldconsulting.com>
 <CAE-0n5319JSX16Z3H5vKQSL9UDetOdfb38zo_vp0C=uX1jddWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE-0n5319JSX16Z3H5vKQSL9UDetOdfb38zo_vp0C=uX1jddWQ@mail.gmail.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 11:19:08AM -0700, Stephen Boyd wrote:
> Quoting Johan Hovold (2022-11-03 06:21:33)
> > On Wed, Nov 02, 2022 at 09:53:49AM -0700, Stephen Boyd wrote:
> > > Quoting Johan Hovold (2022-11-02 03:52:39)
> >
> > > > > Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > > Cc: Johan Hovold <johan+linaro@kernel.org>
> > > > > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > > > > Cc: Taniya Das <quic_tdas@quicinc.com>
> > > > > Cc: Satya Priya <quic_c_skakit@quicinc.com>
> > > > > Cc: Douglas Anderson <dianders@chromium.org>
> > > > > Cc: Matthias Kaehlcke <mka@chromium.org>
> > > > > Reported-by: Stephen Boyd <swboyd@chromium.org>
> > > >
> > > > We typically don't add Reported-by tags for bugs we find and fix
> > > > ourselves.
> > >
> > > Heh, I didn't see anything like that in Documentation/ so it seems fine.
> > > I debugged my problem and reported it.
> >
> > I'd say the documentation is pretty clear on this matter:
> >
> >   Reported-by: names a user who reported a problem which is fixed by this
> >   patch; this tag is used to give credit to the (often underappreciated)
> >   people who test our code and let us know when things do not work
> >   correctly.
> >
> >   - Documentation/process/5.Posting.rst
> >
> >   The Reported-by tag gives credit to people who find bugs and report
> >   them and it hopefully inspires them to help us again in the future.
> >   Please note that if the bug was reported in private, then ask for
> >   permission first before using the Reported-by tag.
> >
> >   - Documentation/process/submitting-patches.rst
> 
> I don't see anything above that says I can't add this tag if I reported
> (by sending an email about the problem to the list), debugged, and
> solved the problem by sending a patch.

We don't try to prevent every strange interpretation of our docs by
spelling everything out. Just look at why we added a tag in the first
place and how it *is* being using.
 
> > Just like you don't add a Tested-by tag for every patch you submit, it
> > is implied that you found the issue you fix unless you explicitly
> > attribute that to a third party using Reported-by.
> 
> I don't see how this is the same. It certainly is not explicit, as you
> say.

We added the Reported-by tag so that users reporting bugs would get some
credit and not just the person fixing the bug. Just as we did for
Tested-by.

If some author added a Tested-by tag for themselves to their own patches
I'm sure you'd call that out too as that's not the way the tag is meant
to be used.

The reasoning is exactly the same for Reported-by.

> I wouldn't have added the tag if I didn't send an email to the list with
> the lockdep splat and follow that up with a bisection report for
> suspend/resume being broken. Shouldn't we value those sorts of bug
> report emails? I will add a link to the report in the commit text to
> clarify.

Ok, perhaps that would make this a bit more reasonable (Reported-by +
Link to report), but I still do not think the tag is warranted.

> > This is the first time I see anyone trying to use Reported-by this way,
> > and even if you think the documentation isn't clear enough on this, our
> > praxis is.
> >
> 
> Ok, so is it just a shock to see this for the first time? What is the
> problem with the tag? Can you elaborate on your concerns? I would like
> to understand.

It's apparently the first time you try to give credit to yourself for
finding a bug this way too, so let's turn that question around. Why do
you suddenly insist on crediting yourself this way when no one else does
so?

In the end it's about maintaining a common interpretation of these tags
and avoiding unnecessary noise. I'm sure no one wants to see a redundant
Tested-by tag on every commit nor a redundant Reported-by tag on every
bug fix for bugs that kernel developers find themselves. And if only
some people start using the tags this way it would also skew our
statistics (e.g. the LWN reports).

Johan
