Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D673729C92
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 16:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240874AbjFIOST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 10:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239945AbjFIOSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:18:17 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93AAC30E8;
        Fri,  9 Jun 2023 07:18:15 -0700 (PDT)
X-GND-Sasl: alexis.lothore@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686320294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=D2uEsskSUg+j6aq0sQrlpHtD/hpOAW9BxWuP9HH1liI=;
        b=JCdwn7TD0a/t0fnixwNJTiDeBlVExLdg59tddQNqPTwfySgsv15q/koXTWwSuBzS8JfbF3
        VxmKMrn80h57xj4rDcVGehCOWE0rxxQElGoQPC1N2X1VUNSd4sTkba9u0gKPpy5HLkDDDi
        aio1fyeQEqEdsYI72ADPR4UvlWIMVtCjgMvsoFrYXR1eWwhvjvAgrQvPCHiC9yo9jd4lLL
        1pk63J9RJEegk4mBrgXTl9f4adzgcu8k890n3WZceVUn6vPX/mWSwKlqe/YWsyI+6adC6p
        BD++u4/f2c1JNDjnY4miy41ml/oeSGPOg2EHnTIrLMW+/1xzhGhTPWGEr/QL0g==
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7819920013;
        Fri,  9 Jun 2023 14:18:12 +0000 (UTC)
From:   alexis.lothore@bootlin.com
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        paul.arola@telus.com, scott.roberts@telus.com
Subject: [PATCH net-next 0/2] add egress rate limit offload for Marvell 6393X family
Date:   Fri,  9 Jun 2023 16:18:10 +0200
Message-ID: <20230609141812.297521-1-alexis.lothore@bootlin.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexis Lothoré <alexis.lothore@bootlin.com>

This series aims to give access to egress rate shaping offloading available
on Marvell 88E6393X family (88E6393X/88E6193X/88E6191X/88E6361)

The switch offers a very basic egress rate limiter: rate can be configured
from 64kbps up to 10gbps depending on the model, with some specific
increments depending on the targeted rate, and is "burstless".

Since available controls are quite limited, this series proposes to provide
controls to userspace through a TBF qdisc. Since hardware features do no
completely matches what TBF qidsc expects, some passed parameters (burst,
latency) are simply ignored

- 1st commit allows mv88e6xxx driver to attach the port_setup_tc callback
  in dsa_switch_opts and to dispatch it to any switch implementing it
- 2nd commit add tbf configuration for 88E6393X family

Alexis Lothoré (2):
  net: dsa: mv88e6xxx: allow driver to hook TC callback
  net: dsa: mv88e6xxx: implement egress tbf qdisc for 6393x family

 drivers/net/dsa/mv88e6xxx/chip.c |  18 ++++++
 drivers/net/dsa/mv88e6xxx/chip.h |   3 +-
 drivers/net/dsa/mv88e6xxx/port.c | 104 +++++++++++++++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/port.h |  17 ++++-
 4 files changed, 139 insertions(+), 3 deletions(-)

-- 
2.41.0

