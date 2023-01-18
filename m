Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704CC6726C0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 19:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjARSYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 13:24:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjARSYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 13:24:44 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8893A846
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 10:24:43 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id bp15so52914056lfb.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 10:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Na6xMADEzYhZzXrlHJxxzhXM5YRKt3/PwZV0GUrKKGc=;
        b=FtbWDIbw43u/20f6aUHdQZhGNF5q7hwzxM44DWYHHZguw4CyS+ovFhwIGEtmOHfbj9
         I94uNKk6/UXOxgfSZKCPkOSVywK307UXAxAhrHPaBiplbKj8UD7F85O5zsEjYiafZ4eP
         vTQhrJ/8od1gBb2UvbLmF2hi3hTlYVOQ84Jp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Na6xMADEzYhZzXrlHJxxzhXM5YRKt3/PwZV0GUrKKGc=;
        b=NFMo2dMeA62MSXPNeYjioZkmG1eThbAqSvjBbsXs4+ZQLqhRyN765A+P7F3g7iIa5n
         iVup6D7aSA/4Hi5r+RbOtH5I8E50PQMuFNItICe6GSg2yRw7COllJCueXfdDk0Ykowuq
         Zi6LVxk1DnD5eQNLgZZiYoSJemboedT59NimJng2z3E+Im6DtLftA//8Ikq2kXxbsD4D
         iKNS3Zo47JSQwmsWEM1ul8eL4hXQG1jxuR4YmmgIAkXKzLylbyR0cwJGw2qB82eXyxvi
         /ezLVadcRKYMei4lM3GZgec0M9c71yOi14shjUM+Iz5MJqjDh51c9d2uhXskd6YmQPua
         YhOQ==
X-Gm-Message-State: AFqh2kpsFZHkNNnmFLadUuD8pCUHCq0ziL8w+nJ1e3qQEwn9KI5xNaHp
        pHiiVhTPdHDudUEJjItF0M29DGdxzcXGqnacg1D2hw==
X-Google-Smtp-Source: AMrXdXu8H4rHNVOE2wtoG3S0Z9KJVoxXo4Da1sSK6RbMP0C1hgRXWtHRAK5N7Qtj8aQOi1yS8Qs1CTyTfwDonhSoIJg=
X-Received: by 2002:a05:6512:2114:b0:4bd:35fd:65b5 with SMTP id
 q20-20020a056512211400b004bd35fd65b5mr759204lfr.297.1674066281456; Wed, 18
 Jan 2023 10:24:41 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 18 Jan 2023 12:24:40 -0600
MIME-Version: 1.0
In-Reply-To: <CAE-0n51XmyzSeKuGNn2BsJew3fK_cEHNoDpVVRqStNAF+Zzp1A@mail.gmail.com>
References: <20230106030108.2542081-1-swboyd@chromium.org> <Y7nV+aeFiq5aD0xU@ravnborg.org>
 <CAE-0n50QOv_+j1Pe19xKj4Cx2Y5_Ak5Kt68UBJuZt10D-jQ44g@mail.gmail.com>
 <Y8FwGTWeYtX0j8MX@ravnborg.org> <CAE-0n51XmyzSeKuGNn2BsJew3fK_cEHNoDpVVRqStNAF+Zzp1A@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 18 Jan 2023 12:24:40 -0600
Message-ID: <CAE-0n51HAkYAcGdsJ=0gbV7JRJSGt9cZ_vHPC3kDepa4rooyvg@mail.gmail.com>
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

Quoting Stephen Boyd (2023-01-13 12:49:43)
> Quoting Sam Ravnborg (2023-01-13 06:52:09)
> > Hi Stephen,
> > On Tue, Jan 10, 2023 at 11:29:41AM -0800, Stephen Boyd wrote:
> > >
> > > After this patch the unprepare only bails out early if the bool
> > > 'prepared' flag isn't set.
> > OK, then everything is fine.
> >
>
> Doug pointed out that enable isn't symmetric because it doesn't do the
> DSI writes. I've updated the patch and I'll send a v2.

Turns out that splitting prepare into prepare and enable breaks the
display even more for me. For now this is the best patch I have and it
fixes the regression I see in v6.1 kernels. Can I get your Reviewed-by
on this patch?
