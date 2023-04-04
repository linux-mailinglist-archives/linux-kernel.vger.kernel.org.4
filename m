Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352516D7034
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 00:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236649AbjDDWhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 18:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236565AbjDDWhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 18:37:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85800113
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 15:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680647818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s/FbBasFGKXho73GYLTBPrVyQLxAhNzEHS05zhrQhKI=;
        b=EJzNiTT5nTBN1UZblHDj3Z4uZDQLGL1yaln1r8T5RMCKVTcTF9XHuivHA5grcKNTy3XBLn
        1ODsMDk/QlrrJy68UBqbFArORPqaS4uIWkbQJNq0Mnki05farbwF2pn/JpMjyp95lntij/
        Ycsr5U3QCvarQgU7lnRh16RbHPKM1sQ=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-OWqtiNSePf2gAjX8QeEEHA-1; Tue, 04 Apr 2023 18:36:57 -0400
X-MC-Unique: OWqtiNSePf2gAjX8QeEEHA-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-54be7584b28so21265467b3.16
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 15:36:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680647817;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s/FbBasFGKXho73GYLTBPrVyQLxAhNzEHS05zhrQhKI=;
        b=444MWYTzQCWBhJ1BsyoG9EkcYeZE7EXlnnljT0iPf7LbUb6FIC23zxs3/mvYZxYFPw
         tnaEROf2wTFyqggXho24i3wXeOmFGC5QuLmuXOgYavn9Vutl+a+v2g2x05V32kq4kLi3
         bKbAA1796t2Zk9nq+mz7MJbOg0TmYoOM102shPxK4fSLchAtZF0bDzOjEXS0aaOkVRbI
         C09GLIgvOQb4B4H8+7Dl/NYKXso1GsMQmvTMXdNAVCPB2+TnnpxkGHV8MRBvS8ZySlgr
         uoxBHwrIl9yB+Kis7S1eIsd7U47EHZBhqGjO6qvzRq4XEuDTllbZ1clw1L6/BpH/1M+K
         44wQ==
X-Gm-Message-State: AAQBX9dgxun5gNJmO+ISz+tOoqSh8eBLav/nVDuOScl66Fbu8RD88yMe
        jOpqRoixplx9b21G7LEQuZ3Wa5lzCLTY3NH1c/7w3ZaDFVPMeDN8r8YGs6YwlZj3wzkpdLsDGhL
        e7NEQenP1crBvCewQ2Xa1302i
X-Received: by 2002:a25:5ec4:0:b0:b38:fad9:e1f4 with SMTP id s187-20020a255ec4000000b00b38fad9e1f4mr4523222ybb.27.1680647817159;
        Tue, 04 Apr 2023 15:36:57 -0700 (PDT)
X-Google-Smtp-Source: AKy350Z+Y1glYqpspXbrweNu5K2lTRooFyGui/4SyHZmHEz9m05Pv+DeGb42aYVw1FPLAl3eznsFiw==
X-Received: by 2002:a25:5ec4:0:b0:b38:fad9:e1f4 with SMTP id s187-20020a255ec4000000b00b38fad9e1f4mr4523202ybb.27.1680647816864;
        Tue, 04 Apr 2023 15:36:56 -0700 (PDT)
Received: from x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id d206-20020a251dd7000000b00b7767ca748asm3633950ybd.39.2023.04.04.15.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 15:36:56 -0700 (PDT)
Date:   Tue, 4 Apr 2023 18:36:53 -0400
From:   Brian Masney <bmasney@redhat.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     kernel test robot <lkp@intel.com>, jic23@kernel.org,
        llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        andriy.shevchenko@linux.intel.com, trix@redhat.com,
        lars@metafoo.de, nathan@kernel.org, ndesaulniers@google.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        hslester96@gmail.com
Subject: Re: [PATCH] iio: light: tsl2772: fix reading proximity-diodes from
 device tree
Message-ID: <ZCymhaDkRkfzk2kP@x1>
References: <20230404011455.339454-1-bmasney@redhat.com>
 <202304041451.gj8oasQp-lkp@intel.com>
 <ZCwGP6rBLgbDGvkv@x1>
 <20230404123544.6m5juesxwf4tklkm@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230404123544.6m5juesxwf4tklkm@pengutronix.de>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 02:35:44PM +0200, Uwe Kleine-König wrote:
> Hello Brian,
> 
> On Tue, Apr 04, 2023 at 07:13:03AM -0400, Brian Masney wrote:
> > This doesn't contain the code that's in iio/togreg [1], and that's why
> > the build failed. I originally developed / built this against
> > next-20230330. I just checked linus/master, next-20230404, iio/testing,
> > and all have the expected code that defines prox_diode_mask.
> > 
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/tree/drivers/iio/light/tsl2772.c?h=togreg#n593
> 
> You might want to make use of the --base parameter to git format-patch
> for you next submission. With that the auto builders have a chance to
> test on the right tree.

I'll add the --base parameter next time. However, I think the issue is
that this compiler error is triggered by this patch [1] that's not in
any maintainer trees. I suspect the kernel test robot still has that in
it's local tree from a previous round of testing against this driver.

[1] https://lore.kernel.org/lkml/20230327120823.1369700-1-trix@redhat.com/

Brian

