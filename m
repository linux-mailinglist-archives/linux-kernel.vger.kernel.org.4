Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A0D6F4F6B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 06:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjECESK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 00:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjECESI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 00:18:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0C91FCF;
        Tue,  2 May 2023 21:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=x21ZOyqwSO6akl9eeR4mmRhulhewI5kv9bFdmjbWKCU=; b=AHWCgdRImqZ8SLjE5Si39Zr/w2
        eTG00Ck5ii4BoHAOWS5HnXwslL7C5lqoHC3HFq3kDyqLEL5PFpuWEgFd+NB+tOMFJLc8YuIvPCZtU
        gTVxyFz5RJuKBp3GwXyo+hqS8voies41iDkSk/CoNIvblA2dZFrBNHJdlDV5AUR1leEYBiJ3PyMLi
        jhlxE8Q0QZXxTzUaiJwP+SL8K0XEr+hK9fFwFz76MVyEG/PlcSJHwivIV7IAolifer8nDrSstZ+DF
        fUJVKOwyir1uWk95PHoGBV65piKy5DTNo71fW4xIZyKmTAMPUsDc0oDaMrffxJvGIZ8EN6kBAGkKy
        q52u7XbQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pu3wH-003IJ3-0K;
        Wed, 03 May 2023 04:18:01 +0000
Date:   Tue, 2 May 2023 21:18:01 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Christoph =?iso-8859-1?Q?B=F6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Cc:     Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com,
        linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org, Thomas Voegtle <tv@lio96.de>
Subject: Re: [PATCH] drbd: do not set REQ_PREFLUSH when submitting barrier
Message-ID: <ZFHgefWofVt24tRl@infradead.org>
References: <20230502092922.175857-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230502092922.175857-1-christoph.boehmwalder@linbit.com>
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

On Tue, May 02, 2023 at 11:29:22AM +0200, Christoph Böhmwalder wrote:
>  	struct bio *bio = bio_alloc(device->ldev->backing_bdev, 0,
> -				    REQ_OP_FLUSH | REQ_PREFLUSH, GFP_NOIO);
> +				    REQ_OP_FLUSH, GFP_NOIO);

This isn't going to work.  flush bios are (somewhat confusingly)
implemented as writes with no data and the preflush flag.  So this
should be:

	REQ_OP_WRITE | REQ_PREFLUSH.

and it looks like whatever flushing this does hasn't wroked for a long
time.
