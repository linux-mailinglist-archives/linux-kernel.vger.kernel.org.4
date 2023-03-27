Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457AA6CAB85
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 19:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbjC0RIx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 27 Mar 2023 13:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbjC0RIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 13:08:30 -0400
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D0D3AA2;
        Mon, 27 Mar 2023 10:07:27 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id cn12so39095941edb.4;
        Mon, 27 Mar 2023 10:07:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679936807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rYJe8F65O4jssLoudktBYu87ax2vScUAeJoZjXvj+pA=;
        b=ax4PQdLGfH2tlyGScgcrnGJt2YhZMdTh/0ASNfM6Mp4xeEZJv5ZJiE09JCkQV0rhF+
         5vHTC9DaFXhsZprrQxeIU7k3BK7/ISjUb0oA73NOr3Bx9wc6LilVnmSdZZ3KCXyIcja2
         6m/3Ul/fgtADHuqYhNUPuvr7QCqGAmNb/wrSaN1L3UwSRha2Pl4HmUErOWR05mQHHoIU
         X5RB2/veKVPEINGthCz08GPk0jEhrflyHS0rce1ovpU8Ux/gNE+qHG60LAdW1k3/1sWw
         JhgQC8ZFJesZ6kNC9VhJ/wFOKIw5VbqnHnz6h4/aFNARerPFDKuodt2TxCkvTYAAd1bS
         Q0QQ==
X-Gm-Message-State: AAQBX9c14DmbYDTS+jfAm0cjTgpR4h1fdWeLe1Yndrb/liNRduN2LRHB
        8qKh6ITt0D/DJqfAWJCzZLLFX55HMpkADjVQq7EPc0oW
X-Google-Smtp-Source: AKy350ZN8Lzz2e4S3Dkb20kL7Entt9Xr2yf9sdds1wXkXk8KUQ74xH5Ju7fHSwL2bMuBW6GWZlh0B0FEo/U6K7eyeAs=
X-Received: by 2002:a50:9f82:0:b0:4fa:3c0b:74b with SMTP id
 c2-20020a509f82000000b004fa3c0b074bmr6398781edf.3.1679936807303; Mon, 27 Mar
 2023 10:06:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230309140724.2152712-1-cristian.marussi@arm.com> <20230309140724.2152712-2-cristian.marussi@arm.com>
In-Reply-To: <20230309140724.2152712-2-cristian.marussi@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Mar 2023 19:06:36 +0200
Message-ID: <CAJZ5v0ixFvJ6akSMZmcUsg1n_kufq_WonWhS+ef=ps1FXKqUGQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] firmware: arm_scmi: Refactor powercap get/set helpers
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, sudeep.holla@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@huawei.com,
        f.fainelli@gmail.com, vincent.guittot@linaro.org,
        tarek.el-sherbiny@arm.com, nicola.mazzucato@arm.com,
        souvik.chakravarty@arm.com, wleavitt@marvell.com,
        wbartczak@marvell.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 9, 2023 at 3:09 PM Cristian Marussi
<cristian.marussi@arm.com> wrote:
>
> Refactor SCMI powercap internal get/set helpers.
>
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>

I can apply this series if I get an ACK or preferably Reviewed-by:
from an SCMI person.

However, I think that it would be more appropriate to route it through
ARM/ARM64 anyway.

