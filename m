Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383086DC9B9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 19:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjDJRIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 13:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjDJRIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 13:08:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4351FF3;
        Mon, 10 Apr 2023 10:08:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 673D761384;
        Mon, 10 Apr 2023 17:08:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE7CC433D2;
        Mon, 10 Apr 2023 17:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681146512;
        bh=Hv4o3VnNG0XBWtGlWc/Q+zmtOMP9UC7woDh5zkuH6i4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UGlIswryCey2zrjsO/Yh6KpekRyDWZmf/i/ti3KQsKavhPhaXj9lf3bRRyWWUYThu
         T3c9q9ivg312q8woHvN9osiuOYEx2rV8nYn5zQvuZNAaMkl6rXYCauZ+2F/eejnz8b
         wepPHv/ziBGMUWRHpSmxerHu9YzbVRsvjNf+feMfTDGSzqCp+lUKFoEg50JlZyL++s
         cx+bD09pY/1LA4GfhIfULFO1azBdmISlUl0BgeFu9nMmuU1olF4PAqY5lbavHFXs13
         PQ8mO+Q87FZkyoYYvwBKue+mWMuS8+8tAI9T/4CwTgPWL7oZzuUKS+0tgl76g2/jU3
         3IGFh/hMZ7tzQ==
Date:   Mon, 10 Apr 2023 10:12:15 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski@linaro.org
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: Add base qrb4210-rb2 board dts
Message-ID: <20230410171215.t65hic7uveeayfja@ripper>
References: <20230315210145.2221116-1-bhupesh.sharma@linaro.org>
 <20230315210145.2221116-3-bhupesh.sharma@linaro.org>
 <20230315223604.ofy7vm3bpccf5aul@ripper>
 <79731f2a-83e5-1e35-d450-456492cc5df2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79731f2a-83e5-1e35-d450-456492cc5df2@linaro.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 12:52:10AM +0100, Konrad Dybcio wrote:
> 
> 
> On 15.03.2023 23:36, Bjorn Andersson wrote:
> > On Thu, Mar 16, 2023 at 02:31:45AM +0530, Bhupesh Sharma wrote:
> >> Add DTS for Qualcomm qrb4210-rb2 board which uses SM4250 SoC.
> >>
> >> This adds debug uart, emmc, uSD and tlmm support along with
> >> regulators found on this board.
> >>
> >> Also defines the 'xo_board' and 'sleep_clk' frequencies for
> >> this board.
> >>
> >> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> >> ---
> [...]
> 
> >> +	vmmc-supply = <&vreg_l24a_2p96>;
> > 
> > Is there any reason why this platform doesn't require the vmmc supply to
> > be driven to HPM? This has traditionally been coming back biting us
> > through some stability issues later.
> Do we even support HPM/LPM on SMD RPM?
> 

We support specifying the load, which will trickle down to have the
HPM/LPM effect. You can find an example of this, with motivation in [1].

PS. While looking for an example I found [2]. regulator-system-load
doesn't do anything unless regulator-allow-set-load is defined...

[1] e38161bd325e ("arm64: dts: apq8096-db820c: Increase load on l21 for SDCARD")
[2] 1d99fee382a6 ("arm64: dts: qcom: sdm845-tama: Add regulator-system-load to l14a/l28a")

Regards,
Bjorn
