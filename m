Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B4C6B1E3F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 09:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjCIIdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 03:33:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjCIIdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:33:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1990CCA2D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 00:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678350699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G4DxzMWFw5jGE1+NNVtKuCD9/BZ7uSP6hGTNxIYyrI0=;
        b=gGnIoi6hM6iBb9zeqGoHCc3GZNS73QsR1fmmJft9fbizgOqzNJg8elhmbZ3UXxJoTVoQK6
        GDJjK3meeuCsf3MlLtFJM+nPxdBSqZ1YK5XawY/dv3swbrAmLNZN1ntVTjY99gBfTZZQF8
        ch9DL5IrxQT2OFVJ1QZi6akmVZnFOFs=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-l8Nr7XpLNi6qxp2R22POHw-1; Thu, 09 Mar 2023 03:31:38 -0500
X-MC-Unique: l8Nr7XpLNi6qxp2R22POHw-1
Received: by mail-qt1-f199.google.com with SMTP id c5-20020ac85185000000b003bfae3b8051so754159qtn.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 00:31:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678350698;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4DxzMWFw5jGE1+NNVtKuCD9/BZ7uSP6hGTNxIYyrI0=;
        b=5K6mMXgLqUwWCNSmuJRsjOtzizCp2rGz0MiccXVobceY/2qZ2ag7J0/ZsYiTOELhqH
         0vsfCp4hiI6Nz1X9zMHB7n5hMxNIeN1cfIMbFFWYpWG9feWQ9yZ70xulNvxxK6TmzQHq
         0cHtWATKRrf7NBy0PWTzJirTiLFwJ7scIq3yHpL4s/2pbrCSRxjZYzcJtxG/A1XL0CUv
         PvhQ4ttw8H1l8OMJ0PC1AjlcUR6DI8qRFu+vhp7IWAOK7cUEMxMvC1T7GLf52+4AbzTm
         N7Ts7UwHCABW34YV1bYw4nIQhWDspbialNmXKqTUHb4wopTDGvgaqFnwKyIbG1ErcZQE
         zWrA==
X-Gm-Message-State: AO0yUKV8W/T2+r8qLqARlBq9z4mFGcpPU5WX7+fWh8mr5asUme1N0zMX
        Ot4n1IE7wLAP3TD3s1cij4EsCVdKfysjZp4l0YOzqX6HsUfjTl/68rPBIj5UnzjaTXgmQHw9hq/
        5gbM7mfTHH0JIWhrZnvP+7scy
X-Received: by 2002:a05:622a:54c:b0:3bf:d9d2:484f with SMTP id m12-20020a05622a054c00b003bfd9d2484fmr35189153qtx.11.1678350698226;
        Thu, 09 Mar 2023 00:31:38 -0800 (PST)
X-Google-Smtp-Source: AK7set+lOQQ30IfqLTp3od+p+eKiTOPO28RD1XBMQ8cVo6/e0bR73jy7mpBYd6WWU+y5fBzb1/Ok4A==
X-Received: by 2002:a05:622a:54c:b0:3bf:d9d2:484f with SMTP id m12-20020a05622a054c00b003bfd9d2484fmr35189140qtx.11.1678350697996;
        Thu, 09 Mar 2023 00:31:37 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-170.retail.telecomitalia.it. [82.57.51.170])
        by smtp.gmail.com with ESMTPSA id y9-20020ac87089000000b003bfaae103f6sm13229024qto.89.2023.03.09.00.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 00:31:37 -0800 (PST)
Date:   Thu, 9 Mar 2023 09:31:33 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Rong Tao <rtoax@foxmail.com>
Cc:     mst@redhat.com, Rong Tao <rongtao@cestc.cn>,
        Jason Wang <jasowang@redhat.com>,
        "open list:VIRTIO CORE AND NET DRIVERS" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tools/virtio: virtio_test -h,--help should return
 directly
Message-ID: <20230309083133.zfebcl67k35b7rkt@sgarzare-redhat>
References: <tencent_4B5122C4158323A1D1ACA04B3295F1579207@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <tencent_4B5122C4158323A1D1ACA04B3295F1579207@qq.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 02:13:13PM +0800, Rong Tao wrote:
>From: Rong Tao <rongtao@cestc.cn>
>
>When we get help information, we should return directly, and we should not
>execute test cases. Move the exit() directly into the help() function and
>remove it from case '?'.
>
>Signed-off-by: Rong Tao <rongtao@cestc.cn>
>---
> tools/virtio/virtio_test.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
>index 120062f94590..6e348fbdc5d8 100644
>--- a/tools/virtio/virtio_test.c
>+++ b/tools/virtio/virtio_test.c
>@@ -337,6 +337,8 @@ static void help(void)
> 		" [--batch=random/N]"
> 		" [--reset=N]"
> 		"\n");
>+
>+	exit(0);

Please exit with a value different from 0 (e.g. 2).

> }
>
> int main(int argc, char **argv)
>@@ -354,14 +356,12 @@ int main(int argc, char **argv)
> 		case -1:
> 			goto done;
> 		case '?':
>-			help();
> 			exit(2);

Sorry, I meant the opposite, remove exit(2) and leave help().

Thanks,
Stefano

> 		case 'e':
> 			features &= ~(1ULL << VIRTIO_RING_F_EVENT_IDX);
> 			break;
> 		case 'h':
> 			help();
>-			goto done;
> 		case 'i':
> 			features &= ~(1ULL << VIRTIO_RING_F_INDIRECT_DESC);
> 			break;
>-- 
>2.39.1
>

