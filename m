Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232E265658B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 23:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbiLZWqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 17:46:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbiLZWqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 17:46:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151B5FC9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 14:46:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CFE560F30
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 22:46:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EAB0C433D2;
        Mon, 26 Dec 2022 22:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672094800;
        bh=xn7lV3m68/eeONQwiMztfwZqj6zMswJJ8qyPz2b3NKM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Iduqg0hWk02rYp6tm+m3J/LyJ4KyJroVheh/aomdXIvPZo6Xkr0R97uFACGmqON/9
         QRArJSR8uBmRKKqcCOTLj2TxgF0GUA2tXHxm19plpAld9yvK5aVuIetFekZ424PcTi
         0KhdPmulEw+I6i4ozZ7IAMuWxT5squUJ4a53uaebcbJhPygMmdIkDduzfmBHlWmwhY
         9HiNCGi5tVzTuIv+9P8tFmgIdHt+55XOnukK0FDECfp0xwdxXj8X/Y8/jGdBPkThbz
         Zu4fTihreuiTutJnb57G8vXK9PggJFTq7olrvbUwcG1ZQs8kpSx2/1vh5Ooi80d4wr
         k/PsNKL012aRw==
From:   Conor Dooley <conor@kernel.org>
To:     Conor Dooley <conor@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org,
        Daire McNamara <daire.mcnamara@microchip.com>,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v3 0/2] mpfs: fix handling failed service requests
Date:   Mon, 26 Dec 2022 22:46:28 +0000
Message-Id: <167209401166.1237431.3681693527005638710.b4-ty@microchip.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221123175652.327859-1-conor@kernel.org>
References: <20221123175652.327859-1-conor@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=533; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=7ZyLo9pw4ngtdXWCQmsbO+VBc6xMj4XuwSVXhASX+OA=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDMmrVBxVFpwpVfx4y6Hg3B9X+6U2uq9WTot0mLX77JyLc5e2 F6TVdpSyMIhxMMiKKbIk3u5rkVr/x2WHc89bmDmsTCBDGLg4BWAie6cy/FN9lX//18ujDZt+Ga75s3 99U/78rX9PVt7ONkpM5EzZ1qrA8L/y5d7j7zRuXf+y56J3o/f2zms7mr6U3tpYxL8oyPtL1xoeAA==
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

On Wed, 23 Nov 2022 17:56:50 +0000, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> As things stand, if a service request fails, we never know about it as
> the status register is not read. This is quite obviously far from ideal,
> as we would be reading garbage from the mailbox if a service was to
> fail.
> 
> [...]

Applied to riscv-soc-fixes, thanks!

[1/2] soc: microchip: mpfs: handle failed system service requests
      https://git.kernel.org/conor/c/730892135b7d

Thanks,
Conor.
