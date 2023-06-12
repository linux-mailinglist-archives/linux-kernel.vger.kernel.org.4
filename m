Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCB572B9E1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 10:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjFLILr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 04:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjFLILl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:11:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029B7B5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 01:11:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CD181224FC;
        Mon, 12 Jun 2023 08:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686557465; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=d4onWRD0uQuxv/zo2IFQ1pl6oFXHj09eFtoJOf6sS80=;
        b=n7u9OjPmGs/Bv8ehuXy2XMkJaYHnQyId+PK+wbByCTrD1SI16l1hHDVMULLZYKeTFU3VAo
        WkY9+zjFruE/05M7K5AttngM0OZoajkGNyvWdUYlI/n0o0hNpkGOTQy9tgGs2OnAanhxEZ
        HemlVJPhbNnX9VH5pWlM9AGbBeDNRpQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686557465;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=d4onWRD0uQuxv/zo2IFQ1pl6oFXHj09eFtoJOf6sS80=;
        b=AHaqYtKlpRexc1JbJ+uYQZL8CJUBIHvBQA0UAtA6qseSzELgEjNJ3+Qz36MiujcMXmjRRW
        dYoRR77dZF+x5WDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ADBB1138EC;
        Mon, 12 Jun 2023 08:11:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GEZkKRnThmSLcAAAMHmgww
        (envelope-from <tiwai@suse.de>); Mon, 12 Jun 2023 08:11:05 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 00/10] ALSA: Catch up MIDI 2.0 updates for UMP 1.1
Date:   Mon, 12 Jun 2023 10:10:44 +0200
Message-Id: <20230612081054.17200-1-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

as the updated MIDI 2.0 spec has been published freshly [*], this is a
catch up to add the support for new specs, especially UMP v1.1
features, on Linux kernel.

The new UMP v1.1 introduced the concept of Function Blocks (FB), which
is a kind of superset of USB MIDI 2.0 Group Terminal Blocks (GTB).
The patch set adds the support for FB as the primary information
source while keeping the parse of GTB as fallback.  Also UMP v1.1
supports the groupless messages, the protocol switch, static FBs, and
other new fundamental features, and those are supported as well.


Takashi

[*] https://www.midi.org/midi-articles/details-about-midi-2-0-midi-ci-profiles-and-property-exchange

===

Takashi Iwai (10):
  ALSA: ump: Add more attributes to UMP EP and FB info
  ALSA: ump: Support UMP Endpoint and Function Block parsing
  ALSA: usb-audio: Parse UMP Endpoint and Function Blocks at first
  ALSA: usb-audio: Add midi2_ump_probe option
  ALSA: seq: ump: Handle groupless messages
  ALSA: seq: ump: Handle FB info update
  ALSA: seq: ump: Notify port changes to system port
  ALSA: seq: ump: Notify UMP protocol change to sequencer
  ALSA: ump: Add info flag bit for static blocks
  ALSA: docs: Update MIDI 2.0 documentation for UMP 1.1 enhancement

 Documentation/sound/designs/midi-2.0.rst |  39 +-
 include/sound/ump.h                      |  89 +++++
 include/sound/ump_msg.h                  | 225 +++++++++++
 include/uapi/sound/asequencer.h          |   5 +-
 include/uapi/sound/asound.h              |  21 +-
 sound/core/seq/seq_system.c              |   1 +
 sound/core/seq/seq_ump_client.c          |  79 +++-
 sound/core/seq/seq_ump_convert.c         |   3 +
 sound/core/ump.c                         | 470 +++++++++++++++++++++++
 sound/usb/midi2.c                        |  42 +-
 10 files changed, 962 insertions(+), 12 deletions(-)

-- 
2.35.3

