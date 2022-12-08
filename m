Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8913C647277
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiLHPG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:06:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbiLHPGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:06:53 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7829D2E0
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 07:06:47 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id b13-20020a17090a5a0d00b0021906102d05so1808762pjd.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 07:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+79/rVNDN1N1SEjLcBAvHUJ9oDu58WUQ9a221hxPVg=;
        b=r6C6cM8tJS7nLq3dPhUaUvYuhBWqpXXoJBn9BftBTVhpB8h8uDfhlZj+q2OTBluKuS
         hcoaypjVnnA1BC0iA+54r/xIFhhwuyabeF8qQGDVdBV80fIK1NeDH88Vsc62OE8oQ5zc
         WU3+eyNwMEhUSF9o8vG9n2oS+E1RBR6tWoMly6RtmGXAP0kpEGQ4KcblKp/vz3Kne+t+
         detBJcxiiE70B/8vemw2TjDSXm54fzueXdxp0rr4S/+CABoRo3YPFEdtzqc/VADT2pzb
         7pjoaJtXq71UymkmHj3F/zBCBBjsuU0en+weIiOswLRATrF1l1OTJn4e240nHRl2JoMg
         3tww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z+79/rVNDN1N1SEjLcBAvHUJ9oDu58WUQ9a221hxPVg=;
        b=1N+xx3Tfony3EijvyrNwaC1G1j7BPoGZoq07Kdh8X7W8QxBf2L4NwX2r0rCbFTx1tE
         QTTyvrTImm3+H5IzhRhY6baWeMnA+9VZz3jM/d9MZ4WTw77GBfHEBov4J6P3naD/ZQs8
         LDRsCosZnGEXm+mr9CyTwj84Cuf029hhzNUHK6dHvKXD41InVZ6B9zNU3YvA7KKhx1iu
         0T2tq73SXmz/LoYd5gxXtRvGJu+Hpu2wJUt06JI4bIZ33RDRViRV0x8CPYKnAHoaTcZt
         JIAkVXsOyn0WjPH0BCSaBdfgzAaRxhtv8JQjKX1fwKCKDuJt1JMvrqCwLsC/bMZpHquE
         KzzA==
X-Gm-Message-State: ANoB5plbPaJ0kHXbO+igAo2IbALIQ14x9RB0Kui9xONaSGM7rY6IfYxs
        qJlBPabGMii+HaYE/8KMyiuK1UfgoBZsrjtez767yw==
X-Google-Smtp-Source: AA0mqf6ryelLIcJtPAb2S5cW1UuwsQpCmsk2//hxrXbnzUoJGrRIS3IouQwBJglIvXqdE9OWXGNry025D53F6/YrY+Y=
X-Received: by 2002:a17:90a:6b85:b0:219:95eb:e11 with SMTP id
 w5-20020a17090a6b8500b0021995eb0e11mr29820246pjj.152.1670512006650; Thu, 08
 Dec 2022 07:06:46 -0800 (PST)
MIME-Version: 1.0
References: <20221208020043.374033-1-badhri@google.com> <Y5GMUzmkfU6qWZgS@kroah.com>
In-Reply-To: <Y5GMUzmkfU6qWZgS@kroah.com>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Thu, 8 Dec 2022 07:06:10 -0800
Message-ID: <CAPTae5KmmYoxcQWGC7yBjyZYqZn7PXLdN4jag=5Zv0RAqYyu_g@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] usb: typec: tcpm: Add callbacks to mitigate
 wakeups due to contaminant
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies ! fixed it in Version 6.

On Wed, Dec 7, 2022 at 11:03 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Dec 07, 2022 at 06:00:41PM -0800, Badhri Jagan Sridharan wrote:
> > On some of the TCPC implementations, when the Type-C port is exposed
> > to contaminants, such as water, TCPC stops toggling while reporting OPEN
> > either by the time TCPM reads CC pin status or during CC debounce
> > window. This causes TCPM to be stuck in TOGGLING state. If TCPM is made
> > to restart toggling, the behavior recurs causing redundant CPU wakeups
> > till the USB-C port is free of contaminant.
> >
> > [206199.287817] CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING, polarity 0, disconnected]
> > [206199.640337] CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING, polarity 0, disconnected]
> > [206199.985789] CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING, polarity 0, disconnected]
> > ...
> >
> > TCPM invokes is_potential_contaminant callback to allow low level chip
> > drivers to monitor TCPM state machine transitions and notify TCPM when
> > the Type-C port needs to be checked for potential contaminant presence.
> > TCPCs which do have the needed hardware can implement the check_contaminant
> > callback which is invoked by TCPM to evaluate for presence of contaminant.
> > Lower level TCPC driver can restart toggling through TCPM_PORT_CLEAN event
> > when the driver detects that USB-C port is free of contaminant.
> >
> > Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> > Change-Id: I136d788bb46d871d12e64bd73fd50a77b4659dbf
> > ---
>
> Always run checkpatch.pl on your patches so you don't get a grumpy
> maintainer asking why you didn't run checkpatch.pl on your patches :(
