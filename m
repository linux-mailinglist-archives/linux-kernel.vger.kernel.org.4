Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1402A5F15EA
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 00:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbiI3WOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 18:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbiI3WOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 18:14:46 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E2817A98
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 15:14:44 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id a17so2359889ilq.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 15:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=z5VOVjfZc8rE2BNhn0bf5+8kLzBQOcSPW+d53aWdSkA=;
        b=LQqxIX6BY8P5EFcVwC1Z4pqZrJbk9eNzLPtfZclpe+g6jM1wTvs/oYhsld/iuumM91
         S3ty92+Fu/hvibwaQ4sxBxuGORtxoyshnPXLebkBxSJrfCMNxjGUzPPmYwrOaCPgmu4E
         V59+Q7OGvAxEEX3no5CBfJCbBDKjn0VOBiI9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=z5VOVjfZc8rE2BNhn0bf5+8kLzBQOcSPW+d53aWdSkA=;
        b=t8bh2s6A86tSlQQAdyycMEtYigxkOaqn3w6UWGnouzFrUELG3XagZ7iChM6/Y3AnLb
         PBfc3sd+K0X0Sa87gHU2oNm5cjFm4TH3iIqfelsPR5kX3bms64xS0gibzWliD2Rf9G7/
         JPzHAHmJUV+u0drxwr+SC5oZnPWQn9ZpzjiIMn1CVH1am/7EVkLhuhkbr6luQrL2p/9z
         vsVkKSFYb/uXHRGstH/w6NF7pRgFMpYg8mCPiTVox6IWatJsmxUJDCIrZ6kZuZTsEJBS
         WOLcsWmQjxXdUbvYCmHQ8UoYwhmBuXTVax5XO7fOzmkfvZW6DRxFHU+cSgMHSMnVjd6I
         /+rQ==
X-Gm-Message-State: ACrzQf3Mg+AJwbaNuqOXdaNTd2ilVQJuz50Q1dDVxPyXNd0QFruSo/Os
        Dl+Gc5MicSBkIoPVYDjLVzLuxw==
X-Google-Smtp-Source: AMsMyM7S133+gipFZ/Jhc33wwMYnDYxmhSQ0ysq0szhKEFykvwLBmliZjOWkAh+rUZULLALKWpbvCw==
X-Received: by 2002:a05:6e02:16c7:b0:2f6:6eb4:8df3 with SMTP id 7-20020a056e0216c700b002f66eb48df3mr5383168ilx.31.1664576083856;
        Fri, 30 Sep 2022 15:14:43 -0700 (PDT)
Received: from chromium.org (c-73-217-34-248.hsd1.co.comcast.net. [73.217.34.248])
        by smtp.gmail.com with ESMTPSA id s12-20020a02b14c000000b0035b0d6f3219sm1361275jah.75.2022.09.30.15.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 15:14:43 -0700 (PDT)
Date:   Fri, 30 Sep 2022 16:14:41 -0600
From:   Jack Rosenthal <jrosenth@chromium.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        Stephen Boyd <swboyd@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Julius Werner <jwerner@chromium.org>
Subject: Re: [PATCH v11] firmware: google: Implement cbmem in sysfs driver
Message-ID: <YzdqUX/zPvtyCmNm@chromium.org>
References: <20220929234432.3711480-1-jrosenth@chromium.org>
 <YzaNjlqc0GqmJt68@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzaNjlqc0GqmJt68@kroah.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-30 at 08:32 +0200, Greg KH wrote:
> symlink?  Ick, no, do not do that at all please.
> 
> As these are device attributes, just stick with them.  Don't do a crazy
> symlink into a non-device-attribute portion of the sysfs tree, by doing
> that you break all userspace tools and stuff like libudev will never
> even see these attributes.

I guess I can fill in some info here about the use case needed:
userspace tools (in this case, a tool called "crossystem") needs to look
up a CBMEM entry by ID and read it.  So, being able to find a fixed path
like /sys/firmware/cbmem/<id>/mem is significantly easier than scanning
all /sys/bus/coreboot/devices/coreboot*/id to find the right device
first.

What exactly do we break here by adding symlinks?  udev won't look into
/sys/firmware, right?

Or, is there another good alternative that we could use to find a CBMEM
entry by its id without needing to scan thru all coreboot bus type
devices?  Setting the device name to something more predictable (e.g.,
"cbmem-<id>") would require the coreboot bus type to "look ahead" and
notice it's a CBMEM entry before registering the device, which wouldn't
exactly be all that clean.

> > +What:		/sys/firmware/cbmem/
> > +Date:		August 2022
> > +Contact:	Jack Rosenthal <jrosenth@chromium.org>
> > +Description:
> > +		Coreboot provides a variety of data structures in CBMEM.  This
> > +		directory contains each CBMEM entry, which can be found via
> > +		Coreboot tables.
> 
> What happened to the coreboot name?

I removed it as it seemed like from your last message you didn't want
it?

> Why cbmem?  What is CBMEM?

I can add this to the next patch once I get clarifications on the above.

> Also, I asked before, but some note about "exposing all of these bios
> values to userspace is not a security issue at all" would be nice, if
> only to point at in a few years and say "wow we were naive"...

Right, I'll add this too.

Thanks,

Jack
