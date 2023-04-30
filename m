Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73DE86F2A0E
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 19:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjD3Rso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 13:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjD3Rsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 13:48:42 -0400
Received: from mx.kolabnow.com (mx.kolabnow.com [212.103.80.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAC21992
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 10:48:39 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mx.kolabnow.com (Postfix) with ESMTP id 0AF9AB08;
        Sun, 30 Apr 2023 19:48:38 +0200 (CEST)
Authentication-Results: ext-mx-out001.mykolab.com (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=kolabnow.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:organization:mime-version:message-id
        :date:date:subject:subject:from:from:received:received:received;
         s=dkim20160331; t=1682876915; x=1684691316; bh=EHLcpJTNtFt8vUWv
        08Q6/5mnvqJ8p7cMapUG1WuvaeA=; b=oRHemrAX7j0/GaMJlUSBfn2y8t++gtc7
        faGL/QvR/B8ApV7dE7DMCyrS9ZoCwjGKh8KlfRC1JW0biQIapJN2WaOcZpZ3ch/E
        uDZSJu8kYk2WAdYUkxOCwG345V5AoZlDnGNlZkJOwSvEhOZPPXChNd8WgZpJ49cc
        yLuNvjgEkC84RheRDag8SAt4FSH+39GX2RlWz9eVJQjC3rjzy+QO1p5uGdE21mmz
        TJp26u4/sN/94CghP51BJ8egVYLKyCbzzTBX8ltqv45SjJ8ZtLL49fo62+sPfU9/
        JuaY4WfAaHx862O/ptmGg7mSSwdbkg94QY0F2yFSEWF4DBhg6j4Kb9psMSIS0iJY
        5ncZZihNDbT8+AmV5Nm6qR+85x9tVaDJc9Cb13mO2RfCXPYVIjWUWQgukffgToBF
        c2QTYJEd8Ny8ijGHARe+jOrTlXKywwAp+u7Ncf01n3UuB1hD5X9w+nr+N6PNbYy2
        rI6H3peMfnAIWvAil1mHBAjqpyfEaewvUmUDjHvkXs+nH3ARFy5m8+vTi9C5vH/q
        Rey4g3QvtjVU6NO5WZiuqlQSMIBI1OrKQhWgYjWcCzNLA4dgHHqOZjCOoADMYEDU
        /4/U172shSK/0VHU+Kw9une+AHzHj5vAgNL9kXXpfAjfCBl3dDglB/nRtmOAOEOB
        /adp94PSqO4=
X-Virus-Scanned: amavisd-new at mykolab.com
X-Spam-Score: -1.9
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cGH0DutYg7U6; Sun, 30 Apr 2023 19:48:35 +0200 (CEST)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by mx.kolabnow.com (Postfix) with ESMTPS id 5D312AFA;
        Sun, 30 Apr 2023 19:48:33 +0200 (CEST)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id AF04E4014;
        Sun, 30 Apr 2023 19:48:32 +0200 (CEST)
From:   alison@she-devel.com
To:     johan@kernel.org
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org, alison@she-devel.com,
        achaiken@aurora.tech, kernel test robot <lkp@intel.com>
Subject: [PATCH v2 0/2] support config of U-Blox Zed-F9P GNSS
Date:   Sun, 30 Apr 2023 10:48:18 -0700
Message-Id: <20230430174820.748119-1-alison@she-devel.com>
MIME-Version: 1.0
Organization: Aurora Innovation
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alison Chaiken <alison@she-devel.com>

Add generalized support for setting arbitrary configuration of the
U-Blox Zed-F9P GNSS.  Employ the new functionality to set the baud rate
of the Zed-F9P if the devicetree specifies a non-default value.

Tested with 6.1.22, only on a U-Blox Zed-F9P GNSS.

V1 -> V2 Fixes error identified by kernel test robot:
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202304300819.u0hfUj33-lkp@intel.com/

Alison Chaiken (2):
  gnss: ubx: customize serial device open to set U-Blox Zed-F9P baud
  dt-bindings: gnss: Add U-Blox Zed-F9

 .../bindings/gnss/u-blox,neo-6m.yaml          |   1 +
 drivers/gnss/ubx.c                            | 195 ++++++++++++++++++
 2 files changed, 196 insertions(+)


base-commit: 825a0714d2b3883d4f8ff64f6933fb73ee3f1834
-- 
2.39.2

