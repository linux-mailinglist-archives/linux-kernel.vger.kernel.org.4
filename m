Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B24D691964
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 08:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjBJHxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 02:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbjBJHxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 02:53:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008D97AE20;
        Thu,  9 Feb 2023 23:53:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A68261CC5;
        Fri, 10 Feb 2023 07:53:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD10CC433D2;
        Fri, 10 Feb 2023 07:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676015591;
        bh=2I9LX6VnJCeDCDxn+SPhDcHNgjHEmOELlciRwbaB3Wk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GjmmCj30FCBlhLr0lr5JShyjQgF+q0mMoH8Tt8Jp4Db4OKvIfqt+n4RAc5H/Ch/fJ
         qyTaVBq/SXIg4VJn1nHg9BR5Wj8weplpEyTjOEjigmqhZMEgpN48G3QxqeldHAMdoK
         CcOFUePEdzRKs7v/dT3TnwAYn9kSGxq8C9cKxme1vRSPcmEXqAx17Ms2yfoGbS6rs0
         lBlSDuvnDBzEUVMTXP0fUSuJJ3u5ErJuKAmZeeohqb83BieYIa0v7cu6ADyGiGLzAw
         HtR2vOXrxv408RlrjzmxrQH52c5PVmfPlH3Bc2zNQzTMojNnqbDEEdj01UyYMB+UgE
         RJhTqYcVeC0iw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pQOEC-00018G-Vq; Fri, 10 Feb 2023 08:53:53 +0100
Date:   Fri, 10 Feb 2023 08:53:52 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v2 00/22] rtc: pm8xxx: add support for setting
 time using nvmem
Message-ID: <Y+X4EBACJ/AYvtOw@hovoldconsulting.com>
References: <20230202155448.6715-1-johan+linaro@kernel.org>
 <167598144775.1655758.2122287458672785227.b4-ty@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167598144775.1655758.2122287458672785227.b4-ty@bootlin.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2023 at 11:25:34PM +0100, Alexandre Belloni wrote:
> 
> On Thu, 02 Feb 2023 16:54:26 +0100, Johan Hovold wrote:
> > This series adds support for setting the RTC time on Qualcomm platforms
> > where the PMIC RTC time registers are read-only by instead storing an
> > offset in some other non-volatile memory. This is used to enable the RTC
> > in the SC8280XP Compute Reference Design (CRD) and Lenovo Thinkpad X13s
> > laptop.
> > 
> > The RTCs in many Qualcomm devices are effectively broken due to the time
> > registers being read-only. Instead some other non-volatile memory can be
> > used to store and offset which a driver can take into account. On
> > machines like the X13s, the UEFI firmware (and Windows) use a UEFI
> > variable for storing such an offset, but not all Qualcomm systems use
> > UEFI.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [01/22] rtc: pm8xxx: fix set-alarm race
>         commit: c88db0eff9722fc2b6c4d172a50471d20e08ecc6

...

> [15/22] rtc: pm8xxx: drop error messages
>         commit: c94fb939e65155bc889e62396f83ef4317d643ac

I noticed that you did not apply patches 16 and 17 that add support for
the nvmem offset. Was that on purpose or a mistake?

Johan
