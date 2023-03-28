Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02DA16CBB8B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 11:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbjC1JxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 05:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232656AbjC1Jwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:52:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25D472AB;
        Tue, 28 Mar 2023 02:51:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57BA261630;
        Tue, 28 Mar 2023 09:51:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B250BC433EF;
        Tue, 28 Mar 2023 09:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679997101;
        bh=IeUoFJsAwrYDiV9XdFo6igFhnSlqKPAMMJqeh4qtdc4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p2cTDIPDDT+JT8iVO9/oDNpMHwO3quM7caq//p3/vN+Noit24Eb5L+Po1Yrp2kGt+
         CquPJOSo38v1miL/GhoQUJa0AMz6Ab0KMqiW4nlf/zsO9+HJcJpqkT7djb7T+Ly53Y
         UtKaANYFP3bsks3tYGN3JtZE/DAeaHn+vUMMPkCFzRIvwFRQHJfWiO2C7o1Pqqsi+6
         +/3134tB122RUrUMAYpIuZU0BU2Vj2/UjJ5yCyI6ljiCtqhzWusMWW0UlGB8s7EH0A
         Z2zfLMq42PvmtjGcX61xOOngKb+1hmtPjotDVUmNYqQnL6XXLF44eKA+bNIOEMkZwD
         /f7MwuMvMWNbQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ph5zd-0004dS-3v; Tue, 28 Mar 2023 11:51:53 +0200
Date:   Tue, 28 Mar 2023 11:51:53 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     andersson@kernel.org, Thinh.Nguyen@synopsys.com,
        gregkh@linuxfoundation.org, mathias.nyman@intel.com,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 3/5] usb: dwc3: qcom: Fix null ptr access during
 runtime_suspend()
Message-ID: <ZCK4uZCrbVZ/HfRq@hovoldconsulting.com>
References: <20230325165217.31069-1-manivannan.sadhasivam@linaro.org>
 <20230325165217.31069-4-manivannan.sadhasivam@linaro.org>
 <ZCKyFEc087xoypdo@hovoldconsulting.com>
 <20230328094718.GB5695@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328094718.GB5695@thinkpad>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 03:17:18PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Mar 28, 2023 at 11:23:32AM +0200, Johan Hovold wrote:
> > On Sat, Mar 25, 2023 at 10:22:15PM +0530, Manivannan Sadhasivam wrote:

> > >  static int dwc3_qcom_suspend(struct dwc3_qcom *qcom, bool wakeup)
> > >  {
> > > +	struct dwc3 *dwc = platform_get_drvdata(qcom->dwc3);
> > >  	u32 val;
> > >  	int i, ret;
> > >  
> > > -	if (qcom->is_suspended)
> > > +	if (qcom->is_suspended || !dwc)
> > >  		return 0;
> > 
> > I think we should try to keep the layering violations confined to the
> > helper functions. So how about amending dwc3_qcom_is_host() and check
> > for NULL before dereferencing the xhci pointer?
> > 
> > If the dwc3 driver hasn't probed yet, we're clearly not in host mode
> > either...
> 
> Well, that's what I initially did but then I reverted to this approach as
> returning true/false from dwc3_qcom_is_host() based on the pointer availability
> doesn't sound right.
> 
> For example, if we return true then it implies that the driver is in host mode
> which is logically wrong (before dwc3 probe) even though there is no impact.

No, you should return false of course as we are *not* in host mode as I
mentioned above.

Johan
