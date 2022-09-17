Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D5D5BB804
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 13:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiIQLmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 07:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiIQLmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 07:42:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F002FFD0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 04:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663414937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SzetDHPEuYHOyKUUGQoVLG/7B0wMNg9j9zSS25jq5MM=;
        b=QVD7UUx3fidUGkfM4Nwp/Apk9XMAKSX/pA6Fpp9UBzA32o9x9bp1NPC0EksTkt4jvXWTNr
        o9UQDVo5tArIwgvSGhjjOuG7g7vdS3A8BYOvU2bLhjpHr8SxqflMtwRMqQsTRXRNbmD4jU
        7KO/I8Gjj9nL88YUd4l7+r8AR9cL5JM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-611-L9zTdvCbMRiW9ZI0xOCrxA-1; Sat, 17 Sep 2022 07:42:16 -0400
X-MC-Unique: L9zTdvCbMRiW9ZI0xOCrxA-1
Received: by mail-ed1-f70.google.com with SMTP id b16-20020a056402279000b0044f1102e6e2so17234986ede.20
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 04:42:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=SzetDHPEuYHOyKUUGQoVLG/7B0wMNg9j9zSS25jq5MM=;
        b=r5W6BsW8mJ2KKkSyy5jrn+Mm1BYQFzbubJFacmkkp9wPJIPPftohDaBmNYtlMtej8S
         7+/u8kKXTRthbuXqi4DM4yU/QQbKM7vLxFb5PFNlpBKs0UQlbjfWbZ1drDGL5x5yX+n8
         JQPjEj7HoaXWoVtiY1xQ2zhKMszQsIu8wgLLwVScCosf/F2id9j3SVzaFPFYgb8Ig38H
         YvIqctAWzP00TseUWE3r8gx7EjeLFhlmmUA3t4DAnDmxORtGNQsB2nbI3ehEh4uQpPJw
         Lv0vn4jjVZxfqqNkXmk9SvBvlaIHKGa6uqZXwo5tiJncrj9itXSHx2SRXeY5Wf7Wg82/
         Wzaw==
X-Gm-Message-State: ACrzQf1xRIJ6x4wT+7ypzzt1L0i3UU2Jk7ls7Va7Y6Hc+aSSG2TlKAGP
        Mk8LEZ9K8i+lFIGDKCB0pPzdJyKH4qerkZK5LCqR307kBQ8bz68MwDPsyHwqAqwSIYqBTNrSD+V
        P3Vv5pOck218jc40Jwqnb1oIC
X-Received: by 2002:a17:907:2d9e:b0:775:3737:ac45 with SMTP id gt30-20020a1709072d9e00b007753737ac45mr6450400ejc.714.1663414935040;
        Sat, 17 Sep 2022 04:42:15 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7oMErWER0UZu2Kpobfn3BHnBemLLcyN70BPZAUhIqgFsMLf6ExJ1mlCXDdXOp6xGiEBjxAdQ==
X-Received: by 2002:a17:907:2d9e:b0:775:3737:ac45 with SMTP id gt30-20020a1709072d9e00b007753737ac45mr6450390ejc.714.1663414934818;
        Sat, 17 Sep 2022 04:42:14 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id 1-20020a170906218100b00730b61d8a5esm12095627eju.61.2022.09.17.04.42.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Sep 2022 04:42:14 -0700 (PDT)
Message-ID: <5097a283-6111-bedc-13c6-61a581f8b72c@redhat.com>
Date:   Sat, 17 Sep 2022 13:42:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH 0/3] Check enumeration before MSR save/restore
Content-Language: en-US
To:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        antonio.gomez.iglesias@linux.intel.com
References: <cover.1663025154.git.pawan.kumar.gupta@linux.intel.com>
 <20220913005053.vk7qmhr6tqqynags@desk>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220913005053.vk7qmhr6tqqynags@desk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/13/22 02:50, Pawan Gupta wrote:
> On Mon, Sep 12, 2022 at 04:38:44PM -0700, Pawan Gupta wrote:
>> Hi,
>>
>> This patchset is to fix the "unchecked MSR access error" [1] during S3
>> resume. Patch 1/3 adds a feature bit for MSR_IA32_TSX_CTRL.
>>
>> Patch 2/3 adds a feature bit for MSR_AMD64_LS_CFG.
>>
>> Patch 3/3 adds check for feature bit before adding any speculation
>> control MSR to the list of MSRs to save/restore.
>>
>> [1] https://lore.kernel.org/lkml/20220906201743.436091-1-hdegoede@redhat.com/
> 
> Added the correct email-id of Hans de Goede <hdegoede@redhat.com>.

I have tested this series and I can confirm that it fixes the exception
which I was seeing on a Packard Bell Dot SC with an Atom N2600 CPU:

Tested-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

