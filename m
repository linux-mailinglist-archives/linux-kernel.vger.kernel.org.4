Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 896E6706C27
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 17:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjEQPGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 11:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbjEQPGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 11:06:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704369EFF
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 08:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684335862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=EUoskz06alEGKkrRXumx8WXCB+JzMICYOzDauyzYlD4=;
        b=RPiD8LYeDL+xet+1CEY//Q6FqhnU8yLuiEmXAW45a2a6gm2rcorqhS1NU+zIPVrzO6+wWH
        QDZve8Dy9TOpYykd0KvL8Hk3ou57cWZm9vFDjnBwWRMaPVt/g9uS7LjO8RT/UsaU+Cnqie
        KzhQsAsCuwwda1uGO1grK3rJ0SwVfEg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-ZQLwPOraOW65iL2mdwEHbQ-1; Wed, 17 May 2023 11:04:13 -0400
X-MC-Unique: ZQLwPOraOW65iL2mdwEHbQ-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-61a3c7657aeso1682036d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 08:04:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684335851; x=1686927851;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EUoskz06alEGKkrRXumx8WXCB+JzMICYOzDauyzYlD4=;
        b=khPEw5hsFgfX1meU6KPJEiT5TrKL4M+5XxT3mLak7xO3B075cNODb9cJkQ/QIgjIEd
         YMw64B1Q0+XytdLN5WVEkr+GzgO3LeAmDRvba285Kv6m+a2zB3lS/P/G7W9allAhFfnW
         iyswwcY5b4gvjisS+x7uciCQVNZ6YnRpAxEprVkizvNcZluBvGDcU++iS0L1blb5ivt3
         lszysZUkTgAbKttmsDJUSn4LizD6mJh4nRIez/pifHht9i0MX5mFv/zL22KuAUW55Cfl
         MCumcRe8O/gylToQhSITalrYuKeEiqFROz6aAjt6aUmoU3nPzGjLAuQ46gvUQFYjtmmI
         rt6A==
X-Gm-Message-State: AC+VfDwyNf7HWXEhbxb2yfFpMeqgLjw8HVQTpoo1z5epIWLK8Vjc1Ptm
        XzJDmUJw4oGoGTESo44wni7mXqgGHmxVc2qadqAsGP89ZReVke4yN0I7OjuYIPq3QVLWOPgWmOZ
        YEwv1HQ5NCNbuP7gxI5mLG378M+81R/shxToooo98rQx8GFcli1JeQlMs+XagJllKIrIA+yi766
        Sts7/trQ==
X-Received: by 2002:a05:6214:b65:b0:61b:76dd:b643 with SMTP id ey5-20020a0562140b6500b0061b76ddb643mr5556196qvb.4.1684335850852;
        Wed, 17 May 2023 08:04:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7xgOY1O5oVXe1NC6GuvFKRBlHEK+Cti7Nt9EV78tAkmZgzxu+H/s1ciiZK62BAp7RGcvV/QQ==
X-Received: by 2002:a05:6214:b65:b0:61b:76dd:b643 with SMTP id ey5-20020a0562140b6500b0061b76ddb643mr5556114qvb.4.1684335850117;
        Wed, 17 May 2023 08:04:10 -0700 (PDT)
Received: from x1n.. (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca. [70.24.86.62])
        by smtp.gmail.com with ESMTPSA id u10-20020a05620a120a00b0074d4cf8f9fcsm661141qkj.107.2023.05.17.08.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 08:04:09 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@kernel.org>, peterx@redhat.com,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 0/2] mm/uffd: Fix vma merge/split
Date:   Wed, 17 May 2023 11:04:06 -0400
Message-Id: <20230517150408.3411044-1-peterx@redhat.com>
X-Mailer: git-send-email 2.39.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains two patches that fix vma merge/split for userfaultfd
on two separate issues.  The patchset is based on akpm/mm-hotfixes-unstable
with 2f628010799e reverted (where patch 1 should be used to replace it
which seems to be the plan we reached).

The major changes comparing to the patches I attached to the reply:

  - Fixed up patch 1 on vma_prev() side effect pointed out by Liam, further
    I simplified it to just bring back the two lines missing, so even shorter.

  - Add fixes tags for both patches, I decided to copy stable for both
    patch in this version, even though patch 2 is more or less tentative
    (as I don't see anything wrong besides vma didn't trigger a merge).

Patch 1 fixes a regression since 6.1+ due to something we overlooked when
converting to maple tree apis.  The plan is we use patch 1 to replace the
commit "2f628010799e (mm: userfaultfd: avoid passing an invalid range to
vma_merge())" in mm-hostfixes-unstable tree if possible, so as to bring
uffd vma operations back aligned with the rest code again.

Patch 2 fixes a long standing issue that vma can be left unmerged even if
we can for either uffd register or unregister.

Many thanks to Lorenzo on either noticing this issue from the assert
movement patch, looking at this problem, and also provided a reproducer on
the unmerged vma issue [1].

Please have a look, thanks.

[1] https://gist.github.com/lorenzo-stoakes/a11a10f5f479e7a977fc456331266e0e

Peter Xu (2):
  mm/uffd: Fix vma operation where start addr cuts part of vma
  mm/uffd: Allow vma to merge as much as possible

 fs/userfaultfd.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

-- 
2.39.1

