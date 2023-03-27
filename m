Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5096CAF7F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 22:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjC0UNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 16:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjC0UNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 16:13:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B79B1BDF;
        Mon, 27 Mar 2023 13:12:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F6C6614E2;
        Mon, 27 Mar 2023 20:12:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21EF9C433EF;
        Mon, 27 Mar 2023 20:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679947978;
        bh=ztuneWnacYJNX61OcSRLH6dtkEQaVL91CZmSDSc+HvA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BGKc7m3TJ1K2Ad+LniE+5DTg+auW75CPse6loLp5HVcL/vZvqbDF9t19XyobR6gzU
         qE8zqtxoQgi8BOnBQOIYzGcrBan8AgDwAY1AGcKU6dAzqu+Bg99o5POZl8tv0yAJgu
         G2uzAInEbtj7GrgHfQpKpRWEAV19EvxCo7lt0es5RKzByzgJ7/pkdAAxOqn+sLzqOa
         dG20RD9sOICkaRFYrBWzyz63wDiXXdcv9ELvhHVpWi+lOJ4rPzAo7nwhSK323biZMb
         gzjV4Yn13exs+q6DU+ir1A6ToP2zFU6cHj8v5MbWwMF46mS4Fbx3WBsR6hNO7anLBX
         pAcJw7Ano5gEA==
Date:   Mon, 27 Mar 2023 20:12:56 +0000
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
Message-ID: <ZCH4yE9nmj/3e1Vx@gmail.com>
References: <20230327134734.3256974-1-abel.vesa@linaro.org>
 <20230327134734.3256974-5-abel.vesa@linaro.org>
 <20230327185358.c4emwquhouq42itf@ripper>
 <20230327190954.GE73752@sol.localdomain>
 <20230327192704.ywczpr2otbwxnsh5@ripper>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327192704.ywczpr2otbwxnsh5@ripper>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 12:27:04PM -0700, Bjorn Andersson wrote:
> 
> That's a valid reason that I was looking for. Wouldn't this be a common
> problem, something other parts of the stack would like to avoid?
> Or it's just a byte array until we get here?
> 
> > It could be done with unaligned memory accesses, though, if you prefer that:
> > 
> 
> No need to jump through the hoops, but a comment would have saved
> (robbed?) me from wondering.

The parameter to qcom_ice_program_key() is 'const u8 crypto_key[]', which has no
inherent alignment in the type.  It might be that the callers currently only
pass 4-byte aligned buffers, but I don't think that should be relied on here.

- Eric
