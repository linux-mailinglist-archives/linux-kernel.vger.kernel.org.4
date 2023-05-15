Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119F2702F8F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 16:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240659AbjEOOWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 10:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240981AbjEOOWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 10:22:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3692690;
        Mon, 15 May 2023 07:21:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11F2661D97;
        Mon, 15 May 2023 14:21:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF7C5C433EF;
        Mon, 15 May 2023 14:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684160491;
        bh=lKnul3tmWj3tLZgkEsGa1O/MPi5gzvyT3nQCUJQZQgo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=efanRrlp5TXWSXfEaTLmJYO493vRVgbH414MpVOnof0Jub0X1E9pIJ6nA0U8vhtfV
         LxLsPREW9qyNpLMVi+SFKRaFktXjmUAzvKW+lGPk1pJ+SPV7vFnXtdCRpy15ADs3er
         2lGfJH/8RDtwMcFZnIZlxNkQUYytG3zZz2HWS9PnePKdTm7hU1U6/cx0M+0B1QWVTP
         hOMPDDPohr7LZGfltSdL8vEnqoPUfq8BWW0tXrFdy1nCAYPYSYwPeTF5pLc/D/fuFR
         q4/RPbQu3nMDaPuSsD9hVFPv9aCBTqWl+GRooqyr+q+/o3ns21R/QvgUCBvbPq8h5p
         w1ltF0SA1+7Dg==
Date:   Mon, 15 May 2023 08:21:28 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 2/5] nvmet: Reorder fields in 'struct nvme_ctrl'
Message-ID: <ZGI/6DT30JBfQPnG@kbusch-mbp>
References: <cover.1682941568.git.christophe.jaillet@wanadoo.fr>
 <af016d2a5e7e7bb503eadb15037b80bc9813b94c.1682941568.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af016d2a5e7e7bb503eadb15037b80bc9813b94c.1682941568.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 01, 2023 at 02:40:26PM +0200, Christophe JAILLET wrote:
> Group some variables based on their sizes to reduce holes.
> On x86_64, this shrinks the size of 'struct nvmet_sq' from 5368 to 5344
> bytes when all CONFIG_* are defined.

This patch is changing struct nvme_ctrl but the commit log only mentions
struct nvmet_sq, which was handled in patch 1/5. I'll just fix that up
when applying.
 
> This structure is embedded into some other structures, so it helps reducing
> their size as well.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Using pahole
> 
> Before:
> ======
> struct nvme_ctrl {
> 	bool                       comp_seen;            /*     0     1 */
