Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF4B6B9FC5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 20:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjCNT35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 15:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbjCNT3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 15:29:38 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C39E048
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 12:29:37 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id qa18-20020a17090b4fd200b0023750b675f5so21420756pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 12:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678822177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CK2IjTOa6kx+2O+0qvyuETJVX+4bsfxYY0mt9ZuOep0=;
        b=dBP4RZImEELetPN5c5k+zQ7icfRKOmspW/8AMl/hUIayMAeJQRaezhgkj2BgANvDjO
         LzcIvQkg1v3BxobFxUbT+/BQdGP6T6gQxSLHqAFcr09VyHEjk5jm9fFV14CnPne8yttd
         mv7L4DwN8jwrrPhQ4H/wxnnUGYz+XXfGvxFFlDKkC2ZxWyU88c2NejGoWRwGIb2fj8AE
         vXC0ZH4Vg+0etQG6mqNKjD9YjwBx3JcH/jaBTuJZHvx1TAvd02ZRvdqY2GzQzr0ZqAYE
         Ji8m3k9iP/spW0n+lkE1Yx0EVxjcTjTiGRFGpz8EBNv48MjI5/ZcgozB30JR/OGLwkWp
         lJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678822177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CK2IjTOa6kx+2O+0qvyuETJVX+4bsfxYY0mt9ZuOep0=;
        b=cIV0uaf/br97Jd023iLxJLCOmcZClv2jGTRxbRECp4+lpjfmDLACGpR18K/Ne3z1kh
         y08ew9C9cvMn7sRtD5gm3UDlRO0F5OEzC4nbQ2TJLS1y08j1pDpt1TKaHfbPc8m/xVwJ
         Y0a6RebJKgvIhGepveUiCD0Yw9hjm/kcsappyfAsYkFDF52SWx6piKPZzboGjEhUJuJy
         v0mz3Y05NJsWbokeBFTopQzCaTeymCpwk7kshkGnr41tc39+WOriTY0cuHSWxrufACqF
         HAiVod7p3BdaZCeE281eLjz5lgdsp0kvMkztyu1U8KLpCu3Pa5q++VV6rlucKT9MHzM2
         CJ7Q==
X-Gm-Message-State: AO0yUKV7vmR0Z4G53F7xSxqqMHAxIilgJIgNEQuAmw7dFAYLwMExh7oZ
        EpGIaXNn49ljYLFd2im6bSbEJg==
X-Google-Smtp-Source: AK7set/4Bn4GEOpvubE4b0UX68bVJOHmI59ol43NY+q+FykSxOopzcCjZK0rwWst/b+iVpyETbQJLQ==
X-Received: by 2002:a17:90b:1802:b0:237:c52f:a54d with SMTP id lw2-20020a17090b180200b00237c52fa54dmr14940407pjb.21.1678822176865;
        Tue, 14 Mar 2023 12:29:36 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:f0b5:e541:9fc5:d395])
        by smtp.gmail.com with ESMTPSA id t9-20020a17090ad50900b002311c4596f6sm2018603pju.54.2023.03.14.12.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 12:29:36 -0700 (PDT)
Date:   Tue, 14 Mar 2023 13:29:34 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Tanmay Shah <tanmay.shah@amd.com>
Cc:     michal.simek@amd.com, andersson@kernel.org,
        jaswinder.singh@linaro.org, ben.levinsky@amd.com,
        shubhrajyoti.datta@amd.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH v5 0/5] drivers: remoteproc: xilinx: add mailbox support
Message-ID: <20230314192934.GA2221478@p14s>
References: <20230311012407.1292118-1-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230311012407.1292118-1-tanmay.shah@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 05:24:03PM -0800, Tanmay Shah wrote:
> This series adds mailbox support required for rpmsg communication
> in Xilinx remoteproc driver. It also fixes few bugs in Xilinx
> zynqmp-ipi driver that handles corner cases.
> 
> ---
> 
> Changes in v5:
>   - mailbox node count should not be 0 for driver to probe
>   - Remove spurious change
>   - Include kick op regardless status of mailbox nodes in dts
> 
> Changes in v4:
>   - split mailbox driver patch into 3 different patches
>   - use of_phandle_iterator_next to get memory-region nodes
>   - move zynqmp_r5_setup_mbox from zynqmp_r5_add_rproc_core to
>     zynqmp_r5_cluster_init
> 
> Changes in v3:
>   - split single patch into multiple patches
>   - add appropriate fixes tag for patches fixing previous bug in the driver
>   - make enhancements in zynqmp-ipi driver that handles corener cases
>   - fix memory-region carveout names
>   - fix multi-line comment format
>   - do not mixup mailbox information with memory-regions
>   - fix redundant dev_warn for split mode
>   - Setting up mailboxes should return an error code
>   - Move mailbox setup during driver probe
>   - Add .kick function only if mailbox setup is success
> 
> v2: https://lore.kernel.org/all/20230126213154.1707300-1-tanmay.shah@amd.com/
> 
> 
> Tanmay Shah (5):
>   mailbox: zynqmp: fix counts of child nodes
>   mailbox: zynqmp: fix IPI isr handling
>   mailbox: zynqmp: fix typo in IPI documentation
>   drivers: remoteproc: xilinx: fix carveout names
>   remoteproc: xilinx: add mailbox channels for rpmsg
> 
>  drivers/mailbox/zynqmp-ipi-mailbox.c       |  13 +-
>  drivers/remoteproc/xlnx_r5_remoteproc.c    | 308 ++++++++++++++++-----
>  include/linux/mailbox/zynqmp-ipi-message.h |   2 +-
>  3 files changed, 247 insertions(+), 76 deletions(-)
>

I have applied this set.

Thanks,
Mathieu

> 
> base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
> -- 
> 2.25.1
> 
