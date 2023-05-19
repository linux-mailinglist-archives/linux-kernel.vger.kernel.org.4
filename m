Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCC4709FBD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 21:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjESTK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 15:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbjESTKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 15:10:08 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5784F10D9
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 12:09:47 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id ada2fe7eead31-437daacde18so1557015137.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 12:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1684523386; x=1687115386;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zW+8AiWcujfmL+jEJZ+aHhi3EhheqVULu3C4IZ9BiOM=;
        b=C1fuRRmrWbyGZwMqQvna7XbmrtvL2KYjvRhmvGsD4O4JPuaECH2RhccW5P4CDrMaYr
         v18fbTaNPmBDQR8daJY6vhvbxXPSVdfF96ex6TMhXOa7HWd0JSA6KnnZzVQpdIS23psB
         xC95at14mHATimnKov/41qZD3FJdIAOCHQAOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684523386; x=1687115386;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zW+8AiWcujfmL+jEJZ+aHhi3EhheqVULu3C4IZ9BiOM=;
        b=OviSPC6oRJ/ycJH8+RemtyhpwXp//Qs+X1b/bmH/Iu7AbCRd/on4+6/BqJi2fszVmY
         KaMsjwlTDhNhVQdpYJeQSlGOjQIm7gupzxyVYzUQ5F+7WrYEXH9gs1IWwl8N3gOmMYAu
         okumvAmRjApxoC+x+TtHCLnLa8mF5YB5ufmnp22EMHHp88pTXrOrIeiA4ri8PjoSP3kn
         bztkKpepnsU9R1Oyc19L2BeATXR1srbIe7V8eJ66+iNpZeIw5x2M1i17RePsvHACBssL
         4uP8v9LAhxvcKGrar2B4YbU7S1wT1GmgEWISmszy40f/xc25MK+5AaQ0H9+F6Bv0JtTu
         py/Q==
X-Gm-Message-State: AC+VfDyO7U0zSNjqoYhrWJCUUTBb8/em1yZSQOX6hHIdixP/uoaKVyzk
        fPNGLGWMbZhKjOtmKJftUMDlvFiec+HulNdH3uw=
X-Google-Smtp-Source: ACHHUZ7pAT9I65XMxsEeLpcE0v+SquvwqAtExCL+uZMbkArAXICN2sJRDdFx5Z1+XQLZnjw0rxB7rw==
X-Received: by 2002:a05:6102:419:b0:42f:78d5:d987 with SMTP id d25-20020a056102041900b0042f78d5d987mr246785vsq.1.1684523386054;
        Fri, 19 May 2023 12:09:46 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id q20-20020ae9e414000000b0074e1ee30478sm1317611qkc.37.2023.05.19.12.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 12:09:45 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Kirill A Shutemov <kirill@shutemov.name>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH v2 0/4] Optimize mremap during mutual alignment within PMD
Date:   Fri, 19 May 2023 19:09:30 +0000
Message-ID: <20230519190934.339332-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here is v2 of the mremap start address optimization / fix for exec warning.

v1->v2:
1. Trigger the optimization for mremaps smaller than a PMD. I tested by tracing
that it works correctly.

2. Fix issue with bogus return value found by Linus if we broke out of the
above loop for the first PMD itself.

Description of patches:
These patches optimizes the start addresses in move_page_tables() and tests the
changes. It addresses a warning [1] that occurs due to a downward, overlapping
move on a mutually-aligned offset within a PMD during exec. By initiating the
copy process at the PMD level when such alignment is present, we can prevent
this warning and speed up the copying process at the same time. Linus Torvalds
suggested this idea.

Please check the individual patches for more details.

thanks,

 - Joel

[1] https://lore.kernel.org/all/ZB2GTBD%2FLWTrkOiO@dhcp22.suse.cz/

Joel Fernandes (Google) (4):
mm/mremap: Optimize the start addresses in move_page_tables()
selftests: mm: Fix failure case when new remap region was not found
selftests: mm: Add a test for mutually aligned moves > PMD size
selftests: mm: Add a test for remapping to area immediately after
existing mapping

mm/mremap.c                              | 56 +++++++++++++++++++
tools/testing/selftests/mm/mremap_test.c | 69 +++++++++++++++++++++---
2 files changed, 119 insertions(+), 6 deletions(-)

--
2.40.1.698.g37aff9b760-goog

