Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFA867FCFF
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 06:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjA2F5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 00:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjA2F5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 00:57:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883F922A18
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 21:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674971785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oSf6XZDVYNJk3cIc7xUh3xm95VMkiJ6FAi9/1U1AbRQ=;
        b=LKMM1GyOAFo0UzIR0kKQNkBXGehMDRyvxknNHzI3CB3NzjWqG9WaVxW9S9acaiP2zZE1Cp
        wS3yx5/Ar2an7v6p7jCjxWPPtal5IPKMwrCgGJuAZlbf5vKWudP6DzfUe9avQFWc6eLz7q
        BaLTHWP8SMH+pFhQMSS5CJm4UQmi970=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-671-HVbpR29tP8Ch3Vjiwp_mEQ-1; Sun, 29 Jan 2023 00:56:18 -0500
X-MC-Unique: HVbpR29tP8Ch3Vjiwp_mEQ-1
Received: by mail-pg1-f197.google.com with SMTP id h126-20020a636c84000000b004d31ad79086so3682672pgc.23
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 21:56:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oSf6XZDVYNJk3cIc7xUh3xm95VMkiJ6FAi9/1U1AbRQ=;
        b=QbbUAz9NVQTS20dhL2SfjrJYLhSDOhsbjBu7ZSKSKOfSH7QdHP82RNKtWdeYNGhlu4
         F23zHcR8pmPH6fnqk33tV/CoMUxunO089ulvJqk4hoqcaIT2OWl81LZPaqvyZtVTnjds
         jm8UWC4BYpF4VXNaax3y5XEraZmZggRMXdRAgu+Tn+VmlmNeyLf8KMeyzUZAp+5vJgGN
         CEYoyrQgYTxeMAmAT7iwK5Wnu0bMSHuPIEzPa4Qhy9JD0zmvk0TqaqQMEKd/OYhrlLUm
         qs5ieC8Cn38qLpt+n6YFWAv7nl8gcl/9e3w99B2Hr/O+9s4rQmC3P3h4Cq3cDMOG0Uub
         RIgw==
X-Gm-Message-State: AFqh2ko56XoUZpSm5fxUbw/4P9whaQ8om5alcEVgiJ0ntnLBc8+kv9XZ
        1kkRb2jWI1Ku7hqGcEH0Bwxks6oP7H/qP1UVjwiSVFng65NC7NFUpimI1qtFFJID/wD5Izu5hMW
        avHIteq124AIKa0DUXdE/pwh1
X-Received: by 2002:a17:90a:4bc2:b0:229:7b29:54ac with SMTP id u2-20020a17090a4bc200b002297b2954acmr46408815pjl.35.1674971776930;
        Sat, 28 Jan 2023 21:56:16 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtM+R0YBDYb3wyJgfTkGKuUFE6HcXh+c6aBlpjxk2FuGJ0r+w0P+ZWuUZUFyOUvMqVDCZlTGg==
X-Received: by 2002:a17:90a:4bc2:b0:229:7b29:54ac with SMTP id u2-20020a17090a4bc200b002297b2954acmr46408802pjl.35.1674971776696;
        Sat, 28 Jan 2023 21:56:16 -0800 (PST)
Received: from [10.72.13.13] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id n2-20020a17090a4e0200b00219463262desm5148749pjh.39.2023.01.28.21.56.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Jan 2023 21:56:16 -0800 (PST)
Message-ID: <1a1c8359-855d-7a05-686a-23935dcad5a9@redhat.com>
Date:   Sun, 29 Jan 2023 13:56:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 1/2] vdpa_sim: not reset state in vdpasim_queue_ready
Content-Language: en-US
To:     Eugenio Perez Martin <eperezma@redhat.com>
Cc:     mst@redhat.com, leiyang@redhat.com,
        Laurent Vivier <lvivier@redhat.com>, sgarzare@redhat.com,
        Zhu Lingshan <lingshan.zhu@intel.com>,
        virtualization@lists.linux-foundation.org, si-wei.liu@oracle.com,
        linux-kernel@vger.kernel.org, lulu@redhat.com,
        Gautam Dawar <gdawar@xilinx.com>, alvaro.karsz@solid-run.com
References: <20230118164359.1523760-1-eperezma@redhat.com>
 <20230118164359.1523760-2-eperezma@redhat.com>
 <CACGkMEt=po+FMEikgj3OXC7_QC=yhRP2Sx0NU=2sFPGgQ4bujA@mail.gmail.com>
 <CAJaqyWejkbiwKK4O0qOObdf294YrzMeSRTVoWNzv75yQCvkJqQ@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <CAJaqyWejkbiwKK4O0qOObdf294YrzMeSRTVoWNzv75yQCvkJqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/1/19 17:14, Eugenio Perez Martin 写道:
> On Thu, Jan 19, 2023 at 4:16 AM Jason Wang <jasowang@redhat.com> wrote:
>> On Thu, Jan 19, 2023 at 12:44 AM Eugenio Pérez <eperezma@redhat.com> wrote:
>>> vdpasim_queue_ready calls vringh_init_iotlb, which resets split indexes.
>>> But it can be called after setting a ring base with
>>> vdpasim_set_vq_state.
>>>
>>> Fix it by stashing them. They're still resetted in vdpasim_vq_reset.
>>>
>>> This was discovered and tested live migrating the vdpa_sim_net device.
>>>
>>> Fixes: 2c53d0f64c06 ("vdpasim: vDPA device simulator")
>>> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
>>> ---
>>>   drivers/vdpa/vdpa_sim/vdpa_sim.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>>> index cb88891b44a8..8839232a3fcb 100644
>>> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>>> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>>> @@ -66,6 +66,7 @@ static void vdpasim_vq_notify(struct vringh *vring)
>>>   static void vdpasim_queue_ready(struct vdpasim *vdpasim, unsigned int idx)
>>>   {
>>>          struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
>>> +       uint16_t last_avail_idx = vq->vring.last_avail_idx;
>>>
>>>          vringh_init_iotlb(&vq->vring, vdpasim->features, vq->num, false,
>>>                            (struct vring_desc *)(uintptr_t)vq->desc_addr,
>>> @@ -74,6 +75,7 @@ static void vdpasim_queue_ready(struct vdpasim *vdpasim, unsigned int idx)
>>>                            (struct vring_used *)
>>>                            (uintptr_t)vq->device_addr);
>>>
>>> +       vq->vring.last_avail_idx = last_avail_idx;
>> Does this need to be serialized with the datapath?
>>
>> E.g in set_vq_state() we do:
>>
>> spin_lock(&vdpasim->lock);
>> vrh->last_avail_idx = state->split.avail_index;
>> spin_unlock(&vdpasim->lock);
>>
> vdpasim_queue_ready is called from vdpasim_set_vq_ready, which holds
> these locks.
>
> Maybe it's too much indirection and to embed vdpasim_queue_ready in
> vdpasim_set_vq_ready would be clearer for the future?


Nope, I miss the caller.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


>
> Thanks!
>

