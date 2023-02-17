Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8235B69A911
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 11:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjBQK0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 05:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjBQK0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 05:26:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A474627F9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 02:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676629535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YsperIyfVkY2ln7H9Mme70veH+mGxMSmpgkeJjryR1A=;
        b=duqDrehpbvGvrne09oCKnVZuYDcOYtjI1ZK5rFjbVmQNuiHh9dNhFtIqMixC58F6n2n6Dn
        8zeQVPaPT3wZE0o24qvtey0dB1Glnw3nbKdbxUpj4/qu27nHfz34LYBJWZUoRAulDmc42F
        A+7Er8vu+0x5wqxX1q8Cj6YnhsmIc+8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-434-7rlDfPfMPDuQHljtGKgbgQ-1; Fri, 17 Feb 2023 05:25:31 -0500
X-MC-Unique: 7rlDfPfMPDuQHljtGKgbgQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 67C29802314;
        Fri, 17 Feb 2023 10:25:30 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (ovpn-194-117.brq.redhat.com [10.40.194.117])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2492C43FBA;
        Fri, 17 Feb 2023 10:25:26 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 17 Feb 2023 11:25:25 +0100 (CET)
Date:   Fri, 17 Feb 2023 11:25:21 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     David Vernet <void@manifault.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, kernel-team@meta.com,
        torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tasks: Extract rcu_users out of union
Message-ID: <20230217102521.GA27682@redhat.com>
References: <20230215233033.889644-1-void@manifault.com>
 <20230216080459.GA5200@redhat.com>
 <Y+54c0YvXcMIFva4@maniforge>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+54c0YvXcMIFva4@maniforge>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/16, David Vernet wrote:
>
> On Thu, Feb 16, 2023 at 09:04:59AM +0100, Oleg Nesterov wrote:
> >
> > >    a task that's successfully looked
> > >    up in e.g. the pid_list with find_task_by_pid_ns(), can always have a
> > >    'usage' reference acquired on them, as it's guaranteed to be >
> > >    0 until after the next gp.
> >
> > Yes. So it seems you need another key-to-task_struct map with rcu-safe
> > lookup/get and thus the add() method needs inc_not_zero(task->rcu_users) ?
>
> Yes, exactly.

OK, in this case I agree, inc_not_zero(rcu_users) makes sense and thus we need
this patch.

Just I was confused by the previous part of the changelog due to my bad English.

Thanks,

Oleg.

