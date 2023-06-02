Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B5B71FE87
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 12:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbjFBKG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 06:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233790AbjFBKGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 06:06:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E47132
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 03:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685700364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=daA/rik3JXYf4bt7f7gEBvROCt8U/eS0ktFKn02ggJY=;
        b=h26eIzcZGJL/O4CFpbgFGHIlmXlQ+kwlpWonjdinlOtpYEbSic8IQItpZh7i4MoNI/B8sC
        d2Y0AWKrnXSThTX9Oouh2xZFJbvpwYbZXEjcC/JqGjBKB6lkH2MCHmVo686POyxGR2nPKC
        G7Mj8D9msilifypXAtjCmC34ZvOuc0k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-VqZMAFENNE2FWDRIgrFZrQ-1; Fri, 02 Jun 2023 06:06:02 -0400
X-MC-Unique: VqZMAFENNE2FWDRIgrFZrQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f603fed174so10337475e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 03:06:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685700361; x=1688292361;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=daA/rik3JXYf4bt7f7gEBvROCt8U/eS0ktFKn02ggJY=;
        b=XuYM5jlV1eyDSW1yByAV4rn8z0Y/C1hYAc7Tk7IYE6YuGlqfTAIhgqclmDxIc73wYq
         X/IqGuxMw3veWvHJo3r1WVMIHgjeMmVmmhZRK8KGw/VkotiETqDh65YW3DyuOD9i0ryo
         30NnAwr4xoeyUbtqcLRI5I0XdWAD17c+cHG0IzdSkVO4V4oxGfdw8GmIlyKy8NfQ2x9s
         TBagR4ZA9g+B3VT1M6rDpcC6yIVMoXaRQqCKY8iN4ciTfEfyP5khP0F4cdIv8qLBw6ZJ
         c6SG5saTUSkGM/i2qQK2zpzKFiQSHLb2EyUemTHuvDL7rxonvOsxWISpgXLlB+2DeGJj
         EnZw==
X-Gm-Message-State: AC+VfDyOXqKPYRLutE7FCIJBhKQOc9LZtAyFQFMh6jZlkllrmfxA2VOR
        Y45ncjafMfnYlyVtj7rGQenyTkksf7n6yd0ns+ZmQKY9JRxWGkMul46NnN2g6cphNUWTZJ9/Vtx
        SqxbTigi5zz9thSdhQ8iaDuhZ
X-Received: by 2002:a1c:7315:0:b0:3f7:26f8:4cd0 with SMTP id d21-20020a1c7315000000b003f726f84cd0mr1065975wmb.16.1685700361687;
        Fri, 02 Jun 2023 03:06:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ577yAr9bkc0osVLUfwjdkNel+f/L2gcmLTc9BArT7msfA6svOFe850n8SpsYUblCdzJpPP/A==
X-Received: by 2002:a1c:7315:0:b0:3f7:26f8:4cd0 with SMTP id d21-20020a1c7315000000b003f726f84cd0mr1065959wmb.16.1685700361256;
        Fri, 02 Jun 2023 03:06:01 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2e:ae00:f2e3:50e0:73f7:451? (p200300d82f2eae00f2e350e073f70451.dip0.t-ipconnect.de. [2003:d8:2f2e:ae00:f2e3:50e0:73f7:451])
        by smtp.gmail.com with ESMTPSA id m24-20020a7bca58000000b003f4dde07956sm5027605wml.42.2023.06.02.03.06.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 03:06:00 -0700 (PDT)
Message-ID: <ead7d0db-6104-1d62-b3d0-f9ebb767af4d@redhat.com>
Date:   Fri, 2 Jun 2023 12:05:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 05/12] selftests/mm: fix invocation of tests that are run
 via shell scripts
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20230602013358.900637-1-jhubbard@nvidia.com>
 <20230602013358.900637-6-jhubbard@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230602013358.900637-6-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.06.23 03:33, John Hubbard wrote:
> We cannot depend upon git to reliably retain the executable bit on shell
> scripts, or so I was told several years ago while working on this same
> run_vmtests.sh script. And sure enough, things such as test_hmm.sh are
> lately failing to run, due to lacking execute permissions.
> 
> A nice clean way to fix this would have been to use TEST_PROGS instead
> of TEST_FILES for the .sh scripts here. That tells the selftest
> framework to run these (and emit a warning if the files are not
> executable, but still run them anyway).
> 
> Unfortunately, run_vmtests.sh has its own run_test() routine, which does
> *not* do the right thing for shell scripts.
> 
> Fix this by explicitly adding "bash" to each of the shell script
> invocations. Leave fixing the overall approach to another day.
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>   tools/testing/selftests/mm/run_vmtests.sh | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
> index 4893eb60d96d..8f81432e4bac 100644
> --- a/tools/testing/selftests/mm/run_vmtests.sh
> +++ b/tools/testing/selftests/mm/run_vmtests.sh
> @@ -242,18 +242,18 @@ if [ $VADDR64 -ne 0 ]; then
>   	if [ "$ARCH" == "$ARCH_ARM64" ]; then
>   		echo 6 > /proc/sys/vm/nr_hugepages
>   	fi
> -	CATEGORY="hugevm" run_test ./va_high_addr_switch.sh
> +	CATEGORY="hugevm" run_test bash ./va_high_addr_switch.sh
>   	if [ "$ARCH" == "$ARCH_ARM64" ]; then
>   		echo $prev_nr_hugepages > /proc/sys/vm/nr_hugepages
>   	fi
>   fi # VADDR64
>   
>   # vmalloc stability smoke test
> -CATEGORY="vmalloc" run_test ./test_vmalloc.sh smoke
> +CATEGORY="vmalloc" run_test bash ./test_vmalloc.sh smoke
>   
>   CATEGORY="mremap" run_test ./mremap_dontunmap
>   
> -CATEGORY="hmm" run_test ./test_hmm.sh smoke
> +CATEGORY="hmm" run_test bash ./test_hmm.sh smoke
>   
>   # MADV_POPULATE_READ and MADV_POPULATE_WRITE tests
>   CATEGORY="madv_populate" run_test ./madv_populate

Sounds hacky, but if it gets the job done

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

