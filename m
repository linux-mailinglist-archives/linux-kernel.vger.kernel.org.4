Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17850645617
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 10:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiLGJJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 04:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiLGJJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 04:09:26 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2852B1A230
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 01:09:25 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id x22so12369715ejs.11
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 01:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LycWcOW4hTd+zMxG7ctf14bHvPvqRQgLxrdseEn+NsU=;
        b=kIqXSCKDkf4sQCsSPC3kOLk3BlpIHgjkJhEdlGQgau2QXnugNqxTPpILX/K39+tTRh
         U319uRITnQSWy82hqUjhUnKewilfz+4O4VSr+cYYmhLReyAkoTaWoLaBnwMdbnbq33Ax
         OtU3MKZIo9mSOoMZqoN5ghciaShpw/+kooSrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LycWcOW4hTd+zMxG7ctf14bHvPvqRQgLxrdseEn+NsU=;
        b=JMiXlHov4gAW65JwjmLuwuplmpWN5ln77K4kFmjhw3xCZnAAQf0i6J978bPZh4U+8g
         0wmX0trAWUW33i3iMVawfGSxySDE28u2XVX5Fz9vhVYNOodMxcgn4U0VIS1Y86M9JaQz
         vPePWfggNetcN1glQe08B+/Sy/STu169nW4zjQMZ8lXlJFqjCWFEhxQeokO1h2V/FsP4
         SXDRiLU+cvCNIhFnXxnWlu5DvO/f+0+XUtBjDDl6pC7atAXG2Qp06dItKzF3bevuT8cO
         OV2qSyQX2yQE9OdMr0MlOX/FkErKZYXWmq7kK9a6FG8wL6HKo5oswKAK7ahvQAt/g4U3
         fa0Q==
X-Gm-Message-State: ANoB5plBCkCGcevkm20Qd0rH6+i9mawMW4XrxMeJcOIifh2CXquqF1yL
        /mCHbwa62RTXyENHyIjmBJQf8gWu2k7tqOSzLZKn+A==
X-Google-Smtp-Source: AA0mqf65XBvfAZHj2/CWnW41GYPtAPJmUcDVYknXeFT/VhI2OyTTI+itR/6K9eqkllrg35x9emP6MA==
X-Received: by 2002:a17:906:5e55:b0:7c0:cfc5:dd0c with SMTP id b21-20020a1709065e5500b007c0cfc5dd0cmr16826310eju.743.1670404163359;
        Wed, 07 Dec 2022 01:09:23 -0800 (PST)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id tj13-20020a170907c24d00b00780b1979adesm8306763ejc.218.2022.12.07.01.09.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Dec 2022 01:09:22 -0800 (PST)
Received: by mail-wm1-f47.google.com with SMTP id n9-20020a05600c3b8900b003d0944dba41so583553wms.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 01:09:21 -0800 (PST)
X-Received: by 2002:a1c:f216:0:b0:3c6:c2ae:278b with SMTP id
 s22-20020a1cf216000000b003c6c2ae278bmr64557436wmc.127.1670404161334; Wed, 07
 Dec 2022 01:09:21 -0800 (PST)
MIME-Version: 1.0
References: <20221207040049.1.I1864b6a7ee98824118b93677868d22d3750f439b@changeid>
 <CACeCKads-Kwqr5iMj9=+ryXFiFnPoyNnhOuzpYspwKo5yP-+mw@mail.gmail.com>
In-Reply-To: <CACeCKads-Kwqr5iMj9=+ryXFiFnPoyNnhOuzpYspwKo5yP-+mw@mail.gmail.com>
From:   Victor Ding <victording@chromium.org>
Date:   Wed, 7 Dec 2022 20:08:44 +1100
X-Gmail-Original-Message-ID: <CANqTbdZVGiNMizP4Ht=-HFssySfJFugsc9_HAxEFRfhY7uPO8A@mail.gmail.com>
Message-ID: <CANqTbdZVGiNMizP4Ht=-HFssySfJFugsc9_HAxEFRfhY7uPO8A@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: zero out stale pointers
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        tinghan.shen@mediatek.com, gustavoars@kernel.org,
        sebastian.reichel@collabora.com, dnojiri@chromium.org,
        bleung@chromium.org, lee.jones@linaro.org, groeck@chromium.org,
        tzungbi@kernel.org, gregkh@linuxfoundation.org, dustin@howett.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant,

Thank you for reviewing. I'll update accordingly in the next revision.

On Wed, Dec 7, 2022 at 7:02 PM Prashant Malani <pmalani@chromium.org> wrote:
>
> Hi Victor,
>
> On Tue, Dec 6, 2022 at 8:02 PM Victor Ding <victording@chromium.org> wrote:
> >
> > `cros_typec_get_switch_handles` allocates several pointers when
> > obtaining four handles. These pointers are all freed if failing to
> > obtain any of the four handles; therefore, pointers in `port` becomes
> > stale. The stale pointers eventually cause use-after-free or double in
> > later code paths.
> >
> > This patch proposes
> Please use the imperative form [1]
>
> > to elimite these stale pointers by zeroing them out
>
> s/elimite/eliminate
>
> > right after they are freed.
> >
> > Signed-off-by: Victor Ding <victording@chromium.org>
> This should have a "Fixes" tag.
>
> Best regards,
>
> -Prashant
>
> [1] https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes

Best regards,
Victor
