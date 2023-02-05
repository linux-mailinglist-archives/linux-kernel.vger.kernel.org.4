Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081AD68B177
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 21:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjBEUIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 15:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBEUIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 15:08:16 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A9F1B578;
        Sun,  5 Feb 2023 12:08:14 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id m2so28805945ejb.8;
        Sun, 05 Feb 2023 12:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GsVLR2sf69c/CgAcTxB0nwg0BCA+KrQO7cMi7O1TpOc=;
        b=kdPtnC3Nm67ra02E0FY/apPVAsDq5FvlRQibSmmWtlSnL7cLhnZdrYa0uDk+SRtXnF
         A9H+k+97bnIMAwfvANMRDOAnSJxF2Krs3F6gxwnUG49qNKyUMtRVxZO2j1G5/4gu61Ya
         FyMPx1a+EkDJRTBFFjMZiS7PHCmhqMPUKpOPv3NrX5NvGtpzEB8NMXrM5ywF596fwrdz
         tTsAy8UUh7JqA8TzTktMRMjAiwjxuvhPWxHI9rt5fdmU9aF1GK9yAvO1MFrt+LYQ+opq
         PBowQ+TsC7OcYtBTLK5xF0qn/sRMC+Zof/PbAS/7x64SA54x+FTLtcEJIVPfKGJR+Dwj
         9AVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GsVLR2sf69c/CgAcTxB0nwg0BCA+KrQO7cMi7O1TpOc=;
        b=sV+wObCo1dWW1Sv9L6WHtM8NOfVOzgMwiekKxaEId+ikXKN90KhrJwrhYOu6Yk2wJz
         gukMVdqiK38bmBvlErikgMN/a3CuoJvp2p2hk3Fotl1dbH/qBkRAi2IFFyFryvAXYz8v
         kmE5ZDjv1qkCBOTRElS5qofq5OceYSYyxr9LlIQNZUA6ZPGftUZ7YLoXYq/p6LcWWdij
         xQoIi57cax85aOTqETfwWTQIl9RfFtUg0tWsFJv3WtU09WWbjRmfGq+NAeb7uVnkCk+5
         JwZQF0qKmxANB2CgOuga1l16Afpn9BKHOWN0jdwBEMs0AAJqm3fz6O2kUyFh0vtd9X4m
         8nEA==
X-Gm-Message-State: AO0yUKXo6A777zTGs3DjmKxzSsz/tdBOr/RHycR9BJSXx7JCgQsPiRhW
        +fm300vQX9IBlmoedXswf5NwrHEiay3DOpz8ikhU52pMq8I=
X-Google-Smtp-Source: AK7set+VcMDxX4TIo7IIQRR6wEoDguvHUogqbf+9V7cPTapAP9TPYeYfC5TT4FFqKE5b8/F1NSfghiFWTd0Ta3dZvBY=
X-Received: by 2002:a17:907:9916:b0:886:2823:423e with SMTP id
 ka22-20020a170907991600b008862823423emr4900277ejc.284.1675627692933; Sun, 05
 Feb 2023 12:08:12 -0800 (PST)
MIME-Version: 1.0
References: <20230109223110.1165433-1-martin.blumenstingl@googlemail.com> <87lemai74d.fsf@intel.com>
In-Reply-To: <87lemai74d.fsf@intel.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 5 Feb 2023 21:08:02 +0100
Message-ID: <CAFBinCCObycVBfN0SjkYLo9BKYWGXxW6ErLoshjASNjR5-iqkQ@mail.gmail.com>
Subject: Re: [PATCH v1 RFC] video/hdmi: Fix HDMI_VENDOR_INFOFRAME_SIZE
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        ville.syrjala@linux.intel.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Bernard Zhao <bernard@vivo.com>, Helge Deller <deller@gmx.de>,
        linux-kernel@vger.kernel.org, Hans Verkuil <hans.verkuil@cisco.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jani, Hello Ville,

On Tue, Jan 10, 2023 at 7:20 PM Jani Nikula <jani.nikula@linux.intel.com> wrote:
[...]
> > I'm not an expert on this topic and I'm not sure if the size still
> > depends on that if condition from long time ago. So please share your
> > thoughts.
>
> I tried to look at this quickly, but it makes my brain hurt. I don't
> think simply changing the size here is right either.
I think I see what you're saying here: hdmi_vendor_infoframe_length()
has logic to determine the "correct" size.

My idea here is to use the maximum possible size for
HDMI_VENDOR_INFOFRAME_SIZE so it can be used with the
HDMI_INFOFRAME_SIZE macro (just like the other _SIZE definitions right
above the vendor infoframe one).
If you have suggestions on my patch then please let me know.


Best regards,
Martin
