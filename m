Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D07690BEA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 15:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjBIOgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 09:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjBIOgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 09:36:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316C95FB51
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 06:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675953346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/TNxD9eCEeQ+7B6yx26kqH/5ttVJ+56DfRBM0E7FvmI=;
        b=dsG0ASI924eKl8cshjccRY05ZWaEXHXTQdh3INt93k4pS/CmCM3gUg1ncko9z6F8GwMeTR
        8Qdtzu3ByFUDbOC6duChrFWrGVlGudINYjHxpzK7+FVApQw73jWbMAVGT95HyCgCzmFcKg
        WbrhEnpovh3OuDxYTCGEwQ8EJCPnBtY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-240-nyH7ZA4nPJStu1_bfc3OFw-1; Thu, 09 Feb 2023 09:35:45 -0500
X-MC-Unique: nyH7ZA4nPJStu1_bfc3OFw-1
Received: by mail-ed1-f71.google.com with SMTP id s26-20020a056402037a00b004a25c2875d6so1567745edw.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 06:35:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/TNxD9eCEeQ+7B6yx26kqH/5ttVJ+56DfRBM0E7FvmI=;
        b=P6qIocsq76le4dH1wPCySAlZGoYmPVouudPCKenE44ENujfbB2jw3XgWkVMkvrBQOw
         ucWEhj7SA3D1jQB+kGR4xlqY8N8pmMhXDl8dSynIgbmUEMa2TUZ7lEAq5qUCRaCSpGxw
         0xiiV5jcDJnhOLs547/J956QLk19Rnwbi2yryTETLqPCHsBPEIBAJmSWXXfzmxJAoq60
         SDrbHOitdyOJYmcjwSQJa2KUrwtsd1CBN64BYdvCbleCPyQ2qLKC3/iSkt0UOt1ipLIS
         chPP71KWftf1PL5dzTNruijsUaqWOPyYVPeHuFU39tWvOqm8WF+BNLI89pZf4Zzo53T4
         I9dg==
X-Gm-Message-State: AO0yUKURMHAnyVOX23R6DDdTzdI/joDzOFQvo8F8Ijg9ZTBt0NqCYC6k
        fJ+LUB0hyj8EmO/FNrlu4G/zZryIUvowffdvDFMl/LKBik/BuN+h/QyWf1/iidc7pi/TtHlHFAR
        oICLEm9mRc2eB9wwVHg1+p0FO
X-Received: by 2002:a17:906:4fc5:b0:878:683c:f0d1 with SMTP id i5-20020a1709064fc500b00878683cf0d1mr17662594ejw.38.1675953343953;
        Thu, 09 Feb 2023 06:35:43 -0800 (PST)
X-Google-Smtp-Source: AK7set8Gq8Lb29eUnowJ6nD+xdHbhxvicrbwXw4bPrC4Uwwx36omr2Tg54EEO64vZjP62/W4oodfmQ==
X-Received: by 2002:a17:906:4fc5:b0:878:683c:f0d1 with SMTP id i5-20020a1709064fc500b00878683cf0d1mr17662573ejw.38.1675953343768;
        Thu, 09 Feb 2023 06:35:43 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id f8-20020a1709063f4800b0088385cd6166sm930964ejj.195.2023.02.09.06.35.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Feb 2023 06:35:43 -0800 (PST)
Message-ID: <9d254312-3526-b0be-7a7d-d533b247fdb2@redhat.com>
Date:   Thu, 9 Feb 2023 15:35:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFCv2 0/1] x86: allow to notify host about guest entering s2idle
Content-Language: en-US, nl
To:     Grzegorz Jaszczyk <jaz@semihalf.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org
Cc:     dmy@semihalf.com, tn@semihalf.com, dbehr@google.com,
        zide.chen@intel.corp-partner.google.com, seanjc@google.com,
        upstream@semihalf.com, markgross@kernel.org, dtor@google.com
References: <20230209135646.3179418-1-jaz@semihalf.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230209135646.3179418-1-jaz@semihalf.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Grzegorz,

Can you please resend this with the linux-pm@vger.kernel.org,
x86@kernel.org and platform-driver-x86@vger.kernel.org email-lists
in the Cc to make sure this gets seen by some more people ?

(not everyone reads linux-kernel) 

And since you mention Mario Limonciello, maybe also add him the the Cc?

Regards,

Hans




On 2/9/23 14:56, Grzegorz Jaszczyk wrote:
> According to the mailing list discussion [1] about the preferred approach
> for notifying hypervisor/VMM about guest entering s2idle state this RFC was
> implemented.
> 
> Instead of original hypercall based approach, which involves KVM change [2]
> and makes it hypervisor specific, implement different mechanism, which
> takes advantage of MMIO/PIO trapping and makes it hypervisor independent.
> 
> For the RFCv1 [3]:
>   Patch #1 extends S2Idle ops by new notify handler which will be invoked as a
>   very last command before system actually enters S2Idle states. It also allows
>   to register and use driver specific notification hook which is used in
>   patch #2.
> 
>   Patch #2 introduces new driver for virtual PMC, which registers
>   acpi_s2idle_dev_ops's notify handler. Its implementation is based on an
>   ACPI _DSM evaluation, which in turn can perform MMIO access and allow to
>   trap and therefore notify the VMM about guest entering S2Idle state.
> 
> For the RFCv2: the patch #1 was dropped as in the meantime Mario Limonciello
> introduced a very similar patch [4] which uses s/notify/check and invokes the
> callback a bit earlier just before s2idle_entry. Mentioned patch has already
> been merged.
> 
> This patchset is marked as RFC since patch #2 implements driver for non
> existing device "HYPE0001", which ACPI ID was not registered yet.
> Furthermore the required registration process [5] will not be started
> before getting positive feedback about this patchset.
> 
> [1] https://patchwork.kernel.org/project/linux-pm/patch/20220609110337.1238762-2-jaz@semihalf.com/
> [2] https://patchwork.kernel.org/project/linux-pm/patch/20220609110337.1238762-3-jaz@semihalf.com/
> [3] https://patchwork.kernel.org/project/linux-pm/cover/20220707125329.378277-1-jaz@semihalf.com/
> [4] https://patchwork.kernel.org/project/linux-pm/patch/20220829162953.5947-2-mario.limonciello@amd.com
> [5] https://uefi.org/PNP_ACPI_Registry
> 
> Grzegorz Jaszczyk (1):
>   platform/x86: Add virtual PMC driver used for S2Idle
> 
>  drivers/platform/x86/Kconfig    |  7 ++++
>  drivers/platform/x86/Makefile   |  3 ++
>  drivers/platform/x86/virt_pmc.c | 73 +++++++++++++++++++++++++++++++++
>  3 files changed, 83 insertions(+)
>  create mode 100644 drivers/platform/x86/virt_pmc.c
> 

