Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB1B628BC9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 23:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237554AbiKNWIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 17:08:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236124AbiKNWIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 17:08:50 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B79C2DD0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 14:08:49 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id u24so19294612edd.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 14:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vpQRZasD08S0MdHsPNjjNIlKX5TcZpvFCg+B+5S/zTc=;
        b=hKwvXDDp7+qNTTZhoSLroEZ5voP47JmP6mDVejeUFiGATDc6RyTNyeTF+5tpYKn6nV
         FPVy3w+FLGGGqf8DJjbpBpP7f+EwoHZBuktWk5SqyaAE1LCB7iPDhoYWlJy5OZ07OJuS
         pA2g8vpJwF1OijAbAiaFHYvqme8FWe2NQBhDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vpQRZasD08S0MdHsPNjjNIlKX5TcZpvFCg+B+5S/zTc=;
        b=UmADhAI8rVViQhIk2B2NO30ApFh/FTKqL7CU1+woUNuIasWhkYkAMtiKLw/EAcpuW9
         hFTwgAngo8k+bIYCq6EmidSlaGuyVMr/ZrZFIlStMnSdDyAznpyJexDKmihYWU3IW24L
         nLc6VrnIKuJjjLglSIlQ4JoOv0eXDwnohrXR74eLwodZmEy9wrgDuFsUOjxcSsUYudCn
         NMy1NA5++z+4MlVxLNxShHSSO11QOt6Fw2e17y6UxzhcCs0nUp0uEsGGP9NCS1fJf4mH
         e+gmzHwdzDUQ6DWpfNUtqMTRTGMP1RGZiMcmhnFZRqEYyBnD+fUqEjfagMwgNvjd97Qg
         1oLw==
X-Gm-Message-State: ANoB5pkFH48RTedvnUdiZpT7fnX4xDHs1qcE5I+VHBsRiEq6V86urEkx
        0DoWq1JQJCx/mzCTZB4hdbzBCp/LZY0LnjuE
X-Google-Smtp-Source: AA0mqf5pVdWtk+CrJ1WhMMRwMAyKSGL/I41fqUTPQxKlWMz7IgA9XgRfNHA5lfrRqQLKpOZt0yn90g==
X-Received: by 2002:a05:6402:d68:b0:467:b88c:f3af with SMTP id ec40-20020a0564020d6800b00467b88cf3afmr6717233edb.24.1668463727507;
        Mon, 14 Nov 2022 14:08:47 -0800 (PST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id eo8-20020a056402530800b00458898fe90asm5350778edb.5.2022.11.14.14.08.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 14:08:46 -0800 (PST)
Received: by mail-wr1-f53.google.com with SMTP id k8so20960359wrh.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 14:08:44 -0800 (PST)
X-Received: by 2002:adf:f145:0:b0:236:5270:735e with SMTP id
 y5-20020adff145000000b002365270735emr8729407wro.659.1668463724464; Mon, 14
 Nov 2022 14:08:44 -0800 (PST)
MIME-Version: 1.0
References: <20221021130637.1.I8c2de0954a4e54e0c59a72938268e2ead91daa98@changeid>
 <e6bc800b-2d3b-aac9-c1cb-7c08d618fc8e@quicinc.com> <CAD=FV=V4m5HNavewSTkrh64_BzLAkivR2mRkTQdaxA8k9JKQbA@mail.gmail.com>
 <956de566-d60a-f257-edff-85a2eac06d99@quicinc.com> <CAD=FV=UUpR9Euq5r+MujO6BdTk2cnWe_0JTdcP_e5RP47apUcw@mail.gmail.com>
 <87iljh4zwr.fsf@intel.com>
In-Reply-To: <87iljh4zwr.fsf@intel.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 14 Nov 2022 14:08:30 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WPa+CayKowHBDTRZTgv9FtCZWUWiKv-UB7XmQ4D+9P7w@mail.gmail.com>
Message-ID: <CAD=FV=WPa+CayKowHBDTRZTgv9FtCZWUWiKv-UB7XmQ4D+9P7w@mail.gmail.com>
Subject: Re: [PATCH] drm/edid: Dump the EDID when drm_edid_get_panel_id() has
 an error
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Stephen Boyd <swboyd@chromium.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
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

On Mon, Nov 14, 2022 at 2:02 AM Jani Nikula <jani.nikula@linux.intel.com> wrote:
>
> On Fri, 11 Nov 2022, Doug Anderson <dianders@chromium.org> wrote:
> > Hi,
> >
> > On Tue, Oct 25, 2022 at 1:39 PM Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
> >>
> >> Hi Doug
> >>
> >> On 10/24/2022 1:28 PM, Doug Anderson wrote:
> >> > Hi,
> >> >
> >> > On Fri, Oct 21, 2022 at 2:18 PM Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
> >> >>
> >> >> Hi Doug
> >> >>
> >> >> On 10/21/2022 1:07 PM, Douglas Anderson wrote:
> >> >>> If we fail to get a valid panel ID in drm_edid_get_panel_id() we'd
> >> >>> like to see the EDID that was read so we have a chance of
> >> >>> understanding what's wrong. There's already a function for that, so
> >> >>> let's call it in the error case.
> >> >>>
> >> >>> NOTE: edid_block_read() has a retry loop in it, so actually we'll only
> >> >>> print the block read back from the final attempt. This still seems
> >> >>> better than nothing.
> >> >>>
> >> >>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> >> >>
> >> >> Instead of checkinf for edid_block_status_valid() on the base_block, do
> >> >> you want to use drm_edid_block_valid() instead?
> >> >>
> >> >> That way you get the edid_block_dump() for free if it was invalid.
> >> >
> >> > I can... ...but it feels a bit awkward and maybe not quite how the
> >> > functions were intended to work together?
> >> >
> >> > One thing I notice is that if I call drm_edid_block_valid() I'm doing
> >> > a bunch of duplicate work that already happened in edid_block_read(),
> >> > which already calls edid_block_check() and handles fixing headers. I
> >> > guess also if I call drm_edid_block_valid() then I should ignore the
> >> > "status" return value of edid_block_read() because we don't need to
> >> > pass it anywhere (because the work is re-done in
> >> > drm_edid_block_valid()).
> >> >
> >> > So I guess I'm happy to do a v2 like that if everyone likes it better,
> >> > but to me it feels a little weird.
> >> >
> >> > -Doug
> >>
> >> Alright, agreed. There is some duplication of code happening if we use
> >> drm_edid_block_valid(). I had suggested that because it has inherent
> >> support for dumping the bad EDID.
> >>
> >> In that case, this change LGTM, because in principle you are doing the
> >> same thing as _drm_do_get_edid() (with the only difference being here we
> >> read only the base block as opposed to the full EDID there).
> >>
> >> Hence,
> >>
> >> Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> >
> > I've given this patch a bunch of time because it wasn't urgent, but
> > seems like it could be about time to land. I'll plan to land it next
> > Monday or Tuesday unless anyone has any other comments.
>
> Ack, it's benign enough.

Thanks! Since you didn't write the above as an Acked-by tag I didn't
add it to the commit, but I went ahead and landed with Abhinav's tag.

69c7717c20cc drm/edid: Dump the EDID when drm_edid_get_panel_id() has an error

-Doug
