Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5746E50BE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 21:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbjDQTVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 15:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjDQTU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 15:20:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948B046A1;
        Mon, 17 Apr 2023 12:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=OCXQAUqZq8AENPbfKo9BLSD0arsRH/iVJodv9zOemb0=; b=Op11VnBitQiV1BtUJzm1VFDJW6
        BGGx6h4ClV44qMdsWj3v9yIy/Z0idVD0zuoZNipfygUawMoqf362gOfZqsBdgesL3sC9fsO7j9DPT
        4rpUUJj/LeXf8amvlSy7XaNKEQ799lSF1Q1Q6nBa7dCnQR49aT2vPxHY31TEYBoHPARJgnGcJ8icf
        htuyGlxIAg3m0r0rByLOdtW8pbm94CkUBANiJb8SBx7VSDL3wv8PSTdVqIgjfquShhL3r5RxtO/gl
        qaMMA1G5dEZWFXqE8T9yRA3d42mZ0JUEsS+mH3cdlGLqWAhCYtwVMXWPs9SxHI+Uv3fD/NPKGaufU
        LF4EfGpQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1poUPG-00HPUr-0s;
        Mon, 17 Apr 2023 19:20:54 +0000
Message-ID: <1a754a3e-2a2b-07d5-c94a-0373a1677e4e@infradead.org>
Date:   Mon, 17 Apr 2023 12:20:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 1/1] HID: shield: Initial driver implementation with
 Thunderstrike support
Content-Language: en-US
To:     Rahul Rameshbabu <rrameshbabu@nvidia.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230417182909.33833-1-rrameshbabu@nvidia.com>
 <20230417182909.33833-2-rrameshbabu@nvidia.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230417182909.33833-2-rrameshbabu@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/17/23 11:29, Rahul Rameshbabu wrote:
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 82f64fb31fda..eb19debaa1f5 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -990,6 +990,24 @@ config HID_SEMITEK
>  	- Woo-dy
>  	- X-Bows Nature/Knight
>  
> +config HID_SHIELD
> +	tristate "SHIELD HID Driver"
> +	depends on USB_HID
> +	depends on BT_HIDP
> +	help
> +	Support for NVIDIA SHIELD accessories.
> +
> +	Supported devices:
> +	- Thunderstrike (NVIDIA SHIELD Controller 2017)
> +
> +config SHIELD_FF
> +	bool "SHIELD force feedback support"
> +	depends on HID_SHIELD
> +	select INPUT_FF_MEMLESS
> +	help
> +	Say Y here if you would like to enable force feedback support for
> +	NVIDIA SHIELD accessories with haptics capabilities.

According to Documentation/process/coding-style.rst, Kconfig help text should
be indented by 2 spaces after the "help" line:

10) Kconfig configuration files
-------------------------------

For all of the Kconfig* configuration files throughout the source tree,
the indentation is somewhat different.  Lines under a ``config`` definition
are indented with one tab, while help text is indented an additional two
spaces.  Example::

  config AUDIT
	bool "Auditing support"
	depends on NET
	help
	  Enable auditing infrastructure that can be used with another
	  kernel subsystem, such as SELinux (which requires this for
	  logging of avc messages output).  Does not do system-call
	  auditing without CONFIG_AUDITSYSCALL.

-- 
~Randy
