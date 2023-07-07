Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6319B74AB58
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 08:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbjGGGtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 02:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbjGGGtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 02:49:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F124B130
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 23:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688712498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HodJdBlqSffql6XiM4u7BM5sylthEOlaUhQsYf8llqA=;
        b=RmkHCBNOcNwFQmdwevoT8JEip+KliPw1zxtjrh/+1A9xhGnSEzMfVa5HWv3AFq9aXPg1JW
        5yi5877bqcxqrkqrcvlThT5srbNeEwv2fUNFHex/WIVxvjzCb4x8gnhTKGAN6XWORn3J17
        hyVuNVBoIzKPe1VD7zxib9auZ/iGBOo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-C0VKP1N_Ng2ssx3NsCUxUQ-1; Fri, 07 Jul 2023 02:48:17 -0400
X-MC-Unique: C0VKP1N_Ng2ssx3NsCUxUQ-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-765986c0568so213548485a.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 23:48:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688712496; x=1691304496;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HodJdBlqSffql6XiM4u7BM5sylthEOlaUhQsYf8llqA=;
        b=PsQmvSkUitiOnpTp9cZBmKl3y1/9/ubMqJQnPFFnAfKklOtTkpqwb7y4SkU4ISyQVW
         eV+9uvtMqcYoImcTtgtMjKWzzAqMq28tFUtrm0hAZfLpV9b+sWfI7EvMrl20dYYxa+rz
         +escu0EXvIFiZXR+wr6vJ2SfngCXl+9VN60eQupQ8aDmy3UaxVFskH+N20XYig0Fz/Kd
         W8giEDfvDt0zILdAeGsyoO9RSL+KVgio2cEh6xJQ2PMnZWCwnJpaqwHULx26eqSA9zr3
         xI8FVgUasCe+FBexAzYwaFbONDezoipQY12KjqshE1v9A9WW5+ZGPhk83NGuh+/lfKMM
         qthw==
X-Gm-Message-State: ABy/qLajspkfa20640SbgQ1FGU4fJdsEhJFcrQTnBJfroqf2HdiS9nKC
        o7B7J4QdXvnbr0vka5fIqspdwOIm0OnogTie2mnmKyKe7dfHncMsRLyLFxRtMjF1EGjkJnHZNIE
        aPYVeoJP7O48MwPF8p53ba9ph
X-Received: by 2002:a05:620a:3195:b0:765:ac6f:df84 with SMTP id bi21-20020a05620a319500b00765ac6fdf84mr4696071qkb.4.1688712496807;
        Thu, 06 Jul 2023 23:48:16 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFH8ilJmpjOriuqxlHflP5tK93Vk3Lpph18AVN0GOH0fI6+exQDEUdBLbjtb9DvIA1NpOWNOg==
X-Received: by 2002:a05:620a:3195:b0:765:ac6f:df84 with SMTP id bi21-20020a05620a319500b00765ac6fdf84mr4696058qkb.4.1688712496618;
        Thu, 06 Jul 2023 23:48:16 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-230.web.vodafone.de. [109.43.176.230])
        by smtp.gmail.com with ESMTPSA id i21-20020a05620a075500b007677f66b160sm1530219qki.124.2023.07.06.23.48.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 23:48:15 -0700 (PDT)
Message-ID: <54dff33c-c289-23a8-cb02-d608e93b6ca2@redhat.com>
Date:   Fri, 7 Jul 2023 08:48:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] x86: Remove the arch_calc_vm_prot_bits() macro from the
 uapi
To:     Dave Hansen <dave.hansen@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20230706190217.371721-1-thuth@redhat.com>
 <2d9bb146-e1ec-4fc2-a4bc-e1c67cfda723@app.fastmail.com>
 <8ec7f329-a0a3-7631-ba05-225944b19771@intel.com>
Content-Language: en-US
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <8ec7f329-a0a3-7631-ba05-225944b19771@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/2023 22.30, Dave Hansen wrote:
> On 7/6/23 13:22, Arnd Bergmann wrote:
>> On Thu, Jul 6, 2023, at 21:02, Thomas Huth wrote:
>>> The arch_calc_vm_prot_bits() macro uses VM_PKEY_BIT0 etc. which are
>>> not part of the uapi, so the macro is completely useless for userspace.
>>> It is also hidden behind the CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
>>> config switch which we shouldn't expose to userspace. Thus let's move
>>> this macro into a new internal header instead.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> Fixes: 8f62c883222c9 ("x86/mm/pkeys: Add arch-specific VMA protection bits")
>> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
>>
>> It looks like this was introduced right after the uapi split,
>> and probably is the result of an incorrect rebase.
> 
> Yeah, I bet I just glossed over the "uapi" in the path.
> 
> Is this causing any real problems?  Or is it OK to just send it along
> during the next merge window with other random cleanups?

As Arnd already said, it's not a real problem - I just came across this file 
while looking at the list in scripts/headers_install.sh.

  Thomas


