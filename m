Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C4D727B1F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 11:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234451AbjFHJWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 05:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbjFHJWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 05:22:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64AEE50
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 02:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686216104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wciZzZhI8oXg7Yuw9Rr2DJCHC9/Z7EBEfdGZiOUWtDk=;
        b=QvbtiS/u4/+fVoSgZak7eaY1xwc7QoRGvLGl+vUfu7QbyuLP4NjvBVuwW72EPOKsc8Y76h
        +o+eNDVoVydQcZQD7wnf7IWDP8qbuqnWzNsa7yR8Wkzq2QRb/AzyYYmdDZUb8RkzksyjKL
        Eac6pRw92u//+37F67bbei3ikIKJd3k=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-rCB7PvHyMOWgrma-LV4QMQ-1; Thu, 08 Jun 2023 05:21:42 -0400
X-MC-Unique: rCB7PvHyMOWgrma-LV4QMQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-75d5588d7e9so55073585a.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 02:21:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686216102; x=1688808102;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wciZzZhI8oXg7Yuw9Rr2DJCHC9/Z7EBEfdGZiOUWtDk=;
        b=Nqi+JaACda8nZPApe4/QW8KZvkRB2VRSe4Zl2OkLiaBt4Qwennb8WyKJdz4FNjHtgo
         LiMFh6IqB6ywviMBSXpstkdykOOQ4EgU7bhmspghTG1AYQpae1hmLVnTBb0uy3Z/uvXY
         S07D2El9y6ArGi1aTvoouTOfxn0beyRGpO6VRW+1ZWgDdQHIAtJhPL6AFQYx+FwHbuPM
         fmjNzHxudX9QcvHAiZHr1bMPRUUA0p2cP4jcShIk5kKcSNyFRVzxaOaPjnc87d/3kvpQ
         sG3SNjkGJsWg58ehQXtm7j+8rOVxEH4VKi75U2ACqo94VPr2eBF1Jf8trnA11nC5qA+f
         RLdw==
X-Gm-Message-State: AC+VfDxh6t/I4XbzEag13I70pRXD/7fiKr5DZqCBWL7wYyF4RofwUiYV
        fQSQWOjU3UYZfXDTxH2tfsATZE6B6e2VgcmG3UXYlV4QyEPWJEkriD7sA2a2hsILzribyT7y1Zo
        G51swxgeVFfHDSCjM0PZ3pnEK
X-Received: by 2002:a05:620a:8395:b0:75b:23a1:3668 with SMTP id pb21-20020a05620a839500b0075b23a13668mr4482009qkn.41.1686216102501;
        Thu, 08 Jun 2023 02:21:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4bhyfn7UJWLUNBv8vKAKxl3tIW7+FDTT6J28VyZbWi/o5E0G9yWUmjDAKtkWbyk9CcvIR9Vg==
X-Received: by 2002:a05:620a:8395:b0:75b:23a1:3668 with SMTP id pb21-20020a05620a839500b0075b23a13668mr4481995qkn.41.1686216102220;
        Thu, 08 Jun 2023 02:21:42 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-111.business.telecomitalia.it. [87.12.25.111])
        by smtp.gmail.com with ESMTPSA id g9-20020a05620a13c900b007463509f94asm201231qkl.55.2023.06.08.02.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 02:21:41 -0700 (PDT)
Date:   Thu, 8 Jun 2023 11:21:36 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Shannon Nelson <shannon.nelson@amd.com>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
        Tiwei Bie <tiwei.bie@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost-vdpa: filter VIRTIO_F_RING_PACKED feature
Message-ID: <lw3nmkdszqo6jjtneyp4kjlmutooozz7xj2fqyxgh4v2ralptc@vkimgnbfafvi>
References: <32ejjuvhvcicv7wjuetkv34qtlpa657n4zlow4eq3fsi2twozk@iqnd2t5tw2an>
 <CACGkMEu3PqQ99UoKF5NHgVADD3q=BF6jhLiyumeT4S1QCqN1tw@mail.gmail.com>
 <20230606085643-mutt-send-email-mst@kernel.org>
 <CAGxU2F7fkgL-HpZdj=5ZEGNWcESCHQpgRAYQA3W2sPZaoEpNyQ@mail.gmail.com>
 <20230607054246-mutt-send-email-mst@kernel.org>
 <CACGkMEuUapKvUYiJiLwtsN+x941jafDKS9tuSkiNrvkrrSmQkg@mail.gmail.com>
 <20230608020111-mutt-send-email-mst@kernel.org>
 <CACGkMEt4=3BRVNX38AD+mJU8v3bmqO-CdNj5NkFP-SSvsuy2Hg@mail.gmail.com>
 <5giudxjp6siucr4l3i4tggrh2dpqiqhhihmdd34w3mq2pm5dlo@mrqpbwckpxai>
 <CACGkMEtqn1dbrQZn3i-W_7sVikY4sQjwLRC5xAhMnyqkc3jwOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEtqn1dbrQZn3i-W_7sVikY4sQjwLRC5xAhMnyqkc3jwOw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 05:00:00PM +0800, Jason Wang wrote:
>On Thu, Jun 8, 2023 at 4:00 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> On Thu, Jun 08, 2023 at 03:46:00PM +0800, Jason Wang wrote:
>>
>> [...]
>>
>> >> > > > > I have a question though, what if down the road there
>> >> > > > > is a new feature that needs more changes? It will be
>> >> > > > > broken too just like PACKED no?
>> >> > > > > Shouldn't vdpa have an allowlist of features it knows how
>> >> > > > > to support?
>> >> > > >
>> >> > > > It looks like we had it, but we took it out (by the way, we were
>> >> > > > enabling packed even though we didn't support it):
>> >> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6234f80574d7569444d8718355fa2838e92b158b
>> >> > > >
>> >> > > > The only problem I see is that for each new feature we have to modify
>> >> > > > the kernel.
>> >> > > > Could we have new features that don't require handling by vhost-vdpa?
>> >> > > >
>> >> > > > Thanks,
>> >> > > > Stefano
>> >> > >
>> >> > > Jason what do you say to reverting this?
>> >> >
>> >> > I may miss something but I don't see any problem with vDPA core.
>> >> >
>> >> > It's the duty of the parents to advertise the features it has. For example,
>> >> >
>> >> > 1) If some kernel version that is packed is not supported via
>> >> > set_vq_state, parents should not advertise PACKED features in this
>> >> > case.
>> >> > 2) If the kernel has support packed set_vq_state(), but it's emulated
>> >> > cvq doesn't support, parents should not advertise PACKED as well
>> >> >
>> >> > If a parent violates the above 2, it looks like a bug of the parents.
>> >> >
>> >> > Thanks
>> >>
>> >> Yes but what about vhost_vdpa? Talking about that not the core.
>> >
>> >Not sure it's a good idea to workaround parent bugs via vhost-vDPA.
>>
>> Sorry, I'm getting lost...
>> We were talking about the fact that vhost-vdpa doesn't handle
>> SET_VRING_BASE/GET_VRING_BASE ioctls well for packed virtqueue before
>> that series [1], no?
>>
>> The parents seem okay, but maybe I missed a few things.
>>
>> [1] https://lore.kernel.org/virtualization/20230424225031.18947-1-shannon.nelson@amd.com/
>
>Yes, more below.
>
>>
>> >
>> >> Should that not have a whitelist of features
>> >> since it interprets ioctls differently depending on this?
>> >
>> >If there's a bug, it might only matter the following setup:
>> >
>> >SET_VRING_BASE/GET_VRING_BASE + VDUSE.
>> >
>> >This seems to be broken since VDUSE was introduced. If we really want
>> >to backport something, it could be a fix to filter out PACKED in
>> >VDUSE?
>>
>> mmm it doesn't seem to be a problem in VDUSE, but in vhost-vdpa.
>> I think VDUSE works fine with packed virtqueue using virtio-vdpa
>> (I haven't tried), so why should we filter PACKED in VDUSE?
>
>I don't think we need any filtering since:
>
>PACKED features has been advertised to userspace via uAPI since
>6234f80574d7569444d8718355fa2838e92b158b. Once we relax in uAPI, it
>would be very hard to restrict it again. For the userspace that tries
>to negotiate PACKED:
>
>1) if it doesn't use SET_VRING_BASE/GET_VRING_BASE, everything works well
>2) if it uses SET_VRING_BASE/GET_VRING_BASE. it might fail or break silently
>
>If we backport the fixes to -stable, we may break the application at
>least in the case 1).

Okay, I see now, thanks for the details!

Maybe instead of "break silently", we can return an explicit error for
SET_VRING_BASE/GET_VRING_BASE in stable branches.
But if there are not many cases, we can leave it like that.

I was just concerned about how does the user space understand that it
can use SET_VRING_BASE/GET_VRING_BASE for PACKED virtqueues in a given
kernel or not.

Thanks,
Stefano

