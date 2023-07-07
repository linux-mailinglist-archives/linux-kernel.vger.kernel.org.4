Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7B474B084
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 14:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjGGMNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 08:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjGGMNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 08:13:02 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0431BE1
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 05:13:01 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-55b1238a024so1394843a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 05:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688731981; x=1691323981;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/RTMO+AT4S3xS25n9FIVImJWehYs4+WIqHvgECXpADM=;
        b=pYt9b++9H9z40fkrNpnb+1C1QezI8L8sE25dz+07e/POfONjfVQ1iu3jJAofE4gi90
         0TqPpduO2yj0TOvyPNKPy47rFVqjAtfXP9dSpQ+cWVBtuzvQirMALOXtxc6HqdP8Sygg
         HZn5JrqUqLISqTZFOd/tD0yj3Je6WigP42kUd4SZkPVQo2uFDKUlbc8OfLBob/SdSk19
         gEfaLLBIG5Z4vnysZivCtViIBdg989E2RPnn/NWUkI9DV59ij0IiJkBizZfjwsDQTT9f
         cAV7FDsXNkCiMTzuPbmZFQbYVcqIqC+ggtWktbSOzs1aCn1gPvOrVSuWAmp9U/KlSaG9
         liuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688731981; x=1691323981;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/RTMO+AT4S3xS25n9FIVImJWehYs4+WIqHvgECXpADM=;
        b=fe1pmeRpTYXgJNicWCJ/q0z/lgMsuQ1/RqpMz55dwbkc5Vhi22J8L+snJlOw2YrzfP
         e2BrbzPsz38FgKGsnivxUVInGxA7bXKNlLk5JCyld8ED++J40Sf7xdJI0w7Oa5EQT2zK
         MhrSwLh9AbQCxk0yONYgs3yg03Tz58QRY+tsVuoaHVfyCWRszMsIbQEmkZuziA+Tkbe4
         vs3QMjan7p/Z0VO7XRK2mFLuKyzPsrrTxaAm7gWgwfE6JFiw/m63waq48qgHBJz0Bmrr
         qv6qAk3Trz51N2gKVuINWWicrLS7MITGTVjM0MDKyJ8UE8MVBa0w6Fz/JDRyDc+ZQilk
         FBPw==
X-Gm-Message-State: ABy/qLbFhQflxIYNyCFFk6AfgLZUSpqUv4R7mIicIz6jiXctDJp15FIj
        ieLuEb3dWE4S0s7k1JEveD1r
X-Google-Smtp-Source: APBJJlFNGpHuoiRuJvDwBsrn6r5eVw5vXZztDkLj/bPpSAIjQw+AHe4MCqOqZ8L8L5UZm9YgAc5cQQ==
X-Received: by 2002:a17:902:e811:b0:1b8:b459:f47c with SMTP id u17-20020a170902e81100b001b8b459f47cmr6222716plg.14.1688731980764;
        Fri, 07 Jul 2023 05:13:00 -0700 (PDT)
Received: from thinkpad ([117.216.120.82])
        by smtp.gmail.com with ESMTPSA id t6-20020a1709027fc600b001b8932d77d7sm3156299plb.279.2023.07.07.05.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 05:13:00 -0700 (PDT)
Date:   Fri, 7 Jul 2023 17:42:54 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: rpmh-rsc: Include state in trace event
Message-ID: <20230707121254.GN6001@thinkpad>
References: <20230620230058.428833-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230620230058.428833-1-quic_bjorande@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 04:00:58PM -0700, Bjorn Andersson wrote:
> When tracing messages written to the RSC it's very useful to know the
> type of TCS being targeted, in particular if/when the code borrows a
> WAKE TCS for ACTIVE votes.
> 
> Add the "state" of the message to the traced information.
> 
> While at it, drop the "send-msg:" substring, as this is already captured
> by the trace event itself.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/soc/qcom/rpmh-rsc.c   |  2 +-
>  drivers/soc/qcom/trace-rpmh.h | 16 ++++++++++++----
>  2 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> index 0dd4363ebac8..a021dc71807b 100644
> --- a/drivers/soc/qcom/rpmh-rsc.c
> +++ b/drivers/soc/qcom/rpmh-rsc.c
> @@ -516,7 +516,7 @@ static void __tcs_buffer_write(struct rsc_drv *drv, int tcs_id, int cmd_id,
>  		write_tcs_cmd(drv, drv->regs[RSC_DRV_CMD_MSGID], tcs_id, j, msgid);
>  		write_tcs_cmd(drv, drv->regs[RSC_DRV_CMD_ADDR], tcs_id, j, cmd->addr);
>  		write_tcs_cmd(drv, drv->regs[RSC_DRV_CMD_DATA], tcs_id, j, cmd->data);
> -		trace_rpmh_send_msg(drv, tcs_id, j, msgid, cmd);
> +		trace_rpmh_send_msg(drv, tcs_id, msg->state, j, msgid, cmd);
>  	}
>  
>  	cmd_enable |= read_tcs_reg(drv, drv->regs[RSC_DRV_CMD_ENABLE], tcs_id);
> diff --git a/drivers/soc/qcom/trace-rpmh.h b/drivers/soc/qcom/trace-rpmh.h
> index 12b676b20cb2..be6b42ecc1f8 100644
> --- a/drivers/soc/qcom/trace-rpmh.h
> +++ b/drivers/soc/qcom/trace-rpmh.h
> @@ -38,14 +38,15 @@ TRACE_EVENT(rpmh_tx_done,
>  
>  TRACE_EVENT(rpmh_send_msg,
>  
> -	TP_PROTO(struct rsc_drv *d, int m, int n, u32 h,
> +	TP_PROTO(struct rsc_drv *d, int m, enum rpmh_state state, int n, u32 h,
>  		 const struct tcs_cmd *c),
>  
> -	TP_ARGS(d, m, n, h, c),
> +	TP_ARGS(d, m, state, n, h, c),
>  
>  	TP_STRUCT__entry(
>  			 __string(name, d->name)
>  			 __field(int, m)
> +			 __field(u32, state)
>  			 __field(int, n)
>  			 __field(u32, hdr)
>  			 __field(u32, addr)
> @@ -56,6 +57,7 @@ TRACE_EVENT(rpmh_send_msg,
>  	TP_fast_assign(
>  		       __assign_str(name, d->name);
>  		       __entry->m = m;
> +		       __entry->state = state;
>  		       __entry->n = n;
>  		       __entry->hdr = h;
>  		       __entry->addr = c->addr;
> @@ -63,8 +65,14 @@ TRACE_EVENT(rpmh_send_msg,
>  		       __entry->wait = c->wait;
>  	),
>  
> -	TP_printk("%s: send-msg: tcs(m): %d cmd(n): %d msgid: %#x addr: %#x data: %#x complete: %d",
> -		  __get_str(name), __entry->m, __entry->n, __entry->hdr,
> +	TP_printk("%s: tcs(m): %d [%s] cmd(n): %d msgid: %#x addr: %#x data: %#x complete: %d",
> +		  __get_str(name), __entry->m,
> +		  __print_symbolic(__entry->state,
> +				   { RPMH_SLEEP_STATE, "sleep" },
> +				   { RPMH_WAKE_ONLY_STATE, "wake" },
> +				   { RPMH_ACTIVE_ONLY_STATE, "active" }),
> +		  __entry->n,
> +		  __entry->hdr,
>  		  __entry->addr, __entry->data, __entry->wait)
>  );
>  
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்
