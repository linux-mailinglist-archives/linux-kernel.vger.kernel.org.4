Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93806A4234
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 14:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjB0NFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 08:05:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjB0NFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 08:05:46 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721EA11EAB
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 05:05:44 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1pWdCI-0006PM-PC; Mon, 27 Feb 2023 14:05:42 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1pWdCI-0001VE-AZ; Mon, 27 Feb 2023 14:05:42 +0100
Date:   Mon, 27 Feb 2023 14:05:42 +0100
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
Subject: About regulator error events
Message-ID: <20230227130542.GM32097@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
From:   Sascha Hauer <sha@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have a board here which has some current limited power switches on it
and I wonder if I can do something reasonable with the error interrupt
pins these switches have.

The devices do not have a communication channel, instead they only have
an enable pin and an error interrupt pin. See
https://www.diodes.com/assets/Datasheets/AP22652_53_52A_53A.pdf for a
datasheet.  The devices come in two variants, one goes into current
limiting mode in case of overcurrent and the other variant switches off
until it gets re-enabled again.

At first sight it seemed logical to me to wire up the error interrupt
pins to REGULATOR_EVENT_OVER_CURRENT events. That was easy to do, but
now the question is: What can a regulator consumer do with these events?

The strategy I had in mind was to disable the regulator, enable it again
to see if the errors persists and if it does, permanently disable the
device.  Disabling the regulator only works though when there's only one
consumer.  With multiple consumers only the enable count decreases, but
the regulator itself stays enabled. This means implementing such a
policy at the consumer side is not generally possible. Implementing a
policy in the regulator core seems awkward as well, as a good strategy
likely differs between different consumers.

A first good step might be to notify the user somehow. While we can get
the overcurrent status of a regulator from
/sys/class/regulator/*/over_current there doesn't seem to be any way to
get a regulator event in userspace, right?  Would patches changing that
be welcomed?

There doesn't seem to be much prior art for handling regulator error
events in the kernel. It would be great to get some input what others do
in this situation, or to get some ideas what they would do if they had
the time to do so ;)

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
