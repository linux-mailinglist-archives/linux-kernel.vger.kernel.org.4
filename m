Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1697B686E4C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 19:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbjBASmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 13:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbjBASmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 13:42:00 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC46346A2
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 10:41:56 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id z11so18684415ede.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 10:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6ehnntGKDa7eVQQXOOpPUsFKwUBTB8JqaOLp9/2yOYY=;
        b=DTd+/4e/1SnRBgPOnGHgrZt3/SmKSOx9lc9nMYZG2Fy3mp9d+TU+hhjX1wchEwAUzs
         b8hdk/wLEYHNSHU+DOvR0QoHimi9RTBefYQKs1Ee/1ZphQ++2Ek7w+LvPM1qaZo0tvQT
         EdtNGvlOUYPlLem7f0ZBLVHMuejFHNJRC5nQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ehnntGKDa7eVQQXOOpPUsFKwUBTB8JqaOLp9/2yOYY=;
        b=eOHJVolXSKol3BguvSxJ8cGunBkJrAWTBmx1kFk50wpKG3sTMyUuVmKAumgp7OZdSW
         0MXXBgkZW+rH1FKoLBT8DQdXqDDnRrKWj+Yv/odmbdGjej1xysM1JK7OdR400xjHOylQ
         gONAupoqqE4rC/gweAS3ra1O6t9AP346HQduI4iGBNbgOjZakGZNT7L/L0KduyT08fMZ
         eb1EnjvFT6z/ReusBTIRosqFbbW9fKSk3+PTCsmqOm5wV34bh2vmtxupP6BXTATx7y/h
         Qa2vfndz2E6RkXMnF2AiJEtz65m9RoW8pNJK7GDBw19dAcxmA4M210R8WtTd8nUeskvQ
         CoqQ==
X-Gm-Message-State: AO0yUKXFFXcKM4IboDSzeJyJJlZgARgcmtoy+6w10qIQYhg9eUiuSRDS
        kcJPnLA6gr0/QzuQTjMys44y9LD43qmG9RfHgXQ=
X-Google-Smtp-Source: AK7set8nYjzzaV2iBTo7lUF3cbyHEb/GJPgbq+LfgGoeBp7pPPWeAmfNtMD9gCqv2rYxolb/qcm8ZA==
X-Received: by 2002:aa7:c448:0:b0:4a0:af87:b3ab with SMTP id n8-20020aa7c448000000b004a0af87b3abmr2807727edr.36.1675276915228;
        Wed, 01 Feb 2023 10:41:55 -0800 (PST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id b20-20020aa7d494000000b0049b58744f93sm10182545edr.81.2023.02.01.10.41.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 10:41:54 -0800 (PST)
Received: by mail-wm1-f42.google.com with SMTP id j32-20020a05600c1c2000b003dc4fd6e61dso2091967wms.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 10:41:54 -0800 (PST)
X-Received: by 2002:a05:600c:a03:b0:3dc:42e7:8d38 with SMTP id
 z3-20020a05600c0a0300b003dc42e78d38mr157425wmp.93.1675276914417; Wed, 01 Feb
 2023 10:41:54 -0800 (PST)
MIME-Version: 1.0
References: <20230201101112.1.Ia7bc164622c8bb2dd7720ecd456672ccfd70fc5b@changeid>
In-Reply-To: <20230201101112.1.Ia7bc164622c8bb2dd7720ecd456672ccfd70fc5b@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 1 Feb 2023 10:41:24 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UKDbnw7b_sVWBS2aS4dXqDeDCcQdgKHfU4zvGWa0+S8A@mail.gmail.com>
Message-ID: <CAD=FV=UKDbnw7b_sVWBS2aS4dXqDeDCcQdgKHfU4zvGWa0+S8A@mail.gmail.com>
Subject: Re: [PATCH] docs: cpufreq: Frequencies are in Hz, not kHz
To:     rafael@kernel.org, viresh.kumar@linaro.org, corbet@lwn.net
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
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

On Wed, Feb 1, 2023 at 10:11 AM Douglas Anderson <dianders@chromium.org> wrote:
>
> Though the documentation for the cpufreq files has always specified
> that the frequencies are in kHz, they simply aren't. For as long as I
> can remember looking at these files they've always been in straight
> Hz. Fix the docs.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> NOTE: git blame shows that this has been wrong since before the kernel
> switched to git. I've tagged the first git commit as Fixes, but we
> could easily just drop the Fixes tag if that's a better way to go.
>
>  Documentation/admin-guide/pm/cpufreq.rst | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Ugh. Please ignore this patch. Somehow I read these numbers many times
and convinced myself that it was Hz enough to actually post a patch.
...but then someone corrected me and pointed out that I'm utterly and
completely wrong. Sorry for the noise.

-Doug
