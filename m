Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF3A6E0D52
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 14:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjDMMPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 08:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjDMMPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 08:15:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F7444B9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 05:15:00 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681388099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4QfYwRPfnM/Po+5MIv+BG5XMFxPKkXy7wz721JHgBQI=;
        b=B531b35YHBrpw26GHLb57Uho47R50AUviok7HTPWskXFW1g1fG0l/+PV1gqxXEqzXDKLJn
        JuezMpiAR7FLnAQtGuqbnKHCIXPNlFVT3DNXyfJGEa6wGHB//kbmp7u8XyEYpNOvDNDlYB
        0Se7qSVMzqudRuW9bN9dMQIJBiIflntebNRk2jUZrbxtA3lEuNpkwqz0l9ipKz9rcz/GH2
        BOAoLfb4Aa/9vjxqPl9eZM5AA8BoAjj6NRKsVKFelQ5eNSeURXivax0LTzOJZrOknd8yEg
        TE79WtW1SeYVg9ChoSxdP+MYrWQi7+Jc/YjTXG6JgYFYq0jRTe04rzLFqQzGyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681388099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4QfYwRPfnM/Po+5MIv+BG5XMFxPKkXy7wz721JHgBQI=;
        b=EZU+eKjOlY9Gc17m58XeZuC+aQkOobzpsI5OQwrQtZMDCp8FUmlDSHIoJmabnZVVFo9uj3
        YrKczjstcnh/tTBg==
To:     Stephen Boyd <swboyd@chromium.org>, Schspa Shi <schspa@gmail.com>
Cc:     longman@redhat.com, linux@roeck-us.net, wuchi.zero@gmail.com,
        linux-kernel@vger.kernel.org,
        syzbot+5093ba19745994288b53@syzkaller.appspotmail.com
Subject: Re: [PATCH] debugobject: Prevent init race with static objects
In-Reply-To: <CAE-0n53hCtzhFN+XdYVqXVzhpciLBubYhDu7-wXEZLVu3xmXNQ@mail.gmail.com>
References: <20230303161906.831686-1-schspa@gmail.com> <87bkl9jt3a.ffs@tglx>
 <m2ttycd8kx.fsf@gmail.com> <87sfdw8yru.ffs@tglx> <87pm908xvu.ffs@tglx>
 <87zg7dzgao.ffs@tglx>
 <CAE-0n53hCtzhFN+XdYVqXVzhpciLBubYhDu7-wXEZLVu3xmXNQ@mail.gmail.com>
Date:   Thu, 13 Apr 2023 14:14:58 +0200
Message-ID: <87r0soyo59.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12 2023 at 17:17, Stephen Boyd wrote:
> Quoting Thomas Gleixner (2023-04-12 00:54:39)
>> +       /* If NULL the allocaction has hit OOM */
>
> s/allocaction/allocation/

That's what I probably wanted to type.

>> -       obj = lookup_object(addr, db);
>> +       /* If NULL the allocaction has hit OOM */
>
> Same comment.

The wonders of copy & pasta!

Thanks for the review!

       tglx
