Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5184D609E3E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 11:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbiJXJqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 05:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiJXJq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 05:46:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A6555C72
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 02:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666604784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iJ+b2y7UqeW+tpjJ0iR2mEUHudPKaMh+lMgb9JMkYy4=;
        b=UD0V63q9Mc76L4gEo311oBG9qgszQLihjCvPU8VyOp731kxM9XA5khXNuSOyM9Q5VPl6Lo
        9r8ojbtS82eE7T+nkH2TsViE1NVVpzbzMTHdwljDqTFNITrfho9FholbVFxA3eBxwH97TD
        wPCZwWHBivUDz5KsQOtCMIBWjA36Hn4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-621-yHJZJHrxNTujpvjw8pJWBQ-1; Mon, 24 Oct 2022 05:46:20 -0400
X-MC-Unique: yHJZJHrxNTujpvjw8pJWBQ-1
Received: by mail-ed1-f69.google.com with SMTP id w20-20020a05640234d400b0045d0d1afe8eso9077785edc.15
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 02:46:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iJ+b2y7UqeW+tpjJ0iR2mEUHudPKaMh+lMgb9JMkYy4=;
        b=U8/LNmTvKHtaWeVlnN/7mxn5EYE0Hv1Um/Du0RcI0A3NrJiGHRTMb+KDXBJDXgUyVG
         sqC2+CaXGCZeii6jLQLoKFyhFotjypnul6ZvmsOlbxacdTKzMipvwKyPRGHvJWPJn/IP
         YNL8uqzIhYhOx2p2xqmjEP+Zf3J53iqBhjFmIj+LxV+ViVtcyge9/sYNFZ44ZdJQH0Gu
         ErzwadTqKA45u00M1mY4x3C7ZGBDRlQb6aaVWYpu5nmJq8wDSctGzbbMrYM3j8CFJW1w
         yGoDkCTbifBTUCvi1n8wNPb5VgZ/9SK5Otz6oIjJSnlYa5AYl7T66dOaEPl9EBRJktuD
         yLgw==
X-Gm-Message-State: ACrzQf3YS14kXy+nLMr02OiYLGxF/0/sITq6IX9bzmUsZdwuEYd+21tq
        Kyrib6m7kfPyA3abw0k0qAHNpql6T7DnRGsl7uucPGS+7i3Cgmf3Vp6AZk19fMTaEc4hZlKDYLl
        7RGLMhudvJajJdt5q20TIWr9W
X-Received: by 2002:a17:907:72d6:b0:79b:8cce:112a with SMTP id du22-20020a17090772d600b0079b8cce112amr13431080ejc.118.1666604779660;
        Mon, 24 Oct 2022 02:46:19 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6BZyVa08kflimw4PK8QRr04Qjjr4pRy5NLIwviaB6j/+ny1aS8XHJBp6uISRRbf0v+5S7hXg==
X-Received: by 2002:a17:907:72d6:b0:79b:8cce:112a with SMTP id du22-20020a17090772d600b0079b8cce112amr13431064ejc.118.1666604779483;
        Mon, 24 Oct 2022 02:46:19 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id r1-20020a1709061ba100b00788c820e630sm15179673ejg.121.2022.10.24.02.46.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 02:46:18 -0700 (PDT)
Message-ID: <8957290c-9499-a399-3e4e-e0276caccd65@redhat.com>
Date:   Mon, 24 Oct 2022 11:46:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 2/2] platform/x86/intel: pmc/core: Add Raptor Lake
 support to pmc core driver
Content-Language: en-US
To:     Jiri Slaby <jirislaby@kernel.org>,
        Gayatri Kammela <gayatri.kammela@linux.intel.com>
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, irenic.rajneesh@gmail.com,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Box <david.e.box@intel.com>
References: <20220912233307.409954-1-gayatri.kammela@linux.intel.com>
 <20220912233307.409954-2-gayatri.kammela@linux.intel.com>
 <3537fa63-9015-c63d-2321-a77062e24d6f@redhat.com>
 <58855ea9-0d89-e17d-349a-657512068663@kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <58855ea9-0d89-e17d-349a-657512068663@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/14/22 09:50, Jiri Slaby wrote:
> On 19. 09. 22, 13:41, Hans de Goede wrote:
> 
>> On 9/13/22 00:33, Gayatri Kammela wrote:
>>> Add Raptor Lake client parts (both RPL and RPL_S) support to pmc core
>>> driver. Raptor Lake client parts reuse all the Alder Lake PCH IPs.
>>>
>>> Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
>>> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>> Cc: David Box <david.e.box@intel.com>
>>> Acked-by: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
>>> Acked-by: Hans de Goede <hdegoede@redhat.com>
>>> Signed-off-by: Gayatri Kammela <gayatri.kammela@linux.intel.com>
>>> ---
>>> Changes since v1:
>>> 1) Added a dependency patch- ea902bcc1943f7539200ec464de3f54335588774 :
>>>   "x86/cpu: Add new Raptor Lake CPU model number".
>>> 2) Rebased the above patch on v6.0-rc1 with "Acked-by" from Hans and
>>>   Rajneesh.
>>
>> I still cannot take this, since patch 1/2 is *already merged* through
>> another tree, so me cherry-picking it leads to potential conflicts.
>>
>> As I have already explained twice you need to submit this upstream
>> throuh the same tree which has the original merge of patch 1/2.
> 
> Hi, friendly ping: has this ever happened, Gayatri?

Since the necessary change are in 6.1-rc1 now, I have merged this
patch now and I'll include this in the pdx86 fixes pull-req which
I'm preparing for 6.1-rc3:

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

