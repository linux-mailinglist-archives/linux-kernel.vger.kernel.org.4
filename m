Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A9D702C11
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 13:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241727AbjEOL5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 07:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241653AbjEOL4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 07:56:13 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E883AAA
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 04:52:04 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f42b984405so46679335e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 04:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684151523; x=1686743523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8VolQsWbhgi3AuZQWFw2bPvkYyOZIlyKr+06pXTfSDc=;
        b=EImsKCtyScRzWBGe7SjLeGJq2OzK2cQXydu6Ow6g4fLmqHU4IcOVgacSiUgN8hLgGc
         y06pzEKiczqmgDXwEmI2jtATvHupAvwioSjkpnUqlEYFVNG8Vu9bBAT7ygeYvUWS7tEg
         K4N1VYvmFeOeSUa4aNcsRyyZRx8XzwCakFMelv9dSAc4Yskchu8kEG8GAatX3PC6SOU8
         3OAIlHKDsTqmRQ7hJvujPagK8Cqni4rDbuOosUAV4FVQYTpmDV+bVnTuqAIX03PzD95q
         ATk6NeGw5sqCkke6R9h1LsJWJjvDv5YdjRV736JIqEc9Zgr2SlrNBrUaz8aoq0vkF6TQ
         /dMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684151523; x=1686743523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8VolQsWbhgi3AuZQWFw2bPvkYyOZIlyKr+06pXTfSDc=;
        b=MwwN+E/Ld7rJ9m4bhB7NqoSDa4XddtHQFckBCEfCyRxQD0BYA095EEHpHEMiCBT16H
         BvlaKoOxIy9RTOFTawhS5yN9ol4Ewpt6H+qgX3z0rAuuJgnchJAL1pv8FsnEuCQiG4Jq
         4c4JXtSdpgqjpbxTfi4NDOcVcjUedGa2u9KVaJUaI8bsHqeMDXXizOKrEd9IJ5zcdCS4
         OU0wNCqKPt1mo/kEQwX9IDehCjSJOVdDDLbBlTKzqCU2Eq0DWM4CXZQRYTwEyrPymDhe
         HOcKINwqhNmsb5komnlXGLPsHqpX30PYxQzl/oEBEKEHGwxS1k+Nty1uOaTaTja5UV++
         6LEw==
X-Gm-Message-State: AC+VfDy81X2G7Duj89uFg3oPy00aX4XCbi/+gEKnXc7ov2CBjFyUQSnG
        JrAvfm8Dnh2vFbulhwwjyqC5aQ==
X-Google-Smtp-Source: ACHHUZ6NHA8DBhZNLqnQ6iNh4CmKPQ4yfwPUUtcxIrXGVFirfmjdSt25P8OUL7/r/fFLCJ/H1AGuVA==
X-Received: by 2002:a05:600c:257:b0:3f4:239c:f19 with SMTP id 23-20020a05600c025700b003f4239c0f19mr18615137wmj.36.1684151523128;
        Mon, 15 May 2023 04:52:03 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id u24-20020a05600c00d800b003f4fffccd73sm6437832wmm.9.2023.05.15.04.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 04:52:01 -0700 (PDT)
Date:   Mon, 15 May 2023 14:51:54 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Ricardo =?iso-8859-1?Q?Ca=F1uelo?= 
        <ricardo.canuelo@collabora.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, lkft-triage@lists.linaro.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: Re: selftests: mincore: mincore_selftest fails only on qemu-armv7
Message-ID: <a9e9a1a7-346a-475e-961c-ec8568613b45@kili.mountain>
References: <CA+G9fYuoB8Ug8PcTU-YGmemL7_eeEksXFihvxWF6OikD7sK7pA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYuoB8Ug8PcTU-YGmemL7_eeEksXFihvxWF6OikD7sK7pA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 03:29:02PM +0530, Naresh Kamboju wrote:
> The selftests: mincore: mincore_selftest fails only on qemu-armv7 running
> Linux next, mainline and stable branches.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> # selftests: mincore: mincore_selftest
> # TAP version 13
> # 1..5
> # # Starting 5 tests from 1 test cases.
> # #  RUN           global.basic_interface ...
> # #            OK  global.basic_interface
> # ok 1 global.basic_interface
> # #  RUN           global.check_anonymous_locked_pages ...
> # #            OK  global.check_anonymous_locked_pages
> # ok 2 global.check_anonymous_locked_pages
> # #  RUN           global.check_huge_pages ...
> # # mincore_selftest.c:156:check_huge_pages:mmap error: Invalid argument
> # # mincore_selftest.c:159:check_huge_pages:Expected 0 (0) == retval (-1)

The test is wrong.  It doesn't accept -EINVAL as a valid failure.

tools/testing/selftests/mincore/mincore_selftest.c
   139  TEST(check_huge_pages)
   140  {
   141          unsigned char vec[1];
   142          char *addr;
   143          int retval;
   144          int page_size;
   145  
   146          page_size = sysconf(_SC_PAGESIZE);
   147  
   148          errno = 0;
   149          addr = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
   150                  MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB,
   151                  -1, 0);
   152          if (addr == MAP_FAILED) {
   153                  if (errno == ENOMEM)

On Armv7 is a 32bit machine so HUGETLB isn't enabled and the errno can
be -EINVAL.  It's has returned this for 10 years.

   154                          SKIP(return, "No huge pages available.");
   155                  else
   156                          TH_LOG("mmap error: %s", strerror(errno));
   157          }
   158          retval = mincore(addr, page_size, vec);
   159          ASSERT_EQ(0, retval);

mm/mmap.c
  1405                  }
  1406          } else if (flags & MAP_HUGETLB) {
  1407                  struct hstate *hs;
  1408  
  1409                  hs = hstate_sizelog((flags >> MAP_HUGE_SHIFT) & MAP_HUGE_MASK);
  1410                  if (!hs)
  1411                          return -EINVAL;
                                ^^^^^^^^^^^^^^^
hstate_sizelog() return NULL when CONFIG_HUGETLB_PAGE is disabled.

  1412  
  1413                  len = ALIGN(len, huge_page_size(hs));

regards,
dan carpenter

