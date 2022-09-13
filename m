Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF945B76F7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 18:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbiIMQ5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 12:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbiIMQ5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 12:57:25 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C51C13F8E;
        Tue, 13 Sep 2022 08:49:39 -0700 (PDT)
Received: from [192.168.2.145] (109-252-122-187.nat.spd-mgts.ru [109.252.122.187])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8A16B6601F9C;
        Tue, 13 Sep 2022 16:17:18 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663082239;
        bh=XkZJpiv5PF0uDye6OFManEG8kZH5pOgK7EHrRYw8g3w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KEKfydIL3dWx62K5QaMFEu8a8m88Q5fbP6ncw+3u4dBvpS7CIwhzG6hLPzyIXXzuy
         UtyepaA6pRJKKFiJnt5mvNMAFpZTpZhMukim8zelsdW+EEXluCZSf2e4Xp95YD/EEY
         KepVNnRonAwvEUmqfYE5LcFxbcsNFRyjnRiTQ6s/O9gfyf8ck7fW9B15HqzfihOlTk
         E5WdJom+DJ9jU4JuTzuU4zsF91b4AyRugWmAoB9wnKiGQjN6H0+eRK+rmc0a1Nl6N9
         mo4j9JY/i7k8Mu30RzLXa4CQjTUnX4b8yOV8F+oGSazSmtzSH60edgfVSIboGpdZdZ
         OyDKHPCy1Q1tQ==
Message-ID: <44e3e1be-363b-f19b-4907-6990d2f5b24c@collabora.com>
Date:   Tue, 13 Sep 2022 18:17:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v3 2/2] PM: ACPI: reboot: Reinstate S5 for reboot
Content-Language: en-US
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        rafael.j.wysocki@intel.com, lenb@kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220913062042.1977790-1-kai.heng.feng@canonical.com>
 <20220913062042.1977790-2-kai.heng.feng@canonical.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20220913062042.1977790-2-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/22 09:20, Kai-Heng Feng wrote:
> Commit d60cd06331a3 ("PM: ACPI: reboot: Use S5 for reboot") caused Dell
> PowerEdge r440 hangs at reboot.
> 
> The issue is fixed by commit 2ca1c94ce0b6 ("tg3: Disable tg3 device on
> system reboot to avoid triggering AER"), so use the new sysoff API to
> reinstate S5 for reboot on ACPI-based systems.
> 
> Cc: Josef Bacik <josef@toxicpanda.com>
> Suggested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v3:
>  - Use new API to invoke ACPI S5.
> 
> v2:
>  - Use do_kernel_power_off_prepare() instead.
> 
>  drivers/acpi/sleep.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index ad4b2987b3d6e..dce5460902eed 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -1088,6 +1088,10 @@ int __init acpi_sleep_init(void)
>  		register_sys_off_handler(SYS_OFF_MODE_POWER_OFF,
>  					 SYS_OFF_PRIO_FIRMWARE,
>  					 acpi_power_off, NULL);
> +
> +		register_sys_off_handler(SYS_OFF_MODE_RESTART_PREPARE,
> +					 SYS_OFF_PRIO_FIRMWARE,
> +					 acpi_power_off_prepare, NULL);

Maybe you could add a small comment to the code explaining why
acpi_power_off_prepare is used for restarting?

Is it safe to use S5 on restart for all devices in general?

-- 
Best regards,
Dmitry

