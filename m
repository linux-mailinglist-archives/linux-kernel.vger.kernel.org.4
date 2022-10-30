Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA57B61272B
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 04:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiJ3Ddb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 23:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiJ3Dd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 23:33:26 -0400
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D86476D5;
        Sat, 29 Oct 2022 20:33:25 -0700 (PDT)
Received: by mail-pl1-f172.google.com with SMTP id d24so8099215pls.4;
        Sat, 29 Oct 2022 20:33:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pS7AZ/Tfdzwte7j4jjsc2iqCeEjErFBQNVNROTsodAU=;
        b=pPrR0QNR8mH+0ZJCRHO29bYOoN7n0ue4L3m6Wf2LJ79HAGyKL3dklDhSVFk1Ucy7iT
         DPsrxFNney55zCNVV7bkjo+2QUZ8GFXGQd27kThbb+4DYdQAWHoB+QaAYsxRenGeyS1o
         0dznYftmT3zG7wt0CO5N/U7zrpJqmeyiYJQe11xGGJevsQ1Dotqknp3Xh0dKOUCq1QWb
         SPdj1ZRGLN8++KK+FXrUprQ4Mc0O8RhlrFJGjwmfPnrUvz95+hbOrdZEWROJLhR/xTfd
         6eJ4yopmHEpQoB/vDt6ZCHZhjQEq3UkG0ncnjmSB80LzwuTCOcWfvkre93BMc9AyCmqK
         qJSg==
X-Gm-Message-State: ACrzQf2n0DmDfDVdcOdp1lyHGtPeQ4rGY6ho0CCkdJkuUMPBYtNOlWjN
        +IrOEsd6pi5mQ0U/au4ZWnIuOheUpNc=
X-Google-Smtp-Source: AMsMyM4EPMYfnlE4FNblmgukY9IYL4JpO0xDIZad0CBoy+OTuHy7FnFe0lVpZmOnLakOMsdDviAIBw==
X-Received: by 2002:a17:90a:6043:b0:213:8043:4b85 with SMTP id h3-20020a17090a604300b0021380434b85mr7504475pjm.135.1667100804466;
        Sat, 29 Oct 2022 20:33:24 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id u12-20020a170902714c00b00186881688f2sm234240plm.220.2022.10.29.20.33.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Oct 2022 20:33:23 -0700 (PDT)
Message-ID: <bc8cf710-c0ad-24e8-7849-6282c8e3bcff@acm.org>
Date:   Sat, 29 Oct 2022 20:33:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2] block: simplify blksize_bits() implementation
Content-Language: en-US
To:     Dawei Li <set_pte_at@outlook.com>
Cc:     axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <TYCP286MB232371C798BE0500E979E24CCA349@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
 <8ccaabc1-2834-dad6-7d46-19bfc2adcc9a@acm.org>
 <TYCP286MB23234B5C344600A604B17242CA349@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <TYCP286MB23234B5C344600A604B17242CA349@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/22 20:25, Dawei Li wrote:
> On Sat, Oct 29, 2022 at 08:00:58PM -0700, Bart Van Assche wrote:
>> On 10/29/22 19:17, Dawei Li wrote:
>>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>>> index 57ed49f20d2e..7b537afe8b38 100644
>>> --- a/include/linux/blkdev.h
>>> +++ b/include/linux/blkdev.h
>>> @@ -1349,12 +1349,7 @@ static inline int blk_rq_aligned(struct request_queue *q, unsigned long addr,
>>>    /* assumes size > 256 */
>>>    static inline unsigned int blksize_bits(unsigned int size)
>>>    {
>>> -	unsigned int bits = 8;
>>> -	do {
>>> -		bits++;
>>> -		size >>= 1;
>>> -	} while (size > 256);
>>> -	return bits;
>>> +	return order_base_2((size + SECTOR_SIZE - 1) >> SECTOR_SHIFT) + SECTOR_SHIFT;
>>>    }
>>
>> Why the rounding ("+ SECTOR_SIZE - 1")? The blksize_bits() argument should
>> be an argument of two.
> 
> Yeah, that's what's supposed to be.
> But I thought maybe a "just in case" is more robust?
> Should we consider these corner cases(!is_power_of_2())?

I don't think that the Linux kernel supports block sizes that are not a 
power of two. Hence my request to leave out the rounding code. Keeping 
that code would be misleading because it would suggest that the 
blksize_bits() argument can be something else than a power of two.

Thanks,

Bart.

