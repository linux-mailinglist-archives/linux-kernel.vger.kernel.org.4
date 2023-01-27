Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655AC67E632
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 14:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234626AbjA0NKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 08:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234649AbjA0NJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 08:09:56 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5325839B9C
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 05:09:27 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-4a263c4ddbaso66826467b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 05:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YU5gp66cUMEsIjOUJMaNzi7WxUjgg7o9Hm+NCfenBwE=;
        b=VFa9ekua1moN5oKZmSpT0UGkVwcW1vH86thEEUAxletqXU+L6fOFt4TXHv9qg6jrCV
         9LuUm1lP5+bOd+IdXBiBEQ+62tN0G77sBKA058eHebk9+NIYhpqCFmRG61QdMDh+6dTp
         WY8SioUPXlSNocwVPmiJfySJxuzhAWxyHXWgiMGwzOra/MxUFIlTPj/SMkBzkTCt+q/E
         KOIHkxCuKDr5fnI0jkM3uUcBAmMvPzsi+/nC5WAVAV60GJM3Qa9xo729uLtE6UGRQY3T
         GRibqylIX1w+dNX8oFlv3marXoVQ7p9ECJkB9fKqG4xWG754K7P+sXdNfQUd+nJcl4lL
         SCfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YU5gp66cUMEsIjOUJMaNzi7WxUjgg7o9Hm+NCfenBwE=;
        b=LAsxyQRM7C7Jmi0iw2YadAbQzopGUPl0Xde8h5Hv383OmQaCWTe4JzOAFIs/D3ttcG
         ttsg12pCGicQk6XVKb7QP4TLDbGsvD/KgoY6V30v2uILuia+RJMO5k+nAXRRPAKdgAjj
         NRfl/YZXY2ZGIaKWWKLwF/cgGhKVHV4bgipi6Anb5m/ojjLAMeEvXFW7XcoO7UA2sBG3
         SfB9xgoaW/+Uff/P6x0wBh9+oo0KmF1aJ26HCIcxzHo7RvTb9wfUcmPNaIqT0E5nQd/P
         +5HHLw0jADKiQGvgBnjnmPJYCEOvyPLvV+05jZWuslv5kEAR/cjwBm/v7nMbJvKyeq7x
         TG8g==
X-Gm-Message-State: AFqh2kpxZyIdx9MzJ0FQrgsL2NlreC7oC/n3A5Dzqrw+w3JO/2P7Qptp
        eCyzkK6QE3lFM5E8ky+bQFciYaSSbzmSDgp+pgDi+Q==
X-Google-Smtp-Source: AMrXdXuZhU3gr9MIDVk/t9AgyzR831Yprp9cmP8hbAnFPAZ+0afieEswrJS7ReQ7g2jBnQekw8MSVepzhDqltNKjajA=
X-Received: by 2002:a05:690c:39b:b0:4f3:8d0e:edce with SMTP id
 bh27-20020a05690c039b00b004f38d0eedcemr3534898ywb.185.1674824959667; Fri, 27
 Jan 2023 05:09:19 -0800 (PST)
MIME-Version: 1.0
References: <20230126132801.2042371-1-arnd@kernel.org> <20230126132801.2042371-5-arnd@kernel.org>
In-Reply-To: <20230126132801.2042371-5-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 27 Jan 2023 14:09:08 +0100
Message-ID: <CACRpkdaGuc6-0P2=K5KETVd4EpbJ_9+DHe6ayy81n8CyjWeacA@mail.gmail.com>
Subject: Re: [PATCH 4/8] gpiolib: remove gpio_set_debounce
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-gpio@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 2:28 PM Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> gpio_set_debounce() only has a single user, which is trivially
> converted to gpiod_set_debounce().
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for shrinking the legacy API surface.

With the fixes pointed out by Andy:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
