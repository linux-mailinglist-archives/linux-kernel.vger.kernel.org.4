Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12BB7616AB2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 18:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbiKBR25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 13:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbiKBR2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 13:28:52 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C3EE69
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 10:28:50 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id t25so47235433ejb.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 10:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X2+9yxVt9jWEvW8G1POIGEGcQSupOLAIpJg0gweghVs=;
        b=EgGB89Zg2h2E8cHoQjjgPCz2n0IaFrtoRPxndhM06adDo28bUdZZyYjM7q7PGcAuCO
         qrK1/JRrMVIgQ54XSYURFj9EiicVAjN1F6gMP1c632DyLUMlyDJIn0yQ1+VaCn4KYaHU
         OW4PLBRpp/FdhTOokAVnaOpXhTYDriLrSphdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X2+9yxVt9jWEvW8G1POIGEGcQSupOLAIpJg0gweghVs=;
        b=ag5WvWahjlN3dkVDfVG0rqsxU47cS4RlNZx+g8bdIjiGyQVThVNh1Qrj1CXg0BR77M
         lvo4QOfAiyuarKDEA2fOzJv105ac6l6LE1kKTDn+Dk9ArczJbW22gEmz7ZGw8U8eRoG3
         19YxTD63jzQMVCB7/bxCJDj58/Z4IkCU9d4LFpUzYyJFXCGRGIM7dpeA2yaRij+hfzIW
         wgoO28ragLeoYKBpEiyn7+s8Yg3rggnrHINbvBg0W+V5epj7f1TSosQKTSBrg9N2qbuL
         JCt6aHfOaBXxwi9h2rZK+Wigyhn6RJbRlMD3Xfsp9z7zY275xHvb/dU3Mg90YDhHCQrS
         JLHQ==
X-Gm-Message-State: ACrzQf1U9F0BL0+zzJZZk9ksxr3gywvZOAUFFSlx66MK5hgFJzvRf/GI
        pKtXEQLul/QohO2IKo+Y8K4gRptivB62w9EU
X-Google-Smtp-Source: AMsMyM4NQnUcTTMuQqDkcAsRChXgtdQQUXbjaQFF7DHZh5/Jlv5ZB3HN2AuLN3lFrInaiCGi54pztw==
X-Received: by 2002:a17:907:d2a:b0:7ad:e0c5:4bd7 with SMTP id gn42-20020a1709070d2a00b007ade0c54bd7mr13944454ejc.177.1667410118777;
        Wed, 02 Nov 2022 10:28:38 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id gz24-20020a170906f2d800b00771cb506149sm5645771ejb.59.2022.11.02.10.28.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 10:28:37 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id ay14-20020a05600c1e0e00b003cf6ab34b61so1744890wmb.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 10:28:36 -0700 (PDT)
X-Received: by 2002:a05:600c:2212:b0:3cf:6068:3c40 with SMTP id
 z18-20020a05600c221200b003cf60683c40mr16617338wml.57.1667410116349; Wed, 02
 Nov 2022 10:28:36 -0700 (PDT)
MIME-Version: 1.0
References: <1667237245-24988-1-git-send-email-quic_khsieh@quicinc.com>
 <94b507e8-5b94-12ae-4c81-95f5d36279d5@linaro.org> <deb60200-5a37-ec77-9515-0c0c89022174@quicinc.com>
 <CAD=FV=X_fs_4JYcRvAwkU9mAafOten9WdyzPfSVWdAU=ZMo8zg@mail.gmail.com>
 <155e4171-187c-4ecf-5a9b-12f0c2207524@linaro.org> <CAD=FV=Wk5rBSq9Mx1GCO0QFYckKV9KUFKL36Ld7dQX1ypHVcYw@mail.gmail.com>
 <CAD=FV=XTOUjVAGFWZ6xTkcNOrCT1p73aU-=KJNYUOxsS-BQsyA@mail.gmail.com> <c5aedb31-3881-50e7-f747-e75b18c3f4b8@linaro.org>
In-Reply-To: <c5aedb31-3881-50e7-f747-e75b18c3f4b8@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 2 Nov 2022 10:28:22 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WPde5wVOGCKQYGuGwgCwRebox4FF0MgV_2pPCTsfo_UA@mail.gmail.com>
Message-ID: <CAD=FV=WPde5wVOGCKQYGuGwgCwRebox4FF0MgV_2pPCTsfo_UA@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dp: remove limitation of link rate at 5.4G to
 support HBR3
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Kuogee Hsieh <quic_khsieh@quicinc.com>, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, vkoul@kernel.org,
        daniel@ffwll.ch, airlied@linux.ie, agross@kernel.org,
        quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 2, 2022 at 10:23 AM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> > 1. Someone figures out how to model this with the bridge chain and
> > then we only allow HBR3 if we detect we've got a TCPC that supports
> > it. This seems like the cleanest / best but feels like a long pole.
> > Not only have we been trying to get the TCPC-modeled-as-a-bridge stuff
> > landed for a long time but even when we do it we still don't have a
> > solution for how to communicate the number of lanes and other stuff
> > between the TCPC and the DP controller so we have to enrich the bridge
> > interface.
>
> I think we'd need some OOB interface. For example for DSI interfaces we
> have mipi_dsi_device struct to communicate such OOB data.
>
> Also take a note regarding data-lanes from my previous email.

Right, we can somehow communicate the max link rate through the bridge
chain to the DP controller in an OOB manner that would work.


> > 2. We add in a DT property to the display controller node that says
> > the max link rate for use on this board. This feels like a hack, but
> > maybe it's not too bad. Certainly it would be incredibly simple to
> > implement. Actually... ...one could argue that even if we later model
> > the TCPC as a bridge that this property would still be valid / useful!
> > You could certainly imagine that the SoC supports HBR3 and the TCPC
> > supports HBR3 but that the board routing between the SoC and the TCPC
> > is bad and only supports HBR2. In this case the only way out is
> > essentially a "board constraint" AKA a DT property in the DP
> > controller.
>
> We have been discussing similar topics with Abhinav. Krzysztof suggested
> using link-frequencies property to provide max and min values.

This sounds good to me and seems worth doing even if we eventually do #1.
