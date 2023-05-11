Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42EC96FF7F5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 19:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238801AbjEKRCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 13:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238752AbjEKRB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 13:01:57 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909D930EB;
        Thu, 11 May 2023 10:01:49 -0700 (PDT)
Received: (Authenticated sender: alexis.lothore@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 18699240010;
        Thu, 11 May 2023 17:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1683824507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=jsupyfCxIr/oLjFxtWs1d7TDSB1BeVIZRiI5538cfpI=;
        b=OuolYvJXgYwrYy7iiiqUOn5GZae3MqufNnBo0utOyp5iFFFZvLgr4rmgPPPk0NwjFRVg6S
        HuOIKSuWv/+5N1cLHz1GDl/dTc9PZ6AaZsOeZ2aA5EiTQbxqqQOenuTuPOmni+oqdP5bl7
        fXdtIOZBYTzgYzg9T3lLkZtVtE57WDLPkvgllw4LKf/P7WaV2yrjClWd+W/IYNOJ6ixwq7
        65f8mGedn9jZrbZ1GnPHmjGVgIAogLMteYdn4oiO2coHg4mt3pb3j5a7r30Ax9elGG7KHU
        BTr4sReh+s/b9wZZHXkYmtTvRjAoYaLGeu8U6avW4iQmLFWgJDUc4Sol9R1rVQ==
From:   alexis.lothore@bootlin.com
To:     andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        herve.codina@bootlin.com, miquel.raynal@bootlin.com,
        milan.stevanovic@se.com, jimmy.lalande@se.com,
        pascal.eberhard@se.com
Subject: [PATCH net v2 0/3] net: dsa: rzn1-a5psw: disabled learning for standalone ports and fix STP support
Date:   Thu, 11 May 2023 19:01:59 +0200
Message-Id: <20230511170202.742087-1-alexis.lothore@bootlin.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexis Lothoré <alexis.lothore@bootlin.com>

This small series fixes STP support and while adding a new function to
enable/disable learning, use that to disable learning on standalone ports
at switch setup as reported by Vladimir Oltean.

This series was initially submitted on net-next by Clement Leger, but some
professional evolutions has made him hand me over those topics.
Also, this new revision is submitted on net instead of net-next for V1
based on Vladimir Oltean's suggestion

Changes since v1:
- fix typos in commit messages and doc
- re-split STP states handling commit
- add Fixes: tag and new Signed-off-by
- submit series as fix on net instead of net-next
- split learning and blocking setting functions
- remove unused define A5PSW_PORT_ENA_TX_SHIFT
- add boolean for tx/rx enabled for clarity

Clément Léger (3):
  net: dsa: rzn1-a5psw: enable management frames for CPU port
  net: dsa: rzn1-a5psw: fix STP states handling
  net: dsa: rzn1-a5psw: disable learning for standalone ports

 drivers/net/dsa/rzn1_a5psw.c | 83 ++++++++++++++++++++++++++++--------
 drivers/net/dsa/rzn1_a5psw.h |  3 +-
 2 files changed, 67 insertions(+), 19 deletions(-)

-- 
2.40.1

