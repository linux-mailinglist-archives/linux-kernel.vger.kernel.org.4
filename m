Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332805EA9C3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 17:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235715AbiIZPKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 11:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235661AbiIZPJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:09:24 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077A752FD2;
        Mon, 26 Sep 2022 06:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1664199754;
  x=1695735754;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z+SSPGyOZfEIh3tj+j1JJaoE55e3O7nhgeSNDbNps14=;
  b=OkdZNGA2/oB1hw2MdbaGHBmbpfLQMfiUyrWEN4GbzXnDCVfbYgghoL6X
   fN9wpT4eKK3LmY5vOFj+foCdwRkG9EXnNc6aBbP4Zyt47R1bnjP2lVqnV
   XN1qJpEubpjoVDrQuydluXzANv65pEMwaNQ/E3HT4CHlTmuQhv9ETgtDz
   QgmU86p8sU9WqXz7mBidoGxAtaNk/FLtNSRxrOCHoLjlwFx07gKfo7zem
   D8+PQnbxRYTT293XcLU+UGxu5tT3SvpTewy9SGUm+KFtNujDczHAOcpeN
   Qq9rKFjFDF26iHxmZEdEpDKd1EZP50bSWq5nWxKdKSHKP7N/IeBLEU1fO
   w==;
Date:   Mon, 26 Sep 2022 15:42:30 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Mark Brown <broonie@kernel.org>
CC:     <krzysztof.kozlowski@linaro.org>, <andi@etezian.org>,
        <kernel@axis.com>, <alim.akhtar@samsung.com>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 4/4] spi: s3c64xx: Fix large transfers with DMA
Message-ID: <YzGsRkyf9tyvjvBy@axis.com>
References: <20220916113951.228398-1-vincent.whitchurch@axis.com>
 <20220916113951.228398-5-vincent.whitchurch@axis.com>
 <Yyh+5ZWXel9SHuWi@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Yyh+5ZWXel9SHuWi@sirena.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 03:38:29PM +0100, Mark Brown wrote:
> On Fri, Sep 16, 2022 at 01:39:51PM +0200, Vincent Whitchurch wrote:
> > The COUNT_VALUE in the PACKET_CNT register is 16-bit so the maximum
> > value is 65535.  Asking the driver to transfer a larger size currently
> > leads to the DMA transfer timing out.  Fix this by splitting the
> > transfer as needed.
> 
> The driver should just set max_transfer_size and let the core
> handle this.

Hmm, AFAICS, the core doesn't actually do anything with
max_transfer_size?  It's only used from spi-mem and a handful of other
clients via spi_max_transfer_size().
