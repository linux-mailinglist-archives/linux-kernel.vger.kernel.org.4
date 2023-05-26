Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83406712BA9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 19:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242637AbjEZRUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 13:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242836AbjEZRUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 13:20:03 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCF3F7;
        Fri, 26 May 2023 10:19:49 -0700 (PDT)
Received: from fpc.intra.ispras.ru (unknown [10.10.165.11])
        by mail.ispras.ru (Postfix) with ESMTPSA id 013B744C1026;
        Fri, 26 May 2023 17:19:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 013B744C1026
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1685121585;
        bh=Mvh06IIheGgnwFtVcRZNkagFx8wj2j4e8MBDk/rccUo=;
        h=From:To:Cc:Subject:Date:From;
        b=ZaRvxiBkm3jcu+5S9ndy1a0Lqj5QfQKpfs+l/MpeIgK2W0BiaJJtyfj/GSyg0IlBc
         B9JpIufjAz+lOEImnysFk5kHjaQW2FFaaxJtI4w9SES9qL/a1fVXXL035jpiA+mpL4
         B7KxfpxzDG6fsz5rPPdB8+6wEUX4xnE1MRwBGFjs=
From:   Fedor Pchelkin <pchelkin@ispras.ru>
To:     Oleksij Rempel <linux@rempel-privat.de>
Cc:     Fedor Pchelkin <pchelkin@ispras.ru>,
        Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de,
        Robin van der Gracht <robin@protonic.nl>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org
Subject: [PATCH 0/2] can: j1939: avoid possible use-after-free when j1939_can_rx_register fails
Date:   Fri, 26 May 2023 20:19:08 +0300
Message-Id: <20230526171910.227615-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.34.1
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

The patch series fixes a possible racy use-after-free scenario described
in 2/2: if j1939_can_rx_register() fails then the concurrent thread may
have already read the invalid priv structure.

The 1/2 makes j1939_netdev_lock a mutex so that access to
j1939_can_rx_register() can be serialized without changing GFP_KERNEL to
GFP_ATOMIC inside can_rx_register(). This seems to be safe.

Note that the patch series has been tested only via Syzkaller and not with
a real device.
