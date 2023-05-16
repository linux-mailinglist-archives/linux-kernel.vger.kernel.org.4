Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE6C7043C9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 05:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjEPDBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 23:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjEPDBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 23:01:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA014233
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 20:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684206020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AEAd3D4zy/iD7bH1Yo/MWqtNt/Zaten+LoJ4wRMWN0U=;
        b=Il98YbjcOUfeXU8DHTM0vMYPc2JFFY7p0SLJQP9D7Cu8Oep3XkFEqOq4NGfvnyNlXPI9qp
        e0Fo/vuTFoKINZqNSNc2MYrYeOZA7Yb2aHz7UPh/XVYIE4pj7bQLyw9jdb2Z8cpZFRW68c
        ly8B5BG5evAtTYKh7rBRwRNNyj8dlhM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-331-4FWlob5xMauTLOaaeX6gTA-1; Mon, 15 May 2023 23:00:15 -0400
X-MC-Unique: 4FWlob5xMauTLOaaeX6gTA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 968591C09500;
        Tue, 16 May 2023 03:00:14 +0000 (UTC)
Received: from localhost (ovpn-12-32.pek2.redhat.com [10.72.12.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B316714171B6;
        Tue, 16 May 2023 03:00:13 +0000 (UTC)
Date:   Tue, 16 May 2023 11:00:10 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        horms@kernel.org, thunder.leizhen@huawei.com,
        John.p.donnelly@oracle.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5] arm64: kdump: simplify the reservation behaviour of
 crashkernel=,high
Message-ID: <ZGLxul+c4vYQBn27@MiWiFi-R3L-srv>
References: <20230407022419.19412-1-bhe@redhat.com>
 <20230414143413.GA27911@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414143413.GA27911@willie-the-truck>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On 04/14/23 at 03:34pm, Will Deacon wrote:
> Hi,
> 
> On Fri, Apr 07, 2023 at 10:24:19AM +0800, Baoquan He wrote:
> > On arm64, reservation for 'crashkernel=xM,high' is taken by searching for
> > suitable memory region top down. If the 'xM' of crashkernel high memory
> > is reserved from high memory successfully, it will try to reserve
> > crashkernel low memory later accoringly. Otherwise, it will try to search
> > low memory area for the 'xM' suitable region. Please see the details in
> > Documentation/admin-guide/kernel-parameters.txt.
> 
> [...]
> 
> >  arch/arm64/mm/init.c | 44 ++++++++++++++++++++++++++++++++++----------
> >  1 file changed, 34 insertions(+), 10 deletions(-)
> 
> I tried to apply this, but smatch is unhappy with the result:
> 
>   | arch/arm64/mm/init.c:153 reserve_crashkernel() error: uninitialized symbol 'search_base'.
> 
> I _think_ this is a false positive, but I must say that the control flow
> in reserve_crashkernel() is extremely hard to follow so I couldn't be
> sure. If the static checker is struggling, then so will humans!
> 
> Ideally, this would all be restructured to make it easier to follow,
> but in the short term we need something to squash the warning.

I tried to refactor the code as you suggested, while it seems not easy
to do. The complexity comes from several cases which need be handled.
I try my best to write a document with the things I think important to
help understand the code. Please help check if it helps or we just having
the current code is fine.

Thanks
Baoquan

