Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 750B7691153
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 20:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjBIT1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 14:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjBIT1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 14:27:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02727683
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 11:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675970808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=akijUhdsZtbO6GrY7g1LPHTtADkehACs6oFy8tM6Z4w=;
        b=P6veRR3oeZXgPJHeBEFiUBjAOaOOQaihaKOOVwzg0d6xihQqFcj4KFwHSsK4yHGnmnLxxO
        /yOZjCRuS0QDGXbI2SYtPnozBms45QcRuDTkO+1nstcFu4y85fmKldqHvmsY5sXpkDpS6U
        AArjcAGxf/8UBk97Wd+8oLRckc+8Uck=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-639-o7tJv8JrM2yqoYlzAMVXKg-1; Thu, 09 Feb 2023 14:26:47 -0500
X-MC-Unique: o7tJv8JrM2yqoYlzAMVXKg-1
Received: by mail-qt1-f197.google.com with SMTP id s4-20020ac85284000000b003b849aa2cd6so1684763qtn.15
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 11:26:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=akijUhdsZtbO6GrY7g1LPHTtADkehACs6oFy8tM6Z4w=;
        b=IH9jvObdqm6Q8mn6kkekopZovEHoJN+TE5pJAUk2p7RxqsTo4N900VUWYMb67jq4QP
         um9k3cUq5jf0XF420l5P/WolVoviiHfMKPrC6+MXPQm7sFtX7p6s6AtWvsA4tGeZ+A7x
         lDZWMSZHWXbNap4dPUMIiomXulclBrfljtnvVPRw6aTe6fCKhsG4XZwXPU0NXBr9zL4i
         m3+8D4/dpo6iNtr23++2ji/j27fEd3iRCDNXF6t4BlRTbh7sbTToYKdwZqzk8xsg71nV
         m1QTl8x5+FSWmwwOyMOdyzKczw/g+luKwjLhuirqn7cb1/F2cF9n2Cq0f7Aio7PLG1ZH
         zk5g==
X-Gm-Message-State: AO0yUKVny6zXZcHybDW6zYh0FCBFGuTcQczv0iPjTeCTWkBPJDFdORpS
        dnlK8fCE++OtQFto0T17itJ0OMllvNU33axHf8+Rpjee2Kc1Ws5vvaKbChcUPXcvTxriba+zBte
        RXUsUFRfNxiP5LS8QO1CjMtpX0QtVlA==
X-Received: by 2002:ac8:7fcd:0:b0:3ba:19e5:3e45 with SMTP id b13-20020ac87fcd000000b003ba19e53e45mr21079033qtk.13.1675970806128;
        Thu, 09 Feb 2023 11:26:46 -0800 (PST)
X-Google-Smtp-Source: AK7set9vrrF2w5Al3fvqHIUnNh/FqiDLAli3cZUHRYIwK1b1hSjOhIxwMzM7+hcFYu3tH0gOx6SFiA==
X-Received: by 2002:ac8:7fcd:0:b0:3ba:19e5:3e45 with SMTP id b13-20020ac87fcd000000b003ba19e53e45mr21078996qtk.13.1675970805679;
        Thu, 09 Feb 2023 11:26:45 -0800 (PST)
Received: from lobep17 ([2600:6c64:4e7f:603b:6e24:8ff:feb9:533e])
        by smtp.gmail.com with ESMTPSA id m28-20020aed27dc000000b003b635a5d56csm1869655qtg.30.2023.02.09.11.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 11:26:45 -0800 (PST)
Message-ID: <6fc6c8c2a94aa46b99f276bf32650ec43d79328d.camel@redhat.com>
Subject: Re: [PATCH] scsi: target: iscsi: set memalloc_noio with loopback
 network connections
From:   Laurence Oberman <loberman@redhat.com>
To:     David Jeffery <djeffery@redhat.com>, target-devel@vger.kernel.org
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Mike Christie <michael.christie@oracle.com>,
        Maurizio Lombardi <mlombard@redhat.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 09 Feb 2023 14:26:44 -0500
