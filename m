Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D007A5B88ED
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 15:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiINNPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 09:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiINNPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 09:15:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663EF558C2;
        Wed, 14 Sep 2022 06:15:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38B2261D05;
        Wed, 14 Sep 2022 13:15:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66B99C433D7;
        Wed, 14 Sep 2022 13:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663161316;
        bh=LC/yaD2w8sEiDYhcM6gqXvtnA5PdZMjHegWYyYGmmwY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ojozldpLrFaLrBJaXV3hDNPauxhrZSeQtHYIWs+cWinfMJk8fxnVe3ESfAHk6Eu7p
         elAYJ5vyc5+OQzwdG4k0HGURSPYvJ7pquvUT9LRbUHUHhTj3MwwdUYjE+f/5MdyYIf
         dPJZpp+1ULEcgj8VUJXu+D1oIBEGeqeQbCswr1zmepnKvEyTRS+NrpcHXGdrZhaIhs
         k/7YrI9jrKrSmLICCPumwcJj1ksY9KgPweiaJ/XWm+burfnHM3xvZ8VFNuV2ORvHvm
         Xbp1XrR41xJDSqklg0Tv+bEPTOHvvga4dTHFsy+ve0SQbLi775aFhZ2nz0OpP1WLGT
         M5buLuMiBS9jA==
Message-ID: <b55bbba1-16ed-dbac-05e9-25ea4661efab@kernel.org>
Date:   Wed, 14 Sep 2022 16:15:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 6/6] soc: ti: pruss: Add helper functions to get/set
 PRUSS_CFG_GPMUX
Content-Language: en-US
To:     Romain Naour <romain.naour@smile.fr>, linux-kernel@vger.kernel.org,
        Md Danish Anwar <danishanwar@ti.com>
Cc:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        nm@ti.com, ssantosh@kernel.org, s-anna@ti.com,
        linux-arm-kernel@lists.infradead.org, grygorii.strashko@ti.com,
        vigneshr@ti.com, kishon@ti.com
References: <20220418123004.9332-1-p-mohan@ti.com>
 <20220418123004.9332-7-p-mohan@ti.com>
 <94b57cbc-b865-e0b4-0d52-3da72f2dd026@smile.fr>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <94b57cbc-b865-e0b4-0d52-3da72f2dd026@smile.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Romain,

On 12/09/2022 17:20, Romain Naour wrote:
> +Danish
> 
> Hi Danish,
> 
> (Removed Puranjay (as he is no longer with TI) and adding Danish.)
> 
> Le 18/04/2022 à 14:30, Puranjay Mohan a écrit :
>> From: Tero Kristo <t-kristo@ti.com>
>>
>> Add two new helper functions pruss_cfg_get_gpmux() & pruss_cfg_set_gpmux()
>> to get and set the GP MUX mode for programming the PRUSS internal wrapper
>> mux functionality as needed by usecases.
> 
> Actually I'm curious about how the GP MUX mode are supposed to work in some
> cases. The register mapping in the AM57xx TRM seems confusing.
> 
> See the "PRU-ICSS I/O Interface" part about the "PRU-ICSS Internal Wrapper
> Multiplexing" [1].
> 
> The commit "ARM: dts: am57xx-idk: Add prueth on ICSS" [2] (only in the
> TI kernel tree) adds pruss1 and pruss2 for the am571x-idk board.
> 
> But this commit doesn't really explain the ti,pruss-gp-mux-sel setting
> from pruss1_eth and pruss2_eth:
> 
>     /* Dual mac ethernet application node on icss1 */
>     pruss1_eth {
>     	status = "okay";
>     	compatible = "ti,am57-prueth";
> 
>     	ti,pruss-gp-mux-sel = <0>,	/* GP, default */
>     			      <4>;	/* MII2, needed for PRUSS1_MII1 */
>     }
> 
>     &pruss2_eth {
>     	ti,pruss-gp-mux-sel = <4>,	/* MII2, needed for PRUSS1_MII0 */
>     			      <4>;	/* MII2, needed for PRUSS1_MII1 */
>     };
> 
> At the first look, the two comments in pruss2_eth node about PRUSS1_MIIx seems
> dubious. Indeed, it would means that the PRUSS2 setting (ti,pruss-gp-mux-sel) is
> required to makes PRUSS1 work.

Yes, if I remember right this is only applicable to AM571 Soc which had
an overloaded pinmuxing design and it resulted in this kind of weird constraint.
i.e. gp-mux-sel of PRUSS2 needs to be set to get PRUSS1 MII to work.

