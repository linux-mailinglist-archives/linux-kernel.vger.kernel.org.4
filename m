Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71BA6369A5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 20:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239791AbiKWTK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 14:10:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238974AbiKWTKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 14:10:54 -0500
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFC28FE64;
        Wed, 23 Nov 2022 11:10:53 -0800 (PST)
Received: by mail-qk1-f181.google.com with SMTP id x18so13143750qki.4;
        Wed, 23 Nov 2022 11:10:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NbSPkwnTrNcrJ9VpYRRJzoDHi8UiOrKZOPAZpU08zhM=;
        b=Ymvi1X6cNs04gk4izymUrzydXDcNkA+HQ7qapsnjWGbI9hNa49SkShAEBYJTWssBTf
         pB/cqXJ4Cg6k4rw52N3Uy286fMiXS5SQgAAh3tUgMLEOJl5y1s9HAS5YzTP/uLtG2nLq
         avlbVrPaQNUff5Q1MUB7cOYCY2QcwEQj+bH3OWekj1JvSCeWxplr5hMrJPUPfi3gw30A
         hen7FRynfyvoSWpovr2S2L4VlQiyrStNHwpQw7MFO2Pq3s5qdjsJkpTt2nnTi/wa5fdq
         wyTenk5PwUwEhw57vvysRXPDaJ+nGFunUTnFD7hXp1WvChBX9xSzXujQl8BzeMoWwXL1
         PKDg==
X-Gm-Message-State: ANoB5pnsVw9FfdM1NYUVxG3IsfwimbRDy3mYJ0Vm6Uvj6Qj3HYoKPOxS
        bi9IXFFdbjNE9bFLO6q4czTKm5PHqW94gAHkaEUiXeYRj+w=
X-Google-Smtp-Source: AA0mqf6fNv3a2I+13Tw+6GO9/D1Fg05iUWfCplG+Fb1qm7+WLi0e1o74TtCSLGatgMloBVykryvibeFXNLKgWVrW4Rw=
X-Received: by 2002:a05:620a:4611:b0:6fa:af7e:927c with SMTP id
 br17-20020a05620a461100b006faaf7e927cmr25906532qkb.443.1669230652623; Wed, 23
 Nov 2022 11:10:52 -0800 (PST)
MIME-Version: 1.0
References: <20221116025417.2590275-1-srinivas.pandruvada@linux.intel.com>
 <CAJZ5v0hQkZ=jprMc5MNaCudKNATtjs_5Z+N7+a7eeaXRjGpaDQ@mail.gmail.com>
 <4b168fc1cad6a57e0f20b9050c86174a57b34989.camel@linux.intel.com> <CAJZ5v0gD+d=9DhpjD80qJWkvp4pro3gqf2cFLEjsGk9jSx+XGQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0gD+d=9DhpjD80qJWkvp4pro3gqf2cFLEjsGk9jSx+XGQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 23 Nov 2022 20:10:41 +0100
Message-ID: <CAJZ5v0gDQ7JCrp_sim+SWqOcmiYxHWDgT-m772fMnhej0YTE1Q@mail.gmail.com>
Subject: Re: [PATCH RESEND 1/2] thermal: intel: Prevent accidental clearing of
 HFI status
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 8:49 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, Nov 18, 2022 at 8:38 PM srinivas pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> >
> > On Fri, 2022-11-18 at 18:54 +0100, Rafael J. Wysocki wrote:
> > > On Wed, Nov 16, 2022 at 3:54 AM Srinivas Pandruvada
> > > <srinivas.pandruvada@linux.intel.com> wrote:
> > > >
> > > > When there is a package thermal interrupt with PROCHOT log, it will
> > > > be
> > > > processed and cleared. It is possible that there is an active HFI
> > > > event
> > > > status, which is about to get processed or getting processed. While
> > > > clearing PROCHOT log bit, it will also clear HFI status bit. This
> > > > means
> > > > that hardware is free to update HFI memory.
> > > >
> > > > When clearing a package thermal interrupt, some processors will
> > > > generate
> > > > a "general protection fault" when any of the read only bit is set
> > > > to 1.
> > > > The driver maintains a mask of all read-write bits which can be
> > > > set.
> > > > This mask doesn't include HFI status bit. This bit will also be
> > > > cleared,
> > > > as it will be assumed read-only bit. So, add HFI status bit 26 to
> > > > the
> > > > mask.
> > > >
> > > > Signed-off-by: Srinivas Pandruvada
> > > > <srinivas.pandruvada@linux.intel.com>
> > > > Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > >
> > > Is a Fixes tag missing here?
> > While adding the following change, this should have been take care of:
> > ab09b0744a99 ("thermal: intel: hfi: Enable notification interrupt")
> >
> > But the above change didn't add this line, which this patch is
> > changing. We can add:
> >
> > Fixes: ab09b0744a99 ("thermal: intel: hfi: Enable notification
> > interrupt")
>
> OK
>
> > Do you want me to send another PATCH with fixes.
>
> No, I can take care of this.
>
> > >
> > > Also, do you want it in 6.1-rc7 or would 6.2 suffice?
> > Not urgent. 6.2 should be fine.
>
> OK, thanks!

Both applied as 6.2 material now, thanks!
