Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD8B6612D14
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 22:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiJ3VnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 17:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJ3Vmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 17:42:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA8FAE60
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 14:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667166116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=MgVI/NJmz9bHNl5fyvWvLupv11bDXKEB94mkCaXf69A=;
        b=ahJzsEog7yG3JqQHWEcPvBnKSlwZabAt4XNXbpuobGdOqekye6z1X2TY5u/abNo5CpNLv0
        oQD9qSzQgMzz/YiDEPjjD/t1GbGkwIikwkwrXVdUbZ0XrTq5g/0vGZ5oYHPnQmfZaC0cXo
        ELAOBd9gn0j2G8SaExPp7qRlmL0BkAY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-537-GiYimE3eN4WxxLtfw3EwlQ-1; Sun, 30 Oct 2022 17:41:55 -0400
X-MC-Unique: GiYimE3eN4WxxLtfw3EwlQ-1
Received: by mail-qt1-f198.google.com with SMTP id fy10-20020a05622a5a0a00b0039cd5097697so6487692qtb.7
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 14:41:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MgVI/NJmz9bHNl5fyvWvLupv11bDXKEB94mkCaXf69A=;
        b=lALftrumrwFGGyWn1+T4gHrwzD4JdG4Z+qRThEelI2gF5IiZI5iEq5v4btSukCyQH7
         DoBEgz57m1lwtwQcoWHIB6Q/C08lp1VUMqRjzfcop+50jfnJS4HmoLiKHIBkvTrxIlyx
         tYgAjBoUTl06yM5jUNNwXPyFr3bdA9xVHxFjtfgGlfmdsPtsXROBaHhz8bNP0INeod42
         oXdHjfWa/Mb2Ia6hOycChVAj5g6ubmJUDcWSZt5GAABE3iJuivl5XqN7lcOc9KkAgcTH
         aOW41wclbuZPtXGk8/7+xNfVFBs15BeN2ix+BTmg9dsAK9yt6oli9XUzaiQHskVGAIg4
         ggTQ==
X-Gm-Message-State: ACrzQf3hb7gOPFSP0va4eQhKa8Px35Xrgu/VRrs+J9ChTxUrlixNS718
        kp4pul39AiNlDTVK+6BjN4ns3t0VoiuYAzhOoVaPDvAUKQ/G9vXxnl9LNBOkPycCCW80bxg3cTS
        FEx+V5e7hEu55CYexHWMA7rXgJYKw2wgh6U6BGTswJFaD6ERreA+WVEqdfWqRkcZy0qM92FRdqg
        ==
X-Received: by 2002:a05:622a:14d:b0:39c:c531:2506 with SMTP id v13-20020a05622a014d00b0039cc5312506mr8311642qtw.13.1667166114216;
        Sun, 30 Oct 2022 14:41:54 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4HxJvZ0hL772t1OEj0fcNR5zBHfX/VDSOY6kS6G8fDh08MXBBQBY9OgRo+06XQms03A0QKaQ==
X-Received: by 2002:a05:622a:14d:b0:39c:c531:2506 with SMTP id v13-20020a05622a014d00b0039cc5312506mr8311623qtw.13.1667166113933;
        Sun, 30 Oct 2022 14:41:53 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id az42-20020a05620a172a00b006bb87c4833asm3506450qkb.109.2022.10.30.14.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 14:41:53 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Huang Ying <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        Andrea Arcangeli <aarcange@redhat.com>, peterx@redhat.com
Subject: [PATCH 0/2] mm: Use pte marker for swapin errors
Date:   Sun, 30 Oct 2022 17:41:49 -0400
Message-Id: <20221030214151.402274-1-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rfc->v1:
- Rename SWAP_ERROR -> SWAPIN_ERROR [David, Miaohe]
- Added r-bs for Ying and Miaohe

Hi,

This series uses the pte marker to replace the swapin error swap entry,
then we save one more swap entry slot for swap devices.  A new pte marker
bit is defined.

One thing worth mentioning: we need the pte marker to be always built to
make sure it works like before, so I made an attempt in patch 1 to drop
CONFIG_PTE_MARKER and always compile pte marker in.  Since pte markers are
enabled in many distributions by default already, meanwhile the codeset is
really small I assume it's fine.  But still I'm tagging with RFC for this
initial version.

Smoke tested on anonymous mem on a fake swap failure.  Please have a look,
thanks.

Peter Xu (2):
  mm: Always compile in pte markers
  mm: Use pte markers for swap errors

 include/linux/swap.h    | 16 ++++----------
 include/linux/swapops.h | 49 +++++++++--------------------------------
 mm/Kconfig              |  7 ------
 mm/memory.c             | 13 ++++++-----
 mm/shmem.c              |  2 +-
 mm/swapfile.c           |  2 +-
 6 files changed, 23 insertions(+), 66 deletions(-)

-- 
2.37.3

