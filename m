Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A32A6426FD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 11:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiLEKzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 05:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiLEKzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 05:55:48 -0500
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8500C1901C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 02:55:47 -0800 (PST)
Received: from 8bytes.org (p200300c27724780086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7724:7800:86ad:4f9d:2505:dd0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id A5EE42202AB;
        Mon,  5 Dec 2022 11:55:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1670237746;
        bh=UVOyFFaGYlpHJfm3mAMdFZ8zDZRV5tP+GuufCO475L4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=50ZzaDPqm6zSg1911499wI12ZJg8Zfh0ZeU4ptABj61knUN9uman1W/Zj3OEYkx5o
         DT9ag6YE8z9ZTFTyx8NXeKVyX07AjJ5Y6upV3L3aXZ/D460VDVWyQafxz15zOjjp4S
         FgdSVQjAe6xWxLCc2OH6AjuG6WHUyTjlxiuvxDq5rQ2/mXrNf4qAAR1Pe5N1Y/pvFQ
         Yhj/72n4bxUlGQer/1yKN42pLQMYn0kWFsXltRhMpwfVCMAT6640YBKA6YihbyoJeU
         NGKhXkJLpH1XQucxnBVkOjqWKoVoQneM7GOQ/2JkWO+TE92+yU4RW13aCKBdVkF2a2
         Tb0yRdJ7AuqDA==
Date:   Mon, 5 Dec 2022 11:55:45 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Yong Wu <yong.wu@mediatek.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommu/mediatek: Fix crash on isr after kexec()
Message-ID: <Y43OMbwJUTv0dmOt@8bytes.org>
References: <20221125-mtk-iommu-v2-0-e168dff7d43e@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221125-mtk-iommu-v2-0-e168dff7d43e@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 11:16:48PM +0100, Ricardo Ribalda wrote:
> If the system is rebooted via isr(), the IRQ handler might be triggerd
> before the domain is initialized. Resulting on an invalid memory access
> error.
> 
> Fix:
> [    0.500930] Unable to handle kernel read from unreadable memory at virtual address 0000000000000070
> [    0.501166] Call trace:
> [    0.501174]  report_iommu_fault+0x28/0xfc
> [    0.501180]  mtk_iommu_isr+0x10c/0x1c0
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Applied with commit-message spelling fix.

