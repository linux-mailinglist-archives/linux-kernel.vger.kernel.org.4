Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8BC964B7B2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 15:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235491AbiLMOrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 09:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235646AbiLMOqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 09:46:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D746144
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 06:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670942766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TDTummWpVHLBTOI1ESXdr5O5IWYx/wuq8cEUFeith0Q=;
        b=A/9WWTTfN6/s29tzGhZM/be0c7jpfK9Re49PHr88/zqhiM3jFjiecOf+4Jn3/5j79od8pE
        H9DwvumoZMY1DglQ3chTfyCKt5EGzciOhcgp8jHYAC1N1b3Adm7Ei5YvU+gEd3QR+Ku6Ar
        a3TZ12VsVNrnlT7GrSIy3VJNn8aNSCc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-532-ERimchgWPFC2iEtMqYqjZg-1; Tue, 13 Dec 2022 09:46:05 -0500
X-MC-Unique: ERimchgWPFC2iEtMqYqjZg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 786E13815D28;
        Tue, 13 Dec 2022 14:46:03 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.17.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BCAE9C15BA0;
        Tue, 13 Dec 2022 14:46:02 +0000 (UTC)
Date:   Tue, 13 Dec 2022 09:45:58 -0500
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
Message-ID: <Y5iQJqCoxJH+GcqH@lorien.usersys.redhat.com>
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
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 03:31:06PM +0100 Greg Kroah-Hartman wrote:
> On Tue, Dec 13, 2022 at 08:22:58AM -0500, Phil Auld wrote:
> > On Tue, Dec 13, 2022 at 07:23:54AM +0100 Greg Kroah-Hartman wrote:
> > > On Mon, Dec 12, 2022 at 02:17:58PM -0500, Phil Auld wrote:
> > > > Hi,
> > > > 
> > > > On Tue, Nov 08, 2022 at 01:24:39PM +0100 Greg Kroah-Hartman wrote:
> > > > > On Tue, Nov 08, 2022 at 03:30:46PM +0530, Vishal Chourasia wrote:
> > > > > > 
> > > > > > Thanks Greg & Peter for your direction. 
> > > > > > 
> > > > > > While we pursue the idea of having debugfs based on kernfs, we thought about
> > > > > > having a boot time parameter which would disable creating and updating of the
> > > > > > sched_domain debugfs files and this would also be useful even when the kernfs
> > > > > > solution kicks in, as users who may not care about these debugfs files would
> > > > > > benefit from a faster CPU hotplug operation.
> > > > > 
> > > > > Ick, no, you would be adding a new user/kernel api that you will be
> > > > > required to support for the next 20+ years.  Just to get over a
> > > > > short-term issue before you solve the problem properly.
> > > > 
> > > > I'm not convinced moving these files from debugfs to kernfs is the right
> > > > fix.  That will take it from ~50 back to ~20 _minutes_ on these systems.
> > > > I don't think either of those numbers is reasonable.
> > > > 
> > > > The issue as I see it is the full rebuild for every change with no way to
> > > > batch the changes. How about something like the below?
> > > > 
> > > > This puts the domains/* files under the sched_verbose flag. About the only
> > > > thing under that flag now are the detailed topology discovery printks anyway
> > > > so this fits together nicely.
> > > > 
> > > > This way the files would be off by default (assuming you don't boot with
> > > > sched_verbose) and can be created at runtime by enabling verbose. Multiple
> > > > changes could also be batched by disabling/makeing changes/re-enabling.
> > > > 
> > > > It does not create a new API, uses one that is already there.
> > > 
> > > The idea seems good, the implementation might need a bit of work :)
> > 
> > More than the one comment below? Let me know.
> 
> No idea, resubmit a working patch and I'll review it properly :)
>

Will do. 


Thanks,
Phil


-- 

