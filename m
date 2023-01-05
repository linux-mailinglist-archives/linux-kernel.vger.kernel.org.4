Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E17E65F298
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 18:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235459AbjAERZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 12:25:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235496AbjAERYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 12:24:41 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71E43DBE6;
        Thu,  5 Jan 2023 09:18:52 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id bk16so23586158wrb.11;
        Thu, 05 Jan 2023 09:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VChtWA5HK5AG2rAtUk+ztjmVxkEmPar/HvsaNCiAzRw=;
        b=j00VTv2Y9d4T95tjvsiMRYO5bG4sGTI54DKqwcVm6IgjWgfc1erF65qYDJh54nEUPM
         ohQoo6qK1e0w2B/OnP42WLot8g7OPpSxJGaW7bGVOar4NfJTA1emfs2D9NRl+xWGUlzx
         LDuVpNedTSX7KVF+WxD5zBeSjx6+PSJTvvT3nJFKkJ+YtAgXYKk8vkHIC2jROM+IFFID
         +GVJzcnqu7Gmyt66cSeTACxDpoGvdJ65AlKjRpvlnMY8dVc4m0QZx67lL5lBoTSO7eaQ
         emGIAGL0YFxXG8FK7zLsMZVaQwdtPhg/lmHfS3/hTMJML+B8+MPvV6ARYB/j3cwR86oL
         FR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VChtWA5HK5AG2rAtUk+ztjmVxkEmPar/HvsaNCiAzRw=;
        b=aSVS0PLr5YuOCa+5RPMLdfPYJgUaXd/c1JNL/SoFWdV5kJ2cfB3j/vvGeWuHNJpjVI
         1PkzmN/zsouxXrWgPpHtfWxtx2AVc48yptgohdtJUvVtOu2TViH93SMxuK6kfW0cBCsC
         l2S6rvT+gP2h1iL8+p+dowPT6/D0llt3C+MY8HJ5dPyZk6G6M6jCNzhidsysA1i1Fx47
         vliaNYjqjLjdVIJ9DqdCpwgysO+ttT8Mx02HyRVFZJVk2zF7aMDsI7K0ABU02zvWEnRm
         w5wd/j1hflGE1kHwGU/2+nj/1+rVZqYoRUg7mhhl2C/5+sZut9lRMUFMmAZTN9L/feJs
         3oqQ==
X-Gm-Message-State: AFqh2kpJEKTeWVEqN7Ms6LfN39R1F8puvV4X0C6r8NgQA/hAx1CImwoc
        VZ9/LlN6TO/dqviI2dSMOaE=
X-Google-Smtp-Source: AMrXdXt9qSAGc/Dlf6Chtr57J60AD6VkWYwy/2f7x8saezg8sBS79QzWuezFNygWI11cXhMjz/npuA==
X-Received: by 2002:a5d:6e0a:0:b0:242:10ac:ac42 with SMTP id h10-20020a5d6e0a000000b0024210acac42mr33558999wrz.55.1672939131327;
        Thu, 05 Jan 2023 09:18:51 -0800 (PST)
Received: from jernej-laptop.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id m15-20020adffa0f000000b0028f9132e9ddsm18227421wrr.39.2023.01.05.09.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 09:18:50 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 2/2] rtc: sun6i: Drop the unused has_out_clk flag
Date:   Thu, 05 Jan 2023 18:18:49 +0100
Message-ID: <3471996.iIbC2pHGDl@jernej-laptop>
In-Reply-To: <20221229184011.62925-2-samuel@sholland.org>
References: <20221229184011.62925-1-samuel@sholland.org>
 <20221229184011.62925-2-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

Dne =C4=8Detrtek, 29. december 2022 ob 19:40:11 CET je Samuel Holland napis=
al(a):
> This flag was never used by the driver.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



