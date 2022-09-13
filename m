Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F0B5B7C05
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 22:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiIMULI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 16:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiIMULH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 16:11:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F30642D3;
        Tue, 13 Sep 2022 13:11:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E114B61585;
        Tue, 13 Sep 2022 20:11:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70EEEC433D6;
        Tue, 13 Sep 2022 20:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663099865;
        bh=4+HGjp25/cN2z21/49nNWSVIRVlNUxdlMA9fDjagpzw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MmmWGxWOh91Qvorm6crbMaDED/E6pwg9MJXGkmKnBVe0Q6DkfBMStUAMjl0nMuqFc
         lacaMubCGeElgsMLia23xkFVUqqC+yqTLsI1aj5Kqi1jG2znDk29BJitQMA51BLHPD
         AKuWv7+vAeLd/N7VJEMSGHMcS9sNz325cYXDiqY4hI00z62jLY9SFz61GUcAgift3o
         Sr8Bk4/rrywPwIui3Me/clCh/lowVBH/pZ6Fkq+4o/zgDlDUnzFypZrSbN9sESvdm9
         Hyy5eeKChEFdrCz9lfTebap9Paj/c/gQe86NkaUsQx2rp9DHXqV/sRsWJ6RXf/2HKG
         SCI9ZDZ1TgyRg==
Date:   Tue, 13 Sep 2022 15:11:02 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>
Subject: Re: [PATCH v1 2/2] soc: qcom: mdt_loader: Move the memory allocation
 into mdt loader
Message-ID: <20220913201102.mjmtvsx5xyfcr5cw@builder.lan>
References: <cover.1663007783.git.quic_gokukris@quicinc.com>
 <2ba262668e86e58acb086c64fc759ba02b39a525.1663007783.git.quic_gokukris@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ba262668e86e58acb086c64fc759ba02b39a525.1663007783.git.quic_gokukris@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 11:41:32AM -0700, Gokul krishna Krishnakumar wrote:
> By moving the memory allocation to mdt loader we can simplify the scm
> call, by just packing arguments provided to it from the clients for
> making secuer world calls. We can also simplify the memory allocation
> for the qcom metadata, by just doing one memory allocation in the
> mdt loader.
> 
> Signed-off-by: Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
> ---
>  drivers/remoteproc/qcom_q6v5_mss.c  |  2 +-
>  drivers/soc/qcom/mdt_loader.c       | 41 ++++++++++++++++++++++++++++---------
>  include/linux/soc/qcom/mdt_loader.h |  5 +++--
>  3 files changed, 35 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
> index fddb63c..1919bfc 100644
> --- a/drivers/remoteproc/qcom_q6v5_mss.c
> +++ b/drivers/remoteproc/qcom_q6v5_mss.c
> @@ -947,7 +947,7 @@ static int q6v5_mpss_init_image(struct q6v5 *qproc, const struct firmware *fw,
>  	int ret;
>  	int i;
>  
> -	metadata = qcom_mdt_read_metadata(fw, &size, fw_name, qproc->dev);
> +	metadata = qcom_mdt_read_metadata(fw, &size, fw_name, qproc->dev, NULL);

At the end of this function we invoke kfree(metadata), which would be
bad if that comes from dma_alloc_coherent().

>  	if (IS_ERR(metadata))
>  		return PTR_ERR(metadata);
>  
> diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
[..]
> @@ -160,9 +164,18 @@ void *qcom_mdt_read_metadata(const struct firmware *fw, size_t *data_len,
>  	ehdr_size = phdrs[0].p_filesz;
>  	hash_size = phdrs[hash_segment].p_filesz;
>  
> -	data = kmalloc(ehdr_size + hash_size, GFP_KERNEL);
> -	if (!data)
> -		return ERR_PTR(-ENOMEM);
> +	/*
> +	 * During the scm call memory protection will be enabled for the meta
> +	 * data blob, so make sure it's physically contiguous, 4K aligned and
> +	 * non-cachable to avoid XPU violations.
> +	 */
> +	scm_dev = qcom_get_scm_device();

As LKP points out, I don't seem to have this function.

> +	data = dma_alloc_coherent(scm_dev, ehdr_size + hash_size, mdata_phys,
> +				       GFP_KERNEL);

I am not thrilled about the idea of doing dma_alloc_coherent() in this
file and dma_free_coherent() in the scm driver. Similarly, I consider
these functions to operate in the context of the caller, so operating on
the scm device's struct device isn't so nice.


After trying various models I came to the conclusion that it was better
to try to keep the MDT loader to just load MDT files, and move the
SCM/PAS interaction out of that. Unfortunately we have a number of
client drivers that would then need to (essentially) duplicate the
content of qcom_mdt_pas_init() - so I left that in there.

I still believe that keeping the MDT loader focused on loading MDTs is a
good idea, but I'm open to any suggestions for improvements in the
interaction between these different components.

Regards,
Bjorn
