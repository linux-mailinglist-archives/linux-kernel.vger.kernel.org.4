Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1786A5EB913
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 06:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbiI0ECB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 00:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiI0EBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 00:01:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0AF753AC
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 21:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664251309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7lIjUt+hfufCzcxQtRQ7Q4/F8PQSEKvpahXtOM1zAs0=;
        b=Fw4jrLKJTnTz4XvLFd9pcdsM96W02UtQ0H6TsPfBVNE9ms8x4fcEqKxbTCXxgHgfQJ3+nH
        wepeseVpgFJ7u48veuf9yOqBrOPmDoNhwpZa6/wwKa9QZDghvprwQevkWtuWjF+DtFfzfg
        bYeJFfvIdS4iRyjJjTxZeLyGTgdd8Jc=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-410-VG41BaDbN2OyoUeME1VVOw-1; Tue, 27 Sep 2022 00:01:42 -0400
X-MC-Unique: VG41BaDbN2OyoUeME1VVOw-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-12777f2df6aso3096201fac.14
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 21:01:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=7lIjUt+hfufCzcxQtRQ7Q4/F8PQSEKvpahXtOM1zAs0=;
        b=NPtTVdK/taFvic3C3LUq4B7YhD9InxUPO8hQediIMaBxqmlIBbUjDairALC2eNgoBg
         eycIH9IH4wqGt9JTwWQezzAO0tXmIcklUty0+iY3iSvo5p1Hus1qBPbUymUJ09Ng169l
         Uz1qyC0K3HbgEdW0VYdblacWI+qYVJwgwPs9+VR60YXH6iGyUaqUyszWXM+bonSJRSAL
         D+/Zr/9FNmfcsPRzrtok1s6jRJbuRk78mfkHsgeOYo8iNBwV2QhNWJlh/phtv2XCmqvR
         Ug2e2IQ6SDdOsuvjMNBU5vYOR+O/Ejoyf+8ofHZ+senuJYeQ7FGfRgM8WwvuDPEXItc5
         o3ng==
X-Gm-Message-State: ACrzQf2SLKCGUFXkYyqRwXhKHhv8q3LLferAJNCyh4coPQ2GRHdJQlPO
        CoPA/PTgZqasIgsYeP54dEVZ1oPvhU/P7yg/vkucOygAtx/Z75tI9ZOpGPujHBZvL9ITl+4S+go
        mXigNQHH4S50xXT8tojJiFtYINO/IJqJO/CadPTpL
X-Received: by 2002:a05:6870:e409:b0:127:d330:c941 with SMTP id n9-20020a056870e40900b00127d330c941mr1049110oag.280.1664251301505;
        Mon, 26 Sep 2022 21:01:41 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM70F8Ybkw+ftIjAd0V0ZxtTyRfkCtq71sY1UXmniwDHvOisWowtKgZkzq9L+wAcLMvQbmN4FB4GulJ4+Dx5uA0=
X-Received: by 2002:a05:6870:e409:b0:127:d330:c941 with SMTP id
 n9-20020a056870e40900b00127d330c941mr1049102oag.280.1664251301353; Mon, 26
 Sep 2022 21:01:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220926102946.3097-1-wangdeming@inspur.com>
In-Reply-To: <20220926102946.3097-1-wangdeming@inspur.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 27 Sep 2022 12:01:30 +0800
Message-ID: <CACGkMEtnsBEu6nm0oFCJyQwwf5PzdMRAsbzZZPZZ1TS9vRg1RQ@mail.gmail.com>
Subject: Re: [PATCH] virtio_ring: Drop unnecessary initialization of detach_buf_packed
To:     Deming Wang <wangdeming@inspur.com>
Cc:     mst <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 7:15 PM Deming Wang <wangdeming@inspur.com> wrote:
>
> The variable is initialized but it is only used after its assignment.
>
> Signed-off-by: Deming Wang <wangdeming@inspur.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/virtio/virtio_ring.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 8974c34b40fd..abac0a3de440 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1544,7 +1544,7 @@ static bool virtqueue_kick_prepare_packed(struct virtqueue *_vq)
>  static void detach_buf_packed(struct vring_virtqueue *vq,
>                               unsigned int id, void **ctx)
>  {
> -       struct vring_desc_state_packed *state = NULL;
> +       struct vring_desc_state_packed *state;
>         struct vring_packed_desc *desc;
>         unsigned int i, curr;
>
> --
> 2.27.0
>

