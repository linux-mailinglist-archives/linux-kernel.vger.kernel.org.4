Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB136D1601
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 05:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjCaDbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 23:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjCaDbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 23:31:43 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23C2CA18
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 20:31:42 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id r7-20020a17090b050700b002404be7920aso20045074pjz.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 20:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680233502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f0dyJHBuK5UpoDUR2HtwiB0N1zgJU2RE6kdVXBTWcZE=;
        b=jND5ce5JWkxV0kSqsZnPmOZC5F+jlDguHcuLWv0PtRKqc0xvdyrkCYfdLOd5wLTf0I
         4f6QOAAEBkUWLxLk+ubfelg6JyUSlWmeVhl6P0hkLnBnoiXbC21BxjBNErX2WoZFzXjI
         mMPx5i1TgomZRiLJhti472rzFjRjMs78zQo6DboaN4OZaWclZRlviF+5fFQ9N7tbYYOq
         ZH0rf/Z1+ifs+NYKnKWRoX9AxH4gTrFeCjxMI7Z6q/SOLbig8zWOec041Yq0O6odTKiT
         jsRK931W+lbOKHwIhflL7hc003WbXxxJ6TytRSXi2ehFRSZ0oPVx48mb4EjT/GUp5+69
         OXUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680233502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f0dyJHBuK5UpoDUR2HtwiB0N1zgJU2RE6kdVXBTWcZE=;
        b=xqqUEQKxlwqTitV9SB+DfPz4WJxiNK+PtaZZJdUAumspLPovxWapoNSWQbfbqcVq1m
         74mf7MKx9v6cQZxt8tFCMc4pLNPTXo8j3Nj8aReLF5K4Rb3aXKizSLqeiE0KFBQ1fqgD
         q15TZH74ad9mOFyYwbLGlc/aOKy7QL97OP3B2BNGWWwPJMTsDpx/ZafGpgXnbA1mhq6t
         IbAlvmr6rJuMuW+wNO3vwgPa8DlT2eYNeDlPkDaeONYqMe2OMoTQZDWG5CjyJoog8be2
         gf3qAt89+cvEYTbNlBKgrFa2lpuGDsf+nHDvCfb86WJ39saPZWJXdsuk7Sir4Z7/9iBR
         SKqQ==
X-Gm-Message-State: AAQBX9cNoBefWDjm1OEBajqfD0wlsxfMDwbD5OLcvPJM+YGdvrkaA+wm
        txS1pTHoObHeXX0ILoME6a0=
X-Google-Smtp-Source: AKy350ao0UIaY49NAnVjHbGTq092/pCn7iKgFwIfciJ3fEwDzuOpFLcRz9RQuZFES1aQXmBM0kqbMQ==
X-Received: by 2002:a17:903:32c7:b0:199:4be8:be48 with SMTP id i7-20020a17090332c700b001994be8be48mr9694702plr.19.1680233502317;
        Thu, 30 Mar 2023 20:31:42 -0700 (PDT)
Received: from ubt.spreadtrum.com ([138.113.14.245])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902eac400b001a239325f1csm449128pld.100.2023.03.30.20.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 20:31:41 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux.dev, Baolin Wang <baolin.wang@linux.alibaba.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [RESEND PATCH V3 0/2] Add reattaching support and fix memory leak issue
Date:   Fri, 31 Mar 2023 11:31:22 +0800
Message-Id: <20230331033124.864691-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
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

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

V3:
* Split into two patches;
* Added support reattching an existing domain;
* Release DMA buffer only when domain freed.

V2: https://lkml.org/lkml/2023/3/7/1717
* Added some comment in sprd_iommu_attach_device() for the reason
  of calling sprd_iommu_cleanup().

V1: https://lkml.org/lkml/2023/2/10/198

Chunyan Zhang (2):
  iommu: sprd: release dma buffer to avoid memory leak
  iommu: sprd: Add support for reattaching an existing domain

 drivers/iommu/sprd-iommu.c | 54 +++++++++++++++++++++++++++++---------
 1 file changed, 41 insertions(+), 13 deletions(-)

-- 
2.25.1