> 
> In my use case, only the pruss1 is expected to be used with the prueth driver.
> 
> Actually, the prueth on PRUSS1 partially works with only pruss1_eth's gp-mux
> initialized:
> 
>     pruss1_eth {
>             status = "okay";
>             compatible = "ti,am57-prueth";
> 
>             ti,pruss-gp-mux-sel = <0>,      /* GP, default */
>                                   <4>;      /* MII2, needed for PRUSS1_MII1 */
>     }
> 
>     pruss2_eth {
>             status = "disabled";
>     }
> 
> (Tests done with the ti-linux-kernel 5.10.y)
> 
> On wireshark I noticed ethernet frames (ping) sent from the board but the reply
> from the remote PC is never received on the board.
> 
> It really seems we need pruss2_eth's gp-mux initialized.
> The problem here is that I don't want to enable PRUSS2 just to
> configure pruss2_eth's gp-mux for the sake of pruss1.
> 
> I had to write manually (using devmem2) the "good" value (0x10002003) in
> PRUSS2_CFG0 and PRUSS2_CFG1 to configure entirely the PRUSS1_MII1.
> 
> I'm not sure how the driver should handle this register mapping properly.
> 
> [1] https://www.ti.com/lit/ds/symlink/am5749.pdf
> 
> [2]
> https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/commit/?h=linux-5.10.y&id=2a3b089f5697fe2f9a9875b2fba1bef88d196a53
> 
> Best regards,
> Romain

cheers,
-roger

> 
>>
>> Co-developed-by: Suman Anna <s-anna@ti.com>
>> Signed-off-by: Suman Anna <s-anna@ti.com>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> Co-developed-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
>> Signed-off-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
>> Signed-off-by: Puranjay Mohan <p-mohan@ti.com>
>> ---
>>  include/linux/pruss_driver.h | 44 ++++++++++++++++++++++++++++++++++++
>>  1 file changed, 44 insertions(+)
>>
>> diff --git a/include/linux/pruss_driver.h b/include/linux/pruss_driver.h
>> index e2d5477225c6..3312281ef4c1 100644
>> --- a/include/linux/pruss_driver.h
>> +++ b/include/linux/pruss_driver.h
>> @@ -35,4 +35,48 @@ struct pruss {
>>  	struct clk *iep_clk_mux;
>>  };
>>  
>> +/**
>> + * pruss_cfg_get_gpmux() - get the current GPMUX value for a PRU device
>> + * @pruss: pruss instance
>> + * @pru_id: PRU identifier (0-1)
>> + * @mux: pointer to store the current mux value into
>> + *
>> + * Return: 0 on success, or an error code otherwise
>> + */
>> +static inline int pruss_cfg_get_gpmux(struct pruss *pruss,
>> +				      enum pruss_pru_id pru_id, u8 *mux)
>> +{
>> +	int ret = 0;
>> +	u32 val;
>> +
>> +	if (pru_id < 0 || pru_id >= PRUSS_NUM_PRUS)
>> +		return -EINVAL;
>> +
>> +	ret = pruss_cfg_read(pruss, PRUSS_CFG_GPCFG(pru_id), &val);
>> +	if (!ret)
>> +		*mux = (u8)((val & PRUSS_GPCFG_PRU_MUX_SEL_MASK) >>
>> +			    PRUSS_GPCFG_PRU_MUX_SEL_SHIFT);
>> +	return ret;
>> +}
>> +
>> +/**
>> + * pruss_cfg_set_gpmux() - set the GPMUX value for a PRU device
>> + * @pruss: pruss instance
>> + * @pru_id: PRU identifier (0-1)
>> + * @mux: new mux value for PRU
>> + *
>> + * Return: 0 on success, or an error code otherwise
>> + */
>> +static inline int pruss_cfg_set_gpmux(struct pruss *pruss,
>> +				      enum pruss_pru_id pru_id, u8 mux)
>> +{
>> +	if (mux >= PRUSS_GP_MUX_SEL_MAX ||
>> +	    pru_id < 0 || pru_id >= PRUSS_NUM_PRUS)
>> +		return -EINVAL;
>> +
>> +	return pruss_cfg_update(pruss, PRUSS_CFG_GPCFG(pru_id),
>> +				PRUSS_GPCFG_PRU_MUX_SEL_MASK,
>> +				(u32)mux << PRUSS_GPCFG_PRU_MUX_SEL_SHIFT);
>> +}
>> +
>>  #endif	/* _PRUSS_DRIVER_H_ */
> 