> ---
>  drivers/firmware/arm_scmi/powercap.c | 65 +++++++++++++++++++---------
>  1 file changed, 45 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/firmware/arm_scmi/powercap.c b/drivers/firmware/arm_scmi/powercap.c
> index 83b90bde755c..2e490492f187 100644
> --- a/drivers/firmware/arm_scmi/powercap.c
> +++ b/drivers/firmware/arm_scmi/powercap.c
> @@ -313,24 +313,33 @@ static int scmi_powercap_xfer_cap_get(const struct scmi_protocol_handle *ph,
>         return ret;
>  }
>
> -static int scmi_powercap_cap_get(const struct scmi_protocol_handle *ph,
> -                                u32 domain_id, u32 *power_cap)
> +static int __scmi_powercap_cap_get(const struct scmi_protocol_handle *ph,
> +                                  const struct scmi_powercap_info *dom,
> +                                  u32 *power_cap)
>  {
> -       struct scmi_powercap_info *dom;
> -       struct powercap_info *pi = ph->get_priv(ph);
> -
> -       if (!power_cap || domain_id >= pi->num_domains)
> -               return -EINVAL;
> -
> -       dom = pi->powercaps + domain_id;
>         if (dom->fc_info && dom->fc_info[POWERCAP_FC_CAP].get_addr) {
>                 *power_cap = ioread32(dom->fc_info[POWERCAP_FC_CAP].get_addr);
>                 trace_scmi_fc_call(SCMI_PROTOCOL_POWERCAP, POWERCAP_CAP_GET,
> -                                  domain_id, *power_cap, 0);
> +                                  dom->id, *power_cap, 0);
>                 return 0;
>         }
>
> -       return scmi_powercap_xfer_cap_get(ph, domain_id, power_cap);
> +       return scmi_powercap_xfer_cap_get(ph, dom->id, power_cap);
> +}
> +
> +static int scmi_powercap_cap_get(const struct scmi_protocol_handle *ph,
> +                                u32 domain_id, u32 *power_cap)
> +{
> +       const struct scmi_powercap_info *dom;
> +
> +       if (!power_cap)
> +               return -EINVAL;
> +
> +       dom = scmi_powercap_dom_info_get(ph, domain_id);
> +       if (!dom)
> +               return -EINVAL;
> +
> +       return __scmi_powercap_cap_get(ph, dom, power_cap);
>  }
>
>  static int scmi_powercap_xfer_cap_set(const struct scmi_protocol_handle *ph,
> @@ -375,17 +384,20 @@ static int scmi_powercap_xfer_cap_set(const struct scmi_protocol_handle *ph,
>         return ret;
>  }
>
> -static int scmi_powercap_cap_set(const struct scmi_protocol_handle *ph,
> -                                u32 domain_id, u32 power_cap,
> -                                bool ignore_dresp)
> +static int __scmi_powercap_cap_set(const struct scmi_protocol_handle *ph,
> +                                  struct powercap_info *pi, u32 domain_id,
> +                                  u32 power_cap, bool ignore_dresp)
>  {
> +       int ret = -EINVAL;
>         const struct scmi_powercap_info *pc;
>
>         pc = scmi_powercap_dom_info_get(ph, domain_id);
> -       if (!pc || !pc->powercap_cap_config || !power_cap ||
> -           power_cap < pc->min_power_cap ||
> -           power_cap > pc->max_power_cap)
> -               return -EINVAL;
> +       if (!pc || !pc->powercap_cap_config)
> +               return ret;
> +
> +       if (power_cap &&
> +           (power_cap < pc->min_power_cap || power_cap > pc->max_power_cap))
> +               return ret;
>
>         if (pc->fc_info && pc->fc_info[POWERCAP_FC_CAP].set_addr) {
>                 struct scmi_fc_info *fci = &pc->fc_info[POWERCAP_FC_CAP];
> @@ -394,10 +406,23 @@ static int scmi_powercap_cap_set(const struct scmi_protocol_handle *ph,
>                 ph->hops->fastchannel_db_ring(fci->set_db);
>                 trace_scmi_fc_call(SCMI_PROTOCOL_POWERCAP, POWERCAP_CAP_SET,
>                                    domain_id, power_cap, 0);
> -               return 0;
> +               ret = 0;
> +       } else {
> +               ret = scmi_powercap_xfer_cap_set(ph, pc, power_cap,
> +                                                ignore_dresp);
>         }
>
> -       return scmi_powercap_xfer_cap_set(ph, pc, power_cap, ignore_dresp);
> +       return ret;
> +}
> +
> +static int scmi_powercap_cap_set(const struct scmi_protocol_handle *ph,
> +                                u32 domain_id, u32 power_cap,
> +                                bool ignore_dresp)
> +{
> +       struct powercap_info *pi = ph->get_priv(ph);
> +
> +       return __scmi_powercap_cap_set(ph, pi, domain_id,
> +                                      power_cap, ignore_dresp);
>  }
>
>  static int scmi_powercap_xfer_pai_get(const struct scmi_protocol_handle *ph,
> --
> 2.34.1
>
