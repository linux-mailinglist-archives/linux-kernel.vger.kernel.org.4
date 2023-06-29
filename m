Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CF87422D1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 11:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjF2JAQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 29 Jun 2023 05:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbjF2I76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 04:59:58 -0400
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781AF10D5;
        Thu, 29 Jun 2023 01:59:57 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-98273ae42d0so12691966b.0;
        Thu, 29 Jun 2023 01:59:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688029196; x=1690621196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uYjZj3THgvQsrzXivluwVI0Hwjsw98Y00KuXK0YUsxs=;
        b=R7lDXMsw+8AtYSTwSB6E6hkjPwjhi07Ccsv0tx4ZqdiyEcIBDfUs9cV0e+L9wunbTA
         oGMLDepallygHEW35whQts5S6cno7+3C+tN44T07oL7NPqiDaAPqhQBtuY8TxmbWhqpZ
         8TNYYXxa+R1dHpV4U0XTGXQTBvz62KSl/2k6b6XNhZYAVEim23jhbyGk2HPXyEBxiIh/
         LHzRXhhi25HLyTkF7rVjzAY7u0eCHipQukOBz8nABPt8mZ3NAXTGPDJsV2OJw8vNOekK
         LEhqAgBkV0PRWyNRZLJkWTjmr1SIEpURXTLZ8Rwyhg+OWouKX/j/c6CXXOm2Yn9Aux0K
         osWA==
X-Gm-Message-State: AC+VfDzuSfx+DtiNzX83MhdrUnveYlt1JVH9XlKqlWHodOyaQ1uESfoW
        LgDrD2f8FAQEk1GMXC7jcrOakE2zKRkPvDHEO7keh2WdUHA=
X-Google-Smtp-Source: ACHHUZ53T3Owoz4/GKEcb66vGc1cbO3Z1LBxaDVyBbNWZrtsqPe9x/q7lnnrfTmP090y+kbschlQ39HIYGKafF5+QWo=
X-Received: by 2002:a17:906:7a4f:b0:988:a037:9dad with SMTP id
 i15-20020a1709067a4f00b00988a0379dadmr24735746ejo.4.1688029195747; Thu, 29
 Jun 2023 01:59:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230627071727.16646-1-Chung-kai.Yang@mediatek.com>
In-Reply-To: <20230627071727.16646-1-Chung-kai.Yang@mediatek.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 29 Jun 2023 10:59:44 +0200
Message-ID: <CAJZ5v0gxNOWhC58PHeUhW_tgf6d1fGJVZ1x91zkDdht11yUv-A@mail.gmail.com>
Subject: Re: [PATCH v2] PM: QoS: Restore support for default value on
 frequency QoS
To:     Chungkai Yang <Chung-kai.Yang@mediatek.com>
Cc:     rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ccj.yeh@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 9:18 AM Chungkai Yang
<Chung-kai.Yang@mediatek.com> wrote:
>
> PM_QOS_DEFAULT_VALUE case is not covered.
>
> Commit 8d36694245f2 ("PM: QoS: Add check to make sure CPU freq is
> non-negative") makes sure CPU freq is non-negative to avoid negative
> value converting to unsigned data type. However, when the value is
> PM_QOS_DEFAULT_VALUE, pm_qos_update_target specifically uses
> c->default_value which is set to FREQ_QOS_MIN/MAX_DEFAULT_VALUE when
> cpufreq_policy_alloc is executed, for this case handling.
>
> Adding check for PM_QOS_DEFAULT_VALUE to let default setting work will
> fix this problem.
>
> Signed-off-by: Chungkai Yang <Chung-kai.Yang@mediatek.com>
>
> ---
> V1 -> V2: Check both freq_qos_add/update_request.
>
> Link:
>   https://lore.kernel.org/lkml/20230626035144.19717-1-Chung-kai.Yang@mediatek.com/
> ---
>  kernel/power/qos.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/power/qos.c b/kernel/power/qos.c
> index af51ed6d45ef..260aca45c681 100644
> --- a/kernel/power/qos.c
> +++ b/kernel/power/qos.c
> @@ -531,7 +531,7 @@ int freq_qos_add_request(struct freq_constraints *qos,
>  {
>         int ret;
>
> -       if (IS_ERR_OR_NULL(qos) || !req || value < 0)
> +       if (IS_ERR_OR_NULL(qos) || !req || (value < 0 && value != PM_QOS_DEFAULT_VALUE))
>                 return -EINVAL;
>
>         if (WARN(freq_qos_request_active(req),
> @@ -563,7 +563,7 @@ EXPORT_SYMBOL_GPL(freq_qos_add_request);
>   */
>  int freq_qos_update_request(struct freq_qos_request *req, s32 new_value)
>  {
> -       if (!req || new_value < 0)
> +       if (!req || (new_value < 0 && new_value != PM_QOS_DEFAULT_VALUE))

This is functionally correct, but it's better to avoid duplicating the
value check, so please add a helper for it, for example:

static bool freq_qos_value_invalid(s32 value)
{
        return value < 0 && value != PM_QOS_DEFAULT_VALUE;
}

and call it in both places.

>                 return -EINVAL;
>
>         if (WARN(!freq_qos_request_active(req),
> --
