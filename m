Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67AD96B3993
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 10:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbjCJJEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 04:04:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjCJJDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 04:03:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1041B2D8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 00:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678438788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JSOXOjdfBH4z2A2joOF3hu2wKWS36UlVXuUE3j0PT9A=;
        b=domif4Cn32MDarw8fygLJFF+xJ+0Sg4uw/p6rJkdPhIaqKIC8CHzMoKay1kcYr2s6txnSB
        P31JbKDl/S5qJxAGF/CoNaCzCyMu3R7E2jwX5GbPxSgNYAp6GO2PE/PLFzEK4CyT/Z3mSk
        1Tq+jYBMcFBCy8m+uJE3UkQ6GY/m1jQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-_h2R8IWbOeKq7LXJn35mAg-1; Fri, 10 Mar 2023 03:59:46 -0500
X-MC-Unique: _h2R8IWbOeKq7LXJn35mAg-1
Received: by mail-wr1-f71.google.com with SMTP id y11-20020a056000168b00b002ce179d1b90so915093wrd.23
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 00:59:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678438785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JSOXOjdfBH4z2A2joOF3hu2wKWS36UlVXuUE3j0PT9A=;
        b=nIN3d4DpjS2TYndbsCVdN67+YnlnjmB97lrb2GysMo8veBpj/MsG1YkkymOs5WwO+y
         4yIEmPPjKexgDtlyuq1qQ67MCO+mIwSl/YNqU9iD5ZN4Mw9tiCXhLivkae0bMoyCAGUy
         69u2Je5ixpDAqEoDXWVr1BstpVZO5uq9WR1L9TngLXCdBewJxhEGf7PQdAihPxW6/4Sj
         n3LR/Wcje05LqTL7W2B84MHZuuyUQiu9ktRDRqB12VdAqGju1Gr813WOGzhuvqayOy68
         zF7P7wlxlvWaZfBWlfLETIssYktyjFwrAjjpRnE6Q43NDifgz7B5wY4ZBljsshexZ60q
         +xpg==
X-Gm-Message-State: AO0yUKWn4YKkfHN0WWbYJdwKXxG949DUZizillmxED/+6qWveDuYueOQ
        rPQqfdVTGvbtpTUjBpmW5+uUFait6GuPCnjYEu3zErxboe76KSaxSpcUw361bhz62sU2grYQ1T9
        oM/KZ1O4w44lv7kVyYUF3GM2H
X-Received: by 2002:a05:600c:5028:b0:3eb:a4e:a2b2 with SMTP id n40-20020a05600c502800b003eb0a4ea2b2mr1942749wmr.4.1678438785211;
        Fri, 10 Mar 2023 00:59:45 -0800 (PST)
X-Google-Smtp-Source: AK7set/Az9JmFp4O0bJkHnPIfsNeuI++C8epvGL47tzv7KyRdo2SazZZqc3EbyXrfIt2qo/Y6T4r/w==
X-Received: by 2002:a05:600c:5028:b0:3eb:a4e:a2b2 with SMTP id n40-20020a05600c502800b003eb0a4ea2b2mr1942738wmr.4.1678438784936;
        Fri, 10 Mar 2023 00:59:44 -0800 (PST)
Received: from redhat.com ([2.52.9.88])
        by smtp.gmail.com with ESMTPSA id 16-20020a05600c029000b003eb68bb61c8sm1525637wmk.3.2023.03.10.00.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 00:59:44 -0800 (PST)
Date:   Fri, 10 Mar 2023 03:59:40 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Longpeng(Mike)" <longpeng2@huawei.com>
Cc:     jasowang@redhat.com, stefanha@redhat.com, sgarzare@redhat.com,
        arei.gonglei@huawei.com, yechuan@huawei.com,
        huangzhichao@huawei.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, eperezma@redhat.com
Subject: Re: [PATCH v4 0/2] vdpasim: support doorbell mapping
Message-ID: <20230310035915-mutt-send-email-mst@kernel.org>
References: <20230227091857.2406-1-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230227091857.2406-1-longpeng2@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 05:18:55PM +0800, Longpeng(Mike) wrote:
> From: Longpeng <longpeng2@huawei.com>
> 
> This patchset supports doorbell mapping for vdpasim devices.
> 
> v3: https://lore.kernel.org/lkml/20230213070446-mutt-send-email-mst@kernel.org/T/
> v2: https://lore.kernel.org/lkml/CACGkMEtdT5fG=ffbpQadkGmzHf6Ax-+L50LsriYqJaW++natMg@mail.gmail.com/T/

Pls fix issues found by 0-day and repost.

> Changes v3->v4:
>     - use WRITE_ONCE  [Jason]
>     - start/stop periodic work when create/destroy vdpasim device  [Jason]
> 
> Changes v2->v3:
>     - add a new callback named get_vq_notification_pgprot to vdpa_config_ops [Jason]
>     - remove the new added module parameter 'parameter' [Jason]
>     - opencode the schedule/cancel_delayed() [Jason]
> 
> Changes v1->v2:
>     - support both kick mode and passthrough mode. [Jason]
>     - poll the notify register first. [Jason, Michael]
> 
> Longpeng (2):
>   vdpa: support specify the pgprot of vq notification area
>   vdpasim: support doorbell mapping
> 
>  drivers/vdpa/vdpa_sim/vdpa_sim.c | 67 ++++++++++++++++++++++++++++++++
>  drivers/vdpa/vdpa_sim/vdpa_sim.h |  3 ++
>  drivers/vhost/vdpa.c             |  4 +-
>  include/linux/vdpa.h             |  9 +++++
>  4 files changed, 82 insertions(+), 1 deletion(-)
> 
> -- 
> 2.23.0

