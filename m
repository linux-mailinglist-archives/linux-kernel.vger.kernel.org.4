Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276A5643793
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 23:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbiLEWBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 17:01:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbiLEWBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 17:01:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD189388;
        Mon,  5 Dec 2022 14:01:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B4C26144D;
        Mon,  5 Dec 2022 22:01:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F95C433C1;
        Mon,  5 Dec 2022 22:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670277662;
        bh=ft+sTE0mE8t3iZHmaktOo2bqKVFMds11iKVynOJ6Y6I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DMDSMNNsku4wmMi56cdErZdDCXO8lNdgxRNdkvFrudoPSaI80S2chbc8HLsq37rh/
         mka7WwzSFMYh2csr61wAshRQ4lUn9hxqFQJ/TwCboq+JnbiqdxpwQYv794QgI0uwfo
         0ZCiu6zd524YRPbUINHJZ8Zo78WjT5/kV5ZH3NYrR9NAyoakJqPhXX3rsh1oC2iWyM
         EuIPNwhFbRKuEOdrzYMuJbL3NhSTAeye1PVrK8a0BM4Ix0Uzjwz1fC552swq8zZ1HZ
         3BGj0u+rErlF+4EDasajwSA1K/ibLsCgiCzVqtFrBQgpkBt9koMp4iha02H6ZG6wZb
         ftPS5dKVatqCQ==
Date:   Mon, 5 Dec 2022 16:01:00 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     ye.xingchen@zte.com.cn
Cc:     agross@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-next] soc: qcom: smem_state: Use
 device_match_of_node()
Message-ID: <20221205220100.a2omqdmhtw26i7qx@builder.lan>
References: <202211171548066327249@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202211171548066327249@zte.com.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 03:48:06PM +0800, ye.xingchen@zte.com.cn wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Replace the open-code with device_match_of_node().
> 
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  drivers/soc/qcom/smem_state.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/smem_state.c b/drivers/soc/qcom/smem_state.c
> index e848cc9a3cf8..a7844841a727 100644
> --- a/drivers/soc/qcom/smem_state.c
> +++ b/drivers/soc/qcom/smem_state.c
> @@ -63,7 +63,7 @@ static struct qcom_smem_state *of_node_to_state(struct device_node *np)
>  	mutex_lock(&list_lock);
> 
>  	list_for_each_entry(state, &smem_states, list) {
> -		if (state->of_node == np) {
> +		if (device_match_of_node(state, np)) {

I don't find this form easier to read, nor is state a struct device *...

Regards,
Bjorn

>  			kref_get(&state->refcount);
>  			goto unlock;
>  		}
> -- 
> 2.25.1
