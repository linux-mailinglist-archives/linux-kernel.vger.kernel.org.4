Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA34744A3D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 17:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjGAPVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 11:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGAPVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 11:21:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1258F;
        Sat,  1 Jul 2023 08:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=mQ8pDj9XRWQTj8dc+gzlxW0IUFnmUUteg8hky6OW2+A=; b=Us34vC4HP67mjiMUiKh6VrSyH0
        ded25ncA3eoTn+frDF1dDRJIZ1kdH7u8edxIE4mpifyz19uxbsVRWljIYQkav4Lj5G43GQQMojcQC
        NSzzNLlaUb0LYvbXBf2UiikjqDUm5bzgPuBTfDaw1lgEJyPNkWnCu5fR9zRUnl1NIfwZMeB8J8f0p
        2pr8jD5GHT6NUZTz6duseyRpbLKPdWp5KnwK7rJsJ0blU8CAmciwSBU/0/cCBbPanzuOLiRnQdb5O
        j6O9OnjSlkUef32GVQq26ZEobj9Jb80gINtvV6wIdR2hbiPcU+b0m1ermvcxdSX3YMWJyr17PN1if
        LB47EHeg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qFcPb-006DjH-02;
        Sat, 01 Jul 2023 15:21:23 +0000
Message-ID: <68a9b3aa-d064-ed6a-2bcd-9423eb4f595c@infradead.org>
Date:   Sat, 1 Jul 2023 08:21:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] Documentation/mm: Add information about
 kmap_local_folio()
Content-Language: en-US
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Deming Wang <wangdeming@inspur.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Collingbourne <pcc@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>
References: <20230701142041.9992-1-fmdefrancesco@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230701142041.9992-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/1/23 07:19, Fabio M. De Francesco wrote:

> 
> v1->v2: I thought to Cc everybody but Andrew :-( Sorry, fixed.
> 	Andrew, can you please take this patch through your tree?
> 
>  Documentation/mm/highmem.rst | 27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/mm/highmem.rst b/Documentation/mm/highmem.rst
> index c964e0848702..bb9584f167a6 100644
> --- a/Documentation/mm/highmem.rst
> +++ b/Documentation/mm/highmem.rst
> @@ -51,11 +51,14 @@ Temporary Virtual Mappings
>  The kernel contains several ways of creating temporary mappings. The following
>  list shows them in order of preference of use.
>  
> -* kmap_local_page().  This function is used to require short term mappings.
> -  It can be invoked from any context (including interrupts) but the mappings
> -  can only be used in the context which acquired them.
> -
> -  This function should always be used, whereas kmap_atomic() and kmap() have
> +* kmap_local_page(), kmap_local_folio() - These functions are used to require

                                                                         acquire ?

> +  short term mappings. They can be invoked from any context (including
> +  interrupts) but the mappings can only be used in the context which acquired
> +  them. The only differences between them consist in the first taking a pointer
> +  to a struct page and the second taking a pointer to struct folio and the byte
> +  offset within the folio which identifies the page.

-- 
~Randy
