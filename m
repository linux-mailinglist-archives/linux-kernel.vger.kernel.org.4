Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD6F46D6B72
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 20:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236132AbjDDSU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 14:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbjDDSUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 14:20:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827CC421F
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 11:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680632407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7XT+54kNmbwxTpTAz5W9o9/M+Rh1QMK7ruIlt9Kz6lw=;
        b=XJ0uk8O1SX3Vfyoryt/7cicT/4L63UEeI7LWZB6P1i4qOs3vx+xbcjBPGbICKTy13BHS/c
        70bxnyBNLvXXKz3dsJyub8JioLg1SjeFCuUXZgIxcTCF36f1G3rKJrjgM6U0gZRZKnO3Ao
        wUXDUYpkjXeHbnGw1LoYyz2ThvR9GmA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-XIdnWeb0Nnm2Ny6kPXlqkQ-1; Tue, 04 Apr 2023 14:20:06 -0400
X-MC-Unique: XIdnWeb0Nnm2Ny6kPXlqkQ-1
Received: by mail-ed1-f72.google.com with SMTP id s30-20020a508d1e000000b005005cf48a93so46899283eds.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 11:20:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680632405;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7XT+54kNmbwxTpTAz5W9o9/M+Rh1QMK7ruIlt9Kz6lw=;
        b=vOx8M9l3OILJGLmJMU6J2rQconJJDZgX9gfb5vKqhYeDLNZVdEvh4zmIc88GcnCJhM
         L77QiqNeCMntVQtHaC8QezO9G5nWkA7zORoIsHpZCeUcG6VlSfVyQzdoJeeGvElDR6Xf
         26AR0YACMYEjamYwpLsbHt39sDLFYczOU4YDtZt0wP3sBbzQbdCij2627wx/3SHej2cm
         siaMTHQ8BdfA/oux863cN+ztxU2iK/u5CAn8nn3MrG/VBOQb/mVrUqKIgdoQRsdphSxb
         xZ/LOkCNc9APkWk0GZ4cqOSjB/dx2EasYMkSQ5gLbX4Makw+kIfPpaBs9kKxJY5vRmmJ
         Jpxg==
X-Gm-Message-State: AAQBX9fyGJgLidnBBtTrnTiir1UaEb2z4yTm0h990CVr7TizkcWYieFC
        QDwndPXFdIq+22pkbFWdDEDGPjb/sW7NvLXWwyevoNGKMFr6t/mXHlJg8UWvylLCRJ6Ch+Z2EUp
        pk2WExy2DIa7NibGWNDNrvxK0gnGhF2530Hs=
X-Received: by 2002:a17:906:7ccf:b0:8af:3b78:315d with SMTP id h15-20020a1709067ccf00b008af3b78315dmr494844ejp.23.1680632405036;
        Tue, 04 Apr 2023 11:20:05 -0700 (PDT)
X-Google-Smtp-Source: AKy350Z+YtSgiZBggw+M7xHvvW2pBrOXMai9kh5qc/qV7jQ/QF37ZVHXAE3jOk4rynID9LNK2xF72Q==
X-Received: by 2002:a17:906:7ccf:b0:8af:3b78:315d with SMTP id h15-20020a1709067ccf00b008af3b78315dmr494825ejp.23.1680632404803;
        Tue, 04 Apr 2023 11:20:04 -0700 (PDT)
Received: from redhat.com ([2.52.139.22])
        by smtp.gmail.com with ESMTPSA id g20-20020a170906595400b00932ebffdf4esm6233903ejr.214.2023.04.04.11.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 11:20:04 -0700 (PDT)
Date:   Tue, 4 Apr 2023 14:20:00 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     jasowang@redhat.com, tglx@linutronix.de, hch@lst.de,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 01/11] lib/group_cpus: Export group_cpus_evenly()
Message-ID: <20230404141915-mutt-send-email-mst@kernel.org>
References: <20230323053043.35-1-xieyongji@bytedance.com>
 <20230323053043.35-2-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323053043.35-2-xieyongji@bytedance.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 01:30:33PM +0800, Xie Yongji wrote:
> Export group_cpus_evenly() so that some modules
> can make use of it to group CPUs evenly according
> to NUMA and CPU locality.
> 
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> Acked-by: Jason Wang <jasowang@redhat.com>


Hi Thomas, do you ack merging this through my tree?
Thanks!

> ---
>  lib/group_cpus.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/lib/group_cpus.c b/lib/group_cpus.c
> index 9c837a35fef7..aa3f6815bb12 100644
> --- a/lib/group_cpus.c
> +++ b/lib/group_cpus.c
> @@ -426,3 +426,4 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
>  	return masks;
>  }
>  #endif /* CONFIG_SMP */
> +EXPORT_SYMBOL_GPL(group_cpus_evenly);
> -- 
> 2.20.1

