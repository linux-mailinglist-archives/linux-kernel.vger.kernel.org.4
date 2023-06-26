Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17BEE73E221
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 16:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjFZO17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 10:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjFZO15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 10:27:57 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276F0194
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 07:27:56 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fa8cd4a1f2so13414965e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 07:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687789674; x=1690381674;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4DnGyVoee8gvGuSTj8BLFAgu78VLTgNZVx6wVHkdXbQ=;
        b=LwYwK+/i0bFdFZGaDi24JeRIDv6mzwkLHYe3k8g7oGo1ClMh7V5+CaEThR6xOldga5
         ijp1ruDfBiLS3Bgv8iuIaBaYgHibEqdOak3qSOeKgFwUcbNZDQme5SFUgNDOBNCVT2Qn
         7lITrSHmspgfWdg0h5WjjB4ddRtC/Jr3UjNWCAXnkwHLkmFafq7kdIrqktjwTW5G7hwv
         rO3xHl/32vdk1QtigyH9L7RT+fG62cvqxejAvJ7ms5UWdC7PIE8KkeabfyHd9usols1P
         V3kjVEVZsffqt+r8CNLrFCXODgIcci9L+EPJrRWIkdrHcMZYIqyxOWtJjFlS89HjYBDH
         KIew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687789674; x=1690381674;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4DnGyVoee8gvGuSTj8BLFAgu78VLTgNZVx6wVHkdXbQ=;
        b=DnT8lyNgMlfO9ZjN1+jj3fivtlf0SZJ7LpqJvdBebLAK+qAeqcxzE+Cfo3jXN+3XJP
         8OVLCu/r74lFVjDNp5V65mVGsVd6VkogojNbPMU9zQZZriSGq8VtJNUPdnGz4q7Wz8h7
         JPsKE7ZPG1HavHi42J/bZ1CF9P4Icgc+J5wnb82iBGWOT16zj4BvPm8fjvBVaOIS4AK8
         hO8Lw770cK2eXX15ATPb33K0rORscaU1EtxuQr1azGupSrQfZ8xgPYSgkjLPAfwkVnEG
         KloNknPMEmL3qCduD8FfjkALPDCaJWQ4qc7BcWGnGzf3IFbWqy46WBD/spMK3QrUYLTO
         XMAw==
X-Gm-Message-State: AC+VfDwGtCQ6yMzheP5iw8VW+IUvsEG+JgEpsNgL4DZG9h9GKxuJJyjD
        VW2Yj8fA/5ml/QRZQZzC1/G5gw==
X-Google-Smtp-Source: ACHHUZ5XIfVFgiVsCRS/7OXRvpEvOG87JJDUFfAi0DygtyZj6YDzuRIuF9OVvfa8xcoBU4ZFnTj1uw==
X-Received: by 2002:adf:f8cd:0:b0:313:f4f5:2ddc with SMTP id f13-20020adff8cd000000b00313f4f52ddcmr1361891wrq.62.1687789674566;
        Mon, 26 Jun 2023 07:27:54 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id d13-20020a5d4f8d000000b003063db8f45bsm7559591wru.23.2023.06.26.07.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 07:27:54 -0700 (PDT)
Date:   Mon, 26 Jun 2023 15:27:52 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Mans Rullgard <mans@mansr.com>
Cc:     Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: led_bl: take led_access lock when required
Message-ID: <20230626142752.GA95170@aspen.lan>
References: <20230619160249.10414-1-mans@mansr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619160249.10414-1-mans@mansr.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2023 at 05:02:49PM +0100, Mans Rullgard wrote:
> The led_access lock must be held when calling led_sysfs_enable() and
> led_sysfs_disable().  This fixes warnings such as this:
>
> [    2.432495] ------------[ cut here ]------------
> [    2.437316] WARNING: CPU: 0 PID: 22 at drivers/leds/led-core.c:349 led_sysfs_disable+0x54/0x58
> [    2.446105] Modules linked in:
> [    2.449218] CPU: 0 PID: 22 Comm: kworker/u2:1 Not tainted 6.3.8+ #1
> [    2.456268] Hardware name: Generic AM3517 (Flattened Device Tree)
> [    2.462402] Workqueue: events_unbound deferred_probe_work_func
> [    2.468353]  unwind_backtrace from show_stack+0x10/0x14
> [    2.473632]  show_stack from dump_stack_lvl+0x24/0x2c
> [    2.478759]  dump_stack_lvl from __warn+0x9c/0xc4
> [    2.483551]  __warn from warn_slowpath_fmt+0x64/0xc0
> [    2.488586]  warn_slowpath_fmt from led_sysfs_disable+0x54/0x58
> [    2.494567]  led_sysfs_disable from led_bl_probe+0x20c/0x3b0
> [    2.500305]  led_bl_probe from platform_probe+0x5c/0xb8
> [    2.505615]  platform_probe from really_probe+0xc8/0x2a0
> [    2.510986]  really_probe from __driver_probe_device+0x88/0x19c
> [    2.516967]  __driver_probe_device from driver_probe_device+0x30/0xcc
> [    2.523498]  driver_probe_device from __device_attach_driver+0x94/0xc4
> [    2.530090]  __device_attach_driver from bus_for_each_drv+0x80/0xcc
> [    2.536437]  bus_for_each_drv from __device_attach+0xf8/0x19c
> [    2.542236]  __device_attach from bus_probe_device+0x8c/0x90
> [    2.547973]  bus_probe_device from deferred_probe_work_func+0x80/0xb0
> [    2.554504]  deferred_probe_work_func from process_one_work+0x228/0x4c0
> [    2.561187]  process_one_work from worker_thread+0x1fc/0x4d0
> [    2.566925]  worker_thread from kthread+0xb4/0xd0
> [    2.571685]  kthread from ret_from_fork+0x14/0x2c
> [    2.576446] Exception stack(0xd0079fb0 to 0xd0079ff8)
> [    2.581573] 9fa0:                                     00000000 00000000 00000000 00000000
> [    2.589813] 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    2.598052] 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> [    2.604888] ---[ end trace 0000000000000000 ]---
>
>
> Signed-off-by: Mans Rullgard <mans@mansr.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
