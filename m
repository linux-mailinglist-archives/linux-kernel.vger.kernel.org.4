Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D456F847F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 16:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbjEEOFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 10:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232695AbjEEOFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 10:05:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639B614E5D;
        Fri,  5 May 2023 07:05:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09C3D6120E;
        Fri,  5 May 2023 14:05:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06870C433EF;
        Fri,  5 May 2023 14:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683295545;
        bh=C2geJvBn21IBblTJ0IEJ0Dfm+DUTWnIev4wKTeoTUdM=;
        h=From:To:Cc:Subject:Date:From;
        b=ij29A2hgwGSdgvcBBZwr7aCJLne6Qx520GWrjgyoYtasTyRBe1z9EVXqF4F8Kgboq
         9LcNfshqPnyDH3mvXc+U0O6jHF4Gi3vBtu8ddZPLNTTPP9UpoAAwASP0Q2qLLQAgCo
         tf1PPgacXyFZPj1u0wAZ6au31CKe3XRhxS0qsAaAy4DXGzrhJxAtn25zWeaXioDWeX
         Eg7Tpga5FC11GeUx1CIqeuU3JjwjV5eM0OjNMrIxxqlc0pWDAvnBbdCdxPElZasRI4
         Gye2ip21A+pBstCs7WoV5jzhvjC/7B7tnhVjOI5ve6UFpwPtyWR/ZlRYWmqFo9n+On
         r8ErfpClE1kNA==
From:   Mark Brown <broonie@kernel.org>
To:     "Michael S . Tsirkin" <mst@redhat.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Wenliang Wang <wangwenliang.1995@bytedance.com>
Subject: linux-next: manual merge of the vhost tree with the net tree
Date:   Fri,  5 May 2023 23:05:41 +0900
Message-Id: <20230505140541.220392-1-broonie@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the vhost tree got a conflict in:

  drivers/net/virtio_net.c

between commit:

  f8bb510439456 ("virtio_net: suppress cpu stall when free_unused_bufs")

from the net and Linus' tree and commit:

  bc31caabba78f ("virtio_net: suppress cpu stall when free_unused_bufs")

from the vhost tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc drivers/net/virtio_net.c
index a12ae26db0e22,cdb1654e5a435..0000000000000
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
