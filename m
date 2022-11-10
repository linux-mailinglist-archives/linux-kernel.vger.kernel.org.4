Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C228624810
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 18:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbiKJRRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 12:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiKJRRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 12:17:11 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3471146A;
        Thu, 10 Nov 2022 09:17:10 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id c15-20020a17090a1d0f00b0021365864446so2137396pjd.4;
        Thu, 10 Nov 2022 09:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2lVmgd5iU+DYuUAsCm9zf956y2hb5rpDqnPteUG5ac4=;
        b=qWCdTEiP5pQviSj+O54GiZmAoHPXK0RyCfkwi3DuBLECwS890sS1zUZ0xN3rVkwbFe
         /PuessvPsaYoGAtWygPt0T+UV6+Iir/W3NZ71kmM58q04a31/hUFylisA+t1tFCenbvF
         fNNsFZpMJN4NhdUDClBcxMShnJ83vphoAgdQxWxzpK1qOsShiLGKYTF/GbR9Uvv3Hiuz
         8c4zuZ+rQM/740i3Oz3IhpWBYcg5nJnymVDj12V7DbAnflKN8lkCutU/BBykzVWAtG8X
         NRwDrHa8EijttIiyy7GH7K2IYmj4TwhkXKjwKpWMMQh1aRBF8xIXGH2x9zpvFYFROnAy
         3dxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2lVmgd5iU+DYuUAsCm9zf956y2hb5rpDqnPteUG5ac4=;
        b=ulkKw1ThLq8bHdsKZf+kisjL8h9MPEXXqld9ngY08po+lVGlQ3CfZ+ITf6M1+mRnpJ
         THO8yQeyeb0/wlK4vfF0EdqSlmtwiKsrqhvP4zkGdCvjEAHYLXM0QuQ72/lk1DEQ4niK
         yWzIXENzFaTGhCT9IHsBofTEHQMGRmgFuj6jaYelpMMVtVt1UqrJCT2kHr2FKybyRND+
         IRRk46cSpJyMF3cTOHg9WitX1dQFDQmFlmsdZTFh3pDu2FnKFbU5q2CcS/drTumfpaUU
         4BU0s7iNRUxfBSJHHid2G3PBLEyCi4ZqSxcAA91FBLRKG3D8ZcZNv3D8bpdTTVuW/rWC
         DxFg==
X-Gm-Message-State: ACrzQf2G/a/P5NCX0HrTPgojhxfn7qA7O26/KcwcP1rar5GN6J4UCmpo
        1PALcs/pIwZyjVri+ooT6k8=
X-Google-Smtp-Source: AMsMyM4NM5BH+EEeld8afhNduczRl5sEVCUkHHUUXRK7D8MepJ09HG6rCFRLdfcKcf+AqZ0qjnXlMg==
X-Received: by 2002:a17:903:1209:b0:179:d027:66e6 with SMTP id l9-20020a170903120900b00179d02766e6mr66443580plh.67.1668100629918;
        Thu, 10 Nov 2022 09:17:09 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:6af4:9e55:5482:c0de])
        by smtp.gmail.com with ESMTPSA id je6-20020a170903264600b0017f7c4e260fsm11554164plb.150.2022.11.10.09.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 09:17:09 -0800 (PST)
Date:   Thu, 10 Nov 2022 09:17:06 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] gpiolib: add support for software nodes
Message-ID: <Y20yElFGvm2GLtE9@google.com>
References: <20221031-gpiolib-swnode-v2-0-81f55af5fa0e@gmail.com>
 <20221031-gpiolib-swnode-v2-6-81f55af5fa0e@gmail.com>
 <Y2uNDmRefzPvUu3P@smile.fi.intel.com>
 <Y2v6lxoCQvlRdr8q@google.com>
 <Y20BEuHlY2OEsZ0v@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y20BEuHlY2OEsZ0v@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 03:48:02PM +0200, Andy Shevchenko wrote:
> On Wed, Nov 09, 2022 at 11:08:07AM -0800, Dmitry Torokhov wrote:
> > On Wed, Nov 09, 2022 at 01:20:46PM +0200, Andy Shevchenko wrote:
> > > On Tue, Nov 08, 2022 at 04:26:51PM -0800, Dmitry Torokhov wrote:
> 
> ...
> 
> > > > +	pr_debug("%s: parsed '%s' property of node '%pfwP[%d]' - status (%d)\n",
> > > > +		 __func__, propname, fwnode, idx, PTR_ERR_OR_ZERO(desc));
> > > 
> > > %pe ?
> > 
> > "/* %pe with a non-ERR_PTR gets treated as plain %p */".
> > 
> > I do not think users are interested in the address on success.
> 
> Hmm... Perhaps we can teach %pe to behave differently with, e.g. %pe0,
> modification.

Yes, and maybe we could even have %e for normal errors ;)

> But this is another story. So, let's go with your variant.
> 
> ...
> 
> > > > +#include <dt-bindings/gpio/gpio.h>
> > > 
> > > Not sure why we have this here.
> > 
> > For convenience - so that users have access to GPIO_ACTIVE_HIGH/
> > GPIO_ACTIVE_LOW and other flags.
> 
> Okay, would we make this as a guarantee then?
> 
> In such case a comment before this inclusion should be added to explain why
> we do that without any actual user to be present in the header file.

Just to close the loop - I added a comment reflecting this in v3.

Thanks.

-- 
Dmitry
