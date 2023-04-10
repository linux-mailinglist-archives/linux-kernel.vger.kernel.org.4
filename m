Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42ABE6DCD8D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 00:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjDJWjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 18:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDJWjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 18:39:08 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CD21BCC
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 15:39:06 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id o18so5721963wro.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 15:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681166345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6jQtQIg81hhKy0u5QqnR6EQxCUiuIoJOyPsQHQCmMj8=;
        b=cJe5Pn9w6R7GRNmQYB/y5Khb3421RiECmYHpLU3DkYSHrPUtokDoOc/o2nUKqBMMXb
         8Y4U5Ju5pQ8Er7qtYsAjkF2I/OqiDBR4+PeENRIUjVxTjHJxk2DgwKKtcBDrqB7+A1p4
         b1ks3PWPnCPjxQVpSnmHF4k3ekIUcqcBl73+zQAgdEMlF1eetL39YnIaaysppH9VkwkY
         RVLCD27T53F/KjGqAS2aU3Rp0k6CN3idh2i/WLXDuiYRHorKlVr0PNlbkKu/9XNZwkfk
         BG8YMmNotv4MzTQd/1N572qacnAP5ScBrVng7Q1Kpt0NaLJ1vK38Jl9wFtZ2Yx37vdC9
         X5qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681166345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6jQtQIg81hhKy0u5QqnR6EQxCUiuIoJOyPsQHQCmMj8=;
        b=oUqBKauenTgCjfmROejHdMGk+stgsoSNmr6iDb37JaKsAoSlRKfBbAhPcGO9BkSzUj
         szp2ryX6AZVWCZVQ5uOD+nrffD1yFH3UmMhRA4mWCcOEWuYT77bDnvGX3SAMF1Kx9xkr
         A75YMH9iLZy/tP1QMKMl2w1Dh4D3bj0aNRRKQ/UX/qlnYdHAhwIAMICy3EL9oj1mVLv4
         /01HggEE5EoNCYAgmfxSx1FT/Z3K/dITnLhaNDGzEA8fDJJTywiPNyddZZHiFZ60mopP
         EbeLs20QO5pZAJA5tFN3ngnaiYdHdeXtuQ6SrK/M3H6fl9xfntlxb2OSOffvzVJ05gNM
         C/XA==
X-Gm-Message-State: AAQBX9eMLlOmgnFdfJHFt/29HLT8To1MmN04p3bkYDmQuS+C2mPi/ikH
        e3gBzFBbKQtek/6xkRuRBlk=
X-Google-Smtp-Source: AKy350bNQFzw2ewXKA4xP/NvzT+o7phQookx45WDlyf/ustqMgKLnz3cjNBmbRRMckkflrs8HSDEeQ==
X-Received: by 2002:adf:f28c:0:b0:2ef:bb8b:3bf5 with SMTP id k12-20020adff28c000000b002efbb8b3bf5mr4983303wro.38.1681166344746;
        Mon, 10 Apr 2023 15:39:04 -0700 (PDT)
Received: from localhost ([2a02:1210:8629:800:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with UTF8SMTPSA id k9-20020a5d4289000000b002d21379bcabsm12779178wrq.110.2023.04.10.15.39.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 15:39:04 -0700 (PDT)
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     alsa-devel@alsa-project.org
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        David Rhodes <david.rhodes@cirrus.com>,
        James Schulman <james.schulman@cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 0/3] ASoC: ep93xx: Prepare for DT transition
Date:   Tue, 11 Apr 2023 00:38:59 +0200
Message-Id: <20230410223902.2321834-1-alexander.sverdlin@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a preparatory series for EP93xx transition to DT. This patchset is
a pre-requisite and has been tested with the full DT patchset [1].

[1]. git://git.maquefel.me/linux.git branch ep93xx/6.2-rc4-v0

Alexander Sverdlin (3):
  ASoC: ep93xx: i2s: move enable call to startup callback
  ASoC: cs4271: flat regcache, trivial simplifications
  ASoC: ep93xx: i2s: Make it individually selectable

 sound/soc/cirrus/Kconfig      |  6 +++++-
 sound/soc/cirrus/ep93xx-i2s.c | 12 +++++++++++-
 sound/soc/codecs/cs4271-i2c.c |  1 -
 sound/soc/codecs/cs4271-spi.c |  1 -
 sound/soc/codecs/cs4271.c     |  4 ++--
 5 files changed, 18 insertions(+), 6 deletions(-)

-- 
2.40.0

