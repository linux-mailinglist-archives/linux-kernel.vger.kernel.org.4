Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E73613B35
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 17:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbiJaQZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 12:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbiJaQZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 12:25:32 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3150610549;
        Mon, 31 Oct 2022 09:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667233531; x=1698769531;
  h=from:to:cc:subject:date:message-id;
  bh=8ZkqY2fkQzp7wMp62ktaXg2E2J6EJ0M2jxbxpAiqLwU=;
  b=Cf3zsKkJHjkbifoy+toj6OTviE/YoMV6rRjrE+8iPi2HCBsutWWewCJ+
   C/VtSiiFapSGJynkHswrL3r6zJOgWdDeZuDsfbMlVGnlAU/Oo3zMJTs9G
   FktuROENto+mYNTmRUJkS1a7kSZqq0+fIjmnx6M4zOeIg5ULXsH9WQ8Lo
   eEqMeZA8BT4MM9GbTTuTwgEke/INavT2kS4ZVHcV3xUWR2cl4QmzPSPO/
   stNYh1UtVtPZ2diftHrMC8oQ8H55ekLaMoTGv9unb7s7PDpYDk87Tws4E
   xJWPVKSR0QveiJroh5ouM9JJvfj3qHJGpxP3CDd0G3Juv57g5hVaHz/G4
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,228,1661788800"; 
   d="scan'208";a="215149684"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 01 Nov 2022 00:25:30 +0800
IronPort-SDR: De11Si936dnF+6Gupziir88gJO7WdQTuP4+70VV4hqMZgdKMp4SDNqSwgvBznJKLzPqag7mw0f
 TOuXMTBOyjnCjw+R/YbI0r9gFxLkCLUYGpZVMc5wd55avWiOxdvjYe0CDnmXqTjVrI4oC6RMHO
 KCGCSAIo9zuB24Ezn3Uw5+fMqNiUrRgF9dBjpEw1YbAS/bmcQJGp52f5M1MSVKXMmHpjvVVHaG
 cbIAxAimlOD5B7LguLwaaTD2DhfmBFD21jV7ysD4Z2yjLpyxeZwSFVWNc3ADKT0jlH5mNpDdHE
 A4QPW/vFlICyD1+1pIb/HHXI
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Oct 2022 08:44:45 -0700
IronPort-SDR: Fc8Rsal29PfocnsngXPozZTra2FILDVFI/ElPYdMpSdsUh52nSvfu3O0j8PWYY83Ar+69NIlyu
 aLw2zzkcqS+iXqaQxyYp/lkhm446jFUX7Pa6rDRwoVWPcU1B/0rfZ9wfTiFaYvaZlaN5eKcZQI
 z1Z3M3Jw3Oqfa06deNZfScaf6m9X/QcwJDwxLGLrdjgpCSn+CpRQs7dYAXFJDqbrepzMCBLLOv
 kkZnQS+Qj4/44Pgcx8IVKZyPfrCus6WTP+3pAOu26WLr+jhmFjJqRLaN8kVE+pSEmEuXNX3exc
 nMQ=
WDCIronportException: Internal
Received: from ilb001078.ad.shared (HELO ilb001078.sdcorp.global.sandisk.com) ([10.45.31.219])
  by uls-op-cesaip02.wdc.com with ESMTP; 31 Oct 2022 09:25:27 -0700
From:   Arthur Simchaev <Arthur.Simchaev@wdc.com>
To:     martin.petersen@oracle.com
Cc:     avri.altman@wdc.com, Avi.Shchislowski@wdc.com, beanhuo@micron.com,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>
Subject: [PATCH 0/4] ufs: core: Always read the descriptors with max length
Date:   Mon, 31 Oct 2022 18:25:20 +0200
Message-Id: <1667233524-13715-1-git-send-email-Arthur.Simchaev@wdc.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Read any descriptor with a maximum size of QUERY_DESC_MAX_SIZE.
According to the spec the device rerurns the actual size.
Thus can improve code readability and save CPU cycles.
While at it, cleanup few leftovers around the descriptor size parameter.

Suggested-by: Bean Huo <beanhuo@micron.com>

Arthur Simchaev (4):
  ufs:core: Remove redundant wb check
  ufs:core: Remove redundant desc_size variable from hba
  ufs: core: Remove len parameter from ufshcd_set_active_icc_lvl
  ufs: core: Remove ufshcd_map_desc_id_to_length function

 drivers/ufs/core/ufs_bsg.c     |   7 +--
 drivers/ufs/core/ufshcd-priv.h |   3 --
 drivers/ufs/core/ufshcd.c      | 100 ++++++++++-------------------------------
 drivers/ufs/core/ufshpb.c      |   5 +--
 include/ufs/ufshcd.h           |   1 -
 5 files changed, 26 insertions(+), 90 deletions(-)

-- 
2.7.4

