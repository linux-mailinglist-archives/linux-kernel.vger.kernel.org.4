Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2F6652746
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 20:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbiLTTo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 14:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234055AbiLTTou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 14:44:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070E5B7D;
        Tue, 20 Dec 2022 11:44:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9232361585;
        Tue, 20 Dec 2022 19:44:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B13B5C433EF;
        Tue, 20 Dec 2022 19:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1671565488;
        bh=4xo5oo+WtVDTNnsHpxY1lVhm2FicJ/yYRghdkVhayAM=;
        h=From:Date:Subject:To:Cc:From;
        b=0TBfP0T9HhCCfl0ZMzoNoXlxQBxT5R0Cwp5hOi+2jGrf+DCaoRzRm3mmAUc3wLR6k
         slSkdty7xRR6ASK8q5KD3YJrpSdpvP0FJAlhfiF2dYTLNQaac0PkLvRGGghx/458Av
         rBEfpeQxHrM+6N4hjf/prwTOrDlCJ8/AtNdrSDNE=
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Date:   Tue, 20 Dec 2022 14:44:17 -0500
Subject: [PATCH] docs: maintainer-pgp-guide: update for latest gnupg defaults
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221220-docs-pgp-guide-v1-1-9b0c0bf974fb@linuxfoundation.org>
X-B4-Tracking: v=1; b=H4sIAJEQomMC/x2NQQrCQAwAv1JyNrANRdCviId0E7c5uF0SFaH07
 249DsMwG4S6acB12MD1Y2Fr7TCeBsgL16Jo0hkoEY1ECWXNga00LG8TRZbLlCZiSWeCHs0cirNz
 zcuRPTle6odorg/7/k+3+77/ABwfkz95AAAA
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.12-dev-05166
X-Developer-Signature: v=1; a=openpgp-sha256; l=10596;
 i=konstantin@linuxfoundation.org; h=from:subject:message-id;
 bh=4xo5oo+WtVDTNnsHpxY1lVhm2FicJ/yYRghdkVhayAM=;
 b=owGbwMvMwCW27YjM47CUmTmMp9WSGJIXCayXN1BRtlrYvtjyaVppW0Wayr4JyaZ+jpqaHfOvrEq5
 L9TeUcrCIMbFICumyFK2L3ZTUOFDD7n0HlOYOaxMIEMYuDgFYCKr5jEy7GOZxvvGRvbM52WnvwpsZN
 Ssu7+4tX3FtETlau3GH+FlDxj+F5l6GQgt9L1Rd0TaUu2FKnPRi00aqz1Nw+s+7fw2XXcFOwA=
X-Developer-Key: i=konstantin@linuxfoundation.org; a=openpgp;
 fpr=DE0E66E32F1FDD0902666B96E63EDCA9329DD07E
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is finally becoming increasingly rare to find a distribution that
still ships with gnupg-1.x, so remove the last vestiges of "gpg" vs
"gpg2" from documentation.

Similarly, starting with GnuPG 2.2 and above, the default --gen-key
operation creates ed25519/cv25519 keypairs, so update all example
command outputs to use that combination instead of rsa2048.

Lastly, add a few wording tweaks and remove links that lead to stale
information (e.g. hardware tokens overview from 2017).

Signed-off-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
---
 Documentation/process/maintainer-pgp-guide.rst | 102 ++++++++-----------------
 1 file changed, 30 insertions(+), 72 deletions(-)

diff --git a/Documentation/process/maintainer-pgp-guide.rst b/Documentation/process/maintainer-pgp-guide.rst
index 40bfbd3b7648..f5277993b195 100644
--- a/Documentation/process/maintainer-pgp-guide.rst
+++ b/Documentation/process/maintainer-pgp-guide.rst
@@ -60,36 +60,18 @@ establish the integrity of the Linux kernel itself.
 PGP tools
 =========
 
-Use GnuPG v2
-------------
+Use GnuPG 2.2 or later
+----------------------
 
 Your distro should already have GnuPG installed by default, you just
-need to verify that you are using version 2.x and not the legacy 1.4
-release -- many distributions still package both, with the default
-``gpg`` command invoking GnuPG v.1. To check, run::
+need to verify that you are using a reasonably recent version of it.
+To check, run::
 
     $ gpg --version | head -n1
 
