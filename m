Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39213613ED0
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 21:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiJaUQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 16:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiJaUQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 16:16:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D204EE06
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 13:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667247349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WIa9IfMzqilzK5MYtEhjp/n+BJxTQKIQoEPTpn72stw=;
        b=VOYN1lTn/+KJqERnb7UOcez5RuzMcxx8EnNvlp6eOdNALJYTkkV/TbpHAhwy9AEgUp65gB
        EUYiV2eii8bQvpwKjwsoj621HE4PkNRRCQ3J+v8z/XJPvbkkWTebZmjIlHwNS04WlhgHwU
        sZVWwndWVAmHvldWaOP9uCETDv2SxuM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-657-tAlT8UvsNfKzmBfaEzZICA-1; Mon, 31 Oct 2022 16:15:47 -0400
X-MC-Unique: tAlT8UvsNfKzmBfaEzZICA-1
Received: by mail-ed1-f71.google.com with SMTP id z9-20020a05640235c900b0046358415c4fso2614736edc.9
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 13:15:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WIa9IfMzqilzK5MYtEhjp/n+BJxTQKIQoEPTpn72stw=;
        b=KlrmjW+1wJPFuhwTgbwp1Wb3tIWxu7Q+4fzAPbLxpdP527kqQStBtRPzCplBmtNlUi
         nsSRCllKRMT6NaXjRvZ39LkA4vlpNSqNOq0+K8HmkkmlQ/+bCSlVIjtbli0YDGMT0CLI
         B8ZYlZICZnPYBtavQeU0mH4iYovoWvCO8vwh0I2paaHDpKqQS9feYhzfEphOyQLpGn8m
         zMlC+E1rDhRX1b2No+czmbx4gRq/fXtPpkBfEN8P330CczZMTY9tzC5VAisRhbRIx6OM
         aQzluYYPn+DEbfkzN8pd/2YAj4vPG+LlI1LpWuoJDuP7wC/2bBw5UK1Zc/l+/28C87bd
         Z6nQ==
X-Gm-Message-State: ACrzQf27I8YXSCtyyAShG4DAIzJddbglTQUFOlszkt2mNPaHMk1JIOmp
        OpikIVmehqejArc4/qKAotm0E/UgvFYQd5uO1TkDM5EXRBSUBPGfIC+s+Rmmi8lOWZkymzF8tWK
        vnu0V0hmN5tVkGEIch1hZ/u96
X-Received: by 2002:a17:907:9602:b0:780:8c9f:f99a with SMTP id gb2-20020a170907960200b007808c9ff99amr14920942ejc.465.1667247346376;
        Mon, 31 Oct 2022 13:15:46 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4/oXc0b1EOGJiYwMl/x5r8AyUg3lSAX6lCMTBQFtjCaizzEASZueiWCSYMo18A84SQ6+tidA==
X-Received: by 2002:a17:907:9602:b0:780:8c9f:f99a with SMTP id gb2-20020a170907960200b007808c9ff99amr14920926ejc.465.1667247346215;
        Mon, 31 Oct 2022 13:15:46 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id sg43-20020a170907a42b00b007aa3822f4d2sm3479851ejc.17.2022.10.31.13.15.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 13:15:45 -0700 (PDT)
Message-ID: <2124934d-a8f1-59fa-1958-28472d06d2d6@redhat.com>
Date:   Mon, 31 Oct 2022 21:15:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v1] platform/x86: intel_pmc_core: promote S0ix failure
 warn() to WARN()
Content-Language: en-US, nl
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Sven van Ashbrook <svenva@chromium.org>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "rrangel@chromium.org" <rrangel@chromium.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Rafael J Wysocki <rjw@rjwysocki.net>,
        Rajat Jain <rajatja@google.com>,
        David E Box <david.e.box@intel.com>,
        Mark Gross <markgross@kernel.org>
References: <20221027151908.v1.1.I295e65357f06f162b46ea6fc6c03be37e3978bdc@changeid>
 <4b7304c0-8dd5-9add-7c84-4e9f0aa9396b@redhat.com>
 <MN0PR12MB6101BCCA364437A76FED924AE2339@MN0PR12MB6101.namprd12.prod.outlook.com>
 <CAG-rBijvNoN3ppz6bdkEUofYPPBxCtFfo1nWBK5TdG69fcKMnA@mail.gmail.com>
 <CAE2upjS6qRGRcuVYuAB5DMf66A7VcfCKKYEkpsr1My7RnKDFtQ@mail.gmail.com>
 <CAG-rBihDRq1y61tAp56yYCoTOSZXO9OZNzn7gXb_y8XaiO_zqg@mail.gmail.com>
 <MN0PR12MB610109F448E3FC8CE71FBA76E2379@MN0PR12MB6101.namprd12.prod.outlook.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <MN0PR12MB610109F448E3FC8CE71FBA76E2379@MN0PR12MB6101.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/31/22 20:39, Limonciello, Mario wrote:
> [Public]
> 
>> -----Original Message-----
>> From: Sven van Ashbrook <svenva@chromium.org>
>> Sent: Friday, October 28, 2022 23:12
>> To: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>; Hans de Goede
>> <hdegoede@redhat.com>
>> Cc: Limonciello, Mario <Mario.Limonciello@amd.com>; LKML <linux-
>> kernel@vger.kernel.org>; S-k, Shyam-sundar <Shyam-sundar.S-
>> k@amd.com>; rrangel@chromium.org; platform-driver-
>> x86@vger.kernel.org; Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>;
>> Rafael J Wysocki <rjw@rjwysocki.net>; Rajat Jain <rajatja@google.com>;
>> David E Box <david.e.box@intel.com>; Mark Gross <markgross@kernel.org>
>> Subject: Re: [PATCH v1] platform/x86: intel_pmc_core: promote S0ix failure
>> warn() to WARN()
>>
>> On Thu, Oct 27, 2022 at 12:02 PM Rajneesh Bhardwaj
>> <irenic.rajneesh@gmail.com> wrote:
>>> I'd advise against this promotion based on my experience with S0ix entry
>> failures.
>>
>> On Thu, Oct 27, 2022 at 11:40 AM Hans de Goede <hdegoede@redhat.com>
>> wrote:
>>> I'm not a fan of the change you are suggesting here.
>>
>> Thanks everyone for the feedback. Looks like there is consensus that it's
>> not advisable to promote the warning. We will move forward with changes to
>> our monitoring infrastructure instead.
> 
> Did you see the idea proposed by David Box to introduce some infrastructure in
> the kernel for this?
> 
> Just thinking about it a little bit more, it could be a lot nicer to have something like:
> 
> /sys/power/suspend_stats/last_hw_deepest_state
> 
> During the resume process drivers such as amd_pmc and intel_pmc_core could
> read the appropriate values for the hardware and call a function that would
> populate it with either a "0" or "1" or maybe even the amount of time spent in
> that state.
> 
> We could then retire the debugging messages from both drivers and instead of
> your infrastructure relying upon scanning logs, userspace could read that sysfs
> file after every suspend and raise the alarms when it's 0 (or if it's populated with
> time smaller than X% of the total suspend time).

Something like this does indeed sound like a nice solution for this.

Regards,

Hans

