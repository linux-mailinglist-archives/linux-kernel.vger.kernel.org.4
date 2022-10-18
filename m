Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3956022A5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiJRD3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbiJRD2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:28:41 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E3BA4BA1;
        Mon, 17 Oct 2022 20:21:42 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 5DA8C26038B;
        Tue, 18 Oct 2022 03:21:21 +0000 (UTC)
Received: from pdx1-sub0-mail-a201 (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 91BE3261024;
        Tue, 18 Oct 2022 03:21:20 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1666063280; a=rsa-sha256;
        cv=none;
        b=v17MZhwpbYF72eN+vgCRf37a1D69+ik6rMBHXjWUjufhKP1LZdl3yu1/wRq8oBIvtQpx24
        Ae+1Zc3q5b/v0XyiXXcHDhZa0UY08cXecjgkiketncT+s5Hb8H98n9yGzRSKZuqrFxhvJ0
        Nm5m0lNb+AQQzMDor+jEZ+86ZeREaPshNelIsMwwk9RiTk4zuoC7O/6Q3jS7FxcJBKIGkf
        KgsvT1OpJpgYo+7Fv/tpZOxtHocWob6CHOPFfoOvsz5W2Hgb4M7NKD00i43w5YKZ7vIn4k
        i9iQ29EeHw7/wDIKugmpCmK8WmsD4Nb9sjnka6bvRvA1p8tN8qk/Kbfsmyehzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1666063280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=ILbHeYrKebGff/gCYrwQF+wxGkTlypCNizQCYMdzZOY=;
        b=4IwmUaPKkmUw/4wJV8LRED9pvb9f4cROQNDMB0qmBdsSLjNLXk9OnAygHHdHSBLFdw0uxJ
        WUEy200fY1CRcJLYKo0MNIntAiTaTh7dQIXma3YoppmdEDsLtNg2iQj+LkVNSgaOcVlmMQ
        2G8SX1KMlg5mHyTbBjkV+CD6HoGFcR2Wj6mY9pTJ0ewbdrztBdr9HCRy1WWJ9B+A+dz6z0
        Md5XiTZSZtHeCSks28XR46aES8JwgXX1gHEXEFC2bfvfLfJ3oKX21zl65eP+uB8ypJjdvb
        dGYjOGEdXEgQ8Ucdyz9o3GofxWeQmVqDQoSKIAXjqAAzpMGuj6BZdKGcc6l6OA==
ARC-Authentication-Results: i=1;
        rspamd-7fb88f4dd5-ll8h2;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Continue-Cellar: 272ab2964a3e92de_1666063280948_2398127442
X-MC-Loop-Signature: 1666063280948:1938447653
X-MC-Ingress-Time: 1666063280948
Received: from pdx1-sub0-mail-a201 (pop.dreamhost.com [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.122.146.22 (trex/6.7.1);
        Tue, 18 Oct 2022 03:21:20 +0000
Received: from localhost.localdomain (unknown [104.36.31.104])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a201 (Postfix) with ESMTPSA id 4MrzfR3mNzz4r;
        Mon, 17 Oct 2022 20:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1666063280;
        bh=ILbHeYrKebGff/gCYrwQF+wxGkTlypCNizQCYMdzZOY=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=Cjo3OoCAnmZlFkkZtVAQLi5Y6ZTtEkrFOflM4mK8p1CtCRpaUgXCeU3typB83HXgv
         H031AifP62/r+lj8Rs4Kcuczffkd57ibkWsSlrPk3OpSbJRyRMAkJ+1sQG6JPTpNzZ
         k+eEOFYwhe6dAGq6dJf7HdyVxtBBIoCsRRHAkjlbGQtErFfDwEb0rCEbrjeNzpLy6r
         9FAOq9FiHNw0Uxj83xvxHGWnCromjaUkUB64ZDxBAjcLT0B+N0IZbCgu/n4mxHcRxr
         1HPoTr6r4IISC/o3WSDM5M0wOfRkNI1K3jtCnOc9WzK60rNlXyCE3wyd8G4dPHNNiJ
         l1RFPpgkauQzQ==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     ira.weiny@intel.com, Jonathan.Cameron@huawei.com,
        dave.jiang@intel.com, alison.schofield@intel.com,
        bwidawsk@kernel.org, vishal.l.verma@intel.com,
        a.manzanares@samsung.com, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, dave@stgolabs.net
Subject: [PATCH v3 0/2] cxl: Add general MSI-X/MSI irq support
Date:   Mon, 17 Oct 2022 20:00:08 -0700
Message-Id: <20221018030010.20913-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.38.0
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

Changes from v2 (https://lore.kernel.org/linux-cxl/20221014194930.2630416-1-dave@stgolabs.net/):
 - Moved vector allocation further down the line during the probing (Ira).
 - Replaced the irq enum with cxlds->has_irq (Jonathan).
 - Use pci_request_irq (Ira).
 - Small fixlets/improvements.

Hi,

Patch 1 contains updates for the generic table handling.
Patch 2 populates the table and adds mailbox support.

Applies against 'linux-cxl/pending'. Please consider for v6.3.

Thanks!

Davidlohr Bueso (2):
  cxl/pci: Add generic MSI-X/MSI irq support
  cxl/mbox: Wire up irq support

 drivers/cxl/cxl.h    |  1 +
 drivers/cxl/cxlmem.h |  3 ++
 drivers/cxl/pci.c    | 99 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 103 insertions(+)

-- 
2.38.0

