Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A13374DF30
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 22:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbjGJU0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 16:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjGJU0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 16:26:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD40B198;
        Mon, 10 Jul 2023 13:26:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41B0E611C3;
        Mon, 10 Jul 2023 20:26:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AAD0C433C8;
        Mon, 10 Jul 2023 20:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1689020772;
        bh=Xjx+HnYnS65YQoXatRuMi3xuh6WSWvutNLaaTXSjmko=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UBgdqqvtm7sLAyH42SzguqVkleEGLdFy5ZE6qE+rQlIsaIfZSqgRARIqrMtGI51yh
         qGgvheCjkZYPDKQiZNGvKdjdUbOF1fuoXER7AoVIvZo0BvnDaisoszvYqQsbrbH6Gu
         c0GfnqKot1svigDw/XN/SGEe48D56tu1Y7DAHcZY=
Date:   Mon, 10 Jul 2023 13:26:11 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     corbet@lwn.net, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com, paulmck@kernel.org, catalin.marinas@arm.com,
        rdunlap@infradead.org, peterz@infradead.org, rostedt@goodmis.org,
        kim.phillips@amd.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-mm@kvack.org
Subject: Re: [PATCH] dma-contiguous: support numa CMA for specified node
Message-Id: <20230710132611.ccf619f06f3ead06986cb7f4@linux-foundation.org>
In-Reply-To: <20230710074944.3501810-1-yajun.deng@linux.dev>
References: <20230710074944.3501810-1-yajun.deng@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2023 15:49:44 +0800 Yajun Deng <yajun.deng@linux.dev> wrote:

> The kernel parameter 'cma_pernuma=' only supports reserving the same
> size of CMA area for each node. We need to reserve different sizes of
> CMA area for specified nodes if these devices belong to different nodes.
> 
> Change kernel parameter from 'cma_pernuma=' to 'numa_cma='. If node
> isn't specified, it will reserve CMA area for per-numa node. if the node
> is specified, it will reserve CMA area for the specified node.
> 
> At the same time, print the node id in cma_declare_contiguous_nid() if
> enabled CONFIG_NUMA.

Changing an existing kernel parameter will break existing setups.  It
would be preferable to add a new parameter for this?
