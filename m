Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0EF261A07A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 20:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiKDTCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 15:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiKDTCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 15:02:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A8743875
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 12:02:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FD61622CF
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 19:02:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25E15C433D6;
        Fri,  4 Nov 2022 19:02:12 +0000 (UTC)
Date:   Fri, 4 Nov 2022 15:02:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Noralf =?UTF-8?B?VHLDuG5uZXM=?= <noralf@tronnes.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Subject: Re: [RFC][PATCH v3 13/33] timers: drm: Use timer_shutdown_sync()
 before freeing timer
Message-ID: <20221104150210.1b147688@rorschach.local.home>
In-Reply-To: <ab708fad-9390-2b11-19d8-3e2635254f29@linux.intel.com>
References: <20221104054053.431922658@goodmis.org>
        <20221104054914.271196777@goodmis.org>
        <ab708fad-9390-2b11-19d8-3e2635254f29@linux.intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Nov 2022 08:48:28 +0000
Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com> wrote:

> If it stays all DRM drivers in one patch then I guess it needs to go via 
> drm-misc, which for i915 would be okay I think in this case since patch 
> is extremely unlikely to clash with anything. Or split it up per driver 
> and then we can handle it in drm-intel-next once core functionality is in.
> 
> We do however have some more calls to del_timer_sync, where freeing is 
> perhaps not immediately next to the site in code, but things definitely 
> get freed like on module unload. Would we need to convert all of them to 
> avoid some, presumably new, warnings?


I'm happy to split this patch up. I just got a bit lazy and started
just grouping via entire subsystems. You should see the networking
patch ;-)

-- Steve
