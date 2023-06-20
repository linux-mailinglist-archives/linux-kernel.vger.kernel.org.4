Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A6573767F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 23:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjFTVQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 17:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjFTVQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 17:16:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F99199A;
        Tue, 20 Jun 2023 14:16:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F28C0611D0;
        Tue, 20 Jun 2023 21:16:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF043C433C8;
        Tue, 20 Jun 2023 21:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687295806;
        bh=A5Y/72mBDdgAgnIVAwfA+6xazlifvq+zXHIhV/XW1V8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e4siexhirfw8Vd/9j0rkbvjX+KyYd0vRq4qWiqm9Eoka4gpb0ABVkeUaCAH/7rfgR
         BHxCCLg7qfHVQ4+iD6r45fUZDzX0OLOP6vo1gSYVlrIW/flPH+NBtPyPajvW9MUUva
         Z4gYzVk93Ey0x+c4VyDvBpsbIsfSDnglP/egcxPvobVGW9LOq3zKv9fMSTjQeucrxH
         elVX/gjSRlOHqB5Xo//MFnpVKLy/gygvZaVQzJ+/bz1o7tNwvCNygmlURGuML9fmtA
         u1T4gFOj5nsQiRA98w1bl520M3CRXVfmB1lHQauTJcwFaVzwdAaJj3NvIsMVREMpUg
         TjF7F7cDQB/zw==
Date:   Tue, 20 Jun 2023 15:17:41 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     M Chetan Kumar <m.chetan.kumar@intel.com>,
        Florian Klink <flokli@flokli.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Intel Corporation <linuxwwan@intel.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: wwan: iosm: Convert single instance struct member
 to flexible array
Message-ID: <ZJIXdfbEVfLliPov@work>
References: <20230620194234.never.023-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620194234.never.023-kees@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 12:42:38PM -0700, Kees Cook wrote:
> struct mux_adth actually ends with multiple struct mux_adth_dg members.
> This is seen both in the comments about the member:
> 
> /**
>  * struct mux_adth - Structure of the Aggregated Datagram Table Header.
>  ...
>  * @dg:		datagramm table with variable length
>  */
> 
> and in the preparation for populating it:
> 
>                         adth_dg_size = offsetof(struct mux_adth, dg) +
>                                         ul_adb->dg_count[i] * sizeof(*dg);
> 			...
>                         adth_dg_size -= offsetof(struct mux_adth, dg);
>                         memcpy(&adth->dg, ul_adb->dg[i], adth_dg_size);
> 
> This was reported as a run-time false positive warning:
> 
> memcpy: detected field-spanning write (size 16) of single field "&adth->dg" at drivers/net/wwan/iosm/iosm_ipc_mux_codec.c:852 (size 8)
> 
> Adjust the struct mux_adth definition and associated sizeof() math; no binary
> output differences are observed in the resulting object file.
> 
> Reported-by: Florian Klink <flokli@flokli.de>
> Closes: https://lore.kernel.org/lkml/dbfa25f5-64c8-5574-4f5d-0151ba95d232@gmail.com/
> Fixes: 1f52d7b62285 ("net: wwan: iosm: Enable M.2 7360 WWAN card support")
> Cc: M Chetan Kumar <m.chetan.kumar@intel.com>
> Cc: Bagas Sanjaya <bagasdotme@gmail.com>
> Cc: Intel Corporation <linuxwwan@intel.com>
> Cc: Loic Poulain <loic.poulain@linaro.org>
> Cc: Sergey Ryazanov <ryazanov.s.a@gmail.com>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: netdev@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thank god they used offsetof(struct mux_adth, dg) everywhere. :P

--
Gustavo

> ---
>  drivers/net/wwan/iosm/iosm_ipc_mux_codec.c | 15 ++++++---------
>  drivers/net/wwan/iosm/iosm_ipc_mux_codec.h |  2 +-
>  2 files changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c b/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
> index d6b166fc5c0e..bff46f7ca59f 100644
> --- a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
> +++ b/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
> @@ -626,14 +626,12 @@ static void mux_dl_adb_decode(struct iosm_mux *ipc_mux,
>  		if (adth->signature != cpu_to_le32(IOSM_AGGR_MUX_SIG_ADTH))
>  			goto adb_decode_err;
>  
> -		if (le16_to_cpu(adth->table_length) < (sizeof(struct mux_adth) -
> -				sizeof(struct mux_adth_dg)))
> +		if (le16_to_cpu(adth->table_length) < sizeof(struct mux_adth))
>  			goto adb_decode_err;
>  
>  		/* Calculate the number of datagrams. */
>  		nr_of_dg = (le16_to_cpu(adth->table_length) -
> -					sizeof(struct mux_adth) +
> -					sizeof(struct mux_adth_dg)) /
> +					sizeof(struct mux_adth)) /
>  					sizeof(struct mux_adth_dg);
>  
>  		/* Is the datagram table empty ? */
> @@ -649,7 +647,7 @@ static void mux_dl_adb_decode(struct iosm_mux *ipc_mux,
>  		}
>  
>  		/* New aggregated datagram table. */
> -		dg = &adth->dg;
> +		dg = adth->dg;
>  		if (mux_dl_process_dg(ipc_mux, adbh, dg, skb, if_id,
>  				      nr_of_dg) < 0)
>  			goto adb_decode_err;
> @@ -849,7 +847,7 @@ static void ipc_mux_ul_encode_adth(struct iosm_mux *ipc_mux,
>  			adth->if_id = i;
>  			adth->table_length = cpu_to_le16(adth_dg_size);
>  			adth_dg_size -= offsetof(struct mux_adth, dg);
> -			memcpy(&adth->dg, ul_adb->dg[i], adth_dg_size);
> +			memcpy(adth->dg, ul_adb->dg[i], adth_dg_size);
>  			ul_adb->if_cnt++;
>  		}
>  
> @@ -1426,14 +1424,13 @@ static int ipc_mux_get_payload_from_adb(struct iosm_mux *ipc_mux,
>  
>  		if (adth->signature == cpu_to_le32(IOSM_AGGR_MUX_SIG_ADTH)) {
>  			nr_of_dg = (le16_to_cpu(adth->table_length) -
> -					sizeof(struct mux_adth) +
> -					sizeof(struct mux_adth_dg)) /
> +					sizeof(struct mux_adth)) /
>  					sizeof(struct mux_adth_dg);
>  
>  			if (nr_of_dg <= 0)
>  				return payload_size;
>  
> -			dg = &adth->dg;
> +			dg = adth->dg;
>  
>  			for (i = 0; i < nr_of_dg; i++, dg++) {
>  				if (le32_to_cpu(dg->datagram_index) <
> diff --git a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.h b/drivers/net/wwan/iosm/iosm_ipc_mux_codec.h
> index 5d4e3b89542c..f8df88f816c4 100644
> --- a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.h
> +++ b/drivers/net/wwan/iosm/iosm_ipc_mux_codec.h
> @@ -161,7 +161,7 @@ struct mux_adth {
>  	u8 opt_ipv4v6;
>  	__le32 next_table_index;
>  	__le32 reserved2;
> -	struct mux_adth_dg dg;
> +	struct mux_adth_dg dg[];
>  };
>  
>  /**
> -- 
> 2.34.1
> 
