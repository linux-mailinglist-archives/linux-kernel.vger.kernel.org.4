Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3848731E1E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237315AbjFOQqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 12:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236686AbjFOQp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:45:26 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129B82D60;
        Thu, 15 Jun 2023 09:44:56 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-77aecbadfefso234365939f.3;
        Thu, 15 Jun 2023 09:44:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686847494; x=1689439494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xsMBqmgF0rY87deAgbWAVQ8J/025bqTGL9yMoTkGyWU=;
        b=SMlQunxbHbKK47ouyag+dETywVyhzD26dcONEs7vSOYhDWfjp8N7Z/XMkuhlvzV8Fk
         hPcRd7y62Xv8cIsYwlyklELVkv2mR5URg3qywtid5cFSFENxrRyXqlQ7vhlcLES598Re
         /d4XGmZavHl+0SKVK0WfYIjhCBuzpGWodJztAXIMi5N/aEfuHKqc39FmgQIAnlIzHl3u
         cQDVroFRHsW4yLo4EtjR83bENCQhGN18YC1l/9++Lg5dAR215J9NWtcD5A/X025+HxRZ
         ZmTyo3zAnmLlNLFsSH0kikHfW2/IOwqzJCO06Ko+4wlCs1qtkw4VyWqH6LFqUcYQyP2b
         NAlA==
X-Gm-Message-State: AC+VfDyuYJLiunlpq3F2OHoh9cfT7r/EtdaT1fnPJ8pftn94+JbY9Zbe
        XNbAvSvL2x/ZbZxNhhl40A==
X-Google-Smtp-Source: ACHHUZ71kVLmLSj4RnOUsJPwuM9aCjRiUNC1DqZl8ZeK+7GmQZnX14smCeAQpYiHRP1TlutY6DZBiw==
X-Received: by 2002:a6b:db14:0:b0:777:b765:661a with SMTP id t20-20020a6bdb14000000b00777b765661amr18187638ioc.14.1686847494494;
        Thu, 15 Jun 2023 09:44:54 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id i14-20020a02ca4e000000b00411b2414eb5sm5610532jal.94.2023.06.15.09.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 09:44:53 -0700 (PDT)
Received: (nullmailer pid 1173348 invoked by uid 1000);
        Thu, 15 Jun 2023 16:44:52 -0000
Date:   Thu, 15 Jun 2023 10:44:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH v1 1/1] of/platform: Propagate firmware node by calling
 device_set_node()
Message-ID: <20230615164452.GA1166619-robh@kernel.org>
References: <20230615145243.37095-1-andriy.shevchenko@linux.intel.com>
 <ZIsnaE95qIJ2DVzK@smile.fi.intel.com>
 <ZIsnvXztBQvtYw9b@smile.fi.intel.com>
 <ZIsoWBxb8aGdJ4ja@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIsoWBxb8aGdJ4ja@smile.fi.intel.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 06:03:52PM +0300, Andy Shevchenko wrote:
> On Thu, Jun 15, 2023 at 06:01:17PM +0300, Andy Shevchenko wrote:
> > On Thu, Jun 15, 2023 at 05:59:52PM +0300, Andy Shevchenko wrote:
> > > On Thu, Jun 15, 2023 at 05:52:43PM +0300, Andy Shevchenko wrote:
> > > > Insulate of_device_alloc() and of_amba_device_create() from possible
> > > > changes to fwnode_handle implementation by using device_set_node()
> > > > instead of open-coding dev->dev.fwnode assignments.
> > > 
> > > Side note. When I preparing this change I have noticed a lot of
> > > 
> > > 	dev_set_name(... dev_name())
> > 
> > Plus
> > 
> > 	dev_set_name(dev, ...)
> > 	...
> > 	dev_set_name(dev, ...)
> > 
> > on the same device will also give a memory leak.
> 
> Ah, seems false alarm, the kobject_set_name_vargs() frees the old one.
> Sorry for the noise for second point. But the first one still applies.
> 
> > > in the code which seems to me problematic in two ways:
> > > 1) (minor) the dev_set_name() may fail, no checks are there;

Is there anything besides a memory alloc failure? What will print a 
message already. Wouldn't we fail a bit later on when adding the 
device anyways?

In a rough count, 92 out of 500 cases check the return of 
dev_set_name().

Rob
