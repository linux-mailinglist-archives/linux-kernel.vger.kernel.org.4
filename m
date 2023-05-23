Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509FF70DA27
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 12:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236499AbjEWKRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 06:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbjEWKRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 06:17:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E344109
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 03:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684837012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SQHqTwIHdnGAuCc0miU9eDOkQpjo2/mk/8AwQvJchQc=;
        b=UB3UCMZEBx11i4AAMCJM5McDS/Qsg1rBZW9k79NtaUEpj4l+t0jM36ADIHnFvdf15HiDVO
        Hdkf4G/T1xrI0weLHxlo5HhaFqAdPzCG6qss23nOf4XQB9IQs9MLIP8ryY+BmWZ3/XSwPG
        72Ijo8r839Y5kOapQPzpvCl9q7uzi24=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-4AP2RNOdMX6kfCOpaKtGtQ-1; Tue, 23 May 2023 06:16:51 -0400
X-MC-Unique: 4AP2RNOdMX6kfCOpaKtGtQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9715654aba1so80922066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 03:16:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684837010; x=1687429010;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SQHqTwIHdnGAuCc0miU9eDOkQpjo2/mk/8AwQvJchQc=;
        b=YNbaWayXdooYCpD5WKtErP4e6rWQq1lnZbLY/cicySVvua9WbBm8zuWNrgVriLRr05
         jsJABPXkRywgqeKylZY35pxZC/IFWuQA45fUr/uA1Hnpi1L4DaEtxiLU7DIqckJKaSE/
         bxydJLDD04mXhXdkVov/TGn62Q1pXpWAqJH0TQ/YRET3kfABJ34IgASzK5pz4GeFQrcg
         SlOMMQuuObTSnfDXbmdG6QwMWJmasX0vIjujYZBalaRNQx0ocYXS9brGx89JAcs/4QZw
         YDDkBwwQqLI7lR8z8x6dKxGMt6+4VO/hhpKYRvRAHqFBhhLIm/E7ZkSl3AptEJ7JFAmI
         CX+A==
X-Gm-Message-State: AC+VfDyGVBh25wlPpNtWeUT0zagZoEyrJy/8f6tigb/HeoOymqSOlVUg
        Wbi8Ui6ncK4NnPU8cc1Y6RjNsbkyeeHF742pfQSVvVVf6EH/T12LZIGU0OcH9a9avOsW3GC7Chv
        8DQhJQgFwGGUIVm5EVLUW02Kf
X-Received: by 2002:a17:907:ea9:b0:96a:2b4:eb69 with SMTP id ho41-20020a1709070ea900b0096a02b4eb69mr13393998ejc.31.1684837009827;
        Tue, 23 May 2023 03:16:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ49yhK/BvmMprUo2opyxIyuZkHK27opbVXPXsLNZq65QZvQ3zkJiQT66NAQMp6+0niQu0jLDQ==
X-Received: by 2002:a17:907:ea9:b0:96a:2b4:eb69 with SMTP id ho41-20020a1709070ea900b0096a02b4eb69mr13393965ejc.31.1684837009526;
        Tue, 23 May 2023 03:16:49 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id s22-20020a170906961600b0096f89c8a2f7sm4209255ejx.90.2023.05.23.03.16.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 03:16:48 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <1693e3e3-c486-80c8-aec0-cca0c9080c34@redhat.com>
Date:   Tue, 23 May 2023 12:16:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc:     brouer@redhat.com, bpf@vger.kernel.org,
        Stanislav Fomichev <sdf@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
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
Subject: Re: [PATCH RESEND bpf-next 09/15] xdp: Add VLAN tag hint
Content-Language: en-US
To:     Larysa Zaremba <larysa.zaremba@intel.com>,
        Jesper Dangaard Brouer <jbrouer@redhat.com>
References: <20230512152607.992209-1-larysa.zaremba@intel.com>
 <20230512152607.992209-10-larysa.zaremba@intel.com>
 <b0694577-e2b3-f6de-cf85-aed99fdf2496@redhat.com> <ZGJZU89AK/3mFZXW@lincoln>
 <094f3178-2797-e297-64f8-aa0f7ef16b5f@redhat.com> <ZGuO6Hk+NcdL9iwi@lincoln>
