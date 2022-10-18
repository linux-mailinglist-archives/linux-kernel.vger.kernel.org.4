Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20E1602A0A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 13:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiJRLWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 07:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiJRLWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 07:22:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D6AB14F9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 04:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666092128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AXkk/TJRt0g740mma5eSU1gKEx5XPe7qX5hV83DWnhU=;
        b=aoxyLDDhOxiO7QebJmHtfUVdqgWlciqtsh3W+lZ7D59Us4aCCaiWqZFg4psF3w8p1uvLtq
        qo9nSXwXa7RCSQiBcZ3iNPjLSWhZQt4c6Cuj4qU/RmcwDUVr1cBAOCWb7CGuLpXEEqJTIm
        VFUr1KssGMnfr+IgkUHMI7lExnY5pKA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-27-5vZGNFnJPxqvxZKYtiOlBw-1; Tue, 18 Oct 2022 07:22:07 -0400
X-MC-Unique: 5vZGNFnJPxqvxZKYtiOlBw-1
Received: by mail-wr1-f70.google.com with SMTP id h4-20020adfa4c4000000b0022ec3966c3aso4462711wrb.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 04:22:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AXkk/TJRt0g740mma5eSU1gKEx5XPe7qX5hV83DWnhU=;
        b=UpzTZVhOERw73EeOoA5lLzQncy7OIQNRwne6MTrVcAQkEEHpZPDPoen8ctTvw+tOzn
         aX3O+MTx46SRxHhtGu9cyWiXUrLqfqEYFKuBWi1Hs5a0ewX4+TUQldbN4jD3I7+UFTbC
         cYKnILbkXem2dHkX4/2ezn6aPjHcdIvoZvOqAdRNiTd8Q1683FGIkd5qFEuvB9KpRl+j
         Cx5/NL8oxDDtv0FwSnBION0FV1PkCygVKWq7wHBqWdzQSYpQnboCvNxMx9yLGDbGkV2t
         9B0vYIVoUVybE0rjnyQ2SaLYvPTevAUwndgfM+o6qYyrIemyG6081IT04O/z9rfKBVXZ
         IV2Q==
X-Gm-Message-State: ACrzQf38JNphAnvBKRVqpU7JbyGO4OybgQEJBZfknATXbnxOEG3dgFen
        YMg05gX2Fi57ojzIkhI0TTg8EQmCS3CFwyV88boEMNuFfraWfOG56xUtoRj70E7bqugBHpvuQYt
        xuKptl8U4BGRYpKdH8ZY+f6wW
X-Received: by 2002:a5d:5583:0:b0:22e:3eb7:c2b9 with SMTP id i3-20020a5d5583000000b0022e3eb7c2b9mr1561383wrv.195.1666092126489;
        Tue, 18 Oct 2022 04:22:06 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5HsLM/nUQ1ExV1kxtscrpNczaZThifRym9cy1+40J1HPOyRm7Eslqxl5hGc79wDEjHcXztwQ==
X-Received: by 2002:a5d:5583:0:b0:22e:3eb7:c2b9 with SMTP id i3-20020a5d5583000000b0022e3eb7c2b9mr1561371wrv.195.1666092126150;
        Tue, 18 Oct 2022 04:22:06 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:8900:d1f:5430:86b1:31ba? (p200300cbc70589000d1f543086b131ba.dip0.t-ipconnect.de. [2003:cb:c705:8900:d1f:5430:86b1:31ba])
        by smtp.gmail.com with ESMTPSA id r14-20020a056000014e00b0022e51c5222esm10687385wrx.86.2022.10.18.04.22.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 04:22:05 -0700 (PDT)
Message-ID: <6154cb02-79d4-481c-b88d-33f5cde45738@redhat.com>
Date:   Tue, 18 Oct 2022 13:22:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [akpm-mm:mm-unstable 76/100] mm/ksm.c:423:5: warning: no previous
 prototype for 'break_ksm_pud_entry'
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
References: <202210181850.NTVfp2SW-lkp@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <202210181850.NTVfp2SW-lkp@intel.com>
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

On 18.10.22 12:53, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-unstable
> head:   f5938bbbb79d48ca167e305c228dccbecea0309e
> commit: 268ae2f9f2a7303079739cb975348a8ede4cda1d [76/100] mm/ksm: convert break_ksm() to use walk_page_range_vma()
> config: arc-randconfig-r043-20221017
> compiler: arceb-elf-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?id=268ae2f9f2a7303079739cb975348a8ede4cda1d
>          git remote add akpm-mm https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git
>          git fetch --no-tags akpm-mm mm-unstable
>          git checkout 268ae2f9f2a7303079739cb975348a8ede4cda1d
>          # save the config file
>          mkdir build_dir && cp config build_dir/.config
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>>> mm/ksm.c:423:5: warning: no previous prototype for 'break_ksm_pud_entry' [-Wmissing-prototypes]
>       423 | int break_ksm_pud_entry(pud_t *pud, unsigned long addr, unsigned long next,
>           |     ^~~~~~~~~~~~~~~~~~~
>>> mm/ksm.c:432:5: warning: no previous prototype for 'break_ksm_pmd_entry' [-Wmissing-prototypes]
>       432 | int break_ksm_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long next,
>           |     ^~~~~~~~~~~~~~~~~~~
> 

Right, both should be static. I'll be sending an updated patch set that 
removes break_ksm_pud_entry soonish (busy doing all kinds of other stuff).

-- 
Thanks,

David / dhildenb

