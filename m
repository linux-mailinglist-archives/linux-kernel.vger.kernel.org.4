Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90CDA630F3C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 16:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbiKSPRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 10:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbiKSPRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 10:17:41 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D221C91C15
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 07:17:40 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id jr19so4906190qtb.7
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 07:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ep2NNgB2ClfhmvaXDh44sG5tZ/8LYegqibxZvyW2WE4=;
        b=K0n1CPGgO4e7ug+6PKrrPgi5m90EhIpfwKiaARioU5c4lEJe+NcLkGZMn2KjOKwnGS
         +9PNI0kwcTUePwjWd0UULLjvcbfc0LUgNHJTd4Qcg5EzylMa4OzyBHpKKU/p53sbeUJp
         fjUqM/1PrHTutVnhgt97i8mjObRPtYRn4d7uZSClD+Q8KO26DbmvdM2kHX+FxLO2PMW8
         imSzTjUBv5ErVIx74ASNJAxXJXBC2bwX1dionjqVIe7EDVYtilm4aPis19OQDyuWKXwH
         p34lreeKhivhSAU4J2YmkZezi+MZnzEHSHoQUBqi76oLgZYCWz3q/WWhFpVnNcmw+WHj
         rFJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ep2NNgB2ClfhmvaXDh44sG5tZ/8LYegqibxZvyW2WE4=;
        b=upx3EeXqIyZ0kUh0o6OQbXJdnfDVXjlhNOpaJHh5EHtKF7l79LNsrBs7tPj2gyvP+w
         Oq7jLNGWz67nivGWjiY/etLUjZbkccifmL1pYbgvKp6GCxaI/OvEDXuvI19UBobSxKs0
         yWXmlCavoH0uwHSe3yg++JAbI9sNlSFl9HyfEdTpYVFomUtHjw9dqZKeSdd/j9avAK3g
         9h2mcWAJ0XFT85V2kAOms3madWF81bQzjNs4jGM7Gf09f2v+UHq4s+i1LJZy+1N7efGO
         Tt//0skJiOQiqeysojcaI0Ui6z+TcbwvgSNFMKx2ic8Z4ZNczXTY3SU7HWrass5IXIsL
         k8Ig==
X-Gm-Message-State: ANoB5pmIxqREb6qPUxIPgL6l3Wql0FXdc1K7YBhxPdcGT8te7N/ZAKYy
        gqUeAq7TNEYaAjetRUUxYGo6hPMClHQ=
X-Google-Smtp-Source: AA0mqf5WpJFJN+Z/jalZv4caUewkVWsT4QxTDkrUiVDIFuGFaFTVK/DmLFjVY1AxhDG2OIg7lQy3hw==
X-Received: by 2002:ac8:7343:0:b0:3a4:c30b:c640 with SMTP id q3-20020ac87343000000b003a4c30bc640mr11171549qtp.25.1668871059361;
        Sat, 19 Nov 2022 07:17:39 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p22-20020ac84096000000b0035d432f5ba3sm4001459qtl.17.2022.11.19.07.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 07:17:38 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 19 Nov 2022 07:17:37 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Nested calls to spin_lock_irq with different locks
Message-ID: <20221119151737.GA702470@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

recently I have seen various syzbot reports reporting inconsistent lock
states. One example is

================================
WARNING: inconsistent lock state
5.16.0-syzkaller #0 Not tainted
--------------------------------
inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
syz-executor.2/18360 [HC0[0]:SC0[0]:HE0:SE1] takes:
ffffffff8c712cf8 (sync_timeline_list_lock){?...}-{2:2}, at: spin_lock_irq include/linux/spinlock.h:374 [inline]
ffffffff8c712cf8 (sync_timeline_list_lock){?...}-{2:2}, at: sync_info_debugfs_show+0x2d/0x200 drivers/dma-buf/sync_debug.c:147
{IN-HARDIRQ-W} state was registered at:
  lock_acquire kernel/locking/lockdep.c:5639 [inline]
  lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5604
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
  sync_timeline_debug_remove+0x25/0x190 drivers/dma-buf/sync_debug.c:31

================================
WARNING: inconsistent lock state
5.16.0-syzkaller #0 Not tainted
--------------------------------
inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
syz-executor.2/18360 [HC0[0]:SC0[0]:HE0:SE1] takes:
ffffffff8c712cf8 (sync_timeline_list_lock){?...}-{2:2}, at: spin_lock_irq include/linux/spinlock.h:374 [inline]
ffffffff8c712cf8 (sync_timeline_list_lock){?...}-{2:2}, at: sync_info_debugfs_show+0x2d/0x200 drivers/dma-buf/sync_debug.c:147

The log is from
https://lore.kernel.org/lkml/000000000000d5b3af05edc9d445@google.com/T/.

sync_info_debugfs_show() calls spin_lock_irq(&sync_timeline_list_lock).
With the lock active, it calls sync_print_obj(), which calls
spin_lock_irq(&obj->lock) and spin_unlock_irq(&obj->lock).

spin_unlock_irq(), via __raw_spin_unlock_irq(), calls local_irq_enable(),
presumably enabling hardware interrupts. If such a hardware interrupt
calls sync_timeline_debug_remove(), the problem would be seen.

Can this happen in practice ? In other words, does that mean that nested
calls to spin_lock_irq() (with different locks) are not supported ?
If that is indeed the case, is there a suggested remedy ?

Thanks,
Guenter
