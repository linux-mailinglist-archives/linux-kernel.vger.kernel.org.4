Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790F4716244
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 15:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbjE3NkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 09:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjE3NkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 09:40:07 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFDAA1;
        Tue, 30 May 2023 06:40:06 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id C593085AFF;
        Tue, 30 May 2023 15:39:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1685453993;
        bh=8A/n4Or8zcPbKOdLOdAJ1XbthrueKeyiEt0aiuAR+J0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EIcQODo6+XnwF94Go4CA2PyxHiiEbr/rSjWqPO2i8qS4xUI+todxDlgN+WzQSqNV6
         uVahSHPRa9g73heAdm0WLruBVBZYstDVuNdUn4thqrK8KiJUlzwp2OlVyXkdMjGc75
         jk1reclZaKgG07ngebFpZCYHZ6DQi1/pwU/OXLYIrByWd5zeW1VJ//FoSrw4R7Nq83
         Hh3gpGFUpNr6SpMAuPmL1Uj/6GffWpX9WFjXh2C76RvilWz4I0Nakt4lgXsuv+IIVb
         xKk0q54sV0sjHY50KFs7w7mfVKP6sxVk8dyC4GxeCAsCR/r8WCk9R95OT80FVGnZbt
         DphDniNZsXICQ==
Message-ID: <7e909409-fa18-99ec-7218-5803ba7d0013@denx.de>
Date:   Tue, 30 May 2023 15:39:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 0/9] ARM: dts: stm32: add adc internal channels on
 stm32mp15
Content-Language: en-US
To:     Olivier Moysan <olivier.moysan@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@dh-electronics.com
References: <20230530124538.621760-1-olivier.moysan@foss.st.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20230530124538.621760-1-olivier.moysan@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/23 14:45, Olivier Moysan wrote:
> Add STM32 ADC2 internal channels VREFINT and VDDCORE to STM32MP15x SoCs.
> 
> Add support of vrefint channel by adding access to vrefint calibration
> data in OTP.
> 
> The internal channels are defined in STM32MP15 SoC DT according to
> generic channel bindings. The STM32 driver does not support a mixed use
> of legacy and generic channels. When generic channels are defined,
> legacy channel are ignored. This involves that the board device trees
> using legacy bindings have to be changed to generic bindings.
> 
> Adopt generic iio bindings on STM32 boards implementing the ADC.
> 
> Changes in v2:
> - Add patch from https://lore.kernel.org/linux-arm-kernel/20230518020547.487670-1-marex@denx.de/T/

Thank you
