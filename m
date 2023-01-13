Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F50266A46C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 21:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjAMUty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 15:49:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjAMUtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 15:49:47 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457DD76210
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 12:49:46 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id bf43so34743676lfb.6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 12:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fkHnDayGcMAohLKGEspej/e05EdmPSY3auvLO5nhKvg=;
        b=B1hyLm+idg00BzqYNZMLiXGprSAGG6i9IwN0XKFvJoTp+bbSmW2iNf+GJtXCutZOO3
         8RgU6vVG5lOlOdS4Jh+/EFjzMIfNlQs2UESZqPIAVNO8K6uwqRQpbb6GfpuoMr4V1iJU
         C54ylt/YF1UuhIaYBPOGvyctdx3Rtziy4tGIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fkHnDayGcMAohLKGEspej/e05EdmPSY3auvLO5nhKvg=;
        b=3SUx5X/buHCacCEg8JGmr07CuKwt16cjn7b7Ctl+zgAGqbe79/OqaVLmgfdqX92a2o
         VKFu0RBAmd7aJMQZ3DPWvwJDT0+1dCnbqh6CEyDy4YlbAZpLRuqzRWgBdCqRhL/OsCR8
         XTmsoqdO/ErcjF2rVBnX6EtM4kixi5YrwKEDGb4tUEW5RREgYDONmj0C1ZNujaR369Jk
         J5wUqMbcX5B194IurRSSApX3/TfyK4zEa6rnNxuvDIX0yDvXMRRJkrT4BMR+jNFcHfNV
         JKYUKKXIJL4FLDkTxhvn25OUOvmI8PILOd2TKpqLD8phMFG8c0iT18Zlpy6HP/xGI8dC
         C77Q==
X-Gm-Message-State: AFqh2kr1ggJL7HN+HQKtQg9Yc7XxQXZM9TNOb8/Qi+R1CKlDCDzA5f3F
        K73IU4DfkDUWhfl/vUxqsCZZA9wC7sPVPu4gnmXcHQ==
X-Google-Smtp-Source: AMrXdXsFLXpkYgLqPlD2aDMji/uNDYTLN9rr6vjDLKKJD82SrMUZ1JiyUGLTXyWhvAyNsS4E39x10UQlL6/nncEdZ5s=
X-Received: by 2002:ac2:4e50:0:b0:4ca:e48d:2b4b with SMTP id
 f16-20020ac24e50000000b004cae48d2b4bmr8301849lfr.511.1673642984424; Fri, 13
 Jan 2023 12:49:44 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 13 Jan 2023 14:49:43 -0600
MIME-Version: 1.0
In-Reply-To: <Y8FwGTWeYtX0j8MX@ravnborg.org>
References: <20230106030108.2542081-1-swboyd@chromium.org> <Y7nV+aeFiq5aD0xU@ravnborg.org>
 <CAE-0n50QOv_+j1Pe19xKj4Cx2Y5_Ak5Kt68UBJuZt10D-jQ44g@mail.gmail.com> <Y8FwGTWeYtX0j8MX@ravnborg.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 13 Jan 2023 14:49:43 -0600
Message-ID: <CAE-0n51XmyzSeKuGNn2BsJew3fK_cEHNoDpVVRqStNAF+Zzp1A@mail.gmail.com>
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

Quoting Sam Ravnborg (2023-01-13 06:52:09)
> Hi Stephen,
> On Tue, Jan 10, 2023 at 11:29:41AM -0800, Stephen Boyd wrote:
> > Quoting Sam Ravnborg (2023-01-07 12:28:41)
> >
> > >
> > > For this case we could ask ourself if the display needs to enter sleep
> > > mode right before we disable the regulator. But if the regulator is
> > > fixed, so the disable has no effect, this seems OK.
> >
> > What do you mean by fixed?
> What I tried to say here is if we have a fixed regulator - or in others
> words a supply voltage we cannot turn off, then entering sleep mode is
> important to reduce power consumption.
> But any sane design where power consumption is a concern will have the
> possibility to turn off the power anyway.

Ok got it!

>
> >
> > >
> > > Please fix the unprepare to not jump out early, on top of or together
> > > with the other fix.
> >
> > After this patch the unprepare only bails out early if the bool
> > 'prepared' flag isn't set.
> OK, then everything is fine.
>

Doug pointed out that enable isn't symmetric because it doesn't do the
DSI writes. I've updated the patch and I'll send a v2.
