Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACC5664569
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 16:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238919AbjAJPzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 10:55:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238942AbjAJPy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 10:54:56 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD74B3F120
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 07:54:51 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id bu8so19140560lfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 07:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=profian-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ix339kkTlpn2awHFm+SxDuLq8JxyWGFgKOqLAoyVa7Y=;
        b=dOVMWBGzNqYUYXLR/FTKB5CsJSXGVsyIz6nmC2bcIfxOTCaUynzsUVLboUo0GVzG2i
         6+vL7vdoZWhe44IzF3Mpf/IhwTp79uz0kwya/WXT5bVlQbrkCKe1deWtFSJB2OQDeKzw
         WmbafcqaQYwZT76GLyQrOz7W/0ErkYaE5e3z89jOKDUTlZ3jzocoJM3CyLpwLfmRi+Kt
         IOFEdlMp3D1kv1ZGKxJ3LEkPEqMuprF2qeYY1wlISwNhXMCtO8mHuSrN4PTnWLM3wV7Q
         3W5vsg5cT9NcQqcqW6CpRANTcC3TS93SWoOIFdGNStHfJfA/y3hwkFmSKwRzEhAolLP0
         dEDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ix339kkTlpn2awHFm+SxDuLq8JxyWGFgKOqLAoyVa7Y=;
        b=fDxFW5J9ehZlPgEClxs3GSiRrmnGkEnB3u4U3u/5BJgQ+pXB/NFAQoArAmSYF3CNr0
         jM8ZiPMHCk23GDL9whq6e2IOsxoHS/BEBDGihnbFCGifnkK522XWa/Pg2FliO9j76tEX
         T/ilhtPc7Xb7EFdTrSunOgKKZ84A8SYMWL/deE8e9iYM86+SYH33y08UPh+rfIo7PYzx
         TT+u8Yz4Sfad1L0i/C1uMVVKQ9N7sw/WemyxCC+HQwQzrmQlyQ/gAfISqBu5FHeWJq7T
         3KlwTuSHkT+2ii4rCWOB195RlrTfMDDTgMOmrg8/yAlIUSS6ncy6HYoOan+Ll03IrrsJ
         Xm1g==
X-Gm-Message-State: AFqh2kqXpoX+dSTLfm0hMy5R16wdElcnFma6QsvFbuh345GJwUt3Veo7
        OeGYkTGYoj8F98whuJgb4mFz1A==
X-Google-Smtp-Source: AMrXdXvYlXs9NrFjmUAGjtIBjURoNXBjkCKL2q9ffeOwPbmUOMgEN4lMhlAjNtZ6GUXvNZW4ABPz4g==
X-Received: by 2002:a05:6512:3ca0:b0:4b5:b7c3:8053 with SMTP id h32-20020a0565123ca000b004b5b7c38053mr22268123lfv.42.1673366090060;
        Tue, 10 Jan 2023 07:54:50 -0800 (PST)
Received: from localhost (83-245-197-49.elisa-laajakaista.fi. [83.245.197.49])
        by smtp.gmail.com with ESMTPSA id u7-20020ac258c7000000b004a100c21eaesm2239256lfo.97.2023.01.10.07.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 07:54:49 -0800 (PST)
Date:   Tue, 10 Jan 2023 15:54:48 +0000
From:   Jarkko Sakkinen <jarkko@profian.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "open list:AMD CRYPTOGRAPHIC COPROCESSOR (CCP) DRIVER - SE..." 
        <linux-crypto@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] crypto: ccp: Sanitize sev_platform_init() error
 messages
Message-ID: <Y72KSC/Dr55Qszjy@profian.com>
References: <20230110033520.66560-1-jarkko@profian.com>
 <ddbb4b2f-3eb8-64da-bce9-3cfd66d7729a@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddbb4b2f-3eb8-64da-bce9-3cfd66d7729a@amd.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 08:41:33AM -0600, Tom Lendacky wrote:
