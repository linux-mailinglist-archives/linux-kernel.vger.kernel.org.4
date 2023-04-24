Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4786ED1B3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 17:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbjDXPsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 11:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbjDXPr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 11:47:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CC0423C;
        Mon, 24 Apr 2023 08:47:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 060E762675;
        Mon, 24 Apr 2023 15:47:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C744C433D2;
        Mon, 24 Apr 2023 15:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682351269;
        bh=tCNIk5EDB2upDajNictvyCPC5TncgFO7t/ssn/aQVR0=;
        h=From:To:Cc:Subject:Date:From;
        b=emyPd+T6jWaVtz7Nn4UrOWuN3wX/WlFE10Ocq/or1/0rNuE0ioCCdyNz/s/UdrlV0
         NX+oXKTp/c4io2xqZ6PyG1E0VzhLrXNfSgVzx0b4vcIXohibFAs0VwgswATN8zksEv
         dADvi9pVSN3ZEt0xCNJwDxq//yJ2pVRsc2Bcw1LmNas23I3hMf9w4tJ2/2Y/rohmN+
         4XXJQDEndsOOvopOWxFtgaplwLxFLdv70occ7jBIM2GD94qhpuOHTkBrQVCUlF4web
         rF8rPTpqt/x50HiMIh/Cdw1rezPdak6jfFjUAbGdSt2owhSo5duvTM+pUrls/cPshG
         cAF8uagK5ms7w==
From:   broonie@kernel.org
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Long Li <longli@microsoft.com>, Wei Liu <wei.liu@kernel.org>
Subject: linux-next: manual merge of the sysctl tree with the hyperv tree
Date:   Mon, 24 Apr 2023 16:47:42 +0100
Message-Id: <20230424154742.131094-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
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

Today's linux-next merge of the sysctl tree got a conflict in:

  drivers/hv/vmbus_drv.c

between commit:

  9c318a1d9b500 ("Drivers: hv: move panic report code from vmbus to hv early init code")

from the hyperv tree and commit:

  525f23fe58b59 ("hv: simplify sysctl registration")

from the sysctl tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc drivers/hv/vmbus_drv.c
index 1c65a6dfb9fae,229353f1e9c29..0000000000000
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
