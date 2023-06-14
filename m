Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930D372FC45
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 13:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236537AbjFNLUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 07:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244234AbjFNLUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 07:20:18 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245BB199C
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 04:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=swe8nz8Lh6FmcIvT+gLxDu8hID+uTUYGp7H7b9K49Zs=; b=qewXtu/+qGvoPoWIElwI4uZ05C
        zPE6FJnl43cF8RkhgXvyNdn/daXVe+CuDMZ9L3j1EFwOvMzX9pn31a/u0GJ2WoRIy75vJMqxffQR7
        BWz9tOgY3NaahXgTKg7hXTN4NevrEKKFjtz/6KwvVk5RRqB7zstg5h2Gd0+HnhwgKkfldj27wbtry
        GWTjRBJ2tobpKO0nahr9BxRMiEMdd7mSTwjkRRE3X/clPE0vF31Kd876x5AGTcBJAPh1lnoI5/6cV
        7mXVmnaAj0JrJLyfVp06aSy756CXa2R1q0qgV7ZXC4tJBxi2mXN/IDMheSHQN97Tw2LLZKkh58H2G
        6Njyg+gA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q9OXs-00AkPo-0F;
        Wed, 14 Jun 2023 11:20:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 40753300188;
        Wed, 14 Jun 2023 13:20:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 22D84245CC9AB; Wed, 14 Jun 2023 13:20:11 +0200 (CEST)
Date:   Wed, 14 Jun 2023 13:20:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Richard W.M. Jones" <rjones@redhat.com>
Cc:     Aaron Thompson <dev@aaront.org>, linux-kernel@vger.kernel.org
Subject: Re: printk.time causes rare kernel boot hangs
Message-ID: <20230614112010.GI1639749@hirez.programming.kicks-ass.net>
References: <20230613134105.GA10301@redhat.com>
 <20230614092158.GF1639749@hirez.programming.kicks-ass.net>
 <20230614094522.GA7636@redhat.com>
 <20230614103011.GL7912@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614103011.GL7912@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 11:30:11AM +0100, Richard W.M. Jones wrote:
> OK I have a simpler test:
> 
> $ while true; do qemu-system-x86_64 -no-user-config -nodefaults -display none -machine accel=kvm:tcg,graphics=off -cpu max,la57=off -m 1280 -no-reboot -rtc driftfix=slew -no-hpet -global kvm-pit.lost_tick_policy=discard -kernel vmlinux -serial stdio -append "panic=1 console=ttyS0 edd=off udevtimeout=6000 udev.event-timeout=6000 no_timer_check printk.time=1 cgroup_disable=memory usbcore.nousb cryptomgr.notests tsc=reliable 8250.nr_uarts=1 root=UUID=7cd9caf4-6491-41a5-b387-38af6fa2d638 selinux=0 guestfs_verbose=1 TERM=xterm-256color" >& /tmp/log ; echo -n . ; done
> 
> where "vmlinux" is a locally compiled kernel with CONFIG_PRINTK_TIME=y
> set.  I'm using the current git head.

Ah, that's much easier than whatever guestfish does, let me go run this
then.