-If you see ``gpg (GnuPG) 1.4.x``, then you are using GnuPG v.1. Try the
-``gpg2`` command (if you don't have it, you may need to install the
-gnupg2 package)::
-
-    $ gpg2 --version | head -n1
-
-If you see ``gpg (GnuPG) 2.x.x``, then you are good to go. This guide
-will assume you have the version 2.2 of GnuPG (or later). If you are
-using version 2.0 of GnuPG, then some of the commands in this guide will
-not work, and you should consider installing the latest 2.2 version of
-GnuPG. Versions of gnupg-2.1.11 and later should be compatible for the
-purposes of this guide as well.
-
-If you have both ``gpg`` and ``gpg2`` commands, you should make sure you
-are always using GnuPG v2, not the legacy version. You can enforce this
-by setting the appropriate alias::
-
-    $ alias gpg=gpg2
-
-You can put that in your ``.bashrc`` to make sure it's always the case.
+If you have version 2.2 or above, then you are good to go. If you have a
+version that is prior than 2.2, then some commands from this guide may
+not work.
 
 Configure gpg-agent options
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -150,9 +132,9 @@ PGP defines four capabilities that a key can have:
 The key with the **[C]** capability is often called the "master" key,
 but this terminology is misleading because it implies that the Certify
 key can be used in place of any of other subkey on the same chain (like
-a physical "master key" can be used to open the locks made for other
-keys). Since this is not the case, this guide will refer to it as "the
-Certify key" to avoid any ambiguity.
+a physical "master key" can be used to open locks made for other keys).
+Since this is not the case, this guide will refer to it as "the Certify
+key" to avoid any ambiguity.
 
 It is critical to fully understand the following:
 
@@ -186,10 +168,10 @@ If you used the default parameters when generating your key, then that
 is what you will have. You can verify by running ``gpg --list-secret-keys``,
 for example::
 
-    sec   rsa2048 2018-01-23 [SC] [expires: 2020-01-23]
+    sec   ed25519 2022-12-20 [SC] [expires: 2024-12-19]
           000000000000000000000000AAAABBBBCCCCDDDD
     uid           [ultimate] Alice Dev <adev@kernel.org>
-    ssb   rsa2048 2018-01-23 [E] [expires: 2020-01-23]
+    ssb   cv25519 2022-12-20 [E] [expires: 2024-12-19]
 
 The long line under the ``sec`` entry is your key fingerprint --
 whenever you see ``[fpr]`` in the examples below, that 40-character
@@ -219,18 +201,9 @@ separate signing subkey::
 
 .. note:: ECC support in GnuPG
 
-    GnuPG 2.1 and later has full support for Elliptic Curve
-    Cryptography, with ability to combine ECC subkeys with traditional
-    RSA keys. The main upside of ECC cryptography is that it is much
-    faster computationally and creates much smaller signatures when
-    compared byte for byte with 2048+ bit RSA keys. Unless you plan on
-    using a smartcard device that does not support ECC operations, we
-    recommend that you create an ECC signing subkey for your kernel
-    work.
-
-    Note, that if you plan to use a hardware device that does not
+    Note, that if you intend to use a hardware token that does not
     support ED25519 ECC keys, you should choose "nistp256" instead or
-    "ed25519."
+    "ed25519." See the section below on recommended hardware devices.
 
 
 Back up your Certify key for disaster recovery
@@ -336,13 +309,13 @@ First, identify the keygrip of your Certify key::
 
 The output will be something like this::
 
-    pub   rsa2048 2018-01-24 [SC] [expires: 2020-01-24]
+    pub   ed25519 2022-12-20 [SC] [expires: 2022-12-19]
           000000000000000000000000AAAABBBBCCCCDDDD
           Keygrip = 1111000000000000000000000000000000000000
     uid           [ultimate] Alice Dev <adev@kernel.org>
-    sub   rsa2048 2018-01-24 [E] [expires: 2020-01-24]
+    sub   cv25519 2022-12-20 [E] [expires: 2022-12-19]
           Keygrip = 2222000000000000000000000000000000000000
