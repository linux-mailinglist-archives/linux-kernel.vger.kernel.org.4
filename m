Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259CB67A011
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 18:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234666AbjAXRXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 12:23:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234042AbjAXRXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 12:23:52 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC19949011
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 09:23:51 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 141so11777013pgc.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 09:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+0nNRfjCiY62cIhTLLxOILNdEmv43GkeGwDLJSgq+54=;
        b=KERHFJmysDcwQBNOAlN+gp+2jnAw1CcO6J+pAe7fa0lKM6lW7VtVXnn4RZvxq0fiS0
         0rtGgZP32STP5sXxbA2Vsy/jF1jcF1aDH0vWlP3WvE90aQyvLVtiAMo7Pzrx8osxm7fk
         9JRWfI+N4FVB3ogvKeivLJbrht/WgeO13d93xTmHNm3vXsBQIN3cYlOQXjcI1zBIBUvT
         p3cis2Kf8ytsKJgZhjlBRTSbLxhw4qBIPgIgfTtNi9Ncs0b/zOaAWatfRhggXrydj5sg
         1JB7vPwGLEyY/OzQb+3nbtuNVKo6qamJNPS6Zj3QrVHUd5DTQg6DkWgF20IONQk12qM0
         L6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+0nNRfjCiY62cIhTLLxOILNdEmv43GkeGwDLJSgq+54=;
        b=bpykaWMvQo9gJwb3MX7mC7sO1UK9gxl6xi+69gzZ66wGr1hODHkcltQB5R0Cp7sdai
         Ne9cEf/qM+MD9+Os1/G2iJDKv6wzbSvll6OGBmyPGHm8NkIJTGY/rT4DbMuTYXXBj67A
         YaF/EdbyCsf/9WdkH+oGulsbRJRWKPpVoTrJLgNEeNMm+ciRO/RDQ+bkiyqBEiiY1Qsq
         61w0XnOOA0MixzbS0HwIr/a+ZRsnuA4Sx21+j1/Ju2BkSwB7fM2aGgYpvL++Ak6Ma2Q6
         8BsnFnHnhkX6QeFTT35fVGZ9AmerIiKDuV6eqiiGWRAWNUaVXsvsNFGYJsACW1cKEn0A
         2X1g==
X-Gm-Message-State: AFqh2kpFnQrDhKTrBKrkVlQiOP6NAWmOiuTOeQSx9ojjiJYbPY19E/AM
        vrQEiDRlK/yhvlc7lvxaQyjzghRiV2ZpdnBXsBc=
X-Received: by 2002:a05:6a00:b96:b0:58d:b8f6:6f6d with SMTP id
 g22-20020a056a000b9600b0058db8f66f6dmt4962859pfj.32.1674581031297; Tue, 24
 Jan 2023 09:23:51 -0800 (PST)
MIME-Version: 1.0
From:   novenary <streetwalkermc@gmail.com>
Date:   Tue, 24 Jan 2023 19:23:40 +0200
Message-ID: <CANnEQ3Ef5-XRSVL=RCBuKKhR0oZF+SO2BSSiBigZOyjMeQ7f_g@mail.gmail.com>
Subject: fbcon font is reset after GPU is loaded
Cc:     Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This appears to be a pretty common problem. systemd includes a udev
rule[1] which loads a console font from userspace, using setfont from
the kbd package, when a vtcon device is added. According to udev debug
logs, this event only fires once.

This actually works fine all the way until the GPU driver is loaded,
after which the console is reverted to the default kernel font. My
understanding from skimming the code in fbcon.c is that fonts should
be persisted from one instance to the next.

I can reproduce this on both of my machines, one with an AMD Polaris
GPU, and one with Intel integrated graphics (Kaby Lake R).

As discussed in [2], it seems the only reliable way to change the
console font at the moment is to ensure that the graphics driver is
loaded before udev starts, but I don't believe this is an acceptable
or even correct solution.

Am I missing something? It would be really helpful if someone could
shed light on why this is happening.

[1] https://github.com/systemd/systemd/blob/main/rules.d/90-vconsole.rules.in
[2] https://github.com/NixOS/nixpkgs/issues/202846

Thanks in advance,
novenary
