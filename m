Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4976966E1BC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 16:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbjAQPK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 10:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233653AbjAQPKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 10:10:04 -0500
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4019940BE3;
        Tue, 17 Jan 2023 07:10:01 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id v6so45421835edd.6;
        Tue, 17 Jan 2023 07:10:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=joZxgCnGkvxp1Xb2Q/5fZ4MsMpLI6GFEvSnwU1Uy6Z4=;
        b=mvt7caDKRuA1j6+nVgMlZSZuzaoEAIzi9ll1CXAGT0zvozqjqpwBbH+qzryA1uoGVR
         +57XPxdL0jXxdnryy8Ec47nlLKCh5LiSyzh5sGCKNfceVaDMnw3Um7j+nqXB03rljOLl
         ayET3N8tIK1gcwwIZhmiAmgbWFprbLF9raSCm3Tb9Ue3fhWk0vwyzQLc5P0LYxeQ/f/V
         Lp5xWSw34TNTyAubs6VfzR3ZypE0yMx3VbGoEOq8IUc6Sq6JqvfQeylfwE7fRUbKY5iG
         gTd27LEsg+gy5bX7dbDg8dnfasV/aTNR09xJAqVPdiZO5mFxHejqCdga7JvuD5crBXQr
         ECqw==
X-Gm-Message-State: AFqh2kodHxOwxf36IPpPNB4hKO0zhiYvv4ND1H87g8A1Y+7NkLJ2iwf+
        k6HIuu2bkeZDOGppuSA+f/WkXt7nz9Z28KrgOX4=
X-Google-Smtp-Source: AMrXdXuQxImuyhNi68zfskM+pJ+qzv1BTz3x5hwfZ5P9iSMuZHtBFZmWuaPM9bNs3+2/y6j0aAG5vtdgoD48+lgwVtk=
X-Received: by 2002:aa7:c3cb:0:b0:499:c651:625d with SMTP id
 l11-20020aa7c3cb000000b00499c651625dmr388760edr.413.1673968199861; Tue, 17
 Jan 2023 07:09:59 -0800 (PST)
MIME-Version: 1.0
References: <20230117020742.2760307-1-srinivas.pandruvada@linux.intel.com>
 <20230117020742.2760307-3-srinivas.pandruvada@linux.intel.com>
 <c5167eb8-22d6-c230-5828-80e59154aeb0@linaro.org> <e4f08f6642939e9707ee6427affe3d4aca06410a.camel@linux.intel.com>
In-Reply-To: <e4f08f6642939e9707ee6427affe3d4aca06410a.camel@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 17 Jan 2023 16:09:48 +0100
Message-ID: <CAJZ5v0jzYbpeVxtuqMWUN+X-wwYtKYq=7Ky3jRnb_S6NZc1RVQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] powercap: idle_inject: Add update callback
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rui.zhang@intel.com, amitk@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 4:08 PM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Tue, 2023-01-17 at 12:13 +0100, Daniel Lezcano wrote:
> > On 17/01/2023 03:07, Srinivas Pandruvada wrote:
> >
> > [ ... ]
> >
> > > +struct idle_inject_device *idle_inject_register(struct cpumask
> > > *cpumask)
> > > +{
> > > +       return idle_inject_register_full(cpumask, NULL);
> > > +}
> > >   EXPORT_SYMBOL_NS_GPL(idle_inject_register, IDLE_INJECT);
> >
> > Why not just add the parameter to idle_inject_register() ?
> >
> > There is only one user ATM
> That was done in v1. But Rafael suggested to avoid changes to existing
> kernel source.

However, it can be done if Daniel prefers that.  It is 1 callback now
only, so no big deal I suppose.
