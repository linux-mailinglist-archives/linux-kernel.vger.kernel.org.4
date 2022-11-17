Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5162A62D8E1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234687AbiKQLGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239595AbiKQLGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:06:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9585B13E12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 03:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668683039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=49gONeuNGJL5O9v8lyWQciucbbb4tR6ylBmMzSawcfo=;
        b=Jp07v6X3ZcTONZTidnMuHMGESIbO3fwF7A1yvIbrhXoVcACdsaxe6uvmWoSSYlG3p3ieVb
        isjEpYFdxEJciHYzhRI00H+VZqoSbSMFGPeTdHOqCNfogOdnlfUY5N/Ne7YhEuItKowCq8
        vDj9KzEgK4NTuIGVOOOlp3kY7W8pYT4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-599-djUMgV-pPLWBVgouBD4FIw-1; Thu, 17 Nov 2022 06:03:53 -0500
X-MC-Unique: djUMgV-pPLWBVgouBD4FIw-1
Received: by mail-wr1-f70.google.com with SMTP id d23-20020adfa417000000b002364a31b7c9so556388wra.15
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 03:03:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=49gONeuNGJL5O9v8lyWQciucbbb4tR6ylBmMzSawcfo=;
        b=tXxCbtYwuCXyQ2cNh52wKZwwyjPfIxe4CZ3ff509wf4arGaleP9LUjvgf0R3P6Yacs
         Gs/7esYxXH/xK+yFJ9BmA5BqEhEN9UjbHpKgvjoNYT//mW7AP8m/HU5JqNIlFlVRUHZr
         NmjX+kRznd3h8fgv6QxJWQdBJVP3g0+QQ7nyeqc0Gtcr9Rd2Q75uZjplDKmQ0+Qq40ZL
         TIYLgNiCY9dQAiJt7sE8o4dsAL/U+V0ia4nKg+OsEgbHbY5YCsPsb7MmxsRKUb02JfCh
         pqRh6kFFGX1PmPlVVvkHgcY9Yu+59qcnpmIWMxPiV04s8fO9RcYGZkl/Yaw/4En7zG7r
         hZNQ==
X-Gm-Message-State: ANoB5pnx2y4dseul5PwZ9hrdbZskFkzzSASkTIy1UcwybK12XFxX06ld
        QZChjfAxVqyRZh1qP04nR35Uayj8NAfIBQJ0KZncOE3o9PyBuuM/LSXcWBbpEs3DnfcEafaD/UW
        xTKAhu7FVPio2nEELy486AeMf
X-Received: by 2002:a5d:4ac4:0:b0:22c:f296:1120 with SMTP id y4-20020a5d4ac4000000b0022cf2961120mr1077671wrs.369.1668683032796;
        Thu, 17 Nov 2022 03:03:52 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6pKgpZWq9qnIPGHXQLt6irt29PsCEpNu3cpSlNHTZ/BAPiXelpzL9B69HNimUlVLS5sxm4kw==
X-Received: by 2002:a5d:4ac4:0:b0:22c:f296:1120 with SMTP id y4-20020a5d4ac4000000b0022cf2961120mr1077657wrs.369.1668683032567;
        Thu, 17 Nov 2022 03:03:52 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:5200:39a9:b834:27c1:4ede? (p200300cbc707520039a9b83427c14ede.dip0.t-ipconnect.de. [2003:cb:c707:5200:39a9:b834:27c1:4ede])
        by smtp.gmail.com with ESMTPSA id bg28-20020a05600c3c9c00b003cfaae07f68sm5862544wmb.17.2022.11.17.03.03.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 03:03:52 -0800 (PST)
Message-ID: <98ae206d-c132-7529-1b4c-7f51079d7fa9@redhat.com>
Date:   Thu, 17 Nov 2022 12:03:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH linux-next] selftests/vm: add CATEGORY for
 ksm_functional_tests
Content-Language: en-US
To:     Joel Savitz <jsavitz@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        David Hildenbrand <dhildenb@redhat.com>,
        Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
References: <20221027170043.2363797-1-jsavitz@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221027170043.2363797-1-jsavitz@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.10.22 19:00, Joel Savitz wrote:
> commit e080ceaa69c1 ("selftests/vm: add KSM unmerge tests") in
> linux-next adds an entry to run_vmtests.sh. I recently submitted
> commit b5ba705c2608 ("selftests/vm: enable running select groups of tests")
> to linux-next which categorizes tests by functionality in order to
> allow more precise selection of which tests are to be run.
> 
> Since this newest test targets ksm and does not require more than one
> numa node, add 'CATEGORY="ksm"' to the invocation to group this test
> with the other ksm tests.
> 
> Signed-off-by: Joel Savitz <jsavitz@redhat.com>
> ---
>   tools/testing/selftests/vm/run_vmtests.sh | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/vm/run_vmtests.sh b/tools/testing/selftests/vm/run_vmtests.sh
> index af35dd3bc589..fff00bb77086 100755
> --- a/tools/testing/selftests/vm/run_vmtests.sh
> +++ b/tools/testing/selftests/vm/run_vmtests.sh
> @@ -252,7 +252,7 @@ CATEGORY="ksm_numa" run_test ./ksm_tests -N -m 1
>   # KSM test with 2 NUMA nodes and merge_across_nodes = 0
>   CATEGORY="ksm_numa" run_test ./ksm_tests -N -m 0
>   
> -run_test ./ksm_functional_tests
> +CATEGORY="ksm" run_test ./ksm_functional_tests
>   
>   # protection_keys tests
>   if [ -x ./protection_keys_32 ]

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

