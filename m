Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003A66CAE37
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 21:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbjC0TKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 15:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC0TKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 15:10:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69423170A;
        Mon, 27 Mar 2023 12:09:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1BC52B818C4;
        Mon, 27 Mar 2023 19:09:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C28AC433EF;
        Mon, 27 Mar 2023 19:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679944196;
        bh=md2d2PPOqe1luXPAuVx3FdS34LUYmDoWYP3MNTkgt1w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i/u9quZXyxBAuvWcTmM1kYd7nwq341KWzTeEB9TErt1tmb2YA5pwR7EYqL88vIc8e
         RxFMumxUuU3cBQhuHzFg70H13RCkKJF+jzxUE9xJnTpGEVEK4O0E7j63wssG7FTEqo
         s2ayXeMDdmWOUT7v6/0SOD3n0cjfg4pgtpHXzod+h3g8XS3LhlJx302y8nIXvlmKsD
         FG6aIzRe7pg+ndJ69hphx0c8BbV80evoMkx0SsXEV9HyVVP3sBUpSm2IzPBadrixf0
         eSeToWJhDH5SRML6gClOwv8DzDVyhuqd5tukvtmcZItLO9yDbjOWo/Wi3YVqbpdums
         /8SSlaR/2sjwg==
Date:   Mon, 27 Mar 2023 12:09:54 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Abel Vesa <abel.vesa@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH v4 4/7] soc: qcom: Make the Qualcomm UFS/SDCC ICE a
 dedicated driver
Message-ID: <20230327190954.GE73752@sol.localdomain>
References: <20230327134734.3256974-1-abel.vesa@linaro.org>
 <20230327134734.3256974-5-abel.vesa@linaro.org>
 <20230327185358.c4emwquhouq42itf@ripper>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327185358.c4emwquhouq42itf@ripper>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 11:53:58AM -0700, Bjorn Andersson wrote:
> > +int qcom_ice_program_key(struct qcom_ice *ice,
> > +			 u8 algorithm_id, u8 key_size,
> > +			 const u8 crypto_key[], u8 data_unit_size,
> > +			 int slot)
> > +{
> > +	struct device *dev = ice->dev;
> > +	union {
> > +		u8 bytes[AES_256_XTS_KEY_SIZE];
> > +		u32 words[AES_256_XTS_KEY_SIZE / sizeof(u32)];
> > +	} key;
> > +	int i;
> > +	int err;
> > +
> > +	/* Only AES-256-XTS has been tested so far. */
> > +	if (algorithm_id != QCOM_ICE_CRYPTO_ALG_AES_XTS ||
> > +	    key_size != QCOM_ICE_CRYPTO_KEY_SIZE_256) {
> > +		dev_err_ratelimited(dev,
> > +				    "Unhandled crypto capability; algorithm_id=%d, key_size=%d\n",
> > +				    algorithm_id, key_size);
> > +		return -EINVAL;
> > +	}
> > +
> > +	memcpy(key.bytes, crypto_key, AES_256_XTS_KEY_SIZE);
> > +
> > +	/*
> > +	 * The SCM call byte-swaps the 32-bit words of the key.
> > +	 * So we have to do the same, in order for the final key be correct.
> 
> Does it actually byte swap the words, or is the API just specified to
> take the words in big endian format?

[Note, this is existing code I wrote that Abel is just moving to a new file.]

It doesn't write to the input array, if that is what you are asking.  I was
thinking of this as one byte swap cancelling out another.  But sure, the comment
could be simplified to something like the following:

	/* The SCM call requires that the key words be byte-swapped. */

> How come you memcpy + swap in place, instead of loop over the words and
> cpu_to_be32() them into a __be words[] array?
> 
> > +	 */
> > +	for (i = 0; i < ARRAY_SIZE(key.words); i++)
> > +		__cpu_to_be32s(&key.words[i]);

With this approach there is no need to worry about unaligned memory accesses.
It could be done with unaligned memory accesses, though, if you prefer that:

	union {
		[...]
		__be32 words[...];
	} key;

	[...]
		key.words[i] = cpu_to_be32(get_unaligned((__u32 *)crypto_key + i));

- Eric
