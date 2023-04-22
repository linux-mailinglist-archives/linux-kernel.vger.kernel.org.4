Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3656EB94D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 15:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjDVNSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 09:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjDVNSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 09:18:10 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1560BE69;
        Sat, 22 Apr 2023 06:18:10 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-52019617020so2775916a12.3;
        Sat, 22 Apr 2023 06:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682169489; x=1684761489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OEXOvcCleTccxzf6SpDlH6g1vCT+ZCWv4RoMtM7GwHo=;
        b=YEdAOKFPI/DMfW6tgG6ED31RwIhSefV0uE/absT0glfU00EftR1To1s1g8aXa73Ma6
         knMnRkv6vf5a2ioHqLaPoPUJPLq5RwLDjmwKRLK73zburvZ9I7wdiTq3PgiP6k7aCDdj
         KPW1VJ+FzQ/eNU7Sd8aPoixP9GyggQcApszQx3LbpLQFWjTjE7/a1vKLS/EmuE9bN9ht
         J+x61VYPt1WtqyZNx3PUOwVcKj0evlH0KUjQa/g89SiCCLJBkSWVXYM80fjp1nbk7acD
         m8IY1w2aWQqQEEnJOlkHONVJiMzmI9dVrTgORisVVkHml6gadqO3Rt93l+d76L2AsS4x
         Ya+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682169489; x=1684761489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OEXOvcCleTccxzf6SpDlH6g1vCT+ZCWv4RoMtM7GwHo=;
        b=KQ7mzfM0afFw5QxPOwZ1BT+mkqBdQq954FNAgKe3NTg3g/+Zn8B+PVp0u1OW8hswQM
         pMvb+vh4krQqOUAeGgYkG8O6IM0aHM2JYYcTrdT66aqaUbrpcTVbZuppEz6mypB0Nrse
         0RShBln2tqVDlzkKlHKmJK0ot6BGHC7zV1pV0d2SkWoIyVKJKt7sreC/8Q2CE9+6ewCQ
         I50vJ2J92Dm82gefPbwHMYfcpw4AnYv5Pi2D43qWUCZIjbjsv+7N5h5hjstNf06xQJKA
         fDJfuBTnvVqexZcFR/pbqaHwWYliMn3Pr5AAmlwLrmV4IOnyeg1zCnsVWujLOjNRYjhL
         s3cw==
X-Gm-Message-State: AAQBX9eWwk8zkggD4aS8U9BvOg2R8S0CTO0VBBWfrTKlk7Y61BgS0wf/
        8bFmJQV7lxrtK25+upamtElFHksh4OMxv3U9SU4=
X-Google-Smtp-Source: AKy350bTgDuCya3cK5JM+XV1GjOy7hTTtYrqT8N5d59lxcSv+Z6imF6HRgMbvNpwd/B5B159SQTnMOJ+oW6YPL7+eFs=
X-Received: by 2002:a17:90a:d102:b0:24b:68da:1420 with SMTP id
 l2-20020a17090ad10200b0024b68da1420mr5264972pju.38.1682169489411; Sat, 22 Apr
 2023 06:18:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230419181309.338354-1-cristian.ciocaltea@collabora.com>
In-Reply-To: <20230419181309.338354-1-cristian.ciocaltea@collabora.com>
From:   Vincent Legoll <vincent.legoll@gmail.com>
Date:   Sat, 22 Apr 2023 13:17:58 +0000
Message-ID: <CAEwRq=o71XMoj6_QU-mKrrrBqz80=C0g4fMwejv7fN-vAop89w@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Enable rk3588 timer support
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sugar Zhang <sugar.zhang@rock-chips.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Johan Jonker <jbx6244@gmail.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Apr 19, 2023 at 6:13=E2=80=AFPM Cristian Ciocaltea
<cristian.ciocaltea@collabora.com> wrote:
> This patchset enables Rockchip RK3588/RK3588S SoC timer support.
> While here, it also handles a minor DT binding issue related to RK3288.

I tested this on a QuartzPro64 dev board, I applied your series top of my t=
ree:
Collabora's rk3588 + some DT patches to add support for the qp64 board.

Here is the output from the commands you told me to try:

bash-5.1# grep rk_timer /sys/bus/clockevents/devices/*/current_device
/sys/bus/clockevents/devices/broadcast/current_device:rk_timer

bash-5.1# grep -B3 -A14 'Device: rk_timer' /proc/timer_list

Tick Device: mode:     1
Broadcast device
Clock Event Device: rk_timer
 max_delta_ns:   178956969070
 min_delta_ns:   1000
 mult:           51539608
 shift:          31
 mode:           3
 next_event:     150944000000 nsecs
 set_next_event: rk_timer_set_next_event
 shutdown:       rk_timer_shutdown
 periodic:       rk_timer_set_periodic
 event_handler:  tick_handle_oneshot_broadcast

 retries:        0

tick_broadcast_mask: ff

bash-5.1# head -1 /proc/interrupts ; grep rk_timer /proc/interrupts;
sleep 10; grep rk_timer /proc/interrupts
           CPU0       CPU1       CPU2       CPU3       CPU4       CPU5
      CPU6       CPU7
 25:        742        210         52         49       2197       1640
      1089       2341     GICv3 321 Level     rk_timer
 25:        754        222         52         49       2252       1727
      1146       2404     GICv3 321 Level     rk_timer

So it looks like this is working.

Thanks for your work.

You can add my:

Tested-by: Vincent Legoll <vincent.legoll@gmail.com>

Regards

--=20
Vincent Legoll
