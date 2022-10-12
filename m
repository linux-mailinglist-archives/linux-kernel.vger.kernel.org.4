Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02BB95FC035
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 07:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbiJLFya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 01:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiJLFy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 01:54:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C0D9AFC1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 22:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665554066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q4nlj50WPMcH7w2yz/1NnL0XsiKvj2FRcmAW5ed9ibA=;
        b=HIiClDI8QVlTAyspBMeKV8A+CkUsrR59LLaErPp1S8LU3Aar5REn12Au68HTKT7bAhGXCu
        5hErnfjyRjqnoAGotwcaL28pgitsOvbCE+xn0gaslKMvNEJrcYPJHtTXm13aBm/F/W7LbO
        n/8+XJBX59qQU42L0cPj57f+nw2Gw5A=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-396-qfbZ938TPEOpT_cB1NaFrg-1; Wed, 12 Oct 2022 01:54:25 -0400
X-MC-Unique: qfbZ938TPEOpT_cB1NaFrg-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-132b47fe3bdso7844199fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 22:54:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q4nlj50WPMcH7w2yz/1NnL0XsiKvj2FRcmAW5ed9ibA=;
        b=tG25iVKbCsqBkY/x4c7UWs83mTSU03BKZC+iV7Bj21pRxQsfIDNustGkEcedaSxPer
         nkBqs25rYMRDKKoHvwswdkaLH7+kyqTF9XyoXOzORfN35ZUbyuFjcvn6LSkZ4bdoFMSM
         UtaAdkJIi8J5OAqgYXdL9RrIRyQ2ESR5GLFAhTftnCf8NjbAX8P4stBFrPUSJzQ8hm0+
         haKd4jbYT5UQ0frZJE01zqthMWyAHC59nsJafOdeKc9fK0SBNTcvcmdWyQzQcogLlWOY
         05iNBp1QwagOs7CvEd+KLdJeBN4LOn3D2/vtNDX9xOxNQpixh7NS39VjZhTD0cxh/UKc
         oN7w==
X-Gm-Message-State: ACrzQf0CIuX/cMynijBn3tZ4w+55pcBT5DZ4+/ft368oahIiqD1fKNpY
        3g1VcyXp0SLeUgH+TLaLbuduV1w64lzJHM+R9ergO48jlMdrutug6r9UnuQxMlUEKldr8fk9yNa
        wEiFrWoGgUM1OLnmzzboxldvHR2m+ezscNALbhtXm
X-Received: by 2002:a05:6870:c1d3:b0:136:c4f6:53af with SMTP id i19-20020a056870c1d300b00136c4f653afmr1474560oad.35.1665554064402;
        Tue, 11 Oct 2022 22:54:24 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7c9Rp6vwpqfYxPmhZD9MeI8O/wsB7Z6IHw5Y32+tnGBv7pt411ObFY6hMz5nGHkrScp4/Bqil0HgewiskCCvE=
X-Received: by 2002:a05:6870:c1d3:b0:136:c4f6:53af with SMTP id
 i19-20020a056870c1d300b00136c4f653afmr1474552oad.35.1665554064248; Tue, 11
 Oct 2022 22:54:24 -0700 (PDT)
MIME-Version: 1.0
References: <20221012045152.223274-1-mst@redhat.com>
In-Reply-To: <20221012045152.223274-1-mst@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 12 Oct 2022 13:54:13 +0800
Message-ID: <CACGkMEv1+TqR4Jb51SmrsoZ9H9OKaF_EMbSbeJ=Mr-BcN-bpnQ@mail.gmail.com>
Subject: Re: [PATCH] vdpa/ifcvf: add reviewer
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Zhu Lingshan <lingshan.zhu@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 12:53 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> Zhu Lingshan has been writing and reviewing ifcvf patches for
> a while now, add as reviewer.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  MAINTAINERS | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8d960ca4e969..531bbb0a507a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21736,6 +21736,10 @@ F:     include/linux/virtio*.h
>  F:     include/uapi/linux/virtio_*.h
>  F:     tools/virtio/
>
> +IFCVF VIRTIO DATA PATH ACCELERATOR
> +R:     Zhu Lingshan <lingshan.zhu@intel.com>
> +F:     drivers/vdpa/ifcvf/
> +
>  VIRTIO BALLOON
>  M:     "Michael S. Tsirkin" <mst@redhat.com>
>  M:     David Hildenbrand <david@redhat.com>
> --
> MST
>

