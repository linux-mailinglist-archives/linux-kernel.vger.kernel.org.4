Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1B25F0787
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 11:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbiI3JZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 05:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiI3JZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:25:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BF5474F0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 02:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664529899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L1SJANDr5slVxmH6M0J7RBmBMz9Cu2VImN3b1/69eLw=;
        b=FvIKcpHC5GhoPzeCjPh9ScxOV5aa8vYdasWYyVsvLNLVHyU9kC6gAXQeJUEmyL9WWFne97
        qiZgQHHsNf3mrXobAgIWaiTxLnv7A3WOZ6uHR6mHCEVLYezHe8brIcaOuGCoPnSSKg2ykB
        /y87x6vzzgsgcVBzy24vVcStiAWrEkI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-581-HRAnQ8q2MTqo1Wm3tV42Tg-1; Fri, 30 Sep 2022 05:24:54 -0400
X-MC-Unique: HRAnQ8q2MTqo1Wm3tV42Tg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EAB6C804184;
        Fri, 30 Sep 2022 09:24:53 +0000 (UTC)
Received: from localhost (ovpn-12-133.pek2.redhat.com [10.72.12.133])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ACE17492CA2;
        Fri, 30 Sep 2022 09:24:52 +0000 (UTC)
Date:   Fri, 30 Sep 2022 17:24:48 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Mike Rapoport <rppt@kernel.org>, Chao Ye <cye@redhat.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        guanghuifeng@linux.alibaba.com, mark.rutland@arm.com,
        will@kernel.org, linux-mm@kvack.org, thunder.leizhen@huawei.com,
        wangkefeng.wang@huawei.com, kexec@lists.infradead.org
Subject: Re: [PATCH 1/2] arm64, kdump: enforce to take 4G as the crashkernel
 low memory end
Message-ID: <Yza14IroN9Ke/3uN@MiWiFi-R3L-srv>
References: <20220828005545.94389-2-bhe@redhat.com>
 <Yw8PvF5d2uuWy6Cl@kernel.org>
 <Yw9wU/S8cP0ntR3g@MiWiFi-R3L-srv>
 <YxBeS0G+F+fsBgod@kernel.org>
 <YxCk0mX5IzhvK9Pv@MiWiFi-R3L-srv>
 <YxXPannyTqBZInAt@kernel.org>
 <YxXmsKYGTd1+/U12@MiWiFi-R3L-srv>
 <CAMj1kXFDhbMPNcFnogyi7RXATqyHpqJLK9wiz=djRM3g65J8Zg@mail.gmail.com>
 <YyrBFvD2ID8sqhEK@kernel.org>
 <YzaU99WgKFzpSN4P@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzaU99WgKFzpSN4P@MiWiFi-R3L-srv>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/30/22 at 03:04pm, Baoquan He wrote:
> Hi Mike,
> 
> On 09/21/22 at 10:45am, Mike Rapoport wrote:
> > On Tue, Sep 06, 2022 at 03:05:57PM +0200, Ard Biesheuvel wrote:
> > > 
> > > While I appreciate the effort that has gone into solving this problem,
> > > I don't think there is any consensus that an elaborate fix is required
> > > to ensure that the crash kernel can be unmapped from the linear map at
> > > all cost. In fact, I personally think we shouldn't bother, and IIRC,
> > > Will made a remark along the same lines back when the Huawei engineers
> > > were still driving this effort.
> > > 
> > > So perhaps we could align on that before doing yet another version of this?
> > 
> > I suggest to start with disabling crash kernel protection when its memory
> > reservation is deferred and then Baoquan and kdump folks can take it from
> > here.
> 
> Thanks for the attempt, really appreciated. We all tried and all see
> everybody's effort on this issue.
> 
> If disabling protection is chosen, I would suggest disable it at all.
> The system w/o having CONFIG_ZONE_DMA|32 is rarely seen, I don't think
> we need do the protection for it specifically to make code inconsistent
> and could confuse people. We can revert below commit and its later
> change do to that.
> 
> commit 98d2e1539b84 ("arm64: kdump: protect crash dump kernel memory")
> 
> For RPi4, I tried to find one to test and figure out if it can do crash
> dumping with buffer above 1G. However, nobody care about kdump when I
> asked people around who have one at hand for testing, hobby, or
> developping. Since they are not familiar with kdump setting and not so
> eager to get to know, and I don't want to take up too much time, finally
> I just give up.

Finally, I got help from Chao who is team lead of our kernel QE. Chao
has a RPi4 and he tested different cases of kdump, now we can confirm
that on RPi4 the TF card and usb disk are all 30bit DMA addressing
limited. Just FYI. And thanks again to Chao for his help and patience.

