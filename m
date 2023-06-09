Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1863729B5A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 15:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240459AbjFINST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 09:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjFINSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 09:18:17 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6C030C5
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 06:18:16 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-30fa23e106bso345808f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 06:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686316694; x=1688908694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YgJZVog4QId8J7JaC0naUd6FnkaXXLTRPTgD1N+SRw8=;
        b=AZUurjpf72+T14kiStwV5o9YWM8M1QeNhoASj9V+a4aq+TthkHWeZ4LSAy3ddbBzF/
         yNo/JP5VJmrUCxErZi4CTSTJPAdF0/EHuwXfoaFIfUvhkUUskWTqHo+epj+q/1g6IWfZ
         8gLSU50NZxIJoXEvFNONaKcPf1mkslm2p0B4ZuVp4U98uMvPxiZV/uV3uOk0sPQzEvOR
         DsC7J1d4Xd9UML7hnEGCc1ARoV/RCa417uVeG+aA+cG7liKZlIPoDK5biFYydelGPTQW
         bBw9FQrH/r89oT/IxTquuUA76iyKubgw79vWq2Fra3Y7/irJtiXB5shX5p66xL+kqcw1
         iGIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686316694; x=1688908694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YgJZVog4QId8J7JaC0naUd6FnkaXXLTRPTgD1N+SRw8=;
        b=R/IH2a1vxKMg3FeXQSCvg+zMKLOJyuOXsCU3halRO9s3PhR//i0nXF/SujOavvUNEu
         J8GZI/QI3jLzohoXerD94ddjUOfRr1C+sIBhBrd9eVQaTXPutf4UJRnZS+8F5aCOYSad
         cqhgqtRdb8Y8K+9UrgbC3ZLM4zFBKlDuwDQYx0fAsnuSIvPIpO5G4ZrrmLtYDK6q1Zef
         ddNDhL2kLxosMfj5XHBHOg7BBEWb3Gr5ZEtRz8okKoiyKU0w/2JlUcZNI0Jh/08LuuxR
         6bpGnFROEbPCmU6IrYyQ6HexfLDztIi/7q/Zx6pAoBed3U29uyjsQuRQOIhyle+hpKis
         oYYA==
X-Gm-Message-State: AC+VfDxRa1a+4dfdjmzd26iA/c1wgAwe2OhO+thp7WFhkytl9uXVmjUL
        dasrnjGN8+c+P3XTmjdo3Th39cK0haesNkDt84Q=
X-Google-Smtp-Source: ACHHUZ4ywMdZHZ56LMGYH+4/KpYZ25kc85qDDM6ZC48F8rBycFCPBFhYHAfQYbzl4+AVAw9cyQWQbQ==
X-Received: by 2002:a5d:51c6:0:b0:309:33c4:52e1 with SMTP id n6-20020a5d51c6000000b0030933c452e1mr772596wrv.64.1686316694583;
        Fri, 09 Jun 2023 06:18:14 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id m6-20020a5d6246000000b0030e52d4c1bcsm4511387wrv.71.2023.06.09.06.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 06:18:13 -0700 (PDT)
Date:   Fri, 9 Jun 2023 16:18:08 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Sai Krishna <saikrishnag@marvell.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, sgoutham@marvell.com,
        maciej.fijalkowski@intel.com,
        Naveen Mamindlapalli <naveenm@marvell.com>
Subject: Re: [net PATCH v2] octeontx2-af: Move validation of ptp pointer
 before its usage
Message-ID: <880d628e-18bf-44a1-a55f-ffbe1777dd2b@kadam.mountain>
References: <20230609115806.2625564-1-saikrishnag@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609115806.2625564-1-saikrishnag@marvell.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 05:28:06PM +0530, Sai Krishna wrote:
> @@ -428,7 +427,7 @@ static int ptp_probe(struct pci_dev *pdev,
>  	return 0;
>  
>  error_free:
> -	devm_kfree(dev, ptp);
> +	kfree(ptp);

Yeah.  It's strange any time we call devm_kfree()...  So there is
something here which I have not understood.

>  
>  error:
>  	/* For `ptp_get()` we need to differentiate between the case

This probe function is super weird how it returns success on the failure
path.  One concern, I had initially was that if anything returns
-EPROBE_DEFER then we cannot recover.  That's not possible in the
current code, but it makes me itch...  But here is a different crash.

drivers/net/ethernet/marvell/octeontx2/af/ptp.c
   432  error:
   433          /* For `ptp_get()` we need to differentiate between the case
   434           * when the core has not tried to probe this device and the case when
   435           * the probe failed.  In the later case we pretend that the
   436           * initialization was successful and keep the error in
   437           * `dev->driver_data`.
   438           */
   439          pci_set_drvdata(pdev, ERR_PTR(err));
   440          if (!first_ptp_block)
   441                  first_ptp_block = ERR_PTR(err);

first_ptp_block is NULL for unprobed, an error pointer for probe
failure, or valid pointer.

   442  
   443          return 0;
   444  }

drivers/net/ethernet/marvell/octeontx2/af/ptp.c
   201  struct ptp *ptp_get(void)
   202  {
   203          struct ptp *ptp = first_ptp_block;
                            ^^^^^^^^^^^^^^^^^^^^^^

   204  
   205          /* Check PTP block is present in hardware */
   206          if (!pci_dev_present(ptp_id_table))
   207                  return ERR_PTR(-ENODEV);
   208          /* Check driver is bound to PTP block */
   209          if (!ptp)
   210                  ptp = ERR_PTR(-EPROBE_DEFER);
   211          else
   212                  pci_dev_get(ptp->pdev);
                                    ^^^^^^^^^
if first_ptp_block is an error pointer this will Oops.

   213  
   214          return ptp;
   215  }

regards,
dan carpenter
