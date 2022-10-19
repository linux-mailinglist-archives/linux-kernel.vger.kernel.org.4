Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18E060512F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 22:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbiJSUTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 16:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbiJSUTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 16:19:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07980240AC
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 13:19:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7461B822EB
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 20:19:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D90FDC433C1;
        Wed, 19 Oct 2022 20:19:30 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="bbSVGaHM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1666210768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C5fVcK31viwo6cd+Ntr7JvcXlPspuKK/0tBhkAp7rS4=;
        b=bbSVGaHMrn3+fdih8eHeNZKmyvNtAFlmp0SakMWD716TytdSbCA9Urv9G/y5v1txQdL8Vx
        DDizKMClOts+I3M0vy8BhMV5cw9xi8Gu64h5OPb69gI24IaPUm/ZM2A4PgnISpqFLwUcQ6
        H3FQW7LibPmJT2A/wbQJ6d8YFLUzKFI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f73e1fa5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 19 Oct 2022 20:19:27 +0000 (UTC)
Date:   Wed, 19 Oct 2022 14:19:23 -0600
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     "Intel-gfx@lists.freedesktop.org" <Intel-gfx@lists.freedesktop.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, sultan@kerneltoast.com
Subject: Re: [Intel-gfx] signal: break out of wait loops on kthread_stop()
Message-ID: <Y1Bby6FEEWiFIjjD@zx2c4.com>
References: <0029af41-bf24-9972-10ac-f52e1bdcbf08@linux.intel.com>
 <CAHmME9o25v0kZUV-7qEY=6XXAyOA7q0sG8gpQfxHgr3sSVdsWw@mail.gmail.com>
 <41455798-1dcb-135f-516d-25ab9a8082f5@linux.intel.com>
 <Y1A+9kN6bwfXeqVt@zx2c4.com>
 <8acc3e4a-abbc-32bc-626e-7a216f6755c3@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8acc3e4a-abbc-32bc-626e-7a216f6755c3@linux.intel.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 09:09:28PM +0100, Tvrtko Ursulin wrote:
> Hm why is kthread_stop() after kthread_run() abuse? I don't see it in 
> kerneldoc that it must not be used for stopping threads.

Because you don't want it to stop. You want to wait until it's done. If
you call stop right after run, it will even stop it before it even
begins to run. That's why you wind up sprinkling your msleeps
everywhere, indicating that clearly this is not meant to work that way.

> Yep the yields and sleeps are horrible and will go. But they are also 
> not relevant for the topic at hand.

Except they very much are. The reason you need these is because you're
using kthread_stop() for something it's not meant to do.

> Never mind, I was not looking for anything more than a suggestion on how 
> to maybe work around it in piece as someone is dealing with the affected 
> call sites.

Sultan's kthread_work idea is probably the right direction. This would
seem to have what you need.

Jason