> On 1/9/23 21:35, Jarkko Sakkinen wrote:
> > The following functions end up calling sev_platform_init() or
> > __sev_platform_init_locked():
> > 
> > * sev_guest_init()
> > * sev_ioctl_do_pek_csr
> > * sev_ioctl_do_pdh_export()
> > * sev_ioctl_do_pek_import()
> > * sev_ioctl_do_pek_pdh_gen()
> > * sev_pci_init()
> > 
> > However, only sev_pci_init() prints out the failed command error code, and
> > even there, the error message does not specify which SEV command failed.
> > 
> > Address this by printing out the SEV command errors inside
> > __sev_platform_init_locked(), and differentiate between DF_FLUSH, INIT and
> > INIT_EX commands.  As a side-effect, @error can be removed from the
> > parameter list.
> > 
> > This extra information is particularly useful if firmware loading and/or
> > initialization is going to be made more robust, e.g. by allowing firmware
> > loading to be postponed.
> > ---
> > v4:
> > * Sorry, v3 was malformed. Here's a proper patch.
> > 
> > v3:
> > * Address Tom Lendacky's feedback:
> >    https://lore.kernel.org/kvm/8bf6f179-eee7-fd86-7892-cdcd76e0762a@amd.com/
> > 
> > v2:
> > * Address David Rientjes's feedback:
> >    https://lore.kernel.org/all/6a16bbe4-4281-fb28-78c4-4ec44c8aa679@google.com/
> > * Remove @error.
> > * Remove "SEV_" prefix: it is obvious from context so no need to make klog
> >    line longer.
> > 
> > Signed-off-by: Jarkko Sakkinen <jarkko@profian.com>
> > ---
> >   drivers/crypto/ccp/sev-dev.c | 17 ++++++++++-------
> >   1 file changed, 10 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
> > index 06fc7156c04f..bdc43e75c78b 100644
> > --- a/drivers/crypto/ccp/sev-dev.c
> > +++ b/drivers/crypto/ccp/sev-dev.c
> > @@ -476,19 +476,23 @@ static int __sev_platform_init_locked(int *error)
> >   		dev_err(sev->dev, "SEV: retrying INIT command because of SECURE_DATA_INVALID error. Retrying once to reset PSP SEV state.");
> >   		rc = init_function(&psp_ret);
> >   	}
> > -	if (error)
> > +	if (rc) {
> > +		dev_err(sev->dev, "SEV: %s failed error %#x",
> > +			sev_init_ex_buffer ? "CMD_INIT_EX" : "CMD_INIT", psp_ret);
> >   		*error = psp_ret;
> 
> If I'm not mistaken, error can be NULL, that's why the "if (error)" was
> present. So that should be kept and even filled in on success. So please
> leave it the way it was and just add the message to the "if (rc)" section.

Ah, right thanks, will do.

> > -
> > -	if (rc)
> >   		return rc;
> > +	}
> >   	sev->state = SEV_STATE_INIT;
> >   	/* Prepare for first SEV guest launch after INIT */
> >   	wbinvd_on_all_cpus();
> > -	rc = __sev_do_cmd_locked(SEV_CMD_DF_FLUSH, NULL, error);
> > -	if (rc)
> > +	rc = __sev_do_cmd_locked(SEV_CMD_DF_FLUSH, NULL, &psp_ret);
> 
> Same here, add:
> 
> 	if (error)
> 		*error = psp_ret;
> > +	if (rc) {
> > +		dev_err(sev->dev, "SEV: CMD_DF_FLUSH failed error %#x", psp_ret);
> > +		*error = psp_ret;
> >   		return rc;
> > +	}
> >   	dev_dbg(sev->dev, "SEV firmware initialized\n");
> > @@ -1337,8 +1341,7 @@ void sev_pci_init(void)
> >   	/* Initialize the platform */
> >   	rc = sev_platform_init(&error);
> >   	if (rc)
> > -		dev_err(sev->dev, "SEV: failed to INIT error %#x, rc %d\n",
> > -			error, rc);
> > +		dev_err(sev->dev, "SEV: failed to INIT rc %d\n", rc);
> >   	return;

BR, Jarkko
