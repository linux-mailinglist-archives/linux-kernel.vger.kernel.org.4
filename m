Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721D967CE13
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 15:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbjAZO17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 09:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjAZO15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 09:27:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8741B410B8;
        Thu, 26 Jan 2023 06:27:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E842461852;
        Thu, 26 Jan 2023 14:27:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55EBFC433EF;
        Thu, 26 Jan 2023 14:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674743239;
        bh=co41Sw1i3gt06AkD8wXROVzlyhI8ixuReFbBDCfcQuc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V4R3RAhKfNwFPbZWClkLLF2rbv2UVtoeD1VviKsjb1ykNXy2fyz1t+hKlICOfsoqC
         +oEjp2BfgQGhwmFKBHdL9aYYNrFAkpP76cmGINIpVBLdZ4JQqAyEDfLlKUtlXtSkBk
         RxiFqNA6lGcafmktgn8TPtwcAQ7CCJOZLwnjxVFYdUQCQVzN5n4AUp8UXRJM9yXVuO
         4ptjVPt3w8WnRH515rkC6qW6H5zFQ3ICza8zc8GUU1ccs5URGGYackzva0p77qXi29
         aj7r2DODQMergZGndBZKxgYB/8fA9T6tcD7tA6ldKgZat24ul4Iq+gRHTB1zD+jX5s
         7masdTRvis4Ew==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pL3Dp-0006r1-Ps; Thu, 26 Jan 2023 15:27:25 +0100
Date:   Thu, 26 Jan 2023 15:27:25 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 19/24] rtc: pm8xxx: add support for uefi offset
Message-ID: <Y9KNzSYotgOheKZN@hovoldconsulting.com>
References: <20230126142057.25715-1-johan+linaro@kernel.org>
 <20230126142057.25715-20-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126142057.25715-20-johan+linaro@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 03:20:52PM +0100, Johan Hovold wrote:
> On many Qualcomm platforms the PMIC RTC control and time registers are
> read-only so that the RTC time can not be updated. Instead an offset
> needs be stored in some machine-specific non-volatile memory, which the
> driver can take into account.
> 
> Add support for storing a 32-bit offset from the GPS time epoch in a
> UEFI variable so that the RTC time can be set on such platforms.
> 
> The UEFI variable is
> 
>             882f8c2b-9646-435f-8de5-f208ff80c1bd-RTCInfo
> 
> and holds a 12-byte structure where the first four bytes is a GPS time
> offset in little-endian byte order.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

The Subject of this one was supposed to say "RFC" as it, like the
previous patch, is not intended to be merged just yet.

Johan
