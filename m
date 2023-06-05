Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC92722AC6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234414AbjFEPUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234363AbjFEPUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:20:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07141D2;
        Mon,  5 Jun 2023 08:20:12 -0700 (PDT)
Received: from arisu.mtl.collabora.ca (mtl.collabora.ca [66.171.169.34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: detlev)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BCAD26600368;
        Mon,  5 Jun 2023 16:20:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685978411;
        bh=Ye2OPJTrKVJ6tXJ7CFNhgEilyt6Zi31GJyG9LSEVmZY=;
        h=From:To:Cc:Subject:Date:From;
        b=Pe0WnA1vJCDPhX6P6HNWN4SRl5A7/ZytShvV/StDkqw46eGnVTXBp+SIpBNe2SDu/
         7wyzcm38TOsUrz/Zy3tlZnq/5CkYTy5dDVvWIacHFRPzW9htiEUUZr9f+UD7+uSZ/9
         4wd9KiaEHpFulI2tI6CbSLngCPy1nnEPFqRVq0awUne79rg+7Go3K8Q7jbeoMAv7ZH
         kn/7GAmwZYAfUdHTo5dMEH+OsT5v0yAV2stDLDoO7U4FV1IZ7GVKmrC3QtLiWecXru
         Ny1GWeQURhkjsxLP9aaRWzRgFXiAu6NYErAjEQ5GS2xL8dpDeagmGg0asDw30T/4O3
         HGH69cvay9mQw==
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
Date:   Mon,  5 Jun 2023 11:19:50 -0400
Message-Id: <20230605151953.48539-1-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some PHYs can use an external clock that must be enabled before
communicating with them.

Changes since v2:
 * Reword documentation commit message

Changes since v1:
 * Remove the clock name as it is not guaranteed to be identical across
   different PHYs
 * Disable/Enable the clock when suspending/resuming


