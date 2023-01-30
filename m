Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF29681534
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 16:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236099AbjA3PhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 10:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjA3PhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 10:37:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1C230E6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 07:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675092983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RBmhX41BoXlyvE9x/O8OKKatZjRg7MheACF8SvOJv6k=;
        b=C+w+sWqiF71S7n0mPRtvPc3zpgSKaYYHTR+JLSaGsSIMrujO5Dq/jLk3zx412YZ2B1mtHu
        k3H6cUiyAWh1wsQHhrxE0tMOivnd3b+CeyZ8tSpW9qvIYNcLJ2pYULS7k1wuunwmzJ52yR
        ECcOi+bhncqDVva82bMfqOfS+h3lcWU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-385-sIj5oArnM0KGAbb-XpSN9Q-1; Mon, 30 Jan 2023 10:36:21 -0500
X-MC-Unique: sIj5oArnM0KGAbb-XpSN9Q-1
Received: by mail-ed1-f72.google.com with SMTP id l17-20020a056402255100b00472d2ff0e59so8486273edb.19
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 07:36:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RBmhX41BoXlyvE9x/O8OKKatZjRg7MheACF8SvOJv6k=;
        b=Idm+hzmNndyAY62XnbrLdmEoAu8rAwW6d4NM3i5tRo6JHhDFWVif/oNf9JfYjP5rN1
         hK5jWbpS/wXNq0r5/Ollht+XmEdgRZue4Qu6DPd53BHUZ3tkB8tdUhbtelzHirzdX+a0
         NbQZxunaxAcsETVRzUDSaUza+egArKRzVg1c3XY4kW3UQUGaz3G6R6vPgkpxYt7Octwa
         f8Ry0VdST7Qmwi+5eDhlf8rKNpTfiUyR9dGZLrY1G+RGi/CRMDFUDDSjMUvEziZeta5+
         VQ927wCFjXMdiCOL2AdqTvGlkwU4h85OYs/yfEtPcEmSnnKBqY9vbllboCjgpreyJQAn
         teww==
X-Gm-Message-State: AO0yUKUdTwooHfKveX/7rGsmUs/V7X7aWJL2zfJyv9wRofE5QTJAnC/0
        bKiKqdFAgL3Xc22zVz5s/HXPIF9YSNe0n7MJTXhdbwr2nlITKMB75hggUzB9Q1Dybm0upqEckwO
        3z+lG8kmNAooqleM3xbiGtQiF
X-Received: by 2002:a17:906:4a59:b0:886:ec6e:4c1 with SMTP id a25-20020a1709064a5900b00886ec6e04c1mr6454894ejv.59.1675092980080;
        Mon, 30 Jan 2023 07:36:20 -0800 (PST)
X-Google-Smtp-Source: AK7set+iwFqcC78NFurgo3bhkb5NPKHsAOZddnvdfeU+KEBISZuuSpVuTjQaU3Y4xTKUT0U0sl7I8g==
X-Received: by 2002:a17:906:4a59:b0:886:ec6e:4c1 with SMTP id a25-20020a1709064a5900b00886ec6e04c1mr6454876ejv.59.1675092979905;
        Mon, 30 Jan 2023 07:36:19 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id b14-20020a1709062b4e00b00880d9530761sm4417556ejg.209.2023.01.30.07.36.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 07:36:19 -0800 (PST)
Message-ID: <506d3a5d-45f3-3c2c-ad2e-b6609814dc5c@redhat.com>
Date:   Mon, 30 Jan 2023 16:36:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] platform/x86: dell-smo8800: Use min_t() for comparison
 and assignment
Content-Language: en-US
To:     Deepak R Varma <drv@mailo.com>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
References: <Y9P8debIztOZXazW@ubun2204.myguest.virtualbox.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <Y9P8debIztOZXazW@ubun2204.myguest.virtualbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/27/23 17:31, Deepak R Varma wrote:
> Simplify code by using min_t helper macro for logical evaluation
> and value assignment. Use the _t variant of min macro since the
> variable types are not same.
> This issue is identified by coccicheck using the minmax.cocci file.
> 
> Signed-off-by: Deepak R Varma <drv@mailo.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans


> ---
>  drivers/platform/x86/dell/dell-smo8800.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell/dell-smo8800.c b/drivers/platform/x86/dell/dell-smo8800.c
> index 3385e852104c..8d6b7a83cf24 100644
> --- a/drivers/platform/x86/dell/dell-smo8800.c
> +++ b/drivers/platform/x86/dell/dell-smo8800.c
> @@ -67,10 +67,7 @@ static ssize_t smo8800_misc_read(struct file *file, char __user *buf,
>  
>  	retval = 1;
>  
> -	if (data < 255)
> -		byte_data = data;
> -	else
> -		byte_data = 255;
> +	byte_data = min_t(u32, data, 255);
>  
>  	if (put_user(byte_data, buf))
>  		retval = -EFAULT;

