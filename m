Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6318F67A0B4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 18:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbjAXR7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 12:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbjAXR66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 12:58:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DC6269A
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 09:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674583088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8p0fjBFbr33layaeANbx7Fcez2vuRTWnR65WsK5kAh0=;
        b=FUxg0Ad6zSaGZCd3ZUjUEfR8IzTDr0ME0mZPvbd5KJyymJafr3JpOC99TQ9kOpXaYDrfcP
        KoQYlgFJuYqN4rLEHKr/s0/IFWpC66aaSkFI9iqPHZb996f1Yl3Bt5LelgByqbGJ82mbKo
        xLQCCyJ6XMOqc1B66GP+KgDBcfimEbA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-459-EgctpWEEMH6pWck4X7eZqw-1; Tue, 24 Jan 2023 12:58:04 -0500
X-MC-Unique: EgctpWEEMH6pWck4X7eZqw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0126F857F41;
        Tue, 24 Jan 2023 17:58:04 +0000 (UTC)
Received: from [10.22.10.191] (unknown [10.22.10.191])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8F304492C14;
        Tue, 24 Jan 2023 17:58:03 +0000 (UTC)
Message-ID: <b2962bcd-c35f-26dd-cb4e-8bc7e2807ca2@redhat.com>
Date:   Tue, 24 Jan 2023 12:58:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: WARNING: locking bug in pgd_free
Content-Language: en-US
To:     Sanan Hasanov <sanan.hasanov@Knights.ucf.edu>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "will@kernel.org" <will@kernel.org>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "contact@pgazz.com" <contact@pgazz.com>,
        "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>
References: <IA1PR07MB98304A14BD26596C87A8C581ABC99@IA1PR07MB9830.namprd07.prod.outlook.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <IA1PR07MB98304A14BD26596C87A8C581ABC99@IA1PR07MB9830.namprd07.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/24/23 11:22, Sanan Hasanov wrote:
> Good day, dear maintainers,
>
> We found a bug using a modified kernel configuration file used by syzbot.
>
> We enhanced the coverage of the configuration file using our tool, klocalizer.
>
> Kernel Branch: 6.2.0-rc3-next-20230112
> Kernel config: https://drive.google.com/file/d/1Zg-NZ5s04wPVdO8cfpvQjatI-0VAVjZV/view?usp=sharing
>
> Unfortunately, we do not have a reproducer yet.
>
> Thank you!
>
> Best regards,
> Sanan Hasanov
>
> ------------[ cut here ]------------
> DEBUG_LOCKS_WARN_ON(1)
> WARNING: CPU: 5 PID: 7278 at kernel/locking/lockdep.c:232 hlock_class kernel/locking/lockdep.c:232 [inline]
> WARNING: CPU: 5 PID: 7278 at kernel/locking/lockdep.c:232 hlock_class kernel/locking/lockdep.c:221 [inline]
> WARNING: CPU: 5 PID: 7278 at kernel/locking/lockdep.c:232 check_deadlock kernel/locking/lockdep.c:3017 [inline]
> WARNING: CPU: 5 PID: 7278 at kernel/locking/lockdep.c:232 validate_chain kernel/locking/lockdep.c:3819 [inline]
> WARNING: CPU: 5 PID: 7278 at kernel/locking/lockdep.c:232 __lock_acquire+0x24b8/0x5170 kernel/locking/lockdep.c:5056
> Modules linked in:
> CPU: 5 PID: 7278 Comm: systemd-udevd Not tainted 6.2.0-rc3-next-20230112 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> RIP: 0010:hlock_class kernel/locking/lockdep.c:232 [inline]
> RIP: 0010:hlock_class kernel/locking/lockdep.c:221 [inline]
> RIP: 0010:check_deadlock kernel/locking/lockdep.c:3017 [inline]
> RIP: 0010:validate_chain kernel/locking/lockdep.c:3819 [inline]
> RIP: 0010:__lock_acquire+0x24b8/0x5170 kernel/locking/lockdep.c:5056

This error only happens when the lock class used has been freed 
(zapped). A lock class can be freed by either lockdep_unregister_key() 
or by lockdep_reset_lock(). The lock in question is a static pgd_lock 
defined in arch/x86/mm/fault.c. lockdep_unregister_key() is for 
dynamically allocated key which is not the case for pgd_lock. 
lockdep_reset_lock() is used by locking_selftest.c only. Does your 
config include CONFIG_DEBUG_LOCKING_API_SELFTESTS?

Cheers,
Longman

