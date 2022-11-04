Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F378619B4A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 16:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbiKDPT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 11:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbiKDPTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 11:19:20 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D131FCE1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 08:19:19 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id b29so4760521pfp.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 08:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8apT4eVkkD0mxbgZ0g9ISPIN8xvExLpriY4AODux6RY=;
        b=KMh/l4yCOdL5Z2sjK7qou2oHfbKnjVjAqqrwf7XKu3NcE+iQgZS6QaAGL6IAx6l96H
         QSV4jxVtY3Rrnsk+wwjpF1U0dOB+vQCmHLPcTJe6iH0l3N8PtDgj0BeQcCqF02rbCkfM
         JYyNSrTdgkjwQSdAUqdTkvApKG1w0BKwZfWYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8apT4eVkkD0mxbgZ0g9ISPIN8xvExLpriY4AODux6RY=;
        b=Wuw8mYgIyMpEYXjPs8lF6qQqyHpyHr9i8cOLveeNP4zJbigBqKFlSqnTMcDQXgI/tp
         AtlIPNANIVv181qp9wiTzWWjmL9T4vnUsjIPML9ZqAGrP1TGpnGfvzVbdnyuqtDK8vmD
         kr9b4sg2e4AboqfTRm95pKYYwYDCWyyAQS+bATYMs1TaFS8Cg0gctjeu8h2r2Da1uNXr
         J7y6GN3ZfsgdkQPqqLbCFWvfISbIL77lk7RgB3WMJkRcRRO4ytINEwaT0HJqUD3mumwk
         C/kwKYbiZWP5EpSl1uVeUj/Gxu5LDcW2OPeHvlECxHG5fe57gX0z6iZv4blKdagvja+j
         XoHQ==
X-Gm-Message-State: ACrzQf29HjV5+lO8EwVeZgB6vhDdEHVEb2PA2oYFZUEHa4lLE52MYdJZ
        fnSijja9GRmEMUUaWIEvXoaBDwx7tmkS32hE
X-Google-Smtp-Source: AMsMyM4weNXyqaLX2E9O09FwEt5CSAPOVMxPKNcgQ0fBGfelaxaBqWc9YpA1NL4/gO8yaRmlwaw3sw==
X-Received: by 2002:a63:6986:0:b0:43c:8417:8dac with SMTP id e128-20020a636986000000b0043c84178dacmr30784081pgc.286.1667575158871;
        Fri, 04 Nov 2022 08:19:18 -0700 (PDT)
Received: from [192.168.0.168] ([103.99.10.63])
        by smtp.gmail.com with ESMTPSA id pb13-20020a17090b3c0d00b0020d51aefb82sm1805735pjb.19.2022.11.04.08.19.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 08:19:18 -0700 (PDT)
Message-ID: <439a5b08-17e8-e603-ddf3-1865a63385d4@linuxfoundation.org>
Date:   Fri, 4 Nov 2022 09:19:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 2/2] usb/usbip: Fix v_recv_cmd_submit() to use PIPE_BULK
 define
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     shuah@kernel.org, valentina.manea.m@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1667480280.git.skhan@linuxfoundation.org>
 <c9790c485bfe31c55bbd2f9b270548ecefddc91a.1667480280.git.skhan@linuxfoundation.org>
 <Y2PBA5hmqm9G/DNT@kroah.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <Y2PBA5hmqm9G/DNT@kroah.com>
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

On 11/3/22 07:24, Greg KH wrote:
> On Thu, Nov 03, 2022 at 07:12:43AM -0600, Shuah Khan wrote:
>> Fix v_recv_cmd_submit() to use PIPE_BULK define instead of hard coded
>> values. This also fixes the following signed integer overflow error
>> reported by cppcheck. This is not an issue since pipe is unsigned int.
>> However, this change improves the code to use proper define.
>>
>> drivers/usb/usbip/vudc_rx.c:152:26: error: Signed integer overflow for expression '3<<30'. [integerOverflow]
>>   urb_p->urb->pipe &= ~(3 << 30);
>>
>> In addition, add a sanity check for PIPE_BULK != 3 as the code path depends
>> on PIPE_BULK = 3.
>>
>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>> ---
>>   drivers/usb/usbip/vudc_rx.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/usbip/vudc_rx.c b/drivers/usb/usbip/vudc_rx.c
>> index a6ca27f10b68..e7e0eb6bbca0 100644
>> --- a/drivers/usb/usbip/vudc_rx.c
>> +++ b/drivers/usb/usbip/vudc_rx.c
>> @@ -149,7 +149,10 @@ static int v_recv_cmd_submit(struct vudc *udc,
>>   	urb_p->urb->status = -EINPROGRESS;
>>   
>>   	/* FIXME: more pipe setup to please usbip_common */
>> -	urb_p->urb->pipe &= ~(3 << 30);
>> +#if PIPE_BULK != 3
>> +#error "Sanity check failed, this code presumes PIPE_... to range from 0 to 3"
>> +#endif
> 
> Perhaps use BUILD_BUG_ON() instead of hand-rolling one?
> 

Makes sense. I will send v2.

thanks,
-- Shuah

