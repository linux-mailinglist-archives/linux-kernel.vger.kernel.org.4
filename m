Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A895BF7D0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 09:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbiIUHgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 03:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiIUHgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 03:36:21 -0400
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328AC83F04;
        Wed, 21 Sep 2022 00:36:20 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by a.mx.secunet.com (Postfix) with ESMTP id 31B09205F8;
        Wed, 21 Sep 2022 09:36:18 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
        by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 39iP2hi_bEz5; Wed, 21 Sep 2022 09:36:17 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by a.mx.secunet.com (Postfix) with ESMTPS id 9083120519;
        Wed, 21 Sep 2022 09:36:17 +0200 (CEST)
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
        by mailout2.secunet.com (Postfix) with ESMTP id 8113180004A;
        Wed, 21 Sep 2022 09:36:17 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 09:36:17 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 21 Sep
 2022 09:36:16 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
        id 8228E31829EC; Wed, 21 Sep 2022 09:36:16 +0200 (CEST)
Date:   Wed, 21 Sep 2022 09:36:16 +0200
From:   Steffen Klassert <steffen.klassert@secunet.com>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
CC:     <eadavis@sina.com>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <syzbot+bc05445bc14148d51915@syzkaller.appspotmail.com>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH] padata: fix lockdep warning in padata serialization
Message-ID: <20220921073616.GZ2950045@gauss3.secunet.de>
References: <20220919151248.smfo7nq6yoqzy2vo@oracle.com>
 <20220920003908.391835-1-eadavis@sina.com>
 <20220920014711.bvreurf4ex44w6oj@oracle.com>
 <20220920055443.GI2950045@gauss3.secunet.de>
 <20220920141057.cy54d5ukflrgay3a@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220920141057.cy54d5ukflrgay3a@oracle.com>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 10:10:57AM -0400, Daniel Jordan wrote:
> Hi Steffen,
> 
> On Tue, Sep 20, 2022 at 07:54:43AM +0200, Steffen Klassert wrote:
> > On Mon, Sep 19, 2022 at 09:47:11PM -0400, Daniel Jordan wrote:
> > > On Tue, Sep 20, 2022 at 08:39:08AM +0800, eadavis@sina.com wrote:
> > > > From: Edward Adam Davis <eadavis@sina.com>
> > > > 
> > > > On Mon, 19 Sep 2022 11:12:48 -0400, Daniel Jordan wrote:
> > > > > Hi Edward,
> > > > > 
> > > > > On Mon, Sep 19, 2022 at 09:05:55AM +0800, eadavis@sina.com wrote:
> > > > > > From: Edward Adam Davis <eadavis@sina.com>
> > > > > > 
> > > > > > Parallelized object serialization uses spin_unlock for unlocking a spin lock
> > > > > > that was previously locked with spin_lock.
> > > > > 
> > > > > There's nothing unusual about that, though?
> > > > > 
> > > > > > This caused the following lockdep warning about an inconsistent lock
> > > > > > state:
> > > > > > 
> > > > > >         inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
> > > > > 
> > > > > Neither HARDIRQ-ON-W nor IN-HARDIRQ-W appear in the syzbot report, did
> > > > > you mean SOFTIRQ-ON-W and IN-SOFTIRQ-W?
> > > > Yes, I want say: inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
> > > > > 
> > > > > > We must use spin_lock_irqsave, because it is possible to trigger tipc 
> > > > > > from an irq handler.
> > > > > 
> > > > > A softirq handler, not a hardirq handler.  I'd suggest using
> > > > > spin_lock_bh() instead of _irqsave in your patch.
> > > > I think _irqsave better than _bh, it can save the irq context, but _bh not, 
> > > > and in tipc call trace contain SOFTIRQ-ON-W and IN-SOFTIRQ-W.
> > > 
> > > _irqsave saving the context is about handling nested hardirq disables.
> > > It's not needed here since we don't need to care about disabling
> > > hardirq.
> > > 
> > > _bh is for disabling softirq, a different context from hardirq.  We want
> > > _bh here since the deadlock happens when a CPU takes the lock in both
> > > task and softirq context.  padata uses _bh lock variants because it can
> > > be called in softirq context but not hardirq.  Let's be consistent and
> > > do it in this case too.
> > 
> > padata_do_serial is called with BHs off, so using spin_lock_bh should not
> > fix anything here. I guess the problem is that we call padata_find_next
> > after we enabled the BHs in padata_reorder.
> 
> Yeah, padata_do_serial can be called with BHs off, like in the tipc
> stack, but there are also cases where BHs can be on, like lockdep said
> here:

padata_do_serial was designed to run with BHs off, it is a bug if it
runs with BHs on. But I don't see a case where this can happen. The
only user of padata_do_serial is pcrypt in its serialization callbacks
(pcrypt_aead_enc, pcrypt_aead_dec) and the async crypto callback
pcrypt_aead_done. pcrypt_aead_enc and pcrypt_aead_dec are issued via
the padata_serial_worker with the padata->serial call. BHs are
off here. The crypto callback also runs with BHs off.

What do I miss here?

