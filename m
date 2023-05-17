Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D284870718B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 21:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjEQTKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 15:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjEQTKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 15:10:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8494F93C8
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 12:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684350562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=TNueZVKvKbqYKsThUlmAqqW8H5EGDZrswTYYHFq1+MY=;
        b=PBwtHQ+RUbVbotMmoA/uxZiCoyY7/GVl4/G1cacEHa1JM5/VFtKnCNm4R8bB/JftqIf7hk
        /x65J0DELByOPaI1nDmwRWxvN0TaD1WJeYhMDJdy2+bBBOvk5647XdRpmYa/8/oDbUkg1S
        4NdOJJ/VCwaoT9dG2RWQyNdo5VC4B4k=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-Mni7MywSPdabraTPDwuf2A-1; Wed, 17 May 2023 15:09:21 -0400
X-MC-Unique: Mni7MywSPdabraTPDwuf2A-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-3f38280ec63so2227041cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 12:09:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684350559; x=1686942559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TNueZVKvKbqYKsThUlmAqqW8H5EGDZrswTYYHFq1+MY=;
        b=DWCrBFR42E5PfOMcw+7tgEjYSj9sEbtldbd2tCd649rKEkaCZKBRutyBGdzWceNTUs
         QLg9jZGli2V0UGLWOwotrvLoBoS+WUhHNCBheIFkZ5NahzuU8CL8V78MDOPjy5y2yyfS
         cRgJNDMJklOdxWkBXPjj++G7roeo+ho3f2czRgpTY44ybsCXtJjY+muBuwkGP9W5IX9r
         fJynyt1TLvwmKEajMaRGYxDMKg9evpvf8HSXH9SvLzUVET9GTRkJaufk2LxZYiPVJz7d
         MCIozSXGJVFwLdKcnJdBxVkUIngZejEoGmmM4IVA5X45qCxPZHc6wAc+17jlzLjuD+vL
         5NYQ==
X-Gm-Message-State: AC+VfDwlmmnk5PcQO7EJ0/n0S+JqhJr1B2WpYFWOguRi+yrt0D0ddiDW
        HFtHu9/MNh5xoW57wHuzF8LGLdA8cLueeFeFklTY7zRSr+kcPmKrdWxVBsmtQAaPNPDJalH06uo
        hIe5eJZkOpGMjGln2GhhPf1XIMOIknZFswc7Ta52D+nh35AawcjbKMgCLUb3POed9/+fEVczHbC
        8qVqdNMA==
X-Received: by 2002:a05:622a:1a9f:b0:3f5:1def:67fd with SMTP id s31-20020a05622a1a9f00b003f51def67fdmr6869904qtc.2.1684350559360;
        Wed, 17 May 2023 12:09:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5m7p0QqMHfQEXYY68UUBJuy0d24Wlx3YBE8G36XlPM1mx1FsLjvPznRvMD7EUjylbl1XAp/g==
X-Received: by 2002:a05:622a:1a9f:b0:3f5:1def:67fd with SMTP id s31-20020a05622a1a9f00b003f51def67fdmr6869843qtc.2.1684350558865;
        Wed, 17 May 2023 12:09:18 -0700 (PDT)
Received: from x1n.. (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca. [70.24.86.62])
        by smtp.gmail.com with ESMTPSA id k21-20020a05620a143500b0075954005b46sm833464qkj.48.2023.05.17.12.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 12:09:18 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Mike Rapoport <rppt@kernel.org>, peterx@redhat.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v2 0/2] mm/uffd: Fix vma merge/split
Date:   Wed, 17 May 2023 15:09:14 -0400
Message-Id: <20230517190916.3429499-1-peterx@redhat.com>
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

v2:
- Added r-bs for Lorenzo and Liam
- Reworded patch 1's commit message [Lorenzo]

This series contains two patches that fix vma merge/split for userfaultfd
on two separate issues.  The patchset is based on akpm/mm-hotfixes-unstable
with 2f628010799e reverted (where patch 1 should be used to replace it
which seems to be the plan we reached).

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

