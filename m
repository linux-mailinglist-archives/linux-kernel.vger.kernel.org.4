Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217986DAD6A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 15:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240694AbjDGNZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 09:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbjDGNZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 09:25:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF4D7A8F
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 06:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680873856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XKDIBL9ZgU2suXqR2LBWE+OsH1u5fAyap/1Lc5R3SHE=;
        b=e2RvxqHU1xxpr0Il5yKiEDwwGxzThIG73ynsWA/IIyhwUTQReVkRJdM9s09ZQxo2QHzT8b
        W+PxKk4vAGJ+map3G6c2098CCSD+Kmv2fgO1AnP86EYfmvqyU8rZ4YFfkBITS/bSN6Tkyx
        rETZ1/9CKB4GHyaFDWexdHMWFGs9/0o=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-5uAmcJyBN6SOg5RjpZR_kg-1; Fri, 07 Apr 2023 09:24:14 -0400
X-MC-Unique: 5uAmcJyBN6SOg5RjpZR_kg-1
Received: by mail-io1-f70.google.com with SMTP id d204-20020a6bb4d5000000b00758cfdd36c3so25890216iof.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 06:24:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680873854;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XKDIBL9ZgU2suXqR2LBWE+OsH1u5fAyap/1Lc5R3SHE=;
        b=6Niq4JdEbkXrW+hkEKwsd7dz2ulk6H0asuL4iBBX9svRsj85Kc+YPI+n4OebBX78Z9
         tVmDFxXGVDFdIfZqSmlwRKIWO9Da4IfHj1rrbG1PiuZ3do2viGWI9BGzzSXt7j9B+Nz8
         qzlGtoW2++mK35/ANGsdszg/2LZhf0iI1nDvI/jxCVlrCR125D+SMcz4O/WKOl2THmzb
         hnFJOnTPP1IfZt8nm65LDOH1xqhfhZqq8gU1G0fVamc3S2KaE6EnT0XNG+YlPscnXyPs
         HCyWA5GfNBAQ5AFmt3o9y4YqlaOptayXh8xNtLscNS5RRMENpRm8bmADVyMAmHOBxNyr
         htow==
X-Gm-Message-State: AAQBX9deRYcemIRwGMkzINn1yTFvrLt7GAB3Sgiq7z6qhHbYMUix52AJ
        8npJs/Gu0XV3LMnP9bXlRZUrUxY1tgz7vK4/YcCmdDCdjxkIU3meKMR/jcKVF1Dael61P1OqBsa
        x0xp06prYnwJUhwAsQiDfEpIX
X-Received: by 2002:a92:c534:0:b0:325:ce6b:fc88 with SMTP id m20-20020a92c534000000b00325ce6bfc88mr1409786ili.9.1680873854111;
        Fri, 07 Apr 2023 06:24:14 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZLWJKCpwKaLLMHOXrV2Gzhy8aZbm78mr/jMzHhp+4OtWwQssdaZrujcsR4M7gWRgi7x/JSSw==
X-Received: by 2002:a92:c534:0:b0:325:ce6b:fc88 with SMTP id m20-20020a92c534000000b00325ce6bfc88mr1409775ili.9.1680873853862;
        Fri, 07 Apr 2023 06:24:13 -0700 (PDT)
Received: from [10.0.0.146] (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id x6-20020a923006000000b0031798b87a14sm988373ile.19.2023.04.07.06.24.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 06:24:13 -0700 (PDT)
Message-ID: <3eaa1264-2ab4-fd1d-8871-47c2414cbc29@redhat.com>
Date:   Fri, 7 Apr 2023 08:24:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH] xfs: Use for_each_perag() to iterate all available AGs
To:     Ryosuke Yasuoka <ryasuoka@redhat.com>,
        Eric Sandeen <sandeen@sandeen.net>
Cc:     djwong@kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230404084701.2791683-1-ryasuoka@redhat.com>
 <e51e9fb1-ad5c-5cf8-fa04-4e3a10023739@sandeen.net>
 <CAHpthZrcegPXhti5tDdb=_nwafWnU-FXmtc6aRU7juowMpOnUQ@mail.gmail.com>
Content-Language: en-US
From:   Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <CAHpthZrcegPXhti5tDdb=_nwafWnU-FXmtc6aRU7juowMpOnUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/23 11:03 AM, Ryosuke Yasuoka wrote:
> Eric,
> 
> I failed to reply to you since I got some mistakes.
> Let me re-send my reply just in case.
> 
> Thank you for reviewing my requests.
> 
>> Can you explain what goes wrong if it is zero? Is there a test for this?
>>
>> If it's a general problem, what if the other 2 callers pass in the variable
>> start_agno with a value of 0?
> Sorry I couldn't prepare any tests to confirm what happens if it is zero
> because it is a kind of general problem.
> 
> IIUC, passing zero to for_each_perag_wrap() is not problematic.

...

> OTOH, since we have already a for_each_perag() macro, which just iterates all AG
> from 0 and doesn't wrap, I think it is simpler to use for_earch_perag().
> 
> Regards,
> Ryosuke

Ok - I couldn't tell from the original email if this was a bugfix or a 
cleanup, and wanted to be sure.

Thanks!
-Eric

