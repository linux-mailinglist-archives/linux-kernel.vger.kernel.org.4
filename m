Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402346AA031
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 20:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbjCCTip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 14:38:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbjCCTin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 14:38:43 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB1A1351C
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 11:38:34 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id ff4so2499943qvb.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 11:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmu.edu; s=google-2021; t=1677872313;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HYQ/b/2CMo0jQZJbl9gbztbb/ds7IDeF+eF3lNwAa+E=;
        b=K+wxfTujSJzhr547gDW560HtpnMx27zP4k30p5i8muJ4xRciDbc7FbZRVsoKV8HTuV
         44z32zSMrVEk/ivCmb2jTREfE4m+O7Pz/qEjziFnraeZwQWJzk33TiUQKiutakpx1am4
         L13odP2/Bv8vfiMlpR+aGKQlKNlL5o3pge9UTCFWhp6hgbDXL1tKOiXZMtCmP/r7Cv5/
         ebn148CLiRFPy+SoPzbEU6yag+m5Ft9F+5hJyxYMnlfKpzENQcNeFKgWwcB5itQzcxGJ
         tCMyAumYLL+STXBAvplYXbZnrcvxQSRgFaQyy5UWMQ2859c05ZPxwbOMXgGuOBD4oesq
         mPGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677872313;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HYQ/b/2CMo0jQZJbl9gbztbb/ds7IDeF+eF3lNwAa+E=;
        b=BhJkfs8ghZiLkpHuXJxGT/qnyXk8L1BprbIXma76n66oyLqcadsPwxTZZ+EZ5oI6pn
         fDaqFkT7yRN9plu/Nc15nukSfcRJ+05VmsM1wb6Jtk86CWv7nfYspgAbp48g2Y5+eBCA
         vXBPJASIhO3DZ3u67vqUzZbfojPrcAJQMWWLNSteTf4J3+iBfkSDAqW2IL+C49F+kG2Q
         3zZKUZ3sNTRXR71X1iP2Sxhy16ItH3yqcem4Bx4lHriMJMmlSS9AwKaYr0P4vMqgazub
         /JKGzZOK9nA7uhTpEs5I8MwI4dRBL7SAcmgMoP5UyTZnuAtnWt9go1+4svjwRkNGVkUH
         k94A==
X-Gm-Message-State: AO0yUKXzTtIwzUMsGdm7GbBpA+L9bX73qQ7U8RSvnk5T9RE8RVz4SJ29
        WYyltZPRiSebmYdiWtGkEloxiQ==
X-Google-Smtp-Source: AK7set8SAOoXYTlT0gXqz99dKGbNwHBxgqZB5lr3AWbdV3Fq4g/KydoSI12RgxFiqZ48VoTewdmFIA==
X-Received: by 2002:a05:6214:1c8e:b0:56b:eda1:de3e with SMTP id ib14-20020a0562141c8e00b0056beda1de3emr4744326qvb.36.1677872313396;
        Fri, 03 Mar 2023 11:38:33 -0800 (PST)
Received: from errol.ini.cmu.edu (pool-72-77-81-136.pitbpa.fios.verizon.net. [72.77.81.136])
        by smtp.gmail.com with ESMTPSA id 29-20020a05620a049d00b00741a984943fsm2321202qkr.40.2023.03.03.11.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 11:38:33 -0800 (PST)
Date:   Fri, 3 Mar 2023 14:38:31 -0500
From:   "Gabriel L. Somlo" <somlo@cmu.edu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: qemu_fw_cfg: make kobj_type structure constant
Message-ID: <ZAJMt3nMgvfUpKAi@errol.ini.cmu.edu>
References: <20230227-kobj_type-firmware-qemu-v1-1-fc0c8b44424f@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230227-kobj_type-firmware-qemu-v1-1-fc0c8b44424f@weissschuh.net>
X-Clacks-Overhead: GNU Terry Pratchett
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 03:19:56AM +0000, Thomas Weiﬂschuh wrote:
> Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
> the driver core allows the usage of const struct kobj_type.
> 
> Take advantage of this to constify the structure definition to prevent
> modification at runtime.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  drivers/firmware/qemu_fw_cfg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
> index a69399a6b7c0..f41de793f41b 100644
> --- a/drivers/firmware/qemu_fw_cfg.c
> +++ b/drivers/firmware/qemu_fw_cfg.c
> @@ -452,7 +452,7 @@ static void fw_cfg_sysfs_release_entry(struct kobject *kobj)
>  }
>  
>  /* kobj_type: ties together all properties required to register an entry */
> -static struct kobj_type fw_cfg_sysfs_entry_ktype = {
> +static const struct kobj_type fw_cfg_sysfs_entry_ktype = {

Reviewed-by: Gabriel L. Somlo <somlo@cmu.edu>

Thanks,
--Gabriel

>  	.default_groups = fw_cfg_sysfs_entry_groups,
>  	.sysfs_ops = &fw_cfg_sysfs_attr_ops,
>  	.release = fw_cfg_sysfs_release_entry,
> 
> ---
> base-commit: 2fcd07b7ccd5fd10b2120d298363e4e6c53ccf9c
> change-id: 20230227-kobj_type-firmware-qemu-7746b6320db0
> 
> Best regards,
> -- 
> Thomas Weiﬂschuh <linux@weissschuh.net>
> 
