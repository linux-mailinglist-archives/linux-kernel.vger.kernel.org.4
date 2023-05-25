Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDA571069C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 09:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239539AbjEYHqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 03:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239487AbjEYHp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 03:45:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061B310C4
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 00:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685000674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZidSCpbYm+YuZEoatpe8DCv0kxzBXKit5E4US/iPhJw=;
        b=gLRFAWgqaKVMNfo/BzpE0JdVHqzhUmSpuoPvgBwdrUGIsXB82I5GCEGSREZfxT91m1/UAW
        akxq81b/ikkMQtUm5nU4kqmOJU0+QtCrf+SbiMJpgyIVmzVbvhQP4Rt0mQRAJs5ZjIsSOq
        OszTZhuiGnIsHrGUzMbMVM4YMY0ZqJg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-178iiXXMPkOAx4c-pvLJSw-1; Thu, 25 May 2023 03:44:33 -0400
X-MC-Unique: 178iiXXMPkOAx4c-pvLJSw-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-62381540ab8so7167696d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 00:44:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685000672; x=1687592672;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZidSCpbYm+YuZEoatpe8DCv0kxzBXKit5E4US/iPhJw=;
        b=ONHNDVy2gt6rFKUFFkF05bUWMepi3FJp0qlyH+5BJ/XC3yPbkH1uPZewmTcoLB/xwH
         7J4UCUO/ON7vb8G96sUk3H0OHOeu+oC7XZlFCCGrdQ/T0+VNGN/JSmoWth8+bBNTOr+W
         qCrWN7UFOyBTBjByqOKKnISD06Ck04BDXttCPyW4pEe0q5PJ7BxoQQfsAcrKDFzzSYQH
         HBJQdmysGrnNVpOSk0vOZxmS7HQKZcYCSDsmLls89NUK8ioDAqc6l8nyT5443DPFSNyO
         cbeuJfbaVCIjpxQAFRPVHOSgPdyWdQtVCdP8IsS71IASQvqYo3qLNXxIyDDyaaXandP5
         5FqA==
X-Gm-Message-State: AC+VfDwXX2XnPOMkggb/jO77dA7CkMkhWXHHFNxSAMA/ocUsSpp1uzBy
        ppGvn3j7/JS/8JZY6eS08WX0aXHMpHHQYVF1A2Mi18VTR5Z7RElFZ9oE0ul+6fmfqikr9ueI4bP
        ANQsfya0SAg/LwZjFab2wNTsphcRJVK7E7oA=
X-Received: by 2002:a05:6214:c82:b0:5f1:6a6a:f566 with SMTP id r2-20020a0562140c8200b005f16a6af566mr393317qvr.19.1685000672481;
        Thu, 25 May 2023 00:44:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7/1ui/g02jA0DgMpqIrlVxdCIlV4iF1Q0iEUDTPVHiDhFLNXv+XV7D9obvkc2A78610pRF5w==
X-Received: by 2002:a05:6214:c82:b0:5f1:6a6a:f566 with SMTP id r2-20020a0562140c8200b005f16a6af566mr393310qvr.19.1685000672217;
        Thu, 25 May 2023 00:44:32 -0700 (PDT)
Received: from redhat.com ([191.101.160.247])
        by smtp.gmail.com with ESMTPSA id mx3-20020a0562142e0300b00623854510cfsm230604qvb.31.2023.05.25.00.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 00:44:31 -0700 (PDT)
Date:   Thu, 25 May 2023 03:44:26 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Rong Tao <rtoax@foxmail.com>
Cc:     Rong Tao <rongtao@cestc.cn>, Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO CORE AND NET DRIVERS" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH] tools/virtio: Add .gitignore to ringtest
Message-ID: <20230525034409-mutt-send-email-mst@kernel.org>
References: <tencent_C8F0F579940491D14055C82FABE812478505@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_C8F0F579940491D14055C82FABE812478505@qq.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 08:36:12PM +0800, Rong Tao wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> Ignore executions for ringtest.
> 
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---
>  tools/virtio/ringtest/.gitignore | 7 +++++++
>  1 file changed, 7 insertions(+)
>  create mode 100644 tools/virtio/ringtest/.gitignore
> 
> diff --git a/tools/virtio/ringtest/.gitignore b/tools/virtio/ringtest/.gitignore
> new file mode 100644
> index 000000000000..100b9e30c0f4
> --- /dev/null
> +++ b/tools/virtio/ringtest/.gitignore
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0-only

This one, with SPDX tag seems better.

> +/noring
> +/ptr_ring
> +/ring
> +/virtio_ring_0_9
> +/virtio_ring_inorder
> +/virtio_ring_poll
> -- 
> 2.39.1
> 

