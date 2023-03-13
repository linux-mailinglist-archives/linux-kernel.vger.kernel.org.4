Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E356B81C9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 20:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjCMTix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 15:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjCMTit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 15:38:49 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACFB7F014
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 12:38:48 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id a2so14196450plm.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 12:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678736327;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IVO7PEi2yUALQReAQnVtBqU4m2MDeMLRMQcMWB2PiI0=;
        b=W5VAFVxT5KsRqtiz+5GE7fVAr/3byifsHIfF9hGkKl3m+4e/iWNinGUjiJQQcBURGm
         BtpuoYi09J19BbcCwIARjSdPz2HTN1qUjuTiRpNlVt4j+jLtGIqF4ZNmzHXUoDw4Mw9o
         Qjwf6fysHrAypYip+fUNdluusbd7ljMX7V+2sUtt+0IZ8A5Q34KdTzzXzf9fjkDxOzB6
         ssgcKvdkq5QiNdsuh0sHIrguPigPq412RiDUBZdC+iJ/qpxCWgvQ2lfTTmnk2u3C5c0i
         VJgvHUqXb0e3iKMU3aP4QVI5Jj2xZOWk/OzillHCFcQdFIXlD9h/SJo2uTGskA1/abnL
         KPFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678736327;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IVO7PEi2yUALQReAQnVtBqU4m2MDeMLRMQcMWB2PiI0=;
        b=7N588Q2EKSQ31G/i9Vd2q14MfgkA3t6Poh0j//7sakcLDcgqf7Oc/E4J2TH4N2hgT0
         gtC/Kf1PMId/VjPYjt7kw1ikVndlYB8jNkzAUZ/nGVnwTeMLzAMeG2kZfvLrPQsTYHIK
         YjRWbH65Wno6fKttM7XXhWbmpyGUfkA18F5zgKECm+vGspt9+/wctGOAZ90CWrnnr1PY
         pGH1GXaBWQqP1k5SjobwOsh+3/+Oy/RsOEFqKacXKlLS9QNW+p9N+RAXsauj6OpzRcMK
         YUdv5dk/j7ntyVcX311X48S9qt2uQyrbYplEb44osHz2Hgrb3J+fzBOAD6eCsWg/P134
         ZIDA==
X-Gm-Message-State: AO0yUKUSA+9Ix8LLpom0KdQKsGxFxKGfonqF4I6vl+FfEHaRKGkpb/0w
        u6AdPvlBa56nlTwZSgN1p8JS6A==
X-Google-Smtp-Source: AK7set9qmdjM6JLXUsmVRUYr4chTrnyzUEowNxp6Tf8dv829z/ENOfvRbqn26nHGslbpU+eDnL2l9Q==
X-Received: by 2002:a05:6a20:734c:b0:bf:40b:2db with SMTP id v12-20020a056a20734c00b000bf040b02dbmr43679619pzc.22.1678736327521;
        Mon, 13 Mar 2023 12:38:47 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:2c47:cef8:f9d7:c7e1])
        by smtp.gmail.com with ESMTPSA id i11-20020aa78d8b000000b005ded4825201sm100214pfr.112.2023.03.13.12.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 12:38:47 -0700 (PDT)
Date:   Mon, 13 Mar 2023 13:38:44 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Tanmay Shah <tanmay.shah@amd.com>
Cc:     michal.simek@amd.com, andersson@kernel.org,
        jaswinder.singh@linaro.org, ben.levinsky@amd.com,
        shubhrajyoti.datta@amd.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH v5 1/5] mailbox: zynqmp: fix counts of child nodes
Message-ID: <20230313193844.GA2071975@p14s>
References: <20230311012407.1292118-1-tanmay.shah@amd.com>
 <20230311012407.1292118-2-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230311012407.1292118-2-tanmay.shah@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 05:24:04PM -0800, Tanmay Shah wrote:
> If child mailbox node status is disabled it causes
> crash in interrupt handler. Fix this by assigning
> only available child node during driver probe.
> 
> Fixes: 4981b82ba2ff ("mailbox: ZynqMP IPI mailbox controller")
> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> ---
> 
> Changes in v5:
>   - mailbox node count should not be 0 for driver to probe
> 
>  drivers/mailbox/zynqmp-ipi-mailbox.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
> index a4c8d23c76e2..ae47fbac38d2 100644
> --- a/drivers/mailbox/zynqmp-ipi-mailbox.c
> +++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
> @@ -634,7 +634,12 @@ static int zynqmp_ipi_probe(struct platform_device *pdev)
>  	struct zynqmp_ipi_mbox *mbox;
>  	int num_mboxes, ret = -EINVAL;
>  
> -	num_mboxes = of_get_child_count(np);
> +	num_mboxes = of_get_available_child_count(np);
> +	if (num_mboxes == 0) {
> +		dev_err(dev, "mailbox nodes not available\n");
> +		return -EINVAL;
> +	}
> +

This patchset looks good now.  I'll queue it once I get an ack from Michal.

Thanks,
Mathieu

>  	pdata = devm_kzalloc(dev, struct_size(pdata, ipi_mboxes, num_mboxes),
>  			     GFP_KERNEL);
>  	if (!pdata)
> -- 
> 2.25.1
> 
