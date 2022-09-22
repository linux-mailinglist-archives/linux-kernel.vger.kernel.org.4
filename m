Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447F45E7063
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 02:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiIWAAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 20:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiIWAAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 20:00:03 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71D35B7BF
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 17:00:00 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (unknown [71.190.76.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1E0D76602229;
        Fri, 23 Sep 2022 00:59:55 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663891197;
        bh=XI3oHZqDLqJjLNw81Hk83f5UFOa5J7x8UqAktxIuW38=;
        h=From:To:Cc:Subject:Date:From;
        b=knOY+Gi223BPJ4Tvih1evj2OSeaF5P6zcFgDAyjXpgbYQ4Mh0hIS2g+c00gB/eQEh
         u7upkEyny6/K8T+scWUOQeUixpGnynKlUWfRTX0iA/KnycVTGYX6RYTK6ZuQebDC4R
         2nk9Nm47p/OzFYhgmbTrCHzVOo9roJOrGq1djpnR0wPVHDYAto+dDXwzNn92AOOVte
         B/mihfKE8PUCKfUbOwIuiVVyX9xwA3CK2iWxk1XeOzo4GszZBZ0ykgEt6HBjlYCAdS
         VmuxwbXJHxF+Uq3VLy4Gc6JHCJdRmMUcMAho6zy1M5FoMttw1di1/4816b731cAZkj
         z44E2JwJ4jzXA==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Akihiko Odaki <akihiko.odaki@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Trevor Wu <trevor.wu@mediatek.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        alsa-devel@alsa-project.org, "chunxu.li" <chunxu.li@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 0/6] ASoC: mediatek: Allow separate handling of headphone and headset mic jack
Date:   Thu, 22 Sep 2022 19:59:45 -0400
Message-Id: <20220922235951.252532-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.37.3
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


This series allows the headphone and headset mic jack status to be
handled separately by userspace on MT8192, MT8195 and MT8186.

Changes based on commit d0508b4f1604 ("ASoC: rk3399_gru_sound: Add DAPM
pins, kcontrols for jack detection"). Found while searching for an
alternative for JackSwitch [1].

[1] https://lore.kernel.org/all/b98a8a77-7652-1995-27ba-eb7b6d30202a@gmail.com/


Nícolas F. R. A. Prado (6):
  ASoC: mediatek: mt8192-mt6359: Expose individual headset jack pins
  ASoC: mediatek: mt8195: Expose individual headset jack pins
  ASoC: mediatek: mt8186-da7219: Add headset widgets with switches
  ASoC: mediatek: mt8186-da7219: Expose individual headset jack pins
  ASoC: mediatek: mt8186-rt5682: Add headset widgets with switches
  ASoC: mediatek: mt8186-rt5682: Expose individual headset jack pins

 .../mt8186/mt8186-mt6366-da7219-max98357.c    | 25 +++++++++++++++++--
 .../mt8186/mt8186-mt6366-rt1019-rt5682s.c     | 25 +++++++++++++++++--
 .../mt8192/mt8192-mt6359-rt1015-rt5682.c      | 17 +++++++++++--
 sound/soc/mediatek/mt8195/mt8195-mt6359.c     | 17 +++++++++++--
 4 files changed, 76 insertions(+), 8 deletions(-)

-- 
2.37.3

