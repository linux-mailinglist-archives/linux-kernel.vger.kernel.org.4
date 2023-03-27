Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA896CAE81
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 21:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjC0TYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 15:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjC0TYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 15:24:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9F9CD;
        Mon, 27 Mar 2023 12:24:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE46C6147A;
        Mon, 27 Mar 2023 19:24:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94616C433EF;
        Mon, 27 Mar 2023 19:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679945040;
        bh=iujBnATPdseZ2OyDbUQdNGaFQkW0LiQ28bu7WznPQQc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S8HupFN2ydPYE0W7hyZpOHT9iHChgB2KA0DLs1Glti21Pfff1QyFCgp1gmaCAFRcr
         CkByPMdUjBGkOVyXDxkaa77lWPhlt0U5jfdinFnOCCpV2ikccWqU+5ELj/SsGNE1IM
         c7KF3o8yZUsB9BxgLBJV1qtq0/boxa0b9PMBEtPQl9YtZmIiJPsSoSySTgmw6WeRh4
         amys3xKJVaCnEYA2qZ0D0vLKNyfvcKceog76ZPjfHFyiU0I9bT5EJ9HrxffrCejRxw
         ad/g6bBKOKzTO6tmUClJkzBrz64F6epSP28/NtmeUhP6fwp6Aa21LfCN1jff55xQfA
         yElep5IED3pOg==
Date:   Mon, 27 Mar 2023 12:27:04 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
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
Message-ID: <20230327192704.ywczpr2otbwxnsh5@ripper>
References: <20230327134734.3256974-1-abel.vesa@linaro.org>
 <20230327134734.3256974-5-abel.vesa@linaro.org>
 <20230327185358.c4emwquhouq42itf@ripper>
 <20230327190954.GE73752@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327190954.GE73752@sol.localdomain>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 12:09:54PM -0700, Eric Biggers wrote:
> On Mon, Mar 27, 2023 at 11:53:58AM -0700, Bjorn Andersson wrote:
> > > +int qcom_ice_program_key(struct qcom_ice *ice,
> > > +			 u8 algorithm_id, u8 key_size,
> > > +			 const u8 crypto_key[], u8 data_unit_size,
> > > +			 int slot)
> > > +{
> > > +	struct device *dev = ice->dev;
> > > +	union {
> > > +		u8 bytes[AES_256_XTS_KEY_SIZE];
> > > +		u32 words[AES_256_XTS_KEY_SIZE / sizeof(u32)];
> > > +	} key;
> > > +	int i;
> > > +	int err;
> > > +
> > > +	/* Only AES-256-XTS has been tested so far. */
> > > +	if (algorithm_id != QCOM_ICE_CRYPTO_ALG_AES_XTS ||
> > > +	    key_size != QCOM_ICE_CRYPTO_KEY_SIZE_256) {
> > > +		dev_err_ratelimited(dev,
> > > +				    "Unhandled crypto capability; algorithm_id=%d, key_size=%d\n",
> > > +				    algorithm_id, key_size);
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	memcpy(key.bytes, crypto_key, AES_256_XTS_KEY_SIZE);
> > > +
> > > +	/*
> > > +	 * The SCM call byte-swaps the 32-bit words of the key.
> > > +	 * So we have to do the same, in order for the final key be correct.
> > 
> > Does it actually byte swap the words, or is the API just specified to
> > take the words in big endian format?
> 
> [Note, this is existing code I wrote that Abel is just moving to a new file.]
> 

Ah right, then I'm inclined to keep it untouched.

> It doesn't write to the input array, if that is what you are asking.  I was
> thinking of this as one byte swap cancelling out another.  But sure, the comment
> could be simplified to something like the following:
> 
> 	/* The SCM call requires that the key words be byte-swapped. */
> 

Last time I looked at a crypto driver, it was full of "switch the
endian" operations, back and forth. So my request here was simply to
make it clear which endian is actually expected.
So I'm guessing the appropriate comment is:

	/* The SCM call requires that the key words are encoded in big endian */

> > How come you memcpy + swap in place, instead of loop over the words and
> > cpu_to_be32() them into a __be words[] array?
> > 
> > > +	 */
> > > +	for (i = 0; i < ARRAY_SIZE(key.words); i++)
> > > +		__cpu_to_be32s(&key.words[i]);
> 
> With this approach there is no need to worry about unaligned memory accesses.

That's a valid reason that I was looking for. Wouldn't this be a common
problem, something other parts of the stack would like to avoid?
Or it's just a byte array until we get here?

> It could be done with unaligned memory accesses, though, if you prefer that:
> 

No need to jump through the hoops, but a comment would have saved
(robbed?) me from wondering.

Regards,
Bjorn

> 	union {
> 		[...]
> 		__be32 words[...];
> 	} key;
> 
> 	[...]
> 		key.words[i] = cpu_to_be32(get_unaligned((__u32 *)crypto_key + i));
> 
> - Eric
