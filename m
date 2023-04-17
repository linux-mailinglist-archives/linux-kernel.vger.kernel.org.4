Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECDEF6E4B99
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 16:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjDQOge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 10:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjDQOgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 10:36:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4D1E8;
        Mon, 17 Apr 2023 07:36:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC2D862603;
        Mon, 17 Apr 2023 14:36:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11CCFC433D2;
        Mon, 17 Apr 2023 14:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681742184;
        bh=TJvJT+LSQXiURhDyuoQ3DL12SWV4O4BRIOvlEFEf2K4=;
        h=From:To:Cc:Subject:Date:From;
        b=L/I7s1WWi0EtlddLnCpSrOcdzC2/gyRjEFEHhikUmXtYD/yamH1Uc7qhimNw4CoyZ
         1WJyokHwaqp50Y9ZLKFA7/iFJFxr9Yrjgn0aoAmi95/YGRKQie/OT799bd/fvHeQTa
         FJjEHPpJD3/3mTOfC+/JOJ0rU9a1FgCc/G2yZaPpDOJmRhUGIpBRkEug5OG3ptLXLr
         g+8M8QRzZ9zOMDqRuC/3HXOmOIEgUitf34T8Z4lzm/G6sZ9iHs6O9JYCQAfJ/Xs2uR
         4wrwevW+ppjnLqnqZ+NWc+ZavrMAJmvzdNxILBM+3DzV0NWHRpw1z+bPZaXhSvJeOv
         womyFuPRUTiKw==
From:   broonie@kernel.org
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: linux-next: manual merge of the bluetooth tree with the origin tree
Date:   Mon, 17 Apr 2023 15:36:18 +0100
Message-Id: <20230417143618.2091407-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the bluetooth tree got a conflict in:

  net/bluetooth/hci_conn.c

between commit:

  5dc7d23e167e2 ("Bluetooth: hci_conn: Fix possible UAF")

from the origin tree and commit:

  0623067085473 ("Bluetooth: hci_conn: Fix possible UAF")

from the bluetooth tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc net/bluetooth/hci_conn.c
index 8455ba141ee61,640b951bf40a1..0000000000000
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
