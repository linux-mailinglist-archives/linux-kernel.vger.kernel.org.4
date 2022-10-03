Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5392E5F2FA4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 13:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiJCL32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 07:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiJCL3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 07:29:25 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232162CC8D;
        Mon,  3 Oct 2022 04:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1664796560;
  x=1696332560;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZwcYVLOdHsCgTakuvlsIcAUfd5Jd8zD73dYPiE5yHpo=;
  b=gqBxCs1H2ZvxteM1ijq5qjn3T8QZVK7b44Rgrv5iSr/ILVNjia0TdQAh
   UnH6+jR3XfwSJsFaOgi1Up3P/nOifNVgFgGjBAnUqFqJCNUsYI1ZG8v0T
   sNehcITFZd3CT+0jHjfzJXo+ddLdX75iItRxuENxuqSWxwSmcaQujRuZB
   P2KEBI57XABuRySi9vF7l04lGfkAQbPJP5DeFvrNo4d9H1wPz8WZwVyNk
   IMfjWv7KvdM/rW0b0Nw882Ujikn4thHRYzONJQyZaJbBKGK9FLVBCPRal
   163HTa0eSq3EI3IWsrxKh/KEX7oKj54oCysZQRB2X97jIc/K3umgoBdSU
   Q==;
Date:   Mon, 3 Oct 2022 13:29:18 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     Marek Szyprowski <m.szyprowski@samsung.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "andi@etezian.org" <andi@etezian.org>,
        Christoph Hellwig <hch@lst.de>, kernel <kernel@axis.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: [PATCH v2 2/4] spi: Fix cache corruption due to DMA/PIO overlap
Message-ID: <YzrHjl8x2bd1rqeE@axis.com>
References: <20220927112117.77599-1-vincent.whitchurch@axis.com>
 <CGME20220927112359eucas1p15bee651dfbe727701ad732f6ce9a7f13@eucas1p1.samsung.com>
 <20220927112117.77599-3-vincent.whitchurch@axis.com>
 <a4be6670-832a-ffac-4d68-e4a079eb2eed@samsung.com>
 <461a5187-fc7a-b7f6-84da-0e947f764a0a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <461a5187-fc7a-b7f6-84da-0e947f764a0a@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 02:10:28PM +0200, Robin Murphy wrote:
> That said, maybe this is something that's better to catch than to paper 
> over? Arguably the real bug here is that spi_unmap_buf() and the new 
> sync functions should use the same "{tx,rx}_buf != NULL" condition that 
> spi_map_buf() used for the DMA mapping decision in the first place.

The "{tx,rx}_buf != NULL" condition would not sufficient on its own; the
call to ->can_dma() is also part of the condition.  __spi_unmap_msg()
already does the ->can_dma() call even though it checks for the
orig_nents != 0 condition instead of the tx,rx_buf != NULL, but I
omitted that call in the new sync functions, incorrectly believing it to
be redundant.

It looks like __spi_unmap_msg() would have triggered a similar crash
even before this patch, if a client had reused an xfer with both rx and
tx the first time, and only one of them enabled the next time around
(and with ->can_dma() returning true both times).  Testing the
{tx,rx}_buf instead of sgt->orig_nents would have avoided that, as you
say.
