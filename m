Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1114688838
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 21:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbjBBUX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 15:23:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232893AbjBBUXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 15:23:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D8F7A84
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 12:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675369380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RJI0C60WJGK2M/6vyBhzt6buIMsXF8h2vBudSlcCqtU=;
        b=LFcv1dQ+h3/TKTBcUvNFefXi/Ux0IV7vDy+TrBlI2VyfCZQ4fnURcCRKfSQsrpdAuaHRTs
        NppkCKsEFguu6fme3oHyZXQV15Jd4VYuYKuWeri0DU5iLeEsvReK7LO6m7rIurbAkzQ5SG
        oAy0UBHmlVjdMPBwO5HpL6QNaYIrfoI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-198-f9xXDgAnO-W9B1M0GMovRw-1; Thu, 02 Feb 2023 15:22:54 -0500
X-MC-Unique: f9xXDgAnO-W9B1M0GMovRw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CE7393C38FE2;
        Thu,  2 Feb 2023 20:22:53 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (ovpn-192-48.brq.redhat.com [10.40.192.48])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0FE36492C3E;
        Thu,  2 Feb 2023 20:22:49 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu,  2 Feb 2023 21:22:50 +0100 (CET)
Date:   Thu, 2 Feb 2023 21:22:46 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Wander Lairson Costa <wander@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrei Vagin <avagin@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Hu Chunyu <chuhu@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Paul McKenney <paulmck@kernel.org>
Subject: Re: [PATCH v3] kernel/fork: beware of __put_task_struct calling
 context
Message-ID: <20230202202245.GB17563@redhat.com>
References: <20230201124541.62104-1-wander@redhat.com>
 <20230202183735.GA17563@redhat.com>
 <CAAq0SUmYbpTnVBe+FEn+wQjLsfaAv-uxP0QuNEpSh8iaxAD+1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAq0SUmYbpTnVBe+FEn+wQjLsfaAv-uxP0QuNEpSh8iaxAD+1g@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02, Wander Lairson Costa wrote:
>
> > We already have delayed_put_task_struct() which differs very much.
> > Perhaps something like ___put_task_struct() will look less confusing.
> >
>
> ___put_task_struct()? I already added a function with this name below.

Ah, I meant ___put_task_struct_rcu() or something like this. Bug again
this is just cosmetic nit, please ignore

> > > +void __put_task_struct(struct task_struct *tsk)
> > > +{
> > > +     if (IS_ENABLED(CONFIG_PREEMPT_RT) && (!preemptible() || !in_task()))
> > > +             /*
> > > +              * under PREEMPT_RT, we can't call put_task_struct
> > > +              * in atomic context because it will indirectly
> > > +              * acquire sleeping locks.
> > > +              */
> > > +             call_rcu(&tsk->rcu, __delayed_put_task_struct);
> >
> > Perhaps this deserves additional note to explain why is it safe to use tsk->rcu
> > union. May be this is obvious, but I was confused when I looked at the previous
> > version ;)
> >
>
> Makes sense, I will add it in the next version.

Thanks ;)

Oleg.

