Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6066C50C0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 17:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjCVQbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 12:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjCVQaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 12:30:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B59D50FA8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 09:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679502579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4co9urht5Jz8vflH9r+hMUVr864YiUEsCYrVDvmygMc=;
        b=IJTKhSGHmaJQ+L40rNKmbr/7XSg+GDVT4ZrMUV03ZR+1MVbavP428JnwKsbuhhqtIt27rm
        tUMfTtGUcFTNhTKiZF1pcw4BqCuafSYwMPmQ4XkV4FzCsZ1h6U77RpU4OcmcmccNlYJZCq
        RxDqkmG4wteunWwv9rDEp/EDP6shNUs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-o4OUGA3uOHGYTmuzEdNHDw-1; Wed, 22 Mar 2023 12:29:37 -0400
X-MC-Unique: o4OUGA3uOHGYTmuzEdNHDw-1
Received: by mail-ed1-f69.google.com with SMTP id fi8-20020a056402550800b004a26cc7f6cbso27874273edb.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 09:29:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679502576;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4co9urht5Jz8vflH9r+hMUVr864YiUEsCYrVDvmygMc=;
        b=rFeSiIq3RKId6ryJnJq3D5d1Xw8zPZaiSAdq4bKV5LLxoQZymqbDx7m+TY3iqmvG1H
         WOdoWhPDlqXWUM9u3zYFkzVSqTwz7alrc3JRWpKXNjH5nX+vTCq8+ArOSjzcxcasyKIs
         e5vy3DkwEIUehK5CMkKCw1bJLIt3+htoxHh7puVoURG6zlv5MrC/Y1JbDPqeDxebx5RU
         mduUKUoqWxjudRS1CZ7723WO9NFSRGHvDLy5bG8TLTQAL2K4TLQY736YgyurZWekdgRb
         0bSFXuLgkESbC/WGF0AFzp7kvw3f/QkDuLwfD+5ZQ+j1Eg3ME7WDcuFs9oDFgom2G7lY
         teyQ==
X-Gm-Message-State: AO0yUKWYPf35fTAlscgDjiVfPqPjQnNPkRTQHh24by+BCcfmZgZoobUs
        sFHX3Ao0bZmgTnRY1sUaMfEvP5WtUtwY1GNhEVTHw2y9X/sdIEBaVI8Y9ZlNSZXGQU/KXxO8+e7
        07JEacl/0Mda04ykfOQanUlGIE1cHbBC/
X-Received: by 2002:a05:6402:104b:b0:500:2cac:332c with SMTP id e11-20020a056402104b00b005002cac332cmr6624528edu.25.1679502576361;
        Wed, 22 Mar 2023 09:29:36 -0700 (PDT)
X-Google-Smtp-Source: AK7set8u2RK5fI05lgRdtt4jEAs/A+jF7kGyrDaTZ/+2ngyMsnuzSivl/5iu9W4gc21psUfOwvCj1Q==
X-Received: by 2002:a05:6402:104b:b0:500:2cac:332c with SMTP id e11-20020a056402104b00b005002cac332cmr6624507edu.25.1679502576005;
        Wed, 22 Mar 2023 09:29:36 -0700 (PDT)
Received: from redhat.com ([2.52.143.71])
        by smtp.gmail.com with ESMTPSA id t21-20020a50d715000000b004af7191fe35sm7970134edi.22.2023.03.22.09.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 09:29:35 -0700 (PDT)
Date:   Wed, 22 Mar 2023 12:29:32 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     jasowang@redhat.com, mie@igel.co.jp,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, aisheng.dong@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] tools/virtio: fix build break for aarch64
Message-ID: <20230322121905-mutt-send-email-mst@kernel.org>
References: <20230322075945.3039857-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322075945.3039857-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 03:59:45PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> "-mfunction-return=thunk -mindirect-branch-register" are only valid
> for x86. So introduce compiler operation check to avoid such issues
> 
> Fixes: 0d0ed4006127 ("tools/virtio: enable to build with retpoline")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  tools/virtio/Makefile | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/virtio/Makefile b/tools/virtio/Makefile
> index 7b7139d97d74..1a9e1be52e4f 100644
> --- a/tools/virtio/Makefile
> +++ b/tools/virtio/Makefile
> @@ -4,7 +4,26 @@ test: virtio_test vringh_test
>  virtio_test: virtio_ring.o virtio_test.o
>  vringh_test: vringh_test.o vringh.o virtio_ring.o
>  
> -CFLAGS += -g -O2 -Werror -Wno-maybe-uninitialized -Wall -I. -I../include/ -I ../../usr/include/ -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -include ../../include/linux/kconfig.h -mfunction-return=thunk -fcf-protection=none -mindirect-branch-register
> +TMPOUT = .tmp_$$$$

if you are going to do this pls use mktemp.
But I don't see why not just use -o /dev/null

> +try-run = $(shell set -e;		\
> +	TMP=$(TMPOUT)/tmp;		\
> +	trap "rm -rf $(TMPOUT)" EXIT;	\
> +	mkdir -p $(TMPOUT);		\
> +	if ($(1)) >/dev/null 2>&1;	\
> +	then echo "$(2)";		\
> +	else echo "$(3)";		\
> +	fi)
> +
> +__cc-option = $(call try-run,\
> +	$(1) -Werror $(2) -c -x c /dev/null -o "$$TMP",$(2),)
> +cc-option = $(call __cc-option, $(CC),$(1))
> +
> +CFLAGS += -g -O2 -Werror -Wno-maybe-uninitialized -Wall -I. -I../include/ -I ../../usr/include/ -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -include ../../include/linux/kconfig.h
> +
> +CFLAGS += $(call cc-option,-mfunction-return=thunk)
> +CFLAGS += $(call cc-option,-fcf-protection=none)
> +CFLAGS += $(call cc-option,-mindirect-branch-register)
> +

As far as I can tell this will do the dance with the empty input
each time CFLAGS is evaluated.

Which seems unnecessarily baroque - just use ":=" and it will
be evaluated once.


>  CFLAGS += -pthread
>  LDFLAGS += -pthread
>  vpath %.c ../../drivers/virtio ../../drivers/vhost
> -- 
> 2.37.1

