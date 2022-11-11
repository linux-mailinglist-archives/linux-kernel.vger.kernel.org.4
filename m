Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39BC625FA0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 17:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbiKKQg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 11:36:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234159AbiKKQg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 11:36:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE1985460
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 08:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668184566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6mlEl6qGZPqlKJRRjXwEN5bOOe171F4/1jD4DeUrkco=;
        b=frG0aCAYx2OnbkN2jgu+taVl9VcATig8pe2L3uBa+kemTlGQYQ7AanKKjI+1KkNZdd6dhr
        BOpz6XyT7D6EUyi0et3/7WsK6LGpkzUgguYSVoxwPdjKFky03RLsO7bZdVcBQipMYF65XD
        MKeGJJUKVI8q5pSsNkgf0Pl221ICY6g=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-587-QDFu3gK5PPOi2ugjipi-Jw-1; Fri, 11 Nov 2022 11:36:05 -0500
X-MC-Unique: QDFu3gK5PPOi2ugjipi-Jw-1
Received: by mail-qk1-f199.google.com with SMTP id de43-20020a05620a372b00b006fae7e5117fso5096179qkb.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 08:36:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6mlEl6qGZPqlKJRRjXwEN5bOOe171F4/1jD4DeUrkco=;
        b=6QNwY0wL7VceJf9lfUzzlFarCPG8bHyVamAP4JOGxH0UiZpHWZ8VKqSCJh0q19MNd3
         QheUGTtzubiQydQStlxZS53+BczkO6xGAhGwNwLjTe/XNUQOg8Jqs5dXlRzJ1ze7nbT6
         0DOR61JKlxNB9F7VY8kE705GMBodSeU/0WK6Ivju2IufmAeVQQHW35kvfw5A4Luau3iJ
         ppB5XqQ1PUA2AhfAsOG5ohq7fBBguGW10SX0XuQojjC23VaZvwYQmr3Wu/048stv8YLZ
         SMR8ipJisKvmVoOuTQQv9x3UwnV2NxTb4i66zQ9ybfqJL7iS/oYepb9f9y8ZAeHr/WXb
         hYEA==
X-Gm-Message-State: ANoB5pmUBrALmw+jmiuKPa6uTuaDo4URRcrPTwy0nxcgRQqt5OIDCCTu
        PQLWrcIW4iMU+kaYy1VYu9fR1OzHHK+hPuFyCiQLP166wYh/ONazJKKDlvANoBTBEU0i1CKsdDj
        fSx9NETueHgHNBFwEE+f+snbA
X-Received: by 2002:a05:620a:c98:b0:6fa:2ffe:aab0 with SMTP id q24-20020a05620a0c9800b006fa2ffeaab0mr1764857qki.567.1668184564613;
        Fri, 11 Nov 2022 08:36:04 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6nWeiKKtbGwQyvMC7EoupUmLz8J7yWqDcAtEA6uRF4m9XzonXF3JCm2XUraHXJpty+FSLTaA==
X-Received: by 2002:a05:620a:c98:b0:6fa:2ffe:aab0 with SMTP id q24-20020a05620a0c9800b006fa2ffeaab0mr1764835qki.567.1668184564368;
        Fri, 11 Nov 2022 08:36:04 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-234.retail.telecomitalia.it. [82.53.134.234])
        by smtp.gmail.com with ESMTPSA id ay42-20020a05622a22aa00b0039a08c0a594sm1433589qtb.82.2022.11.11.08.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 08:36:03 -0800 (PST)
Date:   Fri, 11 Nov 2022 17:35:48 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>
Cc:     stefanha@redhat.com, mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org, arei.gonglei@huawei.com,
        yechuan@huawei.com, huangzhichao@huawei.com,
        linux-kernel@vger.kernel.org, xiehong@huawei.com
Subject: Re: [PATCH] vp_vdpa: harden the logic of set status
Message-ID: <20221111163548.x6yy2w74gk6biykw@sgarzare-redhat>
References: <20221111145505.1232-1-longpeng2@huawei.com>
 <20221111151459.dyz42jclq26ai26q@sgarzare-redhat>
 <0f25506f-b9ca-1578-f944-cfb3936ced50@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0f25506f-b9ca-1578-f944-cfb3936ced50@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 11:49:10PM +0800, Longpeng (Mike, Cloud Infrastructure Service Product Dept.) wrote:
>
>
>在 2022/11/11 23:14, Stefano Garzarella 写道:
>>On Fri, Nov 11, 2022 at 10:55:05PM +0800, Longpeng(Mike) wrote:
>>>From: Longpeng <longpeng2@huawei.com>
>>>
>>>1. We should not set status to 0 when invoking vp_vdpa_set_status().
>>>
>>>2. The driver MUST wait for a read of device_status to return 0 before
>>>  reinitializing the device.
>>>
>>>Signed-off-by: Longpeng <longpeng2@huawei.com>
>>>---
>>>drivers/vdpa/virtio_pci/vp_vdpa.c | 11 ++++++++++-
>>>1 file changed, 10 insertions(+), 1 deletion(-)
>>>
>>>diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c 
>>>b/drivers/vdpa/virtio_pci/vp_vdpa.c
>>>index d448db0c4de3..d35fac5cde11 100644
>>>--- a/drivers/vdpa/virtio_pci/vp_vdpa.c
>>>+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
>>>@@ -212,8 +212,12 @@ static void vp_vdpa_set_status(struct 
>>>vdpa_device *vdpa, u8 status)
>>>{
>>>    struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
>>>    struct virtio_pci_modern_device *mdev = vp_vdpa_to_mdev(vp_vdpa);
>>>-    u8 s = vp_vdpa_get_status(vdpa);
>>
>>Is this change really needed?
>>
>No need to get the status if we try to set status to 0 (trigger BUG).
>

Okay, but that's the case that should never happen, so IMHO we can leave 
it as it is.

>>>+    u8 s;
>>>+
>>>+    /* We should never be setting status to 0. */
>>>+    BUG_ON(status == 0);
>>
>>IMHO panicking the kernel seems excessive in this case, please use 
>>WARN_ON and maybe return earlier.
>>
>Um...I referenced the vp_reset/vp_set_status,

Ah I see, maybe it's an old code, because recently we always try to 
avoid BUG_ON().

>
>>>
>>>+    s = vp_vdpa_get_status(vdpa);
>>>    if (status & VIRTIO_CONFIG_S_DRIVER_OK &&
>>>        !(s & VIRTIO_CONFIG_S_DRIVER_OK)) {
>>>        vp_vdpa_request_irq(vp_vdpa);
>>>@@ -229,6 +233,11 @@ static int vp_vdpa_reset(struct vdpa_device *vdpa)
>>>    u8 s = vp_vdpa_get_status(vdpa);
>>>
>>>    vp_modern_set_status(mdev, 0);
>>>+    /* After writing 0 to device_status, the driver MUST wait for 
>>>a read of
>>>+     * device_status to return 0 before reinitializing the device.
>>>+     */
>>>+    while (vp_modern_get_status(mdev))
>>>+        msleep(1);
>>
>>Should we set a limit after which we give up? A malfunctioning 
>>device could keep us here forever.
>>
>Yes, but the malfunctioning device maybe can not work anymore, how to 
>handle it?

Maybe we should set the status to broken, but in this case we could just 
return an error if we couldn't reset it, how about that?

Thanks,
Stefano

