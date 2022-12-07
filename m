Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2F464598D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 13:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbiLGMAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 07:00:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbiLGMAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 07:00:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B623D908
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 03:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670414277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o4H0k6lts6PsyobtRsNysPpDnjppMrdDUHjEAnX8bN8=;
        b=c7Jaclt5RFdZehomchC5xH5NZw5aSyOxfh1qUZa83uy5EWNDvLeHh5GlJ8qE1twH+ltscO
        OKFbrmY4a5TkxM8Sr9+pzGdpo/FrZX28GVrIqkc7RUao2RaUtdrgknlaAf+7ykP/8MuMEN
        50GYufppN6i8wB55dryMRManahXgieE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-231-mO0ExIpKMMG7nVuVHc3yYA-1; Wed, 07 Dec 2022 06:57:54 -0500
X-MC-Unique: mO0ExIpKMMG7nVuVHc3yYA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AEC4B3C025BC;
        Wed,  7 Dec 2022 11:57:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA57F9E70;
        Wed,  7 Dec 2022 11:57:50 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20221207030740.7663-1-hdanton@sina.com>
References: <20221207030740.7663-1-hdanton@sina.com> 
To:     Hillf Danton <hdanton@sina.com>
Cc:     dhowells@redhat.com,
        syzbot <syzbot+3538a6a72efa8b059c38@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KASAN: use-after-free Read in rxrpc_lookup_local
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1359656.1670414268.1@warthog.procyon.org.uk>
Date:   Wed, 07 Dec 2022 11:57:48 +0000
Message-ID: <1359657.1670414268@warthog.procyon.org.uk>
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

Hillf Danton <hdanton@sina.com> wrote:

> To fix the uaf, destroy local in workqueue because of hlist_del under mutex.

Hmmm...  That can't be the whole explanation.  As you say, the hlist_del is
done under the mutex in rxrpc_destroy_local() - the same as the
hlist_add/hlist_replace and the search in rxrpc_lookup_local().

There should be no need to bump it off to a worker thread - the destruction is
in process context already - and doing the destruction not in the I/O thread
violates other assumptions, so I'm not convinced this patch is a valid fix.

I wonder if, under some circumstances, the I/O thread is managing to start and
destroy itself *before* rxrpc_lookup_local() adds itself to the
local_endpoints list.  Possibly I should offload the add to the I/O thread and
use a completion to wait for it to set up.

David

