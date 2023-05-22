Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E7670BA3C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 12:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbjEVKfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 06:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232538AbjEVKe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 06:34:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFD0E6
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 03:34:55 -0700 (PDT)
Date:   Mon, 22 May 2023 12:34:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684751694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SU8vWQ4YXeIMny1KBm3V6Rn7t6JaFAW4SSC0aQ1uE4s=;
        b=OEpZLpEt2CdHdY29GjxWEcbpghhu8bcJHLApfaPGXVkqo6FoyR2h+yHRqXba0uZEJq/xJ+
        QpGRN5MDxrqc/FL4fwFAiQPAFbZwJ/g4ZgLATkOMP2dg3pa8PAyxf578GDunr2sOhLSMUQ
        H49Zx5Gr6C3oleFiXrkq4KHzjeEgUC8CufOUIo0KiP+JPGsLRB8E/5JSN1r+4ZTrmuvJy4
        wE0PB0G2mHpcxsUMlFBIsAJQYr7HmJl2RnJRbvKZMkYhEHDxH4XFbl4UN+V5T6oAlgXqSN
        vdF1d9w9v1TAh05xkKW/N2jpzLmr/PVieAjOHE9l46/Y4glaLLE5xT3AzXjFKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684751694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SU8vWQ4YXeIMny1KBm3V6Rn7t6JaFAW4SSC0aQ1uE4s=;
        b=f6k022gTr9FFsQ96olFXCa9ZgvcdHKKBBvRc49unuaAWQm6Z6ISxGtJlbZCxdkhLYlUjcc
        fZqPfl75zh7nYTDw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Mike Galbraith <efault@gmx.de>,
        lkml <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: r8169: disable ASPM during NAPI poll locking changes --> BUG:
 Invalid wait context --> PREEMPT_RT pain
Message-ID: <20230522103452.2jMLhlFq@linutronix.de>
References: <e55be0ae115ad6494ebb48fecd03e5c2fe528230.camel@gmx.de>
 <28727b435c143f15feddffb4c29095fee2500dff.camel@gmx.de>
 <20230522080604.MgUGcyeU@linutronix.de>
 <59e86f97-3e77-14e0-948a-1a87ccf72f36@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <59e86f97-3e77-14e0-948a-1a87ccf72f36@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-22 12:32:38 [+0200], Heiner Kallweit wrote:
> What do you mean with "but can't"? Taking a spinlock in hardirq context
> is normal.

I'm crafting a patch, testing and will send it with full explanation.

> > 
> >> 	-Mike

 Sebastian
