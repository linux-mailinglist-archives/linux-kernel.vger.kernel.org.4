Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5B070FCA9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 19:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbjEXR3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 13:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233462AbjEXR3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 13:29:42 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15453FC
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 10:29:37 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-7747df5b674so100680539f.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 10:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684949374; x=1687541374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yq6BLiBB15ZpThHz2GQJH12upVOih5oQeiwfZRvJZIs=;
        b=QYLXFTbPT0b4rqKMgZ8/8tyMSyH6G/K6w4o90yWq/K8tpntKJ5mB9bGpaYWDcv36ZL
         XAhIhOM52XaLx/LJa98fxubec+kMG8JuE0/r194/jOAQE15nSxAJxA8HpenwlZ6cBGOU
         X/X8b9a1lbGgiRYIJYi+u2no2vILwgtYxCSRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684949374; x=1687541374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yq6BLiBB15ZpThHz2GQJH12upVOih5oQeiwfZRvJZIs=;
        b=kTffF7GVeD7Qtrf4A+ChW4ZNRb5PNf4bAb7NHjtm7ATxlgBgM16y6SFm03Lqc0qZLm
         J1/d+uR8SOv/XrACDiWwV6GEnK35nZ8XW4uGkGY14RLYgSPPYnGE1Vw9cVMHAoxByaJs
         JdGHleO1bVSGxPVli6XTxdxEVmt5Il3JcR6f9AZhQ4e3j1/kBwQMCoaV9U4SdqXPvfGl
         vfiGqm/KvuI/u6aIcce0UwwSklQsuZ9NIM4lJmbkVlgShGAr0uYtoWIFjS4tsI1sGm2i
         ziNm9TDDBwCzCpf6Gq22smWL3n5IK4dfnTMO0JFEAcAOu2RSb4NAf8RuZWq0zfbCW+rs
         2fmw==
X-Gm-Message-State: AC+VfDy8n/UL9uxbDV1GSg/uxQPaWugRU5pyzlLiY7vq53YaK6wvCSEc
        gXoVk48ONS7N7m95xVmb3MWDXKh0Yx3ysbD1RvU=
X-Google-Smtp-Source: ACHHUZ45RdCC/wNLusbloCvsIxO3vVaIJ8qI84B2BY8QnI8CIXlMPp5OrOQJA3JYwwWZ1QgvV090Jw==
X-Received: by 2002:a5d:9646:0:b0:760:ec52:254d with SMTP id d6-20020a5d9646000000b00760ec52254dmr12072120ios.2.1684949374595;
        Wed, 24 May 2023 10:29:34 -0700 (PDT)
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com. [209.85.166.179])
        by smtp.gmail.com with ESMTPSA id g191-20020a025bc8000000b004141e72be1asm3271272jab.175.2023.05.24.10.29.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 10:29:32 -0700 (PDT)
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-338458a9304so7415ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 10:29:31 -0700 (PDT)
X-Received: by 2002:a05:6e02:1b09:b0:335:a48:f668 with SMTP id
 i9-20020a056e021b0900b003350a48f668mr199716ilv.15.1684949370785; Wed, 24 May
 2023 10:29:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230523193017.4109557-1-dianders@chromium.org> <20230523122802.7.Ib1a98309c455cd7e26b931c69993d4fba33bbe15@changeid>
In-Reply-To: <20230523122802.7.Ib1a98309c455cd7e26b931c69993d4fba33bbe15@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 24 May 2023 10:29:13 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Ucn7BeWWGOOEX0ho7yH31VF-w7U60KFB8qSn4L1xn3fw@mail.gmail.com>
Message-ID: <CAD=FV=Ucn7BeWWGOOEX0ho7yH31VF-w7U60KFB8qSn4L1xn3fw@mail.gmail.com>
Subject: Re: [PATCH 7/9] HID: i2c-hid: Support being a panel follower
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>, hsinyi@google.com,
        devicetree@vger.kernel.org,
        yangcong5@huaqin.corp-partner.google.com,
        linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, cros-qcom-dts-watchers@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 23, 2023 at 12:31=E2=80=AFPM Douglas Anderson <dianders@chromiu=
m.org> wrote:
>
> As talked about in the patch ("drm/panel: Add a way for other devices
> to follow panel state"), we really want to keep the power states of a
> touchscreen and the panel it's attached to in sync with each other. In
> that spirit, add support to i2c-hid to be a panel follower. This will
> let the i2c-hid driver get informed when the panel is powered on and
> off. From there we can match the i2c-hid device's power state to that
> of the panel.
>
> NOTE: this patch specifically _doesn't_ use pm_runtime to keep track
> of / manage the power state of the i2c-hid device, even though my
> first instinct said that would be the way to go. Specific problems
> with using pm_runtime():
> * The initial power up couldn't happen in a runtime resume function
>   since it create sub-devices and, apparently, that's not good to do
>   in your resume function.
> * Managing our power state with pm_runtime meant fighting to make the
>   right thing happen at system suspend to prevent the system from
>   trying to resume us only to suspend us again. While this might be
>   able to be solved, it added complexity.
> Overall the code without pm_runtime() ended up being smaller and
> easier to understand.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  drivers/hid/i2c-hid/i2c-hid-core.c | 82 +++++++++++++++++++++++++++++-
>  1 file changed, 81 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c=
-hid-core.c
> index 34c0d98b4976..f1bb89377e8d 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-core.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
> @@ -38,6 +38,8 @@
>  #include <linux/mutex.h>
>  #include <asm/unaligned.h>
>
> +#include <drm/drm_panel.h>
> +
>  #include "../hid-ids.h"
>  #include "i2c-hid.h"
>
> @@ -107,6 +109,8 @@ struct i2c_hid {
>         struct mutex            reset_lock;
>
>         struct i2chid_ops       *ops;
> +       struct drm_panel_follower panel_follower;
> +       bool                    is_panel_follower;
>  };
>
>  static const struct i2c_hid_quirks {
> @@ -1058,6 +1062,34 @@ int i2c_hid_core_initial_power_up(struct i2c_hid *=
ihid)
>         return ret;
>  }
>
> +int i2c_hid_core_panel_prepared(struct drm_panel_follower *follower)

As pointed out by the kernel test robot, I clearly missed making
several functions "static" in this patch series. :( I'll fix that in
v2, but for now I'll hold off sending v2 to wait for additional
feedback.

-Doug
