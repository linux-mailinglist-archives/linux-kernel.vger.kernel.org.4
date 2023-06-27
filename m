Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD957400BE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 18:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjF0QS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 12:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbjF0QSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 12:18:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157AD358D;
        Tue, 27 Jun 2023 09:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=pFQ4isJV7B2TpjCesrpoSBexjZu02KMRcYM/H65TX6Y=; b=cDV5unRuN1fjTywciYAWUrDi19
        RNTLBA4Bmbwsg3DqyTvxqQ3AI6O+RSJATGlLtPo7BrbhhkqSdbXcoQoLiUZc8jvqJ0dL9a5CLKJwQ
        6zdszemjI+Zo6qrtqfIzYP+FFBi4oSXc6gOH7RHAt71c6Aixw9/2ftJ+2el//DmXY0wMkgdmuAXym
        sgxEGl4Ac/NjKXj1eohGNZrlZ5tmgNyQvPQRwHjFifmbI8oEWolpqBXCy8NWZtwEDyPk4iA+770IN
        DQLnOHKGucPKWfXEWkTXEAVZElRH8lxdDcAbAZiugNZj1RsJaYLxQK8SQs1jhUBiilrcPuKiGxauc
        GCUBMLlw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qEBOm-00Dcey-2T;
        Tue, 27 Jun 2023 16:18:36 +0000
Message-ID: <1e081fc1-5d90-f3d4-7429-363dba996ef7@infradead.org>
Date:   Tue, 27 Jun 2023 09:18:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH V24 2/3] misc: dcc: Add driver support for Data Capture
 and Compare unit(DCC)
Content-Language: en-US
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Alex Elder <elder@ieee.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
References: <cover.1687855361.git.quic_schowdhu@quicinc.com>
 <62bf3d9766bc785cfd0fc8e674ce7f86499a0f5b.1687855361.git.quic_schowdhu@quicinc.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <62bf3d9766bc785cfd0fc8e674ce7f86499a0f5b.1687855361.git.quic_schowdhu@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 6/27/23 02:49, Souradeep Chowdhury wrote:
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 433aa4197785..3112dbb15cf4 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -276,6 +276,15 @@ config QCOM_COINCELL
>  	  to maintain PMIC register and RTC state in the absence of
>  	  external power.
> 
> +config QCOM_DCC
> +	tristate "Qualcomm Technologies, Inc. Data Capture and Compare(DCC) engine driver"

	                                                       Compare (DCC)

> +	depends on ARCH_QCOM || COMPILE_TEST
> +	help
> +	  This option enables driver for Data Capture and Compare engine. DCC

	              enables the driver for the                        . The DCC

> +	  driver provides interface to configure DCC block and read back

	         provides interfaces to configure the DCC block and read back

> +	  captured data from DCC's internal SRAM. The module name for this

	                from the DCC's

> +	  is qcom-dcc.ko

We don't usually add the ".ko" here, so just:

	  is qcom-dcc.

thanks.
-- 
~Randy
