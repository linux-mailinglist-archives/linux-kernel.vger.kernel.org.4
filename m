Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9824F666007
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 17:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjAKQHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 11:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235042AbjAKQHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 11:07:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113C211C28
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 08:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673453180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z1BOT8mAy+WkQiTgOjzQ2w9X/QEdQS1JO0z90YIXXdk=;
        b=cDoiBSsplnzCWus0fZOZ68NGGZvAfguGl6Bg/QQKn7H3ksSegp00xKlhFSJvvVt658dTUt
        FVMomz7dHKzjcjoCoCxmfPBszuj800s+mO+wLQOfqMBqAxUrIPC+HYhS81XvKCAq8piZuK
        nENRZ1vy0hwpmcbHezXihvp7mqjwu/I=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-259-3UZB8fl6PHyrfmyEvQ-2PA-1; Wed, 11 Jan 2023 11:06:14 -0500
X-MC-Unique: 3UZB8fl6PHyrfmyEvQ-2PA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CD98F1C29D43;
        Wed, 11 Jan 2023 16:06:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5A4AEC15BA0;
        Wed, 11 Jan 2023 16:06:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20221226103309.953112-2-houtao@huaweicloud.com>
References: <20221226103309.953112-2-houtao@huaweicloud.com> <20221226103309.953112-1-houtao@huaweicloud.com>
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        Jeff Layton <jlayton@kernel.org>, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Jingbo Xu <jefflexu@linux.alibaba.com>, houtao1@huawei.com
Subject: Re: [PATCH v2 1/2] fscache: Use wait_on_bit() to wait for the freeing of relinquished volume
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2431837.1673453170.1@warthog.procyon.org.uk>
Date:   Wed, 11 Jan 2023 16:06:10 +0000
Message-ID: <2431838.1673453170@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hou Tao <houtao@huaweicloud.com> wrote:

>  			clear_bit(FSCACHE_VOLUME_ACQUIRE_PENDING, &cursor->flags);
> +			/*
> +			 * Paired with barrier in wait_on_bit(). Check
> +			 * wake_up_bit() and waitqueue_active() for details.
> +			 */
> +			smp_mb__after_atomic();
>  			wake_up_bit(&cursor->flags, FSCACHE_VOLUME_ACQUIRE_PENDING);

What two values are you applying a partial ordering to?

David

