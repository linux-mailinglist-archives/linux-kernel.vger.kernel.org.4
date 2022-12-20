Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F511652874
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 22:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234156AbiLTVhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 16:37:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233959AbiLTVhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 16:37:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3408713CEF
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 13:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671572186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=knEFZp/Br2lwUYLZXfbzI9ZSnZOaTBCXhLfkLB5psow=;
        b=ecXMKQbnA8nLHUESey+9ksl4iB+FZTfuZJB2YTIus9GJ7OcbCIKFvBFSBoBRF7YT/dRUiJ
        YXuyNuS9kaVJbN5i9N+Nkg+ehSCPYIX1dQc4WSjearWrWzpMZc0Wvm5UUEVOlEMZ8edEbZ
        0OWOhHRu/4sj0AUhW2yw1zqxeNZWaXs=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-564-2-GtZi0nOu6SJp5QypTSaA-1; Tue, 20 Dec 2022 16:36:24 -0500
X-MC-Unique: 2-GtZi0nOu6SJp5QypTSaA-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-45dd4fb5580so10646447b3.22
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 13:36:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=knEFZp/Br2lwUYLZXfbzI9ZSnZOaTBCXhLfkLB5psow=;
        b=OfDW5n0Ep7OmIV7BdK7jnepqyQCBR7efg59vqpxNbB32GtFZ1PQjAsOoiahrF/FsoE
         8gYBTCu5xDNd2NBjF/zJx0tB85FnWaSNVWIzXvdNDpNRml00IW5rJypwiEXKIzu8Vn+W
         K/3pBgYAUeULMmrMbYvtA73Ig3KALl7zyZhVPtOxvcjCzi6Po9Q2TiS878nmGdhP3NFj
         Z2tQ65a/hQFakC3xkp3OmwW5Rrrzad7sFaEoedyePDXlJk4uyoH/63DP/2EfoV/x8Iy8
         /hgIrhSs8mWx6SSW/wI1+Worg9ElkyM9SmP7DcOd1pL/WsOO03JJ81h6f2VTeVvY8e0F
         3V3A==
X-Gm-Message-State: AFqh2krVvrjbEPvWCIag/rH9H+ceIYStInafnX/sVyTR7Kxg4Gmh8fg4
        t1kh2rFiUclRYvgI0vxetOm0IVptC3Pxz0un5GiOGy/O7v2b20BvcktzVeiF5BliRge3kcMrEOu
        DleWrAVr7HmMl6cJY8IUXlvB7
X-Received: by 2002:a25:1341:0:b0:750:1a06:a065 with SMTP id 62-20020a251341000000b007501a06a065mr3477891ybt.27.1671572183801;
        Tue, 20 Dec 2022 13:36:23 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsPohFHhtEKKvf6gK73YNmbJSdo8yOT0tgD3pKborKAYbk0JfGgQt+ZczDVgb1x59kgQv6r9Q==
X-Received: by 2002:a25:1341:0:b0:750:1a06:a065 with SMTP id 62-20020a251341000000b007501a06a065mr3477861ybt.27.1671572183536;
        Tue, 20 Dec 2022 13:36:23 -0800 (PST)
Received: from fedora (modemcable149.19-202-24.mc.videotron.ca. [24.202.19.149])
        by smtp.gmail.com with ESMTPSA id u25-20020a37ab19000000b006feea093006sm9457393qke.124.2022.12.20.13.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 13:36:22 -0800 (PST)
Date:   Tue, 20 Dec 2022 16:36:20 -0500
From:   Adrien Thierry <athierry@redhat.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Brian Masney <bmasney@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2 0/5] PM: Fixes for Realtime systems
Message-ID: <Y6Iq1CyHScvZM++Y@fedora>
References: <20221219151503.385816-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219151503.385816-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,
Thanks for looking into this!

I tested your patchset on the QDrive3 on a CentOS Stream 9 RT kernel (I
couldn't test it on mainline because the latest RT patchset only supports
6.1 which is missing some bits needed to boot QDrive3).

It fixes the PSCI cpuidle issue I was encountering in [1]. However, I may
have found another code path that triggers a similar issue:

BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:46
in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 113, name: kworker/4:2
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
4 locks held by kworker/4:2/113:
 #0: ffff09b0c2376928 ((wq_completion)pm){+.+.}-{0:0}, at: process_one_work+0x1f4/0x7c0
 #1: ffff800008bf3dd0 ((work_completion)(&genpd->power_off_work)){+.+.}-{0:0}, at: process_one_work+0x1f4/0x7c0
 #2: ffff09b0c2e44860 (&genpd->rslock){....}-{2:2}, at: genpd_lock_rawspin+0x20/0x30
 #3: ffff09b0c6696a20 (&dev->power.lock){+.+.}-{2:2}, at: dev_pm_qos_flags+0x2c/0x60
irq event stamp: 170
hardirqs last  enabled at (169): [<ffffa1be822f8a78>] _raw_spin_unlock_irq+0x48/0xc4
hardirqs last disabled at (170): [<ffffa1be822f8df4>] _raw_spin_lock_irqsave+0xb0/0xfc
softirqs last  enabled at (0): [<ffffa1be814cfff0>] copy_process+0x68c/0x1500
softirqs last disabled at (0): [<0000000000000000>] 0x0
Preemption disabled at:
[<ffffa1be81d7e620>] genpd_lock_rawspin+0x20/0x30
CPU: 4 PID: 113 Comm: kworker/4:2 Tainted: G               X --------- ---  5.14.0-rt14+ #2
Hardware name: Qualcomm SA8540 ADP (DT)
Workqueue: pm genpd_power_off_work_fn
Call trace:
 dump_backtrace+0xb4/0x12c
 show_stack+0x1c/0x70
 dump_stack_lvl+0x98/0xd0
 dump_stack+0x14/0x2c
 __might_resched+0x180/0x220
 rt_spin_lock+0x74/0x11c
 dev_pm_qos_flags+0x2c/0x60
 genpd_power_off.part.0.isra.0+0xac/0x2d0
 genpd_power_off_work_fn+0x68/0x8c
 process_one_work+0x2b8/0x7c0
 worker_thread+0x15c/0x44c
 kthread+0xf8/0x104
 ret_from_fork+0x10/0x20

This happens consistently during boot. But on the mainline kernel, this
code path has changed: genpd_power_off no longer calls dev_pm_qos_flags.
So it might not happen on mainline. I hope to be able to test your
patchset again soon on mainline with the next version of the RT patchset
(which should be able to boot the QDrive3).

Best,
Adrien

[1] https://lore.kernel.org/all/20220615203605.1068453-1-athierry@redhat.com/

