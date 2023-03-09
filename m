Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557F86B1ADC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 06:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjCIFi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 00:38:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCIFi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 00:38:57 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FED6A1D9
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 21:38:55 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id da10so2585504edb.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 21:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google; t=1678340334;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OeETnbz0R1vylDFEe1nHfiVTBeqtDRVmuzrxUEbrY6w=;
        b=LblaaEoxCfpBpDd+i0lEvLWX3CkBh9iPxFhEyOcE43sSBPLAJLTpQBqP/joaw+1kk8
         H+o7dnugPDQNNnv8Ous/Kg2rc01hlgRQK7VJQls00+Juwcp/JykG/owv4St1N2CJt5CQ
         7GxCy2xqECnPy+vwMdrfXvOwWJwRwjwGkfhd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678340334;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OeETnbz0R1vylDFEe1nHfiVTBeqtDRVmuzrxUEbrY6w=;
        b=7ciHFxlngjwbyGjiV+QAnd53wQQgjXO1nKwbWRDeJ0jUKlC0aVMul34ZK224XiC8Oi
         A02a4YIebNtHXnnxs0saKZ+nFX8Jh3PCNanrVqP7QiNcwgY24VVSKR+w5fQAqOIKUepf
         qU00XPqLECot29PIhYpTPMdD3rWBXa2KOh4z/0U3BoK9zEDcEqaRGC0wITDiDO6E4TgY
         8UYSmkK7yNnTjwyPDSESA27jj8wX7QXxh+fsQ77qpOo3Lt+9RfLZuDZK7F71jk1Mh2n7
         fDsFbEIFfLkk3/WYBYF9OOtWA/L+jIH1FxTrFW1BaI2fyNqQQbOlcsv6aUZ0libkl2bZ
         KSlA==
X-Gm-Message-State: AO0yUKVlOmAsnEAfMGruxwMD0TakbzAnXeat8r1P29TfPgvcr3t2ZUTv
        9swCG4byFHUYpJqXOZKGaP3JZM+3ShsJILGDQnw=
X-Google-Smtp-Source: AK7set+hflEs+cFeFyxsYndDhymHjVxXkrCD7nnA8Z1iHFlDOWKwNCE0oUK6fuQluugZcNbDHTtxfV/MeaYnNE/nBvc=
X-Received: by 2002:a17:906:328c:b0:8b1:79ef:6923 with SMTP id
 12-20020a170906328c00b008b179ef6923mr9623874ejw.15.1678340334044; Wed, 08 Mar
 2023 21:38:54 -0800 (PST)
MIME-Version: 1.0
References: <20230306225249.975495-1-eajames@linux.ibm.com>
In-Reply-To: <20230306225249.975495-1-eajames@linux.ibm.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 9 Mar 2023 05:38:41 +0000
Message-ID: <CACPK8Xda32NL8hvFD0fMTKeQnoBOKCz63W=vMJ+X4p_TJ2LCjw@mail.gmail.com>
Subject: Re: [PATCH] fsi: aspeed: Reset master errors after CFAM reset
To:     Eddie James <eajames@linux.ibm.com>,
        Joachim Fenkes <FENKES@de.ibm.com>
Cc:     linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        andrew@aj.id.au, alistair@popple.id.au, jk@ozlabs.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Mar 2023 at 22:53, Eddie James <eajames@linux.ibm.com> wrote:
>
> It has been observed that sometimes the FSI master will return all 0xffs
> after a CFAM has been taken out of reset, without presenting any error.
> Resetting the FSI master errors resolves the issue.

Eddie, you mentioned that Joachim was going to provide input on this
change. Did you hear from him?

Cheers,

Joel

>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  drivers/fsi/fsi-master-aspeed.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
> index 7cec1772820d..5eccab175e86 100644
> --- a/drivers/fsi/fsi-master-aspeed.c
> +++ b/drivers/fsi/fsi-master-aspeed.c
> @@ -454,6 +454,8 @@ static ssize_t cfam_reset_store(struct device *dev, struct device_attribute *att
>         gpiod_set_value(aspeed->cfam_reset_gpio, 1);
>         usleep_range(900, 1000);
>         gpiod_set_value(aspeed->cfam_reset_gpio, 0);
> +       usleep_range(900, 1000);

Is the delay required? How did you arrive at this time?

> +       opb_writel(aspeed, ctrl_base + FSI_MRESP0, cpu_to_be32(FSI_MRESP_RST_ALL_MASTER));
>         mutex_unlock(&aspeed->lock);
>         trace_fsi_master_aspeed_cfam_reset(false);
>
> --
> 2.31.1
>
