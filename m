Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31016ABB27
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 11:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjCFKKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 05:10:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbjCFKJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 05:09:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D301E1F6
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 02:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678097334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EVDDDoseFSlsJ/yOtuOcTrCu0OwrB7nkSCuo1rxDF3U=;
        b=PrmwqQEngeHDC6m8iH11fx7LsV2ihJncZ+D2jsMG6U1AJ5Z9u9LvTAsyGGVcjnirBORiBI
        Hkk570DFxOjB7K3CIaOVcnCs3eArCUJZ3eC97Sq+aRftjGy2dF9jiIJVF+4ZG0oObxwSWQ
        /f3Mytp9q9U0YuyQptRIayk6AeqlYeo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-3q-lzVftPumQxhV_AUN7Uw-1; Mon, 06 Mar 2023 05:08:52 -0500
X-MC-Unique: 3q-lzVftPumQxhV_AUN7Uw-1
Received: by mail-wm1-f71.google.com with SMTP id f14-20020a7bcc0e000000b003dd41ad974bso3546710wmh.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 02:08:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678097331;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EVDDDoseFSlsJ/yOtuOcTrCu0OwrB7nkSCuo1rxDF3U=;
        b=cCS27Szn4eZMrQQ7mLsSAoUQSHDfmSG8rTgZB6EHWwiGOOGo8XOCS6x+dagBI7LKc2
         /lVHnQT+Uu3kJFLKHGdk/Ckx1QQO/FPaMhe93MLTHw61UhaPqhIk0lp2u1PJDO2t8mHD
         8qOnU/tJ9cN5MmGvFRoq/IMh9Cfwf72JMS0ibx2KNO9vxTUk8lOzspHFspK+s1tBM67y
         ZtzuMmsS29Zl7mdGu1IjqVRbadcy3i97cFav0zMt3x0I4fkX8irguUaTH8A+Mbg1uR5h
         b95NcvFfDRwSRvH5CuzrJ2ORg6sksD/tlIzw4XjhH71YacgQgnvJlCEvYJovtLw8Nrk/
         iKdg==
X-Gm-Message-State: AO0yUKXSrPDk3MLLEmqu+xvyqn6EqggSRYj8KiN8T9hVjufB36kN0mC2
        Tb8QelQpn4PHd0VjNnIzk97InI8l8vTFiJszIyTr8gn2PDUR9RTy2pttuz/oO/d5hlBdybTVk9u
        L3/LLM5Uca20sCXzrBSdB5kau
X-Received: by 2002:adf:decf:0:b0:2c7:70c:2d8c with SMTP id i15-20020adfdecf000000b002c7070c2d8cmr6513233wrn.35.1678097331762;
        Mon, 06 Mar 2023 02:08:51 -0800 (PST)
X-Google-Smtp-Source: AK7set9WQWU0/AqjGpjnwlp1W3nHk7FeTxUleAEXtUTLlVYgpYALebFQhOUiiq8oeFfaCx0vUYOFtQ==
X-Received: by 2002:adf:decf:0:b0:2c7:70c:2d8c with SMTP id i15-20020adfdecf000000b002c7070c2d8cmr6513224wrn.35.1678097331467;
        Mon, 06 Mar 2023 02:08:51 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id u18-20020a5d6ad2000000b002c5539171d1sm9161401wrw.41.2023.03.06.02.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 02:08:51 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Jordan Crouse <jorcrous@amazon.com>
Cc:     linux-kernel@vger.kernel.org, Albert Esteve <aesteve@redhat.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Sergio Lopez <slp@redhat.com>,
        Enric Balletbo i Serra <eballetb@redhat.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH] media: venus: dec: Fix capture formats enumeration order
In-Reply-To: <20230303220918.qr5ydbin3nye3qtz@amazon.com>
References: <20230210081835.2054482-1-javierm@redhat.com>
 <20230303220918.qr5ydbin3nye3qtz@amazon.com>
Date:   Mon, 06 Mar 2023 11:08:50 +0100
Message-ID: <87h6uydwel.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jordan Crouse <jorcrous@amazon.com> writes:

Hello Jordan,

> On Fri, Feb 10, 2023 at 09:18:35AM +0100, Javier Martinez Canillas wrote:
>> Commit 9593126dae3e ("media: venus: Add a handling of QC08C compressed
>> format") and commit cef92b14e653 ("media: venus: Add a handling of QC10C
>> compressed format") added support for the QC08C and QC10C compressed
>> formats respectively.
>> 
>> But these also caused a regression, because the new formats where added
>> at the beginning of the vdec_formats[] array and the vdec_inst_init()
>> function sets the default format output and capture using fixed indexes
>> of that array:
>> 
>> static void vdec_inst_init(struct venus_inst *inst)
>> {
>> ...
>> 	inst->fmt_out = &vdec_formats[8];
>> 	inst->fmt_cap = &vdec_formats[0];
>> ...
>> }
>> 
>> Since now V4L2_PIX_FMT_NV12 is not the first entry in the array anymore,
>> the default capture format is not set to that as it was done before.
>> 
>> Both commits changed the first index to keep inst->fmt_out default format
>> set to V4L2_PIX_FMT_H264, but did not update the latter to keep .fmt_out
>> default format set to V4L2_PIX_FMT_NV12.
>> 
>> Rather than updating the index to the current V4L2_PIX_FMT_NV12 position,
>> let's reorder the entries so that this format is the first entry again.
>> 
>> This would also make VIDIOC_ENUM_FMT report the V4L2_PIX_FMT_NV12 format
>> with an index 0 as it did before the QC08C and QC10C formats were added.
>> 
>> Fixes: 9593126dae3e ("media: venus: Add a handling of QC08C compressed format")
>> Fixes: cef92b14e653 ("media: venus: Add a handling of QC10C compressed format")
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>
> I just came across this issue independently and can confirm this patch fixes
> the GStreamer V4L2 decoder on QRB5165.
>
> Tested-by: Jordan Crouse <jorcrous@amazon.com>
>

Thanks for testing it!

Stanimir, can we please get this for v6.3 as well?

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

