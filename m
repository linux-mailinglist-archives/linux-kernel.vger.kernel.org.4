Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7456D3113
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 15:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjDANgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 09:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDANgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 09:36:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5BF1B7EE;
        Sat,  1 Apr 2023 06:36:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A2053B80B4B;
        Sat,  1 Apr 2023 13:36:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EBD5C433EF;
        Sat,  1 Apr 2023 13:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680356172;
        bh=xWIPov0IQiaNQ96i3rNsCQsiBHiJ3C0LQ80p6KiqcNs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qJ5NJPF9v5QJKLs/1kJuHIUU/gx7mX7f91/idrdCE/ZihXnB8CVMykQ3+yVqzTUrY
         MG6U4/q1EC2SbaZGDa9BktQ2/CaVjjL4yVhMD9UTAnCFckBxqVnG3HRmDvlGXXNsnM
         wE+KVhb1nCxWz4PyhIZ3ic9bSxLkGxsOwhG8Datf1hUcJRWeH5rxQStR3nMd2UuaN9
         Tryf5RPmtuIPWDRpxp1bnupY50o3F6l8gVNfkicHMll2x7ZP1/5i4iwqAEVkKkseKq
         rmedcPS9iqVBDXNCjmShRKN4+2HOvrRCRGYydco74MyNruu6AfoVfVEVv+qo4CuQ7L
         e44cdCZI6uDHA==
Date:   Sat, 1 Apr 2023 14:51:21 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     William Breathitt Gray <william.gray@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iio: addac: stx104: Migrate to the regmap API
Message-ID: <20230401145121.1a64a113@jic23-huawei>
In-Reply-To: <ZCGBIAvr7OQLwNXv@smile.fi.intel.com>
References: <cover.1679867815.git.william.gray@linaro.org>
        <4ebc1b6b609a086846420954b893e914fd395384.1679867815.git.william.gray@linaro.org>
        <ZCGBIAvr7OQLwNXv@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> > +		do {
> > +			err = regmap_read(priv->aio_ctl_map, STX104_ADC_STATUS, &adc_status);
> > +			if (err)
> > +				return err;
> > +		} while (u8_get_bits(adc_status, STX104_CNV));  
> 
> Hmm... Isn't it a potential infinite loop (e.g., ther hardware / firmware
> is broken)?
> 
> Why not using regmap_read_poll_timeout() (or its atomic variant, depends on
> the case)?

Just to shortcut things as I'm looking at this.
That's currently handled in patch 2.  Argument being this is a direct conversion
of existing code, whereas changing to xxx_poll_timeout() is an improvement.

I'm fine with it just being rolled into first patch with a note in the patch
description though if that works better.

