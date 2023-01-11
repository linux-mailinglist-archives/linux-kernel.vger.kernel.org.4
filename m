Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157DB665412
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 06:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjAKF44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 00:56:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbjAKF4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 00:56:44 -0500
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34AC4C22;
        Tue, 10 Jan 2023 21:56:43 -0800 (PST)
Received: by mail-wm1-f43.google.com with SMTP id m26-20020a05600c3b1a00b003d9811fcaafso11788444wms.5;
        Tue, 10 Jan 2023 21:56:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nRJzXWIcLGfsAx1uj7LxnnT+lT00vnfCm0VUVZlOxf4=;
        b=4PGs3vxXv8jmfiTEdT5Jkqt4HXEomIub8UhN2KDW4fc1Dl+iyGTlvvu6T145xaD9LJ
         NTrS3Xxkq3iMgVCiuyrzTjqfbzaPhsejam54sr7f3HW8ESlgELodftT3vUNEjpAP+lZS
         3KrwPmH5/fQgcnm9RgMBxxZHYqy12ygXDTDnQwxAjXIgtn/zNzkMO5mEXlQz7NgAUYvm
         sPA/1G9iApMBT9CzHmj8XZKcwiTfEGoMatfyguUZqTAMBHMGnIAtnQ1eDwBniRraUwwh
         BS387+TzqWPwdQX5GqJf4N7ZJ1VpukD0ZK/hjrvNo8A0V1aRd4itJ+yoc7apxikB44Gl
         hVyw==
X-Gm-Message-State: AFqh2koXKexg7JsroSFfORCG6HViA2e39T7wIYHN7j6ir+/m4amU37Ey
        k4v41cyFLYiv7DpdcM/BITU=
X-Google-Smtp-Source: AMrXdXuGMiv2BcYICZBUe09GCtW4hRfxWXShZC6GeIunbbzMLdfIj5QG6N/iKwiH0FjjphNqa2+B0A==
X-Received: by 2002:a05:600c:22d4:b0:3cf:82b9:2fe6 with SMTP id 20-20020a05600c22d400b003cf82b92fe6mr61119232wmg.8.1673416601718;
        Tue, 10 Jan 2023 21:56:41 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id az28-20020a05600c601c00b003cf57329221sm21419506wmb.14.2023.01.10.21.56.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 21:56:41 -0800 (PST)
Message-ID: <c10bf347-9f53-bcaf-acc2-d3dd6baa0efb@kernel.org>
Date:   Wed, 11 Jan 2023 06:56:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 11/13] tty/serial: Call ->dtr_rts() parameter active
 consistently
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        =?UTF-8?Q?Samuel_Iglesias_Gons=c3=a1lvez?= <siglesias@igalia.com>,
        Rodolfo Giometti <giometti@enneenne.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        David Lin <dtwlin@gmail.com>, Alex Elder <elder@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org
References: <20230110120226.14972-1-ilpo.jarvinen@linux.intel.com>
 <20230110120226.14972-12-ilpo.jarvinen@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230110120226.14972-12-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10. 01. 23, 13:02, Ilpo Järvinen wrote:
> Convert various parameter names for ->dtr_rts() and related functions
> from onoff, on, and raise to active.

Much better.

> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

-- 
js
suse labs

