Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E4D63562D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 10:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237654AbiKWJ1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 04:27:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237719AbiKWJ0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 04:26:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949716174
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 01:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669195465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rHc539OKBsHEDzjcGTORMVJC80CXsjOyX/986bqt6ZA=;
        b=Dd7+O14DDVVfqXnlHRkHU/P6SS4IvX6lyPKHrZYwy/sKHAuFHRCW9ixp4EYN3g2QdZVL/2
        un/tAVL39kSyrPbJPiC7c7V/8Y12rJc/dg/m5FH8jBjGtSw7tFRUcXN4AQ8bia72WTBNEt
        +9yrnHyY6c+LglMozpFvymU2fspZ8K0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-612-xyZqxOsKMfC2-jbU1q8MNg-1; Wed, 23 Nov 2022 04:24:24 -0500
X-MC-Unique: xyZqxOsKMfC2-jbU1q8MNg-1
Received: by mail-wm1-f70.google.com with SMTP id 206-20020a1c02d7000000b003d02dc20735so345wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 01:24:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rHc539OKBsHEDzjcGTORMVJC80CXsjOyX/986bqt6ZA=;
        b=MM2P5UqlMmXP/ALsUPkM3jNFAtScsd4x3UUe2aICNw6w8ew6j0yNJ//ZQZ/hYlqZl3
         V+uIarRp+mufSxjElBYRQo1SddTgan3V9imDxxaVgUrOOB/MB25gPtaSfOf9EURJFCzE
         0sj7jmQEMCGLiqCAZXU+j5Xyj8HSFy7xzn+DtcUZjbPCDwv3jtA9VKP6jN9VqvZRmv04
         24tyBOMOBpK+sp2YTUOdhQyCJ9AYxZcf4CmSaPVnazq0WCcFdigZM6J5PVYUZqQhrzXx
         fYAjWUc5anMgJDe1M1tBOxrydbbuqFWOxXeDzQS45n81PJpJX2dUWJ2/iPMyLfUptkrK
         0eMw==
X-Gm-Message-State: ANoB5pkXBgJD7YL5giazboComaGu1qt05FpsjPKiYF35LV45iSUSkOwN
        9/VYvCjAITfOrmT+AN1usy7jkB0la3/sEwwt2ND+7evroqT7bsKYX0WzOcWCmuAoAmFhW5da9wc
        DZNO7NDzJ/3Ix7e0NK++2hA5D
X-Received: by 2002:adf:ea43:0:b0:22e:433a:46ba with SMTP id j3-20020adfea43000000b0022e433a46bamr9757074wrn.575.1669195463349;
        Wed, 23 Nov 2022 01:24:23 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4u1uOdsNCjST/YVlVzbs+ClamC4UhIypgWTGe229T4v23rwD3x6qx9iq0SMSLmdCXNP/nKJw==
X-Received: by 2002:adf:ea43:0:b0:22e:433a:46ba with SMTP id j3-20020adfea43000000b0022e433a46bamr9757054wrn.575.1669195463040;
        Wed, 23 Nov 2022 01:24:23 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:9f00:a98d:4026:7c44:40fd? (p200300cbc7049f00a98d40267c4440fd.dip0.t-ipconnect.de. [2003:cb:c704:9f00:a98d:4026:7c44:40fd])
        by smtp.gmail.com with ESMTPSA id b8-20020a05600c4a8800b003b492753826sm1445713wmp.43.2022.11.23.01.24.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 01:24:22 -0800 (PST)
Message-ID: <8f743e24-4da5-7ca0-ac0f-49b6ad7e7a0a@redhat.com>
Date:   Wed, 23 Nov 2022 10:24:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] documentation/mm: Update pmd_present() in
 arch_pgtable_helpers.rst
Content-Language: en-US
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221123051319.1312582-1-anshuman.khandual@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221123051319.1312582-1-anshuman.khandual@arm.com>
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

On 23.11.22 06:13, Anshuman Khandual wrote:
> Although pmd_present() might seem to indicate a valid and mapped pmd entry,
> in reality it returns true when pmd_page() points to a valid page in memory
> , regardless whether the pmd entry is mapped or not. Andrea Arcangeli had
> earlier explained [1] the required semantics for pmd_present(). This just
> updates the documentation for pmd_present() as required.
> 
> [1] https://lore.kernel.org/lkml/20181017020930.GN30832@redhat.com/
> 
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: linux-mm@kvack.org
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This applies on v6.1-rc6
> 
> The latest trigger was from an earlier discussion here.
> 
> https://lore.kernel.org/all/53c0c955-7afe-905b-468a-cd7ac81238c5@arm.com/
> 
>   Documentation/mm/arch_pgtable_helpers.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/mm/arch_pgtable_helpers.rst b/Documentation/mm/arch_pgtable_helpers.rst
> index cbaee9e59241..fd2a19df884e 100644
> --- a/Documentation/mm/arch_pgtable_helpers.rst
> +++ b/Documentation/mm/arch_pgtable_helpers.rst
> @@ -94,7 +94,7 @@ PMD Page Table Helpers
>   +---------------------------+--------------------------------------------------+
>   | pmd_trans_huge            | Tests a Transparent Huge Page (THP) at PMD       |
>   +---------------------------+--------------------------------------------------+
> -| pmd_present               | Tests a valid mapped PMD                         |
> +| pmd_present               | Tests whether pmd_page() points to valid memory  |
>   +---------------------------+--------------------------------------------------+
>   | pmd_young                 | Tests a young PMD                                |
>   +---------------------------+--------------------------------------------------+

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

