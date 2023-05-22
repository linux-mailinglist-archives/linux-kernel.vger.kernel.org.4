Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95FB70BC0E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 13:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbjEVLme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 07:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjEVLmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 07:42:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D9899
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 04:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684755708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XCoVn7ppCsfW0w+/vJ+0bLvd9vkfTR1n6Nckl2ntEFY=;
        b=SbWRYfGiYC9J5SfGc9zj54tIiE17JCzi2cAcdDQ59iAxu6JN1yLlWNG0SncU0yInX111Nk
        R4bViAmHbq+MB7pt3K9ryuZGWmfqUIKwK85+VmFv7s7zlyWgckgQJIxfNYvSXNwJfM8dhb
        Yr/VrvomBmeWG/O6ob+EvZ2MKYRXqYo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-D-IlCjihOSyyuJuqDv__gw-1; Mon, 22 May 2023 07:41:47 -0400
X-MC-Unique: D-IlCjihOSyyuJuqDv__gw-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-510ddadbec6so5900759a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 04:41:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684755706; x=1687347706;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XCoVn7ppCsfW0w+/vJ+0bLvd9vkfTR1n6Nckl2ntEFY=;
        b=gIpnA9/S+X6oqWaICYQX7kDx/Hi3tJUdsLVvCin/6yaaQjtRD5E8j5IF2NH/Eu933B
         5zmQC3+sa8ROZ9MkJFiwx+2UoU+411AcDTUfPpO6wzNIMh6oWDCQo4Pz4iYu8xKtaZzU
         8mHlQefl1YHFqUa+CPs2I5GZ4K8Elptgi9Sd/aX6VljG754Wc43agSsfUMweKh6fpVhu
         sTU7ec0il+haw8Rm0vFXTM0JuBCjK8X7clhlCDVXPwEDi+hScpPj9O9k3+zMYYvJeJLm
         0b2YBI74THAWarTXvTXWzAPCelhY8cEaSITt2CohDNR6qeojPEjl/guWK56VFmUEcRfv
         n7Cw==
X-Gm-Message-State: AC+VfDy4YlkvIugTB7cwoqsKGVJZmfvvNaNWvO7QswIiPGdADvDJG707
        Z/4Lb3cxmDrDG/l+7tWrFaLZURWVxONBLneSvfpao8R0M/DC/9ksXQTMW/XxyyZA5/uMDFZTHY/
        Gc3tGtpY4qqovyKjzCdaYMZUD
X-Received: by 2002:a17:906:db0d:b0:94f:1a23:2f1b with SMTP id xj13-20020a170906db0d00b0094f1a232f1bmr8806489ejb.24.1684755706369;
        Mon, 22 May 2023 04:41:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7kEr9SuDqWiEbnZsnBzZAAHBZaLG94azZPqviwtKlo0EM0qZLnGpvhLrmWW6uacj8eI75lGg==
X-Received: by 2002:a17:906:db0d:b0:94f:1a23:2f1b with SMTP id xj13-20020a170906db0d00b0094f1a232f1bmr8806456ejb.24.1684755706071;
        Mon, 22 May 2023 04:41:46 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id lx19-20020a170906af1300b0094f07545d40sm2980019ejb.220.2023.05.22.04.41.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 04:41:45 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <fed6ef09-0f5b-8c3d-0484-bb0995d09282@redhat.com>
Date:   Mon, 22 May 2023 13:41:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc:     brouer@redhat.com, Larysa Zaremba <larysa.zaremba@intel.com>,
        bpf@vger.kernel.org, Stanislav Fomichev <sdf@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Anatoly Burakov <anatoly.burakov@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
        netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND bpf-next 14/15] net, xdp: allow metadata > 32
Content-Language: en-US
To:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Jesper Dangaard Brouer <jbrouer@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>
References: <20230512152607.992209-1-larysa.zaremba@intel.com>
 <20230512152607.992209-15-larysa.zaremba@intel.com>
 <ee1ad4f2-34ab-4377-14d5-532cb0687180@redhat.com> <ZGJnFxzDTV2qE4zZ@lincoln>
 <b9a879b2-bb62-ba18-0bdd-5c126a1086a9@intel.com>
 <a37db72f-2e83-c838-7c81-8f01a5a0df32@redhat.com>
 <5b817d49-eefa-51c9-3b51-01f1dba17d42@intel.com>
In-Reply-To: <5b817d49-eefa-51c9-3b51-01f1dba17d42@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/05/2023 18.35, Alexander Lobakin wrote:
> From: Jesper Dangaard Brouer <jbrouer@redhat.com>
> Date: Tue, 16 May 2023 17:35:27 +0200
> 
>>
>> On 16/05/2023 14.37, Alexander Lobakin wrote:
>>> From: Larysa Zaremba<larysa.zaremba@intel.com>
>>> Date: Mon, 15 May 2023 19:08:39 +0200
>>>
>>>> On Mon, May 15, 2023 at 06:17:02PM +0200, Jesper Dangaard Brouer wrote:
>>>>>
>>>>> On 12/05/2023 17.26, Larysa Zaremba wrote:
>>>>>> From: Aleksander Lobakin<aleksander.lobakin@intel.com>
>>>>>>
>>>>>> When using XDP hints, metadata sometimes has to be much bigger
>>>>>> than 32 bytes. Relax the restriction, allow metadata larger than 32
>>>>>> bytes
>>>>>> and make __skb_metadata_differs() work with bigger lengths.
>>>>>>
>>>>>> Now size of metadata is only limited by the fact it is stored as u8
>>>>>> in skb_shared_info, so maximum possible value is 255.
>>>>>
>>>>> I'm confused, IIRC the metadata area isn't stored "in skb_shared_info".
>>>>> The maximum possible size is limited by the XDP headroom, which is also
>>>>> shared/limited with/by xdp_frame.  I must be reading the sentence
>>>>> wrong,
>>>>> somehow.
>>>
>>> skb_shared_info::meta_size  is u8. Since metadata gets carried from
>>> xdp_buff to skb, this check is needed (it's compile-time constant
>>> anyway).
>>> Check for headroom is done separately already (two sentences below).
>>>
>>
>> Damn, argh, for SKBs the "meta_len" is stored in skb_shared_info, which
>> is located on another cacheline.
>> That is a sure way to KILL performance! :-(
> 
> Have you read the code? I use type_max(typeof_member(shinfo, meta_len)),
> what performance are you talking about?
> 

Not talking about your changes (in this patch).

I'm realizing that SKBs using metadata area will have a performance hit
due to accessing another cacheline (the meta_len in skb_shared_info).

IIRC Daniel complained about this performance hit (in the past), I guess
this explains it.  IIRC Cilium changed to use percpu variables/datastore
to workaround this.


> The whole xdp_metalen_invalid() gets expanded into:
> 
> 	return (metalen % 4) || metalen > 255;
> 
> at compile-time. All those typeof shenanigans are only to not open-code
> meta_len's type/size/max.
> 
>>
>> But only use for SKBs that gets created from xdp with metadata, right?
>>

Normal netstack processing actually access this skb_shinfo->meta_len in
gro_list_prepare().  As the caller dev_gro_receive() later access other
memory in skb_shared_info, then the GRO code path already takes this hit
to begin with.

--Jesper

