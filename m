Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7966568E013
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 19:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbjBGScK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 13:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232647AbjBGScD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 13:32:03 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544A28A7F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 10:31:49 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id j12so2913809ila.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 10:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OVGv953a/TRW+zFGloKXvKsCRvM9/SxchdtuwLei+Fo=;
        b=jz/Op+8b4+niNTCYz0rUEA4y/ac+GvW59915DrFptkw1bsxdR8dhDMijIXH9CWlchg
         PUvECpeICr8G9+jezzp4Vtn2SLurCe0I1XymMjzcBEiVFkz8igHdmDUbzNWlG3UjHfJQ
         Mht3RDKpDhJVNIui/bQDplWjhxWtsNOIjP0zI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OVGv953a/TRW+zFGloKXvKsCRvM9/SxchdtuwLei+Fo=;
        b=x/otucLv/xWI1EF+mttShLqvd7hthyGwyPLB9a4kdqKDJqbzWamOjLFADauGOgwdLL
         SHOJkDXQfcsNPUCPuPpBOfxzmV4O+AvGZ01T1MwI6tNJxTpFmkUqBcxlK//1Gxel/bRM
         O1DaieHDaeLXodXT8B3Q9DXxZDv9TxlNhzHEexfDNXnJRK9h1fYdDvuiC6pIMJK4vSf5
         Os/0iN8toelMm3e8Y1F19hyd2HVdD4KoITOwbW1YjUr4FAN9kCynteFHjZ1MjLje4t71
         B1S/BxkNNEDFOuaoMtR28/f7gkkxgkdPchSszDEf43Xgk1HYHSvv6Polh1w10MbjwRri
         ggDw==
X-Gm-Message-State: AO0yUKVXDepvlYw+mgekjTsIzgZbZabsZNHwKkZfH5/+GP60/ExUGrTQ
        PQrvNpaVDyVZyMwiNohYfxIv7A==
X-Google-Smtp-Source: AK7set/ap571v3p51svWnKT+r9LLpAmOse7WGsIyA3foorSztB6PQDbjr2IVAC/t+XfclX9fNwITXQ==
X-Received: by 2002:a05:6e02:1be6:b0:30f:6400:f7dd with SMTP id y6-20020a056e021be600b0030f6400f7ddmr5307831ilv.17.1675794708781;
        Tue, 07 Feb 2023 10:31:48 -0800 (PST)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id n4-20020a92d9c4000000b00310a40e669esm1601859ilq.11.2023.02.07.10.31.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 10:31:48 -0800 (PST)
Date:   Tue, 7 Feb 2023 18:31:47 +0000
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        devicetree@vger.kernel.org, Stephen Kitt <steve@sk2.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] HID: i2c-hid: goodix: Stop tying the reset line to
 the regulator
Message-ID: <Y+KZE1tqTH3lqafJ@google.com>
References: <20230207024816.525938-1-dianders@chromium.org>
 <20230206184744.4.I085b32b6140c7d1ac4e7e97b712bff9dd5962b62@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230206184744.4.I085b32b6140c7d1ac4e7e97b712bff9dd5962b62@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 06:48:13PM -0800, Douglas Anderson wrote:
> In commit 18eeef46d359 ("HID: i2c-hid: goodix: Tie the reset line to
> true state of the regulator"), we started tying the reset line of
> Goodix touchscreens to the regulator.
> 
> The primary motivation for that patch was some pre-production hardware
> (specifically sc7180-trogdor-homestar) where it was proposed to hook
> the touchscreen's main 3.3V power rail to an always-on supply. In such
> a case, when we turned "off" the touchscreen in Linux it was bad to
> assert the "reset" GPIO because that was causing a power drain. The
> patch accomplished that goal and did it in a general sort of way that
> didn't require special properties to be added in the device tree for
> homestar.
> 
> It turns out that the design of using an always-on power rail for the
> touchscreen was rejected soon after the patch was written and long
> before sc7180-trogdor-homestar went into production. The final design
> of homestar actually fully separates the rail for the touchscreen and
> the display panel and both can be powered off and on. That means that
> the original motivation for the feature is gone.
> 
> There are 3 other users of the goodix i2c-hid driver in mainline.
> 
> I'll first talk about 2 of the other users in mainline: coachz and
> mrbland. On both coachz and mrbland the touchscreen power and panel
> power _are_ shared. That means that the patch to tie the reset line to
> the true state of the regulator _is_ doing something on those
> boards. Specifically, the patch reduced power consumption by tens of
> mA in the case where we turned the touchscreen off but left the panel
> on. Other than saving a small bit of power, the patch wasn't truly
> necessary. That being said, even though a small bit of power was saved
> in the state of "panel on + touchscreen off", that's not actually a
> state we ever expect to be in, except perhaps for very short periods
> of time at boot or during suspend/resume. Thus, the patch is truly not
> necessary. It should be further noted that, as documented in the
> original patch, the current code still didn't optimize power for every
> corner case of the "shared rail" situation.
> 
> The last user in mainline was very recently added: evoker. Evoker is
> actually the motivation for me removing this bit of code. It turns out
> that for evoker we need to manage a second power rail for IO to the
> touchscreen. Trying to fit the management of this IO rail into the
> regulator notifiers turns out to be extremely hard. To avoid lockdep
> splats you shouldn't enable/disable other regulators in regulator
> notifiers and trying to find a way around this was going to be fairly
> difficult.
> 
> Given the lack of any true motivation to tie the reset line to the
> regulator, lets go back to the simpler days and remove the code. This
> is, effectively, a revert of commit bdbc65eb77ee ("HID: i2c-hid:
> goodix: Fix a lockdep splat"), commit 25ddd7cfc582 ("HID: i2c-hid:
> goodix: Use the devm variant of regulator_register_notifier()"), and
> commit 18eeef46d359 ("HID: i2c-hid: goodix: Tie the reset line to true
> state of the regulator").
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
