Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16F064BBB4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 19:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236357AbiLMSNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 13:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236538AbiLMSNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 13:13:39 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DAC15814
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 10:13:38 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d7so636740pll.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 10:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bsAx81CS2oGtFlCOIKJ8N6Se9n8UswnoX6gUXWJhq9s=;
        b=VuOVc9dMuIMJz0Dd34VYPlU6ugaxmknQDoMrG5R7uQ5/qpQpbyKwiY7mNU+QgDUtCK
         VkpAdxjZCrFA2AMI7fBHmIIkmi/kUbLQPoxtN0WcjCl9Wu9pcPv2N9pbGogcYhmmgu9x
         wuB1AkD9GkJYjpTrvyeJmuVJOnt7HPvElLbG7uivUVNghl8B8jEXZeTqTyTxUsFVtTS7
         U2qeQkM3IsBjwUJnG2ATPrYF+QYaYNX0X/Kt4O3HyDCyAcRLNQkML35HHbvsC19YHzyq
         Ue5043VbSlz6zLlvo1tcJHA0EmlHu3Ecg/ObI9fgQ6NOjD18pG5cCS68BdXHOs+DiSuR
         0Q4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bsAx81CS2oGtFlCOIKJ8N6Se9n8UswnoX6gUXWJhq9s=;
        b=bhe5wpq1WUJxJONuD5diJr9bpzTH6u8De7mbXDCchLhQ7GFJzMo1yfL1if3vL+aJ9t
         ic+ydCyzAgexdbYyJXB0TwW7fSjDhLjAsBLAJrPnrLBogkng/q5OqVrSu+25aO3BtfRo
         63+b5gha2MKAbsF0iojv5k5wIak0CuyhPCFj7lDzC0ElMIXE7tvAkzsjcvZdAX9coSB3
         2RHrV7edISzxGeki7++UbdNKZ8I9Z1rxqU3jAowgEaqT8XfttC636LccZc2DXYLPAKBp
         X1/T7gvVx1u74k5e3DKxlUleTKSjOrMdAra8a/gBN6A5z8O8aEG2OfeYYWtjxkXWwyX5
         T9gQ==
X-Gm-Message-State: ANoB5pk7PskcERrHY3kXkLjbyG7mwlsdG32q6RnR0fexHP3CfeVm9n0B
        Dq2Eq0a7PzkcUhAe8Q2tp8yt5BpBfPL6jA1hy2YinA==
X-Google-Smtp-Source: AA0mqf4/WHF+AYjmztxjz2jxNUncNhbMJ1aubsknOZGZah2GaEZhPlFE9bFEzQuI53SC2AwxWPH0+sI2DPdk1GSfNbM=
X-Received: by 2002:a17:90a:6708:b0:219:2b00:8d23 with SMTP id
 n8-20020a17090a670800b002192b008d23mr412904pjj.167.1670955217708; Tue, 13 Dec
 2022 10:13:37 -0800 (PST)
MIME-Version: 1.0
References: <20221213115617.25086-1-yc.hung@mediatek.com>
In-Reply-To: <20221213115617.25086-1-yc.hung@mediatek.com>
From:   Curtis Malainey <cujomalainey@google.com>
Date:   Tue, 13 Dec 2022 10:13:26 -0800
Message-ID: <CAOReqxihOWVh0rGqwqCJ3SEOnEpH3RDQv-U1PEQJ6Tj5e02Vag@mail.gmail.com>
Subject: Re: [PATCH] ASoC: SOF: mediatek: initialize panic_info to zero
To:     YC Hung <yc.hung@mediatek.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chao Song <chao.song@intel.com>,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        chunxu.li@mediatek.com, Trevor Wu <trevor.wu@mediatek.com>,
        Curtis Malainey <cujomalainey@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 3:56 AM YC Hung <yc.hung@mediatek.com> wrote:
>
> Coverity spotted that panic_info is not initialized to zero in
> mtk_adsp_dump. Using uninitialized value panic_info.linenum when
> calling snd_sof_get_status. Fix this coverity by initializing
> panic_info struct as zero.
>
> Signed-off-by: YC Hung <yc.hung@mediatek.com>

Reviewed-by: Curtis Malainey <cujomalainey@chromium.org>
