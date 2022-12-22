Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA73653B38
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 05:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235129AbiLVEVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 23:21:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235017AbiLVEUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 23:20:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FDC248C6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 20:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671682765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0mH3oOfXNbjXLHYuolZ32GbumyIJzP4ESKq36TBA8l8=;
        b=WFTLh5u25Av31+XIc0OXl2SpphmVLkWbuOlTEk+WNbOU9vJFub3tsJFRPc96Kdlbxp6PwA
        l0q9sDe0JXflqM2hKSANWC7Sg4aCDMgchlJODz0G8f9jMrM47stq0pPJurqppPaDBe1agP
        JA27nBFjoDpXFlHQkrgbpR9n0vMwKC4=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-22-bUgKwSqoPe2dG9Y_US_Fxw-1; Wed, 21 Dec 2022 23:19:23 -0500
X-MC-Unique: bUgKwSqoPe2dG9Y_US_Fxw-1
Received: by mail-pl1-f199.google.com with SMTP id i4-20020a17090332c400b0018f82951826so637436plr.20
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 20:19:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0mH3oOfXNbjXLHYuolZ32GbumyIJzP4ESKq36TBA8l8=;
        b=Nl4FHFUcea1mTFzbt5Nr4EHMATfxsxjwygnacejtOr+xZyWxpVd/bfAQac/5tjisTd
         6IhR9yqqeShvmtIcEtKcTVjSJBr87xCp9NvWLBnfZk0Bo2fCo/BZBQ35ThGCjlBHAA3V
         /fb25bq1Sd7sZTn6cOQM0xbKzo+hbahZkKT4XTqN55auIj5DNQ1RJ7fAhj+3qyPXnUBg
         qawlLPVYd2lca7tEy6SxMMehymzizm1qV23UarHR4EVwfVG3pPotCHDYrGSR8dzqzxSv
         p69puVyN+JzVcYeExYIraz7FQNy65OrpD4Ch+wUi0tmRL2lsxLK55tVUcRIi7xSEohFN
         AbuQ==
X-Gm-Message-State: AFqh2ko/jQYqDbkow91kgPJwAPnPbIRs1YgQEi61AcED/LbfseJSJvL9
        wUH3I00LMR9V0lNiH/dusLMPiZ2fOAYydIPxCo6HryfJnxDx7O+DrsfkxHe/yeG1NdA58sZVhcq
        ItHpDxS6bnQktLqtSLrzRFfZ3
X-Received: by 2002:aa7:96ec:0:b0:574:3b4e:1cbf with SMTP id i12-20020aa796ec000000b005743b4e1cbfmr4892995pfq.6.1671682762518;
        Wed, 21 Dec 2022 20:19:22 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuKWT574oUOFYNCMz80T1Z1j80xvWLo+SP9Aqhw3A+inWm0X9J2tfCjbK+qrt2KsSY5h33Dpw==
X-Received: by 2002:aa7:96ec:0:b0:574:3b4e:1cbf with SMTP id i12-20020aa796ec000000b005743b4e1cbfmr4892982pfq.6.1671682762208;
        Wed, 21 Dec 2022 20:19:22 -0800 (PST)
Received: from [10.72.13.15] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id i22-20020aa796f6000000b0057630286100sm11183084pfq.164.2022.12.21.20.19.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 20:19:21 -0800 (PST)
Message-ID: <11aa3331-a262-bc97-193c-d1c9a9214541@redhat.com>
Date:   Thu, 22 Dec 2022 12:19:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [PATCH 3/4] vdpa_sim: support vendor satistics
Content-Language: en-US
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     mst@redhat.com, eperezma@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20221221061652.15202-1-jasowang@redhat.com>
 <20221221061652.15202-4-jasowang@redhat.com>
 <20221221133414.teizf56exrf5tqvj@sgarzare-redhat>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20221221133414.teizf56exrf5tqvj@sgarzare-redhat>
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


在 2022/12/21 21:34, Stefano Garzarella 写道:
> On Wed, Dec 21, 2022 at 02:16:51PM +0800, Jason Wang wrote:
>
> Little typo in the title s/satistics/statistics


Fixed.


>
>> This patch adds a new config ops callback to allow individual
>> simulator to implement the vendor stats callback.
>>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> ---
>> drivers/vdpa/vdpa_sim/vdpa_sim.c | 13 +++++++++++++
>> drivers/vdpa/vdpa_sim/vdpa_sim.h |  3 +++
>> 2 files changed, 16 insertions(+)
>>
>> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c 
>> b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> index 55aaa023a6e2..02e892f819e7 100644
>> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> @@ -426,6 +426,18 @@ static int vdpasim_get_vq_state(struct 
>> vdpa_device *vdpa, u16 idx,
>>     return 0;
>> }
>>
>> +static int vdpasim_get_vq_stats(struct vdpa_device *vdpa, u16 idx,
>> +                struct sk_buff *msg,
>> +                struct netlink_ext_ack *extack)
>> +{
>> +    struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
>> +
>> +    if (vdpasim->dev_attr.get_stats)
>> +        return vdpasim->dev_attr.get_stats(vdpasim, idx,
>> +                           msg, extack);
>> +    return -EINVAL;
>
> Maybe -EOPNOTSUPP is better when the device doesn't support it.
> Like we do in vendor_stats_fill() in drivers/vdpa/vdpa.c
>

That's right.


>> +}
>> +
>> static u32 vdpasim_get_vq_align(struct vdpa_device *vdpa)
>> {
>>     return VDPASIM_QUEUE_ALIGN;
>> @@ -710,6 +722,7 @@ static const struct vdpa_config_ops 
>> vdpasim_config_ops = {
>>     .set_vq_ready           = vdpasim_set_vq_ready,
>>     .get_vq_ready           = vdpasim_get_vq_ready,
>>     .set_vq_state           = vdpasim_set_vq_state,
>> +    .get_vendor_vq_stats    = vdpasim_get_vq_stats,
>
> Should we add this callback also in vdpasim_batch_config_ops?


Yes.

Thanks


>
> Thanks,
> Stefano
>
>>     .get_vq_state           = vdpasim_get_vq_state,
>>     .get_vq_align           = vdpasim_get_vq_align,
>>     .get_vq_group           = vdpasim_get_vq_group,
>> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h 
>> b/drivers/vdpa/vdpa_sim/vdpa_sim.h
>> index 51c070a543f1..d2a08c0abad7 100644
>> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
>> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
>> @@ -48,6 +48,9 @@ struct vdpasim_dev_attr {
>>     work_func_t work_fn;
>>     void (*get_config)(struct vdpasim *vdpasim, void *config);
>>     void (*set_config)(struct vdpasim *vdpasim, const void *config);
>> +    int (*get_stats)(struct vdpasim *vdpasim, u16 idx,
>> +             struct sk_buff *msg,
>> +             struct netlink_ext_ack *extack);
>> };
>>
>> /* State of each vdpasim device */
>> -- 
>> 2.25.1
>>
>

