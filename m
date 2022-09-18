Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462625BBE7E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 16:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiIROiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 10:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiIROh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 10:37:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691CA2229E;
        Sun, 18 Sep 2022 07:37:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97E8160277;
        Sun, 18 Sep 2022 14:37:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9832C433D6;
        Sun, 18 Sep 2022 14:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663511864;
        bh=CZnPFkkOMrAlVZffJ1MfzuwNQ9Z1Qa7Has7+Mqxq+Lw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Cl6+qAoF9HqSWCCUtvlpHfGyXIV9F9LR6NfJF4ro2XIGSHEYRfyX9xeEYX3D+utN8
         cmKq/bu2EOsrbUMJRWiytzGd4O1GczJ4CdGHqjlCFbfITsTbmMugF4wCYnCSxnmPHC
         ja9Oo506+s7+XyqhYpJUCNB29o95UgLhJLvyMExqs11C7nlxT9tQinOGGBPdIegcai
         FKP0gxa4UuAwJJAa4jYf5rdK7gp83gBQEN5PkWGubXcXqcZvVN1jg+4lRehMzzNYlU
         F1Mc8AgMf8dCOruJz1KFwFlgFVs4PQ2HxTxetdSOqoyMmNTFdgjPEaXTUe2lkauWmG
         yzrywD+Mi6ZLg==
Date:   Sun, 18 Sep 2022 15:37:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 7/9] iio: pressure: bmp280: Add support for BMP380
 sensor family
Message-ID: <20220918153747.6382c15d@jic23-huawei>
In-Reply-To: <2d7334210b41b256f6d7dc2cfd34036375ebf755.camel@gmail.com>
References: <cover.1663025017.git.ang.iglesiasg@gmail.com>
        <f1da2a2f1bc5bb083f318335c23b4f3d9bb8e536.1663025017.git.ang.iglesiasg@gmail.com>
        <20220917142516.3fc145b6@jic23-huawei>
        <2d7334210b41b256f6d7dc2cfd34036375ebf755.camel@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Sun, 18 Sep 2022 12:06:45 +0200
Angel Iglesias <ang.iglesiasg@gmail.com> wrote:

> On Sat, 2022-09-17 at 14:25 +0100, Jonathan Cameron wrote:
> > On Tue, 13 Sep 2022 01:52:13 +0200
> > Angel Iglesias <ang.iglesiasg@gmail.com> wrote:
> >   
> > > Adds compatibility with the new generation of this sensor, the BMP380.
> > > 
> > > Includes basic sensor initialization to do pressure and temp
> > > measurements and allows tuning oversampling settings for each channel.
> > > 
> > > The compensation algorithms are adapted from the device datasheet and
> > > the repository https://github.com/BoschSensortec/BMP3-Sensor-API.
> > > 
> > > Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>  
> > There is one place (around the reset handing) in here where I
> > suspect we'll end up revisiting it because the matching by
> > device ID is not particularly extensible to new devices.  
> 
> Yeah, after the first time you raised that concern I've been thinking that maybe
> it would be better to add a new "init" or "preinit" callback executing first
> boot tasks for a sensor, such as this reset. Please, let me know how I can help
> with this matter. On the other hand, I'll have the BMP390 and BMP581 on my hands
> in a week or two. The BMP390 is almost the same regmap and operations as the
> BMP380, so I think it will be an easy addition. The BMP581 is a new beast that
> brings in lots of changes, but still has a good bunch of similarities.

Agreed, an .init()/.preinit() callback might make sense.

Given you are planning to look at new parts, perhaps wait until you
have a series adding one of those rather than creating churn in the
driver before that point.  Perhaps the BMP581 will require changes
in this area of the driver anyway and we don't want to end up
changing it twice!

Thanks,

Jonathan
