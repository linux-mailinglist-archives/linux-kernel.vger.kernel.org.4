Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4D56BD408
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 16:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbjCPPjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 11:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbjCPPiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 11:38:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD63EB370A
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 08:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678980900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LUxBnpEd/CYuu9MjkxmdwUGfMF8PyXYj2tKd869pk3Y=;
        b=BHftNBeLJZFnBV60U3a8prD9SIazoh6/kbxg4TxScp1K24XsGQunEd/Dsldnwb8I/WllOD
        ox7d+2YcWVPPPa0HPiuG9RVmtUNcQY1PDBwFb6Xlxwvm5Yk8ixoQHzZodALnwDgLsN9RqX
        nYxxkzwsGeNaNW0ME33uPMb8JmB43ig=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-yaHmlPrQM4OTdNRWYA_15A-1; Thu, 16 Mar 2023 11:31:49 -0400
X-MC-Unique: yaHmlPrQM4OTdNRWYA_15A-1
Received: by mail-wm1-f71.google.com with SMTP id i8-20020a05600c354800b003ed59bae33bso801360wmq.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 08:31:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678980708;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LUxBnpEd/CYuu9MjkxmdwUGfMF8PyXYj2tKd869pk3Y=;
        b=GksdOf3IqcZtxWxQ3gZaEvD5ExBohZzoxbx0gnDY4oeOKlf0ztaLzJb7BgWdnj8woJ
         NyIAni2dX3fHlPvyfM33V/S9Y1Nm30jzdUzc17QLW+h7yDq8Msb0Ktu8JOSu3qQKlPuT
         vnyu7OeS/zEpOi7ssMmk8C3Cp/Uls6Bfhe23L1sE9aRqDfkA4iJuzVRGrV6LvjZHumGt
         d5X+jCFos6HNVc2SWH4B2ZEFr0GDwHTuZT1IPj3L6p2eRQbzX8ToTz8JcatyLUYi39WC
         s4qBB/wkhO/6I3V/L29rEhA53U4Hxz+rp4GfCZLqwBNYhvSdbhEwL7HI6arv5jY7Y81x
         WmCw==
X-Gm-Message-State: AO0yUKXLRXY/Ke4SLKcOv4dblHO586sgktmsQ6m2MfP2rlyp8d9YMYkZ
        fJu/rBpLLEnyTgnVcqqTBqAqrU+6VYHtt2ZR+8X85Bu9x96vRNXWS1ZOMquI22oE2bPCHxY7+1t
        iLbfieAAILcLc/bEslb5+Qm86
X-Received: by 2002:adf:ecc4:0:b0:2cf:e3e3:5b01 with SMTP id s4-20020adfecc4000000b002cfe3e35b01mr4787316wro.56.1678980708490;
        Thu, 16 Mar 2023 08:31:48 -0700 (PDT)
X-Google-Smtp-Source: AK7set9eoS7b5f2Y7YUfSinO7Spqt07xlW+6XoJFsRio5Big/w+ffhRE50JJi7T2mU+22xDSp6JHdw==
X-Received: by 2002:adf:ecc4:0:b0:2cf:e3e3:5b01 with SMTP id s4-20020adfecc4000000b002cfe3e35b01mr4787306wro.56.1678980708182;
        Thu, 16 Mar 2023 08:31:48 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id z4-20020a5d6544000000b002c56013c07fsm7471039wrv.109.2023.03.16.08.31.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 08:31:47 -0700 (PDT)
Message-ID: <8fe0d91b-2209-1c66-2788-f18055c9d213@redhat.com>
Date:   Thu, 16 Mar 2023 16:31:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 3/3] selftests: Set overcommit_policy as OVERCOMMIT_ALWAYS
Content-Language: en-US
To:     Chaitanya S Prakash <chaitanyas.prakash@arm.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
References: <20230314042351.13134-1-chaitanyas.prakash@arm.com>
 <20230314042351.13134-4-chaitanyas.prakash@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230314042351.13134-4-chaitanyas.prakash@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.03.23 05:23, Chaitanya S Prakash wrote:
> The kernel's default behaviour is to obstruct the allocation of high
> virtual address as it handles memory overcommit in a heuristic manner.
> Setting the parameter as OVERCOMMIT_ALWAYS, ensures kernel isn't
> susceptible to the availability of a platform's physical memory when
> denying a memory allocation request.

Which tests in particular require that?

Subjects should start with "selftests/mm" instead of more generic 
"selftests:"

-- 
Thanks,

David / dhildenb

