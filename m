Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104C068DD23
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 16:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjBGPgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 10:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjBGPgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 10:36:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328A1C17F;
        Tue,  7 Feb 2023 07:36:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D5418B819EE;
        Tue,  7 Feb 2023 15:36:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C22CC4339B;
        Tue,  7 Feb 2023 15:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675784164;
        bh=twUuRWo9k9a5573XBSzemQ0MkkZj6VKOcK+Snm4pbYQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=on7gJR781lE0FEpK0kHYrD5xk+6bAxBTheM6yrUELehxQPQvUN+82j9kgc8MoH6Rv
         ANwsPYYxde5xhhPJacBLJD/iSB6+p1rPacaSYIJ6au/q9VN7Dh+X0r80h+yMgw5SOD
         59ISRMLHicS+F9ktW8sGdRuT0LapgpHpSy+CP2qY0FtzAQF1pJ11FXtfQP0skns7Wz
         EOIni3uqdYBwvTJcarlq2NfgX373LNLIuTHbynIekuuaO/cYB+eAvQKoHzl386tbuN
         7OewWkHUmdzNtLrQcx1Kil1pD+zSbomE039Zt9tp+kvQGggq6jF1Gw9/cld6d7gUTr
         R7x84V8c35huw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pPQ1O-0002CR-9t; Tue, 07 Feb 2023 16:36:38 +0100
Date:   Tue, 7 Feb 2023 16:36:38 +0100
From:   Johan Hovold <johan@kernel.org>
To:     David Collins <quic_collinsd@quicinc.com>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 17/22] rtc: pm8xxx: add support for nvmem offset
Message-ID: <Y+JwBkhc/WbkFq25@hovoldconsulting.com>
References: <20230202155448.6715-1-johan+linaro@kernel.org>
 <20230202155448.6715-18-johan+linaro@kernel.org>
 <f7e6203d-5773-3c40-db3c-547334efb218@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7e6203d-5773-3c40-db3c-547334efb218@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 07:16:54PM -0800, David Collins wrote:
> On 2/2/23 07:54, Johan Hovold wrote:

> > +static int pm8xxx_rtc_read_nvmem_offset(struct pm8xxx_rtc *rtc_dd)
> > +{
> > +	size_t len;
> > +	void *buf;
> > +	int rc;
> > +
> > +	buf = nvmem_cell_read(rtc_dd->nvmem_cell, &len);
> > +	if (IS_ERR(buf)) {
> > +		rc = PTR_ERR(buf);
> > +		dev_dbg(rtc_dd->dev, "failed to read nvmem offset: %d\n", rc);
> 
> Why is dev_dbg() used instead of dev_err() for newly added error
> messages?  Also, why do these conditions warrant error logging when some
> of the previous patches in this series removed older error logging?

I would have used dev_err() here and did so for v1, but Alexandre
prefers dev_dbg() for errors that are unlikely to be seen by regular
users but that can still be useful to developers (e.g. when enabling the
rtc on a new platform).

One or two of the spmi errors I removed falls in the same category in so
far that the control and time registers may write-protected on some
platforms, but such errors are currently logged by the spmi controller
driver.

Johan
