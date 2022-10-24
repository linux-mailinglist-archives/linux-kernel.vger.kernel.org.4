Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446DE60BD15
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 00:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbiJXWGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 18:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbiJXWGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:06:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F4086F8C
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 13:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666642695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=+oLikKrpTwfN5eZoO3ZPy9VDegRTEaRcO7+/yERF3Ng=;
        b=iheMMNI2V9RRqz/nwzbld6v5mNwPXjpvQ9J+3ZA8M/ssjI1pgsQ4SVX3j25mzT7LmIdIAC
        P/OA2OaJ/Ydo1r69oDIB8lVeKjAktLpciMyAjv7lyPH31MSK0AZbCSeerL71MkqpVTGFg5
        z+ZhNwZJD6cdKaVAXAyiFzYpY7F23/8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-324-OKMad_OpMgevCwNq-3S7BQ-1; Mon, 24 Oct 2022 15:33:39 -0400
X-MC-Unique: OKMad_OpMgevCwNq-3S7BQ-1
Received: by mail-qt1-f198.google.com with SMTP id a19-20020a05622a02d300b0039a3711179dso7651083qtx.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 12:33:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+oLikKrpTwfN5eZoO3ZPy9VDegRTEaRcO7+/yERF3Ng=;
        b=48odAFCI5rm8lh6t23vM4bdFI7tOpRTLVc9hPbM2oph94TisSWh5ft1GurvRdrx2lK
         t6Rxk8TFRiUsQ0auHHbe9DHICIvn7y6XztdzDwhsdfQxs4uEQi+VDxtYRGBk2Z3iRvFX
         VM4vuPhDtYL5JJM4HF90yMqYTmdhzvIp7qm3Mb9FZWLZv8XDjRujCmlFcaexTg6Cmg/c
         akJoFla0UTEBYQD9CkRTMoa6UAbB2grkrKd1D1H6/9W3dQ9nSOgFlmslFRx5PmFdZejg
         cTpA71ijuXJ2Kmge8B4gb0F2tmfK3Qxp7z3R4UWlFWU+GvAd3BuQGjLEi7VfT7zpo1l8
         VMLw==
X-Gm-Message-State: ACrzQf0MrWCSC2BaXN772mLzuKFUdUslKhUkPSUNfbF2w6IYPQiQ2z7p
        l8YAsK2/gSYWHNTDux7rWC5l4WfaNdopBWsrzmkVkDLrnyXqUmVly6oen3tcYapcWXkkm7Zr5DC
        Ox/WqvOpPHcXBLV747lHeIKB8
X-Received: by 2002:a05:622a:8b:b0:39c:f732:f282 with SMTP id o11-20020a05622a008b00b0039cf732f282mr29083464qtw.391.1666640018855;
        Mon, 24 Oct 2022 12:33:38 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6xnlmrmBflA5e08eff5fSpy4VsFWvEQXtWJgjrlbwS9+Ulhuq7Bln2MzR7zdfaCZEy1gPM9A==
X-Received: by 2002:a05:622a:8b:b0:39c:f732:f282 with SMTP id o11-20020a05622a008b00b0039cf732f282mr29083448qtw.391.1666640018605;
        Mon, 24 Oct 2022 12:33:38 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id t15-20020a05620a450f00b006cddf59a600sm545164qkp.34.2022.10.24.12.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 12:33:38 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Axel Rasmussen <axelrasmussen@google.com>, peterx@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH 0/2] mm/uffd: Fix vma check
Date:   Mon, 24 Oct 2022 15:33:34 -0400
Message-Id: <20221024193336.1233616-1-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I just got time to have a closer look on the uffd-wp triggering of the
warning here:

https://lore.kernel.org/all/YzeR+R6b4bwBlBHh@x1n/T/#u

It turns out to be a wrong check on vma, and with the fix attached we
should be able to remove the ugly macro checks.  Sorry for the bothersome.

Please have a look, thanks.

Peter Xu (2):
  mm/uffd: Fix vma check on userfault for wp
  Revert "mm/uffd: fix warning without PTE_MARKER_UFFD_WP compiled in"

 include/linux/userfaultfd_k.h | 6 +++---
 mm/hugetlb.c                  | 4 ----
 mm/memory.c                   | 2 --
 mm/mprotect.c                 | 2 --
 4 files changed, 3 insertions(+), 11 deletions(-)

-- 
2.37.3

