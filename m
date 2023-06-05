Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3865722773
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 15:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234079AbjFENbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 09:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233658AbjFENbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 09:31:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD8CE6
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 06:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685971844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=09h7AR4TuCkDh4zJT0E+2xZhXl8jzj6eU3ZdjKoNbek=;
        b=gmS4diiYn7Pm676p7UuGn+xWBH7IrpP9pEBE/qaXOsQf+V5KZA89Y379YFE0t1vUZt9YMS
        naiPfy5exKaWj+EESF6tEaLXQqpvc7vDj1r/wVjfmgKG5qg3WPcRoncJ59VD0lBNckY2eS
        cJpSC7g31RzM/Gi0fr2gnxrBtFfdt1w=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-RenWIlJ6M52G5LHE3yc3eA-1; Mon, 05 Jun 2023 09:30:43 -0400
X-MC-Unique: RenWIlJ6M52G5LHE3yc3eA-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-626070979faso34248506d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 06:30:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685971843; x=1688563843;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=09h7AR4TuCkDh4zJT0E+2xZhXl8jzj6eU3ZdjKoNbek=;
        b=lg/aSERjerichL5COJOjvcrgd3ZgWRMa8h+YhBUUJdOfVyT26gTRif8Xymh3Ox3E3d
         eGi9y5uF3ssVcLr1CjzRysOrJZpn7HQOWwgHgXgY1/3Jiy+MwUN5VLn+vA1nnPN9qEaY
         sjKX/ne24u+fk+0jrK9l/3ToJOkWEymuhza3HaIoMhodoDtyuKCxVcqWF91AnHFdm2X0
         L02RqJgVn5s+EhJgyxb/46DAmFb/JbRXSJRj81pXOdyC786IUC8/GmOYK73lmshbNfCm
         hXBPtuPavCDI9pqQobJ5ZmrocEEw/Xad+DgZ8WXKwxjNPuysFtz+Rf64h5W/f/7QJDbV
         M72w==
X-Gm-Message-State: AC+VfDyPpApGYclc00hrcWN+bpOYu3iS1KFJ4X68CEAfmzhR7FnDDSYu
        VlHGg8fFFejvpcbXS6iw11MdwR4Tjdyby4Mb91zGE5I5Sw0IX51rnLO9l0tbHoKrrJI2sQHSk3o
        eawAJde92J9DJvJhBo+AFvx7r
X-Received: by 2002:a05:6214:240b:b0:623:9a08:4edd with SMTP id fv11-20020a056214240b00b006239a084eddmr8345305qvb.25.1685971843171;
        Mon, 05 Jun 2023 06:30:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ59eKAQLHTpxMz4/t5AgUGvFz9F83N7jM9XvbTEJ6IWLoINLpCKUzwbDeHXyzeu5z0HI4vP9w==
X-Received: by 2002:a05:6214:240b:b0:623:9a08:4edd with SMTP id fv11-20020a056214240b00b006239a084eddmr8345276qvb.25.1685971842889;
        Mon, 05 Jun 2023 06:30:42 -0700 (PDT)
Received: from sgarzare-redhat ([5.77.94.106])
        by smtp.gmail.com with ESMTPSA id ph12-20020a0562144a4c00b0061c83f00767sm4623347qvb.3.2023.06.05.06.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 06:30:42 -0700 (PDT)
Date:   Mon, 5 Jun 2023 15:30:35 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Shannon Nelson <shannon.nelson@amd.com>
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>,
        Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
        Tiwei Bie <tiwei.bie@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost-vdpa: filter VIRTIO_F_RING_PACKED feature
Message-ID: <gi2hngx3ndsgz5d2rpqjywdmou5vxhd7xgi5z2lbachr7yoos4@kpifz37oz2et>
References: <20230605110644.151211-1-sgarzare@redhat.com>
 <20230605084104-mutt-send-email-mst@kernel.org>
 <24fjdwp44hovz3d3qkzftmvjie45er3g3boac7aezpvzbwvuol@lmo47ydvnqau>
 <20230605085840-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230605085840-mutt-send-email-mst@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 09:00:25AM -0400, Michael S. Tsirkin wrote:
>On Mon, Jun 05, 2023 at 02:54:20PM +0200, Stefano Garzarella wrote:
>> On Mon, Jun 05, 2023 at 08:41:54AM -0400, Michael S. Tsirkin wrote:
>> > On Mon, Jun 05, 2023 at 01:06:44PM +0200, Stefano Garzarella wrote:
>> > > vhost-vdpa IOCTLs (eg. VHOST_GET_VRING_BASE, VHOST_SET_VRING_BASE)
>> > > don't support packed virtqueue well yet, so let's filter the
>> > > VIRTIO_F_RING_PACKED feature for now in vhost_vdpa_get_features().
>> > >
>> > > This way, even if the device supports it, we don't risk it being
>> > > negotiated, then the VMM is unable to set the vring state properly.
>> > >
>> > > Fixes: 4c8cf31885f6 ("vhost: introduce vDPA-based backend")
>> > > Cc: stable@vger.kernel.org
>> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> > > ---
>> > >
>> > > Notes:
>> > >     This patch should be applied before the "[PATCH v2 0/3] vhost_vdpa:
>> > >     better PACKED support" series [1] and backported in stable branches.
>> > >
>> > >     We can revert it when we are sure that everything is working with
>> > >     packed virtqueues.
>> > >
>> > >     Thanks,
>> > >     Stefano
>> > >
>> > >     [1] https://lore.kernel.org/virtualization/20230424225031.18947-1-shannon.nelson@amd.com/
>> >
>> > I'm a bit lost here. So why am I merging "better PACKED support" then?
>>
>> To really support packed virtqueue with vhost-vdpa, at that point we would
>> also have to revert this patch.
>>
>> I wasn't sure if you wanted to queue the series for this merge window.
>> In that case do you think it is better to send this patch only for stable
>> branches?
>> > Does this patch make them a NOP?
>>
>> Yep, after applying the "better PACKED support" series and being sure 
>> that
>> the IOCTLs of vhost-vdpa support packed virtqueue, we should revert this
>> patch.
>>
>> Let me know if you prefer a different approach.
>>
>> I'm concerned that QEMU uses vhost-vdpa IOCTLs thinking that the kernel
>> interprets them the right way, when it does not.
>>
>> Thanks,
>> Stefano
>>
>
>If this fixes a bug can you add Fixes tags to each of them? Then it's ok
>to merge in this window. Probably easier than the elaborate
>mask/unmask dance.

CCing Shannon (the original author of the "better PACKED support"
series).

IIUC Shannon is going to send a v3 of that series to fix the
documentation, so Shannon can you also add the Fixes tags?

Thanks,
Stefano

