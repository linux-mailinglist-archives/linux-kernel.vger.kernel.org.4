Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554C5660794
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 21:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236190AbjAFUH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 15:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236145AbjAFUHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 15:07:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFD441678
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 12:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673035620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=782xKD92TRBAnQZNDD+gjmN9QEeCF70KQdy4tyYVbXE=;
        b=jAq+EhWplkMo8JqwQBxrI63AqZobF4pM0/K8lzbCEyrjujV+faf/05g96NvA/WoIYFTrYB
        pwiUpmyrPIy85tM+z+of6dk+0wKEOG8bCcxwgiDL9Zv/KSNiBoW4dkDo6rR8rvfvazjOGR
        LXJ48TEVBn6uYxnMWdMDXWZfy8Cfbik=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-652-n3xa0o0KNtq6AzivjTnSgQ-1; Fri, 06 Jan 2023 15:06:57 -0500
X-MC-Unique: n3xa0o0KNtq6AzivjTnSgQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D0DA03C0253D;
        Fri,  6 Jan 2023 20:06:56 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 70A611121314;
        Fri,  6 Jan 2023 20:06:56 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 1072E401B7EC8; Fri,  6 Jan 2023 15:16:23 -0300 (-03)
Date:   Fri, 6 Jan 2023 15:16:23 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     atomlin@atomlin.com, frederic@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v13 3/6] mm/vmstat: manage per-CPU stats from CPU context
 when NOHZ full
Message-ID: <Y7hld2ac9FLppmfD@tpad>
References: <20230105125218.031928326@redhat.com>
 <20230106001244.4463-1-hdanton@sina.com>
 <20230106150154.4560-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230106150154.4560-1-hdanton@sina.com>
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

On Fri, Jan 06, 2023 at 11:01:54PM +0800, Hillf Danton wrote:
> On 6 Jan 2023 09:51:00 -0300 Marcelo Tosatti <mtosatti@redhat.com>
> > On Fri, Jan 06, 2023 at 08:12:44AM +0800, Hillf Danton wrote:
> > > 
> > > Regression wrt V12 if timer is added on the CPU that is not doing HK_TYPE_TIMER?
> > 
> > Before this change, the timer was managed (and queued on an isolated
> > CPU) by vmstat_shepherd. Now it is managed (and queued) by the local
> > CPU, so there is no regression.
> 
> Given vm stats folded when returning to userspace, queuing the delayed work
> barely makes sense in the first place. If it can be canceled, queuing it burns
> cycles with nothing earned. Otherwise vm stats got folded already.

Agree, but you can't know whether return to userspace will occur 
before the timer is fired.

So queueing the timer is to _ensure_ that eventually vmstats will be 
synced (which maintains the current timing behaviour wrt vmstat syncs).

Also don't think the queueing cost is significant: it only happens
for the first vmstat dirty item.

> Nor does shepherd even without delay. And the right thing is only make shepherd
> leave isolated CPUs intact.
> 
> 

