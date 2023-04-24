Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A88156ED010
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 16:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjDXOMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 10:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbjDXOMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 10:12:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D40B7D84;
        Mon, 24 Apr 2023 07:12:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1C3361A2B;
        Mon, 24 Apr 2023 14:11:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B69C433EF;
        Mon, 24 Apr 2023 14:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682345519;
        bh=rXDHwC4VVIDhGhpP6nmTzwKeAZm5iA95fSY6qeiaDfk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ecpuOMTszADJgavY0i4FFYrmRsSE82tCm+QPqEkdo5TNJZ0aomGalWpUZP0Ssb37+
         6BRaY9kgbQwqrNhHiAnWG5WmonxJCpgW7u0su6XQrV4B5V5qAzwpLIhlrluayElPR/
         9LvYnxGL2AR/Jo5Ejdd9VZ2uR/rElBYlR3kFXPr+bNZk1kYpGQ/G/iNoQL5vYnmfNC
         2gWYQtekVQ8MyM+tQvnoS0fEqOvYMNWiu0AMPp90UfQoLGH2XYKkZ+TzqGbivTB67f
         sYnPOiDz75wq5eq8MMpVpB6nSElpSmDbIzBWx/M92Sn27+kD8rIcS+lMpc/OCpiMRO
         6XOmZzurWJmLg==
Message-ID: <4a2f1ed0-015b-9953-1656-5d90020b7c10@kernel.org>
Date:   Mon, 24 Apr 2023 17:11:52 +0300
MIME-Version: 1.0
Subject: Re: [PATCH v2 4/5] drm/msm/mdss: Handle the reg bus ICC path
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230417-topic-dpu_regbus-v2-0-91a66d04898e@linaro.org>
 <20230417-topic-dpu_regbus-v2-4-91a66d04898e@linaro.org>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20230417-topic-dpu_regbus-v2-4-91a66d04898e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konrad,

On 18.04.23 15:10, Konrad Dybcio wrote:
> Apart from the already handled data bus (MAS_MDP_Pn<->DDR), there's
> another path that needs to be handled to ensure MDSS functions properly,
> namely the "reg bus", a.k.a the CPU-MDSS interconnect.
> 
> Gating that path may have a variety of effects.. from none to otherwise
> inexplicable DSI timeouts..
> 
> On the MDSS side, we only have to ensure that it's on at what Qualcomm
> downstream calls "77 MHz", a.k.a 76.8 Mbps and turn it off at suspend.
> 
> To achieve that, make msm_mdss_icc_request_bw() accept a boolean to
> indicate whether we want the busses to be on or off, as this function's
> only use is to vote for minimum or no bandwidth at all.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/gpu/drm/msm/msm_mdss.c | 17 +++++++++++++----
>   1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
[..]
> -static void msm_mdss_icc_request_bw(struct msm_mdss *msm_mdss, unsigned long bw)
> +static void msm_mdss_icc_request_bw(struct msm_mdss *msm_mdss, bool enable)
>   {
>   	int i;
>   
>   	for (i = 0; i < msm_mdss->num_mdp_paths; i++)
> -		icc_set_bw(msm_mdss->mdp_path[i], 0, Bps_to_icc(bw));
> +		icc_set_bw(msm_mdss->mdp_path[i], 0, enable ? Bps_to_icc(MIN_IB_BW) : 0);
> +
> +	if (msm_mdss->reg_bus_path)
> +		icc_set_bw(msm_mdss->reg_bus_path, 0, enable ? 76800 : 0);

Please use Bps_to_icc, kbps_to_icc or any of the other macros.

BR,
Georgi
