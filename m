Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9916430A6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 19:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbiLESlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 13:41:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233569AbiLESkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 13:40:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091FD20F4D
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 10:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670265292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WSqj19ShjO/7vxtuZI+dUviEQUmeLdI4Lm1aF+a+dOQ=;
        b=hBgx9+UuvPamavD7UaT4ZvmQSbtLOIM5jW0QILlnIyfVC/yyzvO/ZNlyZAwKT5DmMsgNqX
        /4kA+tX/NVVd8AaOjOSwVLrmDuMRvFWMPir6AT8th4BGJiVNGAQO1+LiztVj9mCo2Db6Nu
        VcOmt/8hK+gCk4vEWZB/eSL+pVi2o4Y=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-343-Ema1oqdPPVeJJZtUykzAeQ-1; Mon, 05 Dec 2022 13:34:46 -0500
X-MC-Unique: Ema1oqdPPVeJJZtUykzAeQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1A8FF3C38FE4;
        Mon,  5 Dec 2022 18:34:46 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.84])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 560C39E70;
        Mon,  5 Dec 2022 18:34:43 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        tglx@linutronix.de, linux-crypto@vger.kernel.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v11 1/4] random: add vgetrandom_alloc() syscall
References: <20221205020046.1876356-1-Jason@zx2c4.com>
        <20221205020046.1876356-2-Jason@zx2c4.com>
Date:   Mon, 05 Dec 2022 19:34:39 +0100
In-Reply-To: <20221205020046.1876356-2-Jason@zx2c4.com> (Jason A. Donenfeld's
        message of "Mon, 5 Dec 2022 03:00:43 +0100")
Message-ID: <87cz8xr96o.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

* Jason A. Donenfeld:

> +/********************************************************************
> + *
> + * vDSO support helpers.
> + *
> + * The actual vDSO function is defined over in lib/vdso/getrandom.c,
> + * but this section contains the kernel-mode helpers to support that.
> + *
> + ********************************************************************/
> +
> +#ifdef CONFIG_VDSO_GETRANDOM
> +/**
> + * sys_vgetrandom_alloc - Allocate opaque states for use with vDSO getra=
ndom().
> + *
> + * @num:	   On input, a pointer to a suggested hint of how many states to
> + * 		   allocate, and on return the number of states actually allocated.
> + *
> + * @size_per_each: On input, must be zero. On return, the size of each s=
tate allocated,
> + * 		   so that the caller can split up the returned allocation into
> + * 		   individual states.
> + *
> + * @addr:	   Reserved, must be zero.
> + *
> + * @flags:	   Reserved, must be zero.
> + *
> + * The getrandom() vDSO function in userspace requires an opaque state, =
which
> + * this function allocates by mapping a certain number of special pages =
into
> + * the calling process. It takes a hint as to the number of opaque states
> + * desired, and provides the caller with the number of opaque states act=
ually
> + * allocated, the size of each one in bytes, and the address of the first
> + * state, which may be split up into @num states of @size_per_each bytes=
 each,
> + * by adding @size_per_each to the returned first state @num times.
> + *
> + * Returns the address of the first state in the allocation on success, =
or a
> + * negative error value on failure.
> + *
> + * The returned address of the first state may be passed to munmap(2) wi=
th a
> + * length of `(size_t)num * (size_t)size_per_each`, in order to dealloca=
te the
> + * memory, after which it is invalid to pass it to vDSO getrandom().
> + *
> + * States allocated by this function must not be dereferenced, written, =
read,
> + * or otherwise manipulated. The *only* supported operations are:
> + *   - Splitting up the states in intervals of @size_per_each, no more t=
han
> + *     @num times from the first state.
> + *   - Passing a state to the getrandom() vDSO function's @opaque_state
> + *     parameter, but not passing the same state at the same time to two=
 such
> + *     calls.
> + *   - Passing the first state to munmap(2), as described above.
> + * All other uses are undefined behavior, which is subject to change or =
removal

Suggest: =E2=80=9CPassing the first state *and total length* to munmap(2)=
=E2=80=9D

Rest of the documentation looks good to me.  It addresses my concerns
about future evolution of this interface.

Thanks,
Florian

