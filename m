Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE7E6205BD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 02:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbiKHBXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 20:23:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233039AbiKHBXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 20:23:04 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1936D1EADD
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 17:23:02 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id a67so20265097edf.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 17:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=huQuPYkl7U+LTfPaignW2xikp2tMlS/JRi7V+K6MHt8=;
        b=irTny37RkM+fGVHhNgcCBJ0iTlIIPXy+dgkSvu7tYO5TGRTQCbks4PWN65k63oXT+5
         jGRQHWb+zGLrTTmThs65Dup5b/mmNc7pV8yHJsJ/mw1/TVYWLGLi5wMvo294yHZ3Fct3
         wc3/hzieeFRLBlrXiJbqEFDE6P27lTrXB1lYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=huQuPYkl7U+LTfPaignW2xikp2tMlS/JRi7V+K6MHt8=;
        b=SGx9OoW2NYweyXkekBYbCrL31GP+G4H3WFWbxu9stufrXuVE0RIBQn8G7UMpBzUHZL
         Nx9mUacdYidUwpRdjvZncORT1Jxl1uYzf1hGj+qwgmav+uESwfM1UsIWx8sfSjd0TQIN
         4DDk/Xi7+En6OQHUdklxP0bRQHr0GQ2Aw2rzuiOFgx9auOdfiIuskq3mNQVmgAGIH8ut
         b7vJrjU1feRbsVkfLIK5hWZQmjQ5tZLduhe8D35yBJoPVZfhvS+MxJh9giR0u/glLCul
         A35FbCXhhkm+x2hzf//ujfvKHQNIHjNlZOq25K4eP69tDV4Mlb2uGobeilKtSsIkwWe5
         qzBA==
X-Gm-Message-State: ANoB5pkfTWyyMMrYL7Tb54SsoPCH43BAjggzla6PSYVYmgnhJlTvhEi4
        WmLiSdsJgs/TiArbPXGgEVQW8J+gRPJEzgno
X-Google-Smtp-Source: AA0mqf7ebsLRSewVKkp6VfZQIp+eeI9Uhv/vBUnr/TktF0TjBDx/EggdjrIlqzllgdAPD+eZv9AE/g==
X-Received: by 2002:a05:6402:1d84:b0:466:7ef1:bc0f with SMTP id dk4-20020a0564021d8400b004667ef1bc0fmr5074369edb.12.1667870580164;
        Mon, 07 Nov 2022 17:23:00 -0800 (PST)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id f24-20020a056402069800b00458a03203b1sm4943904edy.31.2022.11.07.17.22.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 17:22:59 -0800 (PST)
Received: by mail-wr1-f52.google.com with SMTP id o4so18719915wrq.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 17:22:59 -0800 (PST)
X-Received: by 2002:a5d:4410:0:b0:236:a8f9:268f with SMTP id
 z16-20020a5d4410000000b00236a8f9268fmr33789345wrq.405.1667870578850; Mon, 07
 Nov 2022 17:22:58 -0800 (PST)
MIME-Version: 1.0
References: <20221107191535.624371-1-swboyd@chromium.org> <20221107191535.624371-2-swboyd@chromium.org>
In-Reply-To: <20221107191535.624371-2-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 7 Nov 2022 17:22:47 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UJEkNcWWFExQsCD5SXvH_YvoK_K6mtFB0_ojDSNLP8Zg@mail.gmail.com>
Message-ID: <CAD=FV=UJEkNcWWFExQsCD5SXvH_YvoK_K6mtFB0_ojDSNLP8Zg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arm64: dts: qcom: Fully describe fingerprint node
 on Herobrine
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-arm-msm@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>
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

On Mon, Nov 7, 2022 at 11:15 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Update the fingerprint node on Herobrine to match the fingerprint DT
> binding. This will allow us to drive the reset and boot gpios from the
> driver when it is re-attached after flashing. We'll also be able to boot
> the fingerprint processor if the BIOS isn't doing it for us.
>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Cc: Alexandru M Stan <amstan@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

From Bjorn's recent comment [1], I think your subject needs modification to:

   arm64: dts: qcom: sc7280: Fully describe fingerprint node on Herobrine

Other than that this seems fine and is a better description of hardware, so:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

I guess we're still leaving gpio77 alone (AKA not describing it in the
fingerprint regulator)?

[1] https://lore.kernel.org/r/20221017224853.stuy5qeqxjxntob4@builder.lan/
