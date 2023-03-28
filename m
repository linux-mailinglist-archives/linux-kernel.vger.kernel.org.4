Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48FBF6CB6C0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 08:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbjC1GQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 02:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbjC1GQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 02:16:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A747426A3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 23:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679984159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DlgxyFebJPma7f+wQJ3FxzJD5zU35u7FqncJ3IeO7b8=;
        b=CBVUuo/Umm08zVQeWARGkZAZzfldf7j0/b+hAikjcM0zd7yz4OfSS8Cn2sWbJuANNEqH+a
        vifCgg20I9CryV2jAP22Ev8Y/QgbMK0e7/P1SdIND1RQFPLMW3ldAOwBI162Q9eVBe4wYo
        DyBYItf73ytvUKFDQYWrXw9ToBM8ztc=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-DGyNswHsNh6WW_KqbzFW3A-1; Tue, 28 Mar 2023 02:15:58 -0400
X-MC-Unique: DGyNswHsNh6WW_KqbzFW3A-1
Received: by mail-pl1-f197.google.com with SMTP id k1-20020a170902c40100b001a20f75cd40so7197245plk.22
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 23:15:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679984157;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DlgxyFebJPma7f+wQJ3FxzJD5zU35u7FqncJ3IeO7b8=;
        b=Xnu8uJxavLFqFYoprZpJLxQycC2nqAojllbKn+D5xnjHykrBibfXGqLrJw82Hx35Ha
         dsWkbM6ZaPKRmY1GleuBJZZ3xVyNZK+xHJpeIZiawuL09QlWUtMS8jOxx7PBlTYqbIca
         Y2X4vq6sMFwIR4tekDLMsSPVOZXpeiEnxvKXp4klhU+c/OFk2WZTIHv5kkGGlFZgDS7H
         Na0SBVoSfFrHJOqLpGhrOih1UMhmNQ+EC4NY17H4ddIYkKUh+coVplotE3qhcFFyB9eW
         QCtg/WMvFgSPNyJp4OxzUaxlXd3vAv8+XV4uAAhIqg4PYd8R2PyNLH3UL5Y6Jb1W9+1G
         6J5Q==
X-Gm-Message-State: AO0yUKXicb8GwovYVgh9GN5uc6KQNIIK6sOp9pebLcOFYIVTeUZepT9V
        9IrQK9Ntzt3IF00SnhDK4g63dhy25ZSRnCXZHku70mNediDG7d4l0lj+eRik5bWYUo/CMNWQQaL
        ZVak2L4CoygyMCtWFx6yhJsOe
X-Received: by 2002:a05:6a20:6695:b0:cc:fa4b:3a6a with SMTP id o21-20020a056a20669500b000ccfa4b3a6amr14533511pzh.58.1679984152659;
        Mon, 27 Mar 2023 23:15:52 -0700 (PDT)
X-Google-Smtp-Source: AK7set/EXtnMriPNnUSBqMdB8R3MTX/HZbPmuUZaMQI3cIfChtQpMVsjoT28zHMG/6gN2eQzMIjreQ==
X-Received: by 2002:a05:6a20:6695:b0:cc:fa4b:3a6a with SMTP id o21-20020a056a20669500b000ccfa4b3a6amr14533498pzh.58.1679984152355;
        Mon, 27 Mar 2023 23:15:52 -0700 (PDT)
Received: from [10.72.13.204] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s6-20020a63f046000000b0050bc4ca9024sm18626628pgj.65.2023.03.27.23.15.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 23:15:51 -0700 (PDT)
Message-ID: <92955312-b3f6-5f8e-0e2e-2a18e2af6666@redhat.com>
Date:   Tue, 28 Mar 2023 14:15:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH v4 06/11] vduse: Support get_vq_affinity callback
Content-Language: en-US
To:     Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
        tglx@linutronix.de, hch@lst.de
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20230323053043.35-1-xieyongji@bytedance.com>
 <20230323053043.35-7-xieyongji@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230323053043.35-7-xieyongji@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/3/23 13:30, Xie Yongji 写道:
> This implements get_vq_affinity callback so that
> the virtio-blk driver can build the blk-mq queues
> based on the irq callback affinity.
>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>


Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


> ---
>   drivers/vdpa/vdpa_user/vduse_dev.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index 45aa8703c4b5..cefabd0dab9c 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -722,6 +722,14 @@ static int vduse_vdpa_set_vq_affinity(struct vdpa_device *vdpa, u16 idx,
>   	return 0;
>   }
>   
> +static const struct cpumask *
> +vduse_vdpa_get_vq_affinity(struct vdpa_device *vdpa, u16 idx)
> +{
> +	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
> +
> +	return &dev->vqs[idx]->irq_affinity;
> +}
> +
>   static int vduse_vdpa_set_map(struct vdpa_device *vdpa,
>   				unsigned int asid,
>   				struct vhost_iotlb *iotlb)
> @@ -773,6 +781,7 @@ static const struct vdpa_config_ops vduse_vdpa_config_ops = {
>   	.set_config		= vduse_vdpa_set_config,
>   	.get_generation		= vduse_vdpa_get_generation,
>   	.set_vq_affinity	= vduse_vdpa_set_vq_affinity,
> +	.get_vq_affinity	= vduse_vdpa_get_vq_affinity,
>   	.reset			= vduse_vdpa_reset,
>   	.set_map		= vduse_vdpa_set_map,
>   	.free			= vduse_vdpa_free,

