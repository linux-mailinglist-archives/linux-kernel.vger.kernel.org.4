Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4966260BD69
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 00:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbiJXWbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 18:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbiJXWad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:30:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D602B9B8F
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 13:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666644721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=JQGL1jLTE4eRZpodNbuy8I66zGQdLeMOjp5jA6UyMm8=;
        b=SMLj+kTJpCfkbLX4kUjhidTC9ZIompgDBf30IkHuYN+JPBeazurVDNHm8WZuivCqOjlsgg
        xDY/PTU5udWOR2DQsgzwrGoQyv18ZfnDPjb7IaZZmuiwwjBx4gDaEZ5SaAA1r5mNziU9Jr
        H2kNyzRx0CyyCXsa0SBRzIs0KRe2Qqg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-528-wjrmJy9PN0CopY0F2Db78g-1; Mon, 24 Oct 2022 16:48:34 -0400
X-MC-Unique: wjrmJy9PN0CopY0F2Db78g-1
Received: by mail-qk1-f200.google.com with SMTP id i11-20020a05620a404b00b006eeb0791c1aso9958692qko.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 13:48:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JQGL1jLTE4eRZpodNbuy8I66zGQdLeMOjp5jA6UyMm8=;
        b=lFos9yJD0ewLmnwNQraGNnKBDFjvnwvqTX3mcycZgBQoTJ/eL6dL40HsrsfZifQqrw
         qt9vvRiWs/ty7x2FNOXOTLjlZh1nWRf2C/EHl2qW/YGYMfVsDRuC01vXSbnCFh2Ddlcr
         XNUXwx4DCqfwFjQarID2+Z7N/s1Rr3swpxdZkvNLeTs9TlNINEEgnYZ6G5sG31nUUkA6
         TJPrifyNUNtYwY206lIf4UEDRWvWHOeGtrI6BjtmuMW6NTZsq2vh2+DLxAkT+NVfVoTu
         f2t7Jt3nfRKRFbRmZ2yAiAT03zpFRIlSKoHmDtfK5P0Nvo5fvXcU+fws3T4O61cJ1BPX
         N8Jw==
X-Gm-Message-State: ACrzQf0h45Bjiq7lbdQi3YRJY49/Y9lSWq80HgZ9mvT+xDCGSKKZoMq/
        HYh5IVqEXeeLWW1qzUfvTDTKN60ZGlfS5ZJSJoxE06e6Fglwjygu9cGeJHLeyJWeQ3cEKrcmZUu
        hrWpe1cab/nDmv/ahao3TUxPXC4O2Iykqd2Fm2XV/noteEqiU/gX9at2m5Fhekyr7LgvL06JBmA
        ==
X-Received: by 2002:ac8:5809:0:b0:39d:db1:895 with SMTP id g9-20020ac85809000000b0039d0db10895mr19877751qtg.440.1666644513240;
        Mon, 24 Oct 2022 13:48:33 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5kiaYHseH4qUmhdGwaMcoIvbNsE6lTLOG+iD7P8kRX5rpK3l1TOhSQyMDRCMFRdnSqlNtFFQ==
X-Received: by 2002:ac8:5809:0:b0:39d:db1:895 with SMTP id g9-20020ac85809000000b0039d0db10895mr19877721qtg.440.1666644512931;
        Mon, 24 Oct 2022 13:48:32 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id d13-20020ac8544d000000b0038d9555b580sm498531qtq.44.2022.10.24.13.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 13:48:32 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Huang Ying <ying.huang@intel.com>, peterx@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH RFC 0/2] mm: Use pte marker for swapin errors
Date:   Mon, 24 Oct 2022 16:48:28 -0400
Message-Id: <20221024204830.1342169-1-peterx@redhat.com>
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

Hi,

This series uses the pte marker to replace the swapin error swap entry,
then we safe one more swap entry.  A new pte marker bit is defined.

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

