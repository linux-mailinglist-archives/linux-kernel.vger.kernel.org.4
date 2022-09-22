Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 806C65E603E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 12:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbiIVKzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 06:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbiIVKzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 06:55:44 -0400
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629019E105;
        Thu, 22 Sep 2022 03:55:41 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by a.mx.secunet.com (Postfix) with ESMTP id 0ABEC20519;
        Thu, 22 Sep 2022 12:55:39 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
        by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ZL9nvv1PUCu7; Thu, 22 Sep 2022 12:55:38 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by a.mx.secunet.com (Postfix) with ESMTPS id 71E7020460;
        Thu, 22 Sep 2022 12:55:38 +0200 (CEST)
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
        by mailout1.secunet.com (Postfix) with ESMTP id 60A0A80004A;
        Thu, 22 Sep 2022 12:55:38 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 12:55:38 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 22 Sep
 2022 12:55:37 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
        id 58ED43180DDF; Thu, 22 Sep 2022 12:55:37 +0200 (CEST)
Date:   Thu, 22 Sep 2022 12:55:37 +0200
From:   Steffen Klassert <steffen.klassert@secunet.com>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
CC:     <eadavis@sina.com>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <syzbot+bc05445bc14148d51915@syzkaller.appspotmail.com>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH] padata: fix lockdep warning in padata serialization
Message-ID: <20220922105537.GI2950045@gauss3.secunet.de>
References: <20220919151248.smfo7nq6yoqzy2vo@oracle.com>
 <20220920003908.391835-1-eadavis@sina.com>
 <20220920014711.bvreurf4ex44w6oj@oracle.com>
 <20220920055443.GI2950045@gauss3.secunet.de>
 <20220920141057.cy54d5ukflrgay3a@oracle.com>
 <20220921073616.GZ2950045@gauss3.secunet.de>
 <20220921185138.c6chlv77ugfrsukj@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220921185138.c6chlv77ugfrsukj@oracle.com>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 02:51:38PM -0400, Daniel Jordan wrote:
> On Wed, Sep 21, 2022 at 09:36:16AM +0200, Steffen Klassert wrote:
> > On Tue, Sep 20, 2022 at 10:10:57AM -0400, Daniel Jordan wrote:
> > > Yeah, padata_do_serial can be called with BHs off, like in the tipc
> > > stack, but there are also cases where BHs can be on, like lockdep said
> > > here:
> > 
> > padata_do_serial was designed to run with BHs off, it is a bug if it
> > runs with BHs on. But I don't see a case where this can happen. The
> > only user of padata_do_serial is pcrypt in its serialization callbacks
> > (pcrypt_aead_enc, pcrypt_aead_dec) and the async crypto callback
> > pcrypt_aead_done. pcrypt_aead_enc and pcrypt_aead_dec are issued via
> > the padata_serial_worker with the padata->serial call. BHs are
> > off here. The crypto callback also runs with BHs off.
> > 
> > What do I miss here?
> 
> Ugh.. this newer, buggy part of padata_do_parallel:
> 
>   /* Maximum works limit exceeded, run in the current task. */
>   padata->parallel(padata);

Oh well...

> This skips the usual path in padata_parallel_worker, which disables BHs.
> They should be left off in the above case too.
> 
> What about this?
> 
> ---8<---
> 
> Subject: [PATCH] padata: always leave BHs disabled when running ->parallel()
> 
> A deadlock can happen when an overloaded system runs ->parallel() in the
> context of the current task:
> 
>     padata_do_parallel
>       ->parallel()
>         pcrypt_aead_enc/dec
>           padata_do_serial
>             spin_lock(&reorder->lock) // BHs still enabled
>               <interrupt>
>                 ...
>                   __do_softirq
>                     ...
>                       padata_do_serial
>                         spin_lock(&reorder->lock)
> 
> It's a bug for BHs to be on in _do_serial as Steffen points out, so
> ensure they're off in the "current task" case like they are in
> padata_parallel_worker to avoid this situation.
> 
> Reported-by: syzbot+bc05445bc14148d51915@syzkaller.appspotmail.com
> Fixes: 4611ce224688 ("padata: allocate work structures for parallel jobs from a pool")
> Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>

Yes, that makes sense.

Acked-by: Steffen Klassert <steffen.klassert@secunet.com>

But we also should look at the call to padata_find_next where BHs are
on. padata_find_next takes the same lock as padata_do_serial, so this
might be a candidate for a deadlock too.
