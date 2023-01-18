Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6975671FCE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbjAROir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbjAROiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:38:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F5588775
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674051973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g06cdjA6Y1YmHGhcKb7SPdcn8qSEd7bjUCxNp9yfSiQ=;
        b=eqmuMXcHnkia/tgNj5U+9kLuByYqc32IENBTx2LkDgZft4+ZuzNgWzqF9zNPdYTobYwcLB
        nbqAK5Ob0kr1eWdhYkym5i9VwF07mOiB3lCF+TEJqmTERqbsIHo2Hs0MvNX7lgbgV+xKho
        Wk7pBNv3zRgUU8pqeX/LD8xSXCPGwSM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-623-fZPiOahAP9qbcf3hlqf3pg-1; Wed, 18 Jan 2023 09:26:11 -0500
X-MC-Unique: fZPiOahAP9qbcf3hlqf3pg-1
Received: by mail-wm1-f70.google.com with SMTP id z22-20020a7bc7d6000000b003daf671f7b2so560000wmk.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:26:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g06cdjA6Y1YmHGhcKb7SPdcn8qSEd7bjUCxNp9yfSiQ=;
        b=zXip3aIXNBIQWiMObz0/RrfSpkcvzVO0uFSzMlFRDPysDDFgsDRDGakasfAliByDb3
         qYLufzcVTtylhiDDpIRnYuQvCpllIur2ciYIim2dm9vmwrNIkCk96eY4kQWVCVi/ltgh
         eRtZCJ4+XkmdvSJwBOOgo3BpM+VijvugHPH9EnRtzs9qM8hDvENHBpUKXFSVwLpCA2uE
         cRPPpl+oOEoEtfHIntYQdNHX00ujb0bm5xlqVQLtBTOfUwj5ORiOhbpc0YUQvifY9iWf
         hD87qyG3M9kBLGsbOTYFlzBIt4gPXzuf7dQt+2bIPRGcxqtYdF5xESTImAI0BPiw2zho
         m5LQ==
X-Gm-Message-State: AFqh2koKHlKF9jgXbc7ibVhkQiLGwmey5SucDqz/sFm+U6pCiA8PPucJ
        dBjJAAXfaS1pspNDTsCrvjHx/iQ/iuWBueZ/9jMpihLBDIXhIgZYwX1x2I8j5Ha+bU1ELQVR9Av
        FaO+U+FNdeT4XRRMjnJJJygy5
X-Received: by 2002:a1c:f617:0:b0:3d2:191d:2420 with SMTP id w23-20020a1cf617000000b003d2191d2420mr6765367wmc.7.1674051970243;
        Wed, 18 Jan 2023 06:26:10 -0800 (PST)
X-Google-Smtp-Source: AMrXdXs8qt2aUQTMf4NiwYQSMfy0TkaQhHKLrhb7WoCi5t6BJc9U5DppBmazAWsNoJuY1A5pOdpI3A==
X-Received: by 2002:a1c:f617:0:b0:3d2:191d:2420 with SMTP id w23-20020a1cf617000000b003d2191d2420mr6765343wmc.7.1674051969945;
        Wed, 18 Jan 2023 06:26:09 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:800:1a88:f98a:d223:c454? (p200300cbc70508001a88f98ad223c454.dip0.t-ipconnect.de. [2003:cb:c705:800:1a88:f98a:d223:c454])
        by smtp.gmail.com with ESMTPSA id p4-20020a05600c1d8400b003da286f8332sm2273274wms.18.2023.01.18.06.26.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 06:26:09 -0800 (PST)
Message-ID: <3704dcf0-bd0a-8ab2-7f4f-045fc7c73171@redhat.com>
Date:   Wed, 18 Jan 2023 15:26:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     yang.yang29@zte.com.cn, akpm@linux-foundation.org
Cc:     imbrenda@linux.ibm.com, jiang.xuexin@zte.com.cn,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        ran.xiaokai@zte.com.cn, xu.xin.sc@gmail.com, xu.xin16@zte.com.cn
References: <202212300918477352037@zte.com.cn>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v5 6/6] selftest: add testing unsharing and counting ksm
 zero page
