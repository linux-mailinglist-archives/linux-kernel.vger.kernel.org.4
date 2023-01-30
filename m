Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157B1682018
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 00:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjA3XxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 18:53:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbjA3XxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 18:53:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DE02F79A
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 15:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675122741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TS4HpeCNM0XvAPtszjmqpefmkBNe2MR5KD9S6Iwx0h8=;
        b=dBLIQ0YjxQz4nMj4ISOV08W3BvtZXXNMnn0f3NZCH4cGziMRMM2cDYTV7VKqywjPvLJsek
        xsfhKFS1YQdGal7t4ZD1LvyhbfPOiOV6k4nZWj9YB0TjlR4zJ8NzxCWGCxGJAg9m5QKQKY
        IVX4b+Hm8BtYCpcgL6pAfaLQXasS1BY=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-49-ieev-PH9OLeHhYMj80zHqA-1; Mon, 30 Jan 2023 18:52:18 -0500
X-MC-Unique: ieev-PH9OLeHhYMj80zHqA-1
Received: by mail-il1-f199.google.com with SMTP id x9-20020a056e021ca900b0030f177273c3so8236605ill.8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 15:52:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TS4HpeCNM0XvAPtszjmqpefmkBNe2MR5KD9S6Iwx0h8=;
        b=PO1DtC4nsEzqBkT5zjkq+cO+s5JsACg0blQE9BfjeQHOCHdQZR+TM49BymMBHmcYvp
         CAgKuru3pY8aCBqeVAWlRqA3yA1gAGq7dUnzlcFcFdp8S6Mq66yYh719N4F50vD2yIeJ
         LCxPgi44lLs2eZhWEyM2CqJ0PAt5OWuPea/0jGRL1OvRQiNNuzHDqy657khGQfVP0wBV
         HneKlyF2mXoIqRujkxjq5s7tFMOzZtHzjjQ6uv9jfWZ2Gtg4QuNAmMDvbD7uwbaqy1FW
         wTVVhH+jJvovqccqlZXwMHwn0a+vvCLlvUhfRaGczpsvb7S42fi3Xds9SYyY34FKvJVj
         gxCA==
X-Gm-Message-State: AO0yUKUjhnFD40ZixAEf7Na5bgVKTAwsFosZF1X+hp3X7+6XinwI2mU6
        GtUxA/mh19UMX/PlLFIH0RC0yqQFrFyB7AysNQmq02kF/QQdaq1AodQitvGsBycbkWIWqsc1gDl
        wlTu461d8UERzrvQLptMmBwxi
X-Received: by 2002:a05:6e02:12ed:b0:310:9821:cb3c with SMTP id l13-20020a056e0212ed00b003109821cb3cmr7393423iln.25.1675122737759;
        Mon, 30 Jan 2023 15:52:17 -0800 (PST)
X-Google-Smtp-Source: AK7set87D+MlDDa91Vu1Yko+c/K5kSqcubT59knSAb3ceK0juTeSNvQ8d8ohGk/gqepJgx4IpTGphg==
X-Received: by 2002:a05:6e02:12ed:b0:310:9821:cb3c with SMTP id l13-20020a056e0212ed00b003109821cb3cmr7393413iln.25.1675122737514;
        Mon, 30 Jan 2023 15:52:17 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id q14-20020a02b04e000000b0039decb5b452sm5271432jah.65.2023.01.30.15.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 15:52:16 -0800 (PST)
Date:   Mon, 30 Jan 2023 16:52:15 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Bo Liu <liubo03@inspur.com>
Cc:     <kwankhede@nvidia.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vfio/mdev: Use sysfs_emit() to instead of sprintf()
Message-ID: <20230130165215.068a4c26.alex.williamson@redhat.com>
In-Reply-To: <20230129084117.2384-1-liubo03@inspur.com>
References: <20230129084117.2384-1-liubo03@inspur.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Jan 2023 03:41:17 -0500
Bo Liu <liubo03@inspur.com> wrote:

> Follow the advice of the Documentation/filesystems/sysfs.rst and show()
> should only use sysfs_emit() or sysfs_emit_at() when formatting the
> value to be returned to user space.
> 
> Signed-off-by: Bo Liu <liubo03@inspur.com>
> ---
>  drivers/vfio/mdev/mdev_sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/mdev/mdev_sysfs.c b/drivers/vfio/mdev/mdev_sysfs.c
> index abe3359dd477..e4490639d383 100644
> --- a/drivers/vfio/mdev/mdev_sysfs.c
> +++ b/drivers/vfio/mdev/mdev_sysfs.c
> @@ -96,7 +96,7 @@ static MDEV_TYPE_ATTR_RO(device_api);
>  static ssize_t name_show(struct mdev_type *mtype,
>  			 struct mdev_type_attribute *attr, char *buf)
>  {
> -	return sprintf(buf, "%s\n",
> +	return sysfs_emit(buf, "%s\n",
>  		mtype->pretty_name ? mtype->pretty_name : mtype->sysfs_name);
>  }
>  

Applied to vfio next branch for v6.3.  Thanks,

Alex

