Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE696635F6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 01:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237576AbjAJAAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 19:00:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjAIX75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 18:59:57 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E61E1D0E0;
        Mon,  9 Jan 2023 15:59:55 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1673308792;
        bh=mmA3e+RUDNTDXD6JuByulekojiIyMaEV/XvB6QADix8=;
        h=From:Subject:Date:To:Cc:From;
        b=txlJy/B/9B+Dl+jJG85yHSakLOo8lZMYOGegMaezAObZf2AclFQHMOoX2+igjS96x
         0/74Z7uuLTXz8IcJQC1dC2cLBcUz9wTn43o0fYsIs/OrTQfpjUvOQ/+MRD/OoICkq1
         xSYo587AlcPmC3sD4st/DvUTLb/vIq1PBqBlPJM8=
Subject: [PATCH RESEND v6 0/3] certs: Prevent spurious errors on repeated
 blacklisting
Date:   Mon, 09 Jan 2023 23:59:41 +0000
Message-Id: <20221212-keys-blacklist-v6-0-933267a80582@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc:     keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Mark Pearson <markpearson@lenovo.com>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12-dev-3dd91
X-Developer-Signature: v=1; a=ed25519-sha256; t=1673308789; l=3559;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=mmA3e+RUDNTDXD6JuByulekojiIyMaEV/XvB6QADix8=;
 b=lUOjJ/Hfs2+vrugMhO7ez7GCZs4CNMk6jmXo9Sb1ZDtnfFVlOl3fzUEC85KDsUaoPJnNq2Pm6pej
 ee26YhCqAdFD/QS22XmrbURgYcMzuYjoS2kQ9tEMRBrQtpD3RD+t
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the blacklist keyring was changed to allow updates from the root
user it gained an ->update() function that disallows all updates.
When the a hash is blacklisted multiple times from the builtin or
firmware-provided blacklist this spams prominent logs during boot:

[    0.890814] blacklist: Problem blacklisting hash (-13)

This affects the firmware of various vendors. Reported have been at least:
* Samsung: https://askubuntu.com/questions/1436856/
* Acer: https://ubuntuforums.org/showthread.php?t=2478840
* MSI: https://forum.archlabslinux.com/t/blacklist-problem-blacklisting-hash-13-errors-on-boot/6674/7
* Micro-Star: https://bbs.archlinux.org/viewtopic.php?id=278860
* Lenovo: https://lore.kernel.org/lkml/c8c65713-5cda-43ad-8018-20f2e32e4432@t-8ch.de/

Note: In the meantime I lost access to the machine exhibiting the
problematic behavior. If larger changes are required to this series
somebody else would have to validate them or take over the series.

Changelog:

v1: https://lore.kernel.org/all/20221104014704.3469-1-linux@weissschuh.net/
v1 -> v2:
 * Improve logging message to include the failed hash
 * Add key_create() function without update semantics
 * Use key_create() from mark_raw_hash_blacklisted() and log specific message
   on -EEXIST

v2: https://lore.kernel.org/lkml/20221109025019.1855-1-linux@weissschuh.net/
v2 -> v3:
 * Clarify commit titles and messages
 * Drop the change to BLACKLIST_KEY_PERM from patch 3, as it was an artifact
   of some obsolete version of the patch and not needed

v3: https://lore.kernel.org/lkml/20221118040343.2958-1-linux@weissschuh.net/
v3 -> v4:
 * Drop Fixes-tag from first patch
 * Flesh out commit descriptions and messages

v4: https://lore.kernel.org/r/20221212-keys-blacklist-v4-0-00afeb3137fb@weissschuh.net
v4 -> v5:
 * Reduce lines needed by function calls in key.c
 * Add Reviewed-by from Jarkko

v5: https://lore.kernel.org/r/20221212-keys-blacklist-v5-0-52e9eb5a8827@weissschuh.net
v5 -> v6:
 * Correct Jarkkos email in Reviewed-by tags
 * Resend to hopefully reach @kernel.org recipients

Thomas Weißschuh (3):
  certs: log hash value on blacklist error
  KEYS: Add key_create()
  certs: don't try to update blacklist keys

 certs/blacklist.c   |  21 ++++---
 include/linux/key.h |   8 +++
 security/keys/key.c | 149 +++++++++++++++++++++++++++++++++-----------
 3 files changed, 132 insertions(+), 46 deletions(-)

--
2.38.1

To: David Howells <dhowells@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
To: Paul Moore <paul@paul-moore.com>
To: James Morris <jmorris@namei.org>
To: "Serge E. Hallyn" <serge@hallyn.com>
To: "Mickaël Salaün" <mic@digikod.net>
Cc: keyrings@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Cc: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Cc: Mark Pearson <markpearson@lenovo.com>

---
Thomas Weißschuh (3):
      certs: make blacklisted hash available in klog
      KEYS: Add new function key_create()
      certs: don't try to update blacklist keys

 certs/blacklist.c   |  21 ++++----
 include/linux/key.h |   8 +++
 security/keys/key.c | 137 ++++++++++++++++++++++++++++++++++++++--------------
 3 files changed, 120 insertions(+), 46 deletions(-)
---
base-commit: 512dee0c00ad9e9c7ae9f11fc6743702ea40caff
change-id: 20221212-keys-blacklist-2c79a64667c9

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>