In-Reply-To: <202212300918477352037@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.12.22 02:18, yang.yang29@zte.com.cn wrote:
> From: xu xin <xu.xin16@zte.com.cn>
> 
> Add a function test_unmerge_zero_page() to test the functionality on
> unsharing and counting ksm-placed zero pages and counting of this patch
> series.
> 
> test_unmerge_zero_page() actually contains three subjct test objects:
> 	1) whether the count of ksm zero page can react correctly to cow
> 	   (copy on write);
> 	2) whether the count of ksm zero page can react correctly to unmerge;
> 	3) whether ksm zero pages are really unmerged.
> 
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Xuexin Jiang <jiang.xuexin@zte.com.cn>
> Reviewed-by: Xiaokai Ran <ran.xiaokai@zte.com.cn>
> Reviewed-by: Yang Yang <yang.yang29@zte.com.cn>
> 
> v4->v5:
> fix error of "} while (end_scans < start_scans + 20);" to
> "} while (end_scans < start_scans + 2);" in wait_two_full_scans().
> ---
>   tools/testing/selftests/vm/ksm_functional_tests.c | 103 +++++++++++++++++++++-
>   1 file changed, 99 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/vm/ksm_functional_tests.c b/tools/testing/selftests/vm/ksm_functional_tests.c
> index b11b7e5115dc..b792798a54c4 100644
> --- a/tools/testing/selftests/vm/ksm_functional_tests.c
> +++ b/tools/testing/selftests/vm/ksm_functional_tests.c
> @@ -27,6 +27,8 @@
> 
>   static int ksm_fd;
>   static int ksm_full_scans_fd;
> +static int ksm_zero_pages_fd;
> +static int ksm_use_zero_pages_fd;

If they are global, open them from main(), not from the test case.

>   static int pagemap_fd;
>   static size_t pagesize;
> 
> @@ -57,6 +59,22 @@ static bool range_maps_duplicates(char *addr, unsigned long size)
>   	return false;
>   }
> 
> +static bool check_ksm_zero_pages_count(unsigned long zero_size)
> +{
> +	unsigned long pages_expected = zero_size / (4 * KiB);
> +	char buf[20];
> +	ssize_t read_size;
> +	unsigned long ksm_zero_pages;
> +
> +	read_size = pread(ksm_zero_pages_fd, buf, sizeof(buf) - 1, 0);
> +	if (read_size < 0)
> +		return -errno;
> +	buf[read_size] = 0;
> +	ksm_zero_pages = strtol(buf, NULL, 10);
> +
> +	return ksm_zero_pages == pages_expected;

Better call this function "ksm_get_zero_pages", do it similarly to 
ksm_get_full_scans() and do the comparison in the kernel.

> +}
> +
>   static long ksm_get_full_scans(void)
>   {
>   	char buf[10];
> @@ -70,15 +88,12 @@ static long ksm_get_full_scans(void)
>   	return strtol(buf, NULL, 10);
>   }
> 
> -static int ksm_merge(void)
> +static int wait_two_full_scans(void)
>   {
>   	long start_scans, end_scans;
> 
> -	/* Wait for two full scans such that any possible merging happened. */
>   	start_scans = ksm_get_full_scans();
>   	if (start_scans < 0)
> -		return start_scans;
> -	if (write(ksm_fd, "1", 1) != 1)
>   		return -errno;

This change might not be required.

>   	do {
>   		end_scans = ksm_get_full_scans();
> @@ -89,6 +104,34 @@ static int ksm_merge(void)
>   	return 0;
>   }
> 
> +static inline int ksm_merge(void)
> +{
> +	/* Wait for two full scans such that any possible merging happened. */
> +	if (write(ksm_fd, "1", 1) != 1)
> +		return -errno;
> +	return wait_two_full_scans();
> +}
> +
> +static inline int make_cow(char *map, char val, unsigned long size)
> +{
> +
> +	memset(map, val, size);
> +	return wait_two_full_scans();

Why is that required?

> +}
> +
> +static int unmerge_zero_page(char *start, unsigned long size)
> +{
> +	int ret;
> +
> +	ret = madvise(start, size, MADV_UNMERGEABLE);
> +	if (ret) {
> +		ksft_test_result_fail("MADV_UNMERGEABLE failed\n");
> +		return ret;
> +	}
> +
> +	return wait_two_full_scans();

Dito, why is that required when unmerging?

> +}
> +
>   static char *mmap_and_merge_range(char val, unsigned long size)
>   {
>   	char *map;
> @@ -146,6 +189,56 @@ static void test_unmerge(void)
>   	munmap(map, size);
>   }
> 
> +static void test_unmerge_zero_pages(void)
> +{
> +	const unsigned int size = 2 * MiB;
> +	char *map;
> +
> +	ksft_print_msg("[RUN] %s\n", __func__);
> +
> +	/* Confirm the interfaces*/
> +	ksm_zero_pages_fd = open("/sys/kernel/mm/ksm/zero_pages_sharing", O_RDONLY);
> +	if (ksm_zero_pages_fd < 0) {
> +		ksft_test_result_skip("open(\"/sys/kernel/mm/ksm/zero_pages_sharing\") failed\n");
> +		return;
> +	}
> +	ksm_use_zero_pages_fd = open("/sys/kernel/mm/ksm/use_zero_pages", O_RDWR);
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
> +	map = mmap_and_merge_range(0x00, size);

Not checking for map == MAP_FAILED. Best to follow what
test_unmerge() does.


> +
> +	/* Case 1: make Writing on ksm zero pages (COW) */
> +	if (make_cow(map, 0xcf, size / 2)) {
> +		ksft_test_result_fail("COW failed\n");
> +		goto unmap;
> +	}
> +	ksft_test_result(check_ksm_zero_pages_count(size / 2),
> +						"zero page count react to cow\n");
> +

Let's keep COW tests to cow.c and focus on explicit unmerging here. Once 
we add support for KSM in cow.c , we can also test that e.g., long-term 
R/O pinning works as expected. I have that on my todo list but would be 
pleasantly surprised if someone else could tackle it :)

> +	/* Case 2: Call madvise(xxx, MADV_UNMERGEABLE)*/
> +	if (unmerge_zero_page(map + size / 2, size / 4)) {
> +		ksft_test_result_fail("unmerge_zero_page failed\n");
> +		goto unmap;
> +	}

Just avoid that helper and do it like test_unmerge(). Keep it simple.

> +	ksft_test_result(check_ksm_zero_pages_count(size / 4),
> +						"zero page count react to unmerge\n");
> +
> +	/*Check if ksm pages are really unmerged */

Missing space at the beginning. + the comment is superfluous.

> +	ksft_test_result(!range_maps_duplicates(map + size / 2, size / 4),
> +						"KSM zero pages were unmerged\n");
> +
> +unmap:
> +	munmap(map, size);
> +}
> +
>   static void test_unmerge_discarded(void)
>   {
>   	const unsigned int size = 2 * MiB;
> @@ -261,11 +354,13 @@ int main(int argc, char **argv)
>   	ksm_full_scans_fd = open("/sys/kernel/mm/ksm/full_scans", O_RDONLY);
>   	if (ksm_full_scans_fd < 0)
>   		ksft_exit_skip("open(\"/sys/kernel/mm/ksm/full_scans\") failed\n");
> +

Unrelated change.

>   	pagemap_fd = open("/proc/self/pagemap", O_RDONLY);
>   	if (pagemap_fd < 0)
>   		ksft_exit_skip("open(\"/proc/self/pagemap\") failed\n");
> 
>   	test_unmerge();
> +	test_unmerge_zero_pages();
>   	test_unmerge_discarded();
>   #ifdef __NR_userfaultfd
>   	test_unmerge_uffd_wp();

-- 
Thanks,

David / dhildenb

