Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6606BFBBE
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 18:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjCRRKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 13:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjCRRKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 13:10:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B80902A;
        Sat, 18 Mar 2023 10:10:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 555DD60E93;
        Sat, 18 Mar 2023 17:10:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C431BC433D2;
        Sat, 18 Mar 2023 17:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679159410;
        bh=/3E93eDxIOX8EK9p7cuqtFkmu3KI8NbUB/mWijVw6aM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tBfGXlFfqnqF7sLnLOt8V/eReBlwCSRhspkn0GWFlFYikTKsC3n7HJkGP8ic9A/ic
         vO+Qi4Dhx+AxW9mhIkCXTFHRUU3eRbhgzCJHLZyfPgE01vDhof4sHqjoeH96vgZgiV
         ViFkpJJ8PcvfBTTpes7QpdRuCtWzfWzTevu5mWL1Nfg8c3lBS0ePUBgxStnH7Q7jlo
         CKe2eIU7PfP1LoAL4AzjB1PVQEjFNuARfkDJOkwW6KntC7zZUyiUurKDnN2F2ZB8B5
         FbuzM/00g/YcJWl/OB7iNHJpbPUwzO5Qsj9KoAXG6jZD1w4DGxJbBcKQVz+vFj4Bop
         BtDw+OFWJJ/jQ==
Date:   Sat, 18 Mar 2023 17:24:56 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 2/6] iio: light: Add gain-time-scale helpers
Message-ID: <20230318172456.4190c9f4@jic23-huawei>
In-Reply-To: <bad05e06-3b37-b435-bfac-962aef36cc97@gmail.com>
References: <cover.1678093787.git.mazziesaccount@gmail.com>
        <a4cb9a34ca027867ac014ffe93ca7e8245ce263f.1678093787.git.mazziesaccount@gmail.com>
        <ZAXiKfRbsXpHhwAJ@smile.fi.intel.com>
        <20230312165100.45de0c9b@jic23-huawei>
        <bad05e06-3b37-b435-bfac-962aef36cc97@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> >>> +/*  
> >>
> >> If it's deliberately not a kernel doc, why to bother to have it looking as one?
> >> It's really a provocative to some people who will come with a patches to "fix"
> >> this...  
> > 
> > Just make it kernel-doc.
> >   
> 
> Are you sure...? I don't like the idea of polluting generated docs with 
> documentation for this type of tiny internal pieces not usable outside 
> this component anyways...

You can use :internal or :external to pick up only the docs you want
when including this stuff form a .rst file.

https://docs.kernel.org/doc-guide/kernel-doc.html


> 
> >>  
> >>> + * iio_gts_get_gain - Convert scale to total gain
> >>> + *
> >>> + * Internal helper for converting scale to total gain.
> >>> + *
> >>> + * @max:	Maximum linearized scale. As an example, when scale is created
> >>> + *		in magnitude of NANOs and max scale is 64.1 - The linearized
> >>> + *		scale is 64 100 000 000.
> >>> + * @scale:	Linearized scale to compte the gain for.
> >>> + *
> >>> + * Return:	(floored) gain corresponding to the scale. -EINVAL if scale
> >>> + *		is invalid.
> >>> + */  
> >   
> >> ...
> >> 
