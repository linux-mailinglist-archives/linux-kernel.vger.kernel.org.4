Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8028743A89
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 13:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbjF3LMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 07:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232848AbjF3LL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 07:11:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF4735B6;
        Fri, 30 Jun 2023 04:11:48 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1688123506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LBi2xn+NWrUQzLbxhPhUtfNKTaMAus8XdZkjy6jHSNM=;
        b=418LKbfzErO8aWbRiCy6RicHEfWmrfLoIcdhuAdqKEQ/ZbLyV5fOr9TL2jgmxbiB1UJ3bl
        L7RSNcul7PGGKtMoVG58xOTYMswwl0fvl2x6Gy3oeK78nmBEYbydnR6FVElSSy3QDkkQS4
        aNdClghzIVSlb1kIYZa+lxNsG6dKqXTENfkuKKK8H3fwdANqYJnMII3qHGkdR7RslbGNzH
        rMZSPPYA/DaN+m+jbNSRocp1b1dwjRh2NBrN92RDYtVGXNSXIAHcc+RtRHjhZQcR/LI027
        /C9gb1mFySWZHISgYn13LNhN7Izd0dCqTTysj0/z5qIQHqLoTPKk/6VDB9l9vg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1688123506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LBi2xn+NWrUQzLbxhPhUtfNKTaMAus8XdZkjy6jHSNM=;
        b=jVPJlwFMcCzb0wYuBYE9xW6cZEwUMtJR24us2ZwmMLiYkh/Ya8FPIpIwdTH1G8h/qMJoP9
        yy6W7RPJnQ28ZkBA==
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Yangtao Li <frank.li@vivo.com>
Cc:     miquel.raynal@bootlin.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        mmayer@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        florian.fainelli@broadcom.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, thara.gopinath@gmail.com,
        heiko@sntech.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        srinivas.pandruvada@linux.intel.com,
        DLG-Adam.Ward.opensource@dm.renesas.com, shangxiaojing@huawei.com,
        bchihi@baylibre.com, wenst@chromium.org,
        hayashi.kunihiko@socionext.com,
        niklas.soderlund+renesas@ragnatech.se, chi.minghao@zte.com.cn,
        johan+linaro@kernel.org, jernej.skrabec@gmail.com,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 01/15] genirq/devres: Add error information printing
 for devm_request_threaded_irq()
In-Reply-To: <20230627110025.vgtplc6nluiiuvoh@pengutronix.de>
References: <20230627101215.58798-1-frank.li@vivo.com>
 <20230627110025.vgtplc6nluiiuvoh@pengutronix.de>
Date:   Fri, 30 Jun 2023 13:11:46 +0200
Message-ID: <87h6qpyzkd.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27 2023 at 13:00, Uwe Kleine-K=C3=B6nig wrote:
> On Tue, Jun 27, 2023 at 06:12:01PM +0800, Yangtao Li wrote:
>
> While I assume changing to dev_err_probe is a result of my concern that
> no error should be printed when rc=3D-EPROBEDEFER, my other concern that
> adding an error message to a generic allocation function is a bad idea
> still stands.

I agree in general, but if you actually look at the call sites of
devm_request_threaded_irq() then the vast majority of them print more or
less lousy error messages. A quick grep/sed/awk/sort/uniq revealed

     519 messages total (there are probably more)

     352 unique messages

     323 unique messages after lower casing

         Those 323 are mostly just variants of the same patterns with slight
         modifications in formatting and information provided.

     186 of these messages do not deliver any useful information,
         e.g. "no irq", "

     The most useful one of all is: "could request wakeup irq: %d"

So there is certainly an argument to be made that this particular
function should print a well formatted and informative error message.

It's not a general allocator like kmalloc(). It's specialized and in the
vast majority of cases failing to request the interrupt causes the
device probe to fail. So having proper and consistent information why
the device cannot be used _is_ useful.

Yangtao: The way how this is attempted is not useful at all.

    1) The changelog is word salad and provides 0 rationale

       Also such series require a cover letter...

    2) The dev_err() which is added is not informative at all and cannot
       replace actually useful error messages. It's not that hard to
       make it useful.

    2) Adding the printks unconditionally first will emit two messages
       with different content.

       This is not how such changes are done.

       The proper approach is to create a wrapper function which emits
       the error message:

       wrapper(....., const char *info)
       {
            ret =3D devm_request_threaded_irq(....);
            if (ret < 0) {
               dev_err(dev, "Failed to request %sinterrupt %u %s %s: %d\n,
                       thread_fn ? "threaded " : "",
                       irq, devname, info ? : "", ret);
            }
            return ret;
       }

       Then convert the callsites over one by one with proper
       changelogs and justification.

       See?

Thanks,

        tglx
