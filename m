Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06EF9712CD8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 20:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242344AbjEZSvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 14:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237418AbjEZSvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 14:51:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17962125
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685127024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Iv1rySWpJ3wV63UZEQURnsupoRRaDiB4keiWDoZznIA=;
        b=RHfFnOOPmx0sBIfNuQkQW5tcRToo2E61xiy4ErEW6YLrqqCnuiKZ8YkRPFby5VyOSpDYj/
        SrsFnl1fpaZXrx5Rj7D25NX30jIuucwmo5P8z1kYpZGAJMuRP1+ICUke15vURMeoIWEKi3
        JojhdByoMVfrWk4aiY2uct5Jgyf7ia4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-EtUug-LQPkCc3aRU5U3Xgw-1; Fri, 26 May 2023 14:50:22 -0400
X-MC-Unique: EtUug-LQPkCc3aRU5U3Xgw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-30a88ed463eso443409f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:50:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685127021; x=1687719021;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Iv1rySWpJ3wV63UZEQURnsupoRRaDiB4keiWDoZznIA=;
        b=TdrjFOqKNivAm6iRUwEMqMVsbQTJKfkp7yvYIRqYbjl/L/2hr0DoExLQYHIrEKZtj+
         a+N5dhTfoUSeAXx1c8sWrQDlkRdMtB7bUoLK80VJBMfmo3tBjCRJdjdZ8kMyvOSkeMw3
         xtticCe9UfVcxGKVAld6Eb/iodkSVvvINTVgOV6OeEpwcwVfu5cpvM9AayyRxw/4I3iK
         9h4Pjm3pLhluv/m4jfMcpACfuvlkXy8JH0Gs4Is92iAJ3a9QPWHtrwDZ46NEPdKyRipi
         GQwexS6gdfHAshmzbHCA9rVIav9Xi7hPOGCCUexahMBlwY2glXloU/+Vx3s3ah0rKEz5
         d7Dw==
X-Gm-Message-State: AC+VfDx0EHFsiUIyTErSlf/gJnf7jzhhklOCdDfiPqGKbK0LH5B2wHPC
        /HIsshxzHjCYqpJgJSpzKtTCBoSi/gqEXvNsBOCWZ+Jwh52dUIy+Vakip0/Sg/bxKsoPFng/oWv
        aoFNVAyXWuQSnwDewLdPBIefWmiW2Z1oy
X-Received: by 2002:a5d:4692:0:b0:306:3912:a7f0 with SMTP id u18-20020a5d4692000000b003063912a7f0mr1821711wrq.50.1685127021404;
        Fri, 26 May 2023 11:50:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5AHGb2j2bC1dzW1ck3vYSHMHeI+g1bm2+xdrB6+cWUAioBUBvLaZef/1lx9/GXfgiMT/QPeg==
X-Received: by 2002:a5d:4692:0:b0:306:3912:a7f0 with SMTP id u18-20020a5d4692000000b003063912a7f0mr1821696wrq.50.1685127021032;
        Fri, 26 May 2023 11:50:21 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2e:ae00:f2e3:50e0:73f7:451? (p200300d82f2eae00f2e350e073f70451.dip0.t-ipconnect.de. [2003:d8:2f2e:ae00:f2e3:50e0:73f7:451])
        by smtp.gmail.com with ESMTPSA id z13-20020adfd0cd000000b003048477729asm5796307wrh.81.2023.05.26.11.50.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 11:50:20 -0700 (PDT)
Message-ID: <e31cd404-56ce-4cad-fcc3-3a6695f750fa@redhat.com>
Date:   Fri, 26 May 2023 20:50:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4] mm, compaction: Skip all non-migratable pages during
 scan
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Khalid Aziz <khalid.aziz@oracle.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        akpm@linux-foundation.org, ying.huang@intel.com,
        mgorman@techsingularity.net, baolin.wang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Khalid Aziz <khalid@kernel.org>
References: <20230525191507.160076-1-khalid.aziz@oracle.com>
 <ZG+99h3zg7POIits@casper.infradead.org>
 <ee093583-71c3-51ba-980f-0facb03b0e23@oracle.com>
 <ZG/I7tYY4uV/32hP@casper.infradead.org>
 <ZG/To8Z3StoVoenU@casper.infradead.org>
 <60367660-f4a3-06dc-4d17-4dbdc733ef74@oracle.com>
 <ZHDh4Jeb/vKY+nGU@casper.infradead.org>
 <f5a37f8d-d888-9085-2f2b-1e350a267396@redhat.com>
 <ZHD+eOMpZpWXNAig@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZHD+eOMpZpWXNAig@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.05.23 20:46, Matthew Wilcox wrote:
> On Fri, May 26, 2023 at 06:46:15PM +0200, David Hildenbrand wrote:
>> On 26.05.23 18:44, Matthew Wilcox wrote:
>>> On Fri, May 26, 2023 at 09:44:34AM -0600, Khalid Aziz wrote:
>>>>> Oh, I think I found it!  pin_user_pages_remote() is called by
>>>>> vaddr_get_pfns().  If these are the pages you're concerned about,
>>>>> then the efficient way to do what you want is simply to call
>>>>> folio_maybe_dma_pinned().  Far more efficient than the current mess
>>>>> of total_mapcount().
>>>>
>>>> vfio pinned pages triggered this change. Wouldn't checking refcounts against
>>>> mapcount provide a more generalized way of detecting non-migratable pages?
>>>
>>> Well, you changed the comment to say that we were concerned about
>>> long-term pins.  If we are, than folio_maybe_dma_pinned() is how to test
>>> for long-term pins.  If we want to skip pages which are short-term pinned,
>>> then we need to not change the comment, and keep using mapcount/refcount
>>> differences.
>>>
>>
>> folio_maybe_dma_pinned() is all about FOLL_PIN, not FOLL_LONGTERM.
> 
> But according to our documentation, FOLL_LONGTERM implies FOLL_PIN.

Yes. But folio_maybe_dma_pinned() will indicate both, long-term pins and 
short-term pins. There really is no way to distinguish both, unfortunately.

> Anyway, right now, the code skips any pages which are merely FOLL_GET,
> so we'll skip fewer pages if we do only skip the FOLL_PIN ones,
> regardless if we'd prefer to only skip the FOLL_LONGTERM ones.
> 
>> folio_maybe_dma_pinned() would skip migrating any page that has more than
>> 1024 references. (shared libraries?)
> 
> True, but maybe we should be skipping any page with that many mappings,
> given how disruptive it is to the rest of the system to unmap a page
> from >1024 processes.
> 

So any user with 1024 processes can fragment physical memory? :/

Sorry, I'd like to minimize the usage of folio_maybe_dma_pinned().

It's all suboptimal but let's not try to make it worse.

-- 
Thanks,

David / dhildenb

