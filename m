Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00C7737BAC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 09:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjFUGuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 02:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjFUGte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 02:49:34 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D0F2735
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 23:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687330044; x=1718866044;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=d3xuT8j8LOYHVkbndEK2xBaA4wAzaQvUC0MqemTUsOI=;
  b=IbVr1nnOLsnT/YS4eSNedDexVF5yBy8X3t/awVQtQ102aiYQH6cP6ZEN
   C3d9P3gaCOoaTN4zz0ecJ/i+nOhvUfoouFbVdK6KlW1gd0nYq13GqbDya
   PKp3uNUD7ALC0GSkPSnms/EQZ9oHYNeCMaXjsQc61pkbkB2LPBa8lHmvH
   YJuZd6Y6zwgKjdY55nt/00LFYjcpiObWId/10G8FZc9VMIwwBujtC5YXQ
   m+MteaO4XUgy79zSEaB9DYKx4jR/UF092tIpHlxFANr8a3owxGBry0qdt
   +X5/Fh9PK14MsCD7JvuQ6WbJgi0QdlHBr9v9g9RA+nBKPHy5k9bZK5SfY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="389511902"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="scan'208";a="389511902"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 23:47:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="779728074"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="scan'208";a="779728074"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.90])
  by fmsmga008.fm.intel.com with ESMTP; 20 Jun 2023 23:47:17 -0700
From:   tien.sung.ang@intel.com
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Ang Tien Sung <tien.sung.ang@intel.com>
Subject: [PATCH v2 0/2] firmware: stratix10-svc: support N clients
Date:   Wed, 21 Jun 2023 14:46:43 +0800
Message-Id: <20230621064645.1431883-1-tien.sung.ang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ang Tien Sung <tien.sung.ang@intel.com>

hi,
In order to support N clients sending concurrent messages to svc driver,
we need to have all clients owning up to their individual threads.
And, to cater for the limitation of the mailbox device driver in
secure monitor firmware that only permits a single message at a time,
a mutex is used to prevent the multiple clients from sending a message
to SDM.
Also, added a fix on the removal of the driver that resulted in a
kernel panic due to badly used drv_set_drvdata.

changelog from V1:
- Added "Fixes:" tag to the 2nd patch to detail the fix location.

changelog from V2:
- Remove newline from the 2nd patch after the tag "Fixes:"

Ang Tien Sung (2):
  firmware: stratix10-svc: Support up to N SVC clients
  firmware: stratix10-svc: fix bug in saving controller data

 drivers/firmware/stratix10-svc.c | 188 ++++++++++++++++++++-----------
 1 file changed, 123 insertions(+), 65 deletions(-)

-- 
2.25.1

