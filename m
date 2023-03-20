Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A456C2232
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 21:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjCTUGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 16:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjCTUG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 16:06:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E410FBBB0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 13:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679342735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vLGqq2dkr4d+qChfROhQzB1nvGWWiqjAAUgEiPWsWfk=;
        b=QKLNv1rhjW8T39/4DXb/tRsT9UOxnTd+tFBX+IkZVN6NvkO2gEXh2rOfqqzPQe6RpSm1r9
        lxaECuW2UAwduQlJbBEy/LU4vWfzrNI9KycyyAoxdmifG3m+1j7PrGswaqDG62VFIEGL6E
        ysV34252cvQR9T6KnQRUSma3of56/OA=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-FhKvPKXQOKu5gJZ_TBIVoA-1; Mon, 20 Mar 2023 16:05:33 -0400
X-MC-Unique: FhKvPKXQOKu5gJZ_TBIVoA-1
Received: by mail-qt1-f200.google.com with SMTP id u22-20020a05622a011600b003dfd61e8594so3068247qtw.15
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 13:05:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679342733;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vLGqq2dkr4d+qChfROhQzB1nvGWWiqjAAUgEiPWsWfk=;
        b=Hi2zR+xZwbCRJzci4PJ4HMR1FIGOF2PgVnqEKC4lVf9ToAfPfhIXvzneo56LNMerEO
         fdz+++PUApALQWsn72bVfP8rtXbo3k+geXu+oaMbh9RPaq3htRp4Y3VVUjds40amFUeC
         mPTwRvayjrkNdh+uiikBcBfHUytJ0GI9EsTH4ZCIhJXdUfslo0mYQnQ+rb8X2IWhHE1j
         4jv4pFVjQh+VzSkN/aFc7HSeAOt/USNJKl/04Fngemg/m0Hf2Zf4bP/dr4IN619CWyZ0
         xYRrBnQvKSPrOKnI2x69Gd5v6VZqR/g4M1BPLK0XxW99iDDskGDI+TfySIE0FlXgOndi
         Hnng==
X-Gm-Message-State: AO0yUKV0pR3fwJRBwrqbcdubrozeWzrkgdk5PNdfcd7P28H1xce9I4RU
        C0jpjMywp1I3AeK+H/W8GshkNQPY+j6UTVgekId2BNCg5WQvAP2T1lgtP/mjKb1vF6kYAFLdqn+
        2r29pjTt9zNEPMZKjwL3E4JJAeXcoFTK4
X-Received: by 2002:ac8:7f4e:0:b0:3bf:d149:8966 with SMTP id g14-20020ac87f4e000000b003bfd1498966mr617501qtk.62.1679342733243;
        Mon, 20 Mar 2023 13:05:33 -0700 (PDT)
X-Google-Smtp-Source: AK7set8EYVn9VEzuCjZa06sZPyJPdqRWwwdN6xTMK4QNdqi2czOa4Al3y0wS1AbtorjeGXE8yHikrQ==
X-Received: by 2002:ac8:7f4e:0:b0:3bf:d149:8966 with SMTP id g14-20020ac87f4e000000b003bfd1498966mr617464qtk.62.1679342732969;
        Mon, 20 Mar 2023 13:05:32 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id bk12-20020a05620a1a0c00b0074357a6529asm7968058qkb.105.2023.03.20.13.05.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 13:05:32 -0700 (PDT)
Subject: Re: [PATCH] fpga: xilinx-pr-decoupler: remove unused
 xlnx_pr_decouple_read function
From:   Tom Rix <trix@redhat.com>
To:     Xu Yilun <yilun.xu@intel.com>, Michal Simek <michal.simek@amd.com>
Cc:     mdf@kernel.org, hao.wu@intel.com, michal.simek@xilinx.com,
        nathan@kernel.org, ndesaulniers@google.com,
        linux-fpga@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20230317230617.1673923-1-trix@redhat.com>
 <c8eaefed-e1fd-e0c1-7e8f-561c20632646@amd.com>
 <ZBhqutJChvRkUsRL@yilunxu-OptiPlex-7050>
 <2dc1f25d-d621-ec04-6de5-f731f2a8bb41@redhat.com>
