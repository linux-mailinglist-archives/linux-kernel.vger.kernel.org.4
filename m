Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378BC6E24B2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 15:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjDNNuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 09:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjDNNuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 09:50:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B741E4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 06:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681480134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n9KTxwucszaTPogQTyzYW05x/84ce5RmeI1lCrNY9JY=;
        b=QtssD3cR/1Rrgizi0YHuavkP4o/nSrf3wtfvO6oiyjFye78srFyt91pICvRMTfdzRV/8+x
        74R8P6WdAIdwfAh5u//wbluQcq5TkZlDgN4r12IgO4TM1bBAOkH0CmFB5XA/soX2XvzasH
        jwoA10ghDKpVS3kTtBAl7dBnSolZ/QU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-536-RwSb7RRiNreUmN_e4zUG7w-1; Fri, 14 Apr 2023 09:48:51 -0400
X-MC-Unique: RwSb7RRiNreUmN_e4zUG7w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ACF8110334A6;
        Fri, 14 Apr 2023 13:48:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8577E2166B26;
        Fri, 14 Apr 2023 13:48:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230329140155.53272-5-zhujia.zj@bytedance.com>
References: <20230329140155.53272-5-zhujia.zj@bytedance.com> <20230329140155.53272-1-zhujia.zj@bytedance.com>
To:     Jia Zhu <zhujia.zj@bytedance.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        jefflexu@linux.alibaba.com, hsiangkao@linux.alibaba.com,
        yinxin.x@bytedance.com
Subject: Re: [PATCH V5 4/5] cachefiles: narrow the scope of triggering EPOLLIN events in ondemand mode
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1250224.1681480128.1@warthog.procyon.org.uk>
Date:   Fri, 14 Apr 2023 14:48:48 +0100
Message-ID: <1250225.1681480128@warthog.procyon.org.uk>
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

Jia Zhu <zhujia.zj@bytedance.com> wrote:

>  	if (cachefiles_in_ondemand_mode(cache)) {
> -		if (!xa_empty(&cache->reqs))
> -			mask |= EPOLLIN;
> +		if (!xa_empty(xa)) {
> +			rcu_read_lock();
> +			xa_for_each_marked(xa, index, req, CACHEFILES_REQ_NEW) {
> +				if (!cachefiles_ondemand_is_reopening_read(req)) {
> +					mask |= EPOLLIN;
> +					break;
> +				}
> +			}
> +			rcu_read_unlock();

You should probably use xas_for_each_marked() instead of xa_for_each_marked()
as the former should perform better.

David

