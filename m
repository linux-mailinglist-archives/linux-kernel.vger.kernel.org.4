Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E0D6C27EF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 03:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjCUCRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 22:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjCUCRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 22:17:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EE937577;
        Mon, 20 Mar 2023 19:17:12 -0700 (PDT)
Received: from [192.168.2.81] (109-252-120-116.nat.spd-mgts.ru [109.252.120.116])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 70CA46602179;
        Tue, 21 Mar 2023 02:17:10 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679365031;
        bh=zxU40q7aeTrR2WyKsl0SUCgDymJF0R2V65fkpq6Hwg0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hY7OmhIBvf2Q4/f8296j41aH92E/N2qsgcHWBM8gUOsX6krJG9I/n3RxivOmdR0MB
         m5einW4TFdESel0/z33+DsUPDipfVZ4KMVmEE1q9nj+qW3pCuasglaNHbLCSWMdhL2
         o3NoI0jjyx85CxlPbTlgm9q7tK/PZ44nYo3m4lMNTCN+NpAfTEUNgTcxTuEVZE8H9H
         2jIruL/3MFa+rU2f6TqFKr3BT17fHKXrto6KOhPR1mFRmCCqFvChyQ5iANkdZTLC+r
         JkpSXgmy2XERHK2qMJmHjXQEwZAU2iQjOFOWCPSULlSi3RvKuCSSoHHXcRYlco442v
         ttqAvQiV+Z9NA==
Message-ID: <53675327-d708-d441-4cef-d493d0766911@collabora.com>
Date:   Tue, 21 Mar 2023 05:17:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/2] mfd: tps6586x: use devm-based power off handler
Content-Language: en-US
To:     Benjamin Bara <bbara93@gmail.com>, lee@kernel.org
Cc:     jonathanh@nvidia.com, treding@nvidia.com,
        richard.leitner@linux.dev, benjamin.bara@skidata.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230320220345.1463687-1-bbara93@gmail.com>
 <20230320220345.1463687-2-bbara93@gmail.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20230320220345.1463687-2-bbara93@gmail.com>
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
> +static int tps6586x_power_off_handler(struct sys_off_data *data)
>  {
> -	if (tps6586x_clr_bits(tps6586x_dev, TPS6586X_SUPPLYENE, EXITSLREQ_BIT))
> -		return;
> +	int ret;

Nit: "int ret" should be put after "struct tps6586x_dev" to adhere
canonical kernel coding style

> +	struct device *tps6586x_dev = (struct device *)data->cb_data;

No need for casting of the void* type

-- 
Best regards,
Dmitry

