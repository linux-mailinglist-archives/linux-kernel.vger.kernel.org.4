Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E193162F2FF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 11:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241795AbiKRKwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 05:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241305AbiKRKwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 05:52:51 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5DB97AAD
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 02:52:50 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668768768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DrAeyyOOLCFOu14hr1MLJagcvE2p2H7Ye29s2ft7FsY=;
        b=xnSQuNK9PSTD6lLLJg92XTab/tZ4QZsITFFgNFa6QoyK+J2wXKoV+OxjLwtEB8Z9xmcEwT
        TM1mAemMolvMgOBwNeXMa3mWWwINxGIX5+I9dvwSmcNRxHxQOYmg+NJYz5xQzM+FJQFr/D
        3uqiCx6zsKc+UkZ+FTeJmLf3fktNb52zXRsVsuI7Ekp9r6jN3kr/UPwrRva9WBwQHjrNia
        XHmJmqF+sjYvPPzLZVsV4cUb6EbRcQHxB//NQMl0g3uGCMXavdSKwCuI/kdWLhNtjDmxnS
        cziUgkUG1qVIBfYX9gbtdPFB1Vv9ezTa5aBPz6oXurRB3pyoj7L1UibwHEhbrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668768768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DrAeyyOOLCFOu14hr1MLJagcvE2p2H7Ye29s2ft7FsY=;
        b=G4Xr5YhQ5PvUALojWnddUoAia3zYcm6lUI8k7abwUzH9LBK1/ns2JNhkjkqUUQzwOXvWR7
        SlbWvNIlq8ULlLDA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v5 06/40] printk: fix setting first seq for consoles
In-Reply-To: <Y3ddONIRAGp5dBGJ@alley>
References: <20221116162152.193147-1-john.ogness@linutronix.de>
 <20221116162152.193147-7-john.ogness@linutronix.de>
 <Y3ddONIRAGp5dBGJ@alley>
Date:   Fri, 18 Nov 2022 11:58:44 +0106
Message-ID: <87o7t48rgj.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-18, Petr Mladek <pmladek@suse.com> wrote:
> Another improvement might be to disable handover in this case.
> It would be safe because we are in a sleepable context.
> It would increase the chance that console_flush_all() succeeded.

I also considered this. The problem is that you cannot disable the
handover with the current API and it seemed crazy to dig all the up just
for this.

> We could do this later when there are problems with this approach.
> The problem with the handover has been there even before.

Agreed.

> I do not want to delay this patchset by discussion this non-critical
> problem to the death ;-)

Thanks! :-)

John
