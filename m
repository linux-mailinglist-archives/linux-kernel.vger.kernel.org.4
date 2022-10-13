Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC455FDEF1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 19:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiJMR3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 13:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiJMR31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 13:29:27 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0DEBCBA6;
        Thu, 13 Oct 2022 10:29:26 -0700 (PDT)
Received: from meer.lwn.net (unknown [IPv6:2601:281:8300:73:8b7:7001:c8aa:b65f])
        by ms.lwn.net (Postfix) with ESMTPA id 238C87F9;
        Thu, 13 Oct 2022 17:29:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 238C87F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1665682166; bh=cL4wK7yFKBhyQ4Dhq4XQ8UpoGVtPqbtxxog4Wl00WbI=;
        h=From:To:Cc:Subject:Date:From;
        b=HfmU0YRTnc5nsYQCU9Jq8UhndFRbiWfsgkEMOJzxEzdG7zqqTm6iNmFuLT3x4nbYQ
         odZT4kN9ihgAkqyCe2jxtmzfmWrzn1R/z3KdXQKq05/fr0XodK9eue9BulJKqAHwXi
         L9UwjlWH3MduEqETeYkX6Td7btzeqzLDIK2EmJRy2cN5IRN4J7+QtB9BrGDrZnOUoE
         65ACjgSEFYxCdO+P/6iaGlPc2htUqhoEw3D7gtpcrskour4TPb4MVUYCh3ZM7V1rsc
         sweJZW14qz/FZ3ih6THInD/gowNy4IWJrzeNZp8lljIxyALPAO0xgFjk5KllU+MezT
         WeKtQdhli/D3Q==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/6] docs: Improvements to our HTML output
Date:   Thu, 13 Oct 2022 11:29:12 -0600
Message-Id: <20221013172918.846856-1-corbet@lwn.net>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[This version rebases the series on top of current docs-next and adds
Mauro's acks; there are no other changes.]

For a long time we have rejoiced that our HTML output from Sphinx is far
better than what we got from the old DocBook toolchain.  But it still
leaves a lot to be desired; the following is an attempt to improve the
situation somewhat.

Sphinx has a theming mechanism for HTML rendering.  Since the kernel's
adoption of Sphinx, we have been using the "Read The Docs" theme — a choice
made in a bit of a hurry to have *something* while figuring out the rest.
RTD is OK, but it is not hugely attractive, requires the installation of an
extra package, and does not observe all of the Sphinx configuration
parameters.  Among other things, that makes it hard to put reasonable
contents into the left column in the HTML output.

The Alabaster theme is the default for Sphinx installations, and is bundled
with Sphinx itself.  It has (IMO) nicer output and gives us the control
that we need.

So: switch to Alabaster.  Additional patches adjust the documentation and
remove the RTD references from scripts/sphinx-pre-install.

The penultimate patch changes the way that kerneldoc declarations are
rendered to (IMO) improve readability.  That requires some changes to
kernel-doc to output a new container block and some CSS tweaks to improve
things overall.

It should be noted that I have a long history of inflicting ugly web
designs on the net; this work is a start, but I think we could do far
better yet.  It would be great if somebody who actually enjoys working with
CSS and such would help to improve what we have.

As before, I've put a copy of the rendered docs at:

  https://static.lwn.net/kerneldoc/

To compare the kerneldoc changes specifically, pick a page that includes a
lot of definitions; for example:

  https://static.lwn.net/kerneldoc/driver-api/media/drivers/frontends.html
  vs.
  https://www.kernel.org/doc/html/latest/driver-api/media/drivers/frontends.html

-------
Changes from v2:

- Rebase onto current docs-next and add Mauro's acks

Changes from the initial version:

- Tweak more alabaster style parameters, including the maximum page width.
  There will surely be disagreement over what the right value should be,
  but at least it's defined in units independent of screen resolution.

- Remove "classic" theme configuration and a bunch of other conf.py cruft.

- I've tried to answer all of the other comments, but a couple remain.  The
  sidebar contents are unchanged; making that more useful will require some
  thought and work.  The gray background on function prototypes that Jani
  pointed out is actually something I did intentionally, with the idea of
  making each declaration stand out better in the wall of text.  I still
  think it's better but am not married to it if the world disagrees.

- I've tested PDF and epub builds (no changes) and Sphinx back to v1.7.

In the absence of objections I'll be putting this into docs-next after the
merge window closes.  We can (and surely will) tweak this forever, but at
least it, I hope, shows a direction in which we can go.


Jonathan Corbet (6):
  docs: Switch the default HTML theme to alabaster
  docs: tweak some Alabaster style parameters
  docs: update sphinx.rst to reflect the default theme change
  docs: sphinx-pre-install: don't require the RTD theme
  docs: improve the HTML formatting of kerneldoc comments
  docs: decruft Documentation/conf.py

 Documentation/conf.py                  | 206 ++++---------------------
 Documentation/doc-guide/sphinx.rst     |  16 +-
 Documentation/sphinx-static/custom.css |  28 ++++
 Documentation/sphinx/requirements.txt  |   1 -
 scripts/kernel-doc                     |  52 ++++---
 scripts/sphinx-pre-install             |   8 -
 6 files changed, 92 insertions(+), 219 deletions(-)
 create mode 100644 Documentation/sphinx-static/custom.css

-- 
2.37.2

