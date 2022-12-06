Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4426F6449BB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 17:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235665AbiLFQuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 11:50:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235462AbiLFQuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 11:50:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757342AEE
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 08:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670345382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gQVj/FAk6QDQrcuyuYJJ6Wfs8dTdR09EgNSH0Y+Vk4w=;
        b=VqT5osVMZ/68mkiOqej5k8zcxkb7J6JxdqemESPPeVjjAQ7hzaEO5KdNWzclCKDxT5tuiD
        4G8JJ6N7OdtT37bK2k27RAsKRLQqy0wvPfwxDkASpNq1YkMiBGMop32YQY6CfvMVvkBFSX
        dgiNguab1DKK8GbYnx5DYHZYtzetckY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-299-1XgyIYveNcqU1pRjiRWvUw-1; Tue, 06 Dec 2022 11:49:32 -0500
X-MC-Unique: 1XgyIYveNcqU1pRjiRWvUw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B108E185A7A9;
        Tue,  6 Dec 2022 16:49:31 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (ovpn-192-116.brq.redhat.com [10.40.192.116])
        by smtp.corp.redhat.com (Postfix) with SMTP id 84AC4FD48;
        Tue,  6 Dec 2022 16:49:29 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue,  6 Dec 2022 17:49:31 +0100 (CET)
Date:   Tue, 6 Dec 2022 17:49:28 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org
Subject: Re: [PATCH 3/3] rcu-tasks: Fix synchronize_rcu_tasks() VS
 zap_pid_ns_processes()
Message-ID: <20221206164927.GD3866@redhat.com>
References: <20221125135500.1653800-1-frederic@kernel.org>
 <20221125135500.1653800-4-frederic@kernel.org>
 <871qpkqof8.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871qpkqof8.fsf@email.froward.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30, Eric W. Biederman wrote:
>
> 2) I keep thinking zap_pid_ns_processes() should be changed so that
>    after it sends SIGKILL to all of the relevant processes to not wait,

At least I think it should not wait for the tasks injected into this ns.

Because this looks like a kernel bug even if we forget about this deadlock.

Say we create a task P using clone(CLONE_NEWPID), then inject a task T into
P's pid-namespace via setns/fork. This make the process P "unkillable", it
will hang in zap_pid_ns_processes() "forever" until T->parent reaps a zombie
task T killed by P.

Oleg.

