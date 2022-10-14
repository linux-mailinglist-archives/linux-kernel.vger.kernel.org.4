Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6195FF43C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 21:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbiJNTuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 15:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbiJNTub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 15:50:31 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321477297C;
        Fri, 14 Oct 2022 12:50:29 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id E73CD102304;
        Fri, 14 Oct 2022 19:50:16 +0000 (UTC)
Received: from pdx1-sub0-mail-a219.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 5BDE3102259;
        Fri, 14 Oct 2022 19:50:16 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1665777016; a=rsa-sha256;
        cv=none;
        b=gFozmPtshhKQsvVh5sq11urVH54P1kH7dkf0facaxWCGRUcantS26XYnoBxYf1nItvDBDK
        sl9BrsPDcQ6zv5Sj/4vKP9k6p+92+pkxS3BJcCU60V9G851m9rvZp+XAk+x475/0Iwpi5s
        4Ya/Hw5RTqdFtztj8Ts1xiMpwM4TKL69yFFjCVNUj/PCdkzMrVpuaVAaAfr66VzjxMXLx/
        0LqY8Pg22NmbxN4t5NMVuQX1yqMiYsing4mInuqTUwdmofS4JiDq3jO2z8P8BlM8XLrY25
        1jWxe7JUWZhYSWZOgs9l/tUhXeaavqenA698nvP787g8CDbxRXrVSHyAZQ/WmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1665777016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=BSsw+C8H1haZBqLOKGlQvF0KXC9qFQwxe3lP2soheho=;
        b=nF05uTGv7y67JlV3+sPzhxVW3d1bmKkvRxtAYUgcRd3gMFId4XZQ3MplcnxRbBoAju0XdP
        BFTWPgLHyKeWWnzKGWkUa0jPAH+5EReW2s9LA1VQ0XyGaiOQ9Ir8gH9joINZ4QW4TBqBmJ
        yNlI3n71juribdeok/OCf84AS3a2iFJoMKCsRIgITLhj/Q7/5ruQuizYKFlOj/UvOqQ4KN
        xmVg9WY5TesZSZvu/FKCaxR/Kmo3Huh/ta1baqNSv85pPHG4JhDPdEAIJUO2miXH4GcA1t
        rZgrFtxPIJNr7l57gpqoJUrkGlvo1YmJmLfDyE+jADEQDAnRJYSEgYXtbPseuw==
ARC-Authentication-Results: i=1;
        rspamd-5798657bcf-986bg;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Irritate-Well-Made: 43fba5ab04638e43_1665777016708_1930507670
X-MC-Loop-Signature: 1665777016708:2137937379
X-MC-Ingress-Time: 1665777016707
Received: from pdx1-sub0-mail-a219.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.122.213.136 (trex/6.7.1);
        Fri, 14 Oct 2022 19:50:16 +0000
Received: from offworld.. (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a219.dreamhost.com (Postfix) with ESMTPSA id 4MpxnM2ndWz17;
        Fri, 14 Oct 2022 12:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1665777016;
        bh=BSsw+C8H1haZBqLOKGlQvF0KXC9qFQwxe3lP2soheho=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=RIGH1aw1MLHddM9QFVquTAs0xUcg9OxorBhcMigEFzD+E2tRvFk8cJD0OtXLizDSI
         /QNJpXOc27LNiC1yq29Kyz9NlxO7nzSkjdSgcsSUvaMMGAmdgK1neMbG/zJ1605IhM
         L8YnwzbAR6xLj7YCbzD/j2XEWCLfGkcnbuN568O1snWLRzXwmoZ27ym7882po5HY1p
         4LnquOo/TOqiOBMmUmU4dVlOH7315JAR+LeMVsR/xTXhOvJzbtbiggvKazzWpxCKIl
         BVCeD/ZxrOJ341FsQbIGpvVhX7A5nJEOITNvaRVgnBKy5NmRMDbK3PNxRHnMuUWc8U
         rBl8KfkyfrGfA==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     ira.weiny@intel.com, Jonathan.Cameron@huawei.com,
        dave.jiang@intel.com, alison.schofield@intel.com,
        vishal.l.verma@intel.com, bwidawsk@kernel.org,
        a.manzanares@samsung.com, linux-kernel@vger.kernel.org,
        linux-cxl@vger.kernel.org, dave@stgolabs.net
Subject: [PATCH v2 0/2] cxl: Add basic MSI/MSI-X support
Date:   Fri, 14 Oct 2022 12:49:28 -0700
Message-Id: <20221014194930.2630416-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changes from v1 (https://lore.kernel.org/all/20221012180432.473373-1-dave@stgolabs.net/):

- Do not populate the cxl_irq_cap_table. (Jonathan)
- Moved vector allocation further above. (Jonathan)
- Added an irq_type flag, makes sense to have for checking during setup.
- Left no irq support as an error, but mentioned that in the the call is
  in the context of allocation. Otherwise this makes the user handling
  unnecessarily difficult.
- Picked up Dave's review.
- Added a second patch which adds the basic mailbox support (Dave)


Patch 1 contains updates for the generic table handling.

Patch 2 populates the table and adds mailbox support.

Please consider for v6.3.

Thanks!

Davidlohr Bueso (2):
  cxl/pci: Add generic MSI/MSI-X interrupt support
  cxl/mbox: Wire up basic irq support

 drivers/cxl/cxl.h    |  6 +++
 drivers/cxl/cxlmem.h |  2 +
 drivers/cxl/pci.c    | 91 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 99 insertions(+)

--
2.37.3

