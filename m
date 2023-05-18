Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0918970830A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 15:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbjERNnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 09:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjERNnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 09:43:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB53A1A5
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 06:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=piFrG5IdL4hzL74U9vzU8Q8FkrcebDa8Lvd7CJSzX1k=; b=CsnQ9kgCBYwe6gnaRylmDTM7Wg
        VjmAGMjJNouFmojoa2PViZy7KmCYkXfDItlxSiGdMRAKa4u6bzwnXH4xPbITOvKi46E/e8j1923vR
        u9Qj20fH+4Jugzi8umtd5H2NCKBNNKBIBV0dxSh72+mq7t83yJrzFx7FLxqhbec1O5OZi/yVN98fM
        bMfK/BLvhmvFSMgRRzB1zl6hg7RjhlcD4Ba8FO3xlDIUmySBgiGGVXbnu2ZFgjv2AQpplWQ2Swsa/
        jUTX+NHAV9OEu62r3wgbLMxWNseWs9tNZ5xv/HXPufF4KzJy/mSF0tCwCSPpD5y/XE2Ohl7NFw+0f
        4i0qXJRg==;
Received: from [2001:4bb8:188:3dd5:1149:8081:5f51:3e54] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pzduC-00D6Qd-2E;
        Thu, 18 May 2023 13:42:57 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>
Cc:     xen-devel@lists.xenproject.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org
Subject: unexport swiotlb_active
Date:   Thu, 18 May 2023 15:42:49 +0200
Message-Id: <20230518134253.909623-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this little series removes the last swiotlb API exposed to modules.

Diffstat:
 arch/x86/include/asm/xen/swiotlb-xen.h |    6 ------
 arch/x86/kernel/pci-dma.c              |   28 ++++------------------------
 drivers/gpu/drm/nouveau/nouveau_ttm.c  |   10 +++-------
 drivers/pci/xen-pcifront.c             |    6 ------
 kernel/dma/swiotlb.c                   |    1 -
 5 files changed, 7 insertions(+), 44 deletions(-)
