Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4CC6B3987
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 10:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbjCJJDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 04:03:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbjCJJBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 04:01:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603381111CD
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 00:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678438538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vfaGyjJVfm635JeXhSuWAc4er0IJMoVENEv0pUS72pE=;
        b=I1u/JC6AwMelFLsEEZpnfECD3i75FudEbp8L0lOM1xYwBHozTl/QP7T7kXJK7FGmIidgIw
        ZzWrFbyhG7dlM2J2lJkoNSNMMWV/13h2Q3Fmvjb1fqSxUfOe456HQTH5k/LOBEuumQVSXC
        Ssql97/r/qvK2hnD4ys4YNq6lbX42RM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-5UUb5KFYOMqvm5shdWhxjA-1; Fri, 10 Mar 2023 03:55:31 -0500
X-MC-Unique: 5UUb5KFYOMqvm5shdWhxjA-1
Received: by mail-wm1-f69.google.com with SMTP id e17-20020a05600c219100b003e21fa60ec1so1737354wme.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 00:55:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678438525;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vfaGyjJVfm635JeXhSuWAc4er0IJMoVENEv0pUS72pE=;
        b=zWaQdGjoM0c0w5HW6IT7y3orWz/+fabwrNBZQTHBpikdC/7GfCaNo9+tb91f0ZXvnz
         a/ghiZSSGtjPSl2Fu93yySysFNCGhCZ5cPKcWAsWlpbQQJLFEF4sGdqPk0HlRX4RaHj+
         WsFRqG98B2e1AsTCmxmcflLDJSgVCvORYaMjs0OG3TXc8hsOpu7W7wN28LeUC/bWeRLd
         u0jJGYU5h98FkrnEXduAKgMvbS7ltjuddmAthJPU0tP2NrJVY992YHAmEOSZBbtc8/MN
         cTEzyDScnE9eKralIH6x0ufsvhpraoeUSnSbU/ogvfZEyAot4T5DX/6l/fL/mOwKPqCx
         5sNQ==
X-Gm-Message-State: AO0yUKU8inZfikMzpfbJzxkMjJSlQeiC8iPi/MdPQ+bpK2BVbUB3M/U8
        F+BReq7Yfm44iuXQIY3/wM9kKMp2SwLhVlQXhBunPV4JmOizk7KC9zF2Nyu24SG+02vp5MNMIow
        zGzOY3b4ywx3PR0RF6xEamwt5
X-Received: by 2002:a5d:558e:0:b0:2c9:e5f0:bd4f with SMTP id i14-20020a5d558e000000b002c9e5f0bd4fmr16454641wrv.18.1678438525522;
        Fri, 10 Mar 2023 00:55:25 -0800 (PST)
X-Google-Smtp-Source: AK7set+ZCJLrhyjyYuI2NKYdYVdjVvFfujK+H8p82JNRkHzpuum9+WBjmlvVp1x6vFu5g5usem1xCg==
X-Received: by 2002:a5d:558e:0:b0:2c9:e5f0:bd4f with SMTP id i14-20020a5d558e000000b002c9e5f0bd4fmr16454627wrv.18.1678438525223;
        Fri, 10 Mar 2023 00:55:25 -0800 (PST)
Received: from redhat.com ([2.52.9.88])
        by smtp.gmail.com with ESMTPSA id j13-20020a5d564d000000b002c5694aef92sm1620415wrw.21.2023.03.10.00.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 00:55:24 -0800 (PST)
Date:   Fri, 10 Mar 2023 03:55:21 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Andrey Smetanin <asmetanin@yandex-team.ru>
Cc:     Jason Wang <jasowang@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>
Subject: Re: [PATCH] vhost_net: revert upend_idx only on retriable error
Message-ID: <20230310035509-mutt-send-email-mst@kernel.org>
References: <20221123102207.451527-1-asmetanin@yandex-team.ru>
 <CACGkMEs3gdcQ5_PkYmz2eV-kFodZnnPPhvyRCyLXBYYdfHtNjw@mail.gmail.com>
 <20221219023900-mutt-send-email-mst@kernel.org>
 <62621671437948@mail.yandex-team.ru>
 <20230127031904-mutt-send-email-mst@kernel.org>
 <278011674821181@mail.yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <278011674821181@mail.yandex-team.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 03:08:18PM +0300, Andrey Smetanin wrote:
> Yes, I plan. I need some time, currently I'm very busy in another direction,
> but I will return.


Jason you want to take this up maybe?

> 27.01.2023, 11:19, "Michael S. Tsirkin" <mst@redhat.com>:
> 
> 
>     On Mon, Dec 19, 2022 at 11:24:26AM +0300, Andrey Smetanin wrote:
> 
>          Sorry for the delay.
>          I will send update on this week after some tests.
>          19.12.2022, 10:39, "Michael S. Tsirkin" <mst@redhat.com>:
> 
> 
>     Do you still plan to send something? Dropping this for now.
>      
> 

