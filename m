Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADCB6A6CA1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 13:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjCAM44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 07:56:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjCAM4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 07:56:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0652CFDD
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 04:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677675369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QloCqIzFJ103z7EFMv3i1y8ztq8Zv4HQgkOwMdkYw0Q=;
        b=T2I+d8BKfrTpzQ64E7R0ak5XnVDbLo8GGXCACxaaLLY/lvSfRwyn/3bfZl0R0hbDOV0EAj
        zckkA71iGTMKwvnENgcRMucjIGs9jRl9OWa4Ib/BMcFcSm2+QNSWCkWjoSfOhWclgW5Y2a
        JCF9OdA05o81BgWlD60fukFprRUMZv8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-499-Tih7MDaqM3W0Cra7KS3LSQ-1; Wed, 01 Mar 2023 07:56:08 -0500
X-MC-Unique: Tih7MDaqM3W0Cra7KS3LSQ-1
Received: by mail-ed1-f71.google.com with SMTP id c1-20020a0564021f8100b004acbe232c03so18780544edc.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 04:56:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QloCqIzFJ103z7EFMv3i1y8ztq8Zv4HQgkOwMdkYw0Q=;
        b=0f6vPozpQbNbFnxiShufkR5hpMZQdaAmGJt5Ka4a4rH6OtTDdfFWCro3PZfKqLYSDD
         jVfeIAn5LgtJpujlvixu8HT0+WowVNsvNeMl0VW5KcHmtJLL08d73I8yHJA4oa/BF6GR
         In5ZyplIajDG3EBdOHupmXvOgAAGUQ9EBPsBh6WJI1Yq2rc0yo7AqeWjzlRu9qhOmUGe
         O4h38brqh3WjXWyts6saUVdcg7NgX3O6s2qeylPXu2gVQLZkPnN24gcPHWtRaNPgXzkX
         VFsxrqBDZU4SsIG1agDqFU+05pWoP5wTFoOseWePTVGOH8bPZn/kRj2oXGdGP2BReYCa
         Si8g==
X-Gm-Message-State: AO0yUKXYPw2K2ZiR1eFBIgy2C3X5CB4Lh+eDH6+uNMWdQzpo3rXewP3C
        X6YX4xu7X6e2YIqB5qqEoMdzj4MzLk7Q0ehjjZKXRY2MxEEN8QqMumdPdAwTqlGPAc7H1oCd78Y
        77zqQLOjTEjzH1ZHJ+vzfL+yy
X-Received: by 2002:a17:906:48c1:b0:8e9:9e13:9290 with SMTP id d1-20020a17090648c100b008e99e139290mr6491259ejt.27.1677675367024;
        Wed, 01 Mar 2023 04:56:07 -0800 (PST)
X-Google-Smtp-Source: AK7set/59eypjVPDIwLIkunAv9i5TU5ri7ovQHmhkjP+rJYeEiaIas4XAhCCEjP2YEewBgFb34pM0g==
X-Received: by 2002:a17:906:48c1:b0:8e9:9e13:9290 with SMTP id d1-20020a17090648c100b008e99e139290mr6491250ejt.27.1677675366778;
        Wed, 01 Mar 2023 04:56:06 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id l24-20020a170906939800b008cf1b61a73esm5695521ejx.41.2023.03.01.04.56.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 04:56:06 -0800 (PST)
Message-ID: <0d0e0ca7-5d49-dab9-0f1b-eee30c3360d4@redhat.com>
Date:   Wed, 1 Mar 2023 13:56:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 0/5] apple-gmux: support MMIO gmux type on T2 Macs
Content-Language: en-US, nl
To:     Aditya Garg <gargaditya08@live.com>
Cc:     Orlando Chamberlain <orlandoch.dev@gmail.com>,
        Mark Gross <markgross@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Seth Forshee <sforshee@kernel.org>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Kerem Karabay <kekrby@gmail.com>
References: <BM1PR01MB0931B467250831916F7C55B3B8A59@BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM>
 <60dad2c6-9f37-86af-5f37-aa5d45c33afa@redhat.com>
 <BM1PR01MB093194DDA465CE8D9F081A05B8A59@BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <BM1PR01MB093194DDA465CE8D9F081A05B8A59@BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM>
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

On 2/21/23 20:07, Aditya Garg wrote:
> Hi
> 
>> Currently the backlight registration in apple-gmux.c is unconditional
>> (if a GMUX is detected).
>>
>> I have attached a patch to make it honor the acpi_backlight=xxx
>> kernel commandline option like most other x86/ACPI backlight drivers
>> do, please give this a test.
>>
>> Regards,
>>
>> Hans
> 
> I had to modify the patch a bit to make it apply alongwith the gmux patches by Orlando, and the bug seems to be fixed now.
> Attaching the patch I applied with this email.

Yes I didn't have Orlando's patches in my tree when preparing this.

Thank you for testing this. I'll rebase the patch on top of Orlando's
patches once those have been merged and then officially submit
it for review + merging.

Regards,

Hans

