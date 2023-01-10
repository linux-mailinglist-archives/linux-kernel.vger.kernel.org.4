Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9D8663FF9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 13:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbjAJMLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 07:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238151AbjAJMLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 07:11:12 -0500
Received: from gentwo.de (gentwo.de [161.97.139.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB1C848CE
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 04:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.de; s=default;
        t=1673351912; bh=447xrWnDqvwlUVdeSyRqpMKeorpuhhxwz0VX/chL6q4=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=OQdljGZJ7GEaR+2T0y2kTi4JRaIidDrAhbBtRiwLY1g6Tn7oFLTGivZm/lMhfr950
         AhsWj14TGatRgkkTh68n+6T6xbMynu3m5ib4Z/waZKDvdDDqdtoEhhELYXPQap9O77
         Fw/UGoQ+wtntKA96aBps0Un6+y7U3JRUdAcfckf4gMb3TYdUVH7oKBhDm9ljXRMe5J
         I8Xs09inSfKfZD7hEEBapr4DpvkO1pZf5Z06hyPPNGeaZu6yd8t/iZ5zqeXzA4E/mC
         9QSmtJNgT4hXnPRFtLuFz5jmZRyexjOGN06ifMc5SiYKs7PxgIOaEb2Nexv/Tno1Ts
         MV+naO0HGB9Wg==
Received: by gentwo.de (Postfix, from userid 1001)
        id B32AAB001C8; Tue, 10 Jan 2023 12:58:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id B1C18B00101;
        Tue, 10 Jan 2023 12:58:32 +0100 (CET)
Date:   Tue, 10 Jan 2023 12:58:32 +0100 (CET)
From:   Christoph Lameter <cl@gentwo.de>
To:     Marcelo Tosatti <mtosatti@redhat.com>
cc:     atomlin@atomlin.com, frederic@kernel.org, tglx@linutronix.de,
        mingo@kernel.org, peterz@infradead.org, pauld@redhat.com,
        neelx@redhat.com, oleksandr@natalenko.name,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v13 1/6] mm/vmstat: Add CPU-specific variable to track
 a vmstat discrepancy
In-Reply-To: <20230105125248.772766288@redhat.com>
Message-ID: <e9673684-ef3-4070-18bd-2f20fbfe8d5@gentwo.de>
References: <20230105125218.031928326@redhat.com> <20230105125248.772766288@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jan 2023, Marcelo Tosatti wrote:

> +static inline void vmstat_mark_dirty(void)
> +{
> +	this_cpu_write(vmstat_dirty, true);
> +}

this_cpu_write() is intended for an per cpu atomic context. You are not
using it in that way. The processor may have changed before or after and
thus vmstat_dirty for another CPU may  have been marked dirty.

I guess this would have to be called __vmstat_mark_dirty() and be using
__this_cpu_write(*) with a requirement that preemption be disabled before
using this function.

> +static inline void vmstat_clear_dirty(void)
> +{
> +	this_cpu_write(vmstat_dirty, false);
> +}

Same

> +static inline bool is_vmstat_dirty(void)
> +{
> +	return this_cpu_read(vmstat_dirty);
> +}

This function would only work correctly if preemption is disabled.
Otherwise the processor may change.
