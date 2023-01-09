Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB92D662AE3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 17:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjAIQI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 11:08:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjAIQIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 11:08:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3DD392CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 08:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673280475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2SQ2EfGPkJFKwdsmUYnmI+8rY4vbT4v8q8/Oih2chZ8=;
        b=D7h1pVkBlRaW46I5D6xUCAjhdLecOVP/cKct/NVMW2n+kCRSZeCVOtlkWAIuX1nzK8MTR/
        Nc8JqSzU/mnj2tdgJgw5Z7x+sxg8iO9n9GZUNB9xOvJILPeSh8cSlaEMx8Hf4GJl7Ix8lk
        pFmNaXeAQL46PyxKJZ/SkucVFj52oAI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-100-KiewLg1IP5COvWNbRixStg-1; Mon, 09 Jan 2023 11:07:52 -0500
X-MC-Unique: KiewLg1IP5COvWNbRixStg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E37BE3C02B74;
        Mon,  9 Jan 2023 16:07:51 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 82B5D1121314;
        Mon,  9 Jan 2023 16:07:51 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 42B0A4050992C; Mon,  9 Jan 2023 11:12:49 -0300 (-03)
Date:   Mon, 9 Jan 2023 11:12:49 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     atomlin@atomlin.com, frederic@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v13 3/6] mm/vmstat: manage per-CPU stats from CPU context
 when NOHZ full
Message-ID: <Y7wg4bC65mNcpElo@tpad>
References: <20230105125218.031928326@redhat.com>
 <20230106001244.4463-1-hdanton@sina.com>
 <20230106150154.4560-1-hdanton@sina.com>
 <20230107001529.4617-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230107001529.4617-1-hdanton@sina.com>
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

Hi Hillf,

On Sat, Jan 07, 2023 at 08:15:29AM +0800, Hillf Danton wrote:
> On 6 Jan 2023 15:16:23 -0300 Marcelo Tosatti <mtosatti@redhat.com>
> > On Fri, Jan 06, 2023 at 11:01:54PM +0800, Hillf Danton wrote:
> > > On 6 Jan 2023 09:51:00 -0300 Marcelo Tosatti <mtosatti@redhat.com>
> > > > On Fri, Jan 06, 2023 at 08:12:44AM +0800, Hillf Danton wrote:
> > > > > 
> > > > > Regression wrt V12 if timer is added on the CPU that is not doing HK_TYPE_TIMER?
> > > > 
> > > > Before this change, the timer was managed (and queued on an isolated
> > > > CPU) by vmstat_shepherd. Now it is managed (and queued) by the local
> > > > CPU, so there is no regression.
> > > 
> > > Given vm stats folded when returning to userspace, queuing the delayed work
> > > barely makes sense in the first place. If it can be canceled, queuing it burns
> > > cycles with nothing earned. Otherwise vm stats got folded already.
> > 
> > Agree, but you can't know whether return to userspace will occur 
> > before the timer is fired.
> 
> No way to predict a random timer expiration, no?

Right.

> > 
> > So queueing the timer is to _ensure_ that eventually vmstats will be 
> > synced (which maintains the current timing behaviour wrt vmstat syncs).
> 
> After this change,
> 
> > > > > > @@ -1988,13 +2022,19 @@ void quiet_vmstat(void)
> > > > > >  	if (!is_vmstat_dirty())
> > > > > >  		return;
> > > > > >  
> 
> it is only ensured eventually by this check instead.

Yes, but if you do not return to userspace, then the per-CPU vm
statistics can be dirty indefinitely.

> > > > > > +	refresh_cpu_vm_stats(false);
> > > > > > +
> > > > > > +	if (!IS_ENABLED(CONFIG_FLUSH_WORK_ON_RESUME_USER))
> > > > > > +		return;
> > > > > > +
> > > > > > +	if (!user)
> > > > > > +		return;
> 
> 
> > Also don't think the queueing cost is significant: it only happens
> > for the first vmstat dirty item.
> 
> Cost is considered only if it is needed.

Not sure i understand what you mean (or whether there is any alternative
to the timer).

