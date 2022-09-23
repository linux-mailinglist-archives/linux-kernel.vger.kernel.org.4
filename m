Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D835E78DD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 12:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbiIWK4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 06:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiIWK4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 06:56:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2312107DCA
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 03:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663930534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eef54XeIfI5ePPfdQCCa+xwkgeOXOv7/COauKA6kwwQ=;
        b=UEwLxXK/DcqRGm/I3a1xLTR3BJ660LIWxR4D405iMewcQGAwfZ45M9XLPYJNUuQFe7jkXo
        a3eShBkOPF/MUW7bcMGuLN8FD9AMooOwROydmGKY+AFXQSL+96VS/8rwqqucURsDnOj9XU
        SyHITg6YpfyjPeHz++PTg+Bo3q2LLXc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-600-ptocNfzRP2-iTD52mwrkMw-1; Fri, 23 Sep 2022 06:55:32 -0400
X-MC-Unique: ptocNfzRP2-iTD52mwrkMw-1
Received: by mail-wm1-f71.google.com with SMTP id p36-20020a05600c1da400b003b4faefa2b9so3557983wms.6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 03:55:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=eef54XeIfI5ePPfdQCCa+xwkgeOXOv7/COauKA6kwwQ=;
        b=WAsoVAuel/Hz90Gtyb6eU1TUKhDy4uMNc4suiIx8dICQMcMM9JIrPAv3RVgrxXqbCX
         4fFXWC1/dBaxpBIx5KhorZ/FDY7uH3IXzZONnHnAAXJyDGmjSg3nfwOqVxYmKh8UqOSS
         yoPNNVv9c3BqmJ9hi0hJ6TnhyjJ/HpmWhm28PUcPGEsrsWnaATYu4iQxMDiRTajSGBEH
         ADxci/NK8unke9hz+rPeY9Y9WeL+Jenzotut0qpzDDnesjRa+KdApTiCGI3BB7zEp0qx
         18cAln3dAFXNTV5bfj+qe/a4qpncpv0kJmlXKhjHDL+6nf9tSaYrg10PmUwigddevoVM
         qzyA==
X-Gm-Message-State: ACrzQf1Cl2Zylb7REYVwrX30/is7HDtjN1Pez9+KlQdM2cn6wGtJBJpl
        JmLfdpaJv2vZc+HPVPMwfs2vhCRt+QumnzvRiG9qdKuDZpcPAHcAyWp9MvmS1VEGNlmMqAiguLt
        7fwS7sY1A6BRkgZzeiJExIJou
X-Received: by 2002:adf:de01:0:b0:228:62ae:78bc with SMTP id b1-20020adfde01000000b0022862ae78bcmr4702223wrm.41.1663930531716;
        Fri, 23 Sep 2022 03:55:31 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4kdGvtbB82mE3J4eOPvIcDO2feso4JPy2pwAaShDx+NaqgW7GNPKE3hF5xRI57FveqzL+0bQ==
X-Received: by 2002:adf:de01:0:b0:228:62ae:78bc with SMTP id b1-20020adfde01000000b0022862ae78bcmr4702188wrm.41.1663930531409;
        Fri, 23 Sep 2022 03:55:31 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:cc00:4585:a83b:64f2:ad21? (p200300cbc704cc004585a83b64f2ad21.dip0.t-ipconnect.de. [2003:cb:c704:cc00:4585:a83b:64f2:ad21])
        by smtp.gmail.com with ESMTPSA id d10-20020a056000114a00b002250c35826dsm7067750wrx.104.2022.09.23.03.55.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 03:55:30 -0700 (PDT)
Message-ID: <3108be4e-319d-3444-308d-ca60729ea502@redhat.com>
Date:   Fri, 23 Sep 2022 12:55:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v1 1/3] coding-style.rst: document BUG() and WARN() rules
 ("do not crash the kernel")
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
References: <20220920122302.99195-1-david@redhat.com>
 <20220920122302.99195-2-david@redhat.com>
 <3dcbcc7b-9ca0-1465-5a73-075a1c151331@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <3dcbcc7b-9ca0-1465-5a73-075a1c151331@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.09.22 04:26, John Hubbard wrote:
> On 9/20/22 05:23, David Hildenbrand wrote:
>> [1] https://lkml.kernel.org/r/CAHk-=wiEAH+ojSpAgx_Ep=NKPWHU8AdO3V56BXcCsU97oYJ1EA@mail.gmail.com
>> [2] https://lore.kernel.org/r/CAHk-=wg40EAZofO16Eviaj7mfqDhZ2gVEbvfsMf6gYzspRjYvw@mail.gmail.com
>> [2] https://lkml.kernel.org/r/CAHk-=wit-DmhMfQErY29JSPjFgebx_Ld+pnerc4J2Ag990WwAA@mail.gmail.com
> 
> s/2/3/

Thanks!

> 
> ...
>> diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
>> index 03eb53fd029a..e05899cbfd49 100644
>> --- a/Documentation/process/coding-style.rst
>> +++ b/Documentation/process/coding-style.rst
>> @@ -1186,6 +1186,67 @@ expression used.  For instance:
>>   	#endif /* CONFIG_SOMETHING */
>>   
>>   
>> +22) Do not crash the kernel
>> +---------------------------
>> +
>> +In general, it is not the kernel developer's decision to crash the kernel.
> 
> What do you think of this alternate wording:
> 
> In general, the decision to crash the kernel belongs to the user, rather
> than to the kernel developer.

Ack

[...]

> I like the wording, it feels familiar somehow! :)

:)

> 
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>

Thanks!

-- 
Thanks,

David / dhildenb

