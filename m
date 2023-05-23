Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2250B70D638
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235554AbjEWH4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235937AbjEWHy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:54:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9FC196
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 00:54:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1FF75202B8;
        Tue, 23 May 2023 07:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684828442; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=50iN8PoDEfx2Uk7D1T/wI/NQfHj1ELvra2IISlZVxRQ=;
        b=0+gK4+nsHInHkK2lBLls4UfdGOlQdJUoGlKuq9F/OERRTNZQIw7hpyO6vj8R7dd9nhmpVj
        3WHc4Chouas+mUkQoDnLGJLe530nVhL6AfXPVwHindKfUbDTHRRtVy3nfA/FKnzxJENMq5
        vX3ahgPLUrYIuRsz7f06SgpJt1cUJo4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684828442;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=50iN8PoDEfx2Uk7D1T/wI/NQfHj1ELvra2IISlZVxRQ=;
        b=Vw8LvgqqpOuXdoHkzXrOOJECQk1J7uldbrGnt36AwBKD2H7Umchw7nE2NiTjkhLRyTSS+I
        DvoWI2kUDw/sMjCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C09E813588;
        Tue, 23 May 2023 07:54:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AVRyLBlxbGT4KgAAMHmgww
        (envelope-from <tiwai@suse.de>); Tue, 23 May 2023 07:54:01 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/37] ALSA: Add MIDI 2.0 support
Date:   Tue, 23 May 2023 09:53:21 +0200
Message-Id: <20230523075358.9672-1-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this is a revised patch set for adding the support of MIDI 2.0
functionality.  Only a few minor updates since v1 as below:

* Bump CTL protocol version to 2.0.9
* Add two more ioctls for control API to receive UMP EP and block info
* Minor compile warning fixes
* Documentation fix and addition of two new ioctls
* Put acks

The latest code is found in topic/midi20 branch of sound git tree.

And below is the cover letter of v1, which is still valid:

Hi,

this is a (largish) patch set for adding the support of MIDI 2.0
functionality, mainly targeted for USB devices.  MIDI 2.0 is a
complete overhaul of the 40-years old MIDI 1.0.  Unlike MIDI 1.0 byte
stream, MIDI 2.0 uses packets in 32bit words for Universal MIDI Packet
(UMP) protocol.  It supports both MIDI 1.0 commands for compatibility
and the extended MIDI 2.0 commands for higher resolutions and more
functions.

For supporting the UMP, the patch set extends the existing ALSA
rawmidi and sequencer interfaces, and adds the USB MIDI 2.0 support to
the standard USB-audio driver.

The rawmidi for UMP has a different device name (/dev/snd/umpC*D*) and
it reads/writes UMP packet data in 32bit CPU-native endianness.  For
the old MIDI 1.0 applications, the legacy rawmidi interface is
provided, too.

As default, USB-audio driver will take the alternate setting for MIDI
2.0 interface, and the compatibility with MIDI 1.0 is provided via the
rawmidi common layer.  However, user may let the driver falling back
to the old MIDI 1.0 interface by a module option, too.

A UMP-capable rawmidi device can create the corresponding ALSA
sequencer client(s) to support the UMP Endpoint and UMP Group
connections.  As a nature of ALSA sequencer, arbitrary connections
between clients/ports are allowed, and the ALSA sequencer core
performs the automatic conversions for the connections between a new
UMP sequencer client and a legacy MIDI 1.0 sequencer client.  It
allows the existing application to use MIDI 2.0 devices without
changes.

The MIDI-CI, which is another major extension in MIDI 2.0, isn't
covered by this patch set.  It would be implemented rather in
user-space.

Roughly speaking, the first half of this patch set is for extending
the rawmidi and USB-audio, and the second half is for extending the
ALSA sequencer interface.

The patch set is based on 6.4-rc2 kernel, but all patches can be
cleanly applicable on 6.2 and 6.3 kernels, too (while 6.1 and older
kernels would need minor adjustment for uapi header changes).

The updates for alsa-lib and alsa-utils will follow shortly later.

The author thanks members of MIDI Association OS/API Working Group,
especially Andrew Mee, for great helps for the initial design and
debugging / testing the drivers.


Takashi

---

