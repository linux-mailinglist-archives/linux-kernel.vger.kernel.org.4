Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C1D6069CB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 22:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiJTUro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 16:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiJTUrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 16:47:33 -0400
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB6A21F953
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 13:47:21 -0700 (PDT)
Received: from MUA
        by vps-vb.mhejs.net with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mail@maciej.szmigiero.name>)
        id 1olcQy-0007Uc-He; Thu, 20 Oct 2022 22:46:32 +0200
From:   "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] Fix direct renaming of hashed controls
Date:   Thu, 20 Oct 2022 22:46:20 +0200
Message-Id: <cover.1666296963.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

I've noticed that some of mixer controls on my sound card seem to
be partially broken on the 6.0 kernel - alsactl wasn't able to find them
when restoring the mixer state.

The issue was traced down to the recent addition of hashed controls lookup
in commit c27e1efb61c5 ("ALSA: control: Use xarray for faster lookups").

Since that commit it is *not* enough to just directly update the control
name field (like some of ALSA drivers were doing).
Now the hash entries for the modified control have to be updated too.

This patch set adds a snd_ctl_rename() function that takes care of doing
this operation properly for callers that already have the relevant
struct snd_kcontrol at hand and hold the control write lock (or simply
haven't registered the card yet).

These prerequisites hold true for all the call sites modified.
    
The core controls change and the emu10k1 patch were runtime tested.
Similar patches for other devices were only compile tested.

 include/sound/control.h         |  1 +
 sound/core/control.c            | 23 +++++++++++++++++++++++
 sound/pci/ac97/ac97_codec.c     | 32 ++++++++++++++++++++++++--------
 sound/pci/ca0106/ca0106_mixer.c |  2 +-
 sound/pci/emu10k1/emumixer.c    |  2 +-
 sound/pci/hda/patch_realtek.c   |  2 +-
 sound/usb/mixer.c               |  2 +-
 7 files changed, 52 insertions(+), 12 deletions(-)

