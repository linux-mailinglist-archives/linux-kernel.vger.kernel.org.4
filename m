Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED53F643DDF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 08:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbiLFHzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 02:55:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbiLFHzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 02:55:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8325915736;
        Mon,  5 Dec 2022 23:55:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23AEC6159B;
        Tue,  6 Dec 2022 07:55:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8259DC433C1;
        Tue,  6 Dec 2022 07:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670313342;
        bh=0I6MjdoaniHTQdE6M92nGwwRUX9bmzCkmed1VgLdy4w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=txiWcekEX32RvDDR+LQeWWDeHl2tI47yoHl1qbioOR3ZDWiKmVoXZlxJ2NZvokrMg
         bNXp1RJjdvLpDKM+3jd75HYocWUahyCe/+2v2BBwXb3DdzYBKpyc9x/Zj6yRyv4MdE
         F01XBMeevjCet3D0JPktyJY9R01lMtMbadIpWmozbR1a8XElH1/KRXOZwQfPVG5/Pq
         m3lPCpACLkQxiEWlv14/zdG4YJ/L8PcyORMK3KM9G88mll8pkLPDIBuKEuJ9ClikMD
         i8yXzTUk/C8cR2FwNl5adu0KzM+3NQvPR0IWqQtBOC9tIYZS58TiBhCsCWe6JatY1/
         cb7u9vY3Xgkyg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1p2Snt-000745-9v; Tue, 06 Dec 2022 08:55:50 +0100
Date:   Tue, 6 Dec 2022 08:55:49 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: ufs: qcom: allow 'dma-coherent' property
Message-ID: <Y471hQ2Si5IFq6Xg@hovoldconsulting.com>
References: <20221205100837.29212-1-johan+linaro@kernel.org>
 <20221205100837.29212-2-johan+linaro@kernel.org>
 <20221205230751.ismiwodjhsyxp5uv@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205230751.ismiwodjhsyxp5uv@builder.lan>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 05:07:51PM -0600, Bjorn Andersson wrote:
> On Mon, Dec 05, 2022 at 11:08:36AM +0100, Johan Hovold wrote:
> > UFS controllers may be cache coherent and must be marked as such in the
> > devicetree to avoid data corruption.
> > 
> > This is specifically needed on recent Qualcomm platforms like SC8280XP.
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> 
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> 
> But I think this should be picked up by James or Martin. Added them as
> explicit recipients, but perhaps they would like you to resubmit this?

They were not included in the get_maintainer.pl output so I'm guessing
they prefer to pick UFS binding patches from the scsi list.

> I'm picking the dts change for now.

Thanks.

Johan
