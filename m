Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A9865F67E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 23:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235701AbjAEWKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 17:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235512AbjAEWJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 17:09:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB0169534
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 14:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672956548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=idk7zwMeN8Ms5ELQH7d2B6f/MLuOIPR3AtkkFMxBOP4=;
        b=WxsdcKEzoRuvf4DRT79vN2pF0Mp4E1Y47672tB95E4Dut0Tp9JW4OaXFOKCk3U1T4G2rBb
        MOORUvmk9k35z9vnJTIiUNUlf+7zYNXD/NvUoEJfTmCV1HS+bnsKRgTRexDcRl84IEsWDy
        pOr45HI+F2tP74UjVyKGfwNuKEMOSP0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-116-nZfwCQtLPguWxazHK1lLig-1; Thu, 05 Jan 2023 17:09:07 -0500
X-MC-Unique: nZfwCQtLPguWxazHK1lLig-1
Received: by mail-qk1-f198.google.com with SMTP id v7-20020a05620a0f0700b006faffce43b2so25692709qkl.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 14:09:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=idk7zwMeN8Ms5ELQH7d2B6f/MLuOIPR3AtkkFMxBOP4=;
        b=QfGk2sCN+yRIWoXBw0gXktOgxOXtzWdpMB7t1lpYpulMDSGcFwyMj0ZmaMm/84Q/HK
         H95OUcmVI9yEXZoc2Yf+qmn+sNHXzeKBXQXu+jqLolZHT01ymJczwSPcmGcD4M5PMARg
         Fl5l8ghw2YwwR9qk7Tkn/70VjbfWxV03kyoIknX9PhlgdzQDTmmwrDBUAo9f4qRBzyWd
         gpAqf6zQ561SemiPR7rDSozuk8CR0dYQE1KAtzp5VpkS03MVtvtocTypfrLxvxDReLT2
         ZYrGRZUawpQSttsUVSOcU3ERu6PtSuE3DG26QJbiX014vbtTBvUXc/EF3Cox0rrBeo2X
         5RcQ==
X-Gm-Message-State: AFqh2koD5Q2ABHSHwbutILw0ExV+v3ef9uMejsR1vMQdwkuH4YYQroiA
        TR7yZTyG8IxqjY5Ls84oQQSF8X4paAJebTQ+TQy7Aio6c9Le9jNmZgZneiRGfDYB1zQx8jFcIMZ
        tsAtYQjEe3TxqNRyVKkBCg8cG
X-Received: by 2002:a05:6214:2e81:b0:4b8:8a31:5741 with SMTP id oc1-20020a0562142e8100b004b88a315741mr71801198qvb.15.1672956547037;
        Thu, 05 Jan 2023 14:09:07 -0800 (PST)
X-Google-Smtp-Source: AMrXdXughyad3qrXR+35kG38zogh8DNxPC/6FgPkh/1kss3XlBPgAaxGNhEBt42C/e4ZtH94rv6pbA==
X-Received: by 2002:a05:6214:2e81:b0:4b8:8a31:5741 with SMTP id oc1-20020a0562142e8100b004b88a315741mr71801183qvb.15.1672956546809;
        Thu, 05 Jan 2023 14:09:06 -0800 (PST)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id pj8-20020a05620a1d8800b006cfc7f9eea0sm25787894qkn.122.2023.01.05.14.09.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jan 2023 14:09:06 -0800 (PST)
Subject: Re: [PATCH] ASoC: amd: Return ENODEV if acp63 is not found.
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, ndesaulniers@google.com, Vijendar.Mukunda@amd.com,
        Syed.SabaKareem@amd.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20230105211912.824250-1-trix@redhat.com>
 <Y7dF3VvQs6l7rr3p@dev-arch.thelio-3990X>
From:   Tom Rix <trix@redhat.com>
Message-ID: <3921856d-7843-4206-f888-4ac48cdc97e4@redhat.com>
Date:   Thu, 5 Jan 2023 14:09:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <Y7dF3VvQs6l7rr3p@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/5/23 1:49 PM, Nathan Chancellor wrote:
> Hi Tom,
>
> On Thu, Jan 05, 2023 at 04:19:12PM -0500, Tom Rix wrote:
>> The clang build fails with
>> sound/soc/amd/ps/pci-ps.c:218:2: error: variable 'ret' is used
>>    uninitialized whenever switch default is taken [-Werror,-Wsometimes-uninitialized]
>>          default:
>>          ^~~~~~~
>>
>> When no device is found -ENODEV should be returned.
>> A switch with a single case is overkill, change to if-else.
>>
>> Fixes: 1d325cdaf7a2 ("ASoC: amd: ps: refactor platform device creation logic")
>> Signed-off-by: Tom Rix <trix@redhat.com>
> Thanks for the patch! I sent basically the same thing earlier today
> (sorry for forgetting to Cc you directly) and was told it was not
> correct:
>
> https://lore.kernel.org/6bb126b7-1cb4-0c4c-d357-fadc3ffdd3f9@amd.com/
>
> I am just waiting for some feedback before sending a v2.

Looking closer, the pdev_mask is only set to ACP63_PDM_DEV_MASK so the 
case statement can be folded into the above if-check of pdev_mask.

And the default: dropped,  it looks like dead code.

Please cc me on the v2,

Tom

>
>> ---
>>   sound/soc/amd/ps/pci-ps.c | 7 +++----
>>   1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
>> index 401cfd0036be..cba8800ab4ea 100644
>> --- a/sound/soc/amd/ps/pci-ps.c
>> +++ b/sound/soc/amd/ps/pci-ps.c
>> @@ -205,8 +205,7 @@ static int create_acp63_platform_devs(struct pci_dev *pci, struct acp63_dev_data
>>   		memset(&pdevinfo, 0, sizeof(pdevinfo));
>>   	}
>>   
>> -	switch (adata->pdev_mask) {
>> -	case ACP63_PDM_DEV_MASK:
>> +	if (adata->pdev_mask == ACP63_PDM_DEV_MASK) {
>>   		adata->pdm_dev_index  = 0;
>>   		acp63_fill_platform_dev_info(&pdevinfo[0], parent, NULL, "acp_ps_pdm_dma",
>>   					     0, adata->res, 1, NULL, 0);
>> @@ -214,8 +213,8 @@ static int create_acp63_platform_devs(struct pci_dev *pci, struct acp63_dev_data
>>   					     0, NULL, 0, NULL, 0);
>>   		acp63_fill_platform_dev_info(&pdevinfo[2], parent, NULL, "acp_ps_mach",
>>   					     0, NULL, 0, NULL, 0);
>> -		break;
>> -	default:
>> +	} else {
>> +		ret = -ENODEV;
>>   		dev_dbg(&pci->dev, "No PDM devices found\n");
>>   		goto de_init;
>>   	}
>> -- 
>> 2.27.0
>>
>>

