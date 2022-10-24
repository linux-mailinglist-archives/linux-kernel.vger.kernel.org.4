Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB0160B5D7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbiJXSlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 14:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbiJXSlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:41:05 -0400
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF261057DF
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:22:46 -0700 (PDT)
Received: by mail-pl1-f180.google.com with SMTP id io19so4048236plb.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wQlo3EGPItBuzHrQYdhs7siuCNxgTb6N4tdeGMEYPmg=;
        b=r6BcM5bPHTx+CZ/xITZDNypxRIKxZAhLLtBF9eGUnGF1EEXcMJBiAEppYxIg5nU974
         ufMdIzQaInTisbMym8yR1/G79VLjdpTZXN3uqdinOCCypznM3Z3dQz4u9AN2Ckm8o4tS
         Zb6aXTkzjHnydvU7PL8D6+mUAHNTzOSClsD/kNwrLV6XSFXct/rStsHywYRK0xFhLVPI
         ACj6e7nZS3MpTO2liPnN7jGztHYLJoY6XmlD3XCwVCDwptwxa0ulyTP6b8PbOPVhzaLv
         FuPhNbLwOf5alEo2FJ4n2LvpduSHZpqLJeGWohSjzV0KQu+cQg4UP2FZPa7EN55D1k75
         Xyfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wQlo3EGPItBuzHrQYdhs7siuCNxgTb6N4tdeGMEYPmg=;
        b=2gqZia9iK7oGJVKyQrnQmojIEKqvNmgS0D6ErVg9kGESauJdqOuTtZwP9qIgIqBAG1
         SdHVL4nSAVAiCYACSRiJUTCYW0RhA87h3dP3et8OvmiOnUJ8ZFiUl9P6FUsD+HKaTC9D
         4a0RRl6/pVtfdxThzgPkBO4FS4FtK4ZyHGQ45QLmMmZycm16ubgdDponjm+f9Oy3QnlS
         FebR67OiDkNqAhrermC4Abt2lU1S76iY9ExPhPTotBuilG7vYAcP3jOO+h34Ua5nwNa3
         5HIZfMR4otwOTPi4HVZu944t+XNEmva2bXB7KAS5eea8YX1aQi4mn9b/upJKJiCZvjr1
         e0oQ==
X-Gm-Message-State: ACrzQf3ok4jd2HKV7Yoz7axIWXPDzwHi52p0084Q00n/GbTuT3J0HZt7
        3Yh/5wtCU+Cnbn1USyaWCK5C8mKfDw27lzw3fDbQ6w==
X-Google-Smtp-Source: AMsMyM5WBBFAAfIn9WtDfPDuABCV54WS+zJkcHcW88tzTpF+YchV1WG7oz2KmjlVBqKiRg5LDZYniE/BxUHJidZRrJc=
X-Received: by 2002:a17:90b:4d07:b0:1ef:521c:f051 with SMTP id
 mw7-20020a17090b4d0700b001ef521cf051mr77094132pjb.164.1666631783789; Mon, 24
 Oct 2022 10:16:23 -0700 (PDT)
MIME-Version: 1.0
References: <20221020130123.4033218-1-vincent.whitchurch@axis.com>
In-Reply-To: <20221020130123.4033218-1-vincent.whitchurch@axis.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 24 Oct 2022 19:15:46 +0200
Message-ID: <CAPDyKFrMHA-AgHbAoFTiGru=JPbWYeggCJFnOCyzRLLg-19Fng@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Fix WRITE_ZEROES CQE handling
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     kernel@axis.com, Jon Hunter <jonathanh@nvidia.com>,
        Avri Altman <Avri.Altman@wdc.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Oct 2022 at 15:01, Vincent Whitchurch
<vincent.whitchurch@axis.com> wrote:
>
> WRITE_ZEROES requests use TRIM, so mark them as needing to be issued
> synchronously even when a CQE is being used.  Without this,
> mmc_blk_mq_issue_rq() triggers a WARN_ON_ONCE() and fails the request
> since we don't have any handling for issuing this asynchronously.
>
> Fixes: f7b6fc327327 ("mmc: core: Support zeroout using TRIM for eMMC")
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/core/queue.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index fefaa901b50f..3661ba0bbc87 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -48,6 +48,7 @@ static enum mmc_issue_type mmc_cqe_issue_type(struct mmc_host *host,
>         case REQ_OP_DRV_OUT:
>         case REQ_OP_DISCARD:
>         case REQ_OP_SECURE_ERASE:
> +       case REQ_OP_WRITE_ZEROES:
>                 return MMC_ISSUE_SYNC;
>         case REQ_OP_FLUSH:
>                 return mmc_cqe_can_dcmd(host) ? MMC_ISSUE_DCMD : MMC_ISSUE_SYNC;
> --
> 2.28.0
>
