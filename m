Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C889720262
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 14:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbjFBMrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 08:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235551AbjFBMqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 08:46:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC25196;
        Fri,  2 Jun 2023 05:46:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1F9465016;
        Fri,  2 Jun 2023 12:46:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AD9CC4339E;
        Fri,  2 Jun 2023 12:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685710008;
        bh=TEZWtUaffZaTohv4z8ErYTZOW3hUlO5th1d7OQki8AY=;
        h=From:To:Cc:Subject:Date:From;
        b=UL4aeSaqjL2wxem61uBQ8YL0bxdG6zfbEwL9/KN8lQpej5dpvznpaXc25I2n3T71N
         19Rud0tAjMnOMmMeg15gm0lE17EEtvnPCHH7JXo+Dn34AHpBPnnB2Z5iODx5q+26Yz
         m2E9Ar9x6Q0opfhyBtT+g925BMkMEm0E55xz6iUirPEjhmbRp/lVrapHukGbTYtUj4
         zdLDPUEMxZsxB9uax8FKiSPDAe0kPTHaAdyfnpflq1Z+2rXluee7wVz48UcVUdllyi
         XwhmtbJ398eqn9urJwMEq9FS5R0oXORhTD3PjPsbQZXskMZ2uQ+WEeWQmmMCZP9SDn
         N/Zj/Gv6X80yg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1q54BF-0004xx-6w; Fri, 02 Jun 2023 14:46:57 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corey Minyard <minyard@acm.org>
Subject: [PATCH 0/3] USB: serial: return errors from break handling
Date:   Fri,  2 Jun 2023 14:46:39 +0200
Message-Id: <20230602124642.19076-1-johan@kernel.org>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series starts returning errors from break handling and also uses
that mechanism to report to user space when break signalling is not
supported (e.g. when device or driver support is missing).

Note that the tty layer currently returns early but without reporting
errors when a tty driver does not support break signalling. The intent
expressed in commit 9e98966c7bb9 ("tty: rework break handling") from
2008 appears to be to allow missing support to be reported to user
space however.

Johan


Johan Hovold (3):
  USB: serial: return errors from break handling
  USB: serial: cp210x: disable break signalling on CP2105 SCI
  USB: serial: report unsupported break signalling

 drivers/usb/serial/ark3116.c          |  7 +++--
 drivers/usb/serial/belkin_sa.c        | 12 ++++++---
 drivers/usb/serial/ch341.c            | 37 +++++++++++++++++----------
 drivers/usb/serial/cp210x.c           | 14 +++++++---
 drivers/usb/serial/digi_acceleport.c  |  7 ++---
 drivers/usb/serial/f81232.c           |  4 ++-
 drivers/usb/serial/f81534.c           |  4 ++-
 drivers/usb/serial/ftdi_sio.c         | 10 +++++---
 drivers/usb/serial/io_edgeport.c      |  4 ++-
 drivers/usb/serial/io_ti.c            |  9 +++++--
 drivers/usb/serial/keyspan.c          |  5 +++-
 drivers/usb/serial/keyspan_pda.c      |  8 ++++--
 drivers/usb/serial/mct_u232.c         |  6 ++---
 drivers/usb/serial/mos7720.c          |  9 ++++---
 drivers/usb/serial/mos7840.c          |  7 ++---
 drivers/usb/serial/mxuport.c          |  6 ++---
 drivers/usb/serial/pl2303.c           | 14 ++++++----
 drivers/usb/serial/quatech2.c         |  8 ++++--
 drivers/usb/serial/ti_usb_3410_5052.c | 10 +++++---
 drivers/usb/serial/upd78f0730.c       |  7 +++--
 drivers/usb/serial/usb-serial.c       |  4 +--
 drivers/usb/serial/usb_debug.c        | 13 +++++++---
 drivers/usb/serial/whiteheat.c        |  7 ++---
 drivers/usb/serial/xr_serial.c        |  4 +--
 include/linux/usb/serial.h            |  2 +-
 25 files changed, 146 insertions(+), 72 deletions(-)

-- 
2.39.3

