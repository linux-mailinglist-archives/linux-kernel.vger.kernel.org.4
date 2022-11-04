Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82239619725
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 14:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbiKDNKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 09:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbiKDNKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 09:10:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE02A28E0E
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 06:10:36 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1oqwSw-0000Yl-HE; Fri, 04 Nov 2022 14:10:34 +0100
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1oqwSw-002HHi-Oq; Fri, 04 Nov 2022 14:10:33 +0100
Received: from sha by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1oqwSv-004041-3P; Fri, 04 Nov 2022 14:10:33 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-usb@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 0/2] use-after-free issues in configfs
Date:   Fri,  4 Nov 2022 14:10:29 +0100
Message-Id: <20221104131031.850850-1-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series addresses a few problems with the users of the gether code.
The problem arises when a UDC is disconnected from a gadget created with
configfs doing a "echo '' > UDC". It seems the existing code is tested
up to the point where the gadget from configfs is up, tearing it down
still seems to make problems. I for myself am also not interested in tearing
it down, but I see use-after-free issues when doing a reboot -f.

The underlying problem is that the eth_dev returned by the gether code is used
for multiple bind/unbind cycles, but only initialized properly once.

The usb_gadget * is only valid between bind and unbind, so it is not a suitable
parent for the net_device whose lifetime spans multiple bind/unbind cycles.

I solved the issues for the f_ecm driver, similar problems exist in the other users
like f_eem or f_ncm as well. I can prepare patches for these once it's clear
that this is really the way to go.

Sascha Hauer (2):
  usb: gadget: u_ether: Do not make UDC parent of the net device
  usb: gadget: f_ecm: Always set current gadget in ecm_bind()

 drivers/usb/gadget/function/f_ecm.c   | 22 +++++++++-------------
 drivers/usb/gadget/function/u_ether.c |  4 ----
 2 files changed, 9 insertions(+), 17 deletions(-)

-- 
2.30.2

