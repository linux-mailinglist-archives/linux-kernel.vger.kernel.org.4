Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3458A6AE3EA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 16:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjCGPGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 10:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjCGPF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 10:05:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0978C0C7
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 06:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678201067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QA+pS+AyGzJ5M1nUw6LDHbv4MX95RgL+BAd2MaOcIq4=;
        b=do/LJlVczgkU41pBB1wS45IIAnvmDJlJtWK3WIWBLavMyVUR01i0dqSULiEAXaxAwQGXzB
        h/R1YnsgasCzefRTzWn4BcYaC6qN1/VgWhldELPLimrNuovcPShXGdjG6enNYexqN9a037
        h9GShXcDG54vdpcoWQd59kXu+fb3Eg0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-80-912SrehkO1uLCFzwRFEkxA-1; Tue, 07 Mar 2023 09:57:41 -0500
X-MC-Unique: 912SrehkO1uLCFzwRFEkxA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D0CA53C21C21;
        Tue,  7 Mar 2023 14:57:40 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.80])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 91592112132D;
        Tue,  7 Mar 2023 14:57:38 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     paul@paul-moore.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: Re: [PATCH v6 04/11] LSM: syscalls for current process attributes
References: <20230222200838.8149-1-casey@schaufler-ca.com>
        <20230222200838.8149-5-casey@schaufler-ca.com>
Date:   Tue, 07 Mar 2023 15:57:36 +0100
In-Reply-To: <20230222200838.8149-5-casey@schaufler-ca.com> (Casey Schaufler's
        message of "Wed, 22 Feb 2023 12:08:31 -0800")
Message-ID: <87edq0obhb.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Casey Schaufler:

> Create a system call lsm_get_self_attr() to provide the security
> module maintained attributes of the current process.

Is it really the current process, or the current thread?

> diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
> index 523748cae615..7850fed28998 100644
> --- a/include/uapi/linux/lsm.h
> +++ b/include/uapi/linux/lsm.h
> @@ -9,6 +9,39 @@
>  #ifndef _UAPI_LINUX_LSM_H
>  #define _UAPI_LINUX_LSM_H
>  
> +#include <linux/types.h>
> +#include <linux/unistd.h>
> +
> +/**
> + * struct lsm_ctx - LSM context information
> + * @id: the LSM id number, see LSM_ID_XXX
> + * @flags: LSM specific flags
> + * @len: length of the lsm_ctx struct, @ctx and any other data or padding
> + * @ctx_len: the size of @ctx
> + * @ctx: the LSM context value
> + *
> + * The @len field MUST be equal to the size of the lsm_ctx struct
> + * plus any additional padding and/or data placed after @ctx.
> + *
> + * In all cases @ctx_len MUST be equal to the length of @ctx.
> + * If @ctx is a string value it should be nul terminated with
> + * @ctx_len equal to `strlen(@ctx) + 1`.  Binary values are
> + * supported.
> + *
> + * The @flags and @ctx fields SHOULD only be interpreted by the
> + * LSM specified by @id; they MUST be set to zero/0 when not used.
> + */
> +struct lsm_ctx {
> +	__u64	id;
> +	__u64	flags;
> +	__u64	len;
> +	__u64	ctx_len;
> +	__u8	ctx[];
> +};

The documentation seems to be written from the LSM point of view, not
the application point of view.  As far as I understand it, the LSM
writes to the ctx member, not the application.

Thanks,
Florian

