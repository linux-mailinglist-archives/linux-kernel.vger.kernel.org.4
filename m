Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00E2674737
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 00:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjASX2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 18:28:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjASX16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 18:27:58 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7851837F25
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 15:27:57 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id p25so3779453ljn.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 15:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sparkcharge.io; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kDmL0K++1s4Mya2O7kGY5mEjqqYCgvB7aw/CJew8g1A=;
        b=H9de9Us+oCArxhPuh/jcI4Kqmlwh86mbB8kLQ3GkLQYmFNLghxvMaVGj6JgRoaIJQ3
         50BKzPWzTCyD2VzffNQWhueJqdyS1ha3CvqnbjZTdlhni1/Qzt+u5+7lSegxNAz4FV5F
         YD/DuzVbRsh51NkdsNatjpvUNyhrJN0kFRgbKg5MM7PmpbIwkZq1/drTdM4C1BhFqSZn
         C/ttYQNN1WrNzmDnRpfb+D4QZ5RoUwcULM34aUKscTgS+5iOFEDH2Bhaio6FfJ599Ecp
         0W9x3pNDybRvG2QiTGRafAjekyAmocC6whnzZLJgnQY6vkVNalEZQ5uuEIWW4AxrdrvC
         lSdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kDmL0K++1s4Mya2O7kGY5mEjqqYCgvB7aw/CJew8g1A=;
        b=yayG/Zd4LUhRa+gXROmW+1d5ExTTnTnZLoaRLMfJhAjr0iUQ+S7A+/oZrgJLfofigt
         QuaoqILhWF+zYQX+rDVaR1frER9Opj1QIPL+X+HlOApY2wJUHBXJklesSyn+LXLT544H
         O0+JkikJFE3MEZESUlyYIWdZO3aaNQNaZEvasOXskEPzkDzutYkYKYWGgi+raPh4mAQo
         +TXahxx27ynpHZkQu6NxVuo0VZls21QqdebfyuIDLJQcoCnQiYfiOX/bjw8V1S81++PF
         vLuBX/Hkn0TIoN92AwuqqM3xa0ZIq3TvI+VYm9Z9Cldj2StdjyBObdjASmrnMTzfjwiB
         1Jzw==
X-Gm-Message-State: AFqh2koVjvP/QhQgaxiWfaXZTKlu13K1HpaQTVIJxSh2ptY/W1PRuesN
        d6cbOQ2ggvBiI9Tej/uX6rlnipbVza8f+99Yx8SEDg==
X-Google-Smtp-Source: AMrXdXsc63eeOG5QbM3YICUOh1tZoXR66/wQ9YOZ202aHSDWYdO/MhMACQJCFcKE6uC/PYsgEh7sGIjSLPmxCGJpFYA=
X-Received: by 2002:a2e:9449:0:b0:28b:9755:77a with SMTP id
 o9-20020a2e9449000000b0028b9755077amr1230879ljh.152.1674170875783; Thu, 19
 Jan 2023 15:27:55 -0800 (PST)
MIME-Version: 1.0
References: <20230119213903.899756-1-dennis@sparkcharge.io> <Y8nBloQfBPK3t5ce@mail.local>
In-Reply-To: <Y8nBloQfBPK3t5ce@mail.local>
From:   Dennis Lambe <dennis@sparkcharge.io>
Date:   Thu, 19 Jan 2023 18:27:44 -0500
Message-ID: <CAKYiA1Dr0TAmsqDf1wMeeysN4N8K+KJL6onCgQL98LVV5L7Vmg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] rtc: Set M41T82 & M41T83 xtal load capacitance
 from DT
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Atsushi Nemoto <atsushi.nemoto@sord.co.jp>,
        Gary Bisson <gary.bisson@boundarydevices.com>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Troy Kisky <troy.kisky@boundarydevices.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 5:18 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:

> I need to find time to think about it because while setting the analog
> trimming statically from the device tree solves your immediate problem,
> it will also remove the possibility to handle it from userspace later
> on. I would really prefer this uses the offset interface or a better
> interface that unfortunately doesn't exist yet.

Thanks for letting me know what you're thinking about this. I think I
see what you're getting at.

However, I think this is more complex than either of us had
considered. The M41T82 has two different calibration capabilities:

1. Digital calibration. This looks to me like it behaves similarly to
the digital calibration feature of the M41T00, which ds1307.c exposes
through the offset interface. The M41T8x driver doesn't currently
expose the digital calibration register at all, but if it did I would
agree that the offset interface looks appropriate.

2. Analog calibration -- that's what the datasheet calls it, but the
range on it is very big -- 3.5 pF all the way up to 17.4 pF -- and
their reference design uses it as the only xtal load capacitance in
the circuit. Most of the values you could set for this would be wildly
inappropriate for any given design's choice of xtal oscillator.

Between these, I don't know if you'd want to expose just one, the
other, or some synthesis of both via the offset interface or some new
interface.

I'd make the case that the xtal's required load capacitance is a
hardware requirement that's appropriate to configure via the Device
Tree. Even if you did want to allow some amount of runtime fine-tuning
of this register, you'd still want to document a rational starting
value chosen based on the hardware.

I agree with you, though, that if a runtime fine-tuning feature were
added, we'd have to find a way to choose whether to initialize the
register on boot or not, so that we didn't overwrite the fine-tuning.

Just to demonstrate something that could work, and would be
backward-compatible with this patchset, here's a hypothetical design:
* dt-bindings: add quartz-load-femtofarad-tuning-min and
quartz-load-femtofarad-tuning-max
* Limit run-time tuning adjustments to be within that range
* Only overwrite the analog calibration register on start-up if its
value is outside that range

After thinking through all this, I'd still advocate for merging this
patchset in some form and leaving integration with runtime APIs as a
potential future enhancement. I look forward to hearing your thoughts
about it.
-- 
Dennis Lambe (He/Him)
Lead Firmware Engineer
sparkcharge.io
