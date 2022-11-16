Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC21662C360
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 17:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbiKPQEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 11:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbiKPQEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 11:04:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D182F651
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 08:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668614638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FkGu3btRF6wX/8Cp9qFReUmy5dmFx47Q/M8BwCZWHrw=;
        b=XPUPRD4RPldbRjrLlLkIUMVx67dPw1PnrVBi5EAMmQBbSbRwnkguvNU/FoVoy84FfeGfn4
        5LmcrCjO2ywD4kEoOssrohQcI4OZ/j2MWglGh4w9fCUFBj31uTK10h7x8pwfgwxcSNn4d6
        3MTK3fosuz1VqMjJfkN72akiR7D/rNY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-351-PnRj7g9rPCmWrJTpNEh0tg-1; Wed, 16 Nov 2022 11:03:56 -0500
X-MC-Unique: PnRj7g9rPCmWrJTpNEh0tg-1
Received: by mail-qt1-f200.google.com with SMTP id i4-20020ac813c4000000b003a5044a818cso13380610qtj.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 08:03:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FkGu3btRF6wX/8Cp9qFReUmy5dmFx47Q/M8BwCZWHrw=;
        b=zVkUn2zq/Z1hndmIL0YqZ7AebXzS6JDm9iHKjVcD1axxkRKtJoV45P/j4eJAUIp51L
         gVCHZ0NbLx3WUoRKCszIYPVEKRAllEuSFGEO+xEUL9qCSNMCa/LsTbrDMscCUZX5TeWt
         a53ZaIOneDbzDKR0VqJ/VeLL/eUi9S4ZyKUfq3xGuho+mEs3nQZ9Hm1hX4PeKaDDWN1A
         5E7AN3z3BmJDeC/WBV6ZNOpQAiC9flJf9vc5NFU7TXjvazuqHn8CzOTTBrEK6dyCEFqW
         yOTF9Gl/28ZHSgm027MzSQbLSfkTGGYize9QIpLVVEamSjcZt/e3tmy1oXG8+UACXB0x
         MTNg==
X-Gm-Message-State: ANoB5pkazA9t7uPt24WBFqwwNTjzZXEmE075ENpzT4gwaebybDC8uoYm
        AY7HhsDwtfsBNZ8vPWOK2rb3I/CH+F6Y1MP1Wq6YkkA2clJcxINHUJzl2qOVuxuzhkkyuwnSz7S
        WuPnRF8IuBp9pYBk+X3MhsW4W
X-Received: by 2002:ac8:71c4:0:b0:3a4:f1c1:49a9 with SMTP id i4-20020ac871c4000000b003a4f1c149a9mr21556961qtp.464.1668614636017;
        Wed, 16 Nov 2022 08:03:56 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4Do1ucZVCi1sjsbyFAMwyi1hUQR7O3+Bc8G5p09qPDkp+L5YZTGFKwkNN7X5R/zNxYgRDGpA==
X-Received: by 2002:ac8:71c4:0:b0:3a4:f1c1:49a9 with SMTP id i4-20020ac871c4000000b003a4f1c149a9mr21556937qtp.464.1668614635721;
        Wed, 16 Nov 2022 08:03:55 -0800 (PST)
Received: from [10.16.222.26] (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id bi28-20020a05620a319c00b006fb0e638f12sm10465916qkb.4.2022.11.16.08.03.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 08:03:55 -0800 (PST)
Message-ID: <c2e841b7-e2b3-09f9-8187-328131d72c5d@redhat.com>
Date:   Wed, 16 Nov 2022 11:03:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 2/2] module: Merge same-name module load requests
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>,
        David Hildenbrand <david@redhat.com>
Cc:     pmladek@suse.com, Petr Pavlu <petr.pavlu@suse.com>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220919123233.8538-1-petr.pavlu@suse.com>
 <20220919123233.8538-3-petr.pavlu@suse.com>
 <YzdR0gRNQI2BGnJ9@bombadil.infradead.org>
 <aa8d9456-b260-d999-0296-8e6ab876af7a@suse.com>
 <Y07xX2ejlg0oFoEy@bombadil.infradead.org>
 <d0bc50e3-0e42-311b-20ed-7538bb918c5b@suse.com>
 <Y277Jb9i2VeXQoTL@bombadil.infradead.org>
 <e070839f-c224-047b-9411-91143c1d8394@redhat.com>
 <Y3Jg8X7qv2AKPU1J@bombadil.infradead.org>
 <5467e66d-55de-ca8f-c1ae-ffe6efe7290d@redhat.com>
 <Y3Pol5H4kJioAV9W@bombadil.infradead.org>
From:   Prarit Bhargava <prarit@redhat.com>
In-Reply-To: <Y3Pol5H4kJioAV9W@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/22 14:29, Luis Chamberlain wrote:
> On Mon, Nov 14, 2022 at 04:45:05PM +0100, David Hildenbrand wrote:
>> Note that I don't think the issue I raised is due to 6e6de3dee51a.
>> I don't have the machine at hand right now. But, again, I doubt this will
>> fix it.
> 
> There are *more* modules processed after that commit. That's all. So
> testing would be appreciated.
> 

Can anyone tell us if

https://lore.kernel.org/linux-pm/20221102195957.82871-1-stuart.w.hayes@gmail.com/

resolves the module loading delay problem?

/me is testing now

P.

>    Luis
> 

