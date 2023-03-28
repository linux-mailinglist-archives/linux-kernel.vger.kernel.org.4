Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5086CB589
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 06:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjC1EuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 00:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjC1EuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 00:50:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A62210D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 21:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xlPh4S+TbTgkNsO9Dt503SwDvNQzKRyfCiCNpDhlIR8=; b=yVjVeEwJyLcoFyXalwFYFo+Jq+
        S/xBDNNvXpga8t4TgcZdnUESMN2aJKHjt8vx/pY28AnGcz+RxUIYcSoupOwhAGFstqwHLFpttRfjq
        bhnnVINCRXTPRzn9gf0aaIXTv3F8eMcqgTGccGEO5g/mE1oAZ9LJIF1QnkemSLjSzOkK1Up3RKIYV
        mJJKaaTEhqSyjjLHF7ggUnVp02CXpE0OSCitgRtx9s2m2Ms0UpSZ4jcGeyHLuQTHwnEBAuQnorgsL
        bmuu4lmzKNWF2OdtCNtEp7+al4UyKfB5jZ8FIleUkEP+5cxQFqNery4BKmlS7LEP8ngXoG3jeAYwe
        3p+n7Nlw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ph1HA-00D8WD-30;
        Tue, 28 Mar 2023 04:49:40 +0000
Date:   Mon, 27 Mar 2023 21:49:40 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Albert Huang <huangjie.albert@bytedance.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Christian Schoenebeck <linux_oss@crudebyte.com>
Subject: Re: 9p regression (Was: [PATCH v2] virtio_ring: don't update event
 idx on get_buf)
Message-ID: <ZCJx5Dtms5iDhftF@bombadil.infradead.org>
References: <20230325105633.58592-1-huangjie.albert@bytedance.com>
 <ZCJNTBQLZeyLBKKB@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCJNTBQLZeyLBKKB@codewreck.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 11:13:32AM +0900, Dominique Martinet wrote:
> Hi Michael, Albert,
> 
> Albert Huang wrote on Sat, Mar 25, 2023 at 06:56:33PM +0800:
> > in virtio_net, if we disable the napi_tx, when we triger a tx interrupt,
> > the vq->event_triggered will be set to true. It will no longer be set to
> > false. Unless we explicitly call virtqueue_enable_cb_delayed or
> > virtqueue_enable_cb_prepare.
> 
> This patch (commited as 35395770f803 ("virtio_ring: don't update event
> idx on get_buf") in next-20230327 apparently breaks 9p, as reported by
> Luis in https://lkml.kernel.org/r/ZCI+7Wg5OclSlE8c@bombadil.infradead.org

Spot on, reverting that commit fixes it.

  Luis
