Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17805ECB68
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 19:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbiI0Rlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 13:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbiI0Rko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 13:40:44 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45531EAD63
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:39:21 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id a3-20020aa795a3000000b0054b94ce7d12so6146266pfk.17
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=cfW6P4xnGiNxspv7lrrMAvh03t//Xe+bE5jk10e/JJM=;
        b=MSoTgMILPkGBRU07gf8JBEFKIFDLnaXWXtCN3H+WjQmKsYag5ts5hPQ2M0enqj/yQ2
         8I7vvUSntSs9+XWQrzOl8CsjQrN67E5HUd8ML+4SGsEZv/9xZDtGT4yXiEzWkDHDnRDM
         D3t7J9w3fIcnHnjeUyHEq4ajjzvFkaKzMR9Cc+eQFaxWXii05201jAuJvb6pvuStYRv8
         HFXJ/IqU4iue+ohAJgzdxqMc6/4hVqXXEK6ym3ZAVDk89I+PMhBOY6QEngjLe1GQHJ9t
         oq0reFdcRQAbjJUILrpHFQuWibGCFjyitjzaokBDcEZM5DZrn1+rH3JDFEVXUhHNCBNb
         m8Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=cfW6P4xnGiNxspv7lrrMAvh03t//Xe+bE5jk10e/JJM=;
        b=riS87QrCObVx+Df5v6/eZFNOVTnPcaPQeeKbMRwK2eQ0MZ9mCDhnWRq/5yGJFbMukA
         3fDdjO2gYmSmknBEOTdgPuNb2xMIgNJoD8wjxbFJn37c9xRff5+8FAoVbpyWza+eBN9c
         dQFZ9IALnVTa+8SzAdjvk0QmMyxaoiBN5sIJ5rJYCaAT0ES5YpfFtb/G0alqjGF9VHZg
         aprWt7C+U4ilo0wAiSwq7o2qTdmTwNJB9d6Ibu+TMb7VqsduPX28WaaDkOgrxkh4xWyV
         P4D4CX53/JZC/qFjpMF41dhJleVrd5bCCE1jS4rDF8QlSqhzVvaGubSBiQdX7fMBw0AJ
         7sXQ==
X-Gm-Message-State: ACrzQf26UpdQTaqFCAN0xQWZLbmEgOKRgELHMci2Ib+ANIwkekXLfLUY
        he1Tfp2gWi7OceQq0d+s6LRF1fDcFfML
X-Google-Smtp-Source: AMsMyM5bTykP2riCIcy3AsjQ/14S0fAIi5hNV20tr64VRsRWujSKABbvICdiroXEzyOi0TUtcvRAU2+y3BFL
X-Received: from sgzhang.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3d89])
 (user=sgzhang job=sendgmr) by 2002:aa7:8d05:0:b0:557:f0c1:6413 with SMTP id
 j5-20020aa78d05000000b00557f0c16413mr15214598pfe.19.1664300352650; Tue, 27
 Sep 2022 10:39:12 -0700 (PDT)
Date:   Tue, 27 Sep 2022 17:38:43 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220927173845.2293378-1-sgzhang@google.com>
Subject: [PATCH v1 0/2] mtd: mtdoops: change log and erase functions
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
printk() to counterpart pr_ functions. When panic function invokes mtdoops,
call mtd erase function immediately when needed.

Ray Zhang (2):
  mtd: mtdoops: change printk() to counterpart pr_ functions
  mtd: mtdoops: panic caused mtdoops to call mtd erase function
    immediately

 drivers/mtd/mtdoops.c | 108 ++++++++++++++++++++++++------------------
 1 file changed, 61 insertions(+), 47 deletions(-)

-- 
2.37.3.998.g577e59143f-goog

