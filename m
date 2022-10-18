Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714ED603348
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 21:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiJRTUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 15:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiJRTUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 15:20:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDACA5508E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 12:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666120795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0NZK5a4hlDEe42mcL1hOBkrM8mEbIxo3HSEb4Uc/k4s=;
        b=dhe5yhGSvT+811C2GxHFThUj7F0vK9H638dlyrEkwCyTDw6LupkBGYVjrq95WL3baYZj4j
        4gbwhkWEGgR+ZbeeE/wew2uCDQg9kVjrCB31AAWPddpZXBuJ3s1c53Ysp24wMZFLD1Xvo0
        VC/L/cPkcnHFMOENu7+DGlDAiulYUmg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-149--A6RJNSvMs-y1RHh2H654w-1; Tue, 18 Oct 2022 15:19:54 -0400
X-MC-Unique: -A6RJNSvMs-y1RHh2H654w-1
Received: by mail-qv1-f72.google.com with SMTP id g12-20020a0cfdcc000000b004ad431ceee0so9174280qvs.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 12:19:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0NZK5a4hlDEe42mcL1hOBkrM8mEbIxo3HSEb4Uc/k4s=;
        b=rehgVRSEaxsUAQcByB6N9o4c7CZqn8aubY3sbMH0CSqi/3FH1A1xh/yenyF/95vbVg
         6SfLD5Tqu6bIjfuHC1etZjUYL2XRgAbuvo+h2FJPP0U36Cs1ZcwHJfCgVW1mipv4a6T8
         KVERRWUf/ZIl/O7IC0wnwncLBhEjtnJ5bOlgWiUqlgejwQBkXQMRwKE9Q/Hhj8dN9QYR
         azc/m2o00ONrcS56nrN301LZXMbY4AYv9c1tZ4OeFvA+XAe+DMN2f2O8F14A93cTh6+x
         gcYA6UwoeNH4i0AYpx+AagZEhGr7iNbsnl+5tdlOUrm6O0/HqJWD80PVLM/DWiTF3Ykp
         kFfg==
X-Gm-Message-State: ACrzQf1KIhcDCzxlTnQ4wzpbxp3y49d6h/VsDdrbIzJI9W8qp6fWuqgg
        DSm8ijYnCFmSI9fUddfk3NOKGrkK+g8l2V16on5/t1fun2UIe4sBXsr//xHNYX8bAQJ2fLpTXBI
        478Y/nK9Wgs9YycYlH7bI1qGn
X-Received: by 2002:a05:620a:4548:b0:6ee:deba:2795 with SMTP id u8-20020a05620a454800b006eedeba2795mr2994075qkp.621.1666120794056;
        Tue, 18 Oct 2022 12:19:54 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7w4Z6sIZOnBg9vt5u3oo1kQARfnV39SGme7KRkbMiU9gu5XhYjstTQ9meJrPllvn67OhmNmg==
X-Received: by 2002:a05:620a:4548:b0:6ee:deba:2795 with SMTP id u8-20020a05620a454800b006eedeba2795mr2994059qkp.621.1666120793722;
        Tue, 18 Oct 2022 12:19:53 -0700 (PDT)
Received: from [10.16.222.26] (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id y13-20020a05620a25cd00b006bbf85cad0fsm3064126qko.20.2022.10.18.12.19.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 12:19:53 -0700 (PDT)
Message-ID: <9b6f8b9f-11bd-6850-0f73-3a4352181b97@redhat.com>
Date:   Tue, 18 Oct 2022 15:19:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 2/2] module: Merge same-name module load requests
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Petr Pavlu <petr.pavlu@suse.com>
Cc:     pmladek@suse.com, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220919123233.8538-1-petr.pavlu@suse.com>
 <20220919123233.8538-3-petr.pavlu@suse.com>
 <YzdR0gRNQI2BGnJ9@bombadil.infradead.org>
 <aa8d9456-b260-d999-0296-8e6ab876af7a@suse.com>
 <Y07xX2ejlg0oFoEy@bombadil.infradead.org>
From:   Prarit Bhargava <prarit@redhat.com>
In-Reply-To: <Y07xX2ejlg0oFoEy@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/22 14:33, Luis Chamberlain wrote:
> On Sat, Oct 15, 2022 at 11:27:10AM +0200, Petr Pavlu wrote:
>> The patch does address a regression observed after commit 6e6de3dee51a
>> ("kernel/module.c: Only return -EEXIST for modules that have finished
>> loading"). I guess it can have a Fixes tag added to the patch.
>>
>> I think it is hard to split this patch into parts because the implemented
>> "optimization" is the fix.
> 
> git describe --contains 6e6de3dee51a
> v5.3-rc1~38^2~6
> 
> I'm a bit torn about this situation. Reverting 6e6de3dee51a would be the
> right thing to do, but without it, it still leaves the issue reported
> by Prarit Bhargava. We need a way to resolve the issue on stable and
> then your optimizations can be applied on top.
> 
> Prarit Bhargava, please review Petry's work and see if you can come up
> with a sensible way to address this for stable.

Thanks for the heads up Luis.  I'll take a closer look.  [A long time 
ago] I could swear we made a very targeted decision to *NOT* allow 
modules with the same name to be loaded into the kernel.  What's changed 
that we think this is okay to do today?

Thanks,

P.

> 
>    Luis
> 

