Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B697C6A79D0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 04:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjCBDM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 22:12:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjCBDMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 22:12:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB7C497DE
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 19:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677726697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6m+KHAHNOsR6xNmwXLEtRMEJIUs6S4oYwxVd38E51ks=;
        b=RBqUQpdFR8wAVG6zhao9HXAGcbJUFcRgUmHs1T2CT3hF8szV/Rso1piTtittay+pJaclCI
        Ni4CZ2nxYJWiZjPyCysD/EJCNDP5Lmk8cUsgHX77hso1SqP0jB5OXtyN5miYC6bhMddRh9
        ynkIzCj424SmJdMedb/8DxfFmyYQtY8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-48-SdDSsMyaOaqFLeYc4RhWog-1; Wed, 01 Mar 2023 22:11:33 -0500
X-MC-Unique: SdDSsMyaOaqFLeYc4RhWog-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3016785A5A3;
        Thu,  2 Mar 2023 03:11:33 +0000 (UTC)
Received: from T590 (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C16F11121315;
        Thu,  2 Mar 2023 03:11:28 +0000 (UTC)
Date:   Thu, 2 Mar 2023 11:11:22 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     io-uring@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, nbd@other.debian.org
Subject: Re: ublk-nbd: ublk-nbd is avaialbe
Message-ID: <ZAAT2noc/LqrVDIK@T590>
References: <Y8lSYBU9q5fjs7jS@T590>
 <Y/3RuWZKaYrTj/rT@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/3RuWZKaYrTj/rT@duo.ucw.cz>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 11:04:41AM +0100, Pavel Machek wrote:
> Hi!
> 
> > ublk-nbd[1] is available now.
> > 
> > Basically it is one nbd client, but totally implemented in userspace,
> > and wrt. current nbd-client in [2], the transmission phase is done
> > by linux block nbd driver.
> 
> There is reason nbd-client needs to be in kernel, and the reason is
> deadlocks during low memory situations.

Last time, the nbd memory deadlock is solved by the following approach
[1], which is used for ublk too.

Actually ublk can be thought as replacing nbd socket communication
with (much more lightweight & generic) uring_cmd, and move nbd socket
communication into userspace for ublk-nbd. Not see such way may cause
memory deadlock.

Also, ublk has built-in user recovery mechanism, killing deadlock user
daemon and recovering it can be the last straw, and the disk node won't
be gone away during the recovery.

So please provide some analysis or reproductions, otherwise I may have
to ignore your comments.


[1] https://lore.kernel.org/linux-fsdevel/20191112001900.9206-1-mchristi@redhat.com/

Thanks, 
Ming

