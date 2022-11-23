Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84A4636A92
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 21:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235308AbiKWUKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 15:10:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233625AbiKWUKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 15:10:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3629C7C464
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 12:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669234181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EIwgCVQdeabpDgky2yWDiED//TZuFkW5esnwk4q0RfU=;
        b=Yo1uT/6SCWZ+/h0+iOhY6iiA42/S0Pz7MPuBhPRCGq8LHE8AnnB1LCFQ3CeZWVF/D/qUIk
        oaoVrScOdalF3AWkVflS6HIpWjxrKn5CQfJvEmWvXKyG/Bu58dkJI4hQR5do06fEmdpULm
        k18TC9OIOQXmtTEzEUhHhrETroMMDxo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-367-eEgxoCpvO7S99hJI1A2GQQ-1; Wed, 23 Nov 2022 15:09:37 -0500
X-MC-Unique: eEgxoCpvO7S99hJI1A2GQQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 34ECE1012463;
        Wed, 23 Nov 2022 20:09:37 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.241])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9005F17582;
        Wed, 23 Nov 2022 20:09:36 +0000 (UTC)
Date:   Wed, 23 Nov 2022 14:09:31 -0600
From:   Eric Blake <eblake@redhat.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>, josef@toxicpanda.com,
        linux-block@vger.kernel.org, nbd@other.debian.org
Subject: Re: nbd: please don't spawn 16 threads when nbd is not even in use
Message-ID: <20221123200845.cuct5euvikqksojm@redhat.com>
References: <Y3y4+QqOlF00X9ET@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3y4+QqOlF00X9ET@duo.ucw.cz>
User-Agent: NeoMutt/20220429
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 12:56:41PM +0100, Pavel Machek wrote:
> Hi!
> 
> I see this... and it looks like there are 16 workqueues before nbd is
> even used. Surely there are better ways to do that?

Yes, it would be nice to create a pool of workers that only spawns up
threads when actual parallel requests are made.  Are you willing to
help write the patch?


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

