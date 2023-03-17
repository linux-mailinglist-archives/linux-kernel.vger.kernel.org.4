Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0A36BF55E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 23:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjCQWxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 18:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjCQWxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 18:53:10 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2C9D30B2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 15:53:08 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id l15so1976769ilv.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 15:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1679093588; x=1681685588;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tZQKt8PEtqewJ6G+XTz4rdS+nQPMdiG14rkUN1r/CVQ=;
        b=gMqOXd0bTw4YEjnZpmHxvcSTK+Jt6ubljQfAnP7h0+tG/Ri2ZPlywPCqXD2x9GdssH
         iXKDhXh+qiwf2qrcr/syJjphlyrI3nZS/tN2Ox0AKnh5qxrGePPCeRIsTxtiarKHRyVU
         i5u87187EG/8X4PT832d5VuUfkfgdkUkm0a2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679093588; x=1681685588;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tZQKt8PEtqewJ6G+XTz4rdS+nQPMdiG14rkUN1r/CVQ=;
        b=lCCN3jhvJxipEDq4AL+v/0B42lrYUNVqGm9kiUv8TpmvTIhC8GvJ9cvbHgOKlXY8NK
         h7AswfZQZYQEbByNMi2QJqizrJiT6NSXOsgSJj/dGJoiRr/QjHiU+IlQWIsdKTOHq1Q8
         UzeHSddhc47f6OekBEHs/RFLmVi8gCUPm6Ob2PJs36RSd+7w8JsCJqR2dvj9SRdP5cvU
         0zHBcjTJ+XKFV1+xCrlOvANHX+M+iCTnVYmJ3B8C014jVDMQlElq9sYYZ0we1Ful0IJM
         aZeRMdbeWsdjQs914PYBIH/gtrBN72DyL7/PK+UKPy1l1FFfek8OUTE7Wu88OtNH/+4y
         bUzA==
X-Gm-Message-State: AO0yUKWuGCNPb36rOW80rIdk8qtSXtcKjvxt+ke/nfX00USlXiVPhTAW
        U0JSMRkNKlRNe85m1JcnVUf/Gw==
X-Google-Smtp-Source: AK7set/moJNFKwD/r58i9ms7d34NV3sMr/vetji1mhQmMNaRhRj5dNSSmlbXgRAn/i8tpm7gWmklKw==
X-Received: by 2002:a05:6e02:1a88:b0:316:67be:1b99 with SMTP id k8-20020a056e021a8800b0031667be1b99mr7475616ilv.0.1679093588264;
        Fri, 17 Mar 2023 15:53:08 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id o3-20020a056e02114300b003158e48f1e9sm928296ill.60.2023.03.17.15.53.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 15:53:07 -0700 (PDT)
Message-ID: <d05ae776-ee19-2ce0-c06b-9825e5cbea82@linuxfoundation.org>
Date:   Fri, 17 Mar 2023 16:53:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3] usbip: vudc: Fix use after free bug in vudc_remove due
 to race condition
Content-Language: en-US
To:     Zheng Wang <zyytlz.wz@163.com>, valentina.manea.m@gmail.com
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, hackerzheng666@gmail.com,
        1395428693sheep@gmail.com, alex000young@gmail.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230317100954.2626573-1-zyytlz.wz@163.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230317100954.2626573-1-zyytlz.wz@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/23 04:09, Zheng Wang wrote:
> In vudc_probe, it calls init_vudc_hw, which bound &udc->timer with v_timer.
> 
> When it calls usbip_sockfd_store, it will call v_start_timer to start the
> timer work.
> 
> When we call vudc_remove to remove the driver, theremay be a sequence as
> follows:
> 
> Fix it by shutdown the timer work before cleanup in vudc_remove.
> 
> Note that removing a driver is a root-only operation, and should never
> happen. But the attacker can directly unplug the usb to trigger the remove
> function.
> 
> CPU0                  CPU1
> 
>                       |v_timer
> vudc_remove          |
> kfree(udc);          |
> //free shost         |
>                       |udc->gadget
>                       |//use
> 
> The udc might be removed before v_timer finished, and UAF happens.
> 
> This bug was found by Codeql static analysis and might by false positive.

This statement that this could be a false positive makes me hesitate
taking this patch.

What kind of testing have you done with this fix? Were you able to test
the scenario of unplugging usb?

thanks,
-- Shuah
