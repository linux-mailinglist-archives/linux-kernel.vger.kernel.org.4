Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D025363DB87
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 18:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbiK3RFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 12:05:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiK3RFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 12:05:11 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044E993A6D;
        Wed, 30 Nov 2022 09:00:10 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669827608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jjMJHHMyqhLkfdRT9iuq6XDxjOMpNYWRh37e3CUD8CA=;
        b=myw6xp0Dnh3wwdR9mqSMUGj3QLWVHrv3/yXT7NjbHjRyxY9pUsSss8Z8aQM9P2DmDPrhaM
        eWMFC84xT/a0H4sxUxGZUZ6yCGiAFB2e3GLuEx91WZcQxNgk/jUYPyCEXek2Kbyz4+jrzN
        Wr9+ncWyqDUTrtelfTt7aay3V0OXjsIEGltNPxEtRvm4ghKJ2P+hheZ7edosjd5QsxX6lK
        LIy59LGxYxAS2FYQhXap3hW8STItheNzupoh3THyZGDzOXa0civJEj+W7l92jvSdiNHsVh
        ymyJ4T7P1Bfn4ftp8M2KogW7kNeRThl2pVhz5bFd7flBvtnt0r77x1YbEy/1ag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669827608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jjMJHHMyqhLkfdRT9iuq6XDxjOMpNYWRh37e3CUD8CA=;
        b=DcLE/BRRpt3HcZ/qS1N/9ABGBGH7ajSS8N2HyEb/sZFissGqPJYdutBNvp1kCdXlBIYuWK
        +ohCGzV0qQNKpgCA==
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Florian Weimer <fweimer@redhat.com>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, linux-crypto@vger.kernel.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v10 3/4] random: introduce generic vDSO getrandom()
 implementation
In-Reply-To: <CAHmME9oGffi539nEAJkOjC-2yAR+0Ra+wQw5oG6Y6+CRr5e62g@mail.gmail.com>
References: <20221129210639.42233-1-Jason@zx2c4.com>
 <20221129210639.42233-4-Jason@zx2c4.com>
 <878rjs7mcx.fsf@oldenburg.str.redhat.com> <Y4dt1dLZMmogRlKa@zx2c4.com>
 <Y4dvz4d0dpFzJZ9L@zx2c4.com>
 <16ec2a7a-c469-4732-aeca-e74a9fb88d3e@app.fastmail.com>
 <CAHmME9rpdCGLQzfsNkX=mLHfWeEWi4TyrOf_2rP_9hsyX9v6ow@mail.gmail.com>
 <574ad32d-566e-4c18-a645-1470fc081ede@app.fastmail.com>
 <CAHmME9oGffi539nEAJkOjC-2yAR+0Ra+wQw5oG6Y6+CRr5e62g@mail.gmail.com>
Date:   Wed, 30 Nov 2022 18:00:07 +0100
Message-ID: <8735a0tm20.ffs@tglx>
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

On Wed, Nov 30 2022 at 16:47, Jason A. Donenfeld wrote:
> On Wed, Nov 30, 2022 at 4:29 PM Arnd Bergmann <arnd@arndb.de> wrote:
>> I see what you mean now. However this means your vdso32 copies
>> are different between 32-bit and 64-bit kernels. If you need to
>> access one of the fields from assembler, it even ends up
>> different at source level, which adds a bit of complexity.
>>
>> Making the interface configuration-independent makes it obvious
>> to the reader that none of these problems can happen.
>
> Except ideally, these are word-sized accesses (where only compat code
> has to suffer I suppose).

While I hate it with a passion, there is actually a valid reason to use
this ugly typedef.

On 32bit architectures which have load/store tearing of 64bit variables
into two 32bit accesses due to ISA limitations, that results in
undefined behaviour when write and read are concurrent. Neither
READ_ONCE() nor WRITE_ONCE help there.

Though that begs the question whether we need a 64bit generation counter
for the VDSO at all.

Thanks,

        tglx




