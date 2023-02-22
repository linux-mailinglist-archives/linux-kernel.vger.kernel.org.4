Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602DA69F98C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 18:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbjBVRFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 12:05:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbjBVRE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 12:04:58 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BC23A08B;
        Wed, 22 Feb 2023 09:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8seSikIduHdwWlxLKvtsNdKihKZpOnnG/byEzPIYqpo=; b=Y1ljMAsEbY1xeALhV24P6D+VB8
        W1bdI7nU0WhWoHx4NgJjUs1eL4F579QHnU+VRNoxr0EmxLBTqZ3vOKnmHpwMB+Sofv3xiO5BeF6WD
        1LD1NvVLmJ2+7rgSzEr2KFdkQGbvBYCsMTfz8sZqwESBDJCLccPcpvy9GuBpXxB4wGZyirHyFJlTf
        gndmj7kqHoQ049GccgXjz/BpbKTlsy/A8I1wozGsWIJRtFjTTw2VRwpq8mSkA9UdnUdhM7yIf7jgi
        NcbLaUrNNJrkpHmN4j4xvoM8KhBnKHeFAYPSNMidGw19ugtisIBpD9l0VLYU1g+Tbm+Yn6Ihuibqi
        eg9uba3g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pUsXk-00CbPL-05;
        Wed, 22 Feb 2023 17:04:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 58890300446;
        Wed, 22 Feb 2023 18:04:32 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0DE9520DD8076; Wed, 22 Feb 2023 18:04:32 +0100 (CET)
Date:   Wed, 22 Feb 2023 18:04:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>
Cc:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, Arnd Bergmann <arnd@arndb.de>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v5 0/7] Introduce __xchg, non-atomic xchg
Message-ID: <Y/ZLH5F8LA3H10aL@hirez.programming.kicks-ass.net>
References: <20230118153529.57695-1-andrzej.hajda@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118153529.57695-1-andrzej.hajda@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 04:35:22PM +0100, Andrzej Hajda wrote:

> Andrzej Hajda (7):
>   arch: rename all internal names __xchg to __arch_xchg
>   linux/include: add non-atomic version of xchg
>   arch/*/uprobes: simplify arch_uretprobe_hijack_return_addr
>   llist: simplify __llist_del_all
>   io_uring: use __xchg if possible
>   qed: use __xchg if possible
>   drm/i915/gt: use __xchg instead of internal helper

Nothing crazy in here I suppose, I somewhat wonder why you went through
the trouble, but meh.

You want me to take this through te locking tree (for the next cycle,
not this one) where I normally take atomic things or does someone else
want this?
