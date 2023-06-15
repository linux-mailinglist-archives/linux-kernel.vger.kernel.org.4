Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34027731159
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 09:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245221AbjFOHun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 03:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245313AbjFOHuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 03:50:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A565A107
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 00:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686815331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CtUIVorqz3ndhw8u2Bjfcmy055exUCqFIXM08AiZ4vs=;
        b=ZwbcFL/uNpWZbpl6oTRy8SpilZnfshiWbDNkR2HTbVyzmaN4nqJEJeeDR+6phSSt5lOczZ
        lXt/86kPdKAHiSYh/+zZjIKN0jX0zzJKahelUqp7LHnoZifJBNfpC9wUdwb5xZexBu/HqP
        bgLChFzoTg0nWPOQmcXh+wzAr6msH28=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-541-tqAZT-t7MyqFq8gRej_vew-1; Thu, 15 Jun 2023 03:48:45 -0400
X-MC-Unique: tqAZT-t7MyqFq8gRej_vew-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5EDE5830EFD;
        Thu, 15 Jun 2023 07:48:45 +0000 (UTC)
Received: from localhost (unknown [10.39.192.206])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1750F40479E9;
        Thu, 15 Jun 2023 07:48:44 +0000 (UTC)
Date:   Thu, 15 Jun 2023 08:48:44 +0100
From:   "Richard W.M. Jones" <rjones@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Aaron Thompson <dev@aaront.org>, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: printk.time causes rare kernel boot hangs
Message-ID: <20230615074844.GC10301@redhat.com>
References: <20230614125320.GA1640563@hirez.programming.kicks-ass.net>
 <20230614130348.GF7636@redhat.com>
 <20230614130945.GK1639749@hirez.programming.kicks-ass.net>
 <20230614145348.GB1640563@hirez.programming.kicks-ass.net>
 <20230614150717.GG7636@redhat.com>
 <20230614151920.GN1639749@hirez.programming.kicks-ass.net>
 <20230614153108.GC1640563@hirez.programming.kicks-ass.net>
 <20230614155016.GI7636@redhat.com>
 <20230614173430.GB10301@redhat.com>
 <20230615074040d166068b@mail.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615074040d166068b@mail.local>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 09:40:40AM +0200, Alexandre Belloni wrote:
> Hello,
> 
> On 14/06/2023 18:34:30+0100, Richard W.M. Jones wrote:
> > 
> > FWIW attached is a test program that runs the qemu instances in
> > parallel (up to 8 threads), which seems to be a quicker way to hit the
> > problem for me.  Even on Intel, with this test I can hit the bug in a
> > few hundred iteration.
> > 
> 
> I'm just chiming in to say that we do hit the same issue on the Yocto
> Project CI. We are using qemu 8.0.0 on Intel hardware and a 6.1 kernel.
> 
> I see that f31dcb152a3d0816e2f1deab4e64572336da197d hasn't been
> backported so it may not be the culprit. However, this seems to have
> started happening when we switched from 5.15 to 6.1.

I don't know if it's related or not, or even valid, but it was pointed
out to me[1] that you can get the exact same failure this way:

  - Linux git @ b6dad5178ceaf23f369c3711062ce1f2afc33644
  - Revert f31dcb152a3d0816e2f1deab4e64572336da197d
  - Add the following patch:

diff --git a/init/main.c b/init/main.c
index af50044deed5..c2774865a83f 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1552,6 +1552,7 @@ static noinline void __init kernel_init_freeable(void)
 
 	cad_pid = get_pid(task_pid(current));
 
+	msleep(1);
 	smp_prepare_cpus(setup_max_cpus);
 
 	workqueue_init();

So is sleeping in kernel_init_freeable valid?  It seems as if it
wouldn't be an atomic context.  And is the fact that the failure looks
precisely the same coincidence?

Rich.

[1] https://news.ycombinator.com/item?id=36336059

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-top is 'top' for virtual machines.  Tiny program with many
powerful monitoring features, net stats, disk stats, logging, etc.
http://people.redhat.com/~rjones/virt-top

