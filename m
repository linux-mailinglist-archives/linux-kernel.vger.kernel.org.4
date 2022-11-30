Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9313163D16D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 10:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbiK3JL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 04:11:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbiK3JLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 04:11:24 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B853C6FB
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 01:11:23 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669799482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gYVcaZfHsDnq3Jr0MQcZMxi6w0dAYqbQqAdgN1gLAIc=;
        b=M9Cmst7VuI4zXCi/VmFjfeAe3sGGjF3cLaBLESfNqU19KMcL82k7okkWQLJJKZPi/Idn5A
        q4ujoFJ4SODJBWvGg/MUZeFdvtp4oSJPbkG3Hf5GZTXGCIqJJdDRVFGYWF2EUJeKW/34A+
        R0QLZdTJEjPJHftpdbuT2uUlvu/5cB7R1pGuzBpzm6I6nuh4l/nLAWiLm8I2R+wqjRShy7
        Ld//59TruGPQzbWZAtNgD6HSz5iCZmmF0UVkHiwvj25TjCdGx119N2+7SYO6bsS/OZv9W1
        YRx16z1CjUN1yGpV4XRt9Anoo2478brFt1zWt6I1xz8THUgspgadVfvWxLc2ag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669799482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gYVcaZfHsDnq3Jr0MQcZMxi6w0dAYqbQqAdgN1gLAIc=;
        b=Teh74LVuWlkiETMMXA72/ttIvMTYlCwFvnZUj69tRsX0J5/sCKylDVOOcb5zIvi6baM94m
        PHMLJiAbtV+kDyAQ==
To:     yang.yang29@zte.com.cn, pmladek@suse.com
Cc:     senozhatsky@chromium.org, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, xu.panda@zte.com.cn,
        yang.yang29@zte.com.cn
Subject: Re: [PATCH linux-next] printk: use strscpy() to instead of strlcpy()
In-Reply-To: <202211301601416229001@zte.com.cn>
References: <202211301601416229001@zte.com.cn>
Date:   Wed, 30 Nov 2022 10:17:07 +0106
Message-ID: <874jugx0wk.fsf@jogness.linutronix.de>
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

On 2022-11-30, <yang.yang29@zte.com.cn> wrote:
> From: Xu Panda <xu.panda@zte.com.cn>
>
> The implementation of strscpy() is more robust and safer.
> That's now the recommended way to copy NUL terminated strings.
>
> Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
> Signed-off-by: Yang Yang <yang.yang29@zte.com>

This looks fine, but I am wondering if we should also replace all
strncpy() usage as well. AFAICT they can all be replaced. It would also
avoid the manual termination in console_setup().

John Ogness
