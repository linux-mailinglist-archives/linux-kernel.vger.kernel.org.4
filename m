Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3A76CD76F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 12:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbjC2KNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 06:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjC2KNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 06:13:21 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D844C2D5E;
        Wed, 29 Mar 2023 03:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680084799; x=1711620799;
  h=from:to:cc:subject:date:message-id;
  bh=jtzfWNpg8V71nZT+AF+a7PC+PUuPnz6DFGkaJlc3Oc4=;
  b=BipglQFkFoPVEqaVdPxuEt4117GwyQWH7m255Ijqe3bUAttYZnYT3maL
   oxcKO2O4izxZ5ArrBruvpi0O/1mVp1BRsCKY5NgBcdaHijqH1RkOa0S+k
   b9Hb/UiNoG1FhFdf8HRUdbuzEo5aUviL0mVKqIDy+4YOEAW4qQfaFCz9/
   TuTD4LGZAvfcx/K/tnPtGU6RI8nM5PnGy3/xq9lsEcDkO531qiyvEoXIX
   R28CpZ6BeRP3Wa4WMLk0WZgGHktQN7vGpPzcE/zduSEgXkW1CCC6v3baD
   lcGb+tcxh/qmGRbG/e59i/LQKM8IO+3M+sA8kp0yupOGDVx4YVWgi6ndA
   w==;
X-IronPort-AV: E=Sophos;i="5.98,300,1673884800"; 
   d="scan'208";a="226595765"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Mar 2023 18:13:18 +0800
IronPort-SDR: cpqZ8qXgT+oZmfK7N5tpyFI9tBisK0Sghv6JcosEwQCzzfPNAAGzfFYListmOokL+bgH+OQHl7
 uO5TAR4gBjRuqIB3aypQXKLhNOB/bUbuR7+lfNe2i26u7XtZ+lAJI1u+J1MGVcXy6+HpUQkvA7
 iNDVD4VxVZtRV4kUz8V5iHHOZqr76zuvwaSlf1HmEsHxUtff/p38M6ZL9woiC2JQGEGLhxEUn0
 eVrRvKyNyXTsTPyRcui8R8soke0RUWi3VhezOgDGJC2OP8y5Z8omJlVzZ/EMGLn6dccKRIKeth
 XF8=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 02:23:47 -0700
IronPort-SDR: z0rBdREVaLI9B0r5EaKTr1Gzc29yFugofpD/rTDUuQ3IYp2pBY7Qos6xbp/fI5DPe4nTG2V0UF
 Ekm1+luJjWUtqdsg+TE1+afxIUniKafAnolD8srN4KJcApR87GNOJU6KbnJTxJd7wXd06KA5fN
 Da09/WSjYTwE6n2LSnKvkmbIDYXSb8uxnAMAu5QakxuGlXq7C0b9jxGFUXaa+BHScHc+Y984Y9
 tljhsCFRrNtBplIelRP3dGQWwhvFdWemCPo78Wf2BpKejSUme7Fkhw9BRqSffvoidLJbQAzRtU
 4Qs=
WDCIronportException: Internal
Received: from bxygm33.ad.shared ([10.45.30.255])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Mar 2023 03:13:17 -0700
From:   Avri Altman <avri.altman@wdc.com>
To:     "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Asutosh Das <quic_asutoshd@quicinc.com>, quic_cang@quicinc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Avri Altman <avri.altman@wdc.com>
Subject: [PATCH 0/2] scsi: ufs: mcq: 2 minor cleanups
Date:   Wed, 29 Mar 2023 13:13:01 +0300
Message-Id: <20230329101303.18377-1-avri.altman@wdc.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2 (untested) minor mcq cleanups.

Avri Altman (2):
  scsi: ufs: mcq: Annotate ufshcd_inc_sq_tail appropriately
  scsi: ufs: mcq: Use pointer arithmetic in send_command

 drivers/ufs/core/ufshcd-priv.h | 1 +
 drivers/ufs/core/ufshcd.c      | 5 +++--
 include/ufs/ufshcd.h           | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

-- 
2.17.1

