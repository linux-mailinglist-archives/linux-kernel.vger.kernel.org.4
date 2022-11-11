Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908C6625DD7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 16:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234934AbiKKPG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 10:06:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234930AbiKKPEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 10:04:47 -0500
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF5672989;
        Fri, 11 Nov 2022 07:02:27 -0800 (PST)
Received: from hillosipuli.retiisi.eu (dkxjnptf9d2bpn7gcmbty-3.rev.dnainternet.fi [IPv6:2001:14ba:44ce:b640:9d1d:82c5:eca2:5060])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by meesny.iki.fi (Postfix) with ESMTPSA id 0098A200BD;
        Fri, 11 Nov 2022 17:02:23 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1668178943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qCcjDomMq8wDaaC2JnacJpNVQFK00WdGKnQ62ZAEKUU=;
        b=tb15t2GFR5XvrYE1g0iP+BLnplOva+t6jAVUZKxyWACAO/EbDmPxzO6T+Dipn5t2v2lL+E
        ZYbLy58YcH4rRPyAnqXc5ZZty8Gp27kxrKXK/KOaNDHsQHo6taHxdj3SZ9Y/sIn5hICl6Q
        5exfLZinFBlccwPC2pYOs832E0sdDZI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1668178943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qCcjDomMq8wDaaC2JnacJpNVQFK00WdGKnQ62ZAEKUU=;
        b=D/GxZ71VS9SL9k3zWA5SBpbfufkNK8H9vu1677v6CfF/N9DVe6FdzY5k2TXbwXWp/Ir8zg
        PFEbdg2REOzWxPRHv2QuMD3hxxDaK+YcZuw3A+QqFvVVcwVVYQ0uyjfCGwm0erTIp2VlyN
        SwoXu79tnwW9v1Dm64Yd8AvVtL3t5nI=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1668178943; a=rsa-sha256; cv=none;
        b=L+EkiBIr7j4v0oq+e2Phx9h0/jFGDFz8sqDiBKDxoHeOIn6mjSg61iyMyjbB0vi82KjJen
        pRO0rilGVHFtYgESXomPyRx8hPiXvYuv33d898tdPpV+f1mzmCuONgKC0CIGi2KayhRWX3
        Wt/0J1J5Pz2Xv9f66rY8S1VsJBELk9k=
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 86BBE634C99;
        Fri, 11 Nov 2022 17:02:22 +0200 (EET)
Date:   Fri, 11 Nov 2022 17:02:22 +0200
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Shawn Tu <shawnx.tu@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v1 2/8] media: ov2740: Replace voodoo coding with
 understandle flow
Message-ID: <Y25j/rJWSYI1eT1E@valkosipuli.retiisi.eu>
References: <20220726120556.2881-1-andriy.shevchenko@linux.intel.com>
 <20220726120556.2881-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726120556.2881-2-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Tue, Jul 26, 2022 at 03:05:50PM +0300, Andy Shevchenko wrote:
> Besides not being understandable at the first glance, the code
> might provoke a compiler or a static analyser tool to warn about
> out-of-bound access (when len == 0).

I've never seen one.

However the same pattern is repeatedly used by many, many drivers and
addressing just one doesn't make much sense.

The proper way to fix this would be to have a set of common CCI (Camera
Control Interface) functions that all drivers could use, and then switch
the drivers to use them.

This isn't currently a great fit for e.g. regmap but perhaps something
light on top of regmap-i2c could do the trick?

The rest of the set seems good to me.

-- 
Kind regards,

Sakari Ailus
