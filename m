Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E78B65ACF5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 04:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjABDSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 22:18:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjABDSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 22:18:35 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6FF21BD
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 19:18:33 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id g16so18695288plq.12
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jan 2023 19:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vZvyGK6DxthGUsLi298pua96YvrjAlkyByXaysjEekY=;
        b=cmP6xJtkIhwQCGVKmCN7/xe+AvuuQgBdohmEnkVX+CVpTHLSR8dTK+JQUhhcXtpLJU
         AEn0zFdcJkcqb4sNjcnG8NibcBdmP8bO+j3hSaCZ4n1e2dkGVRabIqOK1vIG3mFXfey6
         xEakNadOxxIXiFplCpYQgxzkCK7RFA02Bv2ycqBbRRGJeKH/OV0Mwg+K4VztgRj7rg0e
         PbuEPtbNDqXpKbn8MZSNLoavsMXTqepweoq6QSd9evwACglxdbWRUG7hNy5XtY9KnZcE
         F2wZdxnq/Pow9BDLjsBjKfg+sWl7lgRSpoOEOdGy1QpHDK2gcmE/mBifXtL/E/7WDZl4
         om9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vZvyGK6DxthGUsLi298pua96YvrjAlkyByXaysjEekY=;
        b=33QhWJvTInF83L12SlW2m5Stn3Wasmx5ykDy57Pl8ZouyS11AGgAlMHtyK54DjuIF5
         EG/apFVDSQ1JKnJT7YnEhhGnlmG2HgjUeu544LgmiR4JPkydnECL49Ig8mAL3nwQ6tG2
         yio5KB30my5ODRMxHg5Ptp2PSkzN7/l1BI0b3i1Drc0VhMteBFjwmjavSqroLCSFWg59
         pFzMSF31rnp2ZvpJsYahwn+mPrgSSf4sfGLLnDvu3bj5HRfI1Dpy+5SKADSadcGIz2FD
         Sy+KGHxsXxzlzSZOniG+1A8ulcLPEj4zhwfehPB5INHV87qiMLirfsbu5pE5B2/0iQkY
         p8qg==
X-Gm-Message-State: AFqh2krMVb1GBaOUngudVDub7OtPW+2ePUSHjOcNUFHQLDFe2r2R92Fh
        8k2jZOZwRB1lCdirbltBjbQskA==
X-Google-Smtp-Source: AMrXdXvPj8o6cK4T3w01Iw3SMa2JT66hdZ4VXWgIspXrvpNrRkrS7ttzQdxzW3nbzDECQOX/gYTa4A==
X-Received: by 2002:a05:6a20:7f59:b0:ac:af5c:2970 with SMTP id e25-20020a056a207f5900b000acaf5c2970mr2514437pzk.3.1672629512652;
        Sun, 01 Jan 2023 19:18:32 -0800 (PST)
Received: from [2620:15c:29:203:20a4:1331:a6b6:c59b] ([2620:15c:29:203:20a4:1331:a6b6:c59b])
        by smtp.gmail.com with ESMTPSA id 72-20020a63064b000000b00477602ff6a8sm15928374pgg.94.2023.01.01.19.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jan 2023 19:18:31 -0800 (PST)
Date:   Sun, 1 Jan 2023 19:18:30 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Jarkko Sakkinen <jarkko@profian.com>
cc:     linux-crypto@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: ccp: Improve sev_platform_init() error
 messages
In-Reply-To: <20221231151106.143121-1-jarkko@profian.com>
Message-ID: <6a16bbe4-4281-fb28-78c4-4ec44c8aa679@google.com>
References: <20221231151106.143121-1-jarkko@profian.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Dec 2022, Jarkko Sakkinen wrote:

> The following functions end up calling sev_platform_init() or
> __sev_platform_init_locked():
> 
> * sev_guest_init()
> * sev_ioctl_do_pek_csr
> * sev_ioctl_do_pdh_export()
> * sev_ioctl_do_pek_import()
> * sev_ioctl_do_pek_pdh_gen()
> * sev_pci_init()
> 
> However, only sev_pci_init() prints out the failed command error code, and
> even there the error message does not specify, SEV which command failed.
> 
> Address this by printing out the SEV command errors inside
> __sev_platform_init_locked(), and differentiate between DF_FLUSH, INIT and
> INIT_EX commands.
> 
> This extra information is particularly useful if firmware loading and/or
> initialization is going to be made more robust, e.g. by allowing
> firmware loading to be postponed.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko@profian.com>
> ---
>  drivers/crypto/ccp/sev-dev.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
> index 5350eacaba3a..ac7385c12091 100644
> --- a/drivers/crypto/ccp/sev-dev.c
> +++ b/drivers/crypto/ccp/sev-dev.c
> @@ -963,6 +963,7 @@ static int __sev_init_ex_locked(int *error)
>  
>  static int __sev_platform_init_locked(int *error)
>  {
> +	const char *cmd = sev_init_ex_buffer ? "SEV_CMD_INIT_EX" : "SEV_CMD_INIT";
>  	struct psp_device *psp = psp_master;
>  	struct sev_device *sev;
>  	int rc = 0, psp_ret = -1;

I think this can just be handled directly in the dev_err() since it's only 
used once.

> @@ -1008,18 +1009,23 @@ static int __sev_platform_init_locked(int *error)
>  	if (error)
>  		*error = psp_ret;
>  
> -	if (rc)
> +	if (rc) {
> +		dev_err(sev->dev, "SEV: %s failed error %#x", cmd, psp_ret);
>  		return rc;
> +	}
>  
>  	sev->state = SEV_STATE_INIT;
>  
>  	/* Prepare for first SEV guest launch after INIT */
>  	wbinvd_on_all_cpus();
> -	rc = __sev_do_cmd_locked(SEV_CMD_DF_FLUSH, NULL, error);
> -	if (rc)
> -		return rc;
> +	rc = __sev_do_cmd_locked(SEV_CMD_DF_FLUSH, NULL, &psp_ret);
> +	if (error)
> +		*error = psp_ret;
>  
> -	dev_dbg(sev->dev, "SEV firmware initialized\n");

Any reason to remove this dbg line?  I assume the following dev_info() 
line is deemed sufficient?

> +	if (rc) {
> +		dev_err(sev->dev, "SEV: SEV_CMD_DF_FLUSH failed error %#x", psp_ret);
> +		return rc;
> +	}
>  
>  	dev_info(sev->dev, "SEV API:%d.%d build:%d\n", sev->api_major,
>  		 sev->api_minor, sev->build);
> @@ -2354,8 +2360,7 @@ void sev_pci_init(void)
>  	/* Initialize the platform */
>  	rc = sev_platform_init(&error);
>  	if (rc)
> -		dev_err(sev->dev, "SEV: failed to INIT error %#x, rc %d\n",
> -			error, rc);
> +		dev_err(sev->dev, "SEV: failed to INIT rc %d\n", rc);
>  
>  skip_legacy:
>  	dev_info(sev->dev, "SEV%s API:%d.%d build:%d\n", sev->snp_initialized ?
