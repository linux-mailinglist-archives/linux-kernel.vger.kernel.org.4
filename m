Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6AF694142
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 10:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjBMJcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 04:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjBMJbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 04:31:37 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E68816AD2;
        Mon, 13 Feb 2023 01:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tlbtwloiMll80xsCP5JxReJzFyl0pMq9yses5MAk/Hw=; b=EYMskAFjqDUuDsKVLxh5WJIqSN
        9XYUb/9Hr+XOo0u6+DfjwQDUegFHC1KiigfqbFKStMj5kZI8KZ1SoWFyvK0yfn/8Xa5/wGs30bpbT
        Drh84WYjg2KkeqDXPOB9B6trmp6a9R4ODGiG9eNDZ5YauLGcoS/TjTzTuZMzQH5pw7VKlRMlI+D6V
        VMGzZ2lHYiV6Oe3JzW8HSv7afWIG2EcS3S/MNLTg4jHV28cOk1JcamPznuzmmm5ua9WETKww8yhz0
        rwcRU6ureLuNr7XmlGivnHo/9Ue4C7e0lf02weexO7gCw8+Y359T40Nv4v3SVdj+1BMLQ4dB57xK+
        XwyHc/qQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pRV6d-009Fkm-2F;
        Mon, 13 Feb 2023 09:28:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2014F30036B;
        Mon, 13 Feb 2023 10:27:19 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0531520C6EEA1; Mon, 13 Feb 2023 10:27:18 +0100 (CET)
Date:   Mon, 13 Feb 2023 10:27:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Coly Li <colyli@suse.de>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzkaller <syzkaller@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH RFC] drivers/core: Replace lockdep_set_novalidate_class()
 with unique class keys
Message-ID: <Y+oCdlIwCDtRRG6T@hirez.programming.kicks-ass.net>
References: <CAHk-=whXYzkOJZo0xpyYfrhWQg1M7j0OeCojTJ84CN4q9sqb2Q@mail.gmail.com>
 <109c3cc0-2c13-7452-4548-d0155c1aba10@gmail.com>
 <Y+gjuqJ5RFxwLmht@moria.home.lan>
 <Y+hRurRwm//1+IcK@rowland.harvard.edu>
 <Y+hTEtCKPuO0zGIt@moria.home.lan>
 <Y+hW74TAVzCpSv7c@rowland.harvard.edu>
 <Y+hYn6uzIUBaxDdV@moria.home.lan>
 <Y+kEgDLSRwdODRdD@rowland.harvard.edu>
 <Y+k6ehYLWa0cmbvb@moria.home.lan>
 <Y+lJxCLpwMGuq0sP@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+lJxCLpwMGuq0sP@rowland.harvard.edu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 12, 2023 at 03:19:16PM -0500, Alan Stern wrote:

> (Device names are often set after the device is initialized.  Does 
> lockdep mind if a lock_class_key's name is changed after it has been 
> registered?)

It does, althought I don't at the moment recall how hard it would be to
change that.
