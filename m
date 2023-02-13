Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E38A76952E5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 22:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjBMVSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 16:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjBMVSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 16:18:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42CC1CF71
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 13:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676323076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p1oNS0vOfF/bAfVUsYaumPLXjxKPjDgFW6IpBNQoMeQ=;
        b=VOpyjZoDEAMTyVvv/46jqz7d6SgGOHHde6ozUq9g0+7xKs6GkxxVO/i40kmaLCQO4jnwFp
        eunvriKIstkgMT97RwxBUXimev/90kB13MwHJIYkogyhiqFjPr61O72HxCiMC8CmXdshgD
        VcwDWNEJBWTFwXF+4Xf9ThAcSlku6ew=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-61-MB-R6nbPMHCtcVZobTIJ3A-1; Mon, 13 Feb 2023 16:17:55 -0500
X-MC-Unique: MB-R6nbPMHCtcVZobTIJ3A-1
Received: by mail-qv1-f72.google.com with SMTP id 98-20020a0c806b000000b0056c2797aa8bso7306724qva.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 13:17:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p1oNS0vOfF/bAfVUsYaumPLXjxKPjDgFW6IpBNQoMeQ=;
        b=hDs2ivI5/nnEP6KSv0FwkfTM312xPqpdP/RDxi1KzDe8jVNrc1jfAy9qXCR0I+UYLZ
         A7b6ampInqrxEPPBuuFh2G7qLRGTM7JUndMh/1qaey64ScHdIhvN2sZQf8kRBq/rkoBO
         J1fotA1sUHnczXr8/7PI9uqxsF4WMsMdYG/PrP7jgSUcIjnkSj++PueGJJlvtXmN9SHf
         MGfO16NLyx7uLvbBNU3sCpzrrGTpb2vJLmA9/l4Ccc++B5RZ+pufkTfEAtAjynuO0OZS
         XLqlNVbhJglnkChOhzOTqUExtwvChX7v62asOPsLl31RXfPhGNYaU5lfpDDgnCGVx0S3
         Tnkw==
X-Gm-Message-State: AO0yUKUjzj7usdroiqnPzSUQ/1y5fCQguXSQ86oBNAPoCM4exTH6YCey
        vHpWPfyxVTIRlHCn61SkXJysnXxijRTNgNxqchOLK3JzM0/joy22BTv1CYvYmEVFDvYLik6avqt
        UFtn0gjjMBahjXkx+mknjLN+afP4XkSjtbS65FVvsS9kNEG/W0fc85P6rcDKtSyvQV4jVGRVEX5
        tS
X-Received: by 2002:a05:622a:1356:b0:3b8:6bab:1e4d with SMTP id w22-20020a05622a135600b003b86bab1e4dmr41247210qtk.51.1676323074393;
        Mon, 13 Feb 2023 13:17:54 -0800 (PST)
X-Google-Smtp-Source: AK7set9aALYiUoVdZJT/bcPbV3M/l4oYZpMatd/WDteYg/QH6cKNpAEijVuqFTI25OrMAajvijakDw==
X-Received: by 2002:a05:622a:1356:b0:3b8:6bab:1e4d with SMTP id w22-20020a05622a135600b003b86bab1e4dmr41247180qtk.51.1676323074134;
        Mon, 13 Feb 2023 13:17:54 -0800 (PST)
Received: from [192.168.1.19] (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id p11-20020a05622a00cb00b003b86d3ee49asm10327388qtw.74.2023.02.13.13.17.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 13:17:53 -0800 (PST)
Subject: Re: [PATCH] EDAC/amd64: remove unneeded call to
 reserve_mc_sibling_devs()
To:     Nathan Chancellor <nathan@kernel.org>,
        Borislav Petkov <bp@alien8.de>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>, tony.luck@intel.com,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230213191510.2237360-1-trix@redhat.com>
 <Y+qZthCMRL1m0p4B@yaz-fattaah> <Y+qcU2M5gchfzbky@zn.tnic>
 <Y+qdVHidnrrKvxiD@dev-arch.thelio-3990X>
From:   Tom Rix <trix@redhat.com>
Message-ID: <03b91ce8-c6d0-63e7-561c-8cada0ece2fe@redhat.com>
Date:   Mon, 13 Feb 2023 13:17:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <Y+qdVHidnrrKvxiD@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/13/23 12:28 PM, Nathan Chancellor wrote:
> On Mon, Feb 13, 2023 at 09:23:47PM +0100, Borislav Petkov wrote:
>> On Mon, Feb 13, 2023 at 08:12:38PM +0000, Yazen Ghannam wrote:
>>> These errors are encountered when extra warnings are enabled, correct?
>> It says so in the warning which one it is: -Werror,-Wsometimes-uninitialized
>>
>> Don't know if we enable that one for clang with W= or Nathan adds
>> additional switches.
> -Wsometimes-uninitialized is part of clang's -Wall so it is on by
> default in all builds, regardless of W=
>
> -Werror comes from CONFIG_WERROR, which is enabled with allmodconfig.
>
>>> I think the following patch would resolve this issue. This is part of a set
>>> that isn't fully applied.
>>> https://lore.kernel.org/linux-edac/20230127170419.1824692-12-yazen.ghannam@amd.com/
>>>
>>> Boris,
>>> Do you think one of these patches should be applied or just hold off until the
>>> entire original set is applied?
>> I still wanted to go through the rest but I'm not sure I'll have time
>> for it before the merge window. So unless this is breaking some silly
>> testing scenario, I'd say I'll leave things as they are.
> This breaks allmodconfig with clang, so it would be great if one of
> these solutions was applied in the meantime.

This happens at least on allyesconfig clang W=1,2, i do not know about 
default, it's in a bad state as well.

It would be great if the clang build was working.

Nathan's patch is fine, go with that.

Tom

>
> Cheers,
> Nathan
>

