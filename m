Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F673673D85
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 16:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjASPcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 10:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjASPcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 10:32:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998C783F8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 07:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674142282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SyecrqHkLk/PkFUatvRgjW9EozPNMXCVVPb055VprZQ=;
        b=QcYFPrk0EYhbJF7hWYo5okjLbMcKBCZmIH2a4OxUhXz1qoJho+H8iZrCMAZFSeIx5VeCs3
        GQTda3c3DQ74qiiFo9nbaepdpyxy5wXLQ3sU6L9jqHLxw5wnpMU+pEfP6Fo9+q1w2OMBGw
        qyg7cmRHX2wErB1zJa66XrhVeCAxnR4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-674-1xVW1Lw0O0u_uKWjSMixlA-1; Thu, 19 Jan 2023 10:31:20 -0500
X-MC-Unique: 1xVW1Lw0O0u_uKWjSMixlA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C3C32181E3EE;
        Thu, 19 Jan 2023 15:31:19 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.34.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 71B4C2026D68;
        Thu, 19 Jan 2023 15:31:19 +0000 (UTC)
Date:   Thu, 19 Jan 2023 10:31:18 -0500
From:   Phil Auld <pauld@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Vishal Chourasia <vishalc@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        vincent.guittot@linaro.org, vschneid@redhat.com,
        srikar@linux.vnet.ibm.com, sshegde@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, ritesh.list@gmail.com,
        aneesh.kumar@linux.ibm.com
Subject: Re: sched/debug: CPU hotplug operation suffers in a large cpu systems
Message-ID: <Y8liRrYL8WpKt+up@lorien.usersys.redhat.com>
References: <Y06ISBWhJflnV+NI@kroah.com>
 <Y1jVjX9FUuUilcjA@li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.ibm.com>
 <Y1jbhCYfktL51zNB@kroah.com>
 <Y1j5cqbyZCDlyaTn@hirez.programming.kicks-ass.net>
 <Y2oozs/YgqqRV5hq@li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.ibm.com>
 <Y2pKh3H0Ukvmfuco@kroah.com>
 <Y5d+ZqdxeJD2eIHL@lorien.usersys.redhat.com>
 <Y5gaerSL8pXZcIjR@kroah.com>
 <Y5h8sqHD9/RWNeYS@lorien.usersys.redhat.com>
 <Y5iMql1nKBkukjJK@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5iMql1nKBkukjJK@kroah.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, et alia,

On Tue, Dec 13, 2022 at 03:31:06PM +0100 Greg Kroah-Hartman wrote:
> On Tue, Dec 13, 2022 at 08:22:58AM -0500, Phil Auld wrote:

> > > 
> > > The idea seems good, the implementation might need a bit of work :)
> > 
> > More than the one comment below? Let me know.
> 
> No idea, resubmit a working patch and I'll review it properly :)
> 

I finally got this posted, twice :(. Sorry for the delay, I ran into
what turned out to be an unrelated issue while testing it, plus end of
the year holidays and what not. 

https://lore.kernel.org/lkml/20230119150758.880189-1-pauld@redhat.com/T/#u


Cheers,
Phil

-- 

