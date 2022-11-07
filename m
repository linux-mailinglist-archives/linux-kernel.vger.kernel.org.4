Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C783861F09C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 11:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbiKGK14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 05:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbiKGK1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 05:27:52 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004AE167CE
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 02:27:51 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667816870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W4ig8W5pzngbxp7sUAaNCRWLphNj78HmsgMSAcQTiIU=;
        b=ToJOeuoXQqapHghob71VdvXHy7FXzsyECQIu6mQpZT/cZsRg29T912FmMiTreHjRnRlLzt
        C4fGSMTbxc09VMZB3s5ZcdkymcnLkCEbGqZWFX3xgvHMJlZ42+CIbm5YfN5H5RFyAHSxY0
        3GZp1icyPFwvti6qBqTKy8D0RKEVr+IjdXRQLXeoXrCt42yRc6oiA1vJfP0mk4WAXyFdZJ
        wjQdgsKSiYjuOerzbD+kkxZsKCGKL28UqyneqxlCCTPgtJ4tB9VxVdB5C6vkD6CKiD8s16
        dSZ/mQIvHNFkZmEi9lShdDzp1+C9vDpH6ByES4iZtRj6dNPkTZIRncvHeWar/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667816870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W4ig8W5pzngbxp7sUAaNCRWLphNj78HmsgMSAcQTiIU=;
        b=TPxcoSqU7chW3+snTy/ipS/OcTzw5fWDwczmCV+QQtewfnjIhH+CLdaVsdj81LnzFD2b0X
        DI9kY8NrlKVjllBA==
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Julia Lawall <Julia.Lawall@inria.fr>
Subject: Re: [for-linus][PATCH 4/5] timers: Add timer_shutdown_sync() and
 timer_shutdown() to be called before freeing timers
In-Reply-To: <20221106233434.425162916@goodmis.org>
References: <20221106233037.815236769@goodmis.org>
 <20221106233434.425162916@goodmis.org>
Date:   Mon, 07 Nov 2022 11:27:49 +0100
Message-ID: <87v8nrvz2y.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 06 2022 at 18:30, Steven Rostedt wrote:
> -#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT)
>  /**
> - * del_timer_sync - deactivate a timer and wait for the handler to finish.
> + * __del_timer_sync - deactivate a timer and wait for the handler to finish.
>   * @timer: the timer to be deactivated
> + * @free: Set to true if the timer is about to be freed
>   *
>   * This function only differs from del_timer() on SMP: besides
>   deactivating

How is this comment still correct?

Thanks,

        tglx
