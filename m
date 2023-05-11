Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FACF6FED0F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 09:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237547AbjEKHnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 03:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237535AbjEKHnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 03:43:07 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992F210FD;
        Thu, 11 May 2023 00:43:02 -0700 (PDT)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1px0x2-0005kb-GR; Thu, 11 May 2023 09:43:00 +0200
Date:   Thu, 11 May 2023 09:43:00 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] hwrng: imx-rngc - use bitfield macros to read fifo
 level
Message-ID: <20230511074300.ocfrmynne7e6wdkj@viti.kaiser.cx>
References: <20230427185357.923412-1-martin@kaiser.cx>
 <20230427185357.923412-2-martin@kaiser.cx>
 <ZFx6PXL9LzyDRoER@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFx6PXL9LzyDRoER@gondor.apana.org.au>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Herbert Xu (herbert@gondor.apana.org.au):

> On Thu, Apr 27, 2023 at 08:53:55PM +0200, Martin Kaiser wrote:

> > @@ -133,9 +133,7 @@ static int imx_rngc_read(struct hwrng *rng, void *data, size_t max, bool wait)
> >  			break;

> >  		/* how many random numbers are in FIFO? [0-16] */
> > -		level = (status & RNGC_STATUS_FIFO_LEVEL_MASK) >>
> > -			RNGC_STATUS_FIFO_LEVEL_SHIFT;
> > -
> > +		level = FIELD_GET(RNGC_STATUS_FIFO_LEVEL, status);

> Wouldn't it be simpler to just get rid of the shift?

Yes, we're only checking that level > 0, there's no need for the shift.
I'll submit a new version of the patch.

Thanks,
Martin
