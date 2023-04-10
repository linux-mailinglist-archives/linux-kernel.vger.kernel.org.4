Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E236DC640
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 13:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjDJL24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 07:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjDJL2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 07:28:54 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E1330D7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 04:28:53 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id n14so29532052plc.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 04:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112; t=1681126132;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VkNfRS2z4TLrRnI95YkzXxtnMiNB9VejbuSfHWwKvfU=;
        b=1MJHz5HjiAZ0Plo62ALxgwSJLnz60cwmLyvXZWvPxOMsoXI9uNFNss3qBh3O5xa5mg
         9NYZnCt3Gt8PmPsES3zZUX9yM92k9hTDoAkLr5ntVVxen1NDn+B3mxmGLiElo1NDdahL
         iaeltav6IJvc9rj8oF70stZYXcTblA0vgMj493XdWPeKLekTXHHtpF1qL5MT+8wa3TWB
         fED/Lscsb36TMigS/BqIh5Ve77DpRxERm2Pb9z/GccceUk2+zRnEbP4+1cG5a2SSOdlT
         PvK7sHplNo2lA2hM7vqkMhVgHncPkZfP+d0x2lyULWsJh7sp75gpRBAmir8nZib66xML
         Heog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681126132;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VkNfRS2z4TLrRnI95YkzXxtnMiNB9VejbuSfHWwKvfU=;
        b=MoE+2jP9p2xZOYzjeHM9P2t0NsIh+SBxMe9rzmYje2CL+QImcY3L0mRrL+MByUQN59
         pvxe1CSBHMkiyQg9IlfOErr8AGEdoSsCv4JZ9c2GO4wVrEkSg6m3JlMBLfT94mxwbwTq
         e3P7oNC5eoh0pBBKzGuQMYIDUu3ITyCpB1V0PBXZ6JB6fXSiEzkNQz3bzRAMBOt50Wpm
         tDuLTT44jtvSYhl0+dxRa0sXJCDhIaW0kH0Y57A4ScSoJhpxgKGgnL0P16CL8xr3T45m
         xneOXCBPcQQGFtDa4aCsvLWR/HVJqjR3Mj57lzNsiDTVVn+ReKjJP1FVx1YvhW9qj/Ha
         +9HA==
X-Gm-Message-State: AAQBX9cIqlYBXG7A6N271q/meuIFriitq9G0mAiBZG2tCBozQOeviYto
        BmuzYc7NUEjsyiMYVXZlC4Twprq38W3Oym56ltM=
X-Google-Smtp-Source: AKy350bCVikvIoHJ6lVsgIMVIyeu765afYRq6v7P1NOXma1TJJbIHOZYgqYBCoWGggyVEWw/E2Dwcg==
X-Received: by 2002:a17:903:1112:b0:1a3:d4c7:365b with SMTP id n18-20020a170903111200b001a3d4c7365bmr15308569plh.3.1681126132550;
        Mon, 10 Apr 2023 04:28:52 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id y11-20020a1709027c8b00b0019c919bccf8sm7575052pll.86.2023.04.10.04.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 04:28:52 -0700 (PDT)
From:   Shunsuke Mie <mie@igel.co.jp>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Shunsuke Mie <mie@igel.co.jp>,
        Stefano Garzarella <sgarzare@redhat.com>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v2 1/2] virtio_ring: add a struce device forward declaration
Date:   Mon, 10 Apr 2023 20:28:44 +0900
Message-Id: <20230410112845.337212-1-mie@igel.co.jp>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The virtio_ring header file uses the struct device without a forward
declaration.

Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---
 include/linux/virtio_ring.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
index 8b95b69ef694..77a9c2f52919 100644
--- a/include/linux/virtio_ring.h
+++ b/include/linux/virtio_ring.h
@@ -58,6 +58,7 @@ do { \
 
 struct virtio_device;
 struct virtqueue;
+struct device;
 
 /*
  * Creates a virtqueue and allocates the descriptor ring.  If
-- 
2.25.1

