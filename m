Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B7D6611BC
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 22:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbjAGVCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 16:02:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjAGVCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 16:02:51 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3E043D80;
        Sat,  7 Jan 2023 13:02:50 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-4b6255ce5baso65437427b3.11;
        Sat, 07 Jan 2023 13:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JmL5h/5f9ZKkHhV7ji7KKVGJQTUq0yPHfnhiMRhXed0=;
        b=IK5dGKTx88W2mfNkdSbqWACqkjubhVS9N14mCOb6xiNrTRTmnuplQafYC0im+wGspK
         eOYeaF0MULlk8xs1MhOKyABR+2n5mu7ywO33aNQ9VX4GMkdSdCVqflFNfkdkPvE907aV
         AbMRlhdfsnbXDXTGbNIAQfaGPRPsPMo8biAT31OQE9sPB82/31f0is5EfnCupoTz/Ke+
         5qPrTwyq0HpYK24udJ89pRlkE2Z5QaSlpexv9uCe2Y49IpPc0IVSTp5co8YZkKYLFYOl
         z+xqA+ASKB1ZQdTTr7sECFdnwcqnzJz4QBV2ycEBNoSYjk2aEYooKDaJopPZvE6w6Z6k
         Ar3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JmL5h/5f9ZKkHhV7ji7KKVGJQTUq0yPHfnhiMRhXed0=;
        b=O2Jt2D/UOX8udyJw4wmKiwmRJp1QZZDvWL8gSq+6byXI9i06Z5PMsbU6ZWUsdhkoVG
         MfGZwjwLJCITxyV+wd++Fwcr1rYoLAI23Rm2RfzCNY88alsjYN87pKjmJultoXVM4mnG
         Tiwve8thwK39D8yykpWbuYWE1juUcL8UsAss+frof2mdcZmJb/cJZWyJtEe8JBKU0Qry
         2arFjIT8c6wBr1ZEX0O+ZsZ4N7umqG4oCN8OUEJAA0ZawLz1F2o1eOAMrzhDNlpMyG4L
         9z7LoOTrBPvXmKafgXDYStxi6lv8gy/lmK9XmeoagdJL2DUxs/3mWcxf88uUFTkx06yd
         u9zw==
X-Gm-Message-State: AFqh2kquv0h80YVRSWW24KesVvJ+CgiZooYNZ5yQ5Hfr405m5dN4uvxE
        Pn1IXU5hcIx/bWJtjQmrGVG88GFyRYO2DNpEyK0=
X-Google-Smtp-Source: AMrXdXvY/st+xuDrW4znKkHpZttsCvsZGZkx5Bw3ldG/KbixkSHtRzf/+VMAvkN/c9NxoWqjkDvGG4OpHXXkd75XJ3w=
X-Received: by 2002:a81:484f:0:b0:3ed:90d2:2ab8 with SMTP id
 v76-20020a81484f000000b003ed90d22ab8mr582273ywa.67.1673125369382; Sat, 07 Jan
 2023 13:02:49 -0800 (PST)
MIME-Version: 1.0
References: <20230107-sam-video-backlight-drop-fb_blank-v1-0-1bd9bafb351f@ravnborg.org>
 <20230107-sam-video-backlight-drop-fb_blank-v1-12-1bd9bafb351f@ravnborg.org>
In-Reply-To: <20230107-sam-video-backlight-drop-fb_blank-v1-12-1bd9bafb351f@ravnborg.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 7 Jan 2023 22:02:38 +0100
Message-ID: <CANiq72mFMJuec+r=T6xYtLpuU+a1rOrAhrHiecy_1Jpj2m4J=g@mail.gmail.com>
Subject: Re: [PATCH 12/15] auxdisplay: ht16k33: Introduce backlight_get_brightness()
To:     sam@ravnborg.org, Stephen Kitt <steve@sk2.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Helge Deller <deller@gmx.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Antonino Daplas <adaplas@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robin van der Gracht <robin@protonic.nl>,
        Miguel Ojeda <ojeda@kernel.org>, Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-staging@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
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

On Sat, Jan 7, 2023 at 7:26 PM Sam Ravnborg via B4 Submission Endpoint
<devnull+sam.ravnborg.org@kernel.org> wrote:
>
> Introduce backlight_get_brightness() to simplify logic
> and avoid direct access to backlight properties.

Note: Stephen sent this one too a while ago (with some more details in
the commit message, which is always nice); and then he sent yesterday
v2 [1] (to mention the functional change with `BL_CORE_SUSPENDED`
[2]).

Anyway, if it goes via drm-misc, feel free to have my:

    Acked-by: Miguel Ojeda <ojeda@kernel.org>

Though it would be nice to have Robin test the change.

Thanks!

[1] https://lore.kernel.org/lkml/20230106143002.1434266-1-steve@sk2.org/
[2] https://lore.kernel.org/lkml/CANiq72kRhmT37H1FAGYGny83ONYXeqJuO8ZPbym0ajQOWKY4Kw@mail.gmail.com/

Cheers,
Miguel
