Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07D370615F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 09:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjEQHjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 03:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjEQHjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 03:39:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFB2DA
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 00:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BXLZ+yEa82RxkW3QXxkSn4CuUde79k4TvT+xYUt2yR0=; b=j8Oc/5AfxoC4ZTxrm8OxtCPW89
        AGSE8ZI/sITlQVr3lH/MGL+wGFdkBbVkgxdzJ0SN09+8RXlto0WaU/tdqa9qfwmcFrq5nmSmhU5mA
        3xTrWuRO8IQ9rZFUFxzv9fP0H9fxAPQODjDNvWZd7oFhsZ5rTviRzIFpk1juA38sdWRID68YhEJUV
        W5ph04GCfXSLlEjH6FNTVeQs4+IBnLFqRmoQw4B9sH5DCtqTblh/k6m0y4PFLzxzJ2AE7Vbx3r1rx
        NRaLxkgtltk9/yf5rfYQGndxwT/GFIRF0jsjdpQqg5DVuXFd0jxfU5MgBmvT0o6T1rVAdVNxLkc+D
        Z4JmZD5w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pzBkp-008hYG-1F;
        Wed, 17 May 2023 07:39:23 +0000
Date:   Wed, 17 May 2023 00:39:23 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     zhenwei pi <pizhenwei@bytedance.com>
Cc:     stefanha@redhat.com, mst@redhat.com, jasowang@redhat.com,
        xuanzhuo@linux.alibaba.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] virtio: abstract virtqueue related methods
Message-ID: <ZGSEq197W8VvOWCc@infradead.org>
References: <20230517025424.601141-1-pizhenwei@bytedance.com>
 <20230517025424.601141-2-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517025424.601141-2-pizhenwei@bytedance.com>
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

On Wed, May 17, 2023 at 10:54:23AM +0800, zhenwei pi wrote:
> All the vring based virtqueue methods could be abstratct in theory,
> MST suggested that add/get bufs and kick functions are quite perfmance
> sensitive, so export these functions from virtio_ring.ko, drivers
> still call them in a fast path.

Who is going to use this?  And why do you think every virtio users
would want to pay for indirect calls just for your shiny new feature?

This seems like an amazingly bad idea to me.
