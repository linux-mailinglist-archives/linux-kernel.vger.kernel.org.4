Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8B86C4053
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 03:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjCVCZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 22:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjCVCZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 22:25:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42718166F8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 19:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679451868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9aQ+a+bWlAmZ+gyzUvCuCjDZKR9JiNDMnvXlPEstOV4=;
        b=FYh9lajKg1CFD6jUeO6IwLH6qLAThYi+g5naWcIA9Ibu6QgDW9LdvwWRIeuaG7srjKkjWe
        gRYsdgVwu92IE7amG1kyCxEW5GCiicvPvkUa69FEd09ibLGywcfQnhkMIgPmtlaoz0cDDw
        1xgeS+JfTZjd9NG7eUf83Pxq0QRpCF0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-VoBO36m1O76nBYPbyK_ltQ-1; Tue, 21 Mar 2023 22:24:27 -0400
X-MC-Unique: VoBO36m1O76nBYPbyK_ltQ-1
Received: by mail-wm1-f69.google.com with SMTP id t1-20020a7bc3c1000000b003dfe223de49so10864702wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 19:24:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679451865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9aQ+a+bWlAmZ+gyzUvCuCjDZKR9JiNDMnvXlPEstOV4=;
        b=FpduDJc5UNGj/Tao6UI4CSEq+zyMVWMpfplmX8xM3z94EhYPGHeZnAJQrQwbM7uwd0
         xjc+bl0U6fH2p5EicRxp85jXd6oG2Ezk7ZylJp8/XAPYdKi59fCHxTulips0PYekiOaa
         wJfM0u3Jkw8WUBLkR6MakzcihoaI7tZr3LHdvGVkgyNy3rnUkxrpYWgrqrPAEwhNHqMR
         c+6Ohq9wZEAif8oRvXrU+mMy8+qt0FyEyvXnI7nkcL1/V75GSQ4S1DNNNrBHzQEuXlal
         tqIkF26dL7xABHMTr94/3IkKmHR/sIeadmoE07Vrz8+1bcfDiOuEYkWFps5oC1KiTQnF
         XbWQ==
X-Gm-Message-State: AO0yUKV+fNHkIf+DUqH265LwjdpoSSgVnxdyjsZU804ydAId/1Zds/YI
        qIzsN5Z/Id7To70VbAjnbSd4+7mlWubtWZvYEy4VGNqyWDlc7Xis2DdKxOj4eJRqjkt1xK5uT0O
        GUVJ97vXsaoejp9p8g3/2jpF0cRDBJkHv
X-Received: by 2002:a1c:4c19:0:b0:3ee:4dc0:d4f6 with SMTP id z25-20020a1c4c19000000b003ee4dc0d4f6mr1397680wmf.17.1679451865505;
        Tue, 21 Mar 2023 19:24:25 -0700 (PDT)
X-Google-Smtp-Source: AK7set8505dczk//oLctuEIBb3ICklPr+fVNrGO/QMzfXYO/4tDS79+1arJ8oEfQz9dOuGEkLLxLcg==
X-Received: by 2002:a1c:4c19:0:b0:3ee:4dc0:d4f6 with SMTP id z25-20020a1c4c19000000b003ee4dc0d4f6mr1397674wmf.17.1679451865192;
        Tue, 21 Mar 2023 19:24:25 -0700 (PDT)
Received: from redhat.com ([2.52.1.105])
        by smtp.gmail.com with ESMTPSA id j36-20020a05600c1c2400b003ebf73acf9asm118939wms.3.2023.03.21.19.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 19:24:24 -0700 (PDT)
Date:   Tue, 21 Mar 2023 22:24:22 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the vhost tree
Message-ID: <20230321222404-mutt-send-email-mst@kernel.org>
References: <20230322123231.2c5cbce5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322123231.2c5cbce5@canb.auug.org.au>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 12:32:31PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the vhost tree, today's linux-next build (htmldocs)
> produced this warning:
> 
> drivers/virtio/virtio_ring.c:2346: warning: Excess function parameter 'vq' description in 'virtqueue_dma_dev'
> 
> Introduced by commit
> 
>   9225f75b9b80 ("virtio_ring: introduce virtqueue_dma_dev()")
> 
> -- 
> Cheers,
> Stephen Rothwell

Fixed up, thanks, no need to repost the patch.

-- 
MST

