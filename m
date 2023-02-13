Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A107A694D04
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 17:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbjBMQhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 11:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjBMQhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 11:37:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370D82108;
        Mon, 13 Feb 2023 08:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qaz/DPwIkRVLhrYLsc81DKWYTQXENIiXxkrqrvuHtg4=; b=NjQjZ37eclcCD+ro3kgbRGKjhV
        y8ciGCLv6NIFLpxz6eE010Omh9moxl2JhPzO2hnWajga7tWaXR6oL+fPK0S7TMYh75frnm+vBFWeJ
        +Y4B6wJgWjv9CVwTSeYHuJ7fXfriyllZwNg9lou63vWTsUZ2s8yydOx8e8c00eLkYHaMCTTDCIpSr
        DRgDI6dJH14rgimA0VcRnutYwXZeNEazJxQt+Tu8FrhEx+SOfQK8lRIo3lJSAXZYUfgkDsmpAqg3k
        iHvygWPGiHnHkVk/rXVR9pEVOxjU4A5ZhVxebrd5W6It49z2YqD4LnVwCsAwHWdpix+OwOHFRuuMA
        +/xoFtWw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pRbos-005vWt-0l; Mon, 13 Feb 2023 16:36:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7595C300033;
        Mon, 13 Feb 2023 17:36:45 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 54F262012B92E; Mon, 13 Feb 2023 17:36:45 +0100 (CET)
Date:   Mon, 13 Feb 2023 17:36:45 +0100
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
Message-ID: <Y+pnHb0MCbx9dDj3@hirez.programming.kicks-ass.net>
References: <Y+gjuqJ5RFxwLmht@moria.home.lan>
 <Y+hRurRwm//1+IcK@rowland.harvard.edu>
 <Y+hTEtCKPuO0zGIt@moria.home.lan>
 <Y+hW74TAVzCpSv7c@rowland.harvard.edu>
 <Y+hYn6uzIUBaxDdV@moria.home.lan>
 <Y+kEgDLSRwdODRdD@rowland.harvard.edu>
 <Y+k6ehYLWa0cmbvb@moria.home.lan>
 <Y+lJxCLpwMGuq0sP@rowland.harvard.edu>
 <Y+oCdlIwCDtRRG6T@hirez.programming.kicks-ass.net>
 <Y+pXCFOyhXbbLgCv@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+pXCFOyhXbbLgCv@rowland.harvard.edu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 10:28:08AM -0500, Alan Stern wrote:
> On Mon, Feb 13, 2023 at 10:27:18AM +0100, Peter Zijlstra wrote:
> > On Sun, Feb 12, 2023 at 03:19:16PM -0500, Alan Stern wrote:
> > 
> > > (Device names are often set after the device is initialized.  Does 
> > > lockdep mind if a lock_class_key's name is changed after it has been 
> > > registered?)
> > 
> > It does, althought I don't at the moment recall how hard it would be to
> > change that.
> 
> If the names are only used for printing purposes, or other similarly 
> innocuous things, it ought to be enough to set the name with 
> smp_store_release() and read the name with smp_load_acquire().

The name is copied from the key to the 'class' upon registration of the
first lock that uses a particular key. Then later, when looking up the
class for subsequent usages of the same key, the string is checked, and
WARNs if they somehow not match.

Granted, this is a silly sanity check that's easily disabled. But from a
cursory look that seems to be just about it.

The only 'problem' is that it's (typically) class name that's printed,
not the key name, so if you change the key name, without also changing
the class name, reports get really confusing.

Still, that all ought to be fixable.. just a matter of typing or so :-)
