Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80AC6F8565
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 17:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbjEEPRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 11:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbjEEPRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 11:17:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B102517FFB
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 08:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683299822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=abj92oKBVKkSuSz9pqIREg9vXlBszotRotTWHKF/vxY=;
        b=Ybkm35MQVl6W0UqmckRPall+d69uZ584vqXpsNH1xez1CQ4OIkUothZZOEuRRIiWMCoQTk
        sv6MiKn4W48QwYnqkG3oNgNpTrjMkLQsWcKzANN7LllotiyXB67KRPxmmT5CMo2iQJpsWQ
        xhiLO+nedfvHfQ5Q9HdsL2UYp+2oNi0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-2KTS8tfzMSqVqVgTWJ271w-1; Fri, 05 May 2023 11:17:01 -0400
X-MC-Unique: 2KTS8tfzMSqVqVgTWJ271w-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f173bd0fc9so10873685e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 08:17:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683299820; x=1685891820;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=abj92oKBVKkSuSz9pqIREg9vXlBszotRotTWHKF/vxY=;
        b=iWZd+l0dr4xsyBqXa2XE/7pT0CGx+bwaD0/LtqFiJyS/i7eRlOYPMQM1diY12J890F
         cca5iT3syXCym9H07YL9RfAueG3aEmkXeX16iADID94juBnlfCFIQmfe7jV+bCdUszAA
         cWx2TeZrfQ1AEKifmr7zjK6DMYvcL2ANS7U1mwVEvWTQkO6/azI7IYmIOe0HyDtHXJ6l
         gZCEBDyOp9an5ypmslApYbt2W58ahafd8rmpT2SFWYE/v/0n0CADIwoLkow3xWeJlmgk
         cenNillzJ5zNNpOSqPPPhuSUeaWnrLXnCA/CfMiC51JRWpv/Qcnq3hSb4y2IyzNQk0i4
         dOlQ==
X-Gm-Message-State: AC+VfDyuuUuFoCz8SdZGkezk22bklpzOhHs+tGYWXEregY+/BL2LBvP4
        hiL+8k3wPIjHmXtZHUUrRqLVm4c06jBvQU5+fiYeexjuEgBxkCWizITrtF6tWVenVEKYbH8uKAH
        tNB9Da8+vjtBFM4NRDAxCWswL
X-Received: by 2002:a1c:7702:0:b0:3f1:72ec:4009 with SMTP id t2-20020a1c7702000000b003f172ec4009mr1676493wmi.9.1683299820163;
        Fri, 05 May 2023 08:17:00 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ78JBIXEOqF3dAix6y4QDwnEAMI8vIJEvszuxEpNDMp1Z2OwDOrdyWv9MUnAGy//RkyiltP9g==
X-Received: by 2002:a1c:7702:0:b0:3f1:72ec:4009 with SMTP id t2-20020a1c7702000000b003f172ec4009mr1676482wmi.9.1683299819807;
        Fri, 05 May 2023 08:16:59 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71f:6900:2b25:fc69:599e:3986? (p200300cbc71f69002b25fc69599e3986.dip0.t-ipconnect.de. [2003:cb:c71f:6900:2b25:fc69:599e:3986])
        by smtp.gmail.com with ESMTPSA id h5-20020a1ccc05000000b003ee5fa61f45sm8280845wmb.3.2023.05.05.08.16.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 08:16:59 -0700 (PDT)
Message-ID: <ac239fcf-9b2d-e82c-bec7-28d139384750@redhat.com>
Date:   Fri, 5 May 2023 17:16:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] sysctl: add config to make randomize_va_space RO
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
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
 <c50ac5e4-3f84-c52a-561d-de6530e617d7@redhat.com>
Organization: Red Hat
In-Reply-To: <c50ac5e4-3f84-c52a-561d-de6530e617d7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.05.23 17:15, David Hildenbrand wrote:
> On 05.05.23 09:46, Sam James wrote:
>>
>> David Hildenbrand <david@redhat.com> writes:
>>
>>> On 04.05.23 23:30, Michael McCracken wrote:
>>>> Add config RO_RANDMAP_SYSCTL to set the mode of the randomize_va_space
>>>> sysctl to 0444 to disallow all runtime changes. This will prevent
>>>> accidental changing of this value by a root service.
>>>> The config is disabled by default to avoid surprises.
>>>
>>> Can you elaborate why we care about "accidental changing of this value
>>> by a root service"?
>>>
>>> We cannot really stop root from doing a lot of stupid things (e.g.,
>>> erase the root fs), so why do we particularly care here?
>>
>> (I'm really not defending the utility of this, fwiw).
>>
>> In the past, I've seen fuzzing tools and other debuggers try to set
>> it, and it might be that an admin doesn't realise that. But they could
>> easily set other dangerous settings unsuitable for production, so...
> 
> At least fuzzing tools randomly toggling it could actually find real
> problems. Debugging tools ... makes sense that they might be using it.
> 
> What I understand is, that it's more of a problem that the system
> continues running and the disabled randomization isn't revealed to an
> admin easily.
> 
> If we really care, not sure what's better: maybe we want to disallow
> disabling it only in a security lockdown kernel? Or at least warn the
> user when disabling it? (WARN_TAINT?)

Sorry, not WARN_TAINT. pr_warn() maybe. Tainting the kernel is probably 
a bit too much as well.

-- 
Thanks,

David / dhildenb

