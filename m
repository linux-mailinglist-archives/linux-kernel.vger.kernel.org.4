Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E786A702C1C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 13:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241708AbjEOL6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 07:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241705AbjEOL5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 07:57:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A77A40E3;
        Mon, 15 May 2023 04:55:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C729614A2;
        Mon, 15 May 2023 11:54:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E4CC433D2;
        Mon, 15 May 2023 11:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684151699;
        bh=kh1kY/KhPkOpkYVPUCfFY3w8ObJ/nJNgBlNa4gelO4c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hzgQWD7bVW5NZ64o0Hk29zdp3hNcGMVcH3Xa3KVWNAvNhDg0DgjqbeV7p882MNW5/
         i8bJq5rZmUCotx1A6xgE1J4bajAIFLQEw0lXLOHxFz5G/28admhEttNQqoSRfka7R8
         41AgS7KCXXJTWWC0hQmndSenHynLhjQ/IA29MHJ3IrTzvwB2uQQYs7GZ2nxSysEX3o
         DQ/3CSjqhMxtRobrbSZ5Z1zfsKjtVFHta++1YYxoAQVNQ9gV3qWzUc+gcro6wDLBp9
         9Inf0rxksfRRcSP/Go3YsGbLmDGnsWbURx+ddNo4WY9bhlVmMlf3wLOildNBOPTUj1
         PLGDB7MN12mVQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pyWn2-00040G-FC; Mon, 15 May 2023 13:54:56 +0200
Date:   Mon, 15 May 2023 13:54:56 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp: Flush RSC sleep & wake votes
Message-ID: <ZGIdkHn6bVbln5uy@hovoldconsulting.com>
References: <20230512150425.3171122-1-quic_bjorande@quicinc.com>
 <f6ecd66b-e207-0ed9-0ff3-1febfdf5bce9@linaro.org>
 <20230515023828.jqrrqkit5ygovimp@ripper>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515023828.jqrrqkit5ygovimp@ripper>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 14, 2023 at 07:38:28PM -0700, Bjorn Andersson wrote:
> On Sat, May 13, 2023 at 11:09:07AM +0200, Konrad Dybcio wrote:
> > 
> > 
> > On 12.05.2023 17:04, Bjorn Andersson wrote:
> > > The rpmh driver will cache sleep and wake votes until the cluster
> > > power-domain is about to enter idle, to avoid unnecessary writes. So
> > > associate the apps_rsc with the cluster pd, so that it can be notified
> > > about this event.
> > > 
> > > Without this, only AMC votes are being commited.
> > Ouch.
> > 
> > Should we make this required: in bindings and add it to all
> > platforms?
> > 
> 
> I though this was an optimization and in the absence of this callback
> the driver would just write out wake and sleep sets as well. But per the
> current implementation (and perhaps some underlying cause?) it is indeed
> required, if you care about power consumption.
> 
> > > 
> > > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> > > ---
> > Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > Fixes: 152d1faf1e2f ("arm64: dts: qcom: add SC8280XP platform")
> > 
> 
> The Fixes sounds reasonable.

Note that support for the cluster domain was not added until 6.2 and
commit 25092e6100ac ("soc: qcom: rpmh-rsc: Attach RSC to cluster PM
domain") while support for sc8280xp went into 5.19 IIRC.

Johan
