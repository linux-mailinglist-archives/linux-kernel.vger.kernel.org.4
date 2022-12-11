Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F33649410
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 13:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiLKMCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 07:02:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiLKMCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 07:02:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89092F036;
        Sun, 11 Dec 2022 04:02:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3FF8FB80AB3;
        Sun, 11 Dec 2022 12:02:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF8CC433D2;
        Sun, 11 Dec 2022 12:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670760132;
        bh=lwrP2pMvzdIwx28QuEg3xbeSocm7aAljFfuV3vqedLM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GyeXbdLF1BKCvVRqSiS42ttcN/aM1cjADHLaFTN2Ozzi4UNkUkTUo5Z2ThxHGdUTb
         5Cgo9yf4NH7WRfptStXb8ISLi45HyYFEFXfbrZO6OMaREVuxzeKJphp/nWxbnbFSep
         gqcvFafNvGnAwGhdRt5BwPcCKXpX6MDMmPsRHBCesGckaSToFyLF/SAbOtdT5LuX3a
         pNMmS7Ly95QVm/DUHyNFsEDJGoGKArb89q0eaSzGCp3jXXGWohtBQHFlDgyBpKrCR8
         0DET7pJ8glLLfCQ7o/WtPdmtsu1fZj5/EW7Q5ZFQM2tzsPINFMdZkIWpF62UIByO3f
         nTZ5erJFE9riw==
Date:   Sun, 11 Dec 2022 12:15:06 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     ye.xingchen@zte.com.cn, lars@metafoo.de, linmq006@gmail.com,
        u.kleine-koenig@pengutronix.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: magnetometer: bmc150_magn: Convert to use
 sysfs_emit_at() API
Message-ID: <20221211121506.4d694c74@jic23-huawei>
In-Reply-To: <CAHp75VfJx84-J2GdOWQAPAtMhPVS3X-dEuHYQqyP4a0WjDsgdQ@mail.gmail.com>
References: <202212071549349412843@zte.com.cn>
        <CAHp75VfJx84-J2GdOWQAPAtMhPVS3X-dEuHYQqyP4a0WjDsgdQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Dec 2022 10:46:14 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Wed, Dec 7, 2022 at 9:49 AM <ye.xingchen@zte.com.cn> wrote:
> >
> > From: ye xingchen <ye.xingchen@zte.com.cn>
> >
> > Follow the advice of the Documentation/filesystems/sysfs.rst and show()
> > should only use sysfs_emit() or sysfs_emit_at() when formatting the
> > value to be returned to user space.  
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmai.com>
> 
> > Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> > ---
> >  drivers/iio/magnetometer/bmc150_magn.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
> > index 06d5a1ef1fbd..1398684a7f30 100644
> > --- a/drivers/iio/magnetometer/bmc150_magn.c
> > +++ b/drivers/iio/magnetometer/bmc150_magn.c
> > @@ -598,8 +598,7 @@ static ssize_t bmc150_magn_show_samp_freq_avail(struct device *dev,
> >         for (i = 0; i < ARRAY_SIZE(bmc150_magn_samp_freq_table); i++) {
> >                 if (bmc150_magn_samp_freq_table[i].freq > data->max_odr)
> >                         break;
> > -               len += scnprintf(buf + len, PAGE_SIZE - len, "%d ",
> > -                                bmc150_magn_samp_freq_table[i].freq);
> > +               len += sysfs_emit_at(buf, len, "%d ", bmc150_magn_samp_freq_table[i].freq);
> >         }

I'd prefer we keep the line break before the last parameter.

Generally in IIO at least, preference is for < 80 chars except where readability is
significantly enhanced by a longer line.  That's not true in this case.

Jonathan


> >         /* replace last space with a newline */
> >         buf[len - 1] = '\n';
> > --
> > 2.25.1  
> 
> 
> 

