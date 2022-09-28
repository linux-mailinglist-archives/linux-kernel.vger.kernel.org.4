Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9305EDBE5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 13:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbiI1LiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 07:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbiI1Lh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 07:37:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6517BF28
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 04:37:55 -0700 (PDT)
Date:   Wed, 28 Sep 2022 13:37:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664365073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gaIVD5wYN/yVh5b5eLakU9sgF+3mfkitytzDMroeUho=;
        b=SP2BhMl+kG5yxiGkfAnEfHEuZ3CXqwOo4Y456IqUmj03Vd+hXdLczHaXe1w2RTmlQMa4/2
        EEJiyNeDJAVIdzPa/wep6L5IxbsltHcIUAXoyRp3hQU9sFdmzj3JH/CUQ4EZyvsUeC8NAV
        nypZay3VKPHKm1xq+nDFy4kUOsPfcQpz/vpYI37tmGlQ37T3f8Ew/76NAr+Tv5xgviW2mN
        R2dVvlVd7SVJxg/k5vaPhdnGHc17KCtLLWa8aKToMUmq8gAmYUGmX4MIg72oTJsiaRGl8R
        85QKUJoR2jqAJu/zRYMYdZRmM2nfMFI43+VY1LeG6yHEs+mZ5j/+JrZoCqy+7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664365073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gaIVD5wYN/yVh5b5eLakU9sgF+3mfkitytzDMroeUho=;
        b=8zZkMfpcdKOLXk2RjZtHKxLMTv1aY6rKvJ1mZab8iRyg4Q3H3XRS4WlcIeHmeFGi15k+8h
        tpKffSOemXY0HNCQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org,
        Sultan Alsawaf <sultan@kerneltoast.com>
Subject: Re: [PATCH] random: avoid reading two cache lines on irq randomness
Message-ID: <YzQyEFMNCcDmJMdX@linutronix.de>
References: <20220923182849.4145148-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220923182849.4145148-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-23 20:28:49 [+0200], Jason A. Donenfeld wrote:
> In order to avoid reading and dirtying two cache lines on every IRQ, move
> the work_struct to the bottom of the fast_pool struct. add_interrupt_
> randomness() always touches .pool and .count, which are currently split,
> because .mix pushes everything down. Instead, move .mix to the bottom,
> so that .pool and .count are always in the first cache line, since the
> .mix is only accessed when the pool is full.
> 
> Fixes: 58340f8e952b ("random: defer fast pool mixing to worker")
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Sultan Alsawaf <sultan@kerneltoast.com>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Yup, makes sense.

Sebastian
