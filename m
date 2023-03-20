Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D2F6C2327
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 21:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjCTUxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 16:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjCTUxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 16:53:42 -0400
Received: from mail.mutex.one (mail.mutex.one [62.77.152.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18E23524B
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 13:53:36 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.mutex.one (Postfix) with ESMTP id A146716C004D;
        Mon, 20 Mar 2023 22:35:24 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at mail.mutex.one
Received: from mail.mutex.one ([127.0.0.1])
        by localhost (mail.mutex.one [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TRUwbhaV26Ey; Mon, 20 Mar 2023 22:35:23 +0200 (EET)
From:   Marian Postevca <posteuca@mutex.one>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mutex.one; s=default;
        t=1679344523; bh=R7uiQ1feQw6p3sdCJIwiFXfTPysR2lDfUQ/O3lrdZTw=;
        h=From:To:Cc:Subject:Date:From;
        b=bdzw+2utFb32iI1er0u+KgqIInBFKvoPWd/wyp2dCnSRGxjb9WxxZ2LWzfOjv2cDv
         YBzeZOlva+NYHs+3Mi/kHa84pu7q32G/A69xDJlgkmxhMemM40T/5NAx+IrSWJG7st
         s7bem0Zlr5GE/I0ozN9zG8rVlpMaQtsIzcKmLYsQ=
To:     Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Marian Postevca <posteuca@mutex.one>
Subject: [PATCH 0/4] ASoC: amd: acp: Add sound support for a line of HUAWEI laptops
Date:   Mon, 20 Mar 2023 22:35:15 +0200
Message-Id: <20230320203519.20137-1-posteuca@mutex.one>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for a line of HUAWEI laptops with
AMD CPUs that connect using the ACP3x module to a ES8336 codec.

The codec driver must be extended to support the S32 LE format
and the MCLK div by 2 option. MCLK div by 2 is needed for one specific
SKU which uses a 48Mhz MCLK which seems to be too high of a frequency
for the codec and must be divided by 2.

The acp legacy driver must also be extended by using callbacks so that
the more complicated handling for this specific codec can be moved
outside the more generic ACP code.

The last patch tries to avoid anoying pop sounds when the speaker/headphones
are enabled/disabled by delaying the handling of the GPIOs and using a mutex
to avoid race conditions between the speaker power event callback and the
trigger callback.

Marian Postevca (4):
  ASoC: es8316: Enable support for S32 LE format and MCLK div by 2
  ASoC: amd: acp: Add support for splitting the codec specific code from
    the ACP driver
  ASoC: amd: acp: Add machine driver that enables sound for systems with
    a ES8336 codec
  ASoC: amd: acp: Improve support for speaker power events

 sound/soc/amd/acp-config.c                    |  70 ++
 sound/soc/amd/acp/Makefile                    |   2 +-
 sound/soc/amd/acp/acp-legacy-mach.c           | 105 ++-
 sound/soc/amd/acp/acp-mach-common.c           |   8 +
 sound/soc/amd/acp/acp-mach.h                  |  67 ++
 sound/soc/amd/acp/acp-renoir.c                |   4 +
 sound/soc/amd/acp/acp3x-es83xx/acp3x-es83xx.c | 615 ++++++++++++++++++
 sound/soc/amd/acp/acp3x-es83xx/acp3x-es83xx.h |  12 +
 sound/soc/codecs/es8316.c                     |  21 +-
 sound/soc/codecs/es8316.h                     |   3 +
 10 files changed, 886 insertions(+), 21 deletions(-)
 create mode 100644 sound/soc/amd/acp/acp3x-es83xx/acp3x-es83xx.c
 create mode 100644 sound/soc/amd/acp/acp3x-es83xx/acp3x-es83xx.h

-- 
2.39.1

