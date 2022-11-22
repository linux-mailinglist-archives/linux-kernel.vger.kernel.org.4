Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED8E63372D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 09:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbiKVIbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 03:31:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232799AbiKVIai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 03:30:38 -0500
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3C68942982
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 00:30:22 -0800 (PST)
Received: from 8bytes.org (p200300c27724780086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7724:7800:86ad:4f9d:2505:dd0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 8810B2A0360;
        Tue, 22 Nov 2022 09:30:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1669105820;
        bh=vLe6nxgqikKlbcnK8kZzaybY0rU15COq4GRTBdtoeg0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JIifV4bBxxqGYXp3xL/kaRjDWVQpQG5GFY0CPgdELMHldHAZ2DWLYMnr1Ihb/GS3n
         niLlNZ3gMPUDzW7AXOrTrm2wGqFNwRu7OYIq+ucgr13+Vhw5/75ol7RhHXiE7dGjzG
         qxaZhEhAOvVVg9wMHXp1Rcal8uGK1yV98G5gzraY/NYjeRf27iUT5ZFpuHLWEqNJuM
         eM5hIlv4bTLb0LnxW3j4KK89coWJaMRkVDtHmgSkqJ3VFDHe3IWZUzsXbKNs7vOSTg
         rl5LkSJLe+faA5zMTwncGWocSFa5m7Z5TyNAIG/FzT6CXB63bejxOTS4CiwnB1qsFL
         LrrPXXihKUu8g==
Date:   Tue, 22 Nov 2022 09:30:18 +0100
From:   "joro@8bytes.org" <joro@8bytes.org>
To:     Yong Wu =?utf-8?B?KOWQtOWLhyk=?= <Yong.Wu@mediatek.com>
Cc:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "will@kernel.org" <will@kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Youlin Pei =?utf-8?B?KOijtOWPi+aelyk=?= 
        <youlin.pei@mediatek.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        Libo Kang =?utf-8?B?KOW6t+WIqeazoik=?= <Libo.Kang@mediatek.com>,
        Anan Sun =?utf-8?B?KOWtmeWuieWuiSk=?= <Anan.Sun@mediatek.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        Chengci Xu =?utf-8?B?KOiuuOaJv+i1kCk=?= 
        <Chengci.Xu@mediatek.com>,
        "groeck@chromium.org" <groeck@chromium.org>,
        Xueqi Zhang =?utf-8?B?KOW8oOmbqueQpik=?= 
        <Xueqi.Zhang@mediatek.com>,
        YF Wang =?utf-8?B?KOeOi+S6kemjnik=?= <YF.Wang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Mingyuan Ma =?utf-8?B?KOmprOm4o+i/nCk=?= 
        <Mingyuan.Ma@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v7 0/6] iommu/mediatek: Improve safety from invalid dts
 input
Message-ID: <Y3yImpIgDiLVk7La@8bytes.org>
References: <20221018024258.19073-1-yong.wu@mediatek.com>
 <b20e6c79b989f0f26707f6e43b9f4aa0d1d8f02e.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b20e6c79b989f0f26707f6e43b9f4aa0d1d8f02e.camel@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wu,

On Tue, Nov 22, 2022 at 01:13:01AM +0000, Yong Wu (吴勇) wrote:
> Gentle ping for this. Could you help review or apply this if it is ok
> for you?

I am waiting for Matthias' OK on this.

Regards,

	Joerg
