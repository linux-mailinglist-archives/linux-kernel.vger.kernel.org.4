Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBFAB675FB7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 22:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjATVo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 16:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjATVoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 16:44:55 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6869A7F99F
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 13:44:54 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id v5so8301794edc.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 13:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QV4xUlvMB6Ml94GZ/lP0/1VdW6RK6YzwPsgjf7qgrwQ=;
        b=iQKAwPM0wYaB3G+O8Te9N2aCGhjICMaONFSIIqU3GNAomdQFeJWurMMTzfF4cPpjkN
         gCEqSTdfz7V91sipjRt8u25nNnr9znfo/DMO+bqWJPz6uL2Yri0Hk7aCWzKVbS80I1xX
         Xw91bc8MXh+L6c8pABFFY0zhZoH4v4mz+KY+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QV4xUlvMB6Ml94GZ/lP0/1VdW6RK6YzwPsgjf7qgrwQ=;
        b=Bgs4tJzdzEGp3ZnjZJp75ZsDhiHUQ6QXr19wIRpnbvqgXdQePVlW+2Aac+RdvbIc15
         g69s0wuSE2kT8FYx6beh9jKgIvueDlgFJWXEG+j0gkWGYZgrhJqwSODBuMeEg8HCULHD
         TzSAtxkHD1HSIOJHiL0VEV92CvMdNeVXojnCdw9l8tvob76l/ClhCpAiPfT9Xw7Tvnz0
         M1QzmPQz8v9lTmBG24IcvrUDIyc5hlk4ZPEEPq0QLlxLc+3CWBhU8aYSRJ1yx1JhorIr
         27YkIp+79e84Cat6GuE5M0ni2tXr1LwUPt5aLXl6IKfEaTXErA0mEFgejOJ7Pui1zYRF
         x7Lw==
X-Gm-Message-State: AFqh2kpkxJWAPluQjUvMPw94/i3qFyAYwpp1EFdoOLhBHKlPD8SDYWCj
        JNmn4ndO59t0by3LzVMkZU8P2h2V/E3zRqMEA0U=
X-Google-Smtp-Source: AMrXdXtk1R2BAsDU1mycgIx1jfL94F/bpWrAyldc8L4L40E21uZ3x6PZ0KAjx4A07afqEcHfHhdScw==
X-Received: by 2002:aa7:d559:0:b0:492:bf3d:1a16 with SMTP id u25-20020aa7d559000000b00492bf3d1a16mr15827467edr.4.1674251092748;
        Fri, 20 Jan 2023 13:44:52 -0800 (PST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id b9-20020a1709063ca900b007c073be0127sm18325359ejh.202.2023.01.20.13.44.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 13:44:51 -0800 (PST)
Received: by mail-wr1-f54.google.com with SMTP id n7so5977776wrx.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 13:44:50 -0800 (PST)
X-Received: by 2002:a5d:5965:0:b0:2be:5047:d840 with SMTP id
 e37-20020a5d5965000000b002be5047d840mr183614wri.646.1674251090648; Fri, 20
 Jan 2023 13:44:50 -0800 (PST)
MIME-Version: 1.0
References: <20230120114313.2087015-1-john@metanate.com>
In-Reply-To: <20230120114313.2087015-1-john@metanate.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 20 Jan 2023 13:44:38 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UPD6c+NY8Ub37N7LmrRFpcr6gKOh0Os14DaKrf3bKo2A@mail.gmail.com>
Message-ID: <CAD=FV=UPD6c+NY8Ub37N7LmrRFpcr6gKOh0Os14DaKrf3bKo2A@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: panel: Set orientation on panel_bridge connector
To:     John Keeping <john@metanate.com>
Cc:     dri-devel@lists.freedesktop.org,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <swboyd@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
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

On Fri, Jan 20, 2023 at 3:43 AM John Keeping <john@metanate.com> wrote:
>
> Commit 15b9ca1641f0 ("drm: Config orientation property if panel provides
> it") added a helper to set the panel panel orientation early but only
> connected this for drm_bridge_connector, which constructs a panel bridge
> with DRM_BRIDGE_ATTACH_NO_CONNECTOR and creates the connector itself.
>
> When the DRM_BRIDGE_ATTACH_NO_CONNECTOR flag is not specified and the
> panel_bridge creates its own connector the orientation is not set unless
> the panel does it in .get_modes which is too late and leads to a warning
> splat from __drm_mode_object_add() because the device is already
> registered.
>
> Call the necessary function to set add the orientation property when the
> connector is created so that it is available before the device is
> registered.

I have no huge objection to your patch and it looks OK to me. That
being said, my understanding is that:

1. DRM_BRIDGE_ATTACH_NO_CONNECTOR is "the future" and not using the
flag is "deprecated".

2. In general, if something about the deprecated method used to work
and a patch broke it then we should fix it until we can finish fully
deprecating. However, we should avoid adding new features to the old
deprecated method and instead encourage people to move to "the
future".

3. I don't think any of the orientation patches broke the deprecated
path. Before those patches, nothing used to configure the orientation
property properly. After those patches, "the future" method (AKA
DRM_BRIDGE_ATTACH_NO_CONNECTOR) did configure the orientation property
properly.

...so by those arguments I would say that we shouldn't land your patch
and that instead you should work to get your drivers moving to
DRM_BRIDGE_ATTACH_NO_CONNECTOR.

Now, all that being said, your patch adds one line of code and really
doesn't seem like a big deal. I'd personally be OK with landing it,
but I'd prefer to hear an opinion from someone more senior in the DRM
world before doing so. I'm still fairly low on the totem pole. ;-)


> Fixes: 15b9ca1641f0 ("drm: Config orientation property if panel provides it")

Maybe remove the "Fixes" tag here. That patch didn't break you, right?
It just didn't happen to _also_ fix you.
