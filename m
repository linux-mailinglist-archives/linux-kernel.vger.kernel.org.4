Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5C15BBF26
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 19:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiIRRav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 13:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiIRRas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 13:30:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EA013EBF;
        Sun, 18 Sep 2022 10:30:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BB9F6160E;
        Sun, 18 Sep 2022 17:30:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60E9FC433D6;
        Sun, 18 Sep 2022 17:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663522246;
        bh=9bN4Sb6zWpLjEIEJ93UIyNQBpe7ibahRuy5/W0f0PMo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tUt7AsytnOHNhH6ka+yWLnmFH6/X035Qlo6kPaJJSEu1PDkzkPASZ3B9QVjHP4eUo
         Dlp3rW7rqmTIEIma43BW+yaX0AC3rCtONmMY+DsijX+p497Le8x7sN+7PBZ7ygstFe
         QSmym++KMrCTZwSB2Vlw3DOEYcFrTKHCpCL/1QAXBMCyL5flvcbj87mrOR0PncydJK
         9jWN64vthnqHyX5CW0O/3LoV+oJoitqHQhG0pV0weoHrrWA0cab2C1XNXQ4DRt61OQ
         pCe5BRVWqbx5KwoE3TtXSIEg8YBOrHkA6G+9i0eWhvpV7sqywqA+E2U18KQL35EUy4
         qFtI3qna63+/A==
Date:   Sun, 18 Sep 2022 18:30:48 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andrea Merello <andrea.merello@iit.it>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        jmondi <jacopo@jmondi.org>,
        Andrea Merello <andrea.merello@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [v7 00/14] Add support for Bosch BNO055 IMU
Message-ID: <20220918183048.3eb64f40@jic23-huawei>
In-Reply-To: <CAHp75Vd6wGPd6MJjEqB=dyrFj36CJi-QRFzy7WsvYgHZDNgG=Q@mail.gmail.com>
References: <20220907132205.28021-1-andrea.merello@iit.it>
        <CAHp75Vd6wGPd6MJjEqB=dyrFj36CJi-QRFzy7WsvYgHZDNgG=Q@mail.gmail.com>
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

On Wed, 7 Sep 2022 17:12:09 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Wed, Sep 7, 2022 at 4:22 PM <andrea.merello@iit.it> wrote:
> >
> > From: Andrea Merello <andrea.merello@iit.it>
> >
> > This series (tries to) add support for Bosch BNO055 IMU to Linux IIO
> > subsystem. It is made up several patches:  
> 
> 
> These
> 
> >   iio: imu: add Bosch Sensortec BNO055 core driver  
> 
> >   iio: imu: add BNO055 serdev driver  
> 
> are huge and I will look at them later on.
> 

I've taken another look at those and think that anything that comes
up should be minor enough we should fix / tidy up as follow on patches.

I'd like to get this some build coverage as it's big and complex. Hence I've
applied it to the togreg branch of iio.git / pushed out as testing.

More comments still welcome! Andy, if you get time to look at those two
large patches, that would still be great + thanks for all your work reviewing
this series and in general - it's a great help to me in keeping up with things.

Note I'll be rebasing that tree in the near future to get some dependencies
for other sets.

Andrea, nice work getting support in place for this complex / buggy / messy
device :)

Jonathan

> --
> With Best Regards,
> Andy Shevchenko

