Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F4F6ED439
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 20:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbjDXSQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 14:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbjDXSQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 14:16:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11687EED
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 11:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682360057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1t7mmBoREyN++55SKMolHK6qsrf6grZmQqxd4DYClio=;
        b=h/lPDZrJBtfpkhuRN5sCe2gsCblGHl7U8V4CdeIbrTqsqD1TZjWyb2OxGBEQOA6lSeD7rr
        I0lTc+EbiyE4JEOQCKc4qs6e44RFiuFfiU9x7y2X5yHA4qFvpjKVHypuZUiGvW0FdXPfNc
        RFjQFIEjCxL16bB0/eokc/QXQbZAH8E=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-bIc3600xN8e5hI0BHUJDGw-1; Mon, 24 Apr 2023 14:14:15 -0400
X-MC-Unique: bIc3600xN8e5hI0BHUJDGw-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-5e7223aab07so28494726d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 11:14:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682360055; x=1684952055;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1t7mmBoREyN++55SKMolHK6qsrf6grZmQqxd4DYClio=;
        b=RDln4DhpsPLMiq3UHsXUJk657yENW8aq+3gCOOaUt4Vax8p1LsvMyRka854sLBtR51
         c9rfeADtfNh3ygdZWDm5HR4CN90qUO6IP9+0k6ShfERaJ57GPK5NZBFpQKczA9Nagvjy
         lljbGaExoy4dNunETel2y1VGroe+APyFz9PXyi0X3ml3Gzzx8y/2aCxlQLL37sqZr1Mp
         8fT31i4q1XaJ4hAzdMynk3QSM4NhOywA3By5csZWzB2cCnLXWVq5nddbZ4IqrSSav03q
         a0Ts+ULiBFA0Bvy1Hl9IfysGlopuaH75iMRFErbGRDvEAyzYcNiMBOVyTnoELXoo5Wbc
         KWtA==
X-Gm-Message-State: AAQBX9fgnzJuhEIMAzFU3F8jEZEZogx0gA6EEP8cFov9oPERjvaUZ2IP
        UTSdH+RjT1G3wBJHkteY/3O7PXlL0gZKXLWqDyotk7eSsYg11iUmxf8g2BTykXuyk0F4xhy+Rb7
        x3MJg05y78Kv0Ku5BvHhxTw6i
X-Received: by 2002:ac8:5792:0:b0:3ef:5733:29e4 with SMTP id v18-20020ac85792000000b003ef573329e4mr23695496qta.64.1682360054981;
        Mon, 24 Apr 2023 11:14:14 -0700 (PDT)
X-Google-Smtp-Source: AKy350atGQDLcokpP+b8qwiVWcVt+lW3aoMSwbKlIc/IoMCQwMl5grguEKprAip97oqd3hMBQL6FWw==
X-Received: by 2002:ac8:5792:0:b0:3ef:5733:29e4 with SMTP id v18-20020ac85792000000b003ef573329e4mr23695447qta.64.1682360054621;
        Mon, 24 Apr 2023 11:14:14 -0700 (PDT)
Received: from [192.168.1.31] (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id p141-20020a374293000000b0074de75f783fsm3757258qka.26.2023.04.24.11.14.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 11:14:14 -0700 (PDT)
Message-ID: <4ca4e590-a996-81ad-e088-d172f5a5a8ba@redhat.com>
Date:   Mon, 24 Apr 2023 11:14:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH] drm/amd/display: return status of
 dmub_srv_get_fw_boot_status
Content-Language: en-US
To:     Hamza Mahfooz <hamza.mahfooz@amd.com>, harry.wentland@amd.com,
        sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        Alvin.Lee2@amd.com, Jun.Lei@amd.com, qingqing.zhuo@amd.com,
        Max.Tseng@amd.com, Josip.Pavic@amd.com, Eric.Yang2@amd.com,
        aurabindo.pillai@amd.com
Cc:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230420135901.3889747-1-trix@redhat.com>
 <9910a5e3-a161-edfa-19d4-2bbf3bbf405f@amd.com>
From:   Tom Rix <trix@redhat.com>
In-Reply-To: <9910a5e3-a161-edfa-19d4-2bbf3bbf405f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/24/23 10:02 AM, Hamza Mahfooz wrote:
>
> On 4/20/23 09:59, Tom Rix wrote:
>> gcc with W=1 reports
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:
>>    In function ‘dc_dmub_srv_optimized_init_done’:
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:184:26:
>>    error: variable ‘dmub’ set but not used 
>> [-Werror=unused-but-set-variable]
>>    184 |         struct dmub_srv *dmub;
>>        |                          ^~~~
>>
>> The return status is never set.
>> It looks like a call to dmub_srv_get_fw_boot_status is missing.
>>
>> Fixes: 499e4b1c722e ("drm/amd/display: add mechanism to skip DCN init")
>
> What tree is this based on? I am unable to find that exact commit on
> amd-staging-drm-next.

linux-next

Tom


>
>> Signed-off-by: Tom Rix <trix@redhat.com>
>> ---
>>   drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 13 +++++++++++--
>>   1 file changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c 
>> b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
>> index d15ec32243e2..36d936ab4300 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
>> +++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
>> @@ -182,14 +182,23 @@ bool dc_dmub_srv_cmd_run_list(struct 
>> dc_dmub_srv *dc_dmub_srv, unsigned int coun
>>   bool dc_dmub_srv_optimized_init_done(struct dc_dmub_srv *dc_dmub_srv)
>>   {
>>       struct dmub_srv *dmub;
>> -    union dmub_fw_boot_status status;
>> +    struct dc_context *dc_ctx;
>> +    union dmub_fw_boot_status boot_status;
>> +    enum dmub_status status;
>>         if (!dc_dmub_srv || !dc_dmub_srv->dmub)
>>           return false;
>>         dmub = dc_dmub_srv->dmub;
>> +    dc_ctx = dc_dmub_srv->ctx;
>> +
>> +    status = dmub_srv_get_fw_boot_status(dmub, &boot_status);
>> +    if (status != DMUB_STATUS_OK) {
>> +        DC_ERROR("Error querying DMUB boot status: error=%d\n", 
>> status);
>> +        return false;
>> +    }
>>   -    return status.bits.optimized_init_done;
>> +    return boot_status.bits.optimized_init_done;
>>   }
>>     bool dc_dmub_srv_notify_stream_mask(struct dc_dmub_srv *dc_dmub_srv,

