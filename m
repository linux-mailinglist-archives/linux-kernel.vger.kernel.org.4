Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B78626259
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 20:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbiKKTqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 14:46:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233886AbiKKTq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 14:46:27 -0500
X-Greylist: delayed 17040 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Nov 2022 11:46:26 PST
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7F0814C8;
        Fri, 11 Nov 2022 11:46:25 -0800 (PST)
Received: from hillosipuli.retiisi.eu (82-181-192-243.bb.dnainternet.fi [82.181.192.243])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by meesny.iki.fi (Postfix) with ESMTPSA id EF7E4205E4;
        Fri, 11 Nov 2022 21:46:22 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1668195983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LqeaIvzF3E4QocGyD6uVMqLxFSDHdJcGyp7GpJMTECg=;
        b=VR87xCsfjrCBXeLraA2Y/tzT0CcYjCd3y4f0ma2d9zbysDJImCvhfC8WCPuMBBowZ+ttWV
        jzVYy2SQ0O/klT8mIQOe9K8Jh91SQ6onN13JeVzi7fSetdJa63bUgm0/hWglqhL3eHnd3a
        y7mONW2UsTpClUUmWEnP7kIq1uT1umM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1668195983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LqeaIvzF3E4QocGyD6uVMqLxFSDHdJcGyp7GpJMTECg=;
        b=BaAuZxrTBqM1SaxwNzFT2Bfgtik/y3mQtd9KYX05kUBfJ7jLcY2SPqTg0HxAuh3ImZql3T
        UQxq6KqlnhjgyIguJjWINYQaVKGrrww8Ya1Cpzj9MlddyYGkha/8byfnGofEUBfsuq/Vmc
        OP+tVabDuwC+Y9/c4sRJ241cXFp5sS4=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1668195983; a=rsa-sha256; cv=none;
        b=Y7wCReQexC9GavD6JsJRbFuTxOXU38neW4npJ2cLvwq0JemZR9xgF7nmh1U0xDCL6lEUII
        U4ibSurvLe0arIg0Vo/IVbd/w9atQRZgPtp7hrTmiYyDrvLYY7BJGoI3UUOANQFOS/gOEa
        QxCuqWnheiSSXpY1d06XrOogQi3mm1A=
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 797AF634C98;
        Fri, 11 Nov 2022 21:46:22 +0200 (EET)
Date:   Fri, 11 Nov 2022 21:46:22 +0200
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Shawn Tu <shawnx.tu@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v1 2/8] media: ov2740: Replace voodoo coding with
 understandle flow
Message-ID: <Y26mjpnYeqeqTPAn@valkosipuli.retiisi.eu>
References: <20220726120556.2881-1-andriy.shevchenko@linux.intel.com>
 <20220726120556.2881-2-andriy.shevchenko@linux.intel.com>
 <Y25j/rJWSYI1eT1E@valkosipuli.retiisi.eu>
 <Y25qgYsQNEGVTKeS@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y25qgYsQNEGVTKeS@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 05:30:09PM +0200, Andy Shevchenko wrote:
> On Fri, Nov 11, 2022 at 05:02:22PM +0200, Sakari Ailus wrote:
> > Hi Andy,
> > 
> > On Tue, Jul 26, 2022 at 03:05:50PM +0300, Andy Shevchenko wrote:
> > > Besides not being understandable at the first glance, the code
> > > might provoke a compiler or a static analyser tool to warn about
> > > out-of-bound access (when len == 0).
> > 
> > I've never seen one.
> > 
> > However the same pattern is repeatedly used by many, many drivers and
> > addressing just one doesn't make much sense.
> > 
> > The proper way to fix this would be to have a set of common CCI (Camera
> > Control Interface) functions that all drivers could use, and then switch
> > the drivers to use them.
> > 
> > This isn't currently a great fit for e.g. regmap but perhaps something
> > light on top of regmap-i2c could do the trick?
> 
> So, then we can skip this one, right?

Yes.

> 
> > The rest of the set seems good to me.
> 
> Thank you for the review, can you apply them, or should I send a v2 with
> dropped first patch?

Already done. I'm still doing more testing before pushing.

Thanks!

-- 
Sakari Ailus
