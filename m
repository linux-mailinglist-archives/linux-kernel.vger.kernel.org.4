Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70FA05F5AF3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 22:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiJEUZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 16:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbiJEUZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 16:25:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DD67F13F
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 13:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665001515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=86WWmb1vJeLs9Ctv4ANh4WOz2rPIK6lvoWUYd8tv0OA=;
        b=AQrlhsW9bRNbW29xs8kFC/csk5e76rz1iftghepgoGvy/jbwZbWbzM6EWHXnmZ15Ue6Fva
        +QwMbIZkkTF0Aw8wMar1xhq9tPQbgw15/kXiGp4s/XhWcfUqiPZbsHGi4KTTWPBu67lU9S
        KS0Ia/0UJx7oelc0FHzSTWwkqG7q/qQ=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-533-w-bw_vyzNjKv2e-7kwjEuQ-1; Wed, 05 Oct 2022 16:25:14 -0400
X-MC-Unique: w-bw_vyzNjKv2e-7kwjEuQ-1
Received: by mail-io1-f71.google.com with SMTP id f25-20020a5d8799000000b006a44e33ddb6so11646478ion.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 13:25:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=86WWmb1vJeLs9Ctv4ANh4WOz2rPIK6lvoWUYd8tv0OA=;
        b=OMgKsOiZqIZtpFd5pkE3XnhTkJuUdNFsxhv9m6NQlnzBxdvPZnWcMw9c0UU/Jvg5B9
         E/6+XABL4IxWMTdZr+n2/PTZLRldhQGWerTfNDcHOQgkLM+C5GJ5iJQwtcf/oNbzglCU
         5t9X/Q9fqyiBimazOEYcwY2IqYpFYFHy0XSeXg/xldHsSf2Xczvgfu0SJ5PAPLIi4YYC
         Y7JcWArlF4YwGFRFeURHH9JNyeSG2RpybPRcKO4fVgrUHJJ88IpWjJ/pg0W9UaW3YSON
         Tmr6kfYrDoU9E3Gakb42JrxGM7kdY0F4QD3SKTIa0WxEmEkX6P02C4f5mYbR2e1ChCuD
         i1bw==
X-Gm-Message-State: ACrzQf0GKnzCXHkZvN2erIyVv2pimUojte2Tpp/IXNnNhMTduaA7n0cM
        rLI0Z+u6z/S7axybI7t3WS93xsJf/dF0GFZFtdN5hZNvtmhZEIdcbJabYPo4hgPpEaupVfU5Sk9
        byw9Hcr1fSkWbvrPUCx4UyCw7
X-Received: by 2002:a05:6638:1135:b0:362:bcba:6fff with SMTP id f21-20020a056638113500b00362bcba6fffmr707433jar.129.1665001513208;
        Wed, 05 Oct 2022 13:25:13 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5zMQ8nZBstQ8/VZUmu7G1LF5iy09Gr1MWJLuQFjO/chMV4an7kCrwy4dVvl9VBSVUH7mrGwg==
X-Received: by 2002:a05:6638:1135:b0:362:bcba:6fff with SMTP id f21-20020a056638113500b00362bcba6fffmr707427jar.129.1665001513003;
        Wed, 05 Oct 2022 13:25:13 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id h14-20020a056602154e00b006a175fe334dsm7161320iow.1.2022.10.05.13.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 13:25:11 -0700 (PDT)
Date:   Wed, 5 Oct 2022 14:25:10 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the vfio tree
Message-ID: <20221005142510.199debc2.alex.williamson@redhat.com>
In-Reply-To: <20221004073151.2d4f778d@canb.auug.org.au>
References: <20221004073151.2d4f778d@canb.auug.org.au>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Oct 2022 07:31:51 +1100
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> In commit
> 
>   66c6b7dbbda3 ("drm/i915/gvt: fix a memory leak in intel_gvt_init_vgpu_types")
> 
> Fixes tag
> 
>   Fixes: c90d097ae144 ("drm/i915/gvt: define weight according to vGPU type")
> 
> has these problem(s):
> 
>   - Target SHA1 does not exist
> 
> Maybe you meant
> 
> Fixes: bc90d097ae14 ("drm/i915/gvt: define weight according to vGPU type")

Yes, I agree.  I've fixed this in my tree and forced the update to my
next branch.  Thanks!

Alex

