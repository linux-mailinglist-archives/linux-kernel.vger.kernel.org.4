Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19AAF6C3A8D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 20:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjCUTbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 15:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjCUTbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 15:31:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1F7567B2;
        Tue, 21 Mar 2023 12:31:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E23F8B8197F;
        Tue, 21 Mar 2023 19:30:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1DC5C433D2;
        Tue, 21 Mar 2023 19:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679427054;
        bh=4J6Qc0ELM8cEsY9i03YO4rNGi65qtpTyn5i1uQsxcCQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=INapG943gubolZaqrNT9yN1ZhD3yy6TjbGDpVUke1O2dbagGzE4OvAKItDxfsIP5L
         znLM/MFcxbJHeb2/2ouSS5DKLLhxzAmtZzgFyWzOz4Fx09iDcfKzwDr8nD/6doJvru
         BWZdZaE6Hh7LkN0HB+u/3e3wFg803O4npbtx+szXEf2Zgl/yM6IO5HkzgZGmqEgX0a
         h+cZ69QMl+7i23o1CWukXhcJzGO5Fwa0BN2akytTx+o1cSZuPLBsXAeGD+2pbl6yk3
         eoT8bH01zwUCWPJpTgcNT7XVh78JOAkxjq6Dok0nesE12K1DjkZ6v+NOyE62xCe/rw
         68V8knbK19W8A==
Message-ID: <783081e3-d78b-bf9c-cef4-af2df6888a72@kernel.org>
Date:   Tue, 21 Mar 2023 21:30:48 +0200
MIME-Version: 1.0
Subject: Re: [RFC PATCH] interconnect: qcom: icc-rpm: Don't call
 __qcom_icc_set twice on the same node
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230303023500.2173137-1-konrad.dybcio@linaro.org>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20230303023500.2173137-1-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3.03.23 4:35, Konrad Dybcio wrote:
> Currently, when sync_state calls set(n, n) all the paths for setting
> parameters on an icc node are called twice. Avoid that.

This could be optimized indeed.

> Fixes: 751f4d14cdb4 ("interconnect: icc-rpm: Set destination bandwidth as well as source bandwidth")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> RFC comes from the fact that I *believe* this should be correct, but I'm
> not entirely sure about it..
> 
> 
>   drivers/interconnect/qcom/icc-rpm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
> index a6e0de03f46b..d35db1af9b08 100644
> --- a/drivers/interconnect/qcom/icc-rpm.c
> +++ b/drivers/interconnect/qcom/icc-rpm.c
> @@ -387,7 +387,7 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
>   	ret = __qcom_icc_set(src, src_qn, sum_bw);
>   	if (ret)
>   		return ret;
> -	if (dst_qn) {
> +	if (dst_qn && src_qn != dst_qn) {
>   		ret = __qcom_icc_set(dst, dst_qn, sum_bw);
>   		if (ret)
>   			return ret;

Today we also call provider->set(node, node) in icc_node_add() to set
the initial bandwidth when nodes are being added to the topology. The
above change will affect that as well.

BR,
Georgi
