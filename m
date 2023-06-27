Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F252B740316
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 20:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjF0SUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 14:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjF0SUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 14:20:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95768107
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 11:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687890004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QA/qzvzGetcCbbR+btLCD+i0WzBbqFbQ1AZROAITRL8=;
        b=GT6xPey2mU4GXaAxc+DzHwT1dXz1fPkvSdDedc/CdtX2evf+WmkZ41KyZG7RjHKJde18eM
        dwtqTbTxEEXo4wxVF5pa9WwHatlNS7eKSlef5w2ZCCNLKwl7iaBCXB8QpZoYEUGhwHxGaB
        PLR0exCngoCPmTZLLuXXDRPw7LEbkbs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-ROhOfOLfNcSKEszcFcLw1g-1; Tue, 27 Jun 2023 14:20:03 -0400
X-MC-Unique: ROhOfOLfNcSKEszcFcLw1g-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-98e40d91fdfso265356866b.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 11:20:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687890001; x=1690482001;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QA/qzvzGetcCbbR+btLCD+i0WzBbqFbQ1AZROAITRL8=;
        b=PhF+e/OAsDw5S8IkwLrUhqaRIjGCWL9o3eFWlf8mjq6V4icwZlpf+fGWA+9jytAsJd
         OlA9qVJnZwq59bcSGRjIGRYdZdEpnz+jqfOiXMsA44nMpKFHN42DXaaQQUjb+Nxk7RQh
         yo4PS3AJMLCXNQZGkzi6TK4YQ+APgh8CObCwrwJCLM9ECDGbqr9JWjvi6TvSBdpjXr3Q
         XS1rRGuJrdlYpqCWhRPaZsoUDdmgL4KWxIpsnFpR2OBPEOjgWQDl5aM4GF/wMZv9Nc3V
         q3Gwx0evWilbd2y4cPe0JXhG8tQNLu/fuk3Ex7Y16C3hyT+9ywyux9aBbJwbumPNb6yM
         634g==
X-Gm-Message-State: AC+VfDzTVWjtHQNx+SpOdi9Fzj9/rUY0OLEJ9bgg+rmQuWYXl3pSY2C/
        eDLEtuk2sC3SFgvmCbaHG6RSCsDnovCT3vQPmkhYfljwfl+9q1TIH3Seov65bCINzT8brOduHgw
        9TSJuf9QJ/b7ZHcQhaNevKLJhaTK/7gpy
X-Received: by 2002:a17:907:6e0f:b0:992:1309:be3a with SMTP id sd15-20020a1709076e0f00b009921309be3amr2783194ejc.0.1687890001092;
        Tue, 27 Jun 2023 11:20:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ65ihjTp3Ah5fR3hDKFgPeZaPbvDZ/9mQbYcWwQHsjW8c4MrLp+u66qGKu8iJo3p+yxvpy40w==
X-Received: by 2002:a17:907:6e0f:b0:992:1309:be3a with SMTP id sd15-20020a1709076e0f00b009921309be3amr2783183ejc.0.1687890000832;
        Tue, 27 Jun 2023 11:20:00 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id o10-20020a17090637ca00b00992025654c2sm1389506ejc.150.2023.06.27.11.20.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 11:20:00 -0700 (PDT)
Message-ID: <32fb03bf-be43-d416-4a32-b30a0c339496@redhat.com>
Date:   Tue, 27 Jun 2023 20:19:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] fs/vboxsf: Replace kmap() with kmap_local_{page, folio}()
From:   Hans de Goede <hdegoede@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Sumitra Sharma <sumitraartsy@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>,
        Fabio <fmdefrancesco@gmail.com>, Deepak R Varma <drv@mailo.com>
References: <20230627135115.GA452832@sumitra.com>
 <6a566e51-6288-f782-2fa5-f9b0349b6d7c@redhat.com>
 <ZJsgWQb+tOqtQuKL@casper.infradead.org>
 <3baed0e0-db2c-906c-5256-1d83d59794e9@redhat.com>
Content-Language: en-US, nl
In-Reply-To: <3baed0e0-db2c-906c-5256-1d83d59794e9@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/27/23 20:10, Hans de Goede wrote:
> Hi Matthew,
> 
> On 6/27/23 19:46, Matthew Wilcox wrote:
>> On Tue, Jun 27, 2023 at 04:34:51PM +0200, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 6/27/23 15:51, Sumitra Sharma wrote:
>>>> kmap() has been deprecated in favor of the kmap_local_page() due to high
>>>> cost, restricted mapping space, the overhead of a global lock for
>>>> synchronization, and making the process sleep in the absence of free
>>>> slots.
>>>>
>>>> kmap_local_{page, folio}() is faster than kmap() and offers thread-local
>>>> and CPU-local mappings, can take pagefaults in a local kmap region and
>>>> preserves preemption by saving the mappings of outgoing tasks and
>>>> restoring those of the incoming one during a context switch.
>>>>
>>>> The difference between kmap_local_page() and kmap_local_folio() consist
>>>> only in the first taking a pointer to a page and the second taking two
>>>> arguments, a pointer to a folio and the byte offset within the folio which
>>>> identifies the page.
>>>>
>>>> The mappings are kept thread local in the functions 'vboxsf_read_folio',
>>>> 'vboxsf_writepage', 'vboxsf_write_end' in file.c
>>>>
>>>> Suggested-by: Ira Weiny <ira.weiny@intel.com>
>>>> Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
>>>
>>> Thanks, patch looks good to me:
>>
>> It doesn't look great to me, tbh.  It's generally an antipattern to map
>> the page/folio up at the top and then pass the virtual address down to
>> the bottom.  Usually we want to work in terms of physical addresses
>> as long as possible.  I see the vmmdev_hgcm_function_parameter can
>> take physical addresses; does it work to simply use the phys_addr
>> instead of the linear_addr?  I see this commentary:
>>
>>        /** Deprecated Doesn't work, use PAGELIST. */
>>         VMMDEV_HGCM_PARM_TYPE_PHYSADDR           = 3,
>>
>> so, um, can we use
>>         /** Physical addresses of locked pages for a buffer. */
>>         VMMDEV_HGCM_PARM_TYPE_PAGELIST           = 10,
>>
>> and convert vboxsf_read_folio() to pass the folio down to vboxsf_read()
>> which converts it to a PAGELIST (however one does that)?
> 
> 
> It has been a long time since I looked at this code in detail. I don't
> think you can just use different types when making virtualbox hypervisor
> calls and then expect the hypervisor to say sure that another way to
> represent a memory buffer, I'll take that instead.

Ok correction to this, drivers/virt/vboxguest/vboxguest_utils.c actually
already translates the VMMDEV_HGCM_PARM_TYPE_LINADDR_KERNEL_IN /
VMMDEV_HGCM_PARM_TYPE_LINADDR_KERNEL_OUT buffers used by vboxsf_write()/
vboxsf_read() to PAGELIST-s before passing them to the hypervisor
using page_to_phys(virt_to_page()) so we map a page and then call
page_to_phys(virt_to_page()) on it which indeed is quite inefficient.

That still leaves the problem that I have very little time to look into
this though ...

Regards,

Hans


