Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC0862E1C0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240622AbiKQQ16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:27:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240788AbiKQQ1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:27:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5BC78D7F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668702335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ddO8xSwm8AIeskUgBl2bXxV1BqhKg/yuCs+KcXuL1uo=;
        b=MXniMMgc0QOF9QkhO3n2JITEYeLhICfThAIQcRANjKT10wWKyUxUqDFa+F5s7dwJyaqW8G
        syg0ZXSyfcyq5hbpuqwr5F1zLN5DI++/VyeSIFYtF7Pjp7l23jzpY4vkKD6B9zvnf/ubkn
        A4lmbz181VKo+4sD11yJdk9Co9X6E+Q=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-220-5EFMH0FyNuCMgPeQk4nC8w-1; Thu, 17 Nov 2022 11:25:34 -0500
X-MC-Unique: 5EFMH0FyNuCMgPeQk4nC8w-1
Received: by mail-qv1-f69.google.com with SMTP id on28-20020a056214449c00b004bbf12d7976so1972865qvb.18
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:25:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ddO8xSwm8AIeskUgBl2bXxV1BqhKg/yuCs+KcXuL1uo=;
        b=7eY1sStoShai8jolQU6w+izj6Syw+vYkOv3GcUEiVxlPAOnfM/p4XgvwIWma1ZxrgR
         axypwB/13PsPDgma4f8lrZ2lqb/7jjPuffQeSue3LLIptHVE+kGJ7Bdf7L5bD/KY01nB
         NqJu5vbRLBeNn16c9aEe0i8R0upxT8mZHG7FW7Vo/6n7kfNihYS9z583a8UoWsS6DgGw
         9yxzCPTyUwssD6iijO5Vm6nzl5i565++kfthUF6ieFN8Kpwgpip+BI7tAWmi1/XxXWb/
         0eyYvj3DRktzKTlgGrkDHOw4LKkiWb/CXGAx91rqmWrq1yYXEVl8g3YNyXBr2J1vpu3F
         nVpQ==
X-Gm-Message-State: ANoB5pnHsvE2uitvA4AuBz/WwdUWr9sqFFj8fV+yPunPXA5nWYc8tucF
        YGQA0FrQ0Bdw60J9laNMaoWXvv7kVfcYt85TF/Ztb4YbeyUow415LXmaxnOKgqoQrYsneIT4jom
        +cpHo/Pi82aFaP1uaps/wdiEq
X-Received: by 2002:a05:620a:35a:b0:6fa:27f6:8338 with SMTP id t26-20020a05620a035a00b006fa27f68338mr2235549qkm.721.1668702334146;
        Thu, 17 Nov 2022 08:25:34 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4lbhRxQJFiYUoLqm6KU1+0iM/S1YR+8DtldDn9LvHgzKEAKyeUS+7z4a7X6z6/x3CNsfZuRg==
X-Received: by 2002:a05:620a:35a:b0:6fa:27f6:8338 with SMTP id t26-20020a05620a035a00b006fa27f68338mr2235526qkm.721.1668702333898;
        Thu, 17 Nov 2022 08:25:33 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-234.retail.telecomitalia.it. [82.53.134.234])
        by smtp.gmail.com with ESMTPSA id ge11-20020a05622a5c8b00b00342f8d4d0basm591430qtb.43.2022.11.17.08.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 08:25:33 -0800 (PST)
Date:   Thu, 17 Nov 2022 17:25:27 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Cc:     linux-kernel@vger.kernel.org, mst@redhat.com,
        virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vdpa_sim_net: Offer VIRTIO_NET_F_STATUS
Message-ID: <20221117162527.yevc65p6q6hpwvmn@sgarzare-redhat>
References: <20221117155502.1394700-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221117155502.1394700-1-eperezma@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 04:55:02PM +0100, Eugenio Pérez wrote:
>VIRTIO_NET_S_LINK_UP is already returned in config reads since vdpasim
>creation, but the feature bit was not offered to the driver.
>
>Tested modifying VIRTIO_NET_S_LINK_UP and different values of "status"
>in qemu virtio-net options, using vhost_vdpa.
>
>Not considering as a fix, because there should be no driver trusting in
>this config read before the feature flag.
>
>Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
>---
> drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 1 +
> 1 file changed, 1 insertion(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

