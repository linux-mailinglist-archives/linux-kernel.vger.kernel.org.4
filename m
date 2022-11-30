Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6927F63D3D8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 11:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233259AbiK3K5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 05:57:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiK3K5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 05:57:18 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF8C1758B
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 02:57:16 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669805835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T/qTFuvSDTyuxtbw1UheUU69WMndDEGtvZ8dq3mS7Wo=;
        b=TokZ/10l9RkiVmqS+ibFGA2Nn+8F5Ekd13h73FlqhlLejZ1E/fZoD4bwbSt9qUG5W/GA+8
        Bp3G+vsz5b1CPSKpalBeslslJEZ/ae1xADF9DxQyqEp4k2i/9HfHJHSlBHLQfuy47PxjCC
        4taINMmqNeKfvlE1Zt+L1029jXWX/eRQXCjP+UnNtdEQA+s67dULKkMoLr9N42z596ziyE
        VaEq18/fDt9rf2BTlod4WGcPlbMtNy3WOOEbzuzn9uyLcf3LXfHIRLwBTctv91uQZEVAB2
        eMpNMfk2QSwsCfnTzcKMU9yhwiWvC99BUKjK6AtnMNT6zRZkXMsju3vIebwvDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669805835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T/qTFuvSDTyuxtbw1UheUU69WMndDEGtvZ8dq3mS7Wo=;
        b=4XAaMV9DDKs8ryi1uMcO9sQ37GXtFxl3eZIyBN1VcaXpduqhPvJmQSFIDc+d5nrU2CrfH1
        lgUx3wiUPViavhAQ==
To:     Jann Horn <jannh@google.com>
Cc:     Andrei Vagin <avagin@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] time/namespace: Refactor copy-pasted helper into
 one copy
In-Reply-To: <CAG48ez1_uq6a4rq_89Ua=2P1jSsDV7u4fCh2y13X9v2JfC5MsA@mail.gmail.com>
References: <20221129191839.2471308-1-jannh@google.com>
 <CAG48ez1_uq6a4rq_89Ua=2P1jSsDV7u4fCh2y13X9v2JfC5MsA@mail.gmail.com>
Date:   Wed, 30 Nov 2022 11:57:14 +0100
Message-ID: <87k03cu2ut.ffs@tglx>
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

On Wed, Nov 30 2022 at 11:15, Jann Horn wrote:
> On Tue, Nov 29, 2022 at 8:18 PM Jann Horn <jannh@google.com> wrote:
>> find_timens_vvar_page() is not arch-specific, as can be seen from how all
>> five per-architecture versions of it are the same.
>> (arm64, powerpc and riscv are exactly the same; x86 and s390 have two
>> characters difference inside a comment, less blank lines, and mark the
>> !CONFIG_TIME_NS version as inline.)
>>
>> Refactor the five copies into a central copy in kernel/time/namespace.c.
>>
>> Marked for stable backporting because it is a prerequisite for the
>> following patch.
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Jann Horn <jannh@google.com>
>
> Should I resend this one without the Cc stable as a standalone cleanup patch?

Yes, please.
