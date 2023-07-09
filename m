Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C208674C85E
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 23:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjGIVSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 17:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGIVSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 17:18:06 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E1511B;
        Sun,  9 Jul 2023 14:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1688937482;
        bh=No8xXIKam1ZdBL258zzIwMmAiWCgXDsDDSVQxysmNX0=;
        h=From:Subject:Date:To:Cc:From;
        b=O2A5I6f2wRamvOLu2hvMMPuKyHTQ8FNh/CW+2mxmbU4JvXyYtg52hy5zKQEc5t4xJ
         txFwLQQPCEnZDFk/INTT5eHpv7/vVZnXyw1LuQIh3OIrO/aoRIBTAoihCN9Uh6i/JG
         A3T+6yVEh3hdIErDC+t+A6NKdY5PsGZT2flM2dWI=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v2 0/3] dyndbg: add source file name to prefix
Date:   Sun, 09 Jul 2023 23:17:57 +0200
Message-Id: <20230709-dyndbg-filename-v2-0-fd83beef0925@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAUkq2QC/3WNyw6CMBAAf4X0bE27YARP/ofh0MdCN8FiuoASw
 r9buXucSSazCcZEyOJWbCLhQkxjzACnQrhgYo+SfGYBCkADlNKv0dtedjRgNE+UClDV18YbrKz
 IlTWM0iYTXchdnIchy1fCjj7H5tFmDsTTmNbjuuif/T9YtFTS2a6+VKVSjdH3NxIzuzCHc8RJt
 Pu+fwF6OXq/yAAAAA==
To:     Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1688937480; l=1116;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=No8xXIKam1ZdBL258zzIwMmAiWCgXDsDDSVQxysmNX0=;
 b=UQKSy2QcmBDcMOt15jIfaOgs/ujS8NzocTchVsGuNvvvn1SR8oRrM2o814pvUMPG8h8JTn8GE
 cJ7HBcfPMm6CnmA2USTy9mZurgdI0ufPlfk+11gXQ3veJoJRODkH3DQ
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently dyndbg has no facility to print the source file name of a
debug statement.
Without the source file the line number is of limited use.
Also the dyndbg control file uses the filename as the primary index, so
having it in the logmessage makes the relation clearer.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v2:
- Apply Acks from Jason and Jim
- Add Greg and Luis to recipients to pick up the patches
- Link to v1: https://lore.kernel.org/r/20221223-dyndbg-filename-v1-0-cbf8543009a1@weissschuh.net

---
Thomas Weißschuh (3):
      dyndbg: constify opt_array
      dyndbg: increase PREFIX_SIZE to 128
      dyndbg: add source filename to prefix

 Documentation/admin-guide/dynamic-debug-howto.rst | 5 +++--
 include/linux/dynamic_debug.h                     | 4 +++-
 lib/dynamic_debug.c                               | 8 ++++++--
 3 files changed, 12 insertions(+), 5 deletions(-)
---
base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
change-id: 20221223-dyndbg-filename-02e0879dae4b

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

