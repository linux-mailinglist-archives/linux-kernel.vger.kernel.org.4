Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D633070E458
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 20:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237252AbjEWRuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237688AbjEWRuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:50:02 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2765697;
        Tue, 23 May 2023 10:50:01 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 01A476C1E22;
        Tue, 23 May 2023 17:43:17 +0000 (UTC)
Received: from pdx1-sub0-mail-a250.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 314AF6C2559;
        Tue, 23 May 2023 17:43:16 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1684863796; a=rsa-sha256;
        cv=none;
        b=SJBBtMdTS1PCNy5NMFPfHz9N+mM/oc7tPsTD7P0Jk8E2pMiUF1jb3PWiy1SEgxbh8uKSfr
        LOAExZ3HWJATrbDM9qVGP2GTH0+cqafBLlkrCkNbLj7gVePRG24L6H8Tp1YnQeOC/QLlyh
        4+ntBzoVnmPsVhRfdyWN4XLLG4fpb9sVCX7BwZibsRjKLdSrH6ucL25RRC0b9biETTXfZC
        inQTbJiUAQw+UxzxENuhNseibIJq45Ng8WxmLf2TQCw6rVuPXLLilGvqYcHEtXhUnsk+Vy
        2IJxS3sseBO3be3rRhSuP03DG4CCiymPlskDVLdt837C8SlE7zKdRE7Lm0yEDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1684863796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=tYJ8eqb/EN9AAbwVRk6uJocgQlf/+ZFzRu1lCYTGfsg=;
        b=PvFQsqza0LgjntHf0DmMkfTOBY30+GZMkB4alJ/ADniHF/JLexfMWyfMzFR0LHVOqlgW79
        Y7Qx26SS5yQkB3FyF4uLjW1m98/p7K4JCIxjYhSY5q8BHdnyjTJI+wTAT+/wg1yyPO9JGS
        jE0LUiyLLkQTi5F88DWOLb2cW/mjoN/lkFH2zRIOI+fcksSCaFJJjG6RfecFkw8+wEHpk0
        Nno8tL1zT/lJcOQSLWOTxLPJPLBDvGZBUg6eA7P/+3HpuuFZ6rukWltfCJRKIe04y+HuYH
        yVDUSRnhJbqf5FahirA6r+js69musGkmwnhq/yGq0d1shNnLKp6rHkIRZvKsCw==
ARC-Authentication-Results: i=1;
        rspamd-5cdf8fd7d9-s7qtv;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Abiding-Stupid: 0e71c7b418b1af87_1684863796760_4140042941
X-MC-Loop-Signature: 1684863796760:640463744
X-MC-Ingress-Time: 1684863796760
Received: from pdx1-sub0-mail-a250.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.127.59.19 (trex/6.8.1);
        Tue, 23 May 2023 17:43:16 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a250.dreamhost.com (Postfix) with ESMTPSA id 4QQhVq2FpBz6m;
        Tue, 23 May 2023 10:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1684863796;
        bh=tYJ8eqb/EN9AAbwVRk6uJocgQlf/+ZFzRu1lCYTGfsg=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=JMp/bISsVxEzj1pIXW4EXTvUi3e5munz9145RL1AoES64jYHz4nc5Pk4alA4KCkkj
         ILA7gudWbYOuVfxl9KJqsGVW+IHpGsnqQT+z1KtZuc7qDrWI2bc/KCp0LPqgx0We+2
         f666EQyq9TParHG8p0hzdf2DRW3IKx+teI9jGLU+qSuMJRPtT9tjS+tDqJPKnCHUfN
         vzX4J8bzGlZWI+ymIDnRB5b0sdUld/+1Hw/YMvoVC+en+CxauADftgnwbz7fj4EdYF
         +1w/WyltzLs04kdunjvJvbi0kYc1wPEGCwhBy8Lbtz1qZbOV0QtxsE1QvSinalC76Z
         YZllsO4McqVhQ==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     dave.jiang@intel.com, alison.schofield@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com,
        Jonathan.Cameron@huawei.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] cxl: Handle background commands
Date:   Tue, 23 May 2023 10:09:23 -0700
Message-Id: <20230523170927.20685-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the latest iteration of the synchronous background command handling
work. Currently there are no users, but it is expected that firmware update
and scan media be the first two to use it.

Patches 1-3 are requirements for the actual patch 4.

Changes from v1/v2 (https://lore.kernel.org/linux-cxl/20230502171841.21317-1-dave@stgolabs.net):
    o Picked up tags for patches 1 and 2.
    o Added more context to the changelog in the rcuwait patch 1. (Dan)
    o Added new patch 3 for common request irq functionality. (Dan)
    o Misc cleanups in patch 4. (Jonathan)
    o Don't clobber the ctrl settings. (Dan)
    o Removed bogus warning in irq handler. (Jonathan, Dan)
    o Make sleep uninterruptible and clarify in the changelog that
      timeouts are in fact unexpected.
    
Applies against 'fixes' from cxl.git.

Thanks!

Davidlohr Bueso (4):
  rcuwait: Support timeouts
  cxl/pci: Allocate irq vectors earlier during probe
  cxl/pci: Introduce cxl_request_irq()
  cxl/mbox: Add background cmd handling machinery

 drivers/cxl/core/mbox.c |   3 +-
 drivers/cxl/cxl.h       |   8 +++
 drivers/cxl/cxlmem.h    |   7 +++
 drivers/cxl/pci.c       | 136 ++++++++++++++++++++++++++++++++++------
 include/linux/rcuwait.h |  23 ++++++-
 5 files changed, 153 insertions(+), 24 deletions(-)

--
2.40.1

