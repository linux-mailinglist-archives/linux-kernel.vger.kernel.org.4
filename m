Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1420D675269
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 11:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjATK1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 05:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjATK1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 05:27:36 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA639AA5C3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 02:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4DtS/Vci9O3nMdUND19zt5XQUjQ2HNLRRxBz1fGz9/o=; b=nKdaBIbExUmIBbVkFL1wLoBiSS
        AFibTSVMIhHp3tFI/rYMfkhH9HH7zDOD94jp/4efCIh/QYXI4s+SJYuuN22q5fy7H4ocEhvVipz3s
        IChK5fH1XCS1Hi7uky++4TWl7jQndemt2GoWXpvVSIhvuC3u2l9nyz/UsrADnWohk/vw5uOASJnyT
        vjXaRS5poLYhNQjYafsJFZrnGqMwiRQLK8dltbhoWwHstQSUkCafnVCSbTazJMudVXJB4YZX71YbP
        db9KinURFV1ETj4B+z2C6rhSF1Zc70QvLg91dkHiDiWlfaUq8JjbIZrMfqoMYG4sAVuuJfQsIrJlm
        nN5cfUkw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pIobR-000byJ-0x;
        Fri, 20 Jan 2023 10:26:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 87A4C30036B;
        Fri, 20 Jan 2023 11:27:00 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7030F20A60F36; Fri, 20 Jan 2023 11:27:00 +0100 (CET)
Date:   Fri, 20 Jan 2023 11:27:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sandipan Das <sandipan.das@amd.com>
Cc:     "Erhard F." <erhard_f@mailbox.org>, linux-kernel@vger.kernel.org
Subject: Re: [bisected] clang 15 built kernel fails to boot, stuck at
 "Loading Linux 6.1.1 ...", gcc 12 built kernel with same config boots fine
Message-ID: <Y8psdH5KRQC3bcTI@hirez.programming.kicks-ass.net>
References: <20230119022303.177052e4@yea>
 <Y8lL95T93g5xK+mu@hirez.programming.kicks-ass.net>
 <Y8lfStnaUFNRxgYu@hirez.programming.kicks-ass.net>
 <178000f1-1464-03cb-2335-a01b77e70692@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178000f1-1464-03cb-2335-a01b77e70692@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 11:20:53AM +0530, Sandipan Das wrote:
> With the combination of defconfig+kvm_guest.config+localyesconfig, the only
> thing that made a difference was the compiler optimization choice. The kernel
> boots up with CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y but not with
> CONFIG_CC_OPTIMIZE_FOR_SIZE=y. Both Clang 15 and 16 kernel builds are affected.

-Os(tupid) strikes again :-)

Lemme go try that.
