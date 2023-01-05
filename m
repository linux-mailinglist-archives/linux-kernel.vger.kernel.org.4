Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697A465F679
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 23:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235605AbjAEWJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 17:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236192AbjAEWIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 17:08:52 -0500
Received: from ryne.moe (ryne.moe [157.90.134.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D6E1A6E41B;
        Thu,  5 Jan 2023 14:08:34 -0800 (PST)
Received: from adrastea.localnet (unknown [170.55.83.2])
        by ryne.moe (Postfix) with ESMTPSA id B45701900401;
        Thu,  5 Jan 2023 22:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redstrate.com;
        s=default; t=1672956513;
        bh=r6XnwZZkbxtki7WdFdm9xTSDHdb0DlUFmv8n6lO6Zl8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Iz43PPr2zlar4TgT0HB4dZeEI8/C8DlhXuMX/j0FHgY3owHVWpBQ3rDFalG0dgkrI
         axgiJG+tjEHmeVQ5xKGPfHAgHyEFMsMEFLRFOOauE++bZ/DbneBB3O/j4q73GPyGFv
         dwADVT1RrjC4VHi+Op0HY68nr/wp+tvvaB0Sw/W0=
From:   redstrate <josh@redstrate.com>
To:     =?ISO-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
Cc:     linux-input@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] HID: uclogic: Add support for XP-PEN Artist 22R Pro
Date:   Thu, 05 Jan 2023 17:08:29 -0500
Message-ID: <4810275.31r3eYUQgx@adrastea>
In-Reply-To: <Y7cLJpgnP50JzHps@fedora>
References: <2068502.VLH7GnMWUR@adrastea> <20230102194911.56083-1-josh@redstrate.com>
 <Y7cLJpgnP50JzHps@fedora>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I see this event codes in a test device mock in libinput, but I wonder
> if we could/should use BTN_9 instead of skiping a few IDs here.
> 
> Honestly, I don't now what should be the right approach in this case,
> let's see if someone else comments on this topic.

I forgot about BTN_9, that should be an easy change. I already merged changes 
upstream in systemd/udev to mark devices with these buttons correctly - so, 
sunken cost and all that :-)

> I think that you could use uclogic_params_parse_ugee_v2_desc() and
> change the number of buttons in the template afterwards. It'd avoid
> some code duplication.

Yeah I think that's what I'll do, I was thinking of reusing it and just 
overriding parameters if needed.

> There are some XP-Pen PRO devices handled by the other init function.
> Maybe we could rename this function to something more specific to your
> device.

Ah okay, it's pretty specific to this device anyway - so I'll rename the 
function so it's clear what it's purpose is. I wasn't sure if future XP-PEN 
Pro work was going to reuse this function, but I guess we'll rename it if that 
happens!

> You can use "uclogic_ugee_v2_probe_endpoint" here.

Good catch! Will change.

> User-space lacks support for dials, but, with this descriptor, would it
> be possible to differenciate between the 2 dials to, for example,
> assign them different actions? Or would them be exposed as the same
> dial?
> 
> I have no idea how would user-space see this, but it'd interesting to
> see how libinput handles it.

Currently userspace sees this as REL_WHEEL and REL_HWHEEL, but like
mentioned libinput currently rejects mouse wheel events from tablet pads.
The fact that they previously worked before these patches is because udev
misclassified the pad device as a mouse. I'm working upstream to expose dials 
on tablet pads in libinput (I just got the green light so I'll be working on 
that shortly!)

> You can cherry-pick my patch refactoring this variables and send it as
> part of your series. I think that it might help maintainers with the
> merge and it'd also fix the problem reported by the test robot.

Ooh good point, I didn't even consider doing that. Next version will have it 
split up into two then.




