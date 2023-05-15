Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D5C702C0C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 13:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241734AbjEOL5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 07:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241667AbjEOL4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 07:56:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3133AAE;
        Mon, 15 May 2023 04:52:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 261DA62250;
        Mon, 15 May 2023 11:52:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C9DC433EF;
        Mon, 15 May 2023 11:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684151540;
        bh=Cx0m8x2Mhqcbhl9YWvPjb4YVogzNRjcf/Utt/v0UfWU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LoYBJJXk7CZp5oKEZA5udpnT3rNMSbJEkfWCbjTyFmnhfNDxLxW1BX798rikxsA7u
         EAF5eNYF5/DJDJg2mGnlECbFu3Gw1nf/d9nC1sOQE8I3AH4l1JG4lcvJssD7CeI680
         fe7OEEb7KihZHIOihJLB7vh/bk3HFxJf5IVGcp9ZIQYNChgc3USc2CO3lWnCh6sA2q
         +0K5V1oC1qQeFB0AdDs8Qgt6YMYG2W0WprbNA73gyzFcywkpn7ckJ6+XPl34tiRFOa
         Kwf9j6lmHr8gQcBC/CjOSsh00XagIMC+Fsi1lISurYg15VbmR0s8WGt3mEV370jKIQ
         6pXmOjd6RX5Rw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pyWkT-0003yW-2Y; Mon, 15 May 2023 13:52:17 +0200
Date:   Mon, 15 May 2023 13:52:17 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp: Flush RSC sleep & wake votes
Message-ID: <ZGIc8SPNy0oqCqjR@hovoldconsulting.com>
References: <20230512150425.3171122-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512150425.3171122-1-quic_bjorande@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 08:04:25AM -0700, Bjorn Andersson wrote:
> The rpmh driver will cache sleep and wake votes until the cluster
> power-domain is about to enter idle, to avoid unnecessary writes. So
> associate the apps_rsc with the cluster pd, so that it can be notified
> about this event.
> 
> Without this, only AMC votes are being commited.

I'm sure I'm missing some details here, but from reading (and tracing)
the code it looks like the cached votes are still being flushed albeit
via rpmh_rsc_cpu_pm_callback() as the individual CPUs go down.

There wasn't really any obvious motivation in the series adding support
for the cluster domain as to why the new mechanism is preferred (e.g. if
this is an actual fix or just an optimisation done to align with
downstream):

	https://lore.kernel.org/all/20221018152837.619426-1-ulf.hansson@linaro.org/

Either way, this appears to work as intended even if it does not in
itself have any significant effect on the X13s power consumption (in
idle or suspend).

> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Tested-by: Johan Hovold <johan+linaro@kernel.org>

Johan
