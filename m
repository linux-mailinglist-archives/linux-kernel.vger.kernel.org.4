Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011A4720916
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 20:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236593AbjFBS1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 14:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235575AbjFBS1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 14:27:09 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7AA123;
        Fri,  2 Jun 2023 11:27:07 -0700 (PDT)
Received: from arisu.hitronhub.home (unknown [23.233.251.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: detlev)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 63A1266066EC;
        Fri,  2 Jun 2023 19:27:04 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685730425;
        bh=oceu11ynUm4Aadbni5SseGKgOMyd/2PaucSJemy3+Ek=;
        h=From:To:Cc:Subject:Date:From;
        b=Mz9YqxM6QV+KY0Yku7jxz+kI54+5/oaIEkaJ5jyABtgogIc0ivvkN9LbY9cLih19r
         a+jCjeOLROW34zp3QOeq2L/zjIOTH6fsHU6HDxZkD7ZqTEysQWa/d0f9dXU1obtZXr
         METtnrlm0HEOlRJA48hC94X34k1/WOXUKuTybrQ1Pia6VHDdM0h86SCCcxmRd0LCTp
         itOqag2iifQZ2hp7eych3eqiklie1hlSDPOPAczilfnVq1xABZ/YXbZ2fzMBfd6lgo
         80KTDTBiJR9rsE1ccGw9QJIO7KWAOji+Ehz0MJScdbquc8OLUad5HpLRujtJfgEecC
         F4uD8jMq6xqYQ==
From:   Detlev Casanova <detlev.casanova@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org
Subject: net: phy: realtek: Support external PHY clock
Date:   Fri,  2 Jun 2023 14:26:56 -0400
Message-Id: <20230602182659.307876-1-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, thank you for your comments ! HEre are the changes that were
discussed.

Some PHYs can use an external clock that must be enabled before probing
it.

Changes since v1:
 * Remove the clock name as it is not guaranteed to be identical across
   different PHYs
 * Disable/Enable the clock when suspending/resuming


