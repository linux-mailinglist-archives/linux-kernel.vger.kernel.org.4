Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869105B9F7D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 18:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiIOQRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 12:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiIOQQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 12:16:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48EC09C208
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 09:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663258616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5QGL2aU0V44evqxOzGLTXba8gjIgDLZbDaCL5a4Fyq4=;
        b=HAqzCsSMdx45hXh098NhyKhLgrVf6zXnAZlVfTTl8afdJxmuYBINAD2zybEpKqc0DaimW+
        sDjbW6w3NzoBW7Mr8NuWyG9BxF+J59/aRMtOMN5WisYJ2rKh2evZSkyREBYCWNlAWBRVUw
        YmWvtUO5PKNlHz0Ezmuq53W4A7V8pwQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-549-o8ySK9JIMrGEY7aho3EImA-1; Thu, 15 Sep 2022 12:16:55 -0400
X-MC-Unique: o8ySK9JIMrGEY7aho3EImA-1
Received: by mail-wr1-f71.google.com with SMTP id q17-20020adfab11000000b0022a44f0c5d9so4622035wrc.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 09:16:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=5QGL2aU0V44evqxOzGLTXba8gjIgDLZbDaCL5a4Fyq4=;
        b=C6mO8lfhesFRTjWJKYhOqFWbzH5y8uPy+ftPKbnbSI3o9nd/cNpmytMcfaKDTC132B
         LtwA5ZYRVYEbbPDJ8bGUuT1GDkZNJVxwBVzCGjdVVmm2G8DNb+Ou+ykAssA9DdaPxAB5
         d/EbZlVrFcP2zLR6cUVtbgsgrzL0XEypMwFB8ALbOgyfMQ9vu2ZxDC8TcwFtDRvzlLxb
         pXNGbhLwwaSyeGMNvwRRUij0H13mH3R16aKQl1I1x1Y0/qJoDkiUYMaatwI9CM/u60zA
         RACa3xqYvB7N2SFupzTlWR1oH0JHRUF8d8SCr0TiV7yx5mqRhIam5avBoiEubttIAvmq
         NaLQ==
X-Gm-Message-State: ACrzQf0GPPYya4FgyAiq/B/+JHPQP+f31pagXMzYgewIMTFkVTQiS2GQ
        pVRY5jmY75C0HWAgK1bLAE2y+/C3OhxVi5AB6DVyfyHpPHgXCWyoKBn7Kt0tq9x/DIoobhhy08j
        Y7NwmpeEJdyFl0SWUFAlMgVaJ
X-Received: by 2002:a05:600c:3b1a:b0:3b4:858b:aef1 with SMTP id m26-20020a05600c3b1a00b003b4858baef1mr398018wms.193.1663258613942;
        Thu, 15 Sep 2022 09:16:53 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6CYMxX0xbHz8gi5YOfJkZsL2gJtb0R6qnAZColXSHX9SLm5vk9dkl8TUPMZ763A++JeCAPKg==
X-Received: by 2002:a05:600c:3b1a:b0:3b4:858b:aef1 with SMTP id m26-20020a05600c3b1a00b003b4858baef1mr398003wms.193.1663258613767;
        Thu, 15 Sep 2022 09:16:53 -0700 (PDT)
Received: from sgarzare-redhat ([79.140.208.123])
        by smtp.gmail.com with ESMTPSA id bh16-20020a05600c3d1000b003a531c7aa66sm3455234wmb.1.2022.09.15.09.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 09:16:53 -0700 (PDT)
Date:   Thu, 15 Sep 2022 18:16:50 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     vdasa@vmware.com
Cc:     gregkh@linuxfoundation.org, Pv-drivers@vmware.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, bryantan@vmware.com
Subject: Re: [PATCH] MAINTAINERS: Add header files under VMWARE VMCI DRIVER
Message-ID: <20220915161650.fchcxhnei5jxdi35@sgarzare-redhat>
References: <20220915031321.1121-1-vdasa@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220915031321.1121-1-vdasa@vmware.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 08:13:21PM -0700, vdasa@vmware.com wrote:
>From: Vishnu Dasa <vdasa@vmware.com>
>
>Add include/linux/vmw_vmci* files under VMWARE VMCI DRIVER.
>
>Acked-by: Bryan Tan <bryantan@vmware.com>
>Signed-off-by: Vishnu Dasa <vdasa@vmware.com>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>---
> MAINTAINERS | 1 +
> 1 file changed, 1 insertion(+)

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

