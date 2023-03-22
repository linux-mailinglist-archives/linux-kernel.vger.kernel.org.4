Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E3A6C43E0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 08:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjCVHNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 03:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjCVHNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 03:13:10 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83DB9EE0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 00:13:09 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id v1so9842443wrv.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 00:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679469188;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hOWk7YshIJ3bAzOKHevB0NjwThFmEQUviYz81y3yVro=;
        b=OfGg+3vRl0hYao7J6L4VmeF3SU8YV/Dx4kqQYkaTjG1leI45PZOqZi+gXJacEru9lo
         tP33YLN8dOKwUx7EdqvNIkDeLzIRUAkI+0qufByS0SyRE9vM4Txdr7aSmg/g1mnTuBaZ
         m/sXDdJbmzQskzKXpa2a5eKgpamXT7oGEaJxf08HB+3TXheSaIfG0ylFXtXHi/69UQxH
         tn8huyVWIqR3c0gj5PuF2E02N1XigRF97Cbmsx9jZDGxSENm7p+Ic2LXd/Hr5Eq9dbXY
         XkkvXSbNP+AQuxO3Q7tXtW18HVRSX2wR4owMiT49iXmq7Km2yDxtBiKpUotqYT679cxo
         eksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679469188;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hOWk7YshIJ3bAzOKHevB0NjwThFmEQUviYz81y3yVro=;
        b=5/JPvF0akd7odS4EwrUuiO82XG/JKhMFMssQvHZPYvWwf6CgBg+HoEG3HzrSczLr6p
         jMr6q9a6ua/qz24KktGTNTA/rPOsxnB7NWQd7Jn+NqQ1S88cXno12LhMOOuoxCxKus0I
         Ux2xd/Wx5BxsmtN6V3eIA5f1MlR6Yv6aoQGp/t1QQIM8G7CUa+fcVMy1E4ac1Jts12Vk
         pceXDmoTrSKHRn9jwJFiXIEfnmv0FBU3uc/2lk+4UkDQyFzsLYfUkzLRXLJCt0TzGIuB
         JJDSXnzkGt3/4RGE5RJ4g1F5R8Q0feVLM9hZR9ZAHBI1Gs5zT6bzIAwLzgOdgff69Azr
         oPgg==
X-Gm-Message-State: AAQBX9clECsT0yXekkUzQQfyM2o9u/NLwG1a7L4Qj1d/VKL2/chUEmAY
        1WKl2QGgsc8b0W8JMXIn75Y=
X-Google-Smtp-Source: AKy350YsBorfu/JIqWuUd6pWRpKb6V8wI0uyrdpYeWiFLQq+ewqJB5vOX+/m1p+bA7UvV2dAsDTgOg==
X-Received: by 2002:a5d:6408:0:b0:2da:a4df:d04c with SMTP id z8-20020a5d6408000000b002daa4dfd04cmr469529wru.19.1679469188048;
        Wed, 22 Mar 2023 00:13:08 -0700 (PDT)
Received: from lucifer.home (host86-146-209-214.range86-146.btcentralplus.com. [86.146.209.214])
        by smtp.googlemail.com with ESMTPSA id u4-20020a5d4344000000b002c5526234d2sm13290279wrr.8.2023.03.22.00.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 00:13:07 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        maple-tree@lists.infradead.org, Vernon Yang <vernon2gm@gmail.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v3 0/4] further cleanup of vma_merge()
Date:   Wed, 22 Mar 2023 07:13:00 +0000
Message-Id: <cover.1679468982.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following on from Vlastimil Babka's patch series "cleanup vma_merge() and
improve mergeability tests" which was in turn based on Liam's prior
cleanups, this patch series introduces changes discussed in review of
Vlastimil's series and goes further in attempting to make the logic as
clear as possible.

Nearly all of this should have absolutely no functional impact, however it
does add a singular VM_WARN_ON() case.

With many thanks to Vernon for helping kick start the discussion around
simplification - abstract use of vma did indeed turn out not to be
necessary - and to Liam for his excellent suggestions which greatly
simplified things.

v3:
- Combine vma_lookup() cases and reinsert accidentally excluded next = NULL
  assignment.
- Reword commit messages to more correctly reflect the current changes.
- Avoid multiple assignment to prev, take vma_start, vma_pgoff assignment
  out of the local variable declarations and revert to setting in if (prev)
  block.

v2:
- Put the patch series on a serious diet, cut comments down to avoid
  bloat.
- Added clever use of find_vma_intersection() and vma_lookup() as suggested
  by Liam which improved clarity + brevity significantly.
- Eliminated the use of a temporary vma local as suggested by Vernon, it
  does seem this was ultimately adding confusion and Liam's suggestions
  eliminated the need for this.
- Moved around initial variables to be more sensible and to initialise each
  variable in one place where possible.
https://lore.kernel.org/all/cover.1679431180.git.lstoakes@gmail.com

v1:
https://lore.kernel.org/all/cover.1679137163.git.lstoakes@gmail.com

Lorenzo Stoakes (4):
  mm/mmap/vma_merge: further improve prev/next VMA naming
  mm/mmap/vma_merge: fold curr, next assignment logic
  mm/mmap/vma_merge: explicitly assign res, vma, extend invariants
  mm/mmap/vma_merge: init cleanup, be explicit about the non-mergeable
    case

 mm/mmap.c | 144 ++++++++++++++++++++++++++++--------------------------
 1 file changed, 76 insertions(+), 68 deletions(-)

--
2.39.2
