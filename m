Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9CE072E737
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 17:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242901AbjFMP2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 11:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242809AbjFMP2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 11:28:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA9210E9;
        Tue, 13 Jun 2023 08:28:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 554D1637B9;
        Tue, 13 Jun 2023 15:28:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9A7C433F0;
        Tue, 13 Jun 2023 15:28:47 +0000 (UTC)
Date:   Tue, 13 Jun 2023 11:28:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
Cc:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        "Elliot Berman" <quic_eberman@quicinc.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>
Subject: Re: [PATCH v5 2/2] remoteproc: qcom: Add remoteproc tracing
Message-ID: <20230613112845.626670df@gandalf.local.home>
In-Reply-To: <12b533c73b8c6b039e90f20afef1c8dcd30b80de.1686606835.git.quic_gokukris@quicinc.com>
References: <cover.1686606835.git.quic_gokukris@quicinc.com>
        <12b533c73b8c6b039e90f20afef1c8dcd30b80de.1686606835.git.quic_gokukris@quicinc.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jun 2023 15:03:26 -0700
Gokul krishna Krishnakumar <quic_gokukris@quicinc.com> wrote:

> diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
> index d4dbb8d1d80c..f7cb31b94a60 100644
> --- a/drivers/remoteproc/remoteproc_internal.h
> +++ b/drivers/remoteproc/remoteproc_internal.h
> @@ -14,6 +14,7 @@
>  
>  #include <linux/irqreturn.h>
>  #include <linux/firmware.h>
> +#include <trace/events/remoteproc_tracepoints.h>
>  
>  struct rproc;
>  
> @@ -171,8 +172,13 @@ u64 rproc_get_boot_addr(struct rproc *rproc, const struct firmware *fw)
>  static inline
>  int rproc_load_segments(struct rproc *rproc, const struct firmware *fw)
>  {
> -	if (rproc->ops->load)
> -		return rproc->ops->load(rproc, fw);
> +	if (rproc->ops->load) {
> +		int ret;
> +
> +		ret = rproc->ops->load(rproc, fw);
> +		trace_rproc_load_segment_event(rproc, ret);
> +		return ret;
> +	}
>  
>  	return -EINVAL;
>  }

So, tracepoints in header files tend to cause problems due to the way they
are created. See the comment in include/linux/tracepoint-defs.h.

What you need to do is:

#include <linux/tracepoint-defs.h>

DECLARE_TRACEPOINT(rproc_load_segment_event);

extern void call_trace_rproc_load_segment_event(struct rproc *rproc, int ret);

static inline void test_trace_rproc_load_segment_event(struct rproc *rproc, int ret)
{
	if (trace_rproc_load_segment_event_enabled())
		call_trace_rproc_load_segment_event(rproc, ret);
}

After adding the above in the header. In the C file, add:

void call_trace_rproc_load_segment_event(struct rproc *rproc, int ret)
{
	trace_rproc_load_segment_event(rproc, ret);
}

-- Steve
