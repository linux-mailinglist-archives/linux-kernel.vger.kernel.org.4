Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5533368CDD7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 05:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjBGEA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 23:00:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjBGEAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 23:00:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C094DC0
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 19:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675742374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0p27cbppODhlJwN0bXzqedqZnAVkCEQHc1O/mLg04Ro=;
        b=arBDndeclV3UNTC+pnzxJ/pKmt7Pd322hKBBl/BCAxB/ece3lRifMAd+AHERr8xxcIjwqp
        9gZnjFyphflhJ6wfGACO+DgAGFA1B4ZtA92MSVB5xgrnJ9pSVZg9UP1YXWocHs+lUwREYo
        +dBWLY6UV5W1a6rGQdi/PZCsq9n0CQc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-271-lo_UqUuCNx6qqsXgSxrnPw-1; Mon, 06 Feb 2023 22:59:30 -0500
X-MC-Unique: lo_UqUuCNx6qqsXgSxrnPw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0AC6685CBE0;
        Tue,  7 Feb 2023 03:59:30 +0000 (UTC)
Received: from localhost (ovpn-12-71.pek2.redhat.com [10.72.12.71])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C7CE1121314;
        Tue,  7 Feb 2023 03:59:28 +0000 (UTC)
Date:   Tue, 7 Feb 2023 11:59:24 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, horms@kernel.org,
        thunder.leizhen@huawei.com, John.p.donnelly@oracle.com,
        will@kernel.org
Subject: Re: [PATCH v2] arm64: kdump: simplify the reservation behaviour of
 crashkernel=,high
Message-ID: <Y+HMnP9Yxi4C7KzF@MiWiFi-R3L-srv>
References: <20230203075723.114538-1-bhe@redhat.com>
 <Y91JV7wNu1QQh1Ag@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y91JV7wNu1QQh1Ag@arm.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/23 at 05:50pm, Catalin Marinas wrote:
> On Fri, Feb 03, 2023 at 03:57:23PM +0800, Baoquan He wrote:
> > On arm64, reservation for 'crashkernel=xM,high' is taken by searching for
> > suitable memory region top down. If the 'xM' of crashkernel high memory
> > is reserved from high memory successfully, it will try to reserve
> > crashkernel low memory later accoringly. Otherwise, it will try to search
> > low memory area for the 'xM' suitable region. Please see the details in
> > Documentation/admin-guide/kernel-parameters.txt.
> > 
> > While we observed an unexpected case where a reserved region crosses the
> > high and low meomry boundary. E.g on a system with 4G as low memory end,
> > user added the kernel parameters like: 'crashkernel=512M,high', it could
> > finally have [4G-126M, 4G+386M], [1G, 1G+128M] regions in running kernel.
> > The crossing 4G boudary of crashkernel high region will bring issues:
> > 
> > 1) For crashkernel=x,high, if getting crashkernel high region across
> > 4G boudary, then user will see two memory regions under 4G, and one
> > memory region above 4G. The two crashkernel low memory regions are
> > confusing.
> 
> Looking at your patch, I just realised that the 4G boundary between
> 'low' and 'high' reservations is not always true. On RPi4, that would be
> 1GB, the limit of ZONE_DMA. Are there user-space tools that rely on this
> 32-bit boundary? If they do, they'd get confused on RPi4, not sure they
> have the notion of the actual ZONE_DMA that the kernel has enabled. If
> we do want ,high to mean always 4G or higher, we'd need to change the
> logic a bit so that the search_base starts from 4G rather than
> CRASH_ADDR_LOW_MAX. We could leave the latter when ,high was not
> specified.

Oh, there could be misunderstanding here. In the current arm64, the
boundary of high memory and low memory is CRASH_ADDR_LOW_MAX. It means
on RPi4, it's 1G. While on all other systems, it's 4G. I use 4G as
boundary in patch log, because systems I know and kdump need support are
all product systems at work, e.g system in baremetal server, or guest
instance in cloud. Sorry for that, with the current crashkernel handling
code in arm64, we should cover RPi4 too so that any description is kept
consistent with code implementation.

I took 4G mainly because I took it as an example people can easily
understand. I should use a generic term. So RPi4 still uses 1G as
boundary of high and low memory.

Talking about RPi4, how do you think about my below patchset? I replied
to you in another mail to ask you for help to check below patchset, and
decide which solution we should take to address the base page mapping
for the whole system when crashkernel is set. That mail could be missed.

https://lore.kernel.org/all/Y9zaJim2oGgXMiOS@MiWiFi-R3L-srv/T/#u
==
arm64, kdump: enforce to take 4G as the crashkernel low memory end
https://lore.kernel.org/all/20220828005545.94389-1-bhe@redhat.com/T/#u


> 
> > 2) If people explicityly specify "crashkernel=x,high crashkernel=y,low"
> > and y <= 128M, when crashkernel high region crosses 4G boudary and the
> > part below 4G of crashkernel high reservation is bigger than y, the
> > expected crahskernel low reservation will be skipped. But the expected
> > crashkernel high reservation is shrank and could not satisfy user space
> > requirement.
> 
> I guess if the user passes both high and low, we should honour that and
> ignore any y <= 128M checks.

Yes, agree. In this v2 patch and the earlier v1, the 'y<=128M' checking
has been removed.

