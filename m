Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3137C6B957E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 14:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbjCNNHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 09:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbjCNNHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 09:07:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511669660D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 06:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678798871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D06c//mkuRZpyD98H/EEIb+v0SXKaLD4v4bbKZoJ7V8=;
        b=HdZnsTBwGJnu/8YSauDvK7g/diZdFgXRjA4i8nupPFTfuZPfgXXr1dNaJiNkKGSfR+iu9I
        0psYvBqo4DUKNHSnqXEBaD1jJi9AjzDQ9Nwf4kkW6NHXMdqsqwXH5QbeAU6U3Glm7izty2
        yLh4SWIz5304FIHmImBZgSmdnVhEIgw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-Yx1YLFLyM4Gf1wS5IuyFMg-1; Tue, 14 Mar 2023 09:01:07 -0400
X-MC-Unique: Yx1YLFLyM4Gf1wS5IuyFMg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B23BC1C0878B;
        Tue, 14 Mar 2023 13:01:05 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 877D91121315;
        Tue, 14 Mar 2023 13:01:05 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id E4F1740416724; Tue, 14 Mar 2023 10:00:46 -0300 (-03)
Date:   Tue, 14 Mar 2023 10:00:46 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Russell King <linux@armlinux.org.uk>,
        Huacai Chen <chenhuacai@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, x86@kernel.org,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v5 00/12] fold per-CPU vmstats remotely
Message-ID: <ZBBv/l6NshXFI8vW@tpad>
References: <20230313162507.032200398@redhat.com>
 <ZBBn0evSQeuiNna4@dhcp22.suse.cz>
 <ZBBvuYkWgtVXCV7J@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBBvuYkWgtVXCV7J@tpad>
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

On Tue, Mar 14, 2023 at 09:59:37AM -0300, Marcelo Tosatti wrote:
> > Why is that a problem? Out-of-sync stats shouldn't cause major problems.
> > Or can they?
> 
> Consider SCHED_FIFO task that is polling the network queue (say
> testpmd).
> 
> 	do {
> 	 	if (net_registers->state & DATA_AVAILABLE) {
> 			process_data)();
> 		}
> 	 } while (!stopped);
> 
> Since this task runs at SCHED_FIFO priority, kworker won't 
> be scheduled to run (therefore per-CPU vmstats won't be
> flushed to global vmstats). 
> 
> Or, if testpmd runs at SCHED_OTHER, then the work item to
> flush per-CPU vmstats causes
> 
> 	testpmd -> kworker
> 	kworker: flush per-CPU vmstats
> 	kworker -> testpmd
> 
> And this might cause undesired latencies to the packets being
> processed by the testpmd task.

This problem is unrelated to the kswapd problem, but both are addressed
by the patchset.

