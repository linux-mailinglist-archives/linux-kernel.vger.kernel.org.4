Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F5270DA10
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 12:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235175AbjEWKP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 06:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbjEWKPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 06:15:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE519FD
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 03:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684836906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ND/ou30ORoYCnfj9Kyfqf3MTIMtAMJBB+4GB/lYgQKU=;
        b=S6EdV6xJ9Gynvw57NVXWS/+Qxi4XtWFDvRqWP2Njwuz0kTM1FxpgJbkFcHcif84fw6wW6C
        cJXB9bsvxs9Luyr0xVsoWs5ZVq+c+aKXyeitnJPP2Ps4ki0fTNfV7+8SDdkSNFDwcvaZgD
        Q18WWsnWXeGh4cHiaME3BJwnDKpFLOI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-0P6vwIawM_aiRoMu41KIPg-1; Tue, 23 May 2023 06:15:05 -0400
X-MC-Unique: 0P6vwIawM_aiRoMu41KIPg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-30932d15a30so4210633f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 03:15:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684836904; x=1687428904;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ND/ou30ORoYCnfj9Kyfqf3MTIMtAMJBB+4GB/lYgQKU=;
        b=FUE6iE0aMePkHXWyzcsk/gR1vET/hpTXDW+uPox9YYb8NFZ2qIaUbeFHh+AKiXhwUY
         pX9ZH2vn/xd8MfR0ag03oXtR3hA7NBMNQkabJIH9L7Ynl8DtA9mSokCic7tJnKad6EKr
         AxgN4aVqdxf/nAtsoEl24rYBjALb09Bkj99JWvRB9FQPBzoa96m1m/S/F2GTyubIgCVW
         rTbFmlq61a5hMgFVLxjwwzv9fBHtDtoxu7ZcaL4TJXMaGjtrL2zn86mhfFMpgPbe616c
         NMPgygZvxyNg5PSNvSaxGaDwtIRgXG/ATTq2pka2/CJtqOp05vflPQQA6jQaK4cjAYfS
         rj6g==
X-Gm-Message-State: AC+VfDw5lW95xhCqHF1GHdLREkye961qA9w+CbGKSXtEHMDFMpBQkd5B
        WrPV3DnIPKobSAulL/UlUI2XU8X6/P4a5Y/eeTSUGmGl+bH2BhbBG5ib+MQOWW96tZuhdRtjbHE
        iYJQr2g5LNr5a9CeFLMV4dEjvqWHxUSev
X-Received: by 2002:a5d:6509:0:b0:309:3db8:51e6 with SMTP id x9-20020a5d6509000000b003093db851e6mr9859191wru.35.1684836904072;
        Tue, 23 May 2023 03:15:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5ycDNXEE29gfxeRpK0bpjNrv1eub8emKCQxHXG/xj0UVG7NHbcGQGOldzjjRYRaTNPSsgWeA==
X-Received: by 2002:a5d:6509:0:b0:309:3db8:51e6 with SMTP id x9-20020a5d6509000000b003093db851e6mr9859162wru.35.1684836903680;
        Tue, 23 May 2023 03:15:03 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74c:b400:5c8b:a0b2:f57e:e1cd? (p200300cbc74cb4005c8ba0b2f57ee1cd.dip0.t-ipconnect.de. [2003:cb:c74c:b400:5c8b:a0b2:f57e:e1cd])
        by smtp.gmail.com with ESMTPSA id s4-20020a5d4244000000b00307bc4e39e5sm10489729wrr.117.2023.05.23.03.15.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 03:15:03 -0700 (PDT)
Message-ID: <c496e8b8-e0d4-a2d6-5cce-e336904e15ae@redhat.com>
Date:   Tue, 23 May 2023 12:15:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Yang Yang <yang.yang29@zte.com.cn>, akpm@linux-foundation.org
Cc:     imbrenda@linux.ibm.com, jiang.xuexin@zte.com.cn,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        ran.xiaokai@zte.com.cn, xu.xin.sc@gmail.com, xu.xin16@zte.com.cn
References: <202305221842587200002@zte.com.cn>
 <20230522105433.4277-1-yang.yang29@zte.com.cn>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v8 6/6] selftest: add a testcase of ksm zero pages
