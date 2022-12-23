Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE22654E5A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 10:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiLWJ1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 04:27:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236192AbiLWJ1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 04:27:17 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944FF37231;
        Fri, 23 Dec 2022 01:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=OyPsDfn6EY3YtQWol1kUj4ZkKQ779YWu6usWCZrDVyU=; b=3vSN5lDJRYtQDXMD4ceVKN3r/6
        iK16qYTqy2Rr8bBRNyrcjRDbQNsmuFotVPpHnYAwMGn4oTxZK98mHdSLqlS9iBfJZOpMNoEALGHyT
        8gGuZywdrNMc458UL5qkuO0RLdjn6QTqBtHWDaqqa5l1sW7zI172v20K0PO8mtOfrkpBtxjcbLrCx
        ZnGUnb3Aql8+9jIqgJmBfoeZGteAptd3lxNwnxqic+V6yejfqQpBmvCtMf1Trgsz54hl4jKx2Pd7B
        mdp3paNZrboT8AzhGVnc2OGhMQNb4MAQ9/CngUxoFXuKi0jjO8H/g7wtGYDaTlzP/LN48Mdjnkoih
        nqWt/2SA==;
Received: from [2001:4bb8:199:7829:8d88:c8b3:6416:2f03] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p8eKY-005hQ1-4D; Fri, 23 Dec 2022 09:27:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux.dev
Subject: revert dma-mapping and vmap API abuse in qcom_q6v5_mss
Date:   Fri, 23 Dec 2022 10:27:01 +0100
Message-Id: <20221223092703.61927-1-hch@lst.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this series reverts a completely broken commit to qcom_q6v5_mss the
abuses the dma-mapping and vmap APIs in multiple, and mostly clearly
documented ways, and then adds a patch to document and reject the
so far undocumented API abuse.

Diffstat:
 drivers/remoteproc/qcom_q6v5_mss.c |   38 +++++--------------------------------
 mm/vmalloc.c                       |    3 ++
 2 files changed, 9 insertions(+), 32 deletions(-)
