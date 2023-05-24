Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C2570F32B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 11:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjEXJkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 05:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjEXJjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 05:39:23 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA631B6
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 02:38:42 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id 98e67ed59e1d1-25533eb3e5dso27465a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 02:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684921121; x=1687513121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=znQ+oQUgIqQozQ/bIunmQ5Brszqw1hXk3gYEb70x7Ec=;
        b=kvRjfI8u1/VLUfkqd5Ct5F3vo6B5Fw1haAIedIcCdIgza/VJRX5AWh4Tyi2Olz+NxT
         9xumV48hwvRiUyeHlx6c5N3s048PejEPGWuOBQz7BbrJNpJUPlfA3D4afx6/5d1dqsNw
         ydRjE6svWzjEbkuFDsCXlCntICW2mJENeLTC7TFnb0Hwi4XZwf1AhOmgKXNOQ3NiR9ZC
         hWhBSoze6SX1RTvi8Bgb49IBilKo8ZECaSfR7VkBCNyMxc85fxgt89oMjmwZNIGbcvAF
         bzPv3hFenPFesnnhAB4TT6t5duvE4fbtMObulDh5m6ijh5o6dFUHpJCrLQ7rcyaGx4mQ
         0rbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684921121; x=1687513121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=znQ+oQUgIqQozQ/bIunmQ5Brszqw1hXk3gYEb70x7Ec=;
        b=ZhOWs6aokcYeJ8gj1Lv74WvYcbugyhMkLLBovfVOfNPqR2g+nCEJVn8B9L9Cj41U18
         +ffAedgOAoRzJeDvy5GLnY5IdgvvVBZfM6iFw/LVSGzYlQOEgANaVL1tQFAhim+5v8I2
         yaPPzw3wVnVw8OWDsbs38ct9YNBppsxNBS8nP7KIIRLR1JhiZvv63jMCbYrS5R6sDpJc
         OpmWzSmkGzCQHQ6Jq0NDMNfjICXhFbiLlq6Mzdra6WICBx6f3AZOp9/EE4SRzqaMH6bx
         rsFlaZrI1EF8SfNbHGdORKH918qYWuM388gvliLfrBr8WNjiKNry+nsd4voE8Btj5SJP
         Q0gw==
X-Gm-Message-State: AC+VfDyUkiWFMZ13N9pakYV5YX+TOnPmmRT+HbKYgvo4sTNoaxECQsPF
        ZyQWP4CUVDgUVe5GtkEVPWMOYaHHgD84OQ==
X-Google-Smtp-Source: ACHHUZ7cV+w13loNLlYYuEwTQ6PJaf/iRpYXJmpxUxnXHgID38lfYIfERsHTMD6/+I0XfoETDCxABw==
X-Received: by 2002:a17:90b:4c41:b0:255:b1d9:a206 with SMTP id np1-20020a17090b4c4100b00255b1d9a206mr3828466pjb.22.1684921121123;
        Wed, 24 May 2023 02:38:41 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id y10-20020a63e24a000000b0051b0e564963sm7441840pgj.49.2023.05.24.02.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 02:38:40 -0700 (PDT)
From:   xu xin <xu.xin.sc@gmail.com>
X-Google-Original-From: xu xin <xu.xin16@zte.com.cn>
To:     david@redhat.com
Cc:     akpm@linux-foundation.org, imbrenda@linux.ibm.com,
        jiang.xuexin@zte.com.cn, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ran.xiaokai@zte.com.cn, xu.xin.sc@gmail.com,
        xu.xin16@zte.com.cn, yang.yang29@zte.com.cn
Subject: Re: [PATCH v9 5/5] selftest: add a testcase of ksm zero pages
Date:   Wed, 24 May 2023 17:38:36 +0800
Message-Id: <20230524093836.21038-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <84c00f9d-0b83-e4a2-de6f-617cf23b6444@redhat.com>
References: <84c00f9d-0b83-e4a2-de6f-617cf23b6444@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> +	if (write(ksm_use_zero_pages_fd, "1", 1) != 1) {
>> +		ksft_test_result_skip("write \"/sys/kernel/mm/ksm/use_zero_pages\" failed\n");
>> +		return;
>> +	}
>
>I realize that this test will fail if there is any other process in the system that has KSM
>Enabled with a suitable page filled with zeroes ... maybe instead of checking the global
>KSM zeropages, check the per-mm ones instead? That should be better

Emmm, yes. It makes sense. I'll do it per-mm in next-version.

>You could do something like the following on top (I recall you had some kind of COW
>tests previously, this should be a simplified version of it):
>

Ok. Thank you.

>diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
>index ea060c683c80..160675a4e3d2 100644
>--- a/tools/testing/selftests/mm/ksm_functional_tests.c
>+++ b/tools/testing/selftests/mm/ksm_functional_tests.c
>@@ -182,6 +182,7 @@ static void test_unmerge(void)
>  static void test_unmerge_zero_pages(void)
>  {
>  	const unsigned int size = 2 * MiB;
>+	unsigned int offs;
>  	char *map;
>  	unsigned long pages_expected;
>  
>@@ -225,8 +226,18 @@ static void test_unmerge_zero_pages(void)
>  		goto unmap;
>  	}
>  
>+	/* Trigger unmerging of the other half by writing to the pages. */
>+	for (offs = size / 2; offs < size; offs += pagesize)
>+		*((unsigned int *)&map[offs]) = offs;
>+
>+	/* We should have no zeropages remaining. */
>+	if (get_ksm_zero_pages()) {
>+		ksft_test_result_fail("'ksm_zero_pages' updated after write fault\n");
>+		goto unmap;
>+	}
>+
>  	/* Check if ksm zero pages are really unmerged */
>-	ksft_test_result(!range_maps_duplicates(map, size / 2),
>+	ksft_test_result(!range_maps_duplicates(map, size),
>  				"KSM zero pages were unmerged\n");
>  unmap:
>  	munmap(map, size);
