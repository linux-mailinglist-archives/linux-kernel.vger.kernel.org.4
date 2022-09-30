Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F345F07B6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 11:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbiI3Jdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 05:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbiI3JdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:33:19 -0400
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [5.144.164.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DB6157FCA
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 02:32:05 -0700 (PDT)
Received: from [192.168.1.101] (95.49.31.201.neoplus.adsl.tpnet.pl [95.49.31.201])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 0E7763EBB8;
        Fri, 30 Sep 2022 11:32:01 +0200 (CEST)
Message-ID: <59e0d757-2c1d-0abc-dc8c-a6b7b0d9aa91@somainline.org>
Date:   Fri, 30 Sep 2022 11:32:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 1/2] slimbus: stream: handle unsupported bitrates for
 presence rate
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20220930092006.85982-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220930092006.85982-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30.09.2022 11:20, Krzysztof Kozlowski wrote:
> Handle errors of getting presence rate for unsupported stream bitrate,
> instead of sending -EINVAL in change content message.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Konrad
>  drivers/slimbus/stream.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/slimbus/stream.c b/drivers/slimbus/stream.c
> index f8eade1e0132..28fbecb3907d 100644
> --- a/drivers/slimbus/stream.c
> +++ b/drivers/slimbus/stream.c
> @@ -204,7 +204,7 @@ int slim_stream_prepare(struct slim_stream_runtime *rt,
>  {
>  	struct slim_controller *ctrl = rt->dev->ctrl;
>  	struct slim_port *port;
> -	int num_ports, i, port_id;
> +	int num_ports, i, port_id, prrate;
>  
>  	pr_err("%s:%d AAAA\n", __func__, __LINE__);
>  	if (rt->ports) {
> @@ -222,6 +222,13 @@ int slim_stream_prepare(struct slim_stream_runtime *rt,
>  	rt->bps = cfg->bps;
>  	rt->direction = cfg->direction;
>  
> +	prrate = slim_get_prate_code(cfg->rate);
> +	if (prrate < 0) {
> +		dev_err(&rt->dev->dev, "Cannot get presence rate for rate %d Hz\n",
> +			cfg->rate);
> +		return -EINVAL;
> +	}
> +
>  	if (cfg->rate % ctrl->a_framer->superfreq) {
>  		/*
>  		 * data rate not exactly multiple of super frame,
> @@ -242,7 +249,7 @@ int slim_stream_prepare(struct slim_stream_runtime *rt,
>  		port = &rt->ports[i];
>  		port->state = SLIM_PORT_DISCONNECTED;
>  		port->id = port_id;
> -		port->ch.prrate = slim_get_prate_code(cfg->rate);
> +		port->ch.prrate = prrate;
>  		port->ch.id = cfg->chs[i];
>  		port->ch.data_fmt = SLIM_CH_DATA_FMT_NOT_DEFINED;
>  		port->ch.aux_fmt = SLIM_CH_AUX_FMT_NOT_APPLICABLE;
