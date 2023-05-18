Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD06707EC3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 13:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjERLEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 07:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjERLEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 07:04:12 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E57E8
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 04:03:46 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1a516fb6523so18604155ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 04:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684407826; x=1686999826;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L8wUobxEGLI2p/DjIP+xJqCqQPQ2167f6CpUfP5l0e4=;
        b=L/z29TYptPB+dKSNb3mEL33qDf2zvq+L0/3Z2CVEjBTqugDsEWs4MwCo5ccH0uwpL2
         AvGAMh7gnwX3UthjGXJv4Cg8sPuRyiIteL58u2eUEKt8LTGjf0Afwk/DmajdKGxekkoU
         KYUZWBlXieZm0Pi8ecFqz2JfXx46KJUIGMbpDXk8FcYGg2OzUUrnv3s7Vb/DtuWYrhhm
         CBEnpAB563A60MUjfailaf0/PpGx3yHkXNXQSQSVj9op61WUVu7XgfOqWYbc7N5oCXCl
         kqRmWgC1aglb0CFUUG+hapCkb8YOtKlcOoyyDnM2rBjdev+O/LWdwDhH9N6t/OOENpdk
         CKXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684407826; x=1686999826;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L8wUobxEGLI2p/DjIP+xJqCqQPQ2167f6CpUfP5l0e4=;
        b=lqS0fnHPyB1p7DqGrDSwFZr7V74ml/MKHtLZ/vlkDJgaDm6jaYJUqXvY0Zi+t8+1Ik
         zbgozVSzqirR8Ubtw8yMuHDyv9D0uwZgCir4AZaYRD0ciUbJClz6uL9vhBGD9LNepnHM
         OV88Obwmn8KbmYcUoN9ueHY6khxkmtlOPu5kQfgFyMx/gLD2z9h8YkIoK7+oCBxCtTP5
         nGJZkyfT7GVq3UdCMbeGZ1EAih62qTr3yfbs+r8JGdfdyzNN5unQ5NuBQYVXBwPKOqDb
         uzqb/udHsOPqvXbQwrfbDET50vMfNS2Z+Xj6du9t/Mhy1GpmeJ697g/lZZFeOh9GHd9S
         dXuQ==
X-Gm-Message-State: AC+VfDwJegTOh632ah1hq89C7YeKF7fiKuGM+kGXWjFVJ4oI95/u2/xT
        xsssVJZFnEzFWQIzxhCXnpuNkQ==
X-Google-Smtp-Source: ACHHUZ6qEky0lbIh7SGpL1S6SNPIGEpyyuqz6caX9PGmjpQo/xjkVek+4gHTCYfNOHYvwcR5n+qSlg==
X-Received: by 2002:a17:903:1205:b0:1ae:14d:8d0a with SMTP id l5-20020a170903120500b001ae014d8d0amr2459581plh.29.1684407825895;
        Thu, 18 May 2023 04:03:45 -0700 (PDT)
Received: from [10.3.43.196] ([61.213.176.8])
        by smtp.gmail.com with ESMTPSA id h8-20020a170902ac8800b001a194df5a58sm1141310plr.167.2023.05.18.04.03.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 04:03:45 -0700 (PDT)
Message-ID: <f16b8f56-8890-a4ae-0108-ff5667350fbc@bytedance.com>
Date:   Thu, 18 May 2023 19:01:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Re: Re: Re: [PATCH v2 1/2] virtio: abstract virtqueue related
 methods
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>, stefanha@redhat.com,
        jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20230517025424.601141-1-pizhenwei@bytedance.com>
 <20230517025424.601141-2-pizhenwei@bytedance.com>
 <ZGSEq197W8VvOWCc@infradead.org>
 <9e4702f2-5473-2139-3858-ae58817bc7b5@bytedance.com>
 <ZGSGQWqbtdwGXurf@infradead.org>
 <cc9f3aea-b8bc-f312-41bb-3fd68083aa99@bytedance.com>
 <20230517062401-mutt-send-email-mst@kernel.org>
 <ee2a975f-0aa6-a46a-e9d2-7f82e313347f@bytedance.com>
 <20230518060656-mutt-send-email-mst@kernel.org>
From:   zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <20230518060656-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/18/23 18:09, Michael S. Tsirkin wrote:
> On Thu, May 18, 2023 at 08:47:22AM +0800, zhenwei pi wrote:
>> On 5/17/23 18:39, Michael S. Tsirkin wrote:
>>> On Wed, May 17, 2023 at 04:35:55PM +0800, zhenwei pi wrote:
>>>>
>>>>
>>>> On 5/17/23 15:46, Christoph Hellwig wrote:
>>>>> On Wed, May 17, 2023 at 03:43:03PM +0800, zhenwei pi wrote:
>>>>>> I have a plan to introduce 'Virtio Over Fabrics'(TCP&RDMA) as Virtio
>>>>>> transport, as mentioned in cover letter of this series:
>>>>>> 3 weeks ago, I posted a proposal 'Virtio Over Fabrics':
>>>>>> https://lists.oasis-open.org/archives/virtio-comment/202304/msg00442.html
>>>>>
>>>>> Just don't do it.  Please define your own protocols over RDMA or TCP
>>>>> for exactly the operations you need (for many they will already exist)
>>>>> instead of piggyg backing on virtio and making everyone else pay the
>>>>> price.
>>>>>
>>>>
>>>> Hi
>>>>
>>>> 1, `virtqueue_add_inbuf` in current version:
>>>> static inline int virtqueue_add_inbuf(struct virtqueue *vq,
>>>>                                         struct scatterlist *sg,
>>>>                                         unsigned int num,
>>>>                                         void *data,
>>>>                                         gfp_t gfp)
>>>> {
>>>>           if (likely(!vq->abstract))
>>>>                   return vring_virtqueue_add_sgs(vq, &sg, num, 0, 1, data,
>>>> NULL, gfp);
>>>>
>>>>           return vq->add_sgs(vq, &sg, num, 0, 1, data, NULL, gfp);
>>>> }
>>>>
>>>> And disassemble 'virtinput_queue_evtbuf':
>>>> static void virtinput_queue_evtbuf(struct virtio_input *vi,
>>>>                                      struct virtio_input_event *evtbuf)
>>>> {
>>>>           struct scatterlist sg[1];
>>>>
>>>>           sg_init_one(sg, evtbuf, sizeof(*evtbuf));
>>>>           virtqueue_add_inbuf(vi->evt, sg, 1, evtbuf, GFP_ATOMIC);
>>>> }
>>>>
>>>> I notice that two instructions are newly added for vring like:
>>>>    24d:   80 78 35 00             cmpb   $0x0,0x35(%rax)
>>>>    251:   75 3f                   jne    292
>>>>
>>>> Is it an expensive price...
>>>
>>> Can we somehow only override the kick method?
>>> Then take the ring and send it over ...
>>>
>>
>> Could you please take a look at this code?
>> https://github.com/pizhenwei/linux/blob/virtio-of-github/drivers/virtio/virtio_fabrics.c#LL861C13-L861C23
> 
> what am I looking at here?
> 
> Looks like at least vof_handle_vq duplicates some code from vringh.
> But besides that yes, that's the idea.
> 

OK, I'd drop this series.

Cc Jason & Stefan.


-- 
zhenwei pi
