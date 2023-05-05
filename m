Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2CF6F855D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 17:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbjEEPP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 11:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232514AbjEEPP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 11:15:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C227517DDC
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 08:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683299719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kkrG6TrT6vUt7l/1yAEGc4UPeZE85BI5/e7CQ9gxkxM=;
        b=bPMVmpuW8pXu0KfXPhgVpE9pu6zWngKu5a5omHVvF6fPTLJ9TehIybYlw7iTiKUBExjUaO
        0oNP7x1GiHnn+gow4SlCvuPsTGoqokJoNrnuqnLnuRVMca+ngR2KjW6inUoAoLy7A4NpJu
        E2e9NCA2tF+89wENlv3QrQRMhOKrku4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-ONZdNSvQNH2sTI4w9-bSww-1; Fri, 05 May 2023 11:15:18 -0400
X-MC-Unique: ONZdNSvQNH2sTI4w9-bSww-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-306489b7585so682397f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 08:15:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683299717; x=1685891717;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kkrG6TrT6vUt7l/1yAEGc4UPeZE85BI5/e7CQ9gxkxM=;
        b=Praw4euYgNdSCFIyxUMp1nxsXW/ZKpz8zqxebXqFS4ayIT5ppE+o4UM7sPfAZM6RKW
         5GAIc4RfemRIafhUb/F9nEFaWvo6Y+Ck98+JAOPlmwp30q817tT6Al9nFEvnTv/WDY9n
         Pp+J/pBZmA5qlxRcbUeGGBhu1rjlvKQlWdkUp0rETxi/jN+SJcbwa+DppeujjLZbBK+K
         qKjOefZRGbb4iebhiUfWve3tJ68Sllqskmuuj1CXCdIxCj1yEShjz1dZOau8jWimn8Dc
         t/mlClHw5eGxtiBWj8dRPUPOg9Cy6E8Kf47sy4sF+6UK68SLLLZC9uW0G+3A0/kFoEdv
         BZwA==
X-Gm-Message-State: AC+VfDwirm7wuz+ocDTy4BMvAieu6aXCu+zhyf9eJZFVK/u8wLeRQx+Z
        DxWN+Y5X6KIHYZkPYXsWca21p0vSRozC7poS3t1LMplxcYXVjX9g1mmiHoeC8Cvgdpy4O6G0kIO
        QriUd3kXKHr1/KIAmbVPTt8fR
X-Received: by 2002:adf:e852:0:b0:2f2:783f:ae4a with SMTP id d18-20020adfe852000000b002f2783fae4amr1565316wrn.32.1683299717085;
        Fri, 05 May 2023 08:15:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5JphXg6YSvIF6EBsByLfX+Q1TzMx3ezx0pIYW00N+N1esYSq7PB5q/K6U1CiU7dEnLsZInQg==
X-Received: by 2002:adf:e852:0:b0:2f2:783f:ae4a with SMTP id d18-20020adfe852000000b002f2783fae4amr1565295wrn.32.1683299716737;
        Fri, 05 May 2023 08:15:16 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71f:6900:2b25:fc69:599e:3986? (p200300cbc71f69002b25fc69599e3986.dip0.t-ipconnect.de. [2003:cb:c71f:6900:2b25:fc69:599e:3986])
        by smtp.gmail.com with ESMTPSA id k17-20020adfe3d1000000b00301a351a8d6sm2704788wrm.84.2023.05.05.08.15.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 08:15:16 -0700 (PDT)
Message-ID: <c50ac5e4-3f84-c52a-561d-de6530e617d7@redhat.com>
Date:   Fri, 5 May 2023 17:15:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Sam James <sam@gentoo.org>
Cc:     Michael McCracken <michael.mccracken@gmail.com>,
        linux-kernel@vger.kernel.org, serge@hallyn.com, tycho@tycho.pizza,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        kernel-hardening@lists.openwall.com
References: <20230504213002.56803-1-michael.mccracken@gmail.com>
 <fbf37518-328d-c08c-7140-5d09d7a2674f@redhat.com> <87pm7f9q3q.fsf@gentoo.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] sysctl: add config to make randomize_va_space RO
In-Reply-To: <87pm7f9q3q.fsf@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.05.23 09:46, Sam James wrote:
> 
> David Hildenbrand <david@redhat.com> writes:
> 
>> On 04.05.23 23:30, Michael McCracken wrote:
>>> Add config RO_RANDMAP_SYSCTL to set the mode of the randomize_va_space
>>> sysctl to 0444 to disallow all runtime changes. This will prevent
>>> accidental changing of this value by a root service.
>>> The config is disabled by default to avoid surprises.
>>
>> Can you elaborate why we care about "accidental changing of this value
>> by a root service"?
>>
>> We cannot really stop root from doing a lot of stupid things (e.g.,
>> erase the root fs), so why do we particularly care here?
> 
> (I'm really not defending the utility of this, fwiw).
> 
> In the past, I've seen fuzzing tools and other debuggers try to set
> it, and it might be that an admin doesn't realise that. But they could
> easily set other dangerous settings unsuitable for production, so...

At least fuzzing tools randomly toggling it could actually find real 
problems. Debugging tools ... makes sense that they might be using it.

What I understand is, that it's more of a problem that the system 
continues running and the disabled randomization isn't revealed to an 
admin easily.

If we really care, not sure what's better: maybe we want to disallow 
disabling it only in a security lockdown kernel? Or at least warn the 
user when disabling it? (WARN_TAINT?)

-- 
Thanks,

David / dhildenb

