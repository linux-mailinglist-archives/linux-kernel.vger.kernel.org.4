Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59641646278
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 21:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiLGUkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 15:40:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiLGUkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 15:40:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB5A30558
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 12:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670445549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DG3GYCB5orB9GpSLNS4eulWhDlsfNUeLR3OpnOQvJIk=;
        b=YTXHhJDcx2mWD1hg0LdIrWgzbGXSO6Em5dCipbqIVz9S0qPIL8oqGjIKYKo/l2kfCinMPB
        WQyRhJHI1mxLrh9GkAl3TkMFRgs0BmStCCuYgmgwaVb7DSW/5a1TIG8LQ6vS/hxfXGmmUL
        mSt7ITkdFEsv1GRbyx3ds0YZMzh6ak4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-70-j7YyzFPoNcShfVSQF7tpJg-1; Wed, 07 Dec 2022 15:39:03 -0500
X-MC-Unique: j7YyzFPoNcShfVSQF7tpJg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4FD311C05B12;
        Wed,  7 Dec 2022 20:39:03 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (ovpn-195-26.brq.redhat.com [10.40.195.26])
        by smtp.corp.redhat.com (Postfix) with SMTP id 14C182027061;
        Wed,  7 Dec 2022 20:39:00 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed,  7 Dec 2022 21:39:03 +0100 (CET)
Date:   Wed, 7 Dec 2022 21:39:00 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org
Subject: Re: [PATCH 3/3] rcu-tasks: Fix synchronize_rcu_tasks() VS
 zap_pid_ns_processes()
Message-ID: <20221207203859.GD5421@redhat.com>
References: <20221125135500.1653800-1-frederic@kernel.org>
 <20221125135500.1653800-4-frederic@kernel.org>
 <871qpkqof8.fsf@email.froward.int.ebiederm.org>
 <20221206164927.GD3866@redhat.com>
 <20221207200155.GA1840475@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207200155.GA1840475@lothringen>
User-Agent: Mutt/1.5.24 (2015-08-30)
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

Frederic,

before anything else, your patches look good to me, it is not that
I tried to argue!

On 12/07, Frederic Weisbecker wrote:
>
> On Tue, Dec 06, 2022 at 05:49:28PM +0100, Oleg Nesterov wrote:
> >
> > At least I think it should not wait for the tasks injected into this ns.
> >
> > Because this looks like a kernel bug even if we forget about this deadlock.
> >
> I think this was made that way on purpose,

Well maybe. But to me we have this behaviour only because we (me at least)
do not know how to avoid the "hang" in this case.

> see the comment in zap_pid_ns_processes():

Heh ;) I wrote this comment in a53b83154914 ("exit: pidns: fix/update the
comments in zap_pid_ns_processes()") exactly because I didn't like this
behaviour, but I thought it must be documented.

> I can't say I like the fact that a parent not belonging to a new namespace
> can create more than one child within that namespace

not sure I understand but this looks fine and useful to me,

> but anyway this all look like an ABI that can't be reverted now.

perhaps... But you know, I wrote my previous email because 2 weeks ago
I had to investigate a bug report which blamed the kernel, while the
problem (unkillable process sleeping in zap_pid_ns_processes) was caused
by the dangling zombie injected into that process's namespace. And I am
still trying to convince the customer they need to fix userspace.

Thanks,

Oleg.

