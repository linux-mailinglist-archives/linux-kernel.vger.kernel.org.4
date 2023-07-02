Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE25744DBD
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 15:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjGBNiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 09:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjGBNiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 09:38:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77121E55
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 06:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688305034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fscz16jdu5EOdDpNFofgtOkAvApauMfws1a+RHlsQn0=;
        b=bqeo8LtrpydN8VC2qwddEFpcycLwhrbnIww6vqV/wB6qO9EyliH/c9a0h3rBAFIjFcQN1B
        KRg+e2CZbvDOtiO0c9BrAoRHLYmVSCwb7E8tQ83EWs4YykVBKkU/dCavmwbG1NtiH6fjh+
        Rp38ZlCft/tq20LsRM5Li/xxt9rY5Ls=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-QnXM37-INmW6g0ehERDcXw-1; Sun, 02 Jul 2023 09:37:13 -0400
X-MC-Unique: QnXM37-INmW6g0ehERDcXw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-94a355cf318so259584766b.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jul 2023 06:37:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688305032; x=1690897032;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fscz16jdu5EOdDpNFofgtOkAvApauMfws1a+RHlsQn0=;
        b=X+aQ/RyETrshNeWsrlCwdv0CCnNndjnavarCr7rFDcbfwlREs8O5zsvHOvePoTLefF
         Pg0Uv3wiZavINW+G+377SBmh7TBlwVsQA3w5r7iyFqnLOeXtSUrvt03Rv3OvYeMv8mD7
         QF/562mRP9DYi2BqZ2nkhE7q/HnxPn04HNWzN6qfe6HlJUSrS2Gsb+3UHz8q12jqYvUG
         dSdSTpIJKBFT8UwzKwWyIxdQ7Jn2exPZAbJYvTQp+W+RXZ4vjpKEdv9n2TEc/HmrCQ5B
         UFDTgQG4lUTNokJF10ty+Dj6XD79YENnadRPVZGizzOkh/HoBzOv/UVBdKEXLUhu887g
         WbVA==
X-Gm-Message-State: AC+VfDyh1ljdxZFBjPynGDfyMfNIlJI6f6jd0zXwW9YwjJjv9vt+IQUC
        siVXTiZIh9j1+yLtlhyhFvIPX/2hCfV8ZdLRliOiohl3hgM4blatdocSGuHARuyEZJ0008vkOsg
        j0iYX3/tQLs9s4xa5pAlBCoBb
X-Received: by 2002:a17:906:b811:b0:979:65f0:cced with SMTP id dv17-20020a170906b81100b0097965f0ccedmr5934777ejb.17.1688305031943;
        Sun, 02 Jul 2023 06:37:11 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFGgYm6Pej4shREErdqqtoaKfnv59VDi8oQbzHD5HcPb5WjgVVGyKQF1QNN/hdRhbN02rqoIg==
X-Received: by 2002:a17:906:b811:b0:979:65f0:cced with SMTP id dv17-20020a170906b81100b0097965f0ccedmr5934769ejb.17.1688305031706;
        Sun, 02 Jul 2023 06:37:11 -0700 (PDT)
Received: from redhat.com ([2.52.134.224])
        by smtp.gmail.com with ESMTPSA id x26-20020a1709065ada00b00992025654c1sm7342793ejs.179.2023.07.02.06.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 06:37:11 -0700 (PDT)
Date:   Sun, 2 Jul 2023 09:37:06 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Maxime Coquelin <maxime.coquelin@redhat.com>
Cc:     xieyongji@bytedance.com, jasowang@redhat.com,
        david.marchand@redhat.com, lulu@redhat.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        xuanzhuo@linux.alibaba.com, eperezma@redhat.com
Subject: Re: [PATCH v1 0/2] vduse: add support for networking devices
Message-ID: <20230702093530-mutt-send-email-mst@kernel.org>
References: <20230627113652.65283-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627113652.65283-1-maxime.coquelin@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 01:36:50PM +0200, Maxime Coquelin wrote:
> This small series enables virtio-net device type in VDUSE.
> With it, basic operation have been tested, both with
> virtio-vdpa and vhost-vdpa using DPDK Vhost library series
> adding VDUSE support using split rings layout (merged in
> DPDK v23.07-rc1).
> 
> Control queue support (and so multiqueue) has also been
> tested, but requires a Kernel series from Jason Wang
> relaxing control queue polling [1] to function reliably.
> 
> [1]: https://lore.kernel.org/lkml/CACGkMEtgrxN3PPwsDo4oOsnsSLJfEmBEZ0WvjGRr3whU+QasUg@mail.gmail.com/T/

Jason promised to post a new version of that patch.
Right Jason?
For now let's make sure CVQ feature flag is off?

> RFC -> v1 changes:
> ==================
> - Fail device init if it does not support VERSION_1 (Jason)
> 
> Maxime Coquelin (2):
>   vduse: validate block features only with block devices
>   vduse: enable Virtio-net device type
> 
>  drivers/vdpa/vdpa_user/vduse_dev.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> -- 
> 2.41.0

