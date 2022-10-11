Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCA05FBAE2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 21:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbiJKTBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 15:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiJKTA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 15:00:59 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EEA82D01;
        Tue, 11 Oct 2022 12:00:57 -0700 (PDT)
Received: from meer.lwn.net (unknown [IPv6:2601:281:8300:73::5f6])
        by ms.lwn.net (Postfix) with ESMTPA id E84F37DE;
        Tue, 11 Oct 2022 19:00:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E84F37DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1665514857; bh=ckcgg3Uja/Sjo6M8PxQ0qtiwcNDWpwwCvMJ3lQlDvhQ=;
        h=From:To:Cc:Subject:Date:From;
        b=dnjNhMgNLM1J/lXlq2X6Yp8BzCt46CYhmTneJGPdXM9ZCUsJ3ipbEjgUeI+mkhICn
         uYBe2pUo2wWMzPNWsUaPxAwPdlqkKk2ZQQWnFtjUtqFIRwiqqBGTApJqaDMCVwKCMh
         S5btu7ELATcwEMWneB0EDYWxz2euNIGpm+CblgTY0sLBeCfQY5eYtNhl4FVd5dfAbY
         daoXI1ATkfigQWDIRlX2nBOC66O+tANQAAxnRtpF5Nba9+oUE8ZOpDJKb+hmTt9UZr
         F8qdk6/nXvxIz8VKIcmmcpqjZp+eVPAVEQq90RlF9Wrhdr7C9jfzN2q7rfeWGGTqk8
         90JPSK8UgRQcg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 0/6] docs: Improvements to our HTML output
Date:   Tue, 11 Oct 2022 13:00:41 -0600
Message-Id: <20221011190047.749145-1-corbet@lwn.net>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

 Documentation/conf.py                  | 204 ++++---------------------
 Documentation/doc-guide/sphinx.rst     |  16 +-
 Documentation/sphinx-static/custom.css |  28 ++++
 Documentation/sphinx/requirements.txt  |   1 -
 scripts/kernel-doc                     |  52 ++++---
 scripts/sphinx-pre-install             |   8 -
 6 files changed, 91 insertions(+), 218 deletions(-)
 create mode 100644 Documentation/sphinx-static/custom.css

-- 
2.37.2

