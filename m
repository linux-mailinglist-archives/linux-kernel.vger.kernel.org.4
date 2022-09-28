Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A05C5ED9C9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 12:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbiI1KGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 06:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233893AbiI1KGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 06:06:01 -0400
Received: from mail-m121145.qiye.163.com (mail-m121145.qiye.163.com [115.236.121.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02356B6031;
        Wed, 28 Sep 2022 03:05:57 -0700 (PDT)
Received: from amadeus-VLT-WX0.lan (unknown [218.85.118.195])
        by mail-m121145.qiye.163.com (Hmail) with ESMTPA id 64787800115;
        Wed, 28 Sep 2022 18:05:54 +0800 (CST)
From:   Chukun Pan <amadeus@jmu.edu.cn>
To:     robin.murphy@arm.com
Cc:     linux.amoon@gmail.com, heiko@sntech.de, robh+dt@kernel.org,
        michael.riesch@wolfvision.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Chukun Pan <amadeus@jmu.edu.cn>
Subject: Re: [PATCH-next v1] arm64: dts: rockchip: Enable NVM Express PCIe controller on rock3a
Date:   Wed, 28 Sep 2022 18:05:20 +0800
Message-Id: <20220928100520.3886-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <e75cc292-ff7a-0daa-e2f9-fde376b5e26e@arm.com>
References: <e75cc292-ff7a-0daa-e2f9-fde376b5e26e@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCGRhNVhpCThpKHh9DTEpDTFUTARMWGhIXJBQOD1
        lXWRgSC1lBWUlKQ1VDTlVKSkNVSkJOWVdZFhoPEhUdFFlBWU9LSFVKSktITUpVSktLVUtZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NE06Egw*Az0jTQwaEkwhNQI*
        HgEwCkNVSlVKTU1PSE5CTk5OS0hIVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlK
        Q1VDTlVKSkNVSkJOWVdZCAFZQUlJQk43Bg++
X-HM-Tid: 0a83838f5e52b03akuuu64787800115
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 27-09-22, 18:47, Robin Murphy wrote:

> (as a side note, is pcie2x1's vpcie3v3-supply as queued in -next 
> actually correct? AFAICS the other socket is effectively powered 
> straight from VCC3V3_SYS so shouldn't have needed VCC3V3_PCIE,
> but at least it's there now ready for this one)

Thanks for the correction, I didn't notice this before. You are right,
the supply of pcie2x1 comes from VCC3V3_SYS. But if we change supply
of pcie2x1 to VCC3V3_SYS, it will cause pcie30phy to fail to initialize
normally. The error is the same as the following:

> phy phy-fe8c0000.phy.4: rockchip_p3phy_rk3568_init: lock
> failed 0x6890000, check input refclk and power supply
> phy phy-fe8c0000.phy.4: phy init failed --> -110
> rockchip-dw-pcie: probe of 3c0800000.pcie failed with error -110

If both vpcie3v3-supply of pcie2x1 and pcie3x2 use VCC3V3_PCIE like
the vendor kernel, they can initialized normally.

Thanks,
Chukun

-- 
2.25.1

