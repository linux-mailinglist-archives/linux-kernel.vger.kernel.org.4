Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B2A741584
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 17:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjF1Png (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 11:43:36 -0400
Received: from dfw.source.kernel.org ([139.178.84.217]:54314 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjF1Pn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:43:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F9D26136F;
        Wed, 28 Jun 2023 15:43:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F6DC433C0;
        Wed, 28 Jun 2023 15:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687967007;
        bh=QafBLFEUSubIM0CHvXTdPIXFnVTEgRgzGG04lDEXW5s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tlPmZc5wm/YQdCJ7H8wF7mko03Bw8ML0pQaHXsDTii81r62St9LdDepg8mzMWmCp6
         erGIUwBdJu49dRTVY0rroxrRSbS2wHJTILgPe6nJ4m+h+NFC8hHau96ibNsgMsY5Ub
         o1xePnLiaA7yiaT3/mhqWkGGBoHxBjNlAoYB21HQ=
Date:   Wed, 28 Jun 2023 17:43:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Will Deacon <will@kernel.org>
Cc:     Mukesh Ojha <quic_mojha@quicinc.com>,
        Pavan Kondeti <quic_pkondeti@quicinc.com>, corbet@lwn.net,
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
Message-ID: <2023062852-jurist-sitcom-e0d6@gregkh>
References: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com>
 <1687955688-20809-3-git-send-email-quic_mojha@quicinc.com>
 <a26f22d2-95a7-4143-bff5-45ef0b53b30b@quicinc.com>
 <86c104a6-a685-4d05-08f4-e1be595f9d31@quicinc.com>
 <20230628153246.GA22090@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628153246.GA22090@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 04:32:47PM +0100, Will Deacon wrote:
> On Wed, Jun 28, 2023 at 08:52:57PM +0530, Mukesh Ojha wrote:
> > 
> > 
> > On 6/28/2023 7:23 PM, Pavan Kondeti wrote:
> > > On Wed, Jun 28, 2023 at 06:04:29PM +0530, Mukesh Ojha wrote:
> > > > Module like minidump providing debugging support will need to
> > > > get the symbol information from the core kernel e.g to get
> > > > the linux_banner, kernel section addresses bss, data, ro etc.
> > > > 
> > > One might ask why we would need such a debug driver to
> > > be compiled as module? What would you do if we need to capture more
> > > kernel data structures later? Do you plan to continue use
> > > kallsyms_lookup_name() to query all the symbols?
> > 
> > You are on point, i needed this driver to be static but i don't have
> > any example at present to collect more than just _linux_banner_ from
> > my existing set of patches..
> > 
> > Agree, it will be easier to make this driver as static instead of
> > opening up the doors for modules to abuse via exporting
> > kallsyms_lookup_name() and also it will be very slow for production
> > kernel uses.
> 
> Right, I unexported that symbol deliberately in 0bd476e6c671 ("kallsyms:
> unexport kallsyms_lookup_name() and kallsyms_on_each_symbol()") and I
> don't think we should add it back for this driver.

I agree, it shouldn't be needed by any in-kernel module/driver.  If you
really want the name, look it up afterward in userspace :)

thanks,

greg k-h
