Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF9762DFBE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234810AbiKQPWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240442AbiKQPU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:20:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455DE781A0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 07:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668698085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HU957M32Z/ToXADM+4xyOYaSls7s4w0XBB16ezobWWg=;
        b=XNr1iqcAYH2kcYtl1tVXrKg5XTtwghsGWY48WEfYjB7ehNDtwaBzEZTiGroGNv3Lm/H5iV
        GeKRaFaNJJdFXv3qwLIUWYCZ5jSgtrG6eGdF7asyncBltTLjba05XAX3jPKZwT+N2h76W2
        RK3uXsyU92Ohd00R29ryktivDQdLYS0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-299-pXRzzu_SPMecrS5w8Jiy4Q-1; Thu, 17 Nov 2022 10:14:39 -0500
X-MC-Unique: pXRzzu_SPMecrS5w8Jiy4Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4800538123A9;
        Thu, 17 Nov 2022 15:14:39 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A9F5D2166B29;
        Thu, 17 Nov 2022 15:14:37 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20221115140447.2971680-1-zhangpeng362@huawei.com>
References: <20221115140447.2971680-1-zhangpeng362@huawei.com>
To:     Peng Zhang <zhangpeng362@huawei.com>
Cc:     dhowells@redhat.com, ericvh@gmail.com, lucho@ionkov.net,
        asmadeus@codewreck.org, linux_oss@crudebyte.com,
        jlayton@kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        syzbot+a76f6a6e524cf2080aa3@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] fscache: fix OOB Read in __fscache_acquire_volume
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3725573.1668698074.1@warthog.procyon.org.uk>
Date:   Thu, 17 Nov 2022 15:14:34 +0000
Message-ID: <3725574.1668698074@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think that the size needs to be able to hold up to 255 to handle NFS keys,
so I think the right solution has to be to fix the maths.  Probably the
easiest way is to change fscache_volume::key to be "u8 *" since it
isn't a simple text string.

David

