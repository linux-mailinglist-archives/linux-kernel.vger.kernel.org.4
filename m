Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECCBC6273AE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 01:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235430AbiKNAFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 19:05:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiKNAFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 19:05:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644222715
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 16:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668384291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=C9HUJqOZpsUXX/KUd6qmIpZLso8+y/lXIHxvBzFZZlE=;
        b=UOwN+IzUNVbPtWfOlp69OxalLygATw8DIr65V390IMHL8lWhNR/gHgaQ8SH8YEeQ01+dpi
        J0iJGGXuwOUYNjuCWHDkNan+0L0e3KBoWu0ATO/LizTcUcaheZaDyZFTmmJbacqr662Y2g
        ItpY0qEFsRhEXb4j6Fa6FAvsvbI8Syc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-640-FsFJeDDvN-6pmgNGbpoXCg-1; Sun, 13 Nov 2022 19:04:50 -0500
X-MC-Unique: FsFJeDDvN-6pmgNGbpoXCg-1
Received: by mail-qk1-f200.google.com with SMTP id bp10-20020a05620a458a00b006fa29f253dcso9873652qkb.11
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 16:04:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C9HUJqOZpsUXX/KUd6qmIpZLso8+y/lXIHxvBzFZZlE=;
        b=QY2QKw0HRAqaE/UFSndYQFNoQSYgEbIYQHoutYTmmOBdf8mdIMUS6znNCjNEJZPeOU
         lpTm/EdjRsGHTnSyXfSmP/jfXRvA/8OwHqDXCBXWS1Qbptjumjs0cKKaKP0P5sj5wrPA
         9DargH1eSx46Bw7u9JMh81vXfvkqfXzNTFVBMCPpsGbObz52ce+MdIX1OQusjJ+Qhs2z
         5TfPLtbw2poanVLNDm2Sf/aBdUTJGNxmGP/Kas5WaiIZwGX7W+2CuLoBd9iRw6YcVWV7
         BZ3u2Pg7B+YMd6r84u1ahTzZ5M7PioftqAx0ytnC6GYGTdbKnsbOtz71owgHx5FL8P3B
         /UAw==
X-Gm-Message-State: ANoB5pk97k6dW3y2PVT+wwyycJxt1p0xPWRMi7PWCZmo1GubnVkVPtsx
        H6DqkfVz5kOI40dxIuhishzVLrPnOKI2TJ0G0Xj3Tb9rlgCowhzWdEK9w5KbU6VEutpNLjyj8hn
        5wNzMl3PRUgyyxP2QxLpf81nC/Zpv0waWJNZ6i+CPTkd1iTChoLDqLp+9UZ35WWTjSlRqh8fX4A
        ==
X-Received: by 2002:a05:620a:c10:b0:6fa:104e:ac20 with SMTP id l16-20020a05620a0c1000b006fa104eac20mr9599612qki.708.1668384289675;
        Sun, 13 Nov 2022 16:04:49 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4r7Uvbz1ek7fXytkb7s7qylb3iixw+NX2gMug2qOpEU+tGK/GI4A5Eh8GsJwwjBaVDjI7GPw==
X-Received: by 2002:a05:620a:c10:b0:6fa:104e:ac20 with SMTP id l16-20020a05620a0c1000b006fa104eac20mr9599584qki.708.1668384289345;
        Sun, 13 Nov 2022 16:04:49 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id cb5-20020a05622a1f8500b0039cc0fbdb61sm4870380qtb.53.2022.11.13.16.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 16:04:48 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Ives van Hoorne <ives@codesandbox.io>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Alistair Popple <apopple@nvidia.com>
Subject: [PATCH v3 0/2] mm/migrate: Fix writable pte for read migration entry
Date:   Sun, 13 Nov 2022 19:04:45 -0500
Message-Id: <20221114000447.1681003-1-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3:
- Go back to use WARN_ON_ONCE because mmdebug.h not included in
  arch/x86/include/asm/pgtable.h
- Added r-b and t-b
- s/symbton/symbtom/ [Nadav]
- Updated commit message of patch 1, removing mprotect example

v2:
- Replace WARN_ON_ONCE with VM_WARN_ON_ONCE in patch 2 [Nadav]

This comes from a report from Ives on using uffd-wp on shmem.  More
information can be found in patch 1 commit message.

Patch 2 added some more sanity check when walking pgtables and when we
convert the ptes into other forms e.g. for migration and swap.  It will
make the error trigger even earlier than the user could notice, meanwhile
nail down the case if it's a wrong pgtable setup.

We probably need patch 1 for stable (5.19+).  Please have a look, thanks.

Peter Xu (2):
  mm/migrate: Fix read-only page got writable when recover pte
  mm/uffd: Sanity check write bit for uffd-wp protected ptes

 arch/x86/include/asm/pgtable.h | 18 +++++++++++++++++-
 mm/migrate.c                   |  8 +++++++-
 2 files changed, 24 insertions(+), 2 deletions(-)

-- 
2.37.3

