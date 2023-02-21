Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C7E69D81F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 02:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbjBUBpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 20:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbjBUBpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 20:45:02 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25BDA5DC;
        Mon, 20 Feb 2023 17:45:00 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id i9so3625761lfc.6;
        Mon, 20 Feb 2023 17:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=34lDDydAwAjd3gUwJRFbQoccKORNig7o9dp+cyLAa44=;
        b=hhBJOZuMVo1ePfb3/3F68gF6BC3ON4xQ3y3JcnWFv09WbtqsPLa5Mb3U7Zh+cKDKCF
         kvO9182b9JjrjENaevcIEelP/puJZI7VtplNpyOE8UrLFtbRdBDMwal8hE7xPL0PEt7k
         ZzST/MOdeg29aK5EoPZ/TyX/hWQ2BHChevLsdy5Eo1smhAM/ZP0OoU8VYV154M60PXzR
         0icNAm/PmkJQuQDMoZm+QfP340RnMnd+p4qZ96mVU81UR7LAHyMEUPvTu7ckzT2+krv/
         K+GxG8mVqKyyAnQmuwOA5+8cO2/eUrt2Jj1bar1F4NjWhFPNYsec7Q0J4qkt+EPEFtQu
         SAlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=34lDDydAwAjd3gUwJRFbQoccKORNig7o9dp+cyLAa44=;
        b=Zy78+99+YZxKcerPwnx3x6PPw6TxKE+nxjWMAjiMvXAlgHSeXtHTaeznlAZPD7T6vd
         v6JlNxBD2Fm+UXFYke4yOHDKp+EAQMGQofPprUsM/lurEhH0FqhThXc8t/I3bjQ/qh/P
         7QBv9KPDfqyhZn/UensIcD/vzsPDDRxfnk/qIRrTBNkSXSUsYxteLtj5woKsTAmpkkp9
         Ud77Ka7rn3p9h0WYmOd9rbdhZ6GvhMIpoDfyhLMO8jkc5WNlzN2hbGOMKlim27yxD8XX
         Tf4EYiuW1JWphpuhWAFPmKLLQi2ulmuj/lU+YtcGbx2v/zxFFmoiIMngXfqjQ9B1BEXV
         sFtQ==
X-Gm-Message-State: AO0yUKXeryqzVyXuFYB7AF9+wxH2gtPqz/mk8uAoiSxRuJHHV+zOvGkn
        AVqhUjoQ0QHL/zsTBoH1h5QBRi5fCSdSThIQbWOolM/1yg==
X-Google-Smtp-Source: AK7set9Iu6OicBYAy8yoZbvlxVUSUKcFs1DOnRErdCLJJTpX8gi0u3toSKpGGdcUc5c9tHFS+Lce1M8lfxi7dHbnRJc=
X-Received: by 2002:ac2:5e8c:0:b0:4db:38a7:f32f with SMTP id
 b12-20020ac25e8c000000b004db38a7f32fmr1165437lfq.4.1676943898660; Mon, 20 Feb
 2023 17:44:58 -0800 (PST)
MIME-Version: 1.0
References: <20230220142431.54589-1-frank.li@vivo.com>
In-Reply-To: <20230220142431.54589-1-frank.li@vivo.com>
From:   Stanley Chu <chu.stanley@gmail.com>
Date:   Tue, 21 Feb 2023 09:44:47 +0800
Message-ID: <CAGaU9a-xmWFhXSZ0Zt7O2xvVz4xd-AY1giFAeKFnAxHAgUx5pw@mail.gmail.com>
Subject: Re: [PATCH] scsi: ufs: ufs-mediatek: guard ufs_mtk_runtime_suspend()
 and ufs_mtk_runtime_resume() w/ CONFIG_PM
To:     Yangtao Li <frank.li@vivo.com>
Cc:     stanley.chu@mediatek.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, zhangshida@kylinos.cn,
        k2ci <kernel-bot@kylinos.cn>
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

Hi Yangtao,

On Mon, Feb 20, 2023 at 10:44 PM Yangtao Li <frank.li@vivo.com> wrote:
>
> To fix below compile error(CONFIG_PM set to 'n'):
>
> drivers/ufs/host/ufs-mediatek.c: In function `ufs_mtk_runtime_suspend`:
> drivers/ufs/host/ufs-mediatek.c:1623:8: error: implicit declaration of
>         function `ufshcd_runtime_suspend`; did you mean `ufs_mtk_runtime_suspend`?
>         [-Werror=implicit-function-declaration]
>  1623 |  ret = ufshcd_runtime_suspend(dev);
>       |        ^~~~~~~~~~~~~~~~~~~~~~
>       |        ufs_mtk_runtime_suspend
> drivers/ufs/host/ufs-mediatek.c: In function `ufs_mtk_runtime_resume`:
> drivers/ufs/host/ufs-mediatek.c:1638:9: error: implicit declaration of function
>         `ufshcd_runtime_resume`; did you mean `ufs_mtk_runtime_resume`?
>         [-Werror=implicit-function-declaration]
>  1638 |  return ufshcd_runtime_resume(dev);
>       |         ^~~~~~~~~~~~~~~~~~~~~
>       |         ufs_mtk_runtime_resume
> At top level:
> drivers/ufs/host/ufs-mediatek.c:1632:12: error: `ufs_mtk_runtime_resume`
>         defined but not used [-Werror=unused-function]
>  1632 | static int ufs_mtk_runtime_resume(struct device *dev)
>       |            ^~~~~~~~~~~~~~~~~~~~~~
> drivers/ufs/host/ufs-mediatek.c:1618:12: error: `ufs_mtk_runtime_suspend`
>         defined but not used [-Werror=unused-function]
>  1618 | static int ufs_mtk_runtime_suspend(struct device *dev)
>
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Reported-by: Shida Zhang <zhangshida@kylinos.cn>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Thanks for this fix.

Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
