Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1FF766071A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 20:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbjAFT0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 14:26:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235500AbjAFTZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 14:25:46 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D824F131
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 11:25:44 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id o8-20020a17090a9f8800b00223de0364beso6134572pjp.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 11:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uxQq5OsPBQFav8FuAajxIExQ+FkVdz7c0EkTv5l/tRI=;
        b=LBNZFQBWQjoz3m56JhOuWZSRkZ6sIJyW0+zkls88KNVqx6ueQlB1fEgi//LPGqbeFu
         3uzdbxVriLfz6MURcwOgECHpl5gtBtkGKFfV4FAMveAObnIJwuMgM7tdFFtOQDp1nIsc
         tg6qNQRddwXCNeg7f6GFTM5Fd4jGQ4XejdT0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uxQq5OsPBQFav8FuAajxIExQ+FkVdz7c0EkTv5l/tRI=;
        b=cf6M0XP2YhXb7dzk3QTN/lp71NfwkamD/0Q3MDjt9znxspQDPMvs8FmxXdyLqCrp0Z
         yZ06pDJ7DLnvP3726vyEDk5mU58U2KulHv4h3swr0w1On174btJztxVDUpJEs6AEWqWJ
         2KFYpqSgMoua+eLUtZFSRjsymZPGX7O79bseEC6wkc/KmOoOOLGdeFpPca1pJj30CgS+
         N51oSQp84VyBmXJQl3AqTaZb4WaYh6ckcLd9BF9cBH9feIXnzrMcFya+jLOGC61bzubf
         Z2V3CemIJsP8FoicHwSBIZSaJvxjson0iBdiE0gNW7LBwG65ndQV5XH5vHHwzoIaYUOx
         +JJQ==
X-Gm-Message-State: AFqh2kqWQkzpFMg6OBy5tMnyA/jW9ds+Grn3evLRYWyXm5V6ukDzM4H7
        qOORc1VMLJljTglrigCTLnI1xA==
X-Google-Smtp-Source: AMrXdXtejaeCic0Krve8ArpgewZ5oAi0jUSsD4lK/sgmiHZFOc1fwcfCY/4tcCRMstxIA2T2/7YxDw==
X-Received: by 2002:a05:6a21:999c:b0:ac:6d11:1ec7 with SMTP id ve28-20020a056a21999c00b000ac6d111ec7mr86001378pzb.17.1673033143884;
        Fri, 06 Jan 2023 11:25:43 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:bc4e:2cc9:68b3:15dc])
        by smtp.gmail.com with ESMTPSA id 22-20020a621816000000b00577c5915138sm1442698pfy.128.2023.01.06.11.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 11:25:43 -0800 (PST)
Date:   Fri, 6 Jan 2023 11:25:41 -0800
From:   Brian Norris <briannorris@chromium.org>
To:     Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        Sean Paul <seanpaul@chromium.org>,
        Michel =?iso-8859-1?Q?D=E4nzer?= <michel.daenzer@mailbox.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Sandy Huang <hjc@rock-chips.com>,
        linux-rockchip@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/atomic: Allow vblank-enabled + self-refresh
 "disable"
Message-ID: <Y7h1tVRI8qsBK9D8@google.com>
References: <20230105174001.1.I3904f697863649eb1be540ecca147a66e42bfad7@changeid>
 <Y7hgLUXOrD7QwKs1@phenom.ffwll.local>
 <Y7hjte/w8yP2TPlB@google.com>
 <Y7hmeBBRqgnwQ2O6@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7hmeBBRqgnwQ2O6@phenom.ffwll.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2023 at 07:20:40PM +0100, Daniel Vetter wrote:
> On Fri, Jan 06, 2023 at 10:08:53AM -0800, Brian Norris wrote:
> > OK! Then that sounds like it at least ACKs my general idea for this
> > series. (Michel and I poked at a few ideas in the thread at [1] and
> > landed on approx. this solution, or else a fake/timer like you suggest.)
> 
> Yeah once I stopped looking at this the wrong way round it does make sense
> what you're doing. See my other reply, I think with just this series here
> the vblanks still stall out? Or does your hw actually keep generating
> vblank irq with the display off?

I might not be understanding all of the IGT tests that I've run through,
but the display is not actually off -- it's sitting on a still frame.
But yes, IRQs still come, and I see no hangs.

This is also ref'd in patch 2:

  bed030a49f3e drm/rockchip: Don't fully disable vop on self refresh

So, we're not even doing that much to power-down the CRTC/VOP. That's
probably why IRQs are still active, contrary to your expectation?

NB: this is how Rockchip Chromebooks implemented PSR from essentially
day 1.

> > On Fri, Jan 06, 2023 at 06:53:49PM +0100, Daniel Vetter wrote:
> > > We might need a few more helpers. Also, probably more igt, or is this
> > > something igt testing has uncovered? If so, please cite the igt testcase
> > > which hits this.
> > 
> > The current patch only fixes a warning that comes when I try to do the
> > second patch. The second patch is a direct product of an IGT test
> > failure (a few of kms_vblank's subtests), and I linked [1] the KernelCI
> > report there.
> 
> Ah yeah that makes sense. Would be good to cite that in this patch too,
> because I guess the same kms_vblank tests can also hit this warning here?

Well, before this series: no, those tests don't hit this warning. The
warning is only uncovered after patch 2. If I do just patch 2, it's
super-trivial to hit the warning. You just have to turn the display on
and go idle long enough for PSR to activate once. I suppose that can
count as "caught by a test", with a little stretch of the imagination.

At any rate, I'll improve this description to refer precisely to the
"next patch" (as Greg suggested already), and that might involve
describing this test case a little.

Brian
