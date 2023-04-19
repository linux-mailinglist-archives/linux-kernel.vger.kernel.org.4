Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4686E7027
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 02:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbjDSAGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 20:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjDSAGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 20:06:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584985FD1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 17:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681862728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iqYcQJ7RxHLqq2m5mcHetAO2yttoUlP/01PDG9Z2dnM=;
        b=TcPPxWOMEUGbYOp37hYfFCjyIrjQLN+0h6yjA5WWFbAIKT5H7wqK5Eu7FX8OJeB9RIskTS
        +VBEGCxEujvf0DgED1SqIv6o0VQrYTGJ3usIPOopJBQsLs0Hu87AMk5Pa010ofnSpWTU3T
        FNRD9XGHA59FcepqozjPjPa7lYt/ybA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-618-lhN3jzYlOMG7_cdy7DrwjA-1; Tue, 18 Apr 2023 20:05:22 -0400
X-MC-Unique: lhN3jzYlOMG7_cdy7DrwjA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 81B788996E0;
        Wed, 19 Apr 2023 00:05:21 +0000 (UTC)
Received: from localhost (ovpn-12-26.pek2.redhat.com [10.72.12.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 434E12958;
        Wed, 19 Apr 2023 00:05:20 +0000 (UTC)
Date:   Wed, 19 Apr 2023 08:05:16 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Eric DeVolder <eric.devolder@oracle.com>, bp@alien8.de,
        x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        ebiederm@xmission.com, dyoung@redhat.com, vgoyal@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
Subject: Re: [PATCH v21 2/7] crash: add generic infrastructure for crash
 hotplug support
Message-ID: <ZD8wPOPxvh7cGJun@MiWiFi-R3L-srv>
References: <20230404180326.6890-1-eric.devolder@oracle.com>
 <20230404180326.6890-3-eric.devolder@oracle.com>
 <ZC6nWzPuIWOxmvv2@MiWiFi-R3L-srv>
 <80767ccc-ffd4-9cb9-44e4-a8d4f0e13853@oracle.com>
 <ZC9cp5RLyNNx0DMG@MiWiFi-R3L-srv>
 <7b25449b-72e9-3eca-73a9-592d7400b746@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b25449b-72e9-3eca-73a9-592d7400b746@oracle.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/18/23 at 08:55am, Eric DeVolder wrote:
......
> > > > Seems we passed in the cpu number just for printing here. Wondering why
> > > > we don't print out hot added/removed memory ranges. Is the cpu number
> > > > printing necessary?
> > > > 
> > > Baoquan,
> > > 
> > > Ah, actually until recently it was used to track the 'offlinecpu' in this
> > > function, but tglx pointed out that was un-necessary. That resulted in
> > > dropping the code in this function dealing with offlinecpu, leaving this as
> > > its only use in this function.
> > > 
> > > The printing of cpu number is not necessary, but helpful; I use it for debugging.
> > 
> > OK, I see. I am not requesting memory range printing, just try to prove
> > cpu number printing is not so justified. If it's helpful, I am OK with
> > it. Let's see if other people have concern about this.
> > 
> 
> I do not plan on adding the memory range printing.
> 
> > > 
> > > The printing of memory range is also not necessary, but in order to do that,
> > > should we choose to do so, requires passing in the memory range to this
> > > function. This patch series did do this early on, and by v7 I dropped it at
> > > your urging (https://lore.kernel.org/lkml/20220401183040.1624-1-eric.devolder@oracle.com/).
> > > At the time, I provided it since I considered this generic infrastructure,
> > > but I could not defend it since x86 didn't need it. However, PPC now needs
> > > this, and is now carrying this as part of PPC support of CRASH_HOTPLUG (https://lore.kernel.org/linuxppc-dev/20230312181154.278900-6-sourabhjain@linux.ibm.com/T/#u).
> > > 
> > > If you'd rather I pickup the memory range handling again, I can do that. I
> > > think I'd likely change this function to be:
> > > 
> > >    void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu,
> > >       struct memory_notify *mhp);
> > > 
> > > where on a CPU op the 'cpu' parameter would be valid and 'mhp' NULL, and on a memory op,
> > > the 'mhp' would be valid and 'cpu' parameter invalid(0).
> > > 
> > > I'd likely then stuff these two parameters into struct kimage so that it can
> > > be utilized by arch-specific handler, if needed.
> > > 
> > > And of course, would print out the memory range for debug purposes.
> > > 
> > > Let me know what you think.
> > 
> 
> I do not plan on adding the memory range handling; I'll let Sourabh do that as he has a use case for it.
> 
> As such, I don't see any other request for changes.

OK, then I have no concern about this patchset. Thanks a lot for all
these effort, Eric.

Hi x86 maintainers,

Could you help check if there's anything we need improve, or consider
taking this patchset?

Thanks
Baoquan

