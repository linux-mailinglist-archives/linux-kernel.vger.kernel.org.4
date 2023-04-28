Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383046F11B2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 08:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345368AbjD1GP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 02:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345367AbjD1GPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 02:15:23 -0400
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4764497;
        Thu, 27 Apr 2023 23:15:22 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-94f1a6e66c9so1758155166b.2;
        Thu, 27 Apr 2023 23:15:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682662520; x=1685254520;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nKg0o2X3zUwk7C1FxgskinEP8Y3FsAVaj1+iPRtrTLM=;
        b=DfpPhoYuY+1M0VOVESKi7HUBK86c31lLLpecVQQSXmt5KNhLhnVjOeUyoETm1qmrte
         fIvugI5XhS3pBkhenmdhDQnSaRjQS50w+7GAzpvqgJIqmMwGq5V3Ic/47NzqK+ONkVx+
         aV2SnVKfB2BXahW79MdTYWYuC58FxndAoMRhoSvcULDuohApe6CGXJQjAenZ5gP1S5Yy
         OAFPrID59GYPIQ720YFGW5ticDh/J0ceimSGiNWrdmI0X//vxYb8rb2NNwdVEnQPNeTz
         JU7Fdk3/240l8gmUNOcym4d3E1r441DFtVF/JkNeDXLirOjo5HmzvbjlQ4M1cMILtYwy
         XL6A==
X-Gm-Message-State: AC+VfDyKGx4Q57O1Pqz6//Pt9tlVKWtabYhWcVIPJU5HRpFN6i1nku98
        wKF2mas91/LgXi29IFmmL10=
X-Google-Smtp-Source: ACHHUZ6EMvsXSqUHkSdrzd/E0ByCGNrcKMWu7/ohpHqyvp5f/plsxP+8DlyngVbdVoo0IoCjp1iLbg==
X-Received: by 2002:a17:907:9347:b0:94e:ed5d:8777 with SMTP id bv7-20020a170907934700b0094eed5d8777mr4092020ejc.25.1682662520293;
        Thu, 27 Apr 2023 23:15:20 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id 26-20020a170906101a00b0095729352bf3sm9256078ejm.215.2023.04.27.23.15.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 23:15:19 -0700 (PDT)
Message-ID: <a21cbbb4-6fe0-c154-6064-517dad716aa0@kernel.org>
Date:   Fri, 28 Apr 2023 08:15:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH for v6.3 regression] mm/mremap: fix vm_pgoff in
 vma_merge() case 3
Content-Language: en-US
To:     Greg KH <greg@kroah.com>, Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>, lstoakes@gmail.com,
        regressions@lists.linux.dev, linux-mm@kvack.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabian Vogt <fvogt@suse.com>, stable@vger.kernel.org
References: <20230427140959.27655-1-vbabka@suse.cz>
 <2023042719-stratus-pavestone-505e@gregkh>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <2023042719-stratus-pavestone-505e@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27. 04. 23, 16:27, Greg KH wrote:
> On Thu, Apr 27, 2023 at 04:09:59PM +0200, Vlastimil Babka wrote:
>> After upgrading build guests to v6.3, rpm started segfaulting for
>> specific packages, which was bisected to commit 0503ea8f5ba7 ("mm/mmap:
>> remove __vma_adjust()"). rpm is doing many mremap() operations with file
>> mappings of its db. The problem is that in vma_merge() case 3 (we merge
>> with the next vma, expanding it downwards) vm_pgoff is not adjusted as
>> it should when vm_start changes. As a result the rpm process most likely
>> sees data from the wrong offset of the file. Fix the vm_pgoff
>> calculation.
>>
>> For case 8 this is a non-functional change as the resulting vm_pgoff is
>> the same.
>>
>> Reported-and-bisected-by: Jiri Slaby <jirislaby@kernel.org>
>> Reported-and-tested-by: Fabian Vogt <fvogt@suse.com>
>> Link: https://bugzilla.suse.com/show_bug.cgi?id=1210903
>> Fixes: 0503ea8f5ba7 ("mm/mmap: remove __vma_adjust()")
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>> Cc: <stable@vger.kernel.org>
>> ---
>> Hi, I'm sending this patch on top of v6.3 as I think it should be
>> applied and backported to 6.3-stable rather sooner than later.
>> This means there would be a small conflict when merging mm/mm-stable
>> later. Alternatively it could be added to mm/mm-stable and upcoming 6.4
>> pull request, but then the stable backport would need adjustment.
>> It's up to Linus and Andrew.
> 
> That's not how the stable tree works, sorry, it needs to be in Linus's
> tree _first_.

In upstream as:
commit 7e7757876f258d99266e7b3c559639289a2a45fe
Author: Vlastimil Babka <vbabka@suse.cz>
Date:   Thu Apr 27 16:09:59 2023 +0200

     mm/mremap: fix vm_pgoff in vma_merge() case 3

Please queue for 6.3.1.

thanks,
-- 
js
suse labs

