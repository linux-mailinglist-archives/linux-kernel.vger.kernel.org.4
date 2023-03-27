Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A1A6CB042
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 23:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjC0VCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 17:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjC0VCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 17:02:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343321BD1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 14:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679950877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pePBFHN5s0mkHf+iMKhZSRwNai0pCDXlXPyFKRXDXsc=;
        b=MUVjvo1pdwxdHsylps3sXG7iZ/5f4LMl2PTjL7L7TvxNObywROTE6gWZcMH816tN3XeGxa
        R0hPo40b3vIDnXZCGrerGcRN9XdrJbIdZjRnmkqSrnQdDoGFTRa79a3CCW/heFQ7lH8pzA
        Sp2PAa4Dbxy28GoxiVFypA96W+9Lngo=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-nusCBFGgMTy4KzOXWw91Ew-1; Mon, 27 Mar 2023 17:01:16 -0400
X-MC-Unique: nusCBFGgMTy4KzOXWw91Ew-1
Received: by mail-qt1-f200.google.com with SMTP id v10-20020a05622a130a00b003e4ee70e001so894438qtk.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 14:01:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679950875; x=1682542875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pePBFHN5s0mkHf+iMKhZSRwNai0pCDXlXPyFKRXDXsc=;
        b=5C83OGECUmDlENOYaS2qnXwNV+KnySp4AhrSc7GVTdKYAT7FQ1KDjUn9wzxcXp7hZn
         Nh5Xts4zNEV92fw3gJnI/+Y2kJi41aDqI4UIAUgR4eZzYIgZmETOyxetgWD1sr+ypsPy
         ri454XnHRVyicN423+v6X8wB4g/+E9+PZTZmUvOYSSgCvLyJys6+pTDjkq7gpUULinLd
         rru1wdjg3VZvv0Um6gJLpMUE2zNX6sVtF28IsZQo8cuwf73P5fAiUSOvC8+AjrWc+pHt
         c0dALPXscbk7eWXKshdmM+0F/R98zLl0AJijrj9I0yQYcWVn+5Fl45CFWu+WcTkrrgi4
         JkCg==
X-Gm-Message-State: AAQBX9cHWbZusrpiGxORjqwwm/hJ40NAqL3dh/+s5ACzsS/kk9Ac0BBc
        +age8yUDm3PmqVTRNmV1Q44Tv3/600sim7BZ0F/dJvCq70n3vusjtTfMc0TDXIXvWWxf09wfPOJ
        yWETMlOY3Dg2t/6vGA3Iq0fjx
X-Received: by 2002:a05:6214:528f:b0:5af:3a13:202d with SMTP id kj15-20020a056214528f00b005af3a13202dmr20867696qvb.4.1679950875516;
        Mon, 27 Mar 2023 14:01:15 -0700 (PDT)
X-Google-Smtp-Source: AKy350aVDWYJQwWqIHwZUh5ktHNEupzgPiHGj1mY8GkaRJKKsVQEhsdqRHbLM5b4eazfi17GQ4yXtw==
X-Received: by 2002:a05:6214:528f:b0:5af:3a13:202d with SMTP id kj15-20020a056214528f00b005af3a13202dmr20867635qvb.4.1679950875081;
        Mon, 27 Mar 2023 14:01:15 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id jh19-20020a0562141fd300b005dd8b93457csm3195224qvb.20.2023.03.27.14.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 14:01:14 -0700 (PDT)
Date:   Mon, 27 Mar 2023 17:01:13 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] userfaultfd: don't fail on unrecognized features
Message-ID: <ZCIEGblnsWHKF8RD@x1n>
References: <20220722201513.1624158-1-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220722201513.1624158-1-axelrasmussen@google.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think I overlooked this patch..

Axel, could you explain why this patch is correct?  Comments inline.

On Fri, Jul 22, 2022 at 01:15:13PM -0700, Axel Rasmussen wrote:
> The basic interaction for setting up a userfaultfd is, userspace issues
> a UFFDIO_API ioctl, and passes in a set of zero or more feature flags,
> indicating the features they would prefer to use.
> 
> Of course, different kernels may support different sets of features
> (depending on kernel version, kconfig options, architecture, etc).
> Userspace's expectations may also not match: perhaps it was built
> against newer kernel headers, which defined some features the kernel
> it's running on doesn't support.
> 
> Currently, if userspace passes in a flag we don't recognize, the
> initialization fails and we return -EINVAL. This isn't great, though.

Why?  IIUC that's the major way for user app to detect any misconfig of
feature list so it can bail out early.

Quoting from man page (ioctl_userfaultfd(2)):

UFFDIO_API
       (Since Linux 4.3.)  Enable operation of the userfaultfd and perform API handshake.

       ...

           struct uffdio_api {
               __u64 api;        /* Requested API version (input) */
               __u64 features;   /* Requested features (input/output) */
               __u64 ioctls;     /* Available ioctl() operations (output) */
           };

       ...

       For Linux kernel versions before 4.11, the features field must be
       initialized to zero before the call to UFFDIO_API, and zero (i.e.,
       no feature bits) is placed in the features field by the kernel upon
       return from ioctl(2).

       ...

       To enable userfaultfd features the application should set a bit
       corresponding to each feature it wants to enable in the features
       field.  If the kernel supports all the requested features it will
       enable them.  Otherwise it will zero out the returned uffdio_api
       structure and return EINVAL.

IIUC the right way to use this API is first probe with features==0, then
the kernel will return all the supported features, then the user app should
enable only a subset (or all, but not a superset) of supported ones in the
next UFFDIO_API with a new uffd.

> Userspace doesn't have an obvious way to react to this; sure, one of the
> features I asked for was unavailable, but which one? The only option it
> has is to turn off things "at random" and hope something works.
> 
> Instead, modify UFFDIO_API to just ignore any unrecognized feature
> flags. The interaction is now that the initialization will succeed, and
> as always we return the *subset* of feature flags that can actually be
> used back to userspace.
> 
> Now userspace has an obvious way to react: it checks if any flags it
> asked for are missing. If so, it can conclude this kernel doesn't
> support those, and it can either resign itself to not using them, or
> fail with an error on its own, or whatever else.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>  fs/userfaultfd.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index e943370107d0..4974da1f620c 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -1923,10 +1923,8 @@ static int userfaultfd_api(struct userfaultfd_ctx *ctx,
>  	ret = -EFAULT;
>  	if (copy_from_user(&uffdio_api, buf, sizeof(uffdio_api)))
>  		goto out;
> -	features = uffdio_api.features;
> -	ret = -EINVAL;
> -	if (uffdio_api.api != UFFD_API || (features & ~UFFD_API_FEATURES))
> -		goto err_out;

What's worse is that I think you removed the only UFFD_API check.  Although
I'm not sure whether it'll be extended in the future or not at all (very
possible we keep using 0xaa forever..), but removing this means we won't be
able to extend it to a new api version in the future, and misconfig of
uffdio_api will wrongly succeed I think:

	/* Test wrong UFFD_API */
	uffdio_api.api = 0xab;
	uffdio_api.features = 0;
	if (ioctl(uffd, UFFDIO_API, &uffdio_api) == 0)
		err("UFFDIO_API should fail but didn't");

> +	/* Ignore unsupported features (userspace built against newer kernel) */
> +	features = uffdio_api.features & UFFD_API_FEATURES;
>  	ret = -EPERM;
>  	if ((features & UFFD_FEATURE_EVENT_FORK) && !capable(CAP_SYS_PTRACE))
>  		goto err_out;
> -- 
> 2.37.1.359.gd136c6c3e2-goog
> 

-- 
Peter Xu

