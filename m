Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C37F60BDE6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 00:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbiJXWxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 18:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbiJXWw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:52:56 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB039E6A3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 14:14:49 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id z24so4370561ljn.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 14:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FXgFJbS2a63KBWIYrk1JkOqFCuXa2BXSDEikjukgc/I=;
        b=a23igI6xFUkOVmrwWcYqJt/zrTqVWiDSUSusTeW1jwopdesRRdT8n6XfnDDeDLn/AL
         Bs14Yi6j6xJlpkkbsvxdFjZGU0B4I9nGF5b+LNvwUuLMAz038OKN1V+NN/1Bn3TcRIXX
         z03BE1QBny7+Oz1nv/l/M4Iyn0MKVmnZQlFHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FXgFJbS2a63KBWIYrk1JkOqFCuXa2BXSDEikjukgc/I=;
        b=ntjPBKykXBP/vUxRRNUv8dHQH+vEY+nvOIRxSVakuUPV/FowJnB3P3hdxooebqUEcs
         eKIljPq5WSAVEfUbpVjQT1wX3ktZROA+jDTrHJ115fJ+gPfuZxfsCD4N1TvpnjgbRkah
         BOh4c9TqdiVhyu0+fxk8j3GXC7eiQq1m8oq+0Ba2sBUmLs42YDz3M+oUBC9Po6v/bHZN
         cQ1JoQFnZnMmv6/IjMBMD65CzgEN4ahpluyxUDB3xtPAU5TCCnUez2i8tRO4raIUXZUM
         F0aEj9myk08dzcNvX1z1X3WS1M1DJgAD5DWSNFhl01QzpRzOkjHqdVI2Is2S8S2miPmN
         unIQ==
X-Gm-Message-State: ACrzQf2CRbpe+oY4E8BHhLyaTHTOSrwWWr4M7KDeZ5mc3Aqyj8aAYLTu
        itq9wb/jBhLRS/FdceZt7LG/rBWzP9JwmuJP
X-Google-Smtp-Source: AMsMyM5PSA7KA78HTBkT1wdY3upxJabc1ITHYqO0DJQI8Lt+1njt2AHcFokpD5XFR9yDpwI55feSfA==
X-Received: by 2002:a17:907:2bf9:b0:7a4:bbce:dd98 with SMTP id gv57-20020a1709072bf900b007a4bbcedd98mr8913015ejc.669.1666643319517;
        Mon, 24 Oct 2022 13:28:39 -0700 (PDT)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id n3-20020a170906724300b007a7f9b6318asm346570ejk.50.2022.10.24.13.28.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 13:28:37 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id b20-20020a05600c4e1400b003cc28585e2fso3979201wmq.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 13:28:37 -0700 (PDT)
X-Received: by 2002:a05:600c:5493:b0:3c9:c18:87d5 with SMTP id
 iv19-20020a05600c549300b003c90c1887d5mr9525360wmb.188.1666643316677; Mon, 24
 Oct 2022 13:28:36 -0700 (PDT)
MIME-Version: 1.0
References: <20221021130637.1.I8c2de0954a4e54e0c59a72938268e2ead91daa98@changeid>
 <e6bc800b-2d3b-aac9-c1cb-7c08d618fc8e@quicinc.com>
In-Reply-To: <e6bc800b-2d3b-aac9-c1cb-7c08d618fc8e@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 24 Oct 2022 13:28:24 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V4m5HNavewSTkrh64_BzLAkivR2mRkTQdaxA8k9JKQbA@mail.gmail.com>
Message-ID: <CAD=FV=V4m5HNavewSTkrh64_BzLAkivR2mRkTQdaxA8k9JKQbA@mail.gmail.com>
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
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Oct 21, 2022 at 2:18 PM Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
> Hi Doug
>
> On 10/21/2022 1:07 PM, Douglas Anderson wrote:
> > If we fail to get a valid panel ID in drm_edid_get_panel_id() we'd
> > like to see the EDID that was read so we have a chance of
> > understanding what's wrong. There's already a function for that, so
> > let's call it in the error case.
> >
> > NOTE: edid_block_read() has a retry loop in it, so actually we'll only
> > print the block read back from the final attempt. This still seems
> > better than nothing.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
> Instead of checkinf for edid_block_status_valid() on the base_block, do
> you want to use drm_edid_block_valid() instead?
>
> That way you get the edid_block_dump() for free if it was invalid.

I can... ...but it feels a bit awkward and maybe not quite how the
functions were intended to work together?

One thing I notice is that if I call drm_edid_block_valid() I'm doing
a bunch of duplicate work that already happened in edid_block_read(),
which already calls edid_block_check() and handles fixing headers. I
guess also if I call drm_edid_block_valid() then I should ignore the
"status" return value of edid_block_read() because we don't need to
pass it anywhere (because the work is re-done in
drm_edid_block_valid()).

So I guess I'm happy to do a v2 like that if everyone likes it better,
but to me it feels a little weird.

-Doug
