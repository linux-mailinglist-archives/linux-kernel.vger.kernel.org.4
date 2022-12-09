Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F316D647B8B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 02:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiLIBii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 20:38:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiLIBif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 20:38:35 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F139C389D8;
        Thu,  8 Dec 2022 17:38:32 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id k79so2660437pfd.7;
        Thu, 08 Dec 2022 17:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gdUrO4Vj0WpEBGdoSL51EYLyXJXFaKz3pHSmds694To=;
        b=W4SnNW/rgY1OgOH5yjRt+PniOQ5lp33EO2mncjn9cRosI9fDluB5dyikWK/32mtxqA
         UMkt1Q3KJtnU/5Q7sZV1/H1irJdb/wbKnkau5qyMgfsYew4z+zwfO24DJGHzbzErfqEA
         sb17bazJvcbhjvw8rFZ2G1eauJlRkuFjf2uwLi17DKgRVNvCsTkvUuMW5un5zUQwJaSl
         Erx8iNfoHVfeUtVTdGqApFBUwvipVbIaGEgKz6K1yV1vRi0cxcjgfsmP+BtnJ97sJPYg
         2AwmwMJheWMvVDwySA9+THgf7FYoJ3S9ShWpay5pc3JZJMfpoQcoBhBG1ytPxEKXPe0Y
         r7Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gdUrO4Vj0WpEBGdoSL51EYLyXJXFaKz3pHSmds694To=;
        b=Vruw5lqLM1kPxqqf/I/t8kst2FMSWqlTPPZvWkKp4NacDM8IfKlgVKkfDXa2JaAPPW
         vRoxBpM2NWLl4ffvV2IlxXRbErg0Bjv+GASBAjVIaxUUHCVv0dbSqOPNJJhrz7uHWUDG
         0e/1szJLqEiYIrPxMi596/Kz4EHnjeWsjmaNrssBVlC/18D+DIW31aVC0Nbzsdu+b8ri
         D/WB57zqn01B/EB2ivRTBND+cxQPOQrKi8/VhF+Btyw+1HW+VZ/GCo9c+sLHDwKpgWtT
         lz4oYqFV9hkzXNKmd7LteGM7+ASaBxoXeHoGes6LZpOHiG9jiFjwZKada1qcYb7GwWsi
         lZnw==
X-Gm-Message-State: ANoB5pl5x5CGVtUApJF4t0N9TL92nuxTbvD/9pBxGR7QFuDv9Cdhx6CA
        /mhWirYMp5S2Eex6byNQzm4=
X-Google-Smtp-Source: AA0mqf5RPIgDj3Hmn7YPOhgMYmk4lfHIIcDcDc7GA1P1ukud6zegHOgxJlCgw5PfFggaji5wYOxb4w==
X-Received: by 2002:aa7:864a:0:b0:56d:1bb6:af75 with SMTP id a10-20020aa7864a000000b0056d1bb6af75mr3344659pfo.4.1670549912342;
        Thu, 08 Dec 2022 17:38:32 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:5853:f1e8:694c:1488])
        by smtp.gmail.com with ESMTPSA id w11-20020aa7954b000000b00528a097aeffsm132178pfq.118.2022.12.08.17.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 17:38:31 -0800 (PST)
Date:   Thu, 8 Dec 2022 17:38:28 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <andersson@kernel.org>, mka@chromium.org,
        swboyd@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-input@vger.kernel.org,
        Yunlong Jia <ecs.beijing2022@gmail.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Johnny Chuang <johnny.chuang.emc@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] Input: elants_i2c: Delay longer with reset asserted
Message-ID: <Y5KRlNvoVo6ZWV24@google.com>
References: <20221208192006.1070898-1-dianders@chromium.org>
 <20221208111910.5.I6edfb3f459662c041563a54e5b7df727c27caaba@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221208111910.5.I6edfb3f459662c041563a54e5b7df727c27caaba@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022 at 11:20:06AM -0800, Douglas Anderson wrote:
> The elan touchscreen datasheet says that the reset GPIO only needs to
> be asserted for 500us in order to reset the regulator. The problem is
> that some boards need a level shifter between the signals on the GPIO
> controller and the signals on the touchscreen. All of these extra
> components on the line can slow the transition of the signals. On one
> board, we measured the reset line and saw that it took almost 1.8ms to
> go low. Even after we bumped up the "drive strength" of the signal
> from the default 2mA to 8mA we still saw it take 421us for the signal
> to go low.
> 
> In order to account for this we let's lengthen the amount of time that
> we keep the reset asserted. Let's bump it up from 500us to 5000us.
> That's still a relatively short amount of time and is much safer.
> 
> It should be noted that this fixes real problems. Case in point:
> 1. The touchscreen power rail may be shared with another device (like
>    an eDP panel). That means that at probe time power might already be
>    on.
> 2. In probe we grab the reset GPIO and assert it (make it low).
> 3. We turn on power (a noop since it was already on).
> 4. We wait 500us.
> 5. We deassert the reset GPIO.
> 
> With the above case and only a 500us delay we saw only a partial reset
> asserted, which is bad. Giving it 5ms is overkill but feels safer in
> case someone else has a different level shifter setup.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Applied, thank you.

-- 
Dmitry
