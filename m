Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1DA6481A4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 12:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiLIL2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 06:28:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiLIL1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 06:27:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A396FF06
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 03:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670585218;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fk6lJ/K747gX2RARMStBT56RkzQK/6QuPSWKbrkfp3w=;
        b=PRupIn8ESJ7eQpBzViigp0ZU2fY7GoqiPfbMBzTTgV8s1bbF0YInkuwT2vZ1prVzNb09zB
        fEnIRd5Ey4Rz5LoA4jeYLRABzJoXmrfJKJcRkngx4zQtxdGKQwjvrOyvZvkt7hK/hxI9wJ
        QJMW4raPyE71RpVfIv3PVNau8BUEVpo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-596-bZbAd-KNPDi39SLGApyWzA-1; Fri, 09 Dec 2022 06:26:55 -0500
X-MC-Unique: bZbAd-KNPDi39SLGApyWzA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 26A61185A794;
        Fri,  9 Dec 2022 11:26:55 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A5FA640C6EC2;
        Fri,  9 Dec 2022 11:26:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <42b33792-50e9-77d7-4d3e-ac5ce1adeda6@huaweicloud.com>
References: <42b33792-50e9-77d7-4d3e-ac5ce1adeda6@huaweicloud.com> <20221128031929.3918348-1-houtao@huaweicloud.com>
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        Jeff Layton <jlayton@kernel.org>, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        "houtao1@huawei.com" <houtao1@huawei.com>
Subject: Re: [PATCH] fscache: Use wake_up_var() to wake up pending volume acquisition
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2308528.1670585211.1@warthog.procyon.org.uk>
Date:   Fri, 09 Dec 2022 11:26:51 +0000
Message-ID: <2308529.1670585211@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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

> >  			clear_bit(FSCACHE_VOLUME_ACQUIRE_PENDING, &cursor->flags);

Maybe this should be clear_bit_unlock() instead.

And I wonder if:

	set_bit(FSCACHE_VOLUME_ACQUIRE_PENDING, &candidate->flags);

in fscache_hash_volume() needs a barrier before it.

> > -			wake_up_bit(&cursor->flags, FSCACHE_VOLUME_ACQUIRE_PENDING);
> > +			/*
> > +			 * Paired with barrier in wait_var_event(). Check
> > +			 * waitqueue_active() and wake_up_var() for details.
> > +			 */
> > +			smp_mb__after_atomic();
> > +			wake_up_var(&cursor->flags);

That doesn't seem right.

wake_up_bit() is more selective, so should be preferred to wake_up_var().

David

