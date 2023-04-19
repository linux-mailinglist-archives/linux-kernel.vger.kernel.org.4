Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042646E7D02
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 16:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbjDSOkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 10:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233370AbjDSOkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 10:40:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1DA448F;
        Wed, 19 Apr 2023 07:39:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3916636B2;
        Wed, 19 Apr 2023 14:39:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CA39C433EF;
        Wed, 19 Apr 2023 14:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681915197;
        bh=A+KTO1CpnowqeS9xSSmESo3/GmHQhE1tcZVW5UKDGIk=;
        h=From:To:Cc:Subject:Date:From;
        b=adKKWfSRBITSE5x1nqQyJjRcjTGLk6cMvnU9VryUF1J0hXRQ1f++ljGg2aFNE67H6
         3FI5hJaxb0Y49qFeZizMhY6Y5xu0be2XBH53YTrw7qHofI7JRJ3ZQ0vCJ5U/cGU2rL
         Bep8vBZWLM5/rLUEVqVdr9hOfRZnd/GHd6R8RH7HupIR3OOrk0NBM1N+nSF8YzEs6p
         HdydVSemXVGqdApyq6kXLPPxqGDs2NzoJq6NQn7njC6gc286qp2bwxrByJZol5AfF/
         wvToWp+y9Wxzt2MPOIMUdiMmDvpFs6y8Ta/DtojTEyM4PXEiUPaep6uHRWuYXPaKRW
         w57nNwWJAqT/g==
From:   broonie@kernel.org
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: linux-next: manual merge of the block tree with the origin tree
Date:   Wed, 19 Apr 2023 15:39:53 +0100
Message-Id: <20230419143953.88507-1-broonie@kernel.org>
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

Today's linux-next merge of the block tree got a conflict in:

  drivers/block/ublk_drv.c

between commit:

  8c68ae3b22fa6 ("ublk: read any SQE values upfront")

from the origin tree and commit:

  2d786e66c9662 ("block: ublk: switch to ioctl command encoding")

from the block tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc drivers/block/ublk_drv.c
index 604c1a13c76ef,f554ebf735804..0000000000000
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@@ -1261,10 -1259,22 +1259,23 @@@ static void ublk_handle_need_get_data(s
  	ublk_queue_cmd(ubq, req);
  }
  
+ static inline int ublk_check_cmd_op(u32 cmd_op)
+ {
+ 	u32 ioc_type = _IOC_TYPE(cmd_op);
+ 
+ 	if (IS_ENABLED(CONFIG_BLKDEV_UBLK_LEGACY_OPCODES) && ioc_type != 'u')
+ 		return -EOPNOTSUPP;
+ 
+ 	if (ioc_type != 'u' && ioc_type != 0)
+ 		return -EOPNOTSUPP;
+ 
+ 	return 0;
+ }
+ 
 -static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 +static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 +			       unsigned int issue_flags,
 +			       struct ublksrv_io_cmd *ub_cmd)
  {
 -	struct ublksrv_io_cmd *ub_cmd = (struct ublksrv_io_cmd *)cmd->cmd;
  	struct ublk_device *ub = cmd->file->private_data;
  	struct ublk_queue *ubq;
  	struct ublk_io *io;
