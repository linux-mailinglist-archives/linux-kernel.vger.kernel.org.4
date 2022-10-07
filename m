Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B86B75F74B5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 09:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiJGH33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 03:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiJGH31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 03:29:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB99A8CC5;
        Fri,  7 Oct 2022 00:29:26 -0700 (PDT)
Date:   Fri, 7 Oct 2022 09:29:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1665127764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lm+zJyR+J0G7xaOdlpm9edaU2VI7rEYfISYTe41x2PI=;
        b=1+2khprDTIdzHGT8gt5NhRut+zyzZ8CxhkV/oPv1dk8sj+Vpvf1NpGTbi3vStdqKfJNyC2
        H6I25/mr3cEs/pVduMdjjGX6P9xCHCu9slxeyI330aXwozBAsawDeZXwf3puTOOvSRfTeB
        AdnjgkQibDQLCveE5/FN9ai3SxCimFq+pcHvUdGNqJFquccW0CE2ijMh+qxgIaSvm6D/QB
        K6cW+coCp+zD28NjSprpOdGoCJI/Uf7pFwxoBH/uB1tq4jLleSaVG/JswoI2AtizwMqnuh
        ttAn3hrwDeDAjFBynQyfaDMh7q47owBSMA9Hc9LS8d7EOsWXl6RhQbiGmCxwAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1665127764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lm+zJyR+J0G7xaOdlpm9edaU2VI7rEYfISYTe41x2PI=;
        b=VYPDss3M7TloK6FZDiEAotco6oYekfafspRvFm0VQJ98qrcYv7Q4TxpNt0kbx76i7zUrXP
        RLxZ9QcIG9GZpyAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Sultan Alsawaf <sultan@kerneltoast.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH 2/2] random: spread out jitter callback to different CPUs
Message-ID: <Yz/VU/FhdgspxFdh@linutronix.de>
References: <20220930231050.749824-1-Jason@zx2c4.com>
 <20220930231050.749824-2-Jason@zx2c4.com>
 <YzgGmh6EQtWzO4HV@zx2c4.com>
 <Yz2+UsgVGRSm+o7W@linutronix.de>
 <Yz3yQzaNUcdIuUMX@zx2c4.com>
 <Yz55w4gNtZn8JzmG@linutronix.de>
 <Yz7JXEaTFWa1VLKJ@zx2c4.com>
 <Yz7M5zJmzKSk/LYH@linutronix.de>
 <Yz8E0lSmsMMB6KeO@sultan-box.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yz8E0lSmsMMB6KeO@sultan-box.localdomain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-06 09:39:46 [-0700], Sultan Alsawaf wrote:
> Hi Sebastian,
Hi Sultan,

> But since a timer is marked as not-pending prior to when it runs, add_timer_on()
> can't detect if the timer is actively running; the above BUG_ON() won't be
> tripped. So the UaF scenario I forsee is that doing this:
>     add_timer_on(timer, 0);
>     // timer is actively running on CPU0, timer is no longer pending
>     add_timer_on(timer, 1); // changes timer base, won't wait for timer to stop
>     del_timer_sync(timer); // only checks CPU1 timer base for the running timer

/me taking notes.

> Sultan

Sebastian
