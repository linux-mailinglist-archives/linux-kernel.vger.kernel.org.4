Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD825FC39A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 12:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiJLKQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 06:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiJLKPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 06:15:45 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329FD15A08
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 03:14:51 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id a10so25470640wrm.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 03:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PeOjosyr5u2M7MVtBWoYoVb9Bk3p95cjeefCPrwJkC8=;
        b=IfIyh9wLS22x3KmioEiReoiaJDSljH0FVVLTgHFIlCO85dVHuNF1tKi97jq9vkDVCD
         vf96D1ykpoCnKHHvEpbZkO2HY99bjvkAOt9sOnwSFXnLTmjO2xcwkqwRrhXEeYqyb10Y
         2LIY6lhVIKnX1RucCyRrC362M2AYpqUOWTt3quh9Pd+1IEuaqR5yn4HTUEcvaiaY6RAB
         JF2ZP9o+OCu02lYjZ3oQ/bcTa+s2lQh8QmhWJITeCxw2/lIGdkZHcrGLVCj/QBmalzuS
         jf0/xhx2gz9mg7ZwnKwuE30KlQqsk8OYdmE1EJdn9ISCwAunLoyV1dSWtCssdHyxYncd
         N6FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PeOjosyr5u2M7MVtBWoYoVb9Bk3p95cjeefCPrwJkC8=;
        b=UruToYfqk2z0vPx+N3TZFLJzmYEvZFo5ZCmQ3QQ4ZnoscwU/kjmTAZ223BsqHzwle4
         DiXCCemB0W66V9DZFNrwkQM8oIGzE7ZUDLChY+6b00wazb7VxUBQpHDq8RI5tyYzBPQh
         jj+WuNu404roISxU7upQXyQWoAZPHCPTTjPJlKVrMdzEUmaoCvzbSBsJDX1wBy6vICfO
         DaSoFPyjE0QzeJeY+kXCltL4XwVFG82q/2lm4ocrjEscoW/ZKnJT/HAZopq6Vk2JYoa2
         0smO7GTlifpYl6pJheYV9c94RnLAUOSO/zthxG0/8MMRLwGe0McfRkX1W/5v2X3N8rTw
         LMiw==
X-Gm-Message-State: ACrzQf12DlKAfAdrk87YJS0URlLxOeAj2mL/iZWcF/61rqnUHDqWE4gm
        MzksVc17leLmzYjuQq10j2pWxA==
X-Google-Smtp-Source: AMsMyM6y2xXYz4x9NLL4v6vXYngR+hifxuZO8FeTz8FWmqoJQGmH7LJIfhFlhS0UXcVQm2AjLQ+Oqw==
X-Received: by 2002:a5d:5988:0:b0:22e:5a65:1e21 with SMTP id n8-20020a5d5988000000b0022e5a651e21mr17945171wri.338.1665569689584;
        Wed, 12 Oct 2022 03:14:49 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id h4-20020a05600c350400b003a83ca67f73sm1503870wmq.3.2022.10.12.03.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 03:14:48 -0700 (PDT)
Date:   Wed, 12 Oct 2022 11:14:47 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 1/7] gpiolib: of: add a quirk for legacy names in
 Mediatek mt2701-cs42448
Message-ID: <Y0aTl9iL/22pLfx6@maple.lan>
References: <20221011-gpiolib-quirks-v1-0-e01d9d3e7b29@gmail.com>
 <20221011-gpiolib-quirks-v1-1-e01d9d3e7b29@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011-gpiolib-quirks-v1-1-e01d9d3e7b29@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 03:19:29PM -0700, Dmitry Torokhov wrote:
> The driver is using non-standard "i2s1-in-sel-gpio1" and
> "i2s1-in-sel-gpio2" names to describe its gpios. In preparation to
> converting to the standard naming (i2s1-in-sel-gpios) and switching the
> driver to gpiod API add a quirk to gpiolib to keep compatibility with
> existing DTSes.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

I'm just passing through since I was curious about this 'set but FWIW:
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