Message-ID: <5fb2fa11-5a58-1856-7cb9-9687637d0741@redhat.com>
Date:   Mon, 20 Mar 2023 13:05:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <2dc1f25d-d621-ec04-6de5-f731f2a8bb41@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/20/23 9:24 AM, Tom Rix wrote:
>
> On 3/20/23 7:16 AM, Xu Yilun wrote:
>> On 2023-03-20 at 08:40:22 +0100, Michal Simek wrote:
>>>
>>> On 3/18/23 00:06, Tom Rix wrote:
>>>> CAUTION: This message has originated from an External Source. 
>>>> Please use proper judgment and caution when opening attachments, 
>>>> clicking links, or responding to this email.
>>>>
>>>>
>>>> clang with W=1 reports
>>>> drivers/fpga/xilinx-pr-decoupler.c:37:19: error: unused function 
>>>> 'xlnx_pr_decouple_read' [-Werror,-Wunused-function]
>>>> static inline u32 xlnx_pr_decouple_read(const struct 
>>>> xlnx_pr_decoupler_data *d,
>>>>                     ^
>>>> This static function is not used, so remove it.
>>>>
>>>> Signed-off-by: Tom Rix <trix@redhat.com>
>>>> ---
>>>>    drivers/fpga/xilinx-pr-decoupler.c | 6 ------
>>>>    1 file changed, 6 deletions(-)
>>>>
>>>> diff --git a/drivers/fpga/xilinx-pr-decoupler.c 
>>>> b/drivers/fpga/xilinx-pr-decoupler.c
>>>> index 2d9c491f7be9..b6f18c07c752 100644
>>>> --- a/drivers/fpga/xilinx-pr-decoupler.c
>>>> +++ b/drivers/fpga/xilinx-pr-decoupler.c
>>>> @@ -34,12 +34,6 @@ static inline void 
>>>> xlnx_pr_decoupler_write(struct xlnx_pr_decoupler_data *d,
>>>>           writel(val, d->io_base + offset);
>>>>    }
>>>>
>>>> -static inline u32 xlnx_pr_decouple_read(const struct 
>>>> xlnx_pr_decoupler_data *d,
>>>> -                                       u32 offset)
>>>> -{
>>>> -       return readl(d->io_base + offset);
>>>> -}
>>>> -
>>>>    static int xlnx_pr_decoupler_enable_set(struct fpga_bridge 
>>>> *bridge, bool enable)
>>>>    {
>>>>           int err;
>>>> -- 
>>>> 2.27.0
>>>>
>>> It should be fixed like this instead.
>>>
>>> Thanks,
>>> Michal
>>>
>>> diff --git a/drivers/fpga/xilinx-pr-decoupler.c 
>>> b/drivers/fpga/xilinx-pr-decoupler.c
>>> index 2d9c491f7be9..58508f44cd49 100644
>>> --- a/drivers/fpga/xilinx-pr-decoupler.c
>>> +++ b/drivers/fpga/xilinx-pr-decoupler.c
>>> @@ -69,7 +69,7 @@ static int xlnx_pr_decoupler_enable_show(struct
>>> fpga_bridge *bridge)
>>>          if (err)
>>>                  return err;
>>>
>>> -       status = readl(priv->io_base);
>>> +       status = xlnx_pr_decouple_read(priv);
>> OK, I'll drop the previous fix, and waiting for the new one.
>
> Michal,
>
> Will you make this change ?

Let me provide some context.

I am cleaning up about 70 similar unused functions all over the tree.

I have removed a lot of one liner wrappers that look like this.

My opinion, to be useful the wrapper needs to be used multiple places 
and/or do something non trival otherwise we will bloat the codebase with 
with 5x lines of code to do a simple readl.

But this is subjection. If you want this change, you should make it.

Tom

>
> Tom
>
>>
>> Thanks,
>> Yilun
>>
>>>          clk_disable(priv->clk);
>>>