In-Reply-To: <caff1add88d1e46c962ee52aae441769450c4dd9.camel@redhat.com>
References: <20230208200957.14073-1-djeffery@redhat.com>
         <caff1add88d1e46c962ee52aae441769450c4dd9.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-02-08 at 15:58 -0500, Laurence Oberman wrote:
> On Wed, 2023-02-08 at 15:09 -0500, David Jeffery wrote:
> > If an admin connects an iscsi initiator to an iscsi target on the
> > same
> > system, the iscsi connection is vulnerable to deadlocks during
> > memory
> > allocations. Memory allocations in the target task accepting the
> > I/O
> > from
> > the initiator can wait on the initiator's I/O when the system is
> > under
> > memory pressure, causing a deadlock situation between the iscsi
> > target and
> > initiator.
> > 
> > When in this configuration, the deadlock scenario can be avoided by
> > use of
> > GFP_NOIO allocations. Rather than force all configurations to use
> > NOIO,
> > memalloc_noio_save/restore can be used to force GFP_NOIO
> > allocations
> > only
> > when in this loopback configuration.
> > 
> > Signed-off-by: David Jeffery <djeffery@redhat.com>
> > ---
> >  drivers/target/iscsi/iscsi_target.c | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> > 
> > diff --git a/drivers/target/iscsi/iscsi_target.c
> > b/drivers/target/iscsi/iscsi_target.c
> > index baf4da7bb3b4..a68e47e2cdf9 100644
> > --- a/drivers/target/iscsi/iscsi_target.c
> > +++ b/drivers/target/iscsi/iscsi_target.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/vmalloc.h>
> >  #include <linux/idr.h>
> >  #include <linux/delay.h>
> > +#include <linux/sched/mm.h>
> >  #include <linux/sched/signal.h>
> >  #include <asm/unaligned.h>
> >  #include <linux/inet.h>
> > @@ -4168,7 +4169,10 @@ int iscsi_target_rx_thread(void *arg)
> >  {
> >  	int rc;
> >  	struct iscsit_conn *conn = arg;
> > +	struct dst_entry *dst;
> >  	bool conn_freed = false;
> > +	bool loopback = false;
> > +	unsigned int flags;
> >  
> >  	/*
> >  	 * Allow ourselves to be interrupted by SIGINT so that a
> > @@ -4186,8 +4190,25 @@ int iscsi_target_rx_thread(void *arg)
> >  	if (!conn->conn_transport->iscsit_get_rx_pdu)
> >  		return 0;
> >  
> > +	/*
> > +	 * If the iscsi connection is over a loopback device from using
> > +	 * iscsi and iscsit on the same system, we need to set
> > memalloc_noio to
> > +	 * prevent memory allocation deadlocks between target and
> > initiator.
> > +	 */
> > +	rcu_read_lock();
> > +	dst = rcu_dereference(conn->sock->sk->sk_dst_cache);
> > +	if (dst && dst->dev && dst->dev->flags & IFF_LOOPBACK)
> > +		loopback = true;
> > +	rcu_read_unlock();
> > +
> > +	if (loopback)
> > +		flags = memalloc_noio_save();
> > +
> >  	conn->conn_transport->iscsit_get_rx_pdu(conn);
> >  
> > +	if (loopback)
> > +		memalloc_noio_restore(flags);
> > +
> >  	if (!signal_pending(current))
> >  		atomic_set(&conn->transport_failed, 1);
> >  	iscsit_take_action_for_connection_exit(conn, &conn_freed);
> 
> I had mentioned to Mike that this was already tested at a large
> customer and in our labs and resolved the deadlocks .
> 
> Regards
> Laurence Oberman
> 

Tested-by:   Laurence Oberman <loberman@redhat.com>
Reviewed-by: Laurence Oberman <loberman@redhat.com>

I hate  to nag here but we have a pressing customer issue and are keen
to get others to weigh in here.

Regards
Laurence



Thanks
Laurence

