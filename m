Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7AA46368C6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 19:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236923AbiKWS3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 13:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237073AbiKWS2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 13:28:47 -0500
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A50EAE7F;
        Wed, 23 Nov 2022 10:28:23 -0800 (PST)
Received: by mail-qv1-f45.google.com with SMTP id q10so1798252qvt.10;
        Wed, 23 Nov 2022 10:28:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MlAtcGHYSDmdv8L+tYr1Di5ydYageamCywcR0aydFEQ=;
        b=WFii2lIcjgacVRp2AY7USwy9kmkI8Z9vSH6Nblq/l0xc2hlCSO7GmqcCnj0rXd3IfR
         DhUCYUAo2F2j8cmoUQ8EMlM3kaHuD31U0fr1G/TTnBwjjk9MX3O1ML/jiRX2Mf7ABwX9
         novwcRJ17ydqkHu3RPzNFq4jLJTaFhyBUIxEFHc2Gyrm7H+piTmTPSpmTn7Xwb4pSP0i
         YXKWGTFmRb9oriMYVlc3Fqg0fuAbD8wu7F6DEznb3N6XuEQKxgEajeaOnLrw4QTxb0bJ
         v5SN5okGYFU0s0CgC0ZIb6jFJhT+eTuPZ6nJIYjr1FK9Blo05gG58K5PLCyvPXSmOo4s
         9aTQ==
X-Gm-Message-State: ANoB5pkFn6JDwB3/9RwCzkscTgMT+LBlG74rm6Y3r6abDFefGELdjbeH
        916Ok/sMkDG8syrCtq+U9KNRique0aCJbGwZp60=
X-Google-Smtp-Source: AA0mqf7XA44tquEVgp8cYRaZYhoIn4DfQqGm2VGwG6J166bI7A5AMshPv2PYoN/zTfGmQRvV6nUFVB3cUFkzLcv0Lv4=
X-Received: by 2002:ad4:534b:0:b0:4b1:8429:a8a7 with SMTP id
 v11-20020ad4534b000000b004b18429a8a7mr9456555qvs.52.1669228102544; Wed, 23
 Nov 2022 10:28:22 -0800 (PST)
MIME-Version: 1.0
References: <20221110015034.7943-1-lihuisong@huawei.com> <20221112020528.7837-1-lihuisong@huawei.com>
In-Reply-To: <20221112020528.7837-1-lihuisong@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 23 Nov 2022 19:28:11 +0100
Message-ID: <CAJZ5v0h16arZRYRkYr+VQB8OP3F8rVSFyodh-ZnZO1_-2bMOxg@mail.gmail.com>
Subject: Re: [PATCH V3 0/2] Optimize PCC OpRegion code and reset pcc_chan_count
To:     Huisong Li <lihuisong@huawei.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, sudeep.holla@arm.com,
        rafael.j.wysocki@intel.com, wanghuiqiang@huawei.com,
        zhangzekun11@huawei.com, wangxiongfeng2@huawei.com,
        tanxiaofei@huawei.com, guohanjun@huawei.com, xiexiuqi@huawei.com,
        wangkefeng.wang@huawei.com, huangdaode@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2022 at 3:07 AM Huisong Li <lihuisong@huawei.com> wrote:
>
> This series clarifies the dependency of PCC OpRegion on interrupt and reset
> pcc_chan_count to zero in case of PCC probe failure.
>
>
> ---
>  - v3: fix commit log and goto tags.
>  - v2: drop the patch that rename platform interrupt bit macro
> ---
>
> Huisong Li (2):
>   ACPI: PCC: Setup PCC Opregion handler only if platform interrupt is
>     available
>   mailbox: pcc: Reset pcc_chan_count to zero in case of PCC probe
>     failure
>
>  drivers/acpi/acpi_pcc.c | 47 +++++++++++++++++++++++++----------------
>  drivers/mailbox/pcc.c   |  1 +
>  2 files changed, 30 insertions(+), 18 deletions(-)
>
> --

Both applied as 6.2 material, thanks!
