Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59A571FEC4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 12:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235246AbjFBKQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 06:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234464AbjFBKQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 06:16:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DE4C0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 03:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685700947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uPvme/9+RDZ+9w0fYgLw3wyLzBbpYxFjL26wqZOhscw=;
        b=WEQsl9T0eIBrIHOzjFeW1b+jJ+lO5FZLNv5netpkSbEB9orxaDpEKykUe5ejjtYptG6l0R
        81gumJOSqvSqDjdY0rW/Bp0hLtjT4oJAKjySIZOGIffvxecNNFG+YWMXuI+ZUk3BxVoc4U
        gGq+LCbJFnoz16HsWQMsMBwk49yR6qk=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-_0lMdxsoNp6Fof_qLLB1qQ-1; Fri, 02 Jun 2023 06:15:46 -0400
X-MC-Unique: _0lMdxsoNp6Fof_qLLB1qQ-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-4ecb00906d0so1452601e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 03:15:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685700945; x=1688292945;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uPvme/9+RDZ+9w0fYgLw3wyLzBbpYxFjL26wqZOhscw=;
        b=b3Pti7thCHrd6sleNpyZmu+rP35PaAdCxUxBEmFNNZLCfjm9cvVN7S2ov5Mn4tYvAP
         icgXEXlVZmUWGziuTxHm8dm3nywmJOByrTWzeSH4n0Uf2g61Xwez9c5c7hGeG9ftvBUr
         hOuYMcfx6m4UIoMQfwLs/chtrsusj7P+CHRI0a+FHUlcjOrH1s7/JSJCF/01xw+3SjmI
         UrVgxRZp0AvB/XGT00Zv12TgYUg0G6y4bjgb8TZNy36iM2q90TU/6LT4xhBym6in1Lc3
         tKS6nizyRzOcb1MmBfyF2SuCqjQwXgEilNVlU7XUNEUoIHReCq9K5Tv+OwDFe1TPllPn
         JgtQ==
X-Gm-Message-State: AC+VfDzYppGdS21H7wDqTd4qyjLJKz4Yy+RUXdHzydNiN1osMHUpIiNy
        kIptRqqNVWKmETfPeGjAc3r6Xam9B9UVYFmoxxRBfnGeKz+pwLh3u5qD9W21W2t+uPDKynKKFRL
        luBHiMrm/DR43v2d/pNoWUQqH
X-Received: by 2002:ac2:532d:0:b0:4ec:8a12:9e70 with SMTP id f13-20020ac2532d000000b004ec8a129e70mr1334473lfh.46.1685700944740;
        Fri, 02 Jun 2023 03:15:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7IemvF/IUVgg95b8zFHrHq1WWMIhPUj3/5NhLu7ZmNjrVXcZp17cOt/tYACTTH5SJF+gqVJg==
X-Received: by 2002:ac2:532d:0:b0:4ec:8a12:9e70 with SMTP id f13-20020ac2532d000000b004ec8a129e70mr1334465lfh.46.1685700944385;
        Fri, 02 Jun 2023 03:15:44 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2e:ae00:f2e3:50e0:73f7:451? (p200300d82f2eae00f2e350e073f70451.dip0.t-ipconnect.de. [2003:d8:2f2e:ae00:f2e3:50e0:73f7:451])
        by smtp.gmail.com with ESMTPSA id f18-20020a1cc912000000b003f4e3ed98ffsm1446681wmb.35.2023.06.02.03.15.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 03:15:43 -0700 (PDT)
Message-ID: <4faf7915-761c-c471-399f-3fcdfc208fd8@redhat.com>
Date:   Fri, 2 Jun 2023 12:15:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 07/12] selftests/mm: set -Wno-format-security to avoid
 uffd build warnings
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20230602013358.900637-1-jhubbard@nvidia.com>
 <20230602013358.900637-8-jhubbard@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230602013358.900637-8-jhubbard@nvidia.com>
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
> The uffd_test_start() is perhaps a little too elaborate about how it
> dispatches tests, leading to a clang warning that looks roughly like
> this:
> 
> "uffd-unit-tests.c:1198:20: warning: format string is not a string literal
> (potentially insecure) [-Wformat-security] ...note: treat the string as
> an argument to avoid this.
>      uffd_test_start(test_name);
> "
> 
> However, it doesn't seem worth it to rewrite the way uffd_test_start()
> works, given that these tests are already deeply unsafe to begin with.
> 
> Fix this by just disabling the compiler warning, but only for
> uffd-unit-tests.
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>   tools/testing/selftests/mm/Makefile | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index 23af4633f0f4..473bf1811552 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -170,6 +170,8 @@ $(OUTPUT)/ksm_tests: LDLIBS += -lnuma
>   
>   $(OUTPUT)/migration: LDLIBS += -lnuma
>   
> +$(OUTPUT)/uffd-unit-tests: CFLAGS += -Wno-format-security
> +
>   local_config.mk local_config.h: check_config.sh
>   	/bin/sh ./check_config.sh $(CC)
>   

Maybe the following will silence the warning by removing test_name
completely:


---
  tools/testing/selftests/mm/uffd-unit-tests.c | 5 +----
  1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index 269c86768a02..15c76ce972be 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -1149,7 +1149,6 @@ int main(int argc, char *argv[])
  	uffd_test_case_t *test;
  	mem_type_t *mem_type;
  	uffd_test_args_t args;
-	char test_name[128];
  	const char *errmsg;
  	int has_uffd, opt;
  	int i, j;
@@ -1192,10 +1191,8 @@ int main(int argc, char *argv[])
  			mem_type = &mem_types[j];
  			if (!(test->mem_targets & mem_type->mem_flag))
  				continue;
-			snprintf(test_name, sizeof(test_name),
-				 "%s on %s", test->name, mem_type->name);
  
-			uffd_test_start(test_name);
+			uffd_test_start("%s on %s", test->name, mem_type->name);
  			if (!uffd_feature_supported(test)) {
  				uffd_test_skip("feature missing");
  				continue;


Still gives me

Testing register-ioctls on anon... done
Testing register-ioctls on shmem... done
Testing register-ioctls on shmem-private... done
Testing register-ioctls on hugetlb... skipped [reason: memory allocation failed]
Testing register-ioctls on hugetlb-private... skipped [reason: memory allocation failed]
...

-- 
Thanks,

David / dhildenb

