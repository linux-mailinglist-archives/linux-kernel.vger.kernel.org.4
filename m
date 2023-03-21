Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD416C27D8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 03:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjCUCHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 22:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjCUCHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 22:07:52 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08AF33471;
        Mon, 20 Mar 2023 19:07:49 -0700 (PDT)
Received: from [192.168.2.81] (109-252-120-116.nat.spd-mgts.ru [109.252.120.116])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 22ED46602179;
        Tue, 21 Mar 2023 02:07:47 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679364467;
        bh=ZOJqWsivZeSOUQy/aPgiOfZ9KXY9x67+cSZ+slXM7cA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=M4jWVDbzL3MD/wvZWEEj8yc0jXdg+i0Jp/2DDmwVkrU+gkKHj31FaS3zr+rdacQLu
         3Dfhrdjsv6QHAM1/F3ISn8j1kMgo7rz2cxKeUouQcd7cwuw171CnjDKtXaTsm1MEm2
         tU3Qdrf01bOJS3bf8snEdQLZ5YZFvA0T20XyPACOkGZSF+tIzK+QtPJ3gT3WCEPk7J
         /GLl/giCaqydSZ1dy1V/ZqSe60jr/JQjTdaRprLaj+3hjXBlv70lNOubAz7gmsvEqc
         1CnDuqJCWmLKL1KptWpVVwKTmErsHvB9ssXQA+twEAi8DvMX7/aQgxQHZjcne6l10Q
         tq+6Wv3p7p3jw==
Message-ID: <a9d9ad38-3743-1cff-2b47-75d1ecdc6f81@collabora.com>
Date:   Tue, 21 Mar 2023 05:07:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 2/2] mfd: tps6586x: register restart handler
To:     Benjamin Bara <bbara93@gmail.com>, lee@kernel.org,
        Wolfram Sang <wsa@kernel.org>
Cc:     jonathanh@nvidia.com, treding@nvidia.com,
        richard.leitner@linux.dev, benjamin.bara@skidata.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230320220345.1463687-1-bbara93@gmail.com>
 <20230320220345.1463687-3-bbara93@gmail.com>
Content-Language: en-US
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20230320220345.1463687-3-bbara93@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/21/23 01:03, Benjamin Bara wrote:
> +static int tps6586x_restart_handler(struct sys_off_data *data)
> +{
> +	unsigned long flags;
> +	struct device *tps6586x_dev = (struct device *)data->cb_data;
> +
> +	/* bring pmic into HARD REBOOT state, enforce atomic i2c xfer */
> +	local_irq_save(flags);
> +	tps6586x_set_bits(tps6586x_dev, TPS6586X_SUPPLYENE, SOFT_RST_BIT);
> +	local_irq_restore(flags);

Please change i2c_in_atomic_xfer_mode() to use preemptible() instead of
irqs_disabled() and drop the local_irq_save/restore.

-- 
Best regards,
Dmitry

