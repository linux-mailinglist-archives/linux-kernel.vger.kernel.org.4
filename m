Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAAC7302E8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 17:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343541AbjFNPIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 11:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343523AbjFNPIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 11:08:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B41189
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 08:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686755240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wGHMe8IA6mAo0HMH3lZ/8EExV+cg7D2Uq+MQfhPcyas=;
        b=et+NrPcIWnIxy5/Lqr5LOYhTfqlyfz74RNPIeFcedeQKy9m3RxwwCKunIUmbwRFmF4tVW/
        BEJ/JIn/GSKEOMpH589smidNTk4oYhFCBPglj01Mu4uSf0gipeh/GBBWEm4ugjmh5XrQ7Z
        Pas7hnAnX52XhvIQnOVMmFYkWt/jW9k=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-66-7l4Ipb7wPzmenxHuK39-gw-1; Wed, 14 Jun 2023 11:07:18 -0400
X-MC-Unique: 7l4Ipb7wPzmenxHuK39-gw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 29D573806706;
        Wed, 14 Jun 2023 15:07:18 +0000 (UTC)
Received: from localhost (unknown [10.39.192.206])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DF96C9E9F;
        Wed, 14 Jun 2023 15:07:17 +0000 (UTC)
Date:   Wed, 14 Jun 2023 16:07:17 +0100
From:   "Richard W.M. Jones" <rjones@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Aaron Thompson <dev@aaront.org>, linux-kernel@vger.kernel.org
Subject: Re: printk.time causes rare kernel boot hangs
Message-ID: <20230614150717.GG7636@redhat.com>
References: <20230613134105.GA10301@redhat.com>
 <20230614092158.GF1639749@hirez.programming.kicks-ass.net>
 <20230614094522.GA7636@redhat.com>
 <20230614103011.GL7912@redhat.com>
 <20230614103953.GM7912@redhat.com>
 <20230614113536.GJ1639749@hirez.programming.kicks-ass.net>
 <20230614125320.GA1640563@hirez.programming.kicks-ass.net>
 <20230614130348.GF7636@redhat.com>
 <20230614130945.GK1639749@hirez.programming.kicks-ass.net>
 <20230614145348.GB1640563@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614145348.GB1640563@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 04:53:48PM +0200, Peter Zijlstra wrote:
> On Wed, Jun 14, 2023 at 03:09:45PM +0200, Peter Zijlstra wrote:
> > On Wed, Jun 14, 2023 at 02:03:48PM +0100, Richard W.M. Jones wrote:
> > > On Wed, Jun 14, 2023 at 02:53:20PM +0200, Peter Zijlstra wrote:
> > > > Ooooh, what qemu version do you have? There were some really dodgy
> > > > reports all around self modifying code, all reported on 7.2, that seems
> > > > to have gone away with 8.
> > > 
> > > > Now, all of them were using TCG, and I think you're using KVM.
> > > 
> > > I'm using qemu-system-x86-8.0.0-4.fc39.x86_64 with KVM.  The host
> > > kernel is 6.4.0-0.rc5.41.fc39.x86_64.
> > > 
> > > > I've at least 36000 cycles and still nothing :-(, let me go try your
> > > > .config.
> > > 
> > > I can definitely reproduce this with your config (but AMD host), so
> > > that's odd.  Let me try with Intel hardware and your config.  You
> > > really should see this with only a few thousands iterations.
> > 
> > Yeah, I'm running on some ancient ivb-ep, let me try on the alderlake. I
> > don't really have AMD machines at hand :-/
> 
> Using v6.4-rc6-37-gb6dad5178cea, and 36000+ cycles on the ADL (affine to
> big cores) later and nothing :-(

So I have just this minute reproduced it on Intel, after around ~2000
iterations.

On this machine I am using:

Host kernel:  6.3.7-200.fc38.x86_64
Guest kernel: git commit fb054096aea0576f0c0a61c598e5e9676443ee86
Guest config: defconfig + kvm_guest.config + CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
QEMU:         qemu-system-x86-8.0.0-4.fc39.x86_64 (using kvm_intel)
Hardware:     Intel(R) Core(TM) i7-10850H CPU @ 2.70GHz

> Clearly I'm doing something wrong.

I'm suspecting version of qemu may have something to do with it, but
honestly I don't know.  Which qemu are you using?

I'll now try with upstream qemu from git in case there's something
about the Fedora qemu.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
Fedora Windows cross-compiler. Compile Windows programs, test, and
build Windows installers. Over 100 libraries supported.
http://fedoraproject.org/wiki/MinGW

