Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E8573A0E7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 14:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjFVM3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 08:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjFVM3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 08:29:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C0D1BC5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 05:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687436899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5pmHwEzAPicyH88XD8XeXekL+O3YOK5f/E4/IhyQwRg=;
        b=fX0oRj6d3zViaUbbuetodbqio7nlsnAZ3/tsm7DZMOZadPtN2ahh82X06PW9Cc9BOMn8zu
        RgpChtpP/9GRDvkiVgrAWnH/ruuvA+RfyJPWhqM3PjMGh9zxqKv8j3UeyxDvOwYQcaTbV6
        bYMjibo9mGTalL4ZvMM0Cyf599pOxy4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-tfzK1AwcMluuPje5Fe9lMA-1; Thu, 22 Jun 2023 08:28:18 -0400
X-MC-Unique: tfzK1AwcMluuPje5Fe9lMA-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7623a4864c2so905079985a.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 05:28:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687436897; x=1690028897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5pmHwEzAPicyH88XD8XeXekL+O3YOK5f/E4/IhyQwRg=;
        b=KCdzCsrNPlPis0XlDFhT5L1g+KrtRORzsBkRuDRheCoIURH/AY1WgArem/rlhEaG6w
         vfhxRCcShfq5hmdCldYN7sUc35CMETC84noarLL1667VstWulG7rBo/zE3lgC6u44Q9w
         2zumWiuPBRZ9kD5QW2hWbZLrDh6J7eLFnk0jGZO8jS5wpYDUp4h1hUppLqbqxQ4j/gPl
         k9xYPr2ZpAehhrv33UQSk0PpOdK2zDtAspXD2NajUUTvMaz1v8gwn3Y79YfopN8KEwpu
         v6VafhJ6IhrX9nf1xu44CiD1x3Vm42KVTmuSg2wpMbo2aGFiV5kLWnmU7RPtlzDrgULU
         pAag==
X-Gm-Message-State: AC+VfDyOIZA5aejQsReYTmIm9BHedp7tVUqk+O4iIUyQfNgkwqVFUwUf
        hAcuQgGZSOuHc2pTcCL8BL+0/YDKdxkiqn7CKLXmzg4jgAGYZWMNR8bk7a2k8VrxQA/BbEXymdC
        3cyaY6g7dLDJ0nLExmV8AR0rupXguNkzN
X-Received: by 2002:a05:620a:4d4:b0:765:25be:36e4 with SMTP id 20-20020a05620a04d400b0076525be36e4mr2203240qks.6.1687436897372;
        Thu, 22 Jun 2023 05:28:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6+Pf7PlnZxl+iDCZchQ2oSl5E1RwIAB5qxqHpnM5zKpM+NYgKOaaF1kJ1Jxjl6Kghb8vQT2Q==
X-Received: by 2002:a05:620a:4d4:b0:765:25be:36e4 with SMTP id 20-20020a05620a04d400b0076525be36e4mr2203223qks.6.1687436897080;
        Thu, 22 Jun 2023 05:28:17 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-160.retail.telecomitalia.it. [87.11.6.160])
        by smtp.gmail.com with ESMTPSA id s16-20020a05620a031000b0075f13bda351sm3301106qkm.115.2023.06.22.05.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 05:28:16 -0700 (PDT)
Date:   Thu, 22 Jun 2023 14:28:11 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>,
        Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
        Tiwei Bie <tiwei.bie@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost-vdpa: filter VIRTIO_F_RING_PACKED feature
Message-ID: <6culpnuswqq4fh7r5iqqtvwrpnsapn4jhx3heorfctztc2miem@hscigltkix5d>
References: <20230605110644.151211-1-sgarzare@redhat.com>
 <20230622073625-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230622073625-mutt-send-email-mst@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 07:37:08AM -0400, Michael S. Tsirkin wrote:
>On Mon, Jun 05, 2023 at 01:06:44PM +0200, Stefano Garzarella wrote:
>> vhost-vdpa IOCTLs (eg. VHOST_GET_VRING_BASE, VHOST_SET_VRING_BASE)
>> don't support packed virtqueue well yet, so let's filter the
>> VIRTIO_F_RING_PACKED feature for now in vhost_vdpa_get_features().
>>
>> This way, even if the device supports it, we don't risk it being
>> negotiated, then the VMM is unable to set the vring state properly.
>>
>> Fixes: 4c8cf31885f6 ("vhost: introduce vDPA-based backend")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>
>OK so for now I dropped this, we have a better fix upstream.
>

Yep, I agree.

Maybe we can reuse this patch in the stable branches where the backport
is not easy. Although as Jason said, maybe we don't need it.

Thanks,
Stefano