In-Reply-To: <ZGuO6Hk+NcdL9iwi@lincoln>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 22/05/2023 17.48, Larysa Zaremba wrote:
> On Mon, May 22, 2023 at 10:37:33AM +0200, Jesper Dangaard Brouer wrote:
>>
>>
>> On 15/05/2023 18.09, Larysa Zaremba wrote:
>>> On Mon, May 15, 2023 at 05:36:12PM +0200, Jesper Dangaard Brouer wrote:
>>>>
>>>>
>>>> On 12/05/2023 17.26, Larysa Zaremba wrote:
>>>>> Implement functionality that enables drivers to expose VLAN tag
>>>>> to XDP code.
>>>>>
>>>>> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
>>>>> ---
>>>> [...]
>>>>
>>>>> diff --git a/net/core/xdp.c b/net/core/xdp.c
>>>>> index 41e5ca8643ec..eff21501609f 100644
>>>>> --- a/net/core/xdp.c
>>>>> +++ b/net/core/xdp.c
>>>>> @@ -738,6 +738,30 @@ __bpf_kfunc int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32 *hash,
>>>>>     	return -EOPNOTSUPP;
>>>>>     }
>>>>
>>>> Remember below becomes part of main documentation on HW metadata hints:
>>>>    - https://kernel.org/doc/html/latest/networking/xdp-rx-metadata.html
>>>>
>>>> Hint compiling locally I use:
>>>>    make SPHINXDIRS="networking" htmldocs
>>>>
>>>>> +/**
>>>>> + * bpf_xdp_metadata_rx_ctag - Read XDP packet inner vlan tag.
>>>>
>>>> Is bpf_xdp_metadata_rx_ctag a good function name for the inner vlan tag?
>>>> Like wise below "stag".
>>>>
>>>> I cannot remember if the C-tag or S-tag is the inner or outer vlan tag.
>>>>
>>>> When reading BPF code that use these function names, then I would have
>>>> to ask Google for help, or find-and-read this doc.
>>>>
>>>> Can we come-up with a more intuitive name, that e.g. helps when reading
>>>> the BPF-prog code?
>>>
>>> Well, my reasoning for such naming is that if someone can configure s-tag
>>> stripping in ethtool with 'rx-vlan-stag-hw-parse', they shouldn't have any
>>> problem with understanding those function names.
>>>
>>
>> Naming is hard.  My perspective is conveying the meaning without having
>> to be knowledgeable about ethtool VLAN commands.  My perspective is a
>> casual BPF-programmer that reads "bpf_xdp_metadata_rx_stag()".
>> Hopefully we can choose a name that says "vlan" somewhere, such that the
>> person reading this doesn't have to lookup and find the documentation to
>> deduct this code is related to VLANs.
>>
>>> One possible improvement that comes to mind is maybe (similarly ethtool) calling
>>> c-tag just 'tag' and letting s-tag stay 'stag'. Because c-tag is this default
>>> 802.1q tag, which is supported by various hardware, while s-tag is significantly
>>> less widespread.
>>>
>>> But there are many options, really.
>>>
>>> What are your suggestions?
>>>
>>
>> One suggestion is (the symmetrical):
>>   * bpf_xdp_metadata_rx_vlan_inner_tag
>>   * bpf_xdp_metadata_rx_vlan_outer_tag
>>
>> As you say above the first "inner" VLAN tag is just the regular 802.1Q
>> VLAN tag.  The concept of C-tag and S-tag is from 802.1ad that
>> introduced the concept of double tagging.
>>
>> Thus one could argue for shorter names like:
>>   * bpf_xdp_metadata_rx_vlan_tag
>>   * bpf_xdp_metadata_rx_vlan_outer_tag
>>
> 
> AFAIK, outer tag is a broader term, it's pretty often used for stacked 802.1Q
> headers. I can't find what exactly is an expected behavior for rxvlan and
> rx-vlan-stag-hw-parse in ethtool, but iavf documentation states that rxvlan
> "enables outer or single 802.1Q VLAN stripping" and rx-vlan-stag-hw-parse
> "enables outer or single 802.1ad VLAN stripping". This is in consistent with how
> ice hardware behaves. More credible sources would be welcome.
> 

It would be good to figure out how other hardware behaves.

The iavf doc sounds like very similar behavior from both functions, just 
802.1Q vs 802.1ad.
Sounds like both will just pop/strip the outer vlan tag.
I have seen Ethertype 802.1Q being used (in practice) for double tagged
packets, even-though 802.1ad should have been used to comply with the
standard.

> What about:
>    * bpf_xdp_metadata_rx_vlan_tag
>    * bpf_xdp_metadata_rx_vlan_qinq_tag
> 

This sounds good to me.

I do wonder if we really need two functions for this?
Would one function be enough?

Given the (iavf) description, the functions basically does the same.
Looking at your ice driver implementation, they could be merged into one
function, as it is the same location in the descriptor.

>>
>>>>
>>>>> + * @ctx: XDP context pointer.
>>>>> + * @vlan_tag: Return value pointer.
>>>>> + *
>>>>
>>>> IMHO right here, there should be a description.
>>>>
>>>> E.g. for what a VLAN "tag" means.  I assume a "tag" isn't the VLAN id,
>>>> but the raw VLAN tag that also contains the prio numbers etc.
>>>>
>>>> It this VLAN tag expected to be in network-byte-order ?
>>>> IMHO this doc should define what is expected (and driver devel must
>>>> follow this).
>>>
>>> Will specify that.
>>>
>>>>
>>>>> + * Returns 0 on success or ``-errno`` on error.
>>>>> + */
>>>>> +__bpf_kfunc int bpf_xdp_metadata_rx_ctag(const struct xdp_md *ctx, u16 *vlan_tag)
>>>>> +{
>>>>> +	return -EOPNOTSUPP;
>>>>> +}
>>>>> +
>>>>> +/**
>>>>> + * bpf_xdp_metadata_rx_stag - Read XDP packet outer vlan tag.
>>>>> + * @ctx: XDP context pointer.
>>>>> + * @vlan_tag: Return value pointer.
>>>>> + *
>>
>> (p.s. Googling I find multiple definitions of what the "S" in S-tag
>> means. The most reliable or statistically consistent seems to be
>> "Service tag", or "Service provider tag".)
>>
>> The description for the renamed "bpf_xdp_metadata_rx_vlan_outer_tag"
>> should IMHO explain that the outer VLAN tag is often refered to as the S-tag
>> (or Service-tag) in Q-in-Q (802.1ad) terminology.  Perhaps we can even spell
>> out that some hardware support (and must be configured via ethtool) to
>> extract this stag.
>>
>> A dump of the tool rx-vlan related commands:
>>
>>    $ ethtool -k i40e2 | grep rx-vlan
>>    rx-vlan-offload: on
>>    rx-vlan-filter: on [fixed]
>>    rx-vlan-stag-hw-parse: off [fixed]
>>    rx-vlan-stag-filter: off [fixed]
>>
[...]

