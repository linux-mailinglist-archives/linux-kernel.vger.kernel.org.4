Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F5B6A4131
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 12:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjB0Lv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 06:51:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjB0Lv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 06:51:26 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447A8CC3F;
        Mon, 27 Feb 2023 03:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IHfNwSFbJCjD3+MFkG1rSN+/4A1joEsOheuA6Ngssbg=; b=RUNzYBF4yIP/4g8B8QGBfC62Qq
        1raaPo1CTNANqDPqMPfaabS7sOposruAsLiI3j4eGCA8R9eJlDZRCY8dHWOe/mzR55BcsAzR8xlw3
        M+MxtUGC/CWO6wj6q9rCyH4jjP0RScXa50/tgvofm1Qvnzfq773PPcARnKN9oI+VZaJYsWhpxWqmk
        XewnftJ/Ynp1W74DSZacj1nWSdfx1C9thtvJunx6gBzHBOY+MnSM2XsptPJ540L2itPSNiy1/Sd+P
        WyfEmguOuorzajxXrabsJ9SNGeSDnYHL1CbOpZIPjN5gcBEDvGhSQC1+kJEO88Sg3Xw4tQcsabeas
        JY6rohOQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pWc2N-00EDds-0W;
        Mon, 27 Feb 2023 11:51:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 10B56300293;
        Mon, 27 Feb 2023 12:51:22 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E819D22F1DD87; Mon, 27 Feb 2023 12:51:21 +0100 (CET)
Date:   Mon, 27 Feb 2023 12:51:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] s390/rwonce: add READ_ONCE_ALIGNED_128() macro
Message-ID: <Y/yZOatifn7lXAhY@hirez.programming.kicks-ass.net>
References: <20230224100237.3247871-1-hca@linux.ibm.com>
 <20230224100237.3247871-2-hca@linux.ibm.com>
 <Y/o8cmyc7IW+28S2@hirez.programming.kicks-ass.net>
 <Y/vHjFRIJTTKVcFq@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/vHjFRIJTTKVcFq@osiris>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26, 2023 at 09:56:44PM +0100, Heiko Carstens wrote:
> On Sat, Feb 25, 2023 at 05:50:58PM +0100, Peter Zijlstra wrote:
> > On Fri, Feb 24, 2023 at 11:02:36AM +0100, Heiko Carstens wrote:
> > > Add an s390 specific READ_ONCE_ALIGNED_128() helper, which can be used for
> > > fast block concurrent (atomic) 128-bit accesses.
> > > 
> > > The used lpq instruction requires 128-bit alignment. This is also the
> > > reason why the compiler doesn't emit this instruction if __READ_ONCE() is
> > > used for 128-bit accesses.
> > 
> > Does your u128 not have natural alignment? Does it help if you force
> > align the u128 type?
> 
> s390 seems to be the only architecture which has a 64 bit alignment for
> __uint128_t. But making it explicitly naturally aligned doesn't help.
> I guess that's because the lpq instruction requires an even-odd register
> pair where it reads to, while the now used lmg instruction can use any
> register pair; but lmg doesn't come with atomic semantics.

One thing you could do it talk with your compiler folks to allow using
lpq for volatile loads. That won't help you now and you'll have to do
these patches, but it makes sense to change the toolchains to me.