Takashi Iwai (37):
  ALSA: rawmidi: Pass rawmidi directly to snd_rawmidi_kernel_open()
  ALSA: rawmidi: Add ioctl callback to snd_rawmidi_global_ops
  ALSA: rawmidi: UMP support
  ALSA: rawmidi: Skip UMP devices at SNDRV_CTL_IOCTL_RAWMIDI_NEXT_DEVICE
  ALSA: ump: Add ioctls to inquiry UMP EP and Block info via control API
  ALSA: ump: Additional proc output
  ALSA: usb-audio: Manage number of rawmidis globally
  ALSA: usb-audio: Define USB MIDI 2.0 specs
  ALSA: usb-audio: USB MIDI 2.0 UMP support
  ALSA: usb-audio: Get UMP EP name string from USB interface
  ALSA: usb-audio: Trim superfluous "MIDI" suffix from UMP EP name
  ALSA: usb-audio: Create UMP blocks from USB MIDI GTBs
  ALSA: ump: Redirect rawmidi substream access via own helpers
  ALSA: ump: Add legacy raw MIDI support
  ALSA: usb-audio: Enable the legacy raw MIDI support
  ALSA: usb-audio: Inform inconsistent protocols in GTBs
  ALSA: seq: Clear padded bytes at expanding events
  ALSA: seq: Add snd_seq_expand_var_event_at() helper
  ALSA: seq: Treat snd_seq_client object directly in client drivers
  ALSA: seq: Drop dead code for the old broadcast support
  ALSA: seq: Check the conflicting port at port creation
  ALSA: seq: Check validity before creating a port object
  ALSA: seq: Prohibit creating ports with special numbers
  ALSA: seq: Introduce SNDRV_SEQ_IOCTL_USER_PVERSION ioctl
  ALSA: seq: Add UMP support
  ALSA: seq: Add port inactive flag
  ALSA: seq: Support MIDI 2.0 UMP Endpoint port
  ALSA: seq: Add port direction to snd_seq_port_info
  ALSA: seq: Add UMP group number to snd_seq_port_info
  ALSA: seq: Automatic conversion of UMP events
  ALSA: seq: Allow suppressing UMP conversions
  ALSA: seq: Bind UMP device
  ALSA: seq: ump: Create UMP Endpoint port for broadcast
  ALSA: seq: Add ioctls for client UMP info query and setup
  ALSA: seq: Print UMP Endpoint and Block information in proc outputs
  ALSA: seq: Add UMP group filter
  ALSA: docs: Add MIDI 2.0 documentation

 Documentation/sound/designs/index.rst    |    1 +
 Documentation/sound/designs/midi-2.0.rst |  351 +++++++
 include/linux/usb/midi-v2.h              |   94 ++
 include/sound/asequencer.h               |    4 +
 include/sound/rawmidi.h                  |   15 +-
 include/sound/seq_device.h               |    1 +
 include/sound/seq_kernel.h               |   10 +
 include/sound/ump.h                      |  175 ++++
 include/sound/ump_msg.h                  |  540 ++++++++++
 include/uapi/sound/asequencer.h          |   83 +-
 include/uapi/sound/asound.h              |   62 +-
 sound/core/Kconfig                       |   13 +
 sound/core/Makefile                      |    3 +
 sound/core/rawmidi.c                     |  264 +++--
 sound/core/rawmidi_compat.c              |    4 +
 sound/core/seq/Kconfig                   |   14 +
 sound/core/seq/Makefile                  |    3 +
 sound/core/seq/seq_clientmgr.c           |  577 +++++++----
 sound/core/seq/seq_clientmgr.h           |   27 +-
 sound/core/seq/seq_compat.c              |    3 +
 sound/core/seq/seq_dummy.c               |    9 +
 sound/core/seq/seq_memory.c              |   98 +-
 sound/core/seq/seq_memory.h              |   19 +-
 sound/core/seq/seq_midi.c                |   12 +-
 sound/core/seq/seq_ports.c               |   47 +-
 sound/core/seq/seq_ports.h               |   23 +-
 sound/core/seq/seq_ump_client.c          |  464 +++++++++
 sound/core/seq/seq_ump_convert.c         | 1203 ++++++++++++++++++++++
 sound/core/seq/seq_ump_convert.h         |   22 +
 sound/core/seq/seq_virmidi.c             |    1 +
 sound/core/ump.c                         |  668 ++++++++++++
 sound/core/ump_convert.c                 |  520 ++++++++++
 sound/core/ump_convert.h                 |   43 +
 sound/usb/Kconfig                        |   11 +
 sound/usb/Makefile                       |    1 +
 sound/usb/card.c                         |   12 +-
 sound/usb/midi.c                         |    7 +-
 sound/usb/midi.h                         |    5 +-
 sound/usb/midi2.c                        | 1190 +++++++++++++++++++++
 sound/usb/midi2.h                        |   33 +
 sound/usb/quirks.c                       |    8 +-
 sound/usb/usbaudio.h                     |    2 +
 42 files changed, 6306 insertions(+), 336 deletions(-)
 create mode 100644 Documentation/sound/designs/midi-2.0.rst
 create mode 100644 include/linux/usb/midi-v2.h
 create mode 100644 include/sound/ump.h
 create mode 100644 include/sound/ump_msg.h
 create mode 100644 sound/core/seq/seq_ump_client.c
 create mode 100644 sound/core/seq/seq_ump_convert.c
 create mode 100644 sound/core/seq/seq_ump_convert.h
 create mode 100644 sound/core/ump.c
 create mode 100644 sound/core/ump_convert.c
 create mode 100644 sound/core/ump_convert.h
 create mode 100644 sound/usb/midi2.c
 create mode 100644 sound/usb/midi2.h

-- 
2.35.3

