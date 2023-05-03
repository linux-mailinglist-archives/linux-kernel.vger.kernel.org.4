Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F63F6F57F9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 14:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjECMdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 08:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjECMdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 08:33:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC9110E5
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 05:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683117154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gi64OX3Of2seO335Lxc+tT0UY6TwkdsRC//xSV8lTrE=;
        b=e7g611dBFaY8WSx+EMdZ+n/PHYtl0sunX2AC23+bZNur+NL/PLv9O2BUIEz8k3jvVquMZi
        AAIFSpOOs3WrH30Z4gVOnCMtXQskotjG423nrVgmc7XLYDFrDxROvN9gnAOzPrYOBx1jNr
        TPTQPvXpTL1eHBsSWrFI1DK1DxroYZ8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-a0xRB9EyN8-59rg55rmjiw-1; Wed, 03 May 2023 08:32:33 -0400
X-MC-Unique: a0xRB9EyN8-59rg55rmjiw-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-5efc80e8485so76704196d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 05:32:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683117153; x=1685709153;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gi64OX3Of2seO335Lxc+tT0UY6TwkdsRC//xSV8lTrE=;
        b=fT1UsKJAGMJCA16TPCxn9bT7LWWGEGzZ3DVVfD+HQrOU0xH+BlRZqNoe1vwW4rkQtF
         Q0x7ImOGH6T7iBoVV0Bhmy0kO9+r+CA8VPGkDZZmXh7T8pDbmEnFoaod/AhYL8rnvqJ3
         fgiErflud+1pPLAvrKezaqAhcVJYm0RBrNoCx2JORrpc4Tf6BXn0paqwRlWmKV5iroVF
         8fwr0gAHMRSeNwABpwGimYYuUNgNumgUSNF5DhLrG6D9VmYC2/BgQG5Q2x3ZWl/oDY83
         G0wELs+QWyJvCkffEESR5gKfGyKAXRHsQrIP2rbix6jHpJWwrt6HEgGqOuVu3zmfyTwS
         3Lwg==
X-Gm-Message-State: AC+VfDwDEWya6gVwm8/t/onGSjVSME/9NEmq/1T/4phdDGEWp+S9ysPh
        V5tOw3jWeu8ELJ/M3V/xemfuxa78QcqcuYcMdo2W1jt7Kc24Xnoh6HcRv67YjQ6K5evbIGDuRYq
        taKrhzokwjKOd6X5UX721hh/9
X-Received: by 2002:a05:6214:2b06:b0:5b5:9c2:8c29 with SMTP id jx6-20020a0562142b0600b005b509c28c29mr10558692qvb.12.1683117153213;
        Wed, 03 May 2023 05:32:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7gD3DZqKFg22wLfhmmFhk3KWfQV1G/GfCVYnFgmZALN4tXOUdfnVs05JyYA1d20ExjdNJAIw==
X-Received: by 2002:a05:6214:2b06:b0:5b5:9c2:8c29 with SMTP id jx6-20020a0562142b0600b005b509c28c29mr10558669qvb.12.1683117152962;
        Wed, 03 May 2023 05:32:32 -0700 (PDT)
Received: from [192.168.1.31] (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id l17-20020a056214029100b005e8f61012e9sm10300002qvv.26.2023.05.03.05.32.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 05:32:32 -0700 (PDT)
Message-ID: <e0d252e7-a025-511e-22b3-c46f1f7ac054@redhat.com>
Date:   Wed, 3 May 2023 05:32:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH] pds_core: add stub macros for pdsc_debufs_* when !
 CONFIG_DEBUG_FS
Content-Language: en-US
To:     Jiri Pirko <jiri@resnulli.us>
Cc:     shannon.nelson@amd.com, brett.creeley@amd.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230502145220.2927464-1-trix@redhat.com>
 <ZFIO4FixTx1HC1RJ@nanopsycho>
From:   Tom Rix <trix@redhat.com>
In-Reply-To: <ZFIO4FixTx1HC1RJ@nanopsycho>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/3/23 12:36 AM, Jiri Pirko wrote:
> Tue, May 02, 2023 at 04:52:20PM CEST, trix@redhat.com wrote:
>> When CONFIG_DEBUG_FS is not defined there is this representative link error
>> ld: drivers/net/ethernet/amd/pds_core/main.o: in function `pdsc_remove':
>> main.c:(.text+0x35c): undefined reference to `pdsc_debugfs_del_dev
>>
>> Avoid these link errors when CONFIG_DEBUG_FS is not defined by
>> providing some empty macros.
>>
>> Signed-off-by: Tom Rix <trix@redhat.com>
>> ---
>> drivers/net/ethernet/amd/pds_core/core.h | 12 ++++++++++++
>> 1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/amd/pds_core/core.h b/drivers/net/ethernet/amd/pds_core/core.h
>> index e545fafc4819..0b39a6dc65c8 100644
>> --- a/drivers/net/ethernet/amd/pds_core/core.h
>> +++ b/drivers/net/ethernet/amd/pds_core/core.h
>> @@ -261,6 +261,7 @@ int pdsc_dl_enable_validate(struct devlink *dl, u32 id,
>>
>> void __iomem *pdsc_map_dbpage(struct pdsc *pdsc, int page_num);
>>
>> +#ifdef CONFIG_DEBUG_FS
>> void pdsc_debugfs_create(void);
>> void pdsc_debugfs_destroy(void);
>> void pdsc_debugfs_add_dev(struct pdsc *pdsc);
>> @@ -270,6 +271,17 @@ void pdsc_debugfs_add_viftype(struct pdsc *pdsc);
>> void pdsc_debugfs_add_irqs(struct pdsc *pdsc);
>> void pdsc_debugfs_add_qcq(struct pdsc *pdsc, struct pdsc_qcq *qcq);
>> void pdsc_debugfs_del_qcq(struct pdsc_qcq *qcq);
>> +#else
>> +#define pdsc_debugfs_create()
>> +#define pdsc_debugfs_destroy()
>> +#define pdsc_debugfs_add_dev(pdsc)
>> +#define pdsc_debugfs_del_dev(pdsc)
>> +#define pdsc_debugfs_add_ident(pdsc)
>> +#define pdsc_debugfs_add_viftype(pdsc)
>> +#define pdsc_debugfs_add_irqs(pdsc)
>> +#define pdsc_debugfs_add_qcq(pdsc, qcq)
>> +#define pdsc_debugfs_del_qcq(qcq)
> Usually this is done using static inline stub functions. Any reason to
> not to do it in the same way?

I do not mind changing the patch if that is what is required.

However I believe Paolo said the change was being handled by another patch.

Tom

>
>
>> +#endif
>>
>> int pdsc_err_to_errno(enum pds_core_status_code code);
>> bool pdsc_is_fw_running(struct pdsc *pdsc);
>> -- 
>> 2.27.0
>>

