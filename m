Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B55BC65DDCD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 21:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240137AbjADUpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 15:45:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjADUph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 15:45:37 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A426B1BE81;
        Wed,  4 Jan 2023 12:45:36 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 3E2C82C5;
        Wed,  4 Jan 2023 20:45:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3E2C82C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1672865136; bh=GnZ2wQ3AWKZiOEmZO0krSMoKPBrB3gSfeQb7VWBa5ZU=;
        h=From:To:Cc:Subject:Date:From;
        b=tizL1noI+FnnMMXP47i1nQCqajPBMirQO0ouQzHWipL1z4pq8O7zueWaJkysqan1a
         DPrtQwwiLuhsJAmIW+Nf+jt4mqXugNAQ9PZKw+p4VnsrBHvnjR0I6EKNH6sKyXCFez
         Idp4CfVEMJqbBIJYxcic3WAs/ophDiJNEGzhqe0rj0SQzI9gUXDuy24EVnUwXly6FC
         HQ39CsgnXbTlgdRcYzf3NKNN3f7JETGZn+pl+mlddkWJ47q9uyHazg1aHgTFjzpEBz
         AcqOb5ypSozCXe4lTf8w3HFE/w4ucz43DhIJdTcuVTOyPl0rwmyAiEXeLI8qd4W1yc
         6LCkD2hMp1iUg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Martin =?utf-8?Q?Li=C5=A1ka?= <mliska@suse.cz>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH] docs: Fix the docs build with Sphinx 6.0
Date:   Wed, 04 Jan 2023 13:45:35 -0700
Message-ID: <87wn629ggg.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sphinx 6.0 removed the execfile_() function, which we use as part of the
configuration process.  They *did* warn us...  Just open-code the
functionality as is done in Sphinx itself.

Tested (using SPHINX_CONF, since this code is only executed with an
alternative config file) on various Sphinx versions from 2.5 through 6.0.

Reported-by: Martin Li=C5=A1ka <mliska@suse.cz>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/sphinx/load_config.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/sphinx/load_config.py b/Documentation/sphinx/loa=
d_config.py
index eeb394b39e2c..8b416bfd75ac 100644
--- a/Documentation/sphinx/load_config.py
+++ b/Documentation/sphinx/load_config.py
@@ -3,7 +3,7 @@
=20
 import os
 import sys
-from sphinx.util.pycompat import execfile_
+from sphinx.util.osutil import fs_encoding
=20
 # ------------------------------------------------------------------------=
------
 def loadConfig(namespace):
@@ -48,7 +48,9 @@ def loadConfig(namespace):
             sys.stdout.write("load additional sphinx-config: %s\n" % confi=
g_file)
             config =3D namespace.copy()
             config['__file__'] =3D config_file
-            execfile_(config_file, config)
+            with open(config_file, 'rb') as f:
+                code =3D compile(f.read(), fs_encoding, 'exec')
+                exec(code, config)
             del config['__file__']
             namespace.update(config)
         else:
--=20
2.38.1

