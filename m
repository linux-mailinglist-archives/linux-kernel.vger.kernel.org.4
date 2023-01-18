Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE35A672929
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 21:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjARURJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 15:17:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjARURG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 15:17:06 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D28623867
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 12:17:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 61C02CE1EAE
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 20:17:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A519C433EF;
        Wed, 18 Jan 2023 20:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674073019;
        bh=msoGIYgablHSNKwDU/Zm9G1C1buCYXqRT7uaWOhwWLo=;
        h=Date:From:To:cc:Subject:From;
        b=XKQXp9qK5gIlaaRf44THdHNTXYaLWrWNfCnHoopLtJXyoYjbaVIQ6jcQ8DrbeyjFF
         KmkioY4z7CDv+fCn2+u9q3Wj3enbAvtT5GxbaFVbKPpX1pZ0nbqgrpjrHYwa5yaJil
         N59pAOZbRqjo10gWme00m/xUDsjx7GTy1yOFbTm6kCpeMDgq6g4yCBdrZ4noqfFwjQ
         1z2nK0KhLl6re4QoPuqAcG+p+qvwMdYOyAJBNDxgpEzNVFZ0QfPBaKKezDqtTHBSLO
         dPu6PeA8mtma860OZkIL5vY2Ba4jSHVFTOB6rPR5Hf4YsQCBkv+o1VfiIn5Lnz/Tnb
         FEBhSwxVER97w==
Date:   Wed, 18 Jan 2023 21:17:00 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID fixes
Message-ID: <nycvar.YFH.7.76.2301182112010.1734@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2023011801

to receive fixes for HID subsystem.

=====
- fixes for potential empty list handling in HID core (Pietro Borrello)
- fix for NULL pointer dereference in betop driver that could be triggered 
  by malicious device (Pietro Borrello)
- fixes for handling calibration data preventing division by zero in 
  Playstation driver (Roderick Colenbrander)
- fix for memory leak on error path in amd-sfh driver (Basavaraj Natikar)
- other few assorted small fixes and device ID-specific handling
=====

Thanks.

----------------------------------------------------------------
Basavaraj Natikar (1):
      HID: amd_sfh: Fix warning unwind goto

Jiasheng Jiang (1):
      HID: intel_ish-hid: Add check for ishtp_dma_tx_map

Jiri Kosina (1):
      HID: revert CHERRY_MOUSE_000C quirk

José Expósito (1):
      HID: uclogic: Add support for XP-PEN Deco 01 V2

Pietro Borrello (3):
      HID: check empty report_list in hid_validate_values()
      HID: check empty report_list in bigben_probe()
      HID: betop: check shape of output reports

Roderick Colenbrander (2):
      HID: playstation: sanity check DualShock4 calibration data.
      HID: playstation: sanity check DualSense calibration data.

 drivers/hid/amd-sfh-hid/amd_sfh_client.c      |  2 +-
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c |  2 +-
 drivers/hid/hid-betopff.c                     | 17 ++++----
 drivers/hid/hid-bigbenff.c                    |  5 +++
 drivers/hid/hid-core.c                        |  4 +-
 drivers/hid/hid-ids.h                         |  2 +-
 drivers/hid/hid-playstation.c                 | 63 +++++++++++++++++++++++++++
 drivers/hid/hid-quirks.c                      |  1 -
 drivers/hid/hid-uclogic-core.c                |  2 +
 drivers/hid/hid-uclogic-params.c              |  2 +
 drivers/hid/intel-ish-hid/ishtp/dma-if.c      | 10 +++++
 11 files changed, 96 insertions(+), 14 deletions(-)

-- 
Jiri Kosina
SUSE Labs

