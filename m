Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628186C48F8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 12:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjCVLUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 07:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjCVLU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 07:20:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7631048E08
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 04:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679483984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e3/nSZoroy6XHga0RIUuS2iBwJK2UyjAhfIJ68s4VJM=;
        b=IcgE80Lrt7FS8eV6BOv7arH9trt2MRAPJKPHhyK1JtUNic3EPN4L8a9/DiACGlF2HPZdTy
        5OVwir4Js+2m37r8osxKn3n06niG8hU6hmw6N76xrSpnWo3Bz4plgOJXqJkrdQV1HzLvu6
        bsLNaGE2ifQ8nhu1La9H3X6gHPpeIYU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-SRwvs2I4OKOV4qCCpHpA1g-1; Wed, 22 Mar 2023 07:19:43 -0400
X-MC-Unique: SRwvs2I4OKOV4qCCpHpA1g-1
Received: by mail-wm1-f71.google.com with SMTP id l17-20020a05600c1d1100b003ed29ba093cso7225142wms.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 04:19:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679483982;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e3/nSZoroy6XHga0RIUuS2iBwJK2UyjAhfIJ68s4VJM=;
        b=69BW5V11klr1ST0P1AlB7aziOHggO8lyiBmoey76fBIUVgyWXdZBxzY7WWdm84d7oK
         8WcpyMDCkzoR0sTqc1Y/81LbfaCxBBiNinRz5ZeQuRc6hsZvd8JShiCadsmfJhAdJ5Cr
         IsNLMyyfIdbR6mev2C2evn5yLDQ5WcqAbA1fm4R6B8h3wvXk0d0qU1a8/QA9gA2LPeUh
         LqR2sNj9v93tYYCgnm4AaWmVtyOiX1gBwOs+b8kcEff+ZzP9oxhS+0jRixl8+yk5TENn
         McLZ+2XvwYEuWh4/1SKPFZ++huBjcXV6oAkEXEvO60x0XSuYthyaTkJx7IcuyHNcp+mv
         qJ0A==
X-Gm-Message-State: AO0yUKXnFpao0CxUmaI/hA4KEpsyKjqTbJT26+X7B6sD6auRflhCjgZC
        DSvYqkHysYwMoZ9Ec4mXPK6/kBtmDS3C/+S5e7RNXSy2nkAsPokpU6wSj0sjrTIlOujOzHeYuvQ
        aH7457/6E0/nnCZ/n6GLQUcXI
X-Received: by 2002:adf:f885:0:b0:2d2:39d3:ce7c with SMTP id u5-20020adff885000000b002d239d3ce7cmr4635776wrp.70.1679483982400;
        Wed, 22 Mar 2023 04:19:42 -0700 (PDT)
X-Google-Smtp-Source: AK7set+9yQcW9mnOqm/TbVZZpP3tWHGR1CXLts64jiq/IWPswo5SopyoJGwWUerGNZUby6CY1fUe8w==
X-Received: by 2002:adf:f885:0:b0:2d2:39d3:ce7c with SMTP id u5-20020adff885000000b002d239d3ce7cmr4635761wrp.70.1679483982127;
        Wed, 22 Mar 2023 04:19:42 -0700 (PDT)
Received: from ?IPV6:2003:cb:c703:d00:ca74:d9ea:11e0:dfb? (p200300cbc7030d00ca74d9ea11e00dfb.dip0.t-ipconnect.de. [2003:cb:c703:d00:ca74:d9ea:11e0:dfb])
        by smtp.gmail.com with ESMTPSA id d7-20020adffbc7000000b002d5a8d8442asm9363506wrs.37.2023.03.22.04.19.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 04:19:41 -0700 (PDT)
Message-ID: <95c37e76-74a8-a384-e7f0-4e476ed52e15@redhat.com>
Date:   Wed, 22 Mar 2023 12:19:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 00/14] mm: move core MM initialization to mm/mm_init.c
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Doug Berger <opendmb@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org
References: <20230321170513.2401534-1-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230321170513.2401534-1-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.03.23 18:04, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> Also in git:
> https://git.kernel.org/rppt/h/mm-init/v2
> 
> v2:
> * move init_cma_reserved_pageblock() from cma.c to mm_init.c
> * rename init_mem_debugging_and_hardening() to
>    mem_debugging_and_hardening_init()
> * inline pgtable_init() into mem_core_init()
> * add Acked and Reviewed tags (thanks David, hopefully I've picked them
>    right)

Sorry, I get lazy on large patches and only ACK instead of checking each 
and every line :)

-- 
Thanks,

David / dhildenb

