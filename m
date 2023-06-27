Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9DFB74057E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 23:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjF0VR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 17:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjF0VR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 17:17:26 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BEF1BD1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 14:17:24 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51bcf75c4acso3219a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 14:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687900643; x=1690492643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cBeSv/arp5bR8O0ezFl7fdKlEKxWfXnzLYU9+AdmzGc=;
        b=tfUpx5yzTHhQIqvV6B/hMBOXajoW3JRxIkAPylYF9WdKHxjWQXkaz29OkaD06EUW+C
         /tSk+kBo0MdDNbAf7SbEV9eaO4cZ/IK21j7EeF69T3+T4FzzOV+PVke8d6c+Bb5S1HQ6
         hLo5lk8AvJtb9soHB+Yq8dVmRdFaso7T2mFv1mIKj+d55uOi+2yqs11OZq8dxUl241lz
         awwPlDOWsF0ihnewJriL+vS5clDEI6pQt4emYOx9wGU1+1QnOmI0tM70awk/SeNecE/U
         1czgUpwJqXcK5y/RIVjx/rZrDm5qZhvRlJVmFjXFnzG3xAq92G/YDwthgX0Iz5XRgtSC
         2tLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687900643; x=1690492643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cBeSv/arp5bR8O0ezFl7fdKlEKxWfXnzLYU9+AdmzGc=;
        b=VGAXc/KLdmlZwFk0zPVeAo37laeSSMrxnc7GryxxFglx9YjzluWAzjr4aVDYF8L8pM
         umAWKXEg8s98aGYnwasF024OpgoZzZgw8YUy/kMnCPRaBqBMdzB9R2VDF/Gej7/m40vx
         dtCeO7FD/WIIXK866xS4knt1onvzCcgn8PwnVVeeo2i1EZag7uBwYDiVze9SLcH+WAzh
         R6revMIsH6tgXeUK9UdPmkGWvQKOHIhjrdveh1uA/ijCJq4otE4IbxFwOG+CNyn29Erj
         wu2Bpr5L+YgwWM0yTyGea0KHb6tOz6X4XKLHQLERmEiLml3R8APcJyzViNo+ZRQoSSS0
         zKJg==
X-Gm-Message-State: AC+VfDx+bmHGIEJPnrVEyW+q1CaukZGAZwQX/6kGD6G127uzWItTORSH
        zdDF2oRKcZylDMdh2BdtPwqWGmzjMD4OBgS/IjQYaA==
X-Google-Smtp-Source: ACHHUZ70Q5j1PrnGsHu1Pss9Gi238RZdicz8QeFii6Q1FnA+fmkZQD6gh8CYj3Aib3f7Q0vjX9+44Tr1PgkxN5zxB2M=
X-Received: by 2002:a50:d087:0:b0:506:b280:4993 with SMTP id
 v7-20020a50d087000000b00506b2804993mr28983edd.2.1687900643282; Tue, 27 Jun
 2023 14:17:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230627050148.2045691-1-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20230627050148.2045691-1-yangcong5@huaqin.corp-partner.google.com>
From:   Doug Anderson <dianders@google.com>
Date:   Tue, 27 Jun 2023 14:17:10 -0700
Message-ID: <CAD=FV=WR=fnhCxC37Eo3hinh2MV=eTNuXG+GrwgR6K_pV4Rbaw@mail.gmail.com>
Subject: Re: [v2] drm/panel: Fine tune Starry-ili9882t panel HFP and HBP
To:     Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc:     sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch,
        airlied@gmail.com, hsinyi@google.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 26, 2023 at 10:01=E2=80=AFPM Cong Yang
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> Because the setting of hproch is too small, there will be warning in
> kernel log[1]. After fine tune the HFP and HBP, this warning can be
> solved. The actual measurement frame rate is 60.1Hz.
>
> [1]: WARNING kernel:[drm] HFP + HBP less than d-phy, FPS will under 60Hz

Thanks for including the warming. This looks like something that's
only printed on Mediatek display controllers. Just out of curiosity:
is that because Mediatek controllers have special requirements, or is
this something generic and the Mediatek controller is the only one
that warns about it?


> Fixes: 8716a6473e6c ("drm/panel: Support for Starry-ili9882t TDDI
> MIPI-DSI panel")

Ideally the tool you have to send mail wouldn't wrap the Fixes line.
Probably not worth resending just for this, but see if there's
something you can do to fix this in the future.

Since this is a tiny fix, I don't think we need to wait too long. I'll
plan to land it on Thursday unless Neil wants to land it himself
sooner.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
