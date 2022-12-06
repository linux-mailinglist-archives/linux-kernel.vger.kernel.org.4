Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2EFC644332
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 13:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbiLFMce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 07:32:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234101AbiLFMcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 07:32:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3119A2935B
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 04:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670329885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=liaMtdwZz66knjpgHV1DLOGIhlv7I5qOXrHvC/9gpP0=;
        b=OOLyShxBjlXmHSvZ9nKN289Uab4NZEwwoTNTPXG2bGTa/V/w4B0hVsQw/Pg8Eitp1MoHfE
        zwUG2+u2X4qBTYwHqlwNgpo73TLMTo7vPpCmfxJ8iwdr+RlRF+lMOKaY7tGPcMyNgKMpBW
        9MJViAKA+GUKYBjfVMn86GHXCc8cdIk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-628-eGnbd74PMnGHVm80Ent7Hw-1; Tue, 06 Dec 2022 07:31:24 -0500
X-MC-Unique: eGnbd74PMnGHVm80Ent7Hw-1
Received: by mail-qv1-f70.google.com with SMTP id m4-20020ad44484000000b004c78122b496so2118473qvt.7
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 04:31:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=liaMtdwZz66knjpgHV1DLOGIhlv7I5qOXrHvC/9gpP0=;
        b=x9Yx3eLJblVoev3G/bEutc19G8W5FakqROqOYAw7x3pnbKVXq5BOoV2PaFatpJspkr
         K+Xb81dOCgKclc2uVCFt/ATxW+YrRcxqq2phK+HrP2agbtx3TGIopj9wdnx3kg+48X70
         fhGBtiVSfS4F5lgT4k0LzY+Vai44BJmp6poPy5EjYotekBloO3Mr49JMSY19LUFF/Sa6
         1oH4Xwafegi0Yn+wsxsgHNAepGnan0TLUEkksiEsunIda1hWCbFx/cXCJCLJliKgDHy/
         /MG9p5hmUMn0AGkAIeU8H0iD3XkuKGbAMfHX8WQvjG1WSmrmv9TjacYF4DHpnMmOU57I
         i5nQ==
X-Gm-Message-State: ANoB5pmRf6+sjG7b8/cpu9nFy232enpYX3tL7sPULMBi6mXhAbz1GX3c
        FbJyX4vQhK5TzMDQvi9qZGo/frA4UDbSmSQsTV0tp/6Qp7hj6PV1AQDEet+Rjkd2y8WjHW0Mv6H
        X6Aag6fpd1d1+64AS54Un3C8H
X-Received: by 2002:a05:622a:4819:b0:3a6:9d10:ad73 with SMTP id fb25-20020a05622a481900b003a69d10ad73mr14582785qtb.458.1670329883247;
        Tue, 06 Dec 2022 04:31:23 -0800 (PST)
X-Google-Smtp-Source: AA0mqf53vvDbZ1mrEzLJQBK38Cb3qg6pzjo2PWIWJ0YIbwTN4hxH+XLtHWEDvimTYM0c3lguIYE0DQ==
X-Received: by 2002:a05:622a:4819:b0:3a6:9d10:ad73 with SMTP id fb25-20020a05622a481900b003a69d10ad73mr14582758qtb.458.1670329882886;
        Tue, 06 Dec 2022 04:31:22 -0800 (PST)
Received: from [10.16.222.26] (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id o1-20020ac841c1000000b0039cc82a319asm11371995qtm.76.2022.12.06.04.31.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 04:31:22 -0800 (PST)
Message-ID: <2e8d862d-fa3d-0879-9097-215d17cb1fed@redhat.com>
Date:   Tue, 6 Dec 2022 07:31:21 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 2/2] module: Merge same-name module load requests
Content-Language: en-US
To:     Petr Mladek <pmladek@suse.com>, Petr Pavlu <petr.pavlu@suse.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <YzdR0gRNQI2BGnJ9@bombadil.infradead.org>
 <aa8d9456-b260-d999-0296-8e6ab876af7a@suse.com>
 <Y07xX2ejlg0oFoEy@bombadil.infradead.org>
 <d0bc50e3-0e42-311b-20ed-7538bb918c5b@suse.com>
 <Y277Jb9i2VeXQoTL@bombadil.infradead.org>
 <e070839f-c224-047b-9411-91143c1d8394@redhat.com>
 <Y3Jg8X7qv2AKPU1J@bombadil.infradead.org>
 <5467e66d-55de-ca8f-c1ae-ffe6efe7290d@redhat.com>
 <94cd5565-1058-2c97-57bb-0ddf12416cd6@redhat.com>
 <2ac0b871-60d0-c535-3fe0-bfaa0d9f7685@suse.com> <Y4opfN6MTsFhrYfu@alley>
From:   Prarit Bhargava <prarit@redhat.com>
In-Reply-To: <Y4opfN6MTsFhrYfu@alley>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 
>> Could you please boot the machine with 'udev.log_level=debug' and provide me
>> logs ('journalctl -b -o short-monotonic') from a run with the vanilla kernel
>> and with the discussed patch?
> 

Petr, I tried to in-line the logs however the email bounced due to its size.

I know this isn't a preferred method of passing information on LKML and 
other lists, but here are links to the logs:

https://people.redhat.com/prarit/4petr/

Both outputs were done with, as requested, 'journalctl -b -o 
short-monotonic'.

vanilla.log is kernel booted with 'udev.log_level=debug'
with-changeset.log is kernel + patch booted with 'udev.log_level=debug'

P.

