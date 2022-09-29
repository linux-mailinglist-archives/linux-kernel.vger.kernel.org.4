Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFAC5EFC1B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 19:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235585AbiI2Rf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 13:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235776AbiI2Rfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 13:35:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A5C12B5CB
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 10:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664472948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6QvssFP6fElsinFmtORISS+XoH9LM/qj79vCQgHmORo=;
        b=ZoT4Ql8ke9cNa3BBuWOf6HTG//R2jL4kpSHaub2823YD0r+ZqIe97m03lOwOBRwZT8cNI6
        Ccu7UnprXD13vTwwtj+JMQN2D6/WO6RFRaFxRLsecpGT1IXX6tE1YZOeQTpZBTliXuy3hX
        CJtpg9nuyAWD7pPQK3G45fTE8xRlpNw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-458-qmxdLoFePs-8qqP6jUc1pA-1; Thu, 29 Sep 2022 13:35:46 -0400
X-MC-Unique: qmxdLoFePs-8qqP6jUc1pA-1
Received: by mail-ed1-f70.google.com with SMTP id t13-20020a056402524d00b00452c6289448so1767329edd.17
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 10:35:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=6QvssFP6fElsinFmtORISS+XoH9LM/qj79vCQgHmORo=;
        b=cdixCQ7ukaA/Ugmvb+/DC+lG5BJ5SCTYxh0WRVnM3zXsIc/YNTVkJeOzNVDU6S74fr
         6WMutuV7pAM2BVa4FDCJa+cx6u6k+DFCgpayiiS79MIKfud3jKA2uJ5o28BqEW/csTqj
         hlYRUVskkBLKz3mEMcYGttTQbLmGwRmjKBaMYXKKimlhiFrCe/IYFq1WGEh6rivtEQEs
         bYfIOVG19IDgD3Bgpo/hlagFe6AwszEBkjbG7M8ZP4E/n2nEgWvsa1vTQiNImcsTPFJi
         r3LONko6VqZAsW9hZ9qYcGjXQ2/4VbRC3ZEwqhAg4rj3fCh7XkYf60qDLcwG/5o6faiM
         B0Fg==
X-Gm-Message-State: ACrzQf1uSqazEmj6dByaX7bnlgOiWZpugf+oWbF3jpXEcRfizAJ82o+p
        VVO+XMjZMM7q8wvDDjeZV9eeR6aw7EqFnrP0ABLTz9b/vEPpScmqFVC/BOfja5rXZtAMfUKiPII
        IghnekehkUQoqME8Nawzy7Vc1
X-Received: by 2002:a05:6402:5110:b0:450:c196:d7b1 with SMTP id m16-20020a056402511000b00450c196d7b1mr4360247edd.117.1664472945483;
        Thu, 29 Sep 2022 10:35:45 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4A74v/Mt3k+wNZ3JdUTgnnAt+nGzICSWWKg87i5m1tJ9DRruLO3VYyV2zBao0y66SzFcmaDw==
X-Received: by 2002:a05:6402:5110:b0:450:c196:d7b1 with SMTP id m16-20020a056402511000b00450c196d7b1mr4360230edd.117.1664472945244;
        Thu, 29 Sep 2022 10:35:45 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:1c09:f536:3de6:228c? ([2001:b07:6468:f312:1c09:f536:3de6:228c])
        by smtp.googlemail.com with ESMTPSA id l13-20020a056402124d00b00456e98b7b7asm67429edw.56.2022.09.29.10.35.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 10:35:44 -0700 (PDT)
Message-ID: <32db4f89-a83f-aac4-5d27-0801bdca60bf@redhat.com>
Date:   Thu, 29 Sep 2022 19:35:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: Commit 'iomap: add support for dma aligned direct-io' causes
 qemu/KVM boot failures
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, qemu-devel@nongnu.org,
        kvm@vger.kernel.org, Kevin Wolf <kwolf@redhat.com>,
        Michael Roth <mdroth@linux.vnet.ibm.com>
References: <fb869c88bd48ea9018e1cc349918aa7cdd524931.camel@redhat.com>
 <YzW+Mz12JT1BXoZA@kbusch-mbp.dhcp.thefacebook.com>
 <a2825beac032fd6a76838164d4e2753d30305897.camel@redhat.com>
 <YzXJwmP8pa3WABEG@kbusch-mbp.dhcp.thefacebook.com>
 <20220929163931.GA10232@lst.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220929163931.GA10232@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/22 18:39, Christoph Hellwig wrote:
> On Thu, Sep 29, 2022 at 10:37:22AM -0600, Keith Busch wrote:
>>> I am aware, and I've submitted the fix to qemu here:
>>> 
>>>   https://lists.nongnu.org/archive/html/qemu-block/2022-09/msg00398.html
>>
>> I don't think so. Memory alignment and length granularity are two completely
>> different concepts. If anything, the kernel's ABI had been that the length
>> requirement was also required for the memory alignment, not the other way
>> around. That usage will continue working with this kernel patch.
> 
> Well, Linus does treat anything that breaks significant userspace
> as a regression.  Qemu certainly is significant, but that might depend
> on bit how common configurations hitting this issue are.

Seeing the QEMU patch, I agree that it's a QEMU bug though.  I'm 
surprised it has ever worked.

It requires 4K sectors in the host but not in the guest, and can be 
worked around (if not migrating) by disabling O_DIRECT.  I think it's 
not that awful, but we probably should do some extra releases of QEMU 
stable branches.

Paolo

