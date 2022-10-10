Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDDAF5F9781
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 06:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbiJJE4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 00:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiJJEz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 00:55:56 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F48152090
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 21:55:54 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id k19-20020a056a00135300b0054096343fc6so5332443pfu.10
        for <linux-kernel@vger.kernel.org>; Sun, 09 Oct 2022 21:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9D7woQS/Y7LRv3lLBPcVe2U8L04aJULWGfNbH/mytNA=;
        b=QiO/CgdadSqQtuPLK8JXrESg1qT7iViO6B+t51xivdvGTGM1afQkRkKxuD32ol9Gbi
         gRNy6BTuIlp/Poa8qc+Mt6Qgy99uNSHFnqgtP3KyVuAwvSRBLX+VKLXlfw1CJdHMTPYw
         rQkeuMavZx49fnBF3Zvputi3lhOq9ONcfFrWAiHxLEDDGDDIvkTqT37dzu1UI2vf/Y6n
         1tMPpAmrd2jaMk+CNdzvNPfWs3N4kTPAh7GKpDEANgGgl3dgeNqDa0tvRZivWDjPZvMC
         qZqdRuiWM/kUo4u7+byGJJOkGTlS1exdPQnHSL6Rz5wj7ekFQ+m64ozAG+shZFWeWuBA
         pxgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9D7woQS/Y7LRv3lLBPcVe2U8L04aJULWGfNbH/mytNA=;
        b=ATTmApUB77JHqOHFFiaVhwcL+IiO4SkiBxsFR9AcBitDS8c24/2YCYQe67FicJkBfq
         jWvJGYrQuFsxdzHy/994wgcL4h48tPOCoXVmjB3H0xIP/nRRKuPySEC3IKABmzE5evno
         QeA9/MhwLN5cJSTflyWFNDzq9/en9Kln6PZ1sIf2B+fKTrbg9V56UCsjsxpXOxq+08ZM
         s/tDDeWQiQxkzmBikNFJ9vFZBOO/iyLZZCG/CGp6yjI43BfjTaR97R8rr29WI9GF/0Un
         uU0j9kbgA4JvWtgHGfH10nnya3qRLXe603JaZxhTf6nA4v0G9J0a5wzrD5HdRLezhX+u
         /TKQ==
X-Gm-Message-State: ACrzQf2S8FltQxkhKlMWkHiGSoM9q9UU42eAXwWTRYoUGpcihoRrR+Gd
        VPqQDuYk5CeMUkxk9/XQ/pNMwTnIarZQ
X-Google-Smtp-Source: AMsMyM7buICJcvtAVcA/hb70MWhtXei9yPJ71Nfeow8q5GbMquyDCR+wh7GjIUw8Ei9dlCpBwzVeiMEx+Jt6
X-Received: from sgzhang.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3d89])
 (user=sgzhang job=sendgmr) by 2002:a17:90a:f417:b0:20b:6d04:a502 with SMTP id
 ch23-20020a17090af41700b0020b6d04a502mr17631808pjb.76.1665377753399; Sun, 09
 Oct 2022 21:55:53 -0700 (PDT)
Date:   Mon, 10 Oct 2022 04:55:46 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221010045549.2221965-1-sgzhang@google.com>
Subject: [PATCH v4 0/3] mtd: mtdoops: use pr_ functions, add and direct call
 mtdoops_erase function when panic
From:   Ray Zhang <sgzhang@google.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ray Zhang <sgzhang@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In mtdoops driver, to comply with latest kernel code requirement, change
printk() to counterpart pr_ functions. [Note: change to pr_debug() may
cause behavior difference.] Add mtdoops_erase function; When panic
function invokes mtdoops, if needed, call mtdoops_erase function
immediately.

Ray Zhang (3):
  mtd: mtdoops: change printk() to counterpart pr_ functions
  mtd: mtdoops: add mtdoops_erase function and move mtdoops_inc_counter
    to after it
  mtd: mtdoops: panic caused mtdoops to call mtdoops_erase function
    immediately

 drivers/mtd/mtdoops.c | 109 ++++++++++++++++++++++++------------------
 1 file changed, 62 insertions(+), 47 deletions(-)

-- 
2.38.0.rc1.362.ged0d419d3c-goog

