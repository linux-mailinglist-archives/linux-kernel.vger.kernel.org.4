Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4DF2727972
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 10:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234645AbjFHIBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 04:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234461AbjFHIBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 04:01:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299F02D45
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 01:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686211212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FNDbmGsJ3mpkLEzox86FiotwEXbzoL7gRModpMEFp+s=;
        b=egynQLebi2sH3JBGuZpLXxM6hNkNgGa+JZL4uCkdVoY7PQ4zrq3VBbRlHs5sEFvOyMGHfF
        8JNhH9sXOkbZLJ6sDZ4fP0ebqSm5YQkcirWdvSBT6TX5LBYQqJJQ6g4R+4dmc8vbpHJogs
        89Ox/7EKDAzRf1z/PlQV+J/ucc8BNh0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-6g0q23ysNUWt0h5uFNptLg-1; Thu, 08 Jun 2023 04:00:11 -0400
X-MC-Unique: 6g0q23ysNUWt0h5uFNptLg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-977c8170b52so51641866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 01:00:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686211210; x=1688803210;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FNDbmGsJ3mpkLEzox86FiotwEXbzoL7gRModpMEFp+s=;
        b=dAXdz2GvRgPpRmVqOG9BW+RU1qJqawFtKQ15H4hBrk/Ou+9dIrm6H27rqSxf60+f0A
         GHhKcEaFkkSOftibx00VzIuvixDqeAlRMP697uEclBNUridctmFhvoKAJ837esu0/HkJ
         S8kDUd8tn+h2UsE+k5PoEmu8530F3MdVTK08pGixTnFqadsTJpf/JEUXJ8/IKRN2yt8P
         zyMyFhpPbRMvAwAESllIpa5rYvCsko0V6NX+ys9DIrCUCi8upM0REWi/iCqStfC0wUGc
         aJ+Oq62unA69rV+JYmcYQYdg6z5BmydDrbIrj6iVq/QGfYD2jrFEAEa94P0g0K8/CdHx
         5eXg==
X-Gm-Message-State: AC+VfDxpvHEKydOetttbz9sJLryYjm9Kk8CqGu9a3+AQYmdO4HYrZl1K
        kvro3XS66YAxxwapkjbjZaNp8js2Y8zWqY86KyPF0B1eSW25vHCARKWD93rTCktrp7zGUYoxHKs
        2b77H3hPOo8uCWkYTsWKngXZT
X-Received: by 2002:a17:907:e92:b0:978:9b09:ccaf with SMTP id ho18-20020a1709070e9200b009789b09ccafmr1684181ejc.14.1686211209896;
        Thu, 08 Jun 2023 01:00:09 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4iYx/Ymtxl9ZzpcCCqLWJ3wFdcVDKXynlxsTc5fgKIP2plln1Gn+TgS5Yvth3Zl/mptkx4nQ==
X-Received: by 2002:a17:907:e92:b0:978:9b09:ccaf with SMTP id ho18-20020a1709070e9200b009789b09ccafmr1684157ejc.14.1686211209532;
        Thu, 08 Jun 2023 01:00:09 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-111.business.telecomitalia.it. [87.12.25.111])
        by smtp.gmail.com with ESMTPSA id jt26-20020a170906dfda00b00978993e0d21sm351480ejc.78.2023.06.08.01.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 01:00:08 -0700 (PDT)
Date:   Thu, 8 Jun 2023 09:59:49 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Shannon Nelson <shannon.nelson@amd.com>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
        Tiwei Bie <tiwei.bie@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost-vdpa: filter VIRTIO_F_RING_PACKED feature
Message-ID: <5giudxjp6siucr4l3i4tggrh2dpqiqhhihmdd34w3mq2pm5dlo@mrqpbwckpxai>
References: <gi2hngx3ndsgz5d2rpqjywdmou5vxhd7xgi5z2lbachr7yoos4@kpifz37oz2et>
 <20230605095404-mutt-send-email-mst@kernel.org>
 <32ejjuvhvcicv7wjuetkv34qtlpa657n4zlow4eq3fsi2twozk@iqnd2t5tw2an>
 <CACGkMEu3PqQ99UoKF5NHgVADD3q=BF6jhLiyumeT4S1QCqN1tw@mail.gmail.com>
 <20230606085643-mutt-send-email-mst@kernel.org>
 <CAGxU2F7fkgL-HpZdj=5ZEGNWcESCHQpgRAYQA3W2sPZaoEpNyQ@mail.gmail.com>
 <20230607054246-mutt-send-email-mst@kernel.org>
 <CACGkMEuUapKvUYiJiLwtsN+x941jafDKS9tuSkiNrvkrrSmQkg@mail.gmail.com>
 <20230608020111-mutt-send-email-mst@kernel.org>
 <CACGkMEt4=3BRVNX38AD+mJU8v3bmqO-CdNj5NkFP-SSvsuy2Hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CACGkMEt4=3BRVNX38AD+mJU8v3bmqO-CdNj5NkFP-SSvsuy2Hg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 03:46:00PM +0800, Jason Wang wrote:

[...]

>> > > > > I have a question though, what if down the road there
>> > > > > is a new feature that needs more changes? It will be
>> > > > > broken too just like PACKED no?
>> > > > > Shouldn't vdpa have an allowlist of features it knows how
>> > > > > to support?
>> > > >
>> > > > It looks like we had it, but we took it out (by the way, we were
>> > > > enabling packed even though we didn't support it):
>> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6234f80574d7569444d8718355fa2838e92b158b
>> > > >
>> > > > The only problem I see is that for each new feature we have to modify
>> > > > the kernel.
>> > > > Could we have new features that don't require handling by vhost-vdpa?
>> > > >
>> > > > Thanks,
>> > > > Stefano
>> > >
>> > > Jason what do you say to reverting this?
>> >
>> > I may miss something but I don't see any problem with vDPA core.
>> >
>> > It's the duty of the parents to advertise the features it has. For example,
>> >
>> > 1) If some kernel version that is packed is not supported via
>> > set_vq_state, parents should not advertise PACKED features in this
>> > case.
>> > 2) If the kernel has support packed set_vq_state(), but it's emulated
>> > cvq doesn't support, parents should not advertise PACKED as well
>> >
>> > If a parent violates the above 2, it looks like a bug of the parents.
>> >
>> > Thanks
>>
>> Yes but what about vhost_vdpa? Talking about that not the core.
>
>Not sure it's a good idea to workaround parent bugs via vhost-vDPA.

Sorry, I'm getting lost...
We were talking about the fact that vhost-vdpa doesn't handle
SET_VRING_BASE/GET_VRING_BASE ioctls well for packed virtqueue before
that series [1], no?

The parents seem okay, but maybe I missed a few things.

[1] https://lore.kernel.org/virtualization/20230424225031.18947-1-shannon.nelson@amd.com/

>
>> Should that not have a whitelist of features
>> since it interprets ioctls differently depending on this?
>
>If there's a bug, it might only matter the following setup:
>
>SET_VRING_BASE/GET_VRING_BASE + VDUSE.
>
>This seems to be broken since VDUSE was introduced. If we really want
>to backport something, it could be a fix to filter out PACKED in
>VDUSE?

mmm it doesn't seem to be a problem in VDUSE, but in vhost-vdpa.
I think VDUSE works fine with packed virtqueue using virtio-vdpa
(I haven't tried), so why should we filter PACKED in VDUSE?

Thanks,
Stefano

