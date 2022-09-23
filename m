Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F375E7C6E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 15:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbiIWN63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 09:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbiIWN6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 09:58:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20AE0148A15
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 06:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663941503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N2JNnlimZO+gNUdKvbZFxiMu/jcdDt8F+ogIcvNJ+8o=;
        b=PT/PlKw/oLuEJQYe3QiMXeLREvRslqjQWwEDHd63f3vIQ7LVS6XUo+MNiRg/EqczVbE2tt
        kuVAxQvbWTzI6jChZMBG2b7f3rS2YMM2ywl9p5h8z2wDIGw0V/lQWggDHsL8v+Kj01228x
        2uAU9QslPO2oWduWTvn/ZUuBtZsE3Dk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-90-KfOK3L36ME-PJ7cYHhnGDQ-1; Fri, 23 Sep 2022 09:58:18 -0400
X-MC-Unique: KfOK3L36ME-PJ7cYHhnGDQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9D73C800186;
        Fri, 23 Sep 2022 13:58:17 +0000 (UTC)
Received: from T590 (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 532B12166B4B;
        Fri, 23 Sep 2022 13:58:12 +0000 (UTC)
Date:   Fri, 23 Sep 2022 21:58:07 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com
Subject: Re: [RESEND PATCH V5 7/7] Documentation: document ublk user recovery
 feature
Message-ID: <Yy27b9CmdmNroIA5@T590>
References: <20220923061505.52007-1-ZiyangZhang@linux.alibaba.com>
 <20220923061505.52007-8-ZiyangZhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923061505.52007-8-ZiyangZhang@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 02:15:05PM +0800, ZiyangZhang wrote:
> Add documentation for user recovery feature of ublk subsystem.
> 
> Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
> ---
>  Documentation/block/ublk.rst | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/Documentation/block/ublk.rst b/Documentation/block/ublk.rst
> index 2122d1a4a541..c3dde087e601 100644
> --- a/Documentation/block/ublk.rst
> +++ b/Documentation/block/ublk.rst
> @@ -144,6 +144,38 @@ managing and controlling ublk devices with help of several control commands:
>    For retrieving device info via ``ublksrv_ctrl_dev_info``. It is the server's
>    responsibility to save IO target specific info in userspace.
>  
> +- ``UBLK_CMD_START_USER_RECOVERY``
> +
> +  This command is valid if ``UBLK_F_USER_RECOVERY`` feature is enabled. This
> +  command is accepted after the old process has exited, ublk device is quiesced
> +  and ``/dev/ublkc*`` is closed. User should send this command before he starts
> +  a new process which opens ``/dev/ublkc*``. When this command returns, the
> +  ublk device is ready for the new process.
> +
> +- ``UBLK_CMD_END_USER_RECOVERY``
> +
> +  This command is valid if ``UBLK_F_USER_RECOVERY`` feature is enabled. This
> +  command is accepted after a new process has opened ``/dev/ublkc*`` and get
> +  all ublk queues be ready. When this command returns, ublk device is
> +  unquiesced and new I/O requests are passed to the new process.
> +
> +- user recovery feature description
> +
> +  Two new features are added for user recovery: ``UBLK_F_USER_RECOVERY`` and
> +  ``UBLK_F_USER_RECOVERY_REISSUE``.
> +
> +  With ``UBLK_F_USER_RECOVERY`` set, after one ubq_daemon(ublksrv io handler) is
> +  dying, ublk does not release ``/dev/ublkc*`` or ``/dev/ublkb*`` but requeues all

The above looks not accurate, the old ubq daemon has to release
/dev/ublkc*, and the new ubq daemon needs to re-open it, and
here I think it is fine to just mention /dev/ublkb* won't be
deleted during the whole recovery, or the device ID is kept,
and it is ublk server's responsibility to recover the device
context by its own knowledge.



thanks,
Ming

