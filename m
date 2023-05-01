Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520646F32EB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 17:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbjEAPdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 11:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjEAPc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 11:32:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CEB118;
        Mon,  1 May 2023 08:32:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D91A7616DE;
        Mon,  1 May 2023 15:32:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FCFAC433D2;
        Mon,  1 May 2023 15:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682955177;
        bh=MvuETEoacr5bq53WzR8YZikS4Thl13VEKTBpvEqCcNA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qkGJVcaqQ5lDiIjCfO2G2dtZDC6KU3mjtZvL4nkBGjtykU9bmkCuwAV1IAgSarPh3
         9FmJTN5WUOpZMlPRbov1x3R9KxdfrRodTnH3CSSeffDJ9NeqovA9GOJ9rVW1i7Er3Q
         t4DttR0CNMztvKMCL34aNvLRQNXX+FFoX6/oyAHdqT2DF3kTs3bZLDZsom3CbKFKe6
         H/jNKpebNOjoHFBeHS3EOqqS+25v5NbEM7jSJvBDIw5c1KY+0FFcwAQIoQNw6JgRbF
         ljuqlfAkr24mPeTUNSC89Be9z389Bm9biyEE6AEUvdohuKsuNOM+p2qlmUEYPcYZJt
         aYiyU9xtQnm2A==
Date:   Mon, 1 May 2023 16:48:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: gts-helpers: fix integration time units
Message-ID: <20230501164843.18d9ec6f@jic23-huawei>
In-Reply-To: <ec06f796-24f7-c3a4-c22e-f568bcc08522@fi.rohmeurope.com>
References: <cover.1681722914.git.mazziesaccount@gmail.com>
        <eeacd192c259e885850b5a2dd8b776bccfc44fa8.1681722914.git.mazziesaccount@gmail.com>
        <20230423121815.6d7c8039@jic23-huawei>
        <ec06f796-24f7-c3a4-c22e-f568bcc08522@fi.rohmeurope.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Apr 2023 05:09:36 +0000
"Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com> wrote:

> On 4/23/23 14:18, Jonathan Cameron wrote:
> > On Mon, 17 Apr 2023 12:20:18 +0300
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >   
> >> The IIO ABI mandates expressing integration times in seconds. The GTS
> >> helper errorneously uses micro seconds in integration_times_available.
> >> Fix this by converting the lists to IIO_VAL_INT_PLUS_MICRO.
> >>
> >> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> >> ---
> >>   drivers/iio/industrialio-gts-helper.c | 43 ++++++++++++++++++++-------
> >>   1 file changed, 33 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrialio-gts-helper.c
> >> index 8bb68975b259..2ab8d2dce019 100644
> >> --- a/drivers/iio/industrialio-gts-helper.c
> >> +++ b/drivers/iio/industrialio-gts-helper.c
> >> @@ -337,6 +337,17 @@ static int iio_gts_build_avail_scale_table(struct iio_gts *gts)
> >>   	return ret;
> >>   }
> >>   
> >> +static void iio_gts_us_to_int_micro(int *time_us, int *int_micro_times,
> >> +				    int num_times)
> >> +{
> >> +	int i;
> >> +
> >> +	for (i = 0; i < num_times; i++) {
> >> +		int_micro_times[i * 2] = time_us[i] / 1000000;
> >> +		int_micro_times[i * 2 + 1] = time_us[i] % 1000000;
> >> +	}
> >> +}
> >> +
> >>   /**
> >>    * iio_gts_build_avail_time_table - build table of available integration times
> >>    * @gts:	Gain time scale descriptor
> >> @@ -351,7 +362,7 @@ static int iio_gts_build_avail_scale_table(struct iio_gts *gts)
> >>    */
> >>   static int iio_gts_build_avail_time_table(struct iio_gts *gts)
> >>   {
> >> -	int *times, i, j, idx = 0;
> >> +	int *times, i, j, idx = 0, *int_micro_times;
> >>   
> >>   	if (!gts->num_itime)
> >>   		return 0;
> >> @@ -360,6 +371,7 @@ static int iio_gts_build_avail_time_table(struct iio_gts *gts)
> >>   	if (!times)
> >>   		return -ENOMEM;
> >>   
> >> +  
> > 
> > Grumble.  
> 
> Oh. I wonder how things like this tend to slip-in. Maybe I should change 
> my password, it must be someone else has cracked my it and is typing 
> these in at night while I am sleeping ^_^;
> 
> > If nothing else comes up I'll tidy that stray line up when applying.  
> 
> Thanks!
> 
> > Note that these will need to wait for after rc1 now so my fixes branch
> > has moved on to include the code being fixed.  
> 
> Well, that's Ok. Please, let me know if you want me to rebase to rc1 and 
> respin the series.
No need as not much changed around these (not I'm not at rc1 yet, but
char-misc-linus now includes these so I rebased on that)

Applied to the fixes-togreg branch of iio.git with fixes tags added now
the commits are upstream.

Thanks,

Jonathan

> 
> --Matti
> 

