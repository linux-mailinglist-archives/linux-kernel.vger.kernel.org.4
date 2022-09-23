Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C915E712F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 03:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbiIWBKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 21:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbiIWBKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 21:10:02 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15673ED42
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 18:09:45 -0700 (PDT)
X-UUID: e414e3a049aa4c8d88b8fee4b6b4a7bc-20220923
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=10Du0IWQFsHNUbZWCznPpkKBXDFn+p52pQMLrjF0b1M=;
        b=IfAenQWbSOOpRCCRlf9IZvS5ZJbIkgDx9Q/ZHmKxeXjG5YzI9jNxHzpHtHCYTsjw9JOyGpIGASPAQXbpPmnqVbZFjRLXCQ3kBEERp48NmEY8Kel/lNQe8/lN4zY350uQhev5tiOijm2lKQ41YarxCkmzgEF9IYmVuj8gzBU6VZw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:6e958d89-7ca8-4a67-9e3c-a8052dccd2b2,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:39a5ff1,CLOUDID:faaac8a2-dc04-435c-b19b-71e131a5fc35,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: e414e3a049aa4c8d88b8fee4b6b4a7bc-20220923
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 59141201; Fri, 23 Sep 2022 09:09:40 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 23 Sep 2022 09:09:39 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Fri, 23 Sep 2022 09:09:38 +0800
Message-ID: <b5e92bac499230a11868521771eaff6fcbc684d5.camel@mediatek.com>
Subject: Re: [PATCH v5 6/6] iommu: Propagate return value in ->attach_dev
 callback functions
From:   Yong Wu <yong.wu@mediatek.com>
To:     Nicolin Chen <nicolinc@nvidia.com>, <joro@8bytes.org>,
        <will@kernel.org>, <robin.murphy@arm.com>,
        <matthias.bgg@gmail.com>, <jean-philippe@linaro.org>
CC:     <jgg@nvidia.com>, <kevin.tian@intel.com>, <iommu@lists.linux.dev>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
Date:   Fri, 23 Sep 2022 09:09:38 +0800
In-Reply-To: <8040df414a1d4bc007a25553b8341acf37ead670.1663836372.git.nicolinc@nvidia.com>
References: <cover.1663836372.git.nicolinc@nvidia.com>
         <8040df414a1d4bc007a25553b8341acf37ead670.1663836372.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-09-22 at 01:54 -0700, Nicolin Chen wrote:
> The mtk_iommu and virtio drivers have places in the ->attach_dev
> callback
> functions that return hardcode errnos instead of the returned values,
> but
> callers of these ->attach_dv callback functions may care. Propagate
> them
> directly without the extra conversions.
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/mtk_iommu.c    | 2 +-
>  drivers/iommu/virtio-iommu.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Yong Wu <yong.wu@mediatek.com> #For mtk_iommu.c

Thanks.

