Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9AA70F1E2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 11:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240556AbjEXJMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 05:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjEXJMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 05:12:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D0D189
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 02:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684919505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pcora42m3cheTOIBvw6GkIZ5gCuxPX3EpEruDFY9GWU=;
        b=jMHrwZAKnFFu9t/9XA2FV0phoRFe0jalPqO2bKEdW+AIjy0y3oS8reQIqWlik2m8AkTl0O
        ivA2W6RuUrc6x/eM8A1ZxLIVwXFaz6QYvVCjMjwMO132rIWVxZGIPXHfj5lQAT60P6H9FR
        H46lMcGkgMyeTqXdiOnfJnFfqWo90rk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-hVQaceg0MZSamyZzzZYVcg-1; Wed, 24 May 2023 05:11:44 -0400
X-MC-Unique: hVQaceg0MZSamyZzzZYVcg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3097ebd267dso219870f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 02:11:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684919503; x=1687511503;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pcora42m3cheTOIBvw6GkIZ5gCuxPX3EpEruDFY9GWU=;
        b=BtP3DJlLtFQb4EjTOK0RPmm5B1Mon1cx1mQQjHzKsdFPG2h98OoATLPP4fU7XXYyy0
         LBIlN1H6Du3WwCyBotRVgDrpRBxTHaZ1Au1sZEJmCbrLPWfx4OHvqAoWmvcLH/IGpBay
         2nxqqD/fOpQN0nl2L4wGNXN8Blpdn9c082NP6Sc2PqYjxQ1JtDZ/wOwmr2g2H5ojzwGl
         U9bTC6gwH4raF/GsfiQVtXtasuFNOmwD6o94RHHFlsRDTFEpvvkQI6LoKAuGbOUUFVKI
         7oHXUdv0J0+ApHxkNFYN9YODzR4SVXYp/bOHJ+o7+91luMcUv32V9x4k0nrJF3WfFLqF
         Zaxw==
X-Gm-Message-State: AC+VfDyNi6C97wlSZRex6FEU5/tadTRi0hMsYn6fNtg+Id/IyoB98Bhu
        lJGqBdNlalrvvwyc8ftu3MMvHBUq5lhnDm4t93H89AM2xx96MwR3Xc9NYlYuvMgIhNWkfEzH59P
        jr3HPT7nDjFxtJ0us9PUjWIu5
X-Received: by 2002:a5d:6083:0:b0:30a:ab38:3104 with SMTP id w3-20020a5d6083000000b0030aab383104mr1140209wrt.34.1684919503308;
        Wed, 24 May 2023 02:11:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5CQILuzjlrD3B4P8U9hT6uxcQuhQfkt1q2wkryb51NsaKxV8s6VcEUl52yg/LGWKdqkGTnLQ==
X-Received: by 2002:a5d:6083:0:b0:30a:ab38:3104 with SMTP id w3-20020a5d6083000000b0030aab383104mr1140179wrt.34.1684919502962;
        Wed, 24 May 2023 02:11:42 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70d:f700:24cd:855:1c60:1ff4? (p200300cbc70df70024cd08551c601ff4.dip0.t-ipconnect.de. [2003:cb:c70d:f700:24cd:855:1c60:1ff4])
        by smtp.gmail.com with ESMTPSA id l9-20020a05600012c900b003078354f774sm13644544wrx.36.2023.05.24.02.11.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 02:11:41 -0700 (PDT)
Message-ID: <84c00f9d-0b83-e4a2-de6f-617cf23b6444@redhat.com>
Date:   Wed, 24 May 2023 11:11:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Yang Yang <yang.yang29@zte.com.cn>, akpm@linux-foundation.org
Cc:     imbrenda@linux.ibm.com, jiang.xuexin@zte.com.cn,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        ran.xiaokai@zte.com.cn, xu.xin.sc@gmail.com, xu.xin16@zte.com.cn
References: <202305241351365661923@zte.com.cn>
 <20230524055906.20614-1-yang.yang29@zte.com.cn>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v9 5/5] selftest: add a testcase of ksm zero pages
In-Reply-To: <20230524055906.20614-1-yang.yang29@zte.com.cn>
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

[...]

> +static void test_unmerge_zero_pages(void)
> +{
> +	const unsigned int size = 2 * MiB;
> +	char *map;
> +	unsigned long pages_expected;
> +
> +	ksft_print_msg("[RUN] %s\n", __func__);
> +
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

I realize that this test will fail if there is any other process in the system that has KSM
enabled with a suitable page filled with zeroes ... maybe instead of checking the global
KSM zeropages, check the per-mm ones instead? That should be better.

> +
> +	/* Mmap zero pages */

Maybe better:

/* Let KSM deduplicate zero pages. */

> +	map = mmap_and_merge_range(0x00, size, false);
> +	if (map == MAP_FAILED)
> +		return;
> +
> +	/* Check if ksm_zero_pages can be update correctly after merging */

s/can be updated/is updated/

> +	pages_expected = size / pagesize;
> +	if (pages_expected != get_ksm_zero_pages()) {
> +		ksft_test_result_fail("'ksm_zero_pages' updated after merging\n");
> +		goto unmap;
> +	}
> +
> +	/* try to unmerge half of the region */
> +	if (madvise(map, size / 2, MADV_UNMERGEABLE)) {
> +		ksft_test_result_fail("MADV_UNMERGEABLE failed\n");
> +		goto unmap;
> +	}
> +
> +	/* Check if ksm_zero_pages can be update correctly after unmerging */
> +	pages_expected /= 2;
> +	if (pages_expected != get_ksm_zero_pages()) {
> +		ksft_test_result_fail("'ksm_zero_pages' updated after unmerging\n");
> +		goto unmap;
> +	}

You could do something like the following on top (I recall you had some kind of COW
tests previously, this should be a simplified version of it):

diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
index ea060c683c80..160675a4e3d2 100644
--- a/tools/testing/selftests/mm/ksm_functional_tests.c
+++ b/tools/testing/selftests/mm/ksm_functional_tests.c
@@ -182,6 +182,7 @@ static void test_unmerge(void)
  static void test_unmerge_zero_pages(void)
  {
  	const unsigned int size = 2 * MiB;
+	unsigned int offs;
  	char *map;
  	unsigned long pages_expected;
  
@@ -225,8 +226,18 @@ static void test_unmerge_zero_pages(void)
  		goto unmap;
  	}
  
+	/* Trigger unmerging of the other half by writing to the pages. */
+	for (offs = size / 2; offs < size; offs += pagesize)
+		*((unsigned int *)&map[offs]) = offs;
+
+	/* We should have no zeropages remaining. */
+	if (get_ksm_zero_pages()) {
+		ksft_test_result_fail("'ksm_zero_pages' updated after write fault\n");
+		goto unmap;
+	}
+
  	/* Check if ksm zero pages are really unmerged */
-	ksft_test_result(!range_maps_duplicates(map, size / 2),
+	ksft_test_result(!range_maps_duplicates(map, size),
  				"KSM zero pages were unmerged\n");
  unmap:
  	munmap(map, size);
-- 
2.40.1


You could also test manual discard (MADV_DONTNEED) and munmap(). Just a thought about which
tests to add eventually later.

-- 
Thanks,

David / dhildenb