In-Reply-To: <20230522105433.4277-1-yang.yang29@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.05.23 12:54, Yang Yang wrote:
> From: xu xin <xu.xin16@zte.com.cn>
> 
> Add a function test_unmerge_zero_page() to test the functionality on
> unsharing and counting ksm-placed zero pages and counting of this patch
> series.
> 
> test_unmerge_zero_page() actually contains three subjct test objects:
> (1) whether the count of ksm zero pages can update correctly after merging;
> (2) whether the count of ksm zero pages can update correctly after
>      unmerging;
> (3) whether ksm zero pages are really unmerged.
> 
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Xuexin Jiang <jiang.xuexin@zte.com.cn>
> Reviewed-by: Xiaokai Ran <ran.xiaokai@zte.com.cn>
> Reviewed-by: Yang Yang <yang.yang29@zte.com.cn>
> ---
>   tools/testing/selftests/mm/ksm_functional_tests.c | 75 +++++++++++++++++++++++
>   1 file changed, 75 insertions(+)
> 
> diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
> index 26853badae70..9b7fb94ed64f 100644
> --- a/tools/testing/selftests/mm/ksm_functional_tests.c
> +++ b/tools/testing/selftests/mm/ksm_functional_tests.c
> @@ -29,6 +29,8 @@
>   
>   static int ksm_fd;
>   static int ksm_full_scans_fd;
> +static int ksm_zero_pages_fd;
> +static int ksm_use_zero_pages_fd;
>   static int pagemap_fd;
>   static size_t pagesize;
>   
> @@ -59,6 +61,21 @@ static bool range_maps_duplicates(char *addr, unsigned long size)
>   	return false;
>   }
>   
> +static long get_ksm_zero_pages(void)
> +{
> +	char buf[20];
> +	ssize_t read_size;
> +	unsigned long ksm_zero_pages;
> +

I would add:

if (!ksm_zero_pages_fd)
	return 0;

> +	read_size = pread(ksm_zero_pages_fd, buf, sizeof(buf) - 1, 0);
> +	if (read_size < 0)
> +		return -errno;
> +	buf[read_size] = 0;
> +	ksm_zero_pages = strtol(buf, NULL, 10);
> +
> +	return ksm_zero_pages;
> +}
> +
>   static long ksm_get_full_scans(void)
>   {
>   	char buf[10];
> @@ -159,6 +176,61 @@ static void test_unmerge(void)
>   	munmap(map, size);
>   }
>   
> +static inline unsigned long expected_ksm_pages(unsigned long mergeable_size)
> +{
> +	return mergeable_size / pagesize;
> +}

I suggest to just inline that.

> +
> +static void test_unmerge_zero_pages(void)
> +{
> +	const unsigned int size = 2 * MiB;
> +	char *map;
> +	unsigned long pages_expected;
> +
> +	ksft_print_msg("[RUN] %s\n", __func__);
> +
> +	/* Confirm the interfaces*/

Missing space at the end of the comment. But I suggest to just drop this comment.

> +	if (ksm_zero_pages_fd < 0) {
> +		ksft_test_result_skip("open(\"/sys/kernel/mm/ksm/ksm_zero_pages\") failed\n");
> +		return;
> +	}
> +	if (ksm_use_zero_pages_fd < 0) {
> +		ksft_test_result_skip("open \"/sys/kernel/mm/ksm/use_zero_pages\" failed\n");
> +		return;
> +	}
> +	if (write(ksm_use_zero_pages_fd, "1", 1) != 1) {
> +		ksft_test_result_skip("write \"/sys/kernel/mm/ksm/use_zero_pages\" failed\n");
> +		return;
> +	}
> +
> +	/* Mmap zero pages*/

Missing space at the end of the comment

> +	map = mmap_and_merge_range(0x00, size, false);
> +	if (map == MAP_FAILED)
> +		return;
> +
> +	/* Check if ksm_zero_pages can be update correctly after merging */
> +	pages_expected = expected_ksm_pages(size);
> +	ksft_test_result(pages_expected == get_ksm_zero_pages(),
> +		"The count zero_page_sharing was updated after merging\n");
> +

Make sure that the number of tests (ksft_test_result*() invocations) is on any return
path as expected (e.g., 1).

if (pages_expected != get_ksm_zero_pages) {
	ksft_test_result_pass("'zero_page_sharing' updated after merging\n");
	goto unmap;
}

> +	/* try to unmerge half of the region */
> +	if (madvise(map, size / 2, MADV_UNMERGEABLE)) {
> +		ksft_test_result_fail("MADV_UNMERGEABLE failed\n");
> +		goto unmap;
> +	}
> +
> +	/* Check if ksm_zero_pages can be update correctly after unmerging */
> +	pages_expected = expected_ksm_pages(size / 2);

Just do

pages_expected /= 2;

> +	ksft_test_result(pages_expected == get_ksm_zero_pages(),
> +		"The count zero_page_sharing was updated after unmerging\n");
> +

if (pages_expected == get_ksm_zero_pages()) {
	ksft_test_result_pass("'zero_page_sharing' updated after unmerging\n");
	goto unmap;
}

> +	/* Check if ksm zero pages are really unmerged */
> +	ksft_test_result(!range_maps_duplicates(map, size / 2),
> +				"KSM zero pages were unmerged\n");
> +unmap:
> +	munmap(map, size);
> +}
> +
>   static void test_unmerge_discarded(void)
>   {
>   	const unsigned int size = 2 * MiB;
> @@ -379,8 +451,11 @@ int main(int argc, char **argv)
>   	pagemap_fd = open("/proc/self/pagemap", O_RDONLY);
>   	if (pagemap_fd < 0)
>   		ksft_exit_skip("open(\"/proc/self/pagemap\") failed\n");
> +	ksm_zero_pages_fd = open("/sys/kernel/mm/ksm/ksm_zero_pages", O_RDONLY);
> +	ksm_use_zero_pages_fd = open("/sys/kernel/mm/ksm/use_zero_pages", O_RDWR);
>   
>   	test_unmerge();
> +	test_unmerge_zero_pages();
>   	test_unmerge_discarded();
>   #ifdef __NR_userfaultfd
>   	test_unmerge_uffd_wp();

You should need something like this:

diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
index 26853badae70..00df05bfc3a3 100644
--- a/tools/testing/selftests/mm/ksm_functional_tests.c
+++ b/tools/testing/selftests/mm/ksm_functional_tests.c
@@ -358,7 +358,7 @@ static void test_prctl_unmerge(void)
  
  int main(int argc, char **argv)
  {
-	unsigned int tests = 5;
+	unsigned int tests = 6;
  	int err;
  
  #ifdef __NR_userfaultfd

-- 
Thanks,

David / dhildenb

