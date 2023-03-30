Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D4E6CF9C2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 05:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjC3Dyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 23:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjC3Dyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 23:54:36 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E9E4C28
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 20:54:33 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id gp15-20020a17090adf0f00b0023d1bbd9f9eso20755191pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 20:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680148473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rif9SVht3Xq5rHKwiENZowsz+awWs141IU0VAwjN1vg=;
        b=fV9FgxnApIXbe1N5pM4jjR9lUZGUI9IHgwkMnRZ43spPTOEuCOBgE6jom5YYd5NaSw
         hO3BaFodAmNdmeJnu/2X1bnm5xCDXutVF46Q4qkwiWvp0QD7VT2G+FS8VK6si5hM24E1
         cmhd1+iI264Fr/t7n/mmHq+QUCu9AJBXrHRE5NMw2hhSYMEgz0n/xxhnwIpLUx49DXMe
         3cXje5lTdqWVmeRk8+mxVWjAALckaFIQEvLAfdbfPdG7pkmLiTnNEoZXurcL3Sjcbenu
         TxKvKkOO0B7xmXzmAWEmob+khrROpJZhtq4GhLIFBe54WEv6nH0q1+rtBdjUdUgdh/Qs
         KpwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680148473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rif9SVht3Xq5rHKwiENZowsz+awWs141IU0VAwjN1vg=;
        b=MMTpYXuK1kf1LIhVSuChYJiq1ddT9AIBGV6mk1r+Zzk2ezTRR6HI+24nJWtfiKTjyp
         Zei0apjd8Wida+gf03JMDcTgFrxsx99khzEqrvVV0zHArjlOzwkmYt0IR7SOf4fNT5xx
         xJEGc3XEFIQtB4itZGEai+QdcjbB8jccpI7HGmC/mn2A0rgQHGj3W9oOhY6Y+TnM5UXi
         1NNeB74d28lCFr/Jaoa/1y/6nsNazxgNhZZbxSPDYZop/OGst55o1IxmF9OEuAHwarIE
         134IxkBPWuHGwwwTMFPhcf4DMzcf8lKbaxC4yIkLa7KS5qRcPNYi967B4ec543qjex4t
         dEBQ==
X-Gm-Message-State: AO0yUKVn1lyWMrK8xJr1cTUtdy72S2NlI7sNX+DN6xZyLuS/+vtLml+C
        0XV/MHVO9V9bwOrP/Tzb5jI89A==
X-Google-Smtp-Source: AK7set+6CKB9aX3Y+69CYgYb8mvQ9d90t+LT0/3dtpbyQgu7Ff5u0kg7CAes3wOVIzKhF5KBg4AuvA==
X-Received: by 2002:a05:6a20:c119:b0:d4:77a6:156f with SMTP id bh25-20020a056a20c11900b000d477a6156fmr18152236pzb.53.1680148472791;
        Wed, 29 Mar 2023 20:54:32 -0700 (PDT)
Received: from localhost ([122.172.85.168])
        by smtp.gmail.com with ESMTPSA id a24-20020a62e218000000b00627f2f23624sm20068315pfi.159.2023.03.29.20.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 20:54:32 -0700 (PDT)
Date:   Thu, 30 Mar 2023 09:24:30 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Anup Patel <anup@brainfault.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Marc Zyngier <maz@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-tegra@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH 14/19] cpufreq: Adjust includes to remove of_device.h
Message-ID: <20230330035430.z6x3escbvr7nlya5@vireshk-i7>
References: <20230329-dt-cpu-header-cleanups-v1-0-581e2605fe47@kernel.org>
 <20230329-dt-cpu-header-cleanups-v1-14-581e2605fe47@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329-dt-cpu-header-cleanups-v1-14-581e2605fe47@kernel.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-03-23, 10:52, Rob Herring wrote:
> Now that of_cpu_device_node_get() is defined in of.h, of_device.h is just
> implicitly including other includes, and is no longer needed. Adjust the
> include files with what was implicitly included by of_device.h (cpu.h and
> of.h) and drop including of_device.h.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Please ack and I will take the series via the DT tree.
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 -
>  drivers/cpufreq/kirkwood-cpufreq.c   | 2 +-
>  drivers/cpufreq/maple-cpufreq.c      | 2 +-
>  drivers/cpufreq/pmac32-cpufreq.c     | 2 +-
>  drivers/cpufreq/pmac64-cpufreq.c     | 2 +-
>  drivers/cpufreq/qcom-cpufreq-hw.c    | 4 ++--
>  drivers/cpufreq/spear-cpufreq.c      | 2 +-
>  drivers/cpufreq/tegra124-cpufreq.c   | 1 -
>  drivers/cpufreq/tegra20-cpufreq.c    | 2 +-
>  include/linux/cpufreq.h              | 1 -
>  10 files changed, 8 insertions(+), 11 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
