Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5002A6B1F80
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 10:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbjCIJKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 04:10:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbjCIJKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 04:10:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3550E1F49E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 01:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678352970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8yCelNSr6rYm3fdnqKstdG6udl5yNcoRzMcScSgtxcE=;
        b=LW81gpNldu7mCWO2T8iudmc92nOjvbsoZMe9HPciQdaGsxafyQUe3q6ubdq0FBaH0WuoD3
        mcHHD2p832xrJxc1n2fazmjAc0vthsFX6y4xiOqI+4O+OB+Ud2oOmJG236Jpj2V2MQ56WG
        fFw7RLV9LXXUO7HW9ysPPWXlxHiLaJY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-3Rg0OLhYNLmfTwl4IoN5CA-1; Thu, 09 Mar 2023 04:09:27 -0500
X-MC-Unique: 3Rg0OLhYNLmfTwl4IoN5CA-1
Received: by mail-qk1-f197.google.com with SMTP id e14-20020a05620a208e00b0074270b9960dso824715qka.22
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 01:09:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678352967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8yCelNSr6rYm3fdnqKstdG6udl5yNcoRzMcScSgtxcE=;
        b=xIuZK0KmzcJ4wgaxnjgZ25FrcvRN7P11Bl4osGDkSvRSqpf9sOYN34pc8aDjIfF9S+
         lWoTBc3f5bMqm/eoBu0bNUfv6P6KX+Zyr75xAxRJBeNpf6M7K138z35vrg7BzhuZ+Zgp
         8ThiM3dn/vbPXkERYZmE4wq0tfllowrAsFiOjMQ6yBl535+vV2fAw9GLqvGleNCCkogu
         hbe4cLSlbigAllaJQ0KEwvh5bqE8yiQj2p9177Mc/tHhzn1Xk/xUAZKNIQrNbpNPMovw
         vHJRs7r+E7xw5oGu+/fewcZ0dxO8Y1piX+b5AgkyivW/LvT4otUIJY0eEgjdm10aVtEq
         nWdw==
X-Gm-Message-State: AO0yUKWz5mmr3lDuUvaSWlTFSiF5/zkFgGTDM2lOA4Nbq89T1i9iy/nQ
        NzxCTIs3c6UxNe6iyyGBMM0Zwe1Oy6hj5my12Owc8mlDzUe1OvxQ8mZPQNwHuraOsnMuXDx3SN2
        Qi0447zEhC7mHZ/66gWiOc2CY
X-Received: by 2002:ac8:5814:0:b0:3b8:6a92:c8d6 with SMTP id g20-20020ac85814000000b003b86a92c8d6mr36025125qtg.60.1678352967334;
        Thu, 09 Mar 2023 01:09:27 -0800 (PST)
X-Google-Smtp-Source: AK7set8EXeeyXyOTcJY3FuYwwfRSxMsmppbkCjawIYdYGgFETMM+mfT4kboxe+Ntrnrw0IwlKRWzFg==
X-Received: by 2002:ac8:5814:0:b0:3b8:6a92:c8d6 with SMTP id g20-20020ac85814000000b003b86a92c8d6mr36025101qtg.60.1678352967091;
        Thu, 09 Mar 2023 01:09:27 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-170.retail.telecomitalia.it. [82.57.51.170])
        by smtp.gmail.com with ESMTPSA id h13-20020ac8514d000000b003bfc335f124sm13095041qtn.79.2023.03.09.01.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 01:09:26 -0800 (PST)
Date:   Thu, 9 Mar 2023 10:09:23 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Rong Tao <rtoax@foxmail.com>
Cc:     Rong Tao <rongtao@cestc.cn>, "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "open list:VIRTIO CORE AND NET DRIVERS" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tools/virtio: virtio_test -h,--help should return
 directly
Message-ID: <20230309090923.dq72s6ovjo5lsyxq@sgarzare-redhat>
References: <tencent_822CEBEB925205EA1573541CD1C2604F4805@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <tencent_822CEBEB925205EA1573541CD1C2604F4805@qq.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 04:42:50PM +0800, Rong Tao wrote:
>From: Rong Tao <rongtao@cestc.cn>
>
>When we get help information, we should return directly, and we should not
>execute test cases. Move the exit() directly into the help() function and
>remove it from case '?'.
>
>Signed-off-by: Rong Tao <rongtao@cestc.cn>
>---
>v2: help(): exit with a value different from 0 (e.g. 2).
>v1: https://lore.kernel.org/lkml/tencent_4B5122C4158323A1D1ACA04B3295F1579207@qq.com/
>---
> tools/virtio/virtio_test.c | 10 +++++-----
> 1 file changed, 5 insertions(+), 5 deletions(-)

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

