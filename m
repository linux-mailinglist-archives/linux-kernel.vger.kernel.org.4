Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331B8664C76
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 20:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjAJT3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 14:29:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjAJT3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 14:29:45 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2325E49152
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 11:29:44 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id f21so9210187ljc.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 11:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C0mrhoty+Ut/5gp43tpMbErT7DWwGt+4GLr6GpRkjbQ=;
        b=i1+w0zA7s1qv8jt4zUE+emrBPpmeSdaUBPz0yCFo1nbNg9YBG5C9AAvS4RNrL0co/Y
         dqSyexwdFchejaYEPv5Wfg4lBoPaVxUCnM4E9fys7J60ul6YlINQL+lxBN5cjLvLT7fy
         V1Xpg8rHHMcctUni8OS7+vepJW4M0IZKby69k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C0mrhoty+Ut/5gp43tpMbErT7DWwGt+4GLr6GpRkjbQ=;
        b=wXxf1yDcjCJxJ8CtHeX7WCJK1Xu/YAsuwDPQKydO0B1BW+Sco3q3vB6rysBdqiz9Eb
         sJNSVELl1te/3E9C3LsQ+Dmp1XJz0dkD5npsFtqxxisWzmp8eypK67LXbA5vuBOlcwDe
         vmBwrF4NTnRE3eFoNHtVvd4bU+RB1adfwzb/XjREQS6snMpwkqyWc6+72U/7vRcp7Bo1
         HnKJWgj7UML+sTmwtc3eOs2Llh5pCx1KUWl6NtiYV9gRXHLjuhRnKpVMtcmJlr27h/tG
         IqYFdfNT1Sxvw41qtg/guZvXKs3KNGCBAKtBZNzqeLu/1JMQVXxS4xY/mGCfrkfys2bQ
         +TRw==
X-Gm-Message-State: AFqh2koeuOovgFoUXbRU1PA14LXIz9vszaHYrKseHm7IHIfRr1AxlyLv
        dO521U3k7LdKPcArv0/qYIZ9gK+dCjgehVpGWavP2Q==
X-Google-Smtp-Source: AMrXdXvM2MfqylLeD7zuAdCzxczA9kWaE3YYfn4AhNYhK9aWSE+eYRCCCjZP2dMjqs5j2772EMlAYv4Eqh5jwd26EBI=
X-Received: by 2002:a2e:2ac4:0:b0:27f:cc03:496a with SMTP id
 q187-20020a2e2ac4000000b0027fcc03496amr3837868ljq.359.1673378982518; Tue, 10
 Jan 2023 11:29:42 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 10 Jan 2023 11:29:41 -0800
MIME-Version: 1.0
In-Reply-To: <Y7nV+aeFiq5aD0xU@ravnborg.org>
References: <20230106030108.2542081-1-swboyd@chromium.org> <Y7nV+aeFiq5aD0xU@ravnborg.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 10 Jan 2023 11:29:41 -0800
Message-ID: <CAE-0n50QOv_+j1Pe19xKj4Cx2Y5_Ak5Kt68UBJuZt10D-jQ44g@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: boe-tv101wum-nl6: Ensure DSI writes succeed
 during disable
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        yangcong <yangcong5@huaqin.corp-partner.google.com>,
        Douglas Anderson <dianders@chromium.org>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Rob Clark <robdclark@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sam Ravnborg (2023-01-07 12:28:41)
> On Thu, Jan 05, 2023 at 07:01:08PM -0800, Stephen Boyd wrote:
> > The unprepare sequence has started to fail after moving to panel bridge
> > code in the msm drm driver (commit 007ac0262b0d ("drm/msm/dsi: switch to
> > DRM_PANEL_BRIDGE")). You'll see messages like this in the kernel logs:
> >
> >    panel-boe-tv101wum-nl6 ae94000.dsi.0: failed to set panel off: -22
> >
> > This is because boe_panel_enter_sleep_mode() needs an operating DSI link
> > to set the panel into sleep mode. Performing those writes in the
> > unprepare phase of bridge ops is too late, because the link has already
> > been torn down by the DSI controller in post_disable, i.e. the PHY has
> > been disabled, etc. See dsi_mgr_bridge_post_disable() for more details
> > on the DSI .
> >
> > Split the unprepare function into a disable part and an unprepare part.
> > For now, just the DSI writes to enter sleep mode are put in the disable
> > function. This fixes the panel off routine and keeps the panel happy.
> >
> > My Wormdingler has an integrated touchscreen that stops responding to
> > touch if the panel is only half disabled too. This patch fixes it. And
> > finally, this saves power when the screen is off because without this
> > fix the regulators for the panel are left enabled when nothing is being
> > displayed on the screen.
>
> The pattern we use in several (but not all) panel drivers are that
> errors in unprepare/disable are logged but the function do not skip
> the remainder of the function. This is to avoid that we do not disable
> power supplies etc.

Ah that would have made it so I didn't see a problem. But I wonder if
the panel gets borked if you don't disable it via DSI writes before
yanking the power?

>
> For this case we could ask ourself if the display needs to enter sleep
> mode right before we disable the regulator. But if the regulator is
> fixed, so the disable has no effect, this seems OK.

What do you mean by fixed?

>
> Please fix the unprepare to not jump out early, on top of or together
> with the other fix.

After this patch the unprepare only bails out early if the bool
'prepared' flag isn't set. Are you suggesting to get rid of that flag
and unconditionally disable the regulators? Is it possible for the
unprepare to be called multiple times without a balanced call to
prepare?
