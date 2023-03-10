Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2566B4F62
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 18:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjCJRsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 12:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjCJRsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 12:48:18 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428C611A2F6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 09:47:43 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id x20-20020a17090a8a9400b00233ba727724so8306671pjn.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 09:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678470457;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cxGEPKOwr+tmbFiOp83p4hK/QKt7HqPKsBOKDzMhBlo=;
        b=H8XP1MoNcr9KjteVGhX7zomURyl8s+0CZ8OFezv1JoRblg1566OYEafcR01mg4DhWw
         36uFcnFShxOwidS6iMe0fCiWfQegp8tsjuegktg2Q7jSVKuJmQ6S3PfNecL3zUmaUUaU
         V2bj7a00LdpAgDfhvKB28e4PvPKY28lcG1+bnG4KShTw6fhx9t8dL9DKOLzELjHL/b0u
         bY3MV78r5K5zGnHB7DFYPn5rsmyMz5SdahEiQFPAluhXDrjz+YySUyEmsqckqImvHejX
         0mK20SbzE9qKWWtoUa7cMhFkDmyMvEQyIhrEEUkrnFDeYMK9ILOuPscqxi7lbtyPfUD9
         Q/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678470457;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cxGEPKOwr+tmbFiOp83p4hK/QKt7HqPKsBOKDzMhBlo=;
        b=Q5m6s/rF51/Tc3+X+TbbQV81FbFNzRybBWfqxw0qQOQO5lVW3bauG6vJlhhleJg2tW
         NNl4p2cuODWL2Y4AAiEZ5An7q9Ani/0zP1nJEcUAScd3ulTcSpeaul7ujASlWxXeSAgp
         lv4EQDToRm9NU4QadUvcazLOm/4C42C/lz/az78t66oVLMI3Z3kmbPCS1NhvQYDSklvh
         AmJ4dYEjPzdyhoIc7KM/cXli+oyGd23WGwhwdIZuq+C0aZXJa4Kc0bZYj62VUCNR6RDH
         tSeLc+lkflicqe6BokZOLgQhQlQ33kcw5dyCD+cJQzrsE58HJ+d93DAUEzmAe257kVWc
         kLMg==
X-Gm-Message-State: AO0yUKXwuaw0kxPyK0RuAlZWja2LfVi6quWAHe84VeeVBg7VCaYSkvaF
        G6mHNQ/jr0+u9FRLQkmu+Qly29aJY3fVakFpS0G9lg==
X-Google-Smtp-Source: AK7set9qlzyfJQkPmeS1QvtKn+DzHcVEf//e44mpadhloRlsZ0QlMRrI+kEDfbQXl075/XuicaWTao1yhsQc5P/VAV8=
X-Received: by 2002:a17:902:edc2:b0:19a:9834:bb2c with SMTP id
 q2-20020a170902edc200b0019a9834bb2cmr10491816plk.11.1678470456953; Fri, 10
 Mar 2023 09:47:36 -0800 (PST)
MIME-Version: 1.0
References: <20230310144703.1541888-1-robh@kernel.org>
In-Reply-To: <20230310144703.1541888-1-robh@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 10 Mar 2023 18:46:59 +0100
Message-ID: <CAPDyKFoVUQEmseNT+dZFJDfwh7ijTwUs5_NckpZLhRQ=VuFpFQ@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: Use of_property_present() for testing DT
 property presence
To:     Rob Herring <robh@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Mar 2023 at 15:47, Rob Herring <robh@kernel.org> wrote:
>
> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties. As
> part of this, convert of_get_property/of_find_property calls to the
> recently added of_property_present() helper when we just want to test
> for presence of a property and nothing more.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Rafael, can you please pick this via your tree.

Kind regards
Uffe

> ---
>  drivers/cpuidle/cpuidle-psci-domain.c | 2 +-
>  drivers/cpuidle/cpuidle-riscv-sbi.c   | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
> index 6ad2954948a5..e875ddadc51b 100644
> --- a/drivers/cpuidle/cpuidle-psci-domain.c
> +++ b/drivers/cpuidle/cpuidle-psci-domain.c
> @@ -165,7 +165,7 @@ static int psci_cpuidle_domain_probe(struct platform_device *pdev)
>          * initialize a genpd/genpd-of-provider pair when it's found.
>          */
>         for_each_child_of_node(np, node) {
> -               if (!of_find_property(node, "#power-domain-cells", NULL))
> +               if (!of_property_present(node, "#power-domain-cells"))
>                         continue;
>
>                 ret = psci_pd_init(node, use_osi);
> diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidle-riscv-sbi.c
> index be383f4b6855..1fab1abc6eb6 100644
> --- a/drivers/cpuidle/cpuidle-riscv-sbi.c
> +++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
> @@ -497,7 +497,7 @@ static int sbi_genpd_probe(struct device_node *np)
>          * initialize a genpd/genpd-of-provider pair when it's found.
>          */
>         for_each_child_of_node(np, node) {
> -               if (!of_find_property(node, "#power-domain-cells", NULL))
> +               if (!of_property_present(node, "#power-domain-cells"))
>                         continue;
>
>                 ret = sbi_pd_init(node);
> @@ -548,8 +548,8 @@ static int sbi_cpuidle_probe(struct platform_device *pdev)
>         for_each_possible_cpu(cpu) {
>                 np = of_cpu_device_node_get(cpu);
>                 if (np &&
> -                   of_find_property(np, "power-domains", NULL) &&
> -                   of_find_property(np, "power-domain-names", NULL)) {
> +                   of_property_present(np, "power-domains") &&
> +                   of_property_present(np, "power-domain-names")) {
>                         continue;
>                 } else {
>                         sbi_cpuidle_use_osi = false;
> --
> 2.39.2
>
