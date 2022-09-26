Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0212B5E9C0C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 10:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234371AbiIZI3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 04:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234509AbiIZI2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 04:28:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DA23AB0E
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664180911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HqsG+MVHFIIYUXh9jWxIMmssIKFxTC2Q+EMTX/72P4E=;
        b=YfLZTyMqGQSA4Og7yQvpS/6TOLFLdMDDwYF4RgWTdhu1SkC1Q113u8rUGFD/8qBBPpdVdD
        q3WZvFOaKsK4WQvjs/W16/aLfkboC+hADS7NgdfB2cHHVWJC6CrtdR36EF7TvCujCQ2cfp
        HO5Wx3TXrw4BK+dv0V2rGw2ldE60ZmU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-659-WuWnw8xlMS6YMJBsJsT2wQ-1; Mon, 26 Sep 2022 04:28:29 -0400
X-MC-Unique: WuWnw8xlMS6YMJBsJsT2wQ-1
Received: by mail-wr1-f71.google.com with SMTP id c21-20020adfa315000000b0022adc2a2edaso930993wrb.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:28:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=HqsG+MVHFIIYUXh9jWxIMmssIKFxTC2Q+EMTX/72P4E=;
        b=qTpdWycwFvY0q4bDDRUlz4sWOdY0kM1QXIB9lnDQEE/XwpceXq56NgS0CarqIFZByU
         b4Yiu6iG3ZKXIO9wfjHzju/ZSGvL9KzgWTTW8Pt1DluWjvzjJU4NhcKr89jYYcQ5uAg1
         mbK06dXgEV1SNpqSDZTkzEYjc2OSWlqMb+QPIDAL8FyzQADHn1Q1RBjFBTbRs0X8P9+E
         MThYvBYJBXQetSv+H7C82LoIv2SzfUXyyCjEppkzF8RflCz3bgOitsH/ZsD1D8q4iisv
         PqhaiXomNzOksS0u7gqQOnt1xWW0CFOBNMhAX8k7HdXfjmTMGWOzFRaLtDux+LteHH3n
         ac6Q==
X-Gm-Message-State: ACrzQf1giJCYNqDYDbmTHaYjhfhEjttCfec2FsKpK+PQwubuITZQmmm2
        VHG4WKsFZv3Dk4zSdR1xBSMjgqxR1JAvVm0MDMAixG9y0H8kP2vZIjDeXsfDNfvBjxkwLvFAW0g
        T6/5X/kNiNPWq42ZU9E8WLR5v
X-Received: by 2002:adf:ee89:0:b0:228:7bdf:47d with SMTP id b9-20020adfee89000000b002287bdf047dmr12331985wro.641.1664180908455;
        Mon, 26 Sep 2022 01:28:28 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7Bl/WEHU2vEBAzJ2u0mYVj47cUqiOCermg8qPqGs7Ef8aijleyg7ahis7ThaGwb8JRoRHffQ==
X-Received: by 2002:adf:ee89:0:b0:228:7bdf:47d with SMTP id b9-20020adfee89000000b002287bdf047dmr12331970wro.641.1664180908227;
        Mon, 26 Sep 2022 01:28:28 -0700 (PDT)
Received: from ?IPV6:2003:cb:c703:4b00:e090:7fa6:b7d6:d4a7? (p200300cbc7034b00e0907fa6b7d6d4a7.dip0.t-ipconnect.de. [2003:cb:c703:4b00:e090:7fa6:b7d6:d4a7])
        by smtp.gmail.com with ESMTPSA id y5-20020a5d6145000000b00226dedf1ab7sm13413277wrt.76.2022.09.26.01.28.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 01:28:27 -0700 (PDT)
Message-ID: <f8ff6148-2775-4465-809b-36a4e5a4c403@redhat.com>
Date:   Mon, 26 Sep 2022 10:28:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 2/3] mm/page_table_check: Do WARN_ON instead of BUG_ON by
 default
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     akpm@linux-foundation.org, corbet@lwn.net, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        rick.p.edgecombe@intel.com
References: <20220911095923.3614387-1-pasha.tatashin@soleen.com>
 <20220911095923.3614387-3-pasha.tatashin@soleen.com>
 <Yx4IEvkmAlcTIP6v@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Yx4IEvkmAlcTIP6v@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.09.22 18:08, Matthew Wilcox wrote:
> On Sun, Sep 11, 2022 at 09:59:22AM +0000, Pasha Tatashin wrote:
>> Currently, page_table_check when detects errors panics kernel. Instead,
>> print a warning, and panic only when specifically requested via kernel
>> parameter:
>>
>> 	page_table_check=panic
> 
> Why are the page table checks so special that they deserve their own
> command line parameter?  Why shouldn't this be controlled by the usual
> panic_on_warn option?
> 

I agree.

https://lkml.kernel.org/r/20220923113426.52871-2-david@redhat.com

Use of WARN_ON_ONCE is the way to go nowadays.

-- 
Thanks,

David / dhildenb

