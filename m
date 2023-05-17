Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F4B706145
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 09:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjEQHfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 03:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjEQHfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 03:35:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF92448A
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 00:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hcKgMqBaVIqZoOwjyxizzLY6i35d7PAbT8GtOYflIfk=; b=fqgCRcaFzw3/J6P9X/XIEYB7c/
        m4m1SzOzwxAy+e0MN7AfudrnRjsla5m3WrVZuhFLh/kE8QAsriNEh2qXwYMAehf1+bCbOHNPIvQgz
        BhdZ6GvATpmwGEnRx0jwHXvYm0NUrg+sd0MCJ5sWMaW5OpY/dbubDOX1o/tTa/QcYd/SFyF2gm4yJ
        3HbXkNE1Qkthwx+tpCOTdM2Ldfbewcy/jTAp/HJJ2DRw7Jn3cSg3eVSTruRbmS1Evl/bZ3/Q79U7O
        duNkcsRIqalJfa2J0wStc9PGKv3ZT62ZgcwkbXFc6lY3NYDB0eiqxwYdRLKTAsToiJp9tBO4+Myil
        bNUZI2Vw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pzBgY-008gi7-04;
        Wed, 17 May 2023 07:34:58 +0000
Date:   Wed, 17 May 2023 00:34:57 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Xiaoming Ding <xiaoming.ding@mediatek.com>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, fei.xu@mediatek.com,
        srv_heupstream@mediatek.com, linux-mm@kvack.org
Subject: Re: [PATCH] tee: add FOLL_LONGTERM for CMA case when alloc shm
Message-ID: <ZGSDoVKKVqCkbaCB@infradead.org>
References: <20230517031856.19660-1-xiaoming.ding@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517031856.19660-1-xiaoming.ding@mediatek.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	u32 page_flag = FOLL_WRITE;
>  
>  	if (!tee_device_get(teedev))
>  		return ERR_PTR(-EINVAL);
> @@ -255,9 +256,11 @@ register_shm_helper(struct tee_context *ctx, unsigned long addr,
>  		ret = ERR_PTR(-ENOMEM);
>  		goto err_free_shm;
>  	}
> -
> +#if IS_ENABLED(CONFIG_CMA)
> +	page_flag |= FOLL_LONGTERM;
> +#endif
>  	if (flags & TEE_SHM_USER_MAPPED)

If this mapping is long live it should always use FOLL_LONGTERM.

The ifdef does not make sense.
