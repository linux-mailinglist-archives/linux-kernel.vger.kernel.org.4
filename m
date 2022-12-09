Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D156488DD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 20:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiLITOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 14:14:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiLITOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 14:14:41 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135F9186CF
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 11:14:40 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id t11-20020a17090a024b00b0021932afece4so9107336pje.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 11:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6UB0YOGyychK/2QqsDbt3+Ytc2kYn0bzS2eLbN1tkGw=;
        b=k9OnBKq1FrKRkzxdBmOluPdfXgUk+ZttA1oRPSB0k7hL/PgYajzWyOCKC3omah3Hpz
         wsPxlKZhgtVvn0Mxg4lLheqOQHILrvkbyToqsRtttAQzMDQIpYQs8G4XqXE6hKf+l7Dj
         0MBwTjeK5FPHjDp7HX3wszEuJ9fRCCoQ9Pi8EZ6NZEjpMCVh681h2jPwTPdzS5By61Hq
         bOxhGMf4F1eNvvfv9zzWbzv9xjqLhxmirSjqOiOBbxPr47QV+X0rA38OF1+wntPtLRd+
         ISyXkgxMufrh60ATQzHo+7zflriYtrs+vUf/oGb9BuaCQtYQJ05nVdHF5FQUFi4pjlaX
         1nDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6UB0YOGyychK/2QqsDbt3+Ytc2kYn0bzS2eLbN1tkGw=;
        b=Nk5bRSdK9egDKkzmYFv0f8P/1GRO6xWwPEk4KQRZuE2rIg1YMINHMH/CMBS9PZWz3Z
         1ezo8cixxnWkuQXpjQh51Ok/Qbdd2ghbsy+l2W1gqnWy2kGQlYUNAMKFtCU0RwT/xMzp
         cZoPjvAdmYLG/jhCtR5coV5nVeK3D59v6sog/hVBCkcsNt1XlwWuHWewGB13+zjqSnnF
         +zXs/cjfrz7Y4RmFgaGPksHnup9BzOhhZs3RpPGISyf/XlJGVmqP8+agOpJWOkZHPY9d
         cnxiReuoNVfd7+eLTpZaZ5T5XovfBc3Fs7gvt+yFvhTH0F7GD6KDy/nLcniuUQVUvEjP
         NZwA==
X-Gm-Message-State: ANoB5pmeLWy84MuYY7lteEFA+qIII+IeQIq7ASrQ92R5WJuLmSx78a/K
        lDq6l6IrtGd5nBYju8tAAIzevA==
X-Google-Smtp-Source: AA0mqf79ax/sypRX+Pt/dn9MwObJdpQ/HTx0JxroKJSRPDqpuaoKM3EM2YzwhZiK6awwCfm0O2FR3A==
X-Received: by 2002:a17:902:a70e:b0:185:4421:7300 with SMTP id w14-20020a170902a70e00b0018544217300mr6830199plq.69.1670613279485;
        Fri, 09 Dec 2022 11:14:39 -0800 (PST)
Received: from localhost ([135.180.226.51])
        by smtp.gmail.com with ESMTPSA id t17-20020a170902e85100b001871acf245csm1681062plg.37.2022.12.09.11.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 11:14:39 -0800 (PST)
Date:   Fri, 09 Dec 2022 11:14:39 -0800 (PST)
X-Google-Original-Date: Fri, 09 Dec 2022 11:04:46 PST (-0800)
Subject:     Re: [PATCH v3 1/2] soc: microchip: mpfs: handle failed system service requests
In-Reply-To: <20221123175652.327859-2-conor@kernel.org>
CC:     Conor Dooley <conor.dooley@microchip.com>,
        jassisinghbrar@gmail.com, daire.mcnamara@microchip.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Conor Dooley <conor@kernel.org>
Message-ID: <mhng-fc50aea2-a2ff-4d2e-a906-0892ee40ca2f@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Nov 2022 09:56:51 PST (-0800), Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>
> If a service request fails, a non-zero, per-service error code will be
> set. Since the individual service drivers may wish to handle things
> differently, there's little point trying to do anything intelligent in
> the system controller driver. Let the caller know that things went wrong
> & leave the details of handling the error to it.
>
> Fixes: d0054a470c33 ("soc: add microchip polarfire soc system controller")
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  drivers/soc/microchip/mpfs-sys-controller.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/soc/microchip/mpfs-sys-controller.c b/drivers/soc/microchip/mpfs-sys-controller.c
> index 6e20207b5756..539fc24b397d 100644
> --- a/drivers/soc/microchip/mpfs-sys-controller.c
> +++ b/drivers/soc/microchip/mpfs-sys-controller.c
> @@ -52,6 +52,12 @@ int mpfs_blocking_transaction(struct mpfs_sys_controller *sys_controller, struct
>
>  	mutex_unlock(&transaction_lock);
>
> +	if (ret)
> +		return ret;
> +
> +	if (msg->response->resp_status)
> +		ret = -EIO;
> +
>  	return ret;
>  }
>  EXPORT_SYMBOL(mpfs_blocking_transaction);

Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
