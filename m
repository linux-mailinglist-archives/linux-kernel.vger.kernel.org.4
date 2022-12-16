Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF49B64E75B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 07:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiLPGqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 01:46:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiLPGqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 01:46:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95E855A82
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 22:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671173164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vP+Isvmd/A/67x0TVCvdJNmttD6ovBCFTaObHthIvOY=;
        b=ewQXlKdCreqfHHJzChGiolP1MI37yH18ukOgE6jdnVz/mODzsdbUFuwUkrquwfyeTJPSgl
        ndCr+88xQOVmRXAQ0tSvo+86SnQ4lwtxUBs1PH3vseDqStNwkewuL9XR70DZ6JkJRNsPqP
        bgRTocD4F4PVk78zCy/vZ+XsCGQRU0Y=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-648-J53pk4J4Mxi_vxLgCGXn8A-1; Fri, 16 Dec 2022 01:46:03 -0500
X-MC-Unique: J53pk4J4Mxi_vxLgCGXn8A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E490F1C05AE3;
        Fri, 16 Dec 2022 06:46:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.96])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E84C6492C14;
        Fri, 16 Dec 2022 06:46:01 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20221216001958.1149-1-hdanton@sina.com>
References: <20221216001958.1149-1-hdanton@sina.com> <167112117887.152641.6194213035340041732.stgit@warthog.procyon.org.uk>
To:     Hillf Danton <hdanton@sina.com>
Cc:     dhowells@redhat.com, netdev@vger.kernel.org,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 7/9] rxrpc: Fix I/O thread stop
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <430835.1671173161.1@warthog.procyon.org.uk>
Date:   Fri, 16 Dec 2022 06:46:01 +0000
Message-ID: <430836.1671173161@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hillf Danton <hdanton@sina.com> wrote:

> > @@ -478,13 +479,14 @@ int rxrpc_io_thread(void *data)
> >  		}
> >  
> >  		set_current_state(TASK_INTERRUPTIBLE);
> > +		should_stop = kthread_should_stop();
> >  		if (!skb_queue_empty(&local->rx_queue) ||
> >  		    !list_empty(&local->call_attend_q)) {
> >  			__set_current_state(TASK_RUNNING);
> >  			continue;
> >  		}
> >  
> > -		if (kthread_should_stop())
> > +		if (should_stop)
> >  			break;
> >  		schedule();
> >  	}
> 
> At the second glance still fail to see the difference this change can
> make.

There is a window here:

  		if (!skb_queue_empty(&local->rx_queue) ...)
			continue;
	--->
		if (kthread_should_stop())
 			break;

in which an event can happen that should be attended to.  For instance the
AF_RXRPC socket being closed, aborting all its calls and stopping the kthread
by doing the final unuse on its rxrpc_local struct - in that order.  The
window can be expanded by an interrupt or softirq handler running.

So once we've observed that we've been asked to stop, we need to check if
there's more work to be done and, if so, do that work first.

So by doing:

		should_stop = kthread_should_stop();
  		if (!skb_queue_empty(&local->rx_queue) ...)
			continue;
		if (should_stop)
 			break;

we do all outstanding cleanup work before exiting the loop to stop the thread.

David

