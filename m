Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28C373D16A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 16:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjFYOV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 10:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbjFYOVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 10:21:45 -0400
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EE8E4E;
        Sun, 25 Jun 2023 07:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1687702905; x=1719238905;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Z0bWCCK3xYF6EpWbniz5Yge0ki9KXt6nvRJYKV/3Rq4=;
  b=iaRxI7XeSdnjdK5umwNZRIoEaIEo4k0nTV0xdKjjVETmEbv1FwjTJg2+
   di87iTDby8DL2uydTbb/JuR6fW/HJVa+BLcCmOBhBdWNNhhQ+g55wjhSo
   UwHuPsJmHaGJ9RMd+S9HGS85/kh+ikWNkeqwotyUYDStprvwBrbChsmRc
   U=;
X-IronPort-AV: E=Sophos;i="6.01,157,1684800000"; 
   d="scan'208";a="292748461"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-f253a3a3.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2023 14:21:39 +0000
Received: from EX19D018EUA004.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2b-m6i4x-f253a3a3.us-west-2.amazon.com (Postfix) with ESMTPS id 89260806BE;
        Sun, 25 Jun 2023 14:21:36 +0000 (UTC)
Received: from EX19D037EUB003.ant.amazon.com (10.252.61.119) by
 EX19D018EUA004.ant.amazon.com (10.252.50.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Sun, 25 Jun 2023 14:21:34 +0000
Received: from EX19MTAUEB001.ant.amazon.com (10.252.135.35) by
 EX19D037EUB003.ant.amazon.com (10.252.61.119) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sun, 25 Jun 2023 14:21:34 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by mail-relay.amazon.com (10.252.135.35) with Microsoft SMTP
 Server id 15.2.1118.26 via Frontend Transport; Sun, 25 Jun 2023 14:21:34
 +0000
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
        id 0F7554AF4; Sun, 25 Jun 2023 14:21:34 +0000 (UTC)
From:   Eliav Farber <farbere@amazon.com>
To:     <giometti@enneenne.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <farbere@amazon.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ronenk@amazon.com>, <talel@amazon.com>, <hhhawa@amazon.com>,
        <jonnyc@amazon.com>, <itamark@amazon.com>, <shellykz@amazon.com>,
        <amitlavi@amazon.com>, <almogbs@amazon.com>
Subject: [PATCH 0/5] Add PPS pulse-width support
Date:   Sun, 25 Jun 2023 14:21:29 +0000
Message-ID: <20230625142134.33690-1-farbere@amazon.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of five patches adds pulse-width calculation support to the
pps core (patch 1)
It then enables pulse-width calculation for the pps-gpio driver (patches
2 - 5).

*) Pulse-width in measured in nano seconds.
*) Width time can be calculated for both assert-time and reset-time.
*) New sysfs were added to expose the pulse-width.
*) Support was added to pps-gpio driver to enable capture-clear based on
   device-tree. 
*) Enabling pulse-width calculation for pps-gpio driver is done based on
   new boolean device-tree properties.

Eliav Farber (5):
  pps: add pulse-width calculation in nsec
  dt-bindings: pps: pps-gpio: introduce capture-clear property
  pps: clients: gpio: add option to set capture-clear from device-tree
  dt-bindings: pps: pps-gpio: introduce pulse-width properties
  pps: clients: gpio: enable pps pulse-width calculations based on
    device-tree

 .../devicetree/bindings/pps/pps-gpio.txt      | 10 ++++
 drivers/pps/clients/pps-gpio.c                | 15 ++++++
 drivers/pps/kapi.c                            | 49 +++++++++++++++++++
 drivers/pps/pps.c                             |  9 ++++
 drivers/pps/sysfs.c                           | 30 ++++++++++++
 include/linux/pps_kernel.h                    |  3 ++
 include/uapi/linux/pps.h                      | 19 +++++++
 7 files changed, 135 insertions(+)

-- 
2.40.1

