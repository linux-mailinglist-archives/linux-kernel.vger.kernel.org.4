Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB1B6C2115
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 20:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjCTTRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 15:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbjCTTQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 15:16:37 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72583A846;
        Mon, 20 Mar 2023 12:08:46 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id ek18so50914261edb.6;
        Mon, 20 Mar 2023 12:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679339325;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rntUn+sA5+a5jB7OMEeFvtRNclHYN0rSHfvZwb0rt/g=;
        b=Yw2nTJUCnicn46QE/nAMk8TEOBXxmKNx8lNlu3aHUixpdumw/gDyjAQX6a47kkcUkN
         Y4vELAcD8me8Wk0GH2BK6oiNa/+9PRqgsw+AvStRoPhrm+/IVwcBNoFuwNodRtw/Ro7c
         2XcOkmjXquU+5O6ywESihU9mmc29CiwnGIqmKg1Z4BHOgy6164xG4ujSxRy8R/kmcAPL
         O5PF0mCcaa2Y8plYM9v2PMPyP4h5b8m7gjt1lj3hQgg4Ip6juolj7PxHrzfZD+BHVGMN
         0wmjvzxhz5PnPjAVrLs836/MbaojocEJW9jUQUm8fMVIZyG13aBrXJW7IFLqFKppSYrr
         NHWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679339325;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rntUn+sA5+a5jB7OMEeFvtRNclHYN0rSHfvZwb0rt/g=;
        b=fB/xDBysK1sjFObhyVxuix2u6PjtggkA3gF1Tzv2uXqnroHQXicZFV87HMZaPmslxa
         j1nPa+pvGt9gpkJB44Atv9B2ll1NhI6tssTpybDQF3tPwzSWopYtooBGOV3X3w93hNDQ
         xFTA5vd9wrxaUSraEaOSWe0jlhBJuCE800gpOaTyKgddex2ACrJvlk9G3pBemvNn8FVu
         wgahGdwn3QLSZI+lYjcx0+bbk8QHhvZ+ThwshdLKRiktNOo+C9JPSTBM8v1zhGmK0FHN
         F0P5F1MjszINE0bU2wuy3iJ6gst+/ylQqeWeFxKthDQb+41EMsCVieqNMt5hhw8vNuft
         FWcQ==
X-Gm-Message-State: AO0yUKXGlQQgLxL2IjW5IDBLyUAHW0KSBpD3AhzbdJ31iqXx+8OxdU71
        pu7OBliKYlg+XkvHG3LrC00ZPTc6OaxK8FvKq2Y=
X-Google-Smtp-Source: AK7set9Ld3St3Qcim1+xZzym7kkesgBkLKqYAhh/hi4W4RBAlupWuN6BKes2OCEYBR9+rEgbIj6IPDk9EMXSr+v9t9k=
X-Received: by 2002:a50:8e0a:0:b0:4fb:dc5e:6501 with SMTP id
 10-20020a508e0a000000b004fbdc5e6501mr382359edw.1.1679339325090; Mon, 20 Mar
 2023 12:08:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230320153419.9185-1-n.zhandarovich@fintech.ru>
In-Reply-To: <20230320153419.9185-1-n.zhandarovich@fintech.ru>
From:   David Rheinsberg <david.rheinsberg@gmail.com>
Date:   Mon, 20 Mar 2023 20:08:33 +0100
Message-ID: <CADyDSO6nvFaC8dZKuSYcqgdiL8oub+eKU-PqYSeH2cXnVw-=Uw@mail.gmail.com>
Subject: Re: [PATCH] HID: wiimote: check completion in wiimod_battery_get_property
To:     Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        David Herrmann <dh.herrmann@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
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

Hi

On Mon, 20 Mar 2023 at 16:34, Nikita Zhandarovich
<n.zhandarovich@fintech.ru> wrote:
>
> wiimote_cmd_wait() in wiimod_battery_get_property() may signal that the
> task of getting specific battery property was interrupted or timed out.
> There is no need to do any further computation in such cases, so just
> return the error.
>
> Found by Linux Verification Center (linuxtesting.org) with static
> analysis tool SVACE.
>
> Fixes: dcf392313817 ("HID: wiimote: convert BATTERY to module")
> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
> ---
>  drivers/hid/hid-wiimote-modules.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/hid-wiimote-modules.c b/drivers/hid/hid-wiimote-modules.c
> index dbccdfa63916..9755718d9856 100644
> --- a/drivers/hid/hid-wiimote-modules.c
> +++ b/drivers/hid/hid-wiimote-modules.c
> @@ -220,8 +220,10 @@ static int wiimod_battery_get_property(struct power_supply *psy,
>         wiiproto_req_status(wdata);
>         spin_unlock_irqrestore(&wdata->state.lock, flags);
>
> -       wiimote_cmd_wait(wdata);
> +       ret = wiimote_cmd_wait(wdata);
>         wiimote_cmd_release(wdata);
> +       if (ret)
> +               return ret;

The current code returns cached battery-information in case a
synchronous update did not succeed. Battery information is likely
updated regularly, anyway, so the synchronous update is usually not
required.

I don't think bailing out and returning the error to the caller is
required or gains us anything but more complexity. Or am I missing
something here?

Thanks
David
