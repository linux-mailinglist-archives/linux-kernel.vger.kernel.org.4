Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B76F665ED4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 16:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbjAKPN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 10:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjAKPNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 10:13:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5FBF1F
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 07:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673449987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HVmiJOgksdOGEHQqWYEPkqHT1UjW44QExBrLaj12oP4=;
        b=IRfTqI077L1LqVvNTDAmeRgApFeWbZ8exsYfFhrqVC5VLdD/zOkAHd72ICbwqq/7A6BzrQ
        I8SMQaR7UiqBzExRt9vafCNYMhuctodo5vw8A6PYtMaENljbONnYRWws4sLF0sOaGmOSvd
        jeK2s5Hrz+90+DSyifR4rB+CMyuQCaE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-298-mov-pDGJMnKN6lHpH1pOrw-1; Wed, 11 Jan 2023 10:13:03 -0500
X-MC-Unique: mov-pDGJMnKN6lHpH1pOrw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CD76A185A78B;
        Wed, 11 Jan 2023 15:13:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DE49E422A4;
        Wed, 11 Jan 2023 15:13:01 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20221229164029.3009754-1-zyytlz.wz@163.com>
References: <20221229164029.3009754-1-zyytlz.wz@163.com>
To:     Zheng Wang <zyytlz.wz@163.com>
Cc:     dhowells@redhat.com, marc.dionne@auristor.com,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        hackerzheng666@gmail.com, alex000young@gmail.com,
        security@kernel.org
Subject: Re: [PATCH] afs: Fix poential UAF in afs_make_call
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2427544.1673449981.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 11 Jan 2023 15:13:01 +0000
Message-ID: <2427545.1673449981@warthog.procyon.org.uk>
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

Zheng Wang <zyytlz.wz@163.com> wrote:

> There is a function call : afs_fs_get_capabilities calls afs_make_call, =
in
> afs_make_call, if error occurs in rxrpc_kernel_send_data, it will call
> afs_put_call twice, which will free the call. And the access of
> call->state will trigger a use-after-free bug.

Are you sure of that?  Did you actually trigger a UAF?

> -		if (cancel_work_sync(&call->async_work))
> -			afs_put_call(call);
> +		cancel_work_sync(&call->async_work);

The problem with this change is that it will leak a ref if the work item w=
as
queued but gets cancelled before being run, given to it here:
  =

  static void afs_wake_up_async_call(struct sock *sk, struct rxrpc_call *r=
xcall,
  				   unsigned long call_user_ID)
  {
  	struct afs_call *call =3D (struct afs_call *)call_user_ID;
  	int r;

  	trace_afs_notify_call(rxcall, call);
  	call->need_attention =3D true;

  	if (__refcount_inc_not_zero(&call->ref, &r)) {  <----
  		trace_afs_call(call->debug_id, afs_call_trace_wake, r + 1,
  			       atomic_read(&call->net->nr_outstanding_calls),
  			       __builtin_return_address(0));

  		if (!queue_work(afs_async_calls, &call->async_work))
  			afs_put_call(call);
  	}
  }

I *think* that cancel_work_sync() returns false if the work item is execut=
ing,
but hasn't been requeued.

David

