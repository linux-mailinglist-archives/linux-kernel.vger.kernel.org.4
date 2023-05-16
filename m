Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFD8705255
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 17:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233631AbjEPPg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 11:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233721AbjEPPg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 11:36:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A41B8A6F
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 08:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684251336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CcyRieVlUfnyzXKTzR5d4JdkM5K3TgxrxW94yInGt+Q=;
        b=S4gEZe+U/W8hMqmB66fW4+ayudR0C0ixxROf/eO+kZbPjI481dkuIekYbDI9OCMQQ9KUTU
        L3kz1qZEYWDqIHd6KK8IbX7YUW7JCbxKFjslN6Dgjk+ppk5kQpiGvt0cD1Ow2Wp3OfOEvt
        n3kXy5a41Gn/i8gRcLcAcMrs6bXapgU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-t6NzK9FrPEKf3-FtYe38xw-1; Tue, 16 May 2023 11:35:31 -0400
X-MC-Unique: t6NzK9FrPEKf3-FtYe38xw-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-50d88a986afso13315861a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 08:35:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684251330; x=1686843330;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CcyRieVlUfnyzXKTzR5d4JdkM5K3TgxrxW94yInGt+Q=;
        b=grg4UEs6+4uDYAbc6A9BjbXroTGsYQ8lMajKuoJXQzAlwzVEWqvIOaNu8jeo0GXilx
         vT9uzmWjKtVl2hcjO/iGQLVL21eeDQ9GtuDCBMBCkeXQ68U4BFszxZKVfvHcb44HJ1Hp
         6YSBoSKhzEpM8A4Pz+JNbwMFTvs2p1OUA8JuyhVr+7nHMwgPqTkndP4DthOLXl5+cSNs
         GXWwD3rviBgSqNmMR6KNjbgRxZmjm9nN2aPPFAcccnDh+9ACpTNAIhhXJeQlrOAtbZlJ
         FLP5Mfi7YTkwMMq71CtgPcr9CLb5rbX/Lw5Phz9aReegv0JL1l1S/9qIi8Hgi89NqZlY
         oJwA==
X-Gm-Message-State: AC+VfDzuV1y34GSS85sRbEUk6iJj+LW4sqOpPQf9khAJAvRBch4sJv05
        0i2jE9l/mq05Os23UYbEYpFsZA8kkpiXs1h3qBfFRun5KSRZ4OWsWbxXOwSbmINj96lSQT2k+ZK
        ma7wkuhy2pdJu4AWxMtKj5EZI
X-Received: by 2002:a17:907:7241:b0:96a:f688:db6d with SMTP id ds1-20020a170907724100b0096af688db6dmr9440487ejc.39.1684251330706;
        Tue, 16 May 2023 08:35:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ57HOpAvaM/nwXSOEpBnwKQLHKhU91w24YzKezDzveXbLZUSTWHiqd71UBuqaWRBls0iTWibg==
X-Received: by 2002:a17:907:7241:b0:96a:f688:db6d with SMTP id ds1-20020a170907724100b0096af688db6dmr9440452ejc.39.1684251330293;
        Tue, 16 May 2023 08:35:30 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id og40-20020a1709071de800b0095807ab4b57sm11264399ejc.178.2023.05.16.08.35.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 08:35:29 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <a37db72f-2e83-c838-7c81-8f01a5a0df32@redhat.com>
Date:   Tue, 16 May 2023 17:35:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc:     brouer@redhat.com, Jesper Dangaard Brouer <jbrouer@redhat.com>,
        bpf@vger.kernel.org, Stanislav Fomichev <sdf@google.com>,
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
Subject: Re: [PATCH RESEND bpf-next 14/15] net, xdp: allow metadata > 32
Content-Language: en-US
To:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>
References: <20230512152607.992209-1-larysa.zaremba@intel.com>
 <20230512152607.992209-15-larysa.zaremba@intel.com>
 <ee1ad4f2-34ab-4377-14d5-532cb0687180@redhat.com> <ZGJnFxzDTV2qE4zZ@lincoln>
 <b9a879b2-bb62-ba18-0bdd-5c126a1086a9@intel.com>
In-Reply-To: <b9a879b2-bb62-ba18-0bdd-5c126a1086a9@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/05/2023 14.37, Alexander Lobakin wrote:
> From: Larysa Zaremba<larysa.zaremba@intel.com>
> Date: Mon, 15 May 2023 19:08:39 +0200
> 
>> On Mon, May 15, 2023 at 06:17:02PM +0200, Jesper Dangaard Brouer wrote:
>>>
>>> On 12/05/2023 17.26, Larysa Zaremba wrote:
>>>> From: Aleksander Lobakin<aleksander.lobakin@intel.com>
>>>>
>>>> When using XDP hints, metadata sometimes has to be much bigger
>>>> than 32 bytes. Relax the restriction, allow metadata larger than 32 bytes
>>>> and make __skb_metadata_differs() work with bigger lengths.
>>>>
>>>> Now size of metadata is only limited by the fact it is stored as u8
>>>> in skb_shared_info, so maximum possible value is 255.
 >>>
>>> I'm confused, IIRC the metadata area isn't stored "in skb_shared_info".
>>> The maximum possible size is limited by the XDP headroom, which is also
>>> shared/limited with/by xdp_frame.  I must be reading the sentence wrong,
>>> somehow.
 >
> skb_shared_info::meta_size  is u8. Since metadata gets carried from
> xdp_buff to skb, this check is needed (it's compile-time constant anyway).
> Check for headroom is done separately already (two sentences below).
> 

Damn, argh, for SKBs the "meta_len" is stored in skb_shared_info, which
is located on another cacheline.
That is a sure way to KILL performance! :-(

But only use for SKBs that gets created from xdp with metadata, right?



>> It's not 'metadata is stored as u8', it's 'metadata size is stored as u8' :)
>> Maybe I should rephrase it better in v2.

Yes, a rephrase will be good.

--Jesper



static inline u8 skb_metadata_len(const struct sk_buff *skb)
{
	return skb_shinfo(skb)->meta_len;
}

