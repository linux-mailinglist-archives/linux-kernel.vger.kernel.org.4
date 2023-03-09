Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDC76B1F7E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 10:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjCIJKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 04:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbjCIJJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 04:09:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDB3109
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 01:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678352920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=srx6n4gHkwmgsQ7OIE1qCU+GHs3BJds+nIoKBUJIQzE=;
        b=Hfr7v9g1gh4/K8xTyfd5Mz6osEDxZoek1m/NCNLfWiNvOGZuJPoCgs+O5LOM8qkZXbbm+z
        68RZmWU4ex7mx872O9kihdRJymsZpxtUpQlrYX52O6PogYsagr+iP5SDSLEN+BbAEL/obi
        RxOt1BDkFqcdfbmGii4Juet17GxLsWg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-uGLhOBpHPbGBjFYLviV33w-1; Thu, 09 Mar 2023 04:08:39 -0500
X-MC-Unique: uGLhOBpHPbGBjFYLviV33w-1
Received: by mail-qk1-f199.google.com with SMTP id z23-20020a05620a101700b0073b328e7d17so848218qkj.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 01:08:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678352919;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=srx6n4gHkwmgsQ7OIE1qCU+GHs3BJds+nIoKBUJIQzE=;
        b=np5dGyabffK9y02MOGnmQR1HbsXCnySvIquzFA9K30IHXKT9VL9k3MMwg7WW0pdzSm
         Potx8EI/zvFFo53H4RjLKaZK/IbGDbVHxeA9uIanDBzD/8YKjUmz43KiDwZtAlH9gIij
         I8AyEVvBeio/XsNlqiFnJbdTQoImHaOfvpoDjMoV4GJpwFgqJMl2TQjfvKUNU2+0WJgr
         h7M8ubMLEAXEIlNnh4vdP48eWiJyob76hAnyqNLlWxvaIayLQhVCcxENTHZdWvJd4fhH
         nav/sZHhPIENWwB4b8RMX2m28BjAK47GYcaWzXiDZ1hA42aQeEdzTSmsvJeGdcsLNKju
         LhHg==
X-Gm-Message-State: AO0yUKX9cew+uQ61+NgAZ/jT2A+skMe4XnZXXLPz1yyzl2wOoWEOXLEL
        b1t57fKq4OvCYzzZ4liN5/OgHCwblKceVn8/fKKfwiZCsu7lB4dZMBAmkvTUYQgOK/HfY26yE9H
        k+Ojq+84GTE3jBwDU7aj05QKI
X-Received: by 2002:a05:622a:60c:b0:3bf:c5ab:a0db with SMTP id z12-20020a05622a060c00b003bfc5aba0dbmr38984339qta.41.1678352919005;
        Thu, 09 Mar 2023 01:08:39 -0800 (PST)
X-Google-Smtp-Source: AK7set/d8xNHSc1KF09A6BOMVU1+xsSGs0gU6ARd/TmG6uhTMDQO4mBh2NmpStvK4BR9Za1QDXGlWg==
X-Received: by 2002:a05:622a:60c:b0:3bf:c5ab:a0db with SMTP id z12-20020a05622a060c00b003bfc5aba0dbmr38984317qta.41.1678352918690;
        Thu, 09 Mar 2023 01:08:38 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-170.retail.telecomitalia.it. [82.57.51.170])
        by smtp.gmail.com with ESMTPSA id b3-20020ac85bc3000000b003bfb820f17csm13555612qtb.63.2023.03.09.01.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 01:08:38 -0800 (PST)
Date:   Thu, 9 Mar 2023 10:08:34 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Rong Tao <rtoax@foxmail.com>
Cc:     jasowang@redhat.com, linux-kernel@vger.kernel.org, mst@redhat.com,
        rongtao@cestc.cn, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] tools/virtio: virtio_test -h,--help should return
 directly
Message-ID: <20230309090834.57bwsiahnlt6r35a@sgarzare-redhat>
References: <20230309084920.oj66qnighnnyet3f@sgarzare-redhat>
 <tencent_19934693116B0C1C8402B2A22F5355205F09@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <tencent_19934693116B0C1C8402B2A22F5355205F09@qq.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 04:56:09PM +0800, Rong Tao wrote:
>Hi, Stefano.
>
>I'm wondering, does '-h,--help' help() should 'exit(0)'? Is '-h' considered
>a successful run and returns '0'.

You're right.
I thought -h would return an error, but that's not the case, so I guess
this patch is fine!

Thanks,
Stefano

>
>Best wishes,
>Rong
>

