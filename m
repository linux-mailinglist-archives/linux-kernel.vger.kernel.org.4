Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7A8624B92
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 21:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbiKJUSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 15:18:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbiKJURx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 15:17:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A5945A07
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 12:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668111410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=93yVlCVIghUC8PyP5uVh+QvYFV+8lvAK0QrTwmcgxD8=;
        b=gSU9jwqpMpkemLjm20fFm92fHIXP/YqK/LMcBrNFlSDwCgXcQNQXzObH95DDMDfWb9StJA
        iQWQRPTYTnQbtLNay71b+AkQ4VZofk4O8NKS8M7yUd60GZBJWCrZqW+kxdyNwg3PpAaUX+
        zazUvfVQ0MK59vJUVBNn2L6x3b6dYXw=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-612-hstrT8IJONyqSZLHydGqzQ-1; Thu, 10 Nov 2022 15:16:49 -0500
X-MC-Unique: hstrT8IJONyqSZLHydGqzQ-1
Received: by mail-io1-f70.google.com with SMTP id bf14-20020a056602368e00b006ce86e80414so1776756iob.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 12:16:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=93yVlCVIghUC8PyP5uVh+QvYFV+8lvAK0QrTwmcgxD8=;
        b=gx2rs0gTCK5WqKKXPCqBYRz9X0d+2/NHSEyWhnEQzOk4D1Bxq/YkQ6Fbe8X101RIaK
         DunEurMg/MCTsWZd9zTJ4dx2RaFv7AxPqLAQEuT2IJW255iUewis9dZihOWgUVgbBlRm
         yy+5w/XeOLgiNlpmYHKs8gzKJ1MLO1zIc5j+fJAX8A7NsDZi2l0bIqXSyOPcQxwlEbJq
         0ll9xb8yu7idA9my33L6cAVChwiYQnaMDOvrs8H24B/G0ET1V3ivLJ0TJ4RQ3mF+paeU
         o+KlQQ1fQEuMnh7/F+WGUDepVHbhR1WBcA4+CvltgKeoEImlYKraTq4yVXhgVMltQQ2l
         xnDA==
X-Gm-Message-State: ACrzQf1vtWmWWAfcPx8O/ehK/5Q8qLLCyhELJGuBP+JbHO1A1kaVJ/pp
        k7x0674/b9Eto8fz0u7TDt1zNLIf/NG0UIBRT98ZmC/4lovpkPaNSZOyKsmhlf+NMmMFYI+QCLI
        ZkwYk1exSuce3VIYn53Ts1WPi
X-Received: by 2002:a05:6e02:686:b0:300:1113:3192 with SMTP id o6-20020a056e02068600b0030011133192mr3715970ils.70.1668111408544;
        Thu, 10 Nov 2022 12:16:48 -0800 (PST)
X-Google-Smtp-Source: AMsMyM6ztJC5t+zhnCg5yze6Ilpp7TK4Q+C4rdLSAX3gmiMajCmP1687ENJXELKVxcoTVNQf/LIjiw==
X-Received: by 2002:a05:6e02:686:b0:300:1113:3192 with SMTP id o6-20020a056e02068600b0030011133192mr3715963ils.70.1668111408352;
        Thu, 10 Nov 2022 12:16:48 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id i7-20020a0566022c8700b006bbea9f45cesm25981iow.38.2022.11.10.12.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 12:16:47 -0800 (PST)
Date:   Thu, 10 Nov 2022 13:16:40 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH] MAINTAINERS: git://github -> https://github.com for
 awilliam
Message-ID: <20221110131640.6e00811f.alex.williamson@redhat.com>
In-Reply-To: <20221013214636.30721-1-palmer@rivosinc.com>
References: <20221013214636.30721-1-palmer@rivosinc.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Oct 2022 14:46:36 -0700
Palmer Dabbelt <palmer@rivosinc.com> wrote:

> Github deprecated the git:// links about a year ago, so let's move to
> the https:// URLs instead.
> 
> Reported-by: Conor Dooley <conor.dooley@microchip.com>
> Link: https://github.blog/2021-09-01-improving-git-protocol-security-github/
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
> I've split these up by github username so folks can take them
> independently, as some of these repos have been renamed at github and
> thus need more than just a sed to fix them.
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3705c487450b..41a925931cc3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21305,7 +21305,7 @@ M:	Alex Williamson <alex.williamson@redhat.com>
>  R:	Cornelia Huck <cohuck@redhat.com>
>  L:	kvm@vger.kernel.org
>  S:	Maintained
> -T:	git git://github.com/awilliam/linux-vfio.git
> +T:	git https://github.com/awilliam/linux-vfio.git
>  F:	Documentation/driver-api/vfio.rst
>  F:	drivers/vfio/
>  F:	include/linux/vfio.h

Applied to vfio next branch for v6.2.  Thanks,

Alex

