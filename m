Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACE06C8F57
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 17:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbjCYQIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 12:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjCYQIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 12:08:47 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9F1FF06;
        Sat, 25 Mar 2023 09:08:44 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 5D89D1C0AB2; Sat, 25 Mar 2023 17:08:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1679760523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Iu3sMDpb2cGCTRvieQtO3ixStP5OjjgHrhtfj3Yc0Rc=;
        b=JetlJMBqxPen7cCBeun33m7ML49bqtZowkmUygKG6oC8Xnv33vQ7Jm2ZCnEy9peHHooj/E
        HgDUjkG9NzY5+mzprr2BOpiSm6aKque252LvbvYgUazU10C1khnSxPDVg+tU0wwUlyG9P3
        r8WfL4xZDpd7vhQPalKAack7X12amgU=
Date:   Sat, 25 Mar 2023 17:08:40 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jiri Kosina <jikos@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>
Subject: Re: [RESEND PATCH 1/2] HID: Add driver for RC Simulator Controllers
Message-ID: <20230325160838.GB1820@bug>
References: <20220822060936.769855-1-marcus.folkesson@gmail.com>
 <CAO-hwJ+3Yrr--cr=r5+jvs4A=A-cmDtrKQETo=YOYDC3nXTMBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO-hwJ+3Yrr--cr=r5+jvs4A=A-cmDtrKQETo=YOYDC3nXTMBg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > +Many RC controllers is able to configure which stick goes to which channel.
> > +This is also configurable in most simulators, so a matching is not necessary.

While it is configurable, we should try to do the good job "by default". Configuring controllers
can take hours, and it is not fun.

> > +The driver is generating the following input event for on channels:
> > +
> > ++---------+----------------+
> > +| Channel |      Event     |
> > ++=========+================+
> > +|     1   |  ABS_Y         |
> > ++---------+----------------+
> > +|     2   |  ABS_X         |
> > ++---------+----------------+
> > +|     3   |  ABS_RY        |
> > ++---------+----------------+
> > +|     4   |  ABS_RX        |
> > ++---------+----------------+
> > +|     5   |  BTN_A         |
> > ++---------+----------------+
> > +|     6   |  BTN_B         |
> > ++---------+----------------+

If one of these is normally used as throttle and rudder, it should be marked as such...

User can then remap it if he does not like the mapping.

Best regards,
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
