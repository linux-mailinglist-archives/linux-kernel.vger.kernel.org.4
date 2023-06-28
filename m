Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4CA974154A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 17:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbjF1Pdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 11:33:37 -0400
Received: from dfw.source.kernel.org ([139.178.84.217]:46086 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbjF1Pc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:32:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BF8C6137B;
        Wed, 28 Jun 2023 15:32:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E266C433C0;
        Wed, 28 Jun 2023 15:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687966374;
        bh=5BCkT+FanlGIy02RrZESfVtbkxz2az/nnPp2C2DcBRs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pno1tIF9znhx4k/HGXHlsU2+bHMzN34sQk2R2qTh5D3byvPa5JoDziFmAJLIJSGSU
         oNIiLtOYIQdRAXfqPWG30pnGbadLIV+kweJXIXvszpB0C5uQXz0X1b0noy5zNTtOI+
         ZBlg1rc0s9A8E8YlqowvKRJVoRNbotCYLcu0sZ1DLSert7+VzIqtqRmobtKIr6ltn/
         INKDWfDZbRCE4/AGRBEV0SwawkGxxwZJf+ca5G6+itVNGSe0zbc90M99E+SqXwEQw+
         RaFjYn5Ni1Y3p/LWXmpqfMWkWTwkIwxdwenIi7264cc2AsIE5yPIVlMbPRvy0Z4IK7
         CzB3k+c5+BKAA==
Date:   Wed, 28 Jun 2023 16:32:47 +0100
From:   Will Deacon <will@kernel.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     Pavan Kondeti <quic_pkondeti@quicinc.com>, corbet@lwn.net,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, keescook@chromium.org, tony.luck@intel.com,
        gpiccoli@igalia.com, mathieu.poirier@linaro.org,
        catalin.marinas@arm.com, linus.walleij@linaro.org,
        andy.shevchenko@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 02/21] kallsyms: Export kallsyms_lookup_name
Message-ID: <20230628153246.GA22090@willie-the-truck>
References: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com>
 <1687955688-20809-3-git-send-email-quic_mojha@quicinc.com>
 <a26f22d2-95a7-4143-bff5-45ef0b53b30b@quicinc.com>
 <86c104a6-a685-4d05-08f4-e1be595f9d31@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86c104a6-a685-4d05-08f4-e1be595f9d31@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 08:52:57PM +0530, Mukesh Ojha wrote:
> 
> 
> On 6/28/2023 7:23 PM, Pavan Kondeti wrote:
> > On Wed, Jun 28, 2023 at 06:04:29PM +0530, Mukesh Ojha wrote:
> > > Module like minidump providing debugging support will need to
> > > get the symbol information from the core kernel e.g to get
> > > the linux_banner, kernel section addresses bss, data, ro etc.
> > > 
> > One might ask why we would need such a debug driver to
> > be compiled as module? What would you do if we need to capture more
> > kernel data structures later? Do you plan to continue use
> > kallsyms_lookup_name() to query all the symbols?
> 
> You are on point, i needed this driver to be static but i don't have
> any example at present to collect more than just _linux_banner_ from
> my existing set of patches..
> 
> Agree, it will be easier to make this driver as static instead of
> opening up the doors for modules to abuse via exporting
> kallsyms_lookup_name() and also it will be very slow for production
> kernel uses.

Right, I unexported that symbol deliberately in 0bd476e6c671 ("kallsyms:
unexport kallsyms_lookup_name() and kallsyms_on_each_symbol()") and I
don't think we should add it back for this driver.

Will
