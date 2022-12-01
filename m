Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C3D63F0C4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 13:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbiLAMol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 07:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbiLAMoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 07:44:39 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CA48C69E;
        Thu,  1 Dec 2022 04:44:34 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id r12so2343950lfp.1;
        Thu, 01 Dec 2022 04:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v2GY69jusU/mBlmClfS6uxaeALsSCNKp6YY6dbnus1o=;
        b=iUy4QVdNagyOvFz7JPCTZ3sDR8j/ETEy8hEu73cEks9T1BWkSccnuCCshnDDXCFG3k
         fJRvBG+3qPVxRqhWuaZxY+2pvM8uRbbVe/GkkCpuo8VUGK+ohnhYP0bJ/2Iqm7EA2Mct
         3luIlHm1TCJDOSPVD1WEoI9NppO+j1M8zjhpPl9UU5JHdzIkJtARbaZGxtMrDQYhwCQU
         DkajAjL7KTHmKSIZiZHMqkuRU8SkJisfVobMC3SDjiqB75nKvvUELVXBS+8nIPw1puQI
         Fp3kPzBCKvGlXZ95jykferJ7aTutA1+aSJLSXMofZXt4AmHJF377Lf4npWKy/LKIMAXX
         VU2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v2GY69jusU/mBlmClfS6uxaeALsSCNKp6YY6dbnus1o=;
        b=AL2nkXas8EJiXs8LsTQlyKE6Pw2vWwAEiYlxORAmeZ2jg7COvqHWBH/WRTPzWYrUpi
         X9PE+J/6puh3i5R0vB6bxSkkbfRCbJV0pYT28G8DRplYABgIedH7q6GruVav9Db0fqX7
         cI3L3lEaWAffLgc6vU3XUTMqaOl7EtJeBb6ba6OEjHtogvW33Sg/l6GArEyoAyKBAVh+
         bGA5mqyY6XmFtHS4vHGXmeT5PT0lCoEuoodfS96QS218v1UHLht94VrnaShNjCYfyxVe
         njGOlKXmAlI0vEd/kYSJ45ZR1fh0ygNiS4q1YnAto+5XYLNcVYnorKI3lf+lHm+6uHcs
         ByMg==
X-Gm-Message-State: ANoB5pml2wsdcrrRnj6acs7DpgCK05fQgnV/HJMC6doAPfbeXRx+RSDR
        y329mQJrS8lnFXC+VDI7HHY=
X-Google-Smtp-Source: AA0mqf5MYuhbPzmQivrlrkVQVD9uARAz4TrlEru/mbwbPYfDtjg6iMVLMCd7JJDXi/+FXWu0H81KFw==
X-Received: by 2002:ac2:4822:0:b0:4a7:648d:a7a6 with SMTP id 2-20020ac24822000000b004a7648da7a6mr21513375lft.588.1669898673144;
        Thu, 01 Dec 2022 04:44:33 -0800 (PST)
Received: from [192.168.50.20] (077222238151.warszawa.vectranet.pl. [77.222.238.151])
        by smtp.gmail.com with ESMTPSA id b21-20020ac24115000000b004a2511b8224sm637755lfi.103.2022.12.01.04.44.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 04:44:32 -0800 (PST)
Message-ID: <067f0a84-2b73-f7ef-fe05-5d5015b68eab@gmail.com>
Date:   Thu, 1 Dec 2022 13:44:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH] Prevent buffer overflow in UVC Gadget setup handler
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     laurent.pinchart@ideasonboard.com, Felipe Balbi <balbi@kernel.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221201122141.8739-1-szymon.heidrich@gmail.com>
 <Y4ieBScmqVbZMrf9@kroah.com>
From:   Szymon Heidrich <szymon.heidrich@gmail.com>
In-Reply-To: <Y4ieBScmqVbZMrf9@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12/2022 13:28, Greg Kroah-Hartman wrote:
> On Thu, Dec 01, 2022 at 01:21:41PM +0100, Szymon Heidrich wrote:
>> Setup function uvc_function_setup permits control transfer
>> requests with up to 64 bytes of payload (UVC_MAX_REQUEST_SIZE),
>> data stage handler for OUT transfer uses memcpy to copy req->actual
>> bytes to uvc_event->data.data array of size 60. This may result
>> in an overflow of 4 bytes.
>>
>> Signed-off-by: Szymon Heidrich <szymon.heidrich@gmail.com>
>> ---
>>  drivers/usb/gadget/function/f_uvc.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> What commit id does this fix?  Is it needed for stable kernels?
> 
> thanks,
> 
> greg k-h

As far as I understand this would be the original commit so cdda479f15cd13fa50a913ca85129c0437cc7b91.
I guess that it is also needed for stable kernels, yet please correct me if I'm wrong.

Best regards,
Szymon
