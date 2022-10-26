Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 279D660DF9A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 13:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbiJZLb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 07:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233520AbiJZLbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 07:31:40 -0400
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DD22F657;
        Wed, 26 Oct 2022 04:31:18 -0700 (PDT)
Received: by mail-qv1-f50.google.com with SMTP id h10so11124129qvq.7;
        Wed, 26 Oct 2022 04:31:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4lXeIi3V6G2qIfuxOA3yJ66Q9+63vtXP3m1JaxcoBmk=;
        b=M2RkvLROR5mf0ighu7xBVn6qBeFDtFiHc2lZ7z6kAb9PLb4VfqPiVczGNuPDuQP646
         dUx8cKLv+JkTQDmSfciVx7apLJnYtO1p3nlV3iR9Ov7o7TrUY6GAIe5ZVhxqBIF+FckF
         Vo8V8XSb9uw4dy8klCFTwIGpyY0iJlOAnMpxCuvfsi9ImP5H/fK0z+5NA/YPhbtH38fs
         +DyShxMZWE/ZIINDneiwUmwbnhfrAF9pTsAdIJ6nIPNEo+I2yKgGzRrWlzwcSCg32fTz
         4LVSymGu7LbBle9pKRpaet+B6xHtjzTqW4u1fUSdtAlabokbhmgm1GSs9Lh2+kTQlitd
         NGJw==
X-Gm-Message-State: ACrzQf3DIq6ckJQAwKfaYSlj4AbcTW5ysBfMm41ERxH2hdRN6s6wAyUi
        rsW2Zrwd5qdb/EySSDa5gCTHigUUwgxT7b+IHKROnWMZ
X-Google-Smtp-Source: AMsMyM4WWnC1I/x6wJ0ootrjhnh44sqQw07FWNHlm41P8JokJbh+ybTfDLAr7TN+AwysjDPatf0qhkYudhkeaX9RLMc=
X-Received: by 2002:ad4:596b:0:b0:4b1:ee66:1cb8 with SMTP id
 eq11-20020ad4596b000000b004b1ee661cb8mr36203074qvb.3.1666783877679; Wed, 26
 Oct 2022 04:31:17 -0700 (PDT)
MIME-Version: 1.0
References: <20221025123432.1227269-1-sudeep.holla@arm.com> <CAPDyKFoQCvga_gjsvHfi3W=zETX2J9c8SnXH5xD6QDaVQ_C8-Q@mail.gmail.com>
In-Reply-To: <CAPDyKFoQCvga_gjsvHfi3W=zETX2J9c8SnXH5xD6QDaVQ_C8-Q@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 26 Oct 2022 13:31:05 +0200
Message-ID: <CAJZ5v0hJxRiL03XDFpU8FuabsHn5i6JMksJ=dfj8B+Dm=s3LYA@mail.gmail.com>
Subject: Re: [PATCH] PM: domains: Fix handling of unavailable/disabled idle states
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     Amit Pundir <amit.pundir@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 2:59 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 25 Oct 2022 at 14:34, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > Platforms can provide the information about the availability of each
> > idle states via status flag. Platforms may have to disable one or more
> > idle states for various reasons like broken firmware or other unmet
> > dependencies.
> >
> > Fix handling of such unavailable/disabled idle states by ignoring them
> > while parsing the states.
> >
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Fixes: a3381e3a65cb ("PM / domains: Fix up domain-idle-states OF parsing")
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>
> I think this should be tagged for stable kernels too. Rafael, can you
> pick this up as a fix for v6.1rc[n]?
>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Applied as 6.1-rc material, thanks!

>
> > ---
> >  drivers/base/power/domain.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > Hi Ulf,
> >
> > As you already know, this change alone doesn't fix the issue reported here[1].
> > It also needs the fixes you have posted [2].
> >
> > Regards,
> > Sudeep
> >
> > [1] https://lore.kernel.org/all/20221018145348.4051809-1-amit.pundir@linaro.org
> > [2] https://lore.kernel.org/all/20221021151013.148457-1-ulf.hansson@linaro.org
>
> Well, I think it's better if we replace [1] with a patch that only
> disables the cluster idle state. In that case, it would be sufficient
> with $subject patch. In that case, we can just manage [2] separately.
>
> Amit, can you submit a new version and test it together with $subject patch?
>
> Kind regards
> Uffe
>
> >
> > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > index ead135c7044c..6471b559230e 100644
> > --- a/drivers/base/power/domain.c
> > +++ b/drivers/base/power/domain.c
> > @@ -2952,6 +2952,10 @@ static int genpd_iterate_idle_states(struct device_node *dn,
> >                 np = it.node;
> >                 if (!of_match_node(idle_state_match, np))
> >                         continue;
> > +
> > +               if (!of_device_is_available(np))
> > +                       continue;
> > +
> >                 if (states) {
> >                         ret = genpd_parse_state(&states[i], np);
> >                         if (ret) {
> > --
> > 2.38.1
> >
