Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10FAF6E255E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 16:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjDNONT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 10:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjDNONQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:13:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1190AB8;
        Fri, 14 Apr 2023 07:12:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37B1E6108E;
        Fri, 14 Apr 2023 14:12:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95A5FC433D2;
        Fri, 14 Apr 2023 14:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681481524;
        bh=yENni4rtGannMxtEPDySiSRFlOYKe6I+J3yRkTZc2SE=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=QtBlmv5MuuwgEVZLl5y83VF6tBhCGHUJNkXkBDlttU4hsvfyuD4vsiyqBjYDZxjHf
         E2RB7On2S1WEfNC/CFMFqVA5v10w/q+cRjupfKANMfldOCZwpfdbAEaA94FM+XXQiX
         lg4Yl7ygODAv8HG5rdQbpDJNOkeqhXrMqwlxOQT67/vqwpw1fbFJ8LwPGJD+jvB8+J
         q3FhcUIjYx0KyUS1XqqrynEhuKRMHXjjOnIX5ZTxLJbDvvdyFU+HEYDCMp22V+hQs1
         JQeyAlvdysSESZQ3Mrvb+KMYTycv+qYysaNXgYSLVRCctYQE9i7rZLCisrg5wX0GLq
         H+GVKzfedS4fw==
Date:   Fri, 14 Apr 2023 16:12:01 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Rahul Rameshbabu <rrameshbabu@nvidia.com>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] HID: shield: Initial driver implementation with
 Thunderstrike support
In-Reply-To: <87a5zbhrdf.fsf@nvidia.com>
Message-ID: <nycvar.YFH.7.76.2304141611320.29760@cbobk.fhfr.pm>
References: <20230410170840.16119-1-rrameshbabu@nvidia.com> <20230410170840.16119-2-rrameshbabu@nvidia.com> <nycvar.YFH.7.76.2304131705350.29760@cbobk.fhfr.pm> <87a5zbhrdf.fsf@nvidia.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Apr 2023, Rahul Rameshbabu wrote:

> The reason why I disable interrupts is because I call
> thunderstrike_update_haptics from the play_effect callback I pass to
> input_ff_create_memless. From there, it is used in ml_effect_timer
> drivers/input/ff-memless.c, which is a timer interrupt context so we
> should disable interrupts when taking haptics_update_lock.
> 
>   static void ml_effect_timer(struct timer_list *t)
>   {
>     struct ml_device *ml = from_timer(ml, t, timer);
>     struct input_dev *dev = ml->dev;
>     unsigned long flags;
> 
>     pr_debug("timer: updating effects\n");
> 
>     spin_lock_irqsave(&dev->event_lock, flags);
>     ml_play_effects(ml);
>     spin_unlock_irqrestore(&dev->event_lock, flags);
>   }

Ah, right, I missed that, it indeed runs in softirq context. Please 
disregard my comment.

Thanks,

-- 
Jiri Kosina
SUSE Labs

