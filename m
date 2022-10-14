Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBFEA5FE9F3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 10:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiJNIAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 04:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiJNIAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 04:00:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F6CE0C4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 01:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665734406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zVILIB5XF/M49DQErChLlIG7/6rWFKqLERRwuxIyoE0=;
        b=Sm34ovAvPs8BHv5CV0ira/dN9FEbe76owtwcA2D5+Jyn/uVTUr2xOXgR7duDiQi4YGJCgw
        3QuaC1SKXKzazV3zaQsgdnGsttSvlXPtSk94h8GmvcK3tPaV6+btg7+fTNljemcJS3+Ffn
        8rrBSUWXyQv0onErZxLlqnWmFjZaqS0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-426-CxFnQLzkOfylAU6hXfur_g-1; Fri, 14 Oct 2022 04:00:05 -0400
X-MC-Unique: CxFnQLzkOfylAU6hXfur_g-1
Received: by mail-ed1-f72.google.com with SMTP id x4-20020a05640226c400b0045c09fc1bd4so3200979edd.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 01:00:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zVILIB5XF/M49DQErChLlIG7/6rWFKqLERRwuxIyoE0=;
        b=b2qqd6Hi7Tj0xOa4PTfWtUAfsTENBJdkyfx9KZrz2NvI/9kvsKD76M+TrfwPEC0ule
         vYADURh1FfYVJXcqE+ZDhU4q8E4FOdXV+SsN1n96gK/9jv1VATUwiemLwg07byTexnhr
         8zytswe5JwcriiiGoEmddMKHYlZkjbZkctgb1mrCJcLjp99y/MxYOHdOC/Am1zB1uCbb
         7IdIa48pRui4ZVvhE4kRiAO0Row4OIi7PvOY7/i/WeFnlxekuphLBVo5HgL+G1lnzRJv
         VegBEfS9mwFBP5Qrhn/7JXV0NAtrappJE+ISc+c96Q0TLtXet18diLch206ltctE702U
         ikpA==
X-Gm-Message-State: ACrzQf0tbdijVVypxI9A8pJV3pcpwNE0fBruzrec+uHiFpb5m2Mn4dV7
        LAnhn9qMCb0yvOrpXFOq/FZ0FXAz3orw9/6toERaYuK2yFZyTRtHJ1H1WV6Zv4TPMjovbr7+AaN
        YmCPGS5gxfutlmflapvw+rLaE
X-Received: by 2002:a05:6402:150a:b0:459:2575:99c6 with SMTP id f10-20020a056402150a00b00459257599c6mr3256945edw.231.1665734403972;
        Fri, 14 Oct 2022 01:00:03 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7Fbmz3m2n1wS8HUDR7xXGw/wCHr77fdTBtw3CtgI5W/YLBhbpCzg7T650dQMOxKcFP6l1xoQ==
X-Received: by 2002:a05:6402:150a:b0:459:2575:99c6 with SMTP id f10-20020a056402150a00b00459257599c6mr3256922edw.231.1665734403716;
        Fri, 14 Oct 2022 01:00:03 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id m3-20020a170906160300b0078194737761sm1103690ejd.124.2022.10.14.01.00.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Oct 2022 01:00:03 -0700 (PDT)
Message-ID: <5320210a-9f94-9971-aa63-c0f48df94def@redhat.com>
Date:   Fri, 14 Oct 2022 10:00:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 2/2] platform/x86/intel: pmc/core: Add Raptor Lake
 support to pmc core driver
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
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <58855ea9-0d89-e17d-349a-657512068663@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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

If not, 6.1-rc1 will be out soon. If this gets resend after 6.1-rc1
is out I can take it and I can add it to 6.1-rc# as a fix in my
next pull-req to Linus.

Regards,

Hans

