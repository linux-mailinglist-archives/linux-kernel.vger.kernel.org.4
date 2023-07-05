Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1E374843C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 14:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbjGEMdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 08:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbjGEMdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 08:33:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7EA119
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 05:33:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EB396155B
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 12:33:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F125C433C9;
        Wed,  5 Jul 2023 12:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688560389;
        bh=MrLDHbklUKpi6qXlkICOurQQLrWotMYZG6zKJgQAjAY=;
        h=From:To:Cc:Subject:Date:From;
        b=m+8kTaSAKikKHrGf9TO3qYgpRMU149MjjocmjN6KKUPV8qFkr5/0Cv7qcumfx3Zsq
         fhOoBHzADQCEjcoN7P2rQcBbA2RfYUFchFgYcEDjrQdoGaRpluo0tgpsbNX0EKF4W1
         oOhpnwmNsskUGHLolkrqjHovCh+WQobWCDMP7CxW0EduDR08SRkKsZ7z8PxIUJqvae
         ZjG2Q0h9sIY0v1Hdcng2TMzeexs4e2RWKWPgTnPuDa5Ykm1TrzeNIbsJTpe8SJEYur
         gWdybdcNAKI9ULO9sjYB0fOUHCgtQ2I1UdgzQxf/FBzzvg0x02OSK/w+edNm3HeSZh
         ahFg3YJg42uKQ==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan+linaro@kernel.org>)
        id 1qH1hK-000846-03;
        Wed, 05 Jul 2023 14:33:30 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/8] ASoC/soundwire/qdsp6/wcd: fix leaks and probe deferral
Date:   Wed,  5 Jul 2023 14:30:10 +0200
Message-Id: <20230705123018.30903-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've been hitting a race during boot which breaks probe of the sound
card on the Lenovo ThinkPad X13s as I've previously reported here:

	https://lore.kernel.org/all/ZIHMMFtuDtvdpFAZ@hovoldconsulting.com/

The immediate issue appeared to be a probe deferral that was turned into
a hard failure, but addressing that in itself only made things worse as
it exposed further bugs.

I was hoping someone more familiar with the code in question would look
into this, but as this affects users of the X13s and breaks audio on my
machine every fifth boot or so, I decided to investigate it myself.

As expected, the Qualcomm codec drivers are broken and specifically leak
resources on component remove, which in turn breaks sound card probe
deferrals.

The source of the deferral itself appears to be legitimate and was
simply due to some audio component not yet having been registered due to
random changes in timing during boot.

These issues can most easily be reproduced by simply blacklisting the
q6apm_dai module and loading it manually after boot.

The sound card probe deferral also exposes a bug in the soundwire
subsystem, which uses completion structures for signalling that a device
has been enumerated on the bus and initialised. The way this is
implemented prevents reprobed codec drivers from learning that the
soundwire devices are still attached, which causes probe to fail.

Included are also two patches that suppresses error messages on
component probe deferral to avoid spamming the logs during boot.

These patches should preferably all go through the ASoC tree even if
merging the soundwire fix separately also works.

Note the ASoC tree already has the following related fixes:

	https://lore.kernel.org/lkml/20230630120318.6571-1-johan+linaro@kernel.org/
	https://lore.kernel.org/lkml/20230630142717.5314-1-johan+linaro@kernel.org/
	https://lore.kernel.org/lkml/20230701094723.29379-1-johan+linaro@kernel.org/
	https://lore.kernel.org/lkml/20230703124701.11734-1-johan+linaro@kernel.org/

Johan


Johan Hovold (8):
  soundwire: fix enumeration completion
  ASoC: qdsp6: audioreach: fix topology probe deferral
  ASoC: codecs: wcd938x: fix missing clsh ctrl error handling
  ASoC: codecs: wcd938x: fix resource leaks on component remove
  ASoC: codecs: wcd934x: fix resource leaks on component remove
  ASoC: codecs: wcd-mbhc-v2: fix resource leaks on component remove
  ASoC: topology: suppress probe deferral errors
  ASoC: core: suppress probe deferral errors

 drivers/soundwire/bus.c         |  8 ++---
 sound/soc/codecs/wcd-mbhc-v2.c  | 57 ++++++++++++++++++++++---------
 sound/soc/codecs/wcd934x.c      | 12 +++++++
 sound/soc/codecs/wcd938x.c      | 59 +++++++++++++++++++++++++++++----
 sound/soc/qcom/qdsp6/topology.c |  4 +--
 sound/soc/soc-core.c            |  6 ++--
 sound/soc/soc-topology.c        | 10 ++++--
 7 files changed, 122 insertions(+), 34 deletions(-)

-- 
2.39.3