-    sub   ed25519 2018-01-24 [S]
+    sub   ed25519 2022-12-20 [S]
           Keygrip = 3333000000000000000000000000000000000000
 
 Find the keygrip entry that is beneath the ``pub`` line (right under the
@@ -365,14 +338,14 @@ Now, if you issue the ``--list-secret-keys`` command, it will show that
 the Certify key is missing (the ``#`` indicates it is not available)::
 
     $ gpg --list-secret-keys
-    sec#  rsa2048 2018-01-24 [SC] [expires: 2020-01-24]
+    sec#  ed25519 2022-12-20 [SC] [expires: 2024-12-19]
           000000000000000000000000AAAABBBBCCCCDDDD
     uid           [ultimate] Alice Dev <adev@kernel.org>
-    ssb   rsa2048 2018-01-24 [E] [expires: 2020-01-24]
-    ssb   ed25519 2018-01-24 [S]
+    ssb   cv25519 2022-12-20 [E] [expires: 2024-12-19]
+    ssb   ed25519 2022-12-20 [S]
 
 You should also remove any ``secring.gpg`` files in the ``~/.gnupg``
-directory, which are left over from earlier versions of GnuPG.
+directory, which may be left over from previous versions of GnuPG.
 
 If you don't have the "private-keys-v1.d" directory
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -437,8 +410,7 @@ functionality. There are several options available:
   U2F, among others, and now finally supports NISTP and ED25519 ECC
   keys.
 
-`LWN has a good review`_ of some of the above models, as well as several
-others. Your choice will depend on cost, shipping availability in your
+Your choice will depend on cost, shipping availability in your
 geographical region, and open/proprietary hardware considerations.
 
 .. note::
@@ -451,7 +423,6 @@ geographical region, and open/proprietary hardware considerations.
 .. _`Nitrokey Pro 2`: https://shop.nitrokey.com/shop/product/nkpr2-nitrokey-pro-2-3
 .. _`Yubikey 5`: https://www.yubico.com/products/yubikey-5-overview/
 .. _Gnuk: https://www.fsij.org/doc-gnuk/
-.. _`LWN has a good review`: https://lwn.net/Articles/736231/
 .. _`qualify for a free Nitrokey Start`: https://www.kernel.org/nitrokey-digital-tokens-for-kernel-developers.html
 
 Configure your smartcard device
@@ -509,11 +480,11 @@ passphrase and the admin PIN of the card for most operations::
 
     Secret subkeys are available.
 
-    pub  rsa2048/AAAABBBBCCCCDDDD
-         created: 2018-01-23  expires: 2020-01-23  usage: SC
+    pub  ed25519/AAAABBBBCCCCDDDD
+         created: 2022-12-20  expires: 2024-12-19  usage: SC
          trust: ultimate      validity: ultimate
-    ssb  rsa2048/1111222233334444
-         created: 2018-01-23  expires: never       usage: E
+    ssb  cv25519/1111222233334444
+         created: 2022-12-20  expires: never       usage: E
     ssb  ed25519/5555666677778888
          created: 2017-12-07  expires: never       usage: S
     [ultimate] (1). Alice Dev <adev@kernel.org>
@@ -577,11 +548,11 @@ If you perform ``--list-secret-keys`` now, you will see a subtle
 difference in the output::
 
     $ gpg --list-secret-keys
-    sec#  rsa2048 2018-01-24 [SC] [expires: 2020-01-24]
+    sec#  ed25519 2022-12-20 [SC] [expires: 2024-12-19]
           000000000000000000000000AAAABBBBCCCCDDDD
     uid           [ultimate] Alice Dev <adev@kernel.org>
-    ssb>  rsa2048 2018-01-24 [E] [expires: 2020-01-24]
-    ssb>  ed25519 2018-01-24 [S]
+    ssb>  cv25519 2022-12-20 [E] [expires: 2024-12-19]
+    ssb>  ed25519 2022-12-20 [S]
 
 The ``>`` in the ``ssb>`` output indicates that the subkey is only
 available on the smartcard. If you go back into your secret keys
@@ -644,7 +615,7 @@ run::
 You can also use a specific date if that is easier to remember (e.g.
 your birthday, January 1st, or Canada Day)::
 
-    $ gpg --quick-set-expire [fpr] 2020-07-01
+    $ gpg --quick-set-expire [fpr] 2025-07-01
 
 Remember to send the updated key back to keyservers::
 
@@ -707,12 +678,6 @@ should be used (``[fpr]`` is the fingerprint of your key)::
 
     $ git config --global user.signingKey [fpr]
 
-**IMPORTANT**: If you have a distinct ``gpg2`` command, then you should
-tell git to always use it instead of the legacy ``gpg`` from version 1::
-
-    $ git config --global gpg.program gpg2
-    $ git config --global gpgv.program gpgv2
-
 How to work with signed tags
 ----------------------------
 
@@ -751,13 +716,6 @@ If you are verifying someone else's git tag, then you will need to
 import their PGP key. Please refer to the
 ":ref:`verify_identities`" section below.
 
-.. note::
-
-    If you get "``gpg: Can't check signature: unknown pubkey
-    algorithm``" error, you need to tell git to use gpgv2 for
-    verification, so it properly processes signatures made by ECC keys.
-    See instructions at the start of this section.
-
 Configure git to always sign annotated tags
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 

---
base-commit: 830b3c68c1fb1e9176028d02ef86f3cf76aa2476
change-id: 20221220-docs-pgp-guide-ad94042ad062

Best regards,
-- 
Konstantin Ryabitsev <konstantin@linuxfoundation.org>
