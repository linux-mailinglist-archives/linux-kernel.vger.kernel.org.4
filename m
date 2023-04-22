Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C886EB9F3
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 17:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjDVPP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 11:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjDVPP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 11:15:57 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF4F9E;
        Sat, 22 Apr 2023 08:15:56 -0700 (PDT)
Received: from [192.168.1.90] (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D430F6603273;
        Sat, 22 Apr 2023 16:15:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1682176554;
        bh=X0mUkWfbzwnY1styVLWorvkjJxYiao2ZcpZFSg7WGBg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Dk0lIkG1Nxu4OoOc57Mos8kM5WKz6Le9oR0FGuBfBl/8YsoaZEZ4VmF2D8Qw4qTnG
         24wwzRrzRTnu9lKWsl9MFO1RysppuzJj+emZpRBYwVgtTm5YH7OZxui2W1jv7yPWJx
         HGpGV9WVZPs4ohtJ8oMI9U2I4B51O7nfFH6EmIvRGinyXXnh7Vnfp27FHDuxdoD3cn
         V9CZ9SFC/K76uVE5eFB1StC084yIgAX/S07bdXc0PD4sY/g/IdDepyYpuU4WYTnbfi
         I6q80HOxTO8xC+25Py9ryjyxCHM+NWqrSxllj23cN24cZx75drgKUm2i8SDIp5gDmV
         zlTdwdc/3BFHw==
Message-ID: <80d23bb9-b55a-57c5-4aa1-d29a919b04ae@collabora.com>
Date:   Sat, 22 Apr 2023 18:15:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 0/3] Enable rk3588 timer support
Content-Language: en-US
To:     Vincent Legoll <vincent.legoll@gmail.com>
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
References: <20230419181309.338354-1-cristian.ciocaltea@collabora.com>
 <CAEwRq=o71XMoj6_QU-mKrrrBqz80=C0g4fMwejv7fN-vAop89w@mail.gmail.com>
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <CAEwRq=o71XMoj6_QU-mKrrrBqz80=C0g4fMwejv7fN-vAop89w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/23 16:17, Vincent Legoll wrote:
> Hello,
> 
> On Wed, Apr 19, 2023 at 6:13 PM Cristian Ciocaltea
> <cristian.ciocaltea@collabora.com> wrote:
>> This patchset enables Rockchip RK3588/RK3588S SoC timer support.
>> While here, it also handles a minor DT binding issue related to RK3288.
> 
> I tested this on a QuartzPro64 dev board, I applied your series top of my tree:
> Collabora's rk3588 + some DT patches to add support for the qp64 board.
> 
> Here is the output from the commands you told me to try:
> 
> bash-5.1# grep rk_timer /sys/bus/clockevents/devices/*/current_device
> /sys/bus/clockevents/devices/broadcast/current_device:rk_timer
> 
> bash-5.1# grep -B3 -A14 'Device: rk_timer' /proc/timer_list
> 
> Tick Device: mode:     1
> Broadcast device
> Clock Event Device: rk_timer
>  max_delta_ns:   178956969070
>  min_delta_ns:   1000
>  mult:           51539608
>  shift:          31
>  mode:           3
>  next_event:     150944000000 nsecs
>  set_next_event: rk_timer_set_next_event
>  shutdown:       rk_timer_shutdown
>  periodic:       rk_timer_set_periodic
>  event_handler:  tick_handle_oneshot_broadcast
> 
>  retries:        0
> 
> tick_broadcast_mask: ff
> 
> bash-5.1# head -1 /proc/interrupts ; grep rk_timer /proc/interrupts;
> sleep 10; grep rk_timer /proc/interrupts
>            CPU0       CPU1       CPU2       CPU3       CPU4       CPU5
>       CPU6       CPU7
>  25:        742        210         52         49       2197       1640
>       1089       2341     GICv3 321 Level     rk_timer
>  25:        754        222         52         49       2252       1727
>       1146       2404     GICv3 321 Level     rk_timer
> 
> So it looks like this is working.
> 
> Thanks for your work.
> 
> You can add my:
> 
> Tested-by: Vincent Legoll <vincent.legoll@gmail.com>

Thanks for taking the time to test this!

Regards,
Cristian
