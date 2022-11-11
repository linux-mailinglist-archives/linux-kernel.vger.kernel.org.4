Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798C4626329
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 21:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234533AbiKKUqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 15:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234546AbiKKUqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 15:46:16 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8D186D4A
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 12:46:14 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id f5so15193058ejc.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 12:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I9Gsc4vAOXyP9hE0dy07upvJe/x2SdZ67s0li3UeIhg=;
        b=kneG+DA5pe4jdo30hl6hW2O1BMx7Y5I6sjTgS/cI1D5Sj66I+Vd9CMBuuJQo9znbkg
         +GIUPErJIfS7CFRyXdU9fmI0DgfS2JdhXiHrXowZWIgzS6dA2e5L+Dm3YEGX3tbTnk96
         T5KuKk04n75cpDT4R8X/t/WlB0uvIzCf7e5nU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I9Gsc4vAOXyP9hE0dy07upvJe/x2SdZ67s0li3UeIhg=;
        b=LPGfLSlBtrWXYR9oX5tzvJ79wWy1M5nyL3K6Xh6J7YheVrKAdYW228FPtOw/ZndYzB
         zrjmSnC9qn7Em+wp5thaIQyjSm1eM7nbVVxNTM1Kj7SHvpBq7uoL8hKogxqASQwghXzt
         nDNYcvwB1KTDq5ixU7TqhCmgEPcdw46M3nORt0dt6RLCcl2VDDomdzTRUpC27KA2dO9r
         8HKiEKBb/ss1of+VuFudP01foqhB/9gBIYkX9m5ZHpjuT0cSQ44kAwasc4py3KKsatyf
         o6PriQXKRZsDom5xAj6pH/Gs8joqmM8NU1QUmrD2yxckNYzpZy33vpp/xflvFCo9Lwfy
         te6w==
X-Gm-Message-State: ANoB5pnp583gMrYNbMk3KDJrYvSDcj7HO6kw6OTBLuAlehznWezvcR7v
        g/IBhjY8BHKeKloGGkmwLNApX+3YbY3vGhrs
X-Google-Smtp-Source: AA0mqf6G/5sXAgVnd/P4QKrlD05xwSqr3H31PcaToSpA3VENzc4Q4fEb76ZbT9natNQoLRzdSTH2Dg==
X-Received: by 2002:a17:906:b019:b0:78e:ebb:cbb7 with SMTP id v25-20020a170906b01900b0078e0ebbcbb7mr3363337ejy.38.1668199572381;
        Fri, 11 Nov 2022 12:46:12 -0800 (PST)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id n15-20020a17090695cf00b0078c213ad441sm1246708ejy.101.2022.11.11.12.46.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 12:46:11 -0800 (PST)
Received: by mail-wr1-f42.google.com with SMTP id z14so7865797wrn.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 12:46:10 -0800 (PST)
X-Received: by 2002:a5d:694c:0:b0:238:b29e:4919 with SMTP id
 r12-20020a5d694c000000b00238b29e4919mr2219053wrw.583.1668199570136; Fri, 11
 Nov 2022 12:46:10 -0800 (PST)
MIME-Version: 1.0
References: <20221021130637.1.I8c2de0954a4e54e0c59a72938268e2ead91daa98@changeid>
 <e6bc800b-2d3b-aac9-c1cb-7c08d618fc8e@quicinc.com> <CAD=FV=V4m5HNavewSTkrh64_BzLAkivR2mRkTQdaxA8k9JKQbA@mail.gmail.com>
 <956de566-d60a-f257-edff-85a2eac06d99@quicinc.com>
In-Reply-To: <956de566-d60a-f257-edff-85a2eac06d99@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 11 Nov 2022 12:45:58 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UUpR9Euq5r+MujO6BdTk2cnWe_0JTdcP_e5RP47apUcw@mail.gmail.com>
Message-ID: <CAD=FV=UUpR9Euq5r+MujO6BdTk2cnWe_0JTdcP_e5RP47apUcw@mail.gmail.com>
Subject: Re: [PATCH] drm/edid: Dump the EDID when drm_edid_get_panel_id() has
 an error
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 25, 2022 at 1:39 PM Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
> Hi Doug
>
> On 10/24/2022 1:28 PM, Doug Anderson wrote:
> > Hi,
> >
> > On Fri, Oct 21, 2022 at 2:18 PM Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
> >>
> >> Hi Doug
> >>
> >> On 10/21/2022 1:07 PM, Douglas Anderson wrote:
> >>> If we fail to get a valid panel ID in drm_edid_get_panel_id() we'd
> >>> like to see the EDID that was read so we have a chance of
> >>> understanding what's wrong. There's already a function for that, so
> >>> let's call it in the error case.
> >>>
> >>> NOTE: edid_block_read() has a retry loop in it, so actually we'll only
> >>> print the block read back from the final attempt. This still seems
> >>> better than nothing.
> >>>
> >>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> >>
> >> Instead of checkinf for edid_block_status_valid() on the base_block, do
> >> you want to use drm_edid_block_valid() instead?
> >>
> >> That way you get the edid_block_dump() for free if it was invalid.
> >
> > I can... ...but it feels a bit awkward and maybe not quite how the
> > functions were intended to work together?
> >
> > One thing I notice is that if I call drm_edid_block_valid() I'm doing
> > a bunch of duplicate work that already happened in edid_block_read(),
> > which already calls edid_block_check() and handles fixing headers. I
> > guess also if I call drm_edid_block_valid() then I should ignore the
> > "status" return value of edid_block_read() because we don't need to
> > pass it anywhere (because the work is re-done in
> > drm_edid_block_valid()).
> >
> > So I guess I'm happy to do a v2 like that if everyone likes it better,
> > but to me it feels a little weird.
> >
> > -Doug
>
> Alright, agreed. There is some duplication of code happening if we use
> drm_edid_block_valid(). I had suggested that because it has inherent
> support for dumping the bad EDID.
>
> In that case, this change LGTM, because in principle you are doing the
> same thing as _drm_do_get_edid() (with the only difference being here we
> read only the base block as opposed to the full EDID there).
>
> Hence,
>
> Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

I've given this patch a bunch of time because it wasn't urgent, but
seems like it could be about time to land. I'll plan to land it next
Monday or Tuesday unless anyone has any other comments.

Thanks!

-Doug
