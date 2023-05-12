Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C5B7009C2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 16:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241356AbjELOC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 10:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241363AbjELOCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 10:02:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322AF19B2;
        Fri, 12 May 2023 07:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=o42bYRiGDYv0oiaZby38uYs2JfHiCSTG+EB2+ilcPVk=; b=Map3vAxfT7tsVfbMF/gNeenRuo
        KLBR5Nzp0laRWmmdiRmjCrUlwA2qAl2I9ItANArxroeXiXYWVIQKCXqA1zKVKZIHbFCa2jdB2eoOd
        7NPmfhfqDnrBzTmDZVBK0b7kTX+Qr5X1wq/bOjeTsvgleSOBxSD6XyINFlYfsMmt/g1nEac2cRso2
        IrnQVXP1ccbFFx+1s5K2CZWW7IZ1uH17gFTL5Fxd4TQeXKVTK5wUaDeiBo47CboZmU19YBfNgGUKM
        CSmE1z8PhialJ38FDh3KbtUju36Wft/LvaFTf52a4CRl9uo1nIuxkjpR6h4T4ByriElFSaL6RyP6f
        DSL5qX3w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pxTLb-00C6TY-1i;
        Fri, 12 May 2023 14:02:15 +0000
Date:   Fri, 12 May 2023 07:02:15 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Ed Tsai <ed.tsai@mediatek.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        stanley.chu@mediatek.com, peter.wang@mediatek.com,
        chun-hung.wu@mediatek.com, alice.chao@mediatek.com,
        powen.kao@mediatek.com, naomi.chu@mediatek.com,
        wsd_upstream@mediatek.com
Subject: Re: [PATCH 2/2] ufs: don't use the fair tag sharings
Message-ID: <ZF5G5ztMng8Xbd1W@infradead.org>
References: <20230509065230.32552-1-ed.tsai@mediatek.com>
 <20230509065230.32552-3-ed.tsai@mediatek.com>
 <ZF0K7A6G2cYBjSgn@infradead.org>
 <aa9af9ae-62a4-6469-244c-b5d9106bb044@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa9af9ae-62a4-6469-244c-b5d9106bb044@acm.org>
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

On Thu, May 11, 2023 at 08:38:04AM -0700, Bart Van Assche wrote:
> For which devices is the fair sharing algorithm useful? As far as I know the
> legacy block layer did not have an equivalent of the fair sharing algorithm
> and I'm not aware of any complaints about the legacy block layer regarding
> to fairness. This is why I proposed in January to remove the fair sharing
> code entirely. See also https://lore.kernel.org/linux-block/20230103195337.158625-1-bvanassche@acm.org/.

Because the old code did not do tag allocation itself?  Either way I
don't think a "I'll opt out for a random driver" is the proper approach
when you think it's not needed.  Especially not without any data
explaining why just that driver is a special snowflake.
