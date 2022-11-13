Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73DAF627250
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 20:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235539AbiKMTsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 14:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235474AbiKMTsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 14:48:53 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84643F02A
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 11:48:50 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id j15so13913199wrq.3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 11:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=urtGGp5NSKnCzuNmXw8f0REx4oVfO4cm/5CFl8huK7k=;
        b=sWuR3DluAzhLY0r9rRBiXIRKVARJIxWuX97LL6z/Ma201raTGFXLhGiIP0psImJorI
         XxoyyaOV8UY43efNeYjhkp4/X5fGpy4cwnOcXRE6sFKwmoM1Yuh9+VxypmIdr49F2tKo
         G/Y7ACZnLx+Z4pP3xlA+u831eXwruRHaXZuOh1F71TM3dzbPmMnPV5HmXVDkzDIqeQKT
         879Ku/ITAv0dMn3lGDMtuBwuWNrOmpWtICdaUVTU2TxBZhjwyw2FATwPmBhxbsLufUub
         oxoIhjbVJVMO/i+0bmDeG1DfELuVYfaO6lb8ytasFXDXyExfTSLLE9urigJ4Ve8rVADP
         258w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=urtGGp5NSKnCzuNmXw8f0REx4oVfO4cm/5CFl8huK7k=;
        b=uaeWi1IOGJ2XE0w4KVhfPpHRCzmtgHQW819bBQoLscgA13NgYRn6uHo1YKfwf6530k
         YitkAXY+GJxfw9UDVLacIu5BV4slZCKEarQzQePT4NnLCria6DJCATNNs1abAKQYoDq6
         j1hUsghs2u+w2oGtmbNRAFpEjDV5RwPSo8m/Bk72j7RbSnRfSdRaO84NiQiAC6UPtQ56
         bPMcMZRzj7hUE8ToR9naJVjBme2mbpZULFAY/4d8aOcvlg65iQOyfUXtOX9Kazw4gqj4
         /Erw2aTfVJJibpHcdNm/kelhG6B17KG+kspVk8DRdxLR0k9zpOx+bMVPCxvaaVtj7nX8
         EQFQ==
X-Gm-Message-State: ANoB5pnmdWVtVq6wFMu6U3Lrn8xmzf8uerlL5YZuQHdhSeNVio4vHake
        4s1x7O4kAK8+d4KWfi4ufRWSRA==
X-Google-Smtp-Source: AA0mqf7dHWm0nu9EyIOQEhW9pElK5EQKu08wMF+XsqBePbB1wQDev5K2ghiHPElC7l0zOJX+GLyD3w==
X-Received: by 2002:adf:fc8f:0:b0:22e:362e:570a with SMTP id g15-20020adffc8f000000b0022e362e570amr5538648wrr.127.1668368929033;
        Sun, 13 Nov 2022 11:48:49 -0800 (PST)
Received: from localhost (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.gmail.com with ESMTPSA id m10-20020a5d56ca000000b00241736714c3sm6588801wrw.14.2022.11.13.11.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 11:48:48 -0800 (PST)
References: <12dd5cb49efa7714f8e0389e4c7b3bc829e8a90e.1668289299.git.christophe.jaillet@wanadoo.fr>
 <3166437.e9J7NaK4W3@diego>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] clk: Remove a useless include
Date:   Sun, 13 Nov 2022 20:29:43 +0100
In-reply-to: <3166437.e9J7NaK4W3@diego>
Message-ID: <1jo7ta3aao.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun 13 Nov 2022 at 09:48, Heiko St=C3=BCbner <heiko@sntech.de> wrote:

> Am Samstag, 12. November 2022, 22:43:03 CET schrieb Christophe JAILLET:
>> <linux/rational.h> is not needed for these drivers. Remove the
>> corresponding #include.
>>=20
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>>  drivers/clk/clk-versaclock5.c | 1 -
>>  drivers/clk/meson/clk-pll.c   | 1 -
>>  drivers/clk/rockchip/clk.c    | 1 -
>
> Clock-trees for soc families normally have different sub-maintainers,
> so depending on how we want to merge this, you might need to split
> this into 3 patches.
>
> But at least for the Rockchip part, I'm also fine with the patch going
> in as a whole, so (for the Rockchip part):
>
> Acked-by: Heiko Stuebner <heiko@sntech.de>
>
>
> Heiko

Same for the Amlogic part

Acked-by: Jerome Brunet <jbrunet@baylibre.com>

>
>>  3 files changed, 3 deletions(-)
>>=20
>
> [...]
>
>> diff --git a/drivers/clk/rockchip/clk.c b/drivers/clk/rockchip/clk.c
>> index e63d4f20b479..398c427b8e81 100644
>> --- a/drivers/clk/rockchip/clk.c
>> +++ b/drivers/clk/rockchip/clk.c
>> @@ -21,7 +21,6 @@
>>  #include <linux/mfd/syscon.h>
>>  #include <linux/regmap.h>
>>  #include <linux/reboot.h>
>> -#include <linux/rational.h>
>>=20=20
>>  #include "../clk-fractional-divider.h"
>>  #include "clk.h"
>>=20

