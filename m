Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6550E74149B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 17:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbjF1PKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 11:10:11 -0400
Received: from mx.kolabnow.com ([212.103.80.153]:16646 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231200AbjF1PKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:10:07 -0400
Received: from localhost (unknown [127.0.0.1])
        by mx.kolabnow.com (Postfix) with ESMTP id BD3A01507;
        Wed, 28 Jun 2023 17:10:05 +0200 (CEST)
Authentication-Results: ext-mx-out001.mykolab.com (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=kolabnow.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:mime-version:message-id:date:date
        :subject:subject:from:from:received:received:received; s=
        dkim20160331; t=1687965003; x=1689779404; bh=h4ahYP33d2p2uwjetro
        Ov3PU/MUKWiTuDotZ45ehQFk=; b=sO9bn2YoyvPU65FCXgW9wZRMClV3Nj8HNKp
        U06azC7tLSfm63hVNaJ8sOAVz+8Qonducv4TzjnOaYNQnrZrQZzTMgPMcKukM/Oo
        0RamdVOPLU/ByaOY5MCWF0KMdTvjYB16Qh3FnWLL4FuWuoFFMqwFS0F231pRV79n
        MDFA9HlMqAuRWEnsGYmDQBfHfRbslNij/xG4mGjqkqMVSZLBE619KVJKTZkQ0cr0
        AmQ6msGFBEm4hfzBqHazeXngO3dRnn+ei77LLu6/F28OFq7LTHfMp/Pv0Bv8/Uwh
        oTYHRIbLSyEk2A4ckIPMoKQFn+NKPNqE2S83Q13lh7hNgj9xEDLwG4D2/6CQ6D5s
        62w19V1uXL02IhoDFK+lGoLS+xBZugmNv0nn+7Iv9plJS5NG3jLf/eKCyYcpCx0J
        cfoGEtejzv1m1pV9wYnR/2+eVLrwm7cemaY3e7YBNIYP1vMBw9vaV+SDml1mhBE1
        ssW7w1VK03j/uIMxaMt7mpZEmnMvuOMy/BOgxRBehFSAeDtPTbfk4dA0Ssl2xOrW
        jWczFdkLXqCJQdaiQtrI0v6hoBV8otr8vKXufokYhi92WGulfeYzOZmNFjLqZtg4
        Yka0Jz1I0olJhxPOS8vRDWXQCjkGlTw0MZ3wfVVu1/JuBRWTURjKByuTguPB4N5T
        ydFM9NCc=
X-Virus-Scanned: amavisd-new at mykolab.com
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 tagged_above=-10 required=4
        tests=[BAYES_00=-1.9] autolearn=no autolearn_force=no
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 54oBje1Govza; Wed, 28 Jun 2023 17:10:03 +0200 (CEST)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by mx.kolabnow.com (Postfix) with ESMTPS id 7BE82607;
        Wed, 28 Jun 2023 17:10:02 +0200 (CEST)
Received: from ext-subm003.mykolab.com (unknown [10.9.6.3])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id AD56934CA;
        Wed, 28 Jun 2023 17:10:01 +0200 (CEST)
From:   alison@she-devel.com
To:     johan@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alison@she-devel.com,
        achaiken@aurora.tech
Subject: [PATCH v8 0/2] support config of U-Blox Zed-F9 GNSS
Date:   Wed, 28 Jun 2023 08:09:46 -0700
Message-Id: <20230628150948.908273-1-alison@she-devel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alison Chaiken <alison@she-devel.com>

Add generalized support for setting arbitrary configuration of the
U-Blox Zed-F9P GNSS.  Employ the new functionality to set the baud rate
of the Zed-F9P if the devicetree specifies a non-default value.

Tested with 6.1.22 on U-Blox Zed-F9P GNSS devices.

V7 -> V8 Rebased on v6.4.
V6 -> V7 Fixed tag and version.
V5 -> V6 Change #ifdef to _maybe_unused and fix warnings.
V4 -> V5 Wrap all new code in a CONFIG_OF=y check and fixes
V3 -> V4 Lookup device-specific properties by matching driver data.
V2 -> V3 Add email recipients whom I foolishly missed the first two times.
V1 -> V2 Fixes error identified by kernel test robot:

Alison Chaiken (2):
  gnss: ubx: customize serial device open to set U-Blox Zed-F9P baud
  dt-bindings: gnss: Add U-Blox Zed-F9

 .../bindings/gnss/u-blox,neo-6m.yaml          |   1 +
 drivers/gnss/ubx.c                            | 243 +++++++++++++++++-
 2 files changed, 233 insertions(+), 11 deletions(-)


base-commit: 6995e2de6891c724bfeb2db33d7b87775f913ad1
-- 
2.40.1

