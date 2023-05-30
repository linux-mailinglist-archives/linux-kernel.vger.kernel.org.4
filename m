Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE0E716A76
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 19:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232683AbjE3RKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 13:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233319AbjE3RKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 13:10:02 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B778A3;
        Tue, 30 May 2023 10:10:01 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1685466599;
        bh=MdGzytOBlrA450u5qkdA+EwlKm7siSNLZdo8yfMwVgs=;
        h=From:Subject:Date:To:Cc:From;
        b=nj7C6UJdy9v2jMv6cDZtctP/TetrcmMwu0eEZfyf7C6OTU6TkSOhHBFGCo7aUWDtV
         Afb6J5JuIBlnM/LkpoeGuzmKWkzZaVL8zQoQhYDyV4PobHjSJBimwGQMUF7hVirgto
         aUzRcdvQEJ5yHZukO0X78JaIP+lmyV0to5T/W8c4=
Subject: [PATCH v3 0/4] block: constify some structures of
 partitions/core.c
Date:   Tue, 30 May 2023 19:09:56 +0200
Message-Id: <20230419-const-partition-v3-0-4e14e48be367@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOQtdmQC/4WNTQ7CIBhEr9KwFsOPpejKexgXQEFIGtrwUdQ0v
 bu0W2NczmTmvQWBTcECujQLSrYECGOsgR8aZLyKD4tDXzNihHFyomdsxggZTyrlkOsWKyL02XV
 CM8dRfWkFFuukovH1F+dhqOWUrAuvXXO71+wD5DG9d2uhW/tbUCgmmPVCONZLLjt+fdoAAMbP/
 hhtRhuwsD8QViGSdrqVTramp1+QdV0/1dJwbw0BAAA=
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        kernel test robot <lkp@intel.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685466599; l=1035;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=MdGzytOBlrA450u5qkdA+EwlKm7siSNLZdo8yfMwVgs=;
 b=6FUiBBPn0ScUemC8H1ckhBS6fF0lUoiFCsvPufAA+ksizM25Syocc+8avthCKgxlZnzBqnRqK
 t+I37LKcGwRC0J4eTP6MNatRVjKXFTIie/gmZViuL0TXR6XOXWiYenS
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few structures containing function pointers that could and should be
const are not. Change that.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v3:
- Rebase on for-6.5/block
- Link to v2: https://lore.kernel.org/r/20230419-const-partition-v2-0-817b58f85cd1@weissschuh.net

Changes in v2:
- Use correct syntax for const array of function pointers.
  Reported by LKP bot.
- Link to v1: https://lore.kernel.org/r/20230419-const-partition-v1-0-2d66f2d83873@weissschuh.net

---
Thomas Weißschuh (4):
      block: constify partition prober array
      block: constify struct part_type part_type
      block: constify struct part_attr_group
      block: constify the whole_disk device_attribute

 block/partitions/core.c | 8 ++++----
 include/linux/blkdev.h  | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)
---
base-commit: 403b6fb8dac1e9407c04652cedd92285c5ae9aa5
change-id: 20230419-const-partition-a06b9f76b2f3

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

