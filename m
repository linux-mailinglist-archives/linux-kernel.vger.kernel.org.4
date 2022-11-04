Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7CDE619B44
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 16:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbiKDPSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 11:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbiKDPSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 11:18:20 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193512497D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 08:18:19 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id h193so4611830pgc.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 08:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vdYOviAQx89yxTqP8I/2vP959IYnbzOSiQXvLwhkYv8=;
        b=Hz0aO6DNjl8dua2dkdqX2SMbs8U9SZluEHymOISTkL0IYkWQv4CLNPpyt8ak5S5wVW
         SDVmOdnDiNb2eNvxNqwHoVLMW86egSJJBzqENrEx/ckb34Vi6rfZuY/ctCZNAGIZKhey
         Wzl14aMKC8OfL98AgVonUxAAKKbgrJMFiaQpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vdYOviAQx89yxTqP8I/2vP959IYnbzOSiQXvLwhkYv8=;
        b=E2Ic1tVINupWyVBpnRwp/AmpRGEwslHgRfjvfiKLvc+YgjFmofvkhpDyGuNuMoYc0z
         XcmiLhfGHkO6OicoTEs2CgbgRPO3GQ86s9X8lD6gnFYv8NzyU0y3BtIwWV/Fflt2Ziou
         rdMmvhw3/3DwPAnMFjw3Ybw3jW5bgn2eA/lzzZZZOgp0/vB79Q4nyf1x1RyvMuGq7fpA
         qrGSIjTW+qX273tDPsA2fv72zUX0hwfTXP5nLo1CgzFj6XJtrtk1SFzjXlAXBUt01IVe
         83VdpbLw2oOfUdBN+kSL8H/XRu2Firvex+M+xE3yeSvqXLvLe3doojL66fhua/6xwJHf
         +/UQ==
X-Gm-Message-State: ACrzQf02Rzdu2xT1OURTb36apW2z4MqpDVc+A1GljB6cLUeUFv2wBqBF
        3r6y8oUfRUnNLvbFkBasxnTQPQ==
X-Google-Smtp-Source: AMsMyM4LdickqCi0ZxMpoY3bMpaRogM51gkh4/airPlRbKeqxuHaEVpRg8A+kd7acI8EFKAhdj0KPA==
X-Received: by 2002:aa7:8e9e:0:b0:56b:bbca:dd98 with SMTP id a30-20020aa78e9e000000b0056bbbcadd98mr36470984pfr.7.1667575098495;
        Fri, 04 Nov 2022 08:18:18 -0700 (PDT)
Received: from [192.168.0.168] ([103.99.10.63])
        by smtp.gmail.com with ESMTPSA id i5-20020a056a00004500b0056a93838606sm2868901pfk.58.2022.11.04.08.18.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 08:18:17 -0700 (PDT)
Message-ID: <e68cb73b-14ae-8c60-7fd6-f2aec4b6bfff@linuxfoundation.org>
Date:   Fri, 4 Nov 2022 09:18:13 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/2] usb/usbip: fix uninitialized variables errors
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     shuah@kernel.org, valentina.manea.m@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1667480280.git.skhan@linuxfoundation.org>
 <76654f2f1cc30b27be10ac9b177bb449a7ad7068.1667480280.git.skhan@linuxfoundation.org>
 <Y2PAd79kMEbt0HNf@kroah.com>
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <Y2PAd79kMEbt0HNf@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/22 07:21, Greg KH wrote:
> On Thu, Nov 03, 2022 at 07:12:42AM -0600, Shuah Khan wrote:
>> Fix uninitialized variable errors reported by cppcheck. One example
>> below.
>>
>> usbip/stub_main.c:284:10: error: Uninitialized variables: priv.seqnum, priv.sdev, priv.urbs, priv.sgl, priv.num_urbs, priv.completed_urbs, priv.urb_status, priv.unlinking [uninitvar]
>>    return priv;
>>
>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>> ---
>>   drivers/usb/usbip/stub_main.c     | 2 +-
>>   drivers/usb/usbip/stub_rx.c       | 4 ++--
>>   drivers/usb/usbip/stub_tx.c       | 4 ++--
>>   drivers/usb/usbip/usbip_event.c   | 2 +-
>>   drivers/usb/usbip/vhci_hcd.c      | 2 +-
>>   drivers/usb/usbip/vhci_rx.c       | 2 +-
>>   drivers/usb/usbip/vhci_tx.c       | 4 ++--
>>   drivers/usb/usbip/vudc_dev.c      | 2 +-
>>   drivers/usb/usbip/vudc_rx.c       | 2 +-
>>   drivers/usb/usbip/vudc_transfer.c | 4 ++--
>>   10 files changed, 14 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/usb/usbip/stub_main.c b/drivers/usb/usbip/stub_main.c
>> index e8c3131a8543..e1248b971218 100644
>> --- a/drivers/usb/usbip/stub_main.c
>> +++ b/drivers/usb/usbip/stub_main.c
>> @@ -277,7 +277,7 @@ static DRIVER_ATTR_WO(rebind);
>>   
>>   static struct stub_priv *stub_priv_pop_from_listhead(struct list_head *listhead)
>>   {
>> -	struct stub_priv *priv, *tmp;
>> +	struct stub_priv *priv = NULL, *tmp;
>>   
>>   	list_for_each_entry_safe(priv, tmp, listhead, list) {
> 
> cppcheck is wrong here, the code is fine, and setting priv to NULL does
> nothing.  If it was required, gcc would have hopefully caught it, and
> the code would have never worked :)
> 
> So are you sure all of these changes are really needed?  Last time I
> looked, cppcheck wasn't all that smart when it came to the kernel and
> threw up huge numbers of false-positives, like this one.
> 

You are right that this one is a false positive. I will take a close look at
the others in this patch.

thanks,
-- Shuah

