Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16D56E7938
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 14:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbjDSMBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 08:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbjDSMBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 08:01:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAB314F77
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 04:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681905596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GgJsIrXz2K4kfjtSt6CE3VKf8/GPSBf/X6+HAGfKUzI=;
        b=CtkfQU/d6z8QVLOpqQZF7Fqpatvu7nEbEmg89kvgSjw0AKpCza5X1liEKQLTEkIK0wckrX
        2aDwSUTSiRlyaHYq4THxFrY0DpxalbEmHxlhJz9vuLS42/+PMhXq23+cpaM5yYXec0xv8K
        LIM5Ly82UUWD8mhC2ilO0Vv9J6mmNgc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-674-Z0iXaEeHMbC2T1VUriRtww-1; Wed, 19 Apr 2023 07:59:51 -0400
X-MC-Unique: Z0iXaEeHMbC2T1VUriRtww-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AD271884ECF;
        Wed, 19 Apr 2023 11:59:50 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F07CA2166B36;
        Wed, 19 Apr 2023 11:59:49 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 2D69A40E019C9; Wed, 19 Apr 2023 08:59:28 -0300 (-03)
Date:   Wed, 19 Apr 2023 08:59:28 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Russell King <linux@armlinux.org.uk>,
        Huacai Chen <chenhuacai@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, x86@kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v7 00/13] fold per-CPU vmstats remotely
Message-ID: <ZD/XoBTqJBL2G+Dk@tpad>
References: <20230320180332.102837832@redhat.com>
 <20230418150200.027528c155853fea8e4f58b2@linux-foundation.org>
 <ZD/NAaa5TVcL7Mxm@tpad>
 <ZD/Qq9v0EDxUn7HW@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZD/Qq9v0EDxUn7HW@tpad>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 08:29:47AM -0300, Marcelo Tosatti wrote:
> On Wed, Apr 19, 2023 at 08:14:09AM -0300, Marcelo Tosatti wrote:
> > This was tried before:
> > https://lore.kernel.org/lkml/20220127173037.318440631@fedora.localdomain/
> > 
> > My conclusion from that discussion (and work) is that a special system
> > call:
> > 
> > 1) Does not allow the benefits to be widely applied (only modified
> > applications will benefit). Is not portable across different operating systems. 
> > 
> > Removing the vmstat_work interruption is a benefit for HPC workloads, 
> > for example (in fact, it is a benefit for any kind of application, 
> > since the interruption causes cache misses).
> > 
> > 2) Increases the system call cost for applications which would use
> > the interface.
> > 
> > So avoiding the vmstat_update update interruption, without userspace 
> > knowledge and modifications, is a better than solution than a modified
> > userspace.
> 
> Another important point is this: if an application dirties
> its own per-CPU vmstat cache, while performing a system call,

Or while handling a VM-exit from a vCPU.

This are, in my mind, sufficient reasons to discard the "flush per-cpu
caches" idea. This is also why i chose to abandon the prctrl interface
patchset.

> and a vmstat sync event is triggered on a different CPU, you'd have to:
> 
> 1) Wait for that CPU to return to userspace and sync its stats
> (unfeasible).
> 
> 2) Queue work to execute on that CPU (undesirable, as that causes
> an interruption).
> 
> 3) Remotely sync the vmstat for that CPU.


