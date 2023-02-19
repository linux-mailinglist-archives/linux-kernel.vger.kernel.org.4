Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A1A69C2C1
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 22:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbjBSViG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 19 Feb 2023 16:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjBSViF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 16:38:05 -0500
Received: from smtprelay06.ispgateway.de (smtprelay06.ispgateway.de [80.67.31.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29654B759;
        Sun, 19 Feb 2023 13:38:04 -0800 (PST)
Received: from [80.82.223.85] (helo=mail.piie.net)
        by smtprelay06.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <peter@piie.net>)
        id 1pTrNi-0005s6-5P; Sun, 19 Feb 2023 22:38:02 +0100
MIME-Version: 1.0
Date:   Sun, 19 Feb 2023 21:38:02 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: RainLoop/1.16.0
From:   "=?utf-8?B?UGV0ZXIgS8Okc3RsZQ==?=" <peter@piie.net>
Message-ID: <4302bb253fb733b675dbf18d1c2bcd15@piie.net>
Subject: Re: [PATCH v1 15/17] thermal/drivers/acerhdf: Make interval
 setting only at module load time
To:     "Daniel Lezcano" <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Hans de Goede" <hdegoede@redhat.com>,
        "Mark Gross" <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org
In-Reply-To: <20230219143657.241542-16-daniel.lezcano@linaro.org>
References: <20230219143657.241542-16-daniel.lezcano@linaro.org>
 <20230219143657.241542-1-daniel.lezcano@linaro.org>
X-Df-Sender: cGV0ZXJAcGlpZS5uZXQ=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

19. Februar 2023 15:38, "Daniel Lezcano" <daniel.lezcano@linaro.org> schrieb:

> The thermal zone device structure is in the process of being private
> to the thermal framework core code. This driver is directly accessing
> and changing the monitoring polling rate.
> 
> After discussing with the maintainers of this driver, having the
> polling interval at module loading time is enough for their purpose.
> 
> Change the code to take into account the interval when the module is
> loaded but restrict the permissions so the value can not be changed
> afterwards.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Acked-by: Peter Kaestle <peter@piie.net>


> ---
> drivers/platform/x86/acerhdf.c | 12 +++---------
> 1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
> index 1956469c3457..61f1c3090867 100644
> --- a/drivers/platform/x86/acerhdf.c
> +++ b/drivers/platform/x86/acerhdf.c
> @@ -79,7 +79,6 @@ static unsigned int list_supported;
> static unsigned int fanstate = ACERHDF_FAN_AUTO;
> static char force_bios[16];
> static char force_product[16];
> -static unsigned int prev_interval;
> static struct thermal_zone_device *thz_dev;
> static struct thermal_cooling_device *cl_dev;
> static struct platform_device *acerhdf_dev;
> @@ -346,20 +345,15 @@ static void acerhdf_check_param(struct thermal_zone_device *thermal)
> trips[0].temperature = fanon;
> trips[0].hysteresis = fanon - fanoff;
> 
> - if (kernelmode && prev_interval != interval) {
> + if (kernelmode) {
> if (interval > ACERHDF_MAX_INTERVAL) {
> pr_err("interval too high, set to %d\n",
> ACERHDF_MAX_INTERVAL);
> interval = ACERHDF_MAX_INTERVAL;
> }
> +
> if (verbose)
> pr_notice("interval changed to: %d\n", interval);
> -
> - if (thermal)
> - thermal->polling_delay_jiffies =
> - round_jiffies(msecs_to_jiffies(interval * 1000));
> -
> - prev_interval = interval;
> }
> }
> 
> @@ -807,5 +801,5 @@ static const struct kernel_param_ops interval_ops = {
> .get = param_get_uint,
> };
> 
> -module_param_cb(interval, &interval_ops, &interval, 0600);
> +module_param_cb(interval, &interval_ops, &interval, 0000);
> MODULE_PARM_DESC(interval, "Polling interval of temperature check");
> -- 
> 2.34.1
