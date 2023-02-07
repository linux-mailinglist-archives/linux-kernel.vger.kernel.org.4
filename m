Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158A668D8CD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 14:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbjBGNNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 08:13:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbjBGNMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 08:12:51 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F0E279B1;
        Tue,  7 Feb 2023 05:11:56 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id m8so15384690edd.10;
        Tue, 07 Feb 2023 05:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IDyA4ggqisB45/w/0REkOlZ81YKrrNesSQZoTA7f6To=;
        b=UIh8SrGt8+V5BJZAYpFdffjM72nB+aFHeNjz1XnZV8VZpiZS7pC6e5xmG9iQZxW129
         ZIxdVyIOS3zPJI0+SKripsm1FqcNKprWTJi3PAQ9Emo2Aw214Ez8pctFp3ktPTTMmR/Q
         65d4fTWG8yvQiqaNRGCVScTeIGLemW2jjyRGzhcs7VAKPFjGsqSNvkQEGxjOveq3K7tZ
         0uMVfIZqMQ5k+uQL87fQxmsWZW0R17S5ntL1rxFs+gnEnRnmRl9JF8CPAozgHmuF8wi4
         UCdzr4yfMvyDKl+O/tt1UyZna8ORFzrHw0CQnpVGQi/x+LXyKNUrroNy8FcwScjD+eox
         RVSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IDyA4ggqisB45/w/0REkOlZ81YKrrNesSQZoTA7f6To=;
        b=WzY1vyiTEjRoX08VASgOanT6P+f6ok56T+0Ex1HbO+digMC3XqACD1xAnTwDc1fV1M
         xxKq+O6BkIK4kYhOwOnMQjuWHAbiCPrMSREJmU5jLpIUJyJoI2sINHRu84mMqu7+cNdw
         +KPMbtcSGGmJewOeEcno56DPDF6YHr8s4ZEjemPqk/xLXsYLtnS/VXOuSzLTU1fKbAIR
         T6rdbW5F9d24Se8IFBp0xfmvFfdZVZlJmousdhns6lq6yjd0Xd8/a1gBsfMByJ/5GQvy
         rGvjxWcfTwLoOa/fo+GUdB8anFMfPgf7w8+e5xCF+AL+V4QZDM5wNDf2vAekIQ5BuXRt
         01yg==
X-Gm-Message-State: AO0yUKUPgmofxo1PHyOSPSfODY9SfkuzPYJDVHGmkXSRvzZa03NGuVs3
        FHWv7oPmvG61hs7WZ3ONkm82EWa71uD/Wm6+V5o=
X-Google-Smtp-Source: AK7set8+3AsI8dOzNizw0yiS9RSPpB1Vb9Xa7G32ZNeTI052jTnUlRWYw69vyq1+8Iq9SS65J0zL7dOTlzHJyGcWixg=
X-Received: by 2002:a50:9ee2:0:b0:4a2:4e5c:6b2f with SMTP id
 a89-20020a509ee2000000b004a24e5c6b2fmr600275edf.2.1675775509214; Tue, 07 Feb
 2023 05:11:49 -0800 (PST)
MIME-Version: 1.0
References: <20230206150751.28618-1-iuliana.prodan@oss.nxp.com>
In-Reply-To: <20230206150751.28618-1-iuliana.prodan@oss.nxp.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Tue, 7 Feb 2023 15:11:37 +0200
Message-ID: <CAEnQRZBc2EWHWev_OCsiQKj2kYZZ2vmoBpJaLJX1nBpDN=AQEg@mail.gmail.com>
Subject: Re: [PATCH v3] remoteproc: imx_dsp_rproc: add custom memory copy
 implementation for i.MX DSP Cores
To:     "Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "S.J. Wang" <shengjiu.wang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        linux-imx <linux-imx@nxp.com>, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 6, 2023 at 5:28 PM Iuliana Prodan (OSS)
<iuliana.prodan@oss.nxp.com> wrote:
>
> From: Iuliana Prodan <iuliana.prodan@nxp.com>
>
> The IRAM is part of the HiFi DSP.
> According to hardware specification only 32-bits write are allowed
> otherwise we get a Kernel panic.
>
> Therefore add a custom memory copy and memset functions to deal with
> the above restriction.
>
> Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
> Reported-by: kernel test robot <lkp@intel.com>

The reported-by shouldn't be here, as LKP only reported some warnings
to your original patch.

I think it is enough to credit it inside version history.
