Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8DE6D992B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 16:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239043AbjDFOKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 10:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238380AbjDFOJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 10:09:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52CB9750
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 07:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680790095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AT1MAIP9v4DHYB4m5xHxagncHIIMlg0uERfKC+FM+xk=;
        b=cfEYLmMYwan/tDPoh5e2ctTDMl9G9Zx6uTF8crXC2xKAZeY6CkKO3Wp9nkmQV6A5d1Hzuv
        NpKuqn2pgMRl1j+dnIaoHOBmyaaYRgJeYZGAARjrPckQAiYXDtyapir8AHUOZNX5E+25xY
        BtGZWzLNsU8dIFDzkbZuykcZYt1o9RU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93--1srl5QOO_2m-vk1gQ05tQ-1; Thu, 06 Apr 2023 10:08:14 -0400
X-MC-Unique: -1srl5QOO_2m-vk1gQ05tQ-1
Received: by mail-ej1-f71.google.com with SMTP id vg10-20020a170907d30a00b0094807746cebso295175ejc.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 07:08:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680790093; x=1683382093;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AT1MAIP9v4DHYB4m5xHxagncHIIMlg0uERfKC+FM+xk=;
        b=ZRWHhgHQFsrgGAuCyqP+OH6kJ+5l1SU7DJa338wzNXj0oXSylRnoz8HH8dudepMH9x
         CfpLPk8jyLcjlASq2eJERdNUSStgMbVAJSkbyoeY3c/6q7Fs7T/xLZ4mWiVUfjhg5MQM
         PmnHkA2oQPy4um8Q/7HMVQXl1mtN+Iaq3bWQxOPNQnd6YgC3jCVJaZ7NfoKyqH8+qtTt
         HG91qqNEkth9l/3rp/dwGJKGoL6uqJ5JvVCev+lCV+GS/Bb0D4UwJ6xUWpDKbUrMqLiH
         qBmYBOXtHpIuVMBBLuQmIg7CZlTCKfPBBOVbSjK9t67KmPStK9HuYywB0CwC/t3+W7Rj
         aYZg==
X-Gm-Message-State: AAQBX9e0laL1JDpZmc3rV3rvgZMlteIdGASRJFx0g8d5i/Je/19N7mAq
        3V7gnnmUXIWpzBMcxOyzGLiRubhCWKqPx8kHVdeZDJmYQ8/Cc/Ri2OFyMRFqGBvVmNuJ6ALEX1w
        AkWDnmYQIs0tzNX5MxurGOTwg
X-Received: by 2002:a17:907:a042:b0:93f:2114:9a1c with SMTP id gz2-20020a170907a04200b0093f21149a1cmr6362887ejc.45.1680790093369;
        Thu, 06 Apr 2023 07:08:13 -0700 (PDT)
X-Google-Smtp-Source: AKy350aYnPYE5+ik5n4GldzrrnSl94ImQLUG+CLdBCsnooZZBbVL3WumeFjJnRY5TgvfVBKjxVz+Iw==
X-Received: by 2002:a17:907:a042:b0:93f:2114:9a1c with SMTP id gz2-20020a170907a04200b0093f21149a1cmr6362870ejc.45.1680790093074;
        Thu, 06 Apr 2023 07:08:13 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id s14-20020a170906bc4e00b0093338259b2bsm834536ejv.207.2023.04.06.07.08.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 07:08:12 -0700 (PDT)
Message-ID: <565e6575-91f7-9ca2-1505-17527b95a816@redhat.com>
Date:   Thu, 6 Apr 2023 16:08:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v7] Introduction-of-HP-BIOSCFG-driver-documentation
Content-Language: en-US, nl
To:     Jorge Lopez <jorgealtxwork@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Mark Pearson <mpearson-lenovo@squebb.ca>,
        =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <thomas@t-8ch.de>
Cc:     Linux x86 Platform Drivers <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>
References: <20230403211548.6253-1-jorge.lopez2@hp.com>
 <ZCuMkdb6jeL4S8hz@debian.me>
 <CAOOmCE-5NHkYcmBP1GGpr=sEoxF9jkjj1LevekEm8R0wbrM4xQ@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAOOmCE-5NHkYcmBP1GGpr=sEoxF9jkjj1LevekEm8R0wbrM4xQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

FWIW I have been reading along with both the v6 and
this v7 posting.

Thomas, Mark, thank you for your review / feedback
on this series.

On 4/4/23 15:37, Jorge Lopez wrote:
> Hi Bagas,
> 
>>
>> Where is the rest of patches if this is a series? Had they been merged?
>>
> 
> There is only one change as requested by  Thomas Weißschuh
> 
>> Feel free to ONLY submit the patch with the documentation for the next
>> revision. Then we can nail down the interface and initial functionality
>> and you don't always have to adapt the code to the changing interface.
> 
> Perhaps, I misunderstood Thomas request.   I will address a few other
> comments and will submit all files again.

I think that Thomas' suggestion to first focus on getting
the userspace API right and then implement the agreed
upon API is a good idea.

So for the next version just post only the documentation
patch again please.

Note it is not the intention to merge just the documentation
patch without merging the code first.

The idea is to first nail the API down and then modify
the code once to implement the agreed upon API.

Then once the API has been agreed upon post newer
versions which also include the code again.

And then once people are also happy with the code
we can merge both the code + documentation in one go.

Regards,

Hans







> 
> Regards,
> 
> Jorge
> 

