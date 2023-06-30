Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEF9743D72
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 16:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbjF3O1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 10:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjF3O1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 10:27:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0D23AA4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 07:27:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5506D6175D
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 14:27:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB939C433CB;
        Fri, 30 Jun 2023 14:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688135238;
        bh=mKsth7EbgkktN+M1x6jv9ltsVnjMGds9Bu4btwXjhuc=;
        h=From:To:Cc:Subject:Date:From;
        b=i+wLH/8aztVS6laPB94qFGyj49FNfrCnK1P4cZtv8bt+cErbMbT6EHOinqk6S6IG2
         A0oRHVrLT/N75GT2CeKVImUVz0vCZ/M1tbxy8QAjZCGkxeq470Q580o4d8Hmh2wGL5
         9OXmakeNK9A6lNP5GUUwBfS7vRKWDjlC3JZK3oZ1+iX/qKxXaXWu86FXn0LZfgOOiH
         M/ZkTqq1aVOJZ8sR/7bY52YvtrtEmPlr4UO9abheW48h+YJWz/nc8KrVyxbkBPPXfn
         LRhrTpiFBv3bmSUVeStZxhGM1xdFFt16ASmQvxQInsbznK+mmJBoMegKXUj6njSzJd
         kq8C5/9LfAVww==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1qFF5o-0001O3-FO; Fri, 30 Jun 2023 16:27:25 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Mark Brown <broonie@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/5] ASoC: codecs: wcd938x/wcd934x: loglevel fix and cleanups
Date:   Fri, 30 Jun 2023 16:27:12 +0200
Message-Id: <20230630142717.5314-1-johan+linaro@kernel.org>
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

When investigating a race in the wcd938x driver I noticed that the MBHC
impedance measurements where printed at error loglevel which is clearly
wrong.

Fix that, and clean up the logging somewhat by using dev_printk() and
addressing some style issues.

Included are also two patches that drop the bogus inline keywords from
the functions involved.

Johan


Johan Hovold (5):
  ASoC: codecs: wcd938x: fix mbhc impedance loglevel
  ASoC: codecs: wcd938x: drop inline keywords
  ASoC: codecs: wcd938x: use dev_printk() for impedance logging
  ASoC: codecs: wcd934x: demote impedance printk loglevel
  ASoC: codecs: wcd934x: drop inline keywords

 sound/soc/codecs/wcd934x.c |  8 ++++----
 sound/soc/codecs/wcd938x.c | 17 +++++++++--------
 2 files changed, 13 insertions(+), 12 deletions(-)

-- 
2.39.3

