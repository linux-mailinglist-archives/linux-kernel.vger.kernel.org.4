Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421AA74F7D3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 20:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbjGKSLb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 11 Jul 2023 14:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjGKSL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 14:11:27 -0400
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C59510C4;
        Tue, 11 Jul 2023 11:11:26 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-315abbd2e64so36844f8f.1;
        Tue, 11 Jul 2023 11:11:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689099084; x=1691691084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f4pTgOl4kr3INqK7GWkbIOwJ2OoYx4wbuRsCFl9wKjs=;
        b=htTbK3XefIdus0P7WtgHWhPEJIfUbRpTe0/SyQmIBj605sjxi1EzR8mN/xWHxy5rfR
         vaFSgr6bBlw8tpNEFXfzvqmdvMYWykDcgAR9Xnw2xTu5YrXmdxiqdTHto4joI1UmOmmi
         q/mRbiuMhyGdnB982ANvt4cE6+jHuGm2JUbaDgaP+8hhsgg5dO4LPnbRmP7MaL50llR0
         pzZQD2k+as+XklGqGaXb5Rs5J2aFaru6JSRJd8jTsBqFVUG4KyK8Z9vw45rXo1PMbea4
         cIAh4sTntCoeMoH1AYj38UjU/Du7sA0iygbQew8CqWMcw4pcWWb1K7JHP2n/8zdpAZsr
         qvPw==
X-Gm-Message-State: ABy/qLZT2a7Tk9jJ0YrUlEQeOcNArym65PUfOLezt5VoKD+lYaOw9042
        P4A3WbwTkwt0f7c5USX/cyZhwKn0A5+5HuFPbxycXs/u
X-Google-Smtp-Source: APBJJlEpIbhOmBRe04QMC23MNIw+WBjJ+zUQzleUvz2/emIfuqZAIyavt4IFyil/DoaEJVlJ5GR56IAvM/jAmmYh2Vs=
X-Received: by 2002:a5d:4c85:0:b0:314:1d7f:9e9 with SMTP id
 z5-20020a5d4c85000000b003141d7f09e9mr16305627wrs.0.1689099084284; Tue, 11 Jul
 2023 11:11:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230705085907.30880-1-Chung-kai.Yang@mediatek.com>
In-Reply-To: <20230705085907.30880-1-Chung-kai.Yang@mediatek.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 11 Jul 2023 20:11:13 +0200
Message-ID: <CAJZ5v0gw3PALtEQLc1W6ZFO6j19SCjVhjsNV6R4knbn83s+-5g@mail.gmail.com>
Subject: Re: [PATCH v3] PM: QoS: Restore support for default value on
 frequency QoS
To:     Chungkai Yang <Chung-kai.Yang@mediatek.com>
Cc:     rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ccj.yeh@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 5, 2023 at 10:59 AM Chungkai Yang
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
> V2 -> V3: Added helper function to avoid duplicating the value check.
> V1 -> V2: Checked both freq_qos_add/update_request.
>
> Link: https://lore.kernel.org/lkml/20230626035144.19717-1-Chung-kai.Yang@mediatek.com/
> Link: https://lore.kernel.org/lkml/20230627071727.16646-1-Chung-kai.Yang@mediatek.com/
> Link: https://lore.kernel.org/lkml/CAJZ5v0gxNOWhC58PHeUhW_tgf6d1fGJVZ1x91zkDdht11yUv-A@mail.gmail.com/
> ---
>  kernel/power/qos.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/power/qos.c b/kernel/power/qos.c
> index af51ed6d45ef..782d3b41c1f3 100644
> --- a/kernel/power/qos.c
> +++ b/kernel/power/qos.c
> @@ -426,6 +426,11 @@ late_initcall(cpu_latency_qos_init);
>
>  /* Definitions related to the frequency QoS below. */
>
> +static inline bool freq_qos_value_invalid(s32 value)
> +{
> +       return value < 0 && value != PM_QOS_DEFAULT_VALUE;
> +}
> +
>  /**
>   * freq_constraints_init - Initialize frequency QoS constraints.
>   * @qos: Frequency QoS constraints to initialize.
> @@ -531,7 +536,7 @@ int freq_qos_add_request(struct freq_constraints *qos,
>  {
>         int ret;
>
> -       if (IS_ERR_OR_NULL(qos) || !req || value < 0)
> +       if (IS_ERR_OR_NULL(qos) || !req || freq_qos_value_invalid(value))
>                 return -EINVAL;
>
>         if (WARN(freq_qos_request_active(req),
> @@ -563,7 +568,7 @@ EXPORT_SYMBOL_GPL(freq_qos_add_request);
>   */
>  int freq_qos_update_request(struct freq_qos_request *req, s32 new_value)
>  {
> -       if (!req || new_value < 0)
> +       if (!req || freq_qos_value_invalid(new_value))
>                 return -EINVAL;
>
>         if (WARN(!freq_qos_request_active(req),
> --

Applied as 6.5-rc material, thanks!
