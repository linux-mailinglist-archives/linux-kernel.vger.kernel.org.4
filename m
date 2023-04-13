Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4166E13D5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 20:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjDMSBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 14:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDMSBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 14:01:46 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52885FFC
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 11:01:45 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-760c1762f7dso760939f.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 11:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1681408905; x=1684000905;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ij6zwJrpntmJePBZisrDXJzAEzTHSMkMI1ovFIrxG50=;
        b=XaB/gmdvlYhqzZIYnL3QtCa/98iuJIobHANgi10fzRIvdz96A8kWnp3mbrIk62NCvy
         0wZpZyH50iP2qhrZfsVkkUXc043lozBp0zU2M2YfMxCy8CUBeN5vJN67SrKxDjgERmli
         W5MhCSpXoOG8s9fs3mOTfqfPhRMpqQal5HVGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681408905; x=1684000905;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ij6zwJrpntmJePBZisrDXJzAEzTHSMkMI1ovFIrxG50=;
        b=UOWOGZIiBJCJmL3hRZ5y54pb6xwdVDLJSZP1wefUw51S3zZDyO5/z3c2c7rZKIlq5p
         uMwWWs+lNSyvSb4NxRl9Y0/ujIh51SkFmt70ByTCNfYQHqcZV72vYdpBsG1dWAFUJLjp
         7cBhXdYnvMNvYdh6A7RoifEJfQpi2/gAFGFv0JGw7uVqnND6FUSzqfNCy8y1VtfB0+XD
         gaoqz7duD5FnioPUThl41+cTbfGB4Z4Ok8Uirex1orEUAUJro2hHvujgfa9We8QdzNOZ
         luIXTTcqlCNoKR2pLEtnxcYSjGCQ5VaSIHwkca1RDAyclnixe9uWwvkeY5VrA5TDeWxk
         DYKg==
X-Gm-Message-State: AAQBX9dvz6goWeWv2fxZp91JnYzrOZBukk/rssvDGvqR8KXZ5//atoUS
        pIIatEuCa6dEnhPbM7U8I9djVYHBasNVt2rBysA=
X-Google-Smtp-Source: AKy350ZXXA+4Kh6yy6AVWpLezmKVkL6jTAUotvMC2E6nPRx6IBUULK+YtAbwkzgUahy7lOxYr0ypJQ==
X-Received: by 2002:a05:6602:2c50:b0:758:9dcb:5d1a with SMTP id x16-20020a0566022c5000b007589dcb5d1amr1808246iov.2.1681408905130;
        Thu, 13 Apr 2023 11:01:45 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id v11-20020a02cbab000000b0040f019ae7a6sm626917jap.95.2023.04.13.11.01.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 11:01:44 -0700 (PDT)
Message-ID: <8219a54a-f83d-f31e-bd10-74660d829a06@linuxfoundation.org>
Date:   Thu, 13 Apr 2023 12:01:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3] usbip: vudc: Fix use after free bug in vudc_remove due
 to race condition
Content-Language: en-US
To:     Zheng Hacker <hackerzheng666@gmail.com>
Cc:     Zheng Wang <zyytlz.wz@163.com>, valentina.manea.m@gmail.com,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, 1395428693sheep@gmail.com,
        alex000young@gmail.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20230317100954.2626573-1-zyytlz.wz@163.com>
 <d05ae776-ee19-2ce0-c06b-9825e5cbea82@linuxfoundation.org>
 <CAJedcCwK8Z_nuBM4NnM1PwbTqTnfX2n6UEy9dd5LKf_GScq=xA@mail.gmail.com>
 <CAJedcCxT0ggGbVSQnqpcYcN=5gahUOEwGWZrP4P1Lz29A8Smqg@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CAJedcCxT0ggGbVSQnqpcYcN=5gahUOEwGWZrP4P1Lz29A8Smqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/23 02:09, Zheng Hacker wrote:
> Friendly ping about the issue.
> Sorry that I couldn't make test about the driver.
> 
> Thanks,
> Zheng
> 
> Zheng Hacker <hackerzheng666@gmail.com> 于2023年3月18日周六 15:39写道：
>>
>> Shuah Khan <skhan@linuxfoundation.org> 于2023年3月18日周六 06:53写道：
>>>
>>> On 3/17/23 04:09, Zheng Wang wrote:
>>>> In vudc_probe, it calls init_vudc_hw, which bound &udc->timer with v_timer.
>>>>
>>>> When it calls usbip_sockfd_store, it will call v_start_timer to start the
>>>> timer work.
>>>>
>>>> When we call vudc_remove to remove the driver, theremay be a sequence as
>>>> follows:
>>>>
>>>> Fix it by shutdown the timer work before cleanup in vudc_remove.
>>>>
>>>> Note that removing a driver is a root-only operation, and should never
>>>> happen. But the attacker can directly unplug the usb to trigger the remove
>>>> function.
>>>>
>>>> CPU0                  CPU1
>>>>
>>>>                        |v_timer
>>>> vudc_remove          |
>>>> kfree(udc);          |
>>>> //free shost         |
>>>>                        |udc->gadget
>>>>                        |//use
>>>>
>>>> The udc might be removed before v_timer finished, and UAF happens.
>>>>
>>>> This bug was found by Codeql static analysis and might by false positive.
>>>
>>> This statement that this could be a false positive makes me hesitate
>>> taking this patch.
>>>
>>> What kind of testing have you done with this fix? Were you able to test
>>> the scenario of unplugging usb?
>>>
>>
>> Sorry I did't make a full test for I did't have the device. The
>> attacking scenario if based on other cases.
>>

Sorry. I really need for you test this and provide information on how
it was tested.

thanks,
-- Shuah

