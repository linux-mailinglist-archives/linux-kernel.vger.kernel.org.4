Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF98E6435B2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 21:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbiLEUc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 15:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiLEUc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 15:32:26 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF3D29804;
        Mon,  5 Dec 2022 12:32:25 -0800 (PST)
Received: from notapiano (unknown [IPv6:2804:14c:1a9:3b3c::1000])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6A77166015B4;
        Mon,  5 Dec 2022 20:32:19 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1670272343;
        bh=T4jEOj3MX4O9ybwnACjigBqd5HrWbxgMvQT+OXT7Qxk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fh0QsJ4GR6deGY2L6Vkcewz5FdvFD+iF+Dm4aQ01N4TzbW2YZ2A4+o9YVy+GNToGF
         ZD6BhwRSV5qSfie3oinKOdFuwrNJjzxQJWsa+yGhLFd+7Xq35kMU8EyUzwbmVfNPVH
         7KAvzPEtAqTa6zH5kufv8rY5C8vyptJiIYDGcGVtq+ZeKXLW2eaVl+HSPnSt18v3aU
         kiOgFe/DhyBaeeO6j3F9dKzqWkcJ+qHc2U0ugmpT5KWiPnWzlg5ROJPK8h4WyhnJ73
         4ul80sF820fkOVZOxzL60/wh+a7DbuXMDWHeRE2sZ0JrpANDNSl0jScEEpWPHN731e
         QrRgtuqd5e9Og==
Date:   Mon, 5 Dec 2022 17:32:14 -0300
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, yunfei.dong@mediatek.com
Subject: Re: [PATCH v5 2/3] media: dt-bindings: media: mediatek: Remove
 "dma-ranges" property for decoder
Message-ID: <20221205203214.megeq5nr7ksvb5vw@notapiano>
References: <20221128143832.25584-1-allen-kh.cheng@mediatek.com>
 <20221128143832.25584-3-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221128143832.25584-3-allen-kh.cheng@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 10:38:31PM +0800, Allen-KH Cheng wrote:
> Since commit f1ad5338a4d5 ("of: Fix "dma-ranges" handling for bus
> controllers") was merge, we don't need a dma-ranges property for IOMMU
> in mediatek video codec.

This description isn't right, as it gives the impression that the mentioned
commit removed the need for having a dma-ranges property, but that isn't the
case, the property wasn't needed even before that commit. That commit did
however expose the fact that having this property didn't make sense in the first
place.

Here's a suggestion:

	The decoder nodes already make use of the iommus property to configure the IOMMU
	for address translations, so also having a dma-ranges property doesn't make
	sense.

	In fact, after commit f1ad5338a4d5 ("of: Fix "dma-ranges" handling for bus
	controllers"), having a dma-ranges property causes IOMMU faults.

	Remove the dma-ranges property and update the example.

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas
