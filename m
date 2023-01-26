Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA8667D535
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 20:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbjAZTQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 14:16:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjAZTQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 14:16:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03806577D5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 11:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674760525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z/6NzXul2HEh42eixvs/tgvbhLjr/JPWRiufbihZODs=;
        b=CENBYMcDlfPZ6z2FQZc9+BBZsptb+WBhObW8F23bT5In+GeWjKZ6vaUOL3C1mvw5j8/v1H
        BBkjN9iT0fG9lngTApZV0llj4+0e60Up/+h/ezMaEMs1EhvpxXcYS04nK/vCRNRRbrAdKD
        AE+CQnEyohq3k8/55flr7d6sLco166c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-112-UnlMdd_YM9eYwBW14uadDA-1; Thu, 26 Jan 2023 14:15:22 -0500
X-MC-Unique: UnlMdd_YM9eYwBW14uadDA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5DF8787B2A4;
        Thu, 26 Jan 2023 19:15:21 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (ovpn-194-60.brq.redhat.com [10.40.194.60])
        by smtp.corp.redhat.com (Postfix) with SMTP id ACBFAC15BA0;
        Thu, 26 Jan 2023 19:15:18 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 26 Jan 2023 20:15:18 +0100 (CET)
Date:   Thu, 26 Jan 2023 20:15:15 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Gregory Price <gourry.memverge@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        avagin@gmail.com, peterz@infradead.org, luto@kernel.org,
        krisman@collabora.com, tglx@linutronix.de, corbet@lwn.net,
        shuah@kernel.org, Gregory Price <gregory.price@memverge.com>
Subject: Re: [PATCH v7 1/1] ptrace,syscall_user_dispatch: checkpoint/restore
 support for SUD
Message-ID: <20230126191515.GE4069@redhat.com>
References: <20230126190645.18341-1-gregory.price@memverge.com>
 <20230126190645.18341-2-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126190645.18341-2-gregory.price@memverge.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
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

On 01/26, Gregory Price wrote:
>
> Implement ptrace getter/setter interface for syscall user dispatch.
>
> These prctl settings are presently write-only, making it impossible to
> implement transparent checkpoint/restore via software like CRIU.
>
> 'on_dispatch' field is not exposed because it is a kernel-internal
> only field that cannot be 'true' when returning to userland.
>
> Signed-off-by: Gregory Price <gregory.price@memverge.com>
> ---
>  .../admin-guide/syscall-user-dispatch.rst     |  5 ++-
>  include/linux/syscall_user_dispatch.h         | 18 +++++++++
>  include/uapi/linux/ptrace.h                   |  9 +++++
>  kernel/entry/syscall_user_dispatch.c          | 39 +++++++++++++++++++
>  kernel/ptrace.c                               |  9 +++++
>  5 files changed, 79 insertions(+), 1 deletion(-)

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

