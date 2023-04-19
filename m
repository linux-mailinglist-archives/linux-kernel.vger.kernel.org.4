Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D946E75FE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 11:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbjDSJH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 05:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjDSJHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 05:07:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BC52135
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 02:07:51 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681895270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GCyPWsTIn/hjYZSAOjujfIp5oyXS1amsxY3tt10sDqI=;
        b=XAbbVh9s7WzcPUokMUYdRdJo+MHPt6jzHWwvKW09aWviQOrxPSPo0jkcVjqCjHbU3/6U9W
        RGVIoti6tZSvNztUUaXrD3keDELRBkkv3TgtSVirjBJYnTUn3H6RYsQRZBNiQpP6gDVIxB
        yHixMQMM6OS+mRnNmV43VOP6Lv1lZsdwCFkkhuXFnsMleZuF1mo0xD0n1mJd+xxiTh1sHS
        i0hJiQNh788wl7Zi/QVX/lHYgOE5ySqBhcyaWusjWxcHuc2KAd5jeSc50lORyQRxd6Tbia
        SB5ZzDcnrzg8LTDsYbuib8/fP4uEuu1orgtBF2hHDfog8CSiN/KB0Nt7MF1v4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681895270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GCyPWsTIn/hjYZSAOjujfIp5oyXS1amsxY3tt10sDqI=;
        b=QWHQI1ikUQOUFD6XIjUdAxQWGgcOVr+BdtCs6BB8ghxHuEZSIiLuhsjl8DOw7W+A1QDiKm
        tDmxzKaCBWq4zqCA==
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH] printk: Enough to disable preemption in printk deferred
 context
In-Reply-To: <20230419074210.17646-1-pmladek@suse.com>
References: <20230419074210.17646-1-pmladek@suse.com>
Date:   Wed, 19 Apr 2023 11:11:52 +0206
Message-ID: <87r0sg5jin.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-19, Petr Mladek <pmladek@suse.com> wrote:
> it is safe to interrupt one writer now. The preemption still
> has to be disabled because the deferred context is CPU specific.

Really it is enough to disable migration.

We need to keep an eye on the usage of this function. By allowing
interrupts and preemption, it means that other printk's on that CPU will
also be deferred if the context interrupted within the deferred block.

John
