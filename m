Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE876DD742
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 11:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjDKJzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 05:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjDKJz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 05:55:27 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809E610DE
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 02:55:24 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-2ef70620b9dso594269f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 02:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1681206923;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qjwT/tg0Il9N/eZxuQXGAWsNmLhCbQOBOXoq9lsOf/U=;
        b=LhR2tDt6FPotjaySQ6Sf6tz9AG58+vuUcuM1yAZgHkm1xiEQJEHBRofim1m6IDozXv
         VI57GGn+P7smvIJg1ibAhWImNuu+0ChlA3+Q/1cNs3y/ZP+RcJBoiDNuZfGklAtqnP9v
         JkVBhuPRD66yy7XkwBawBfXNfPQUiNNhIMddg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681206923;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qjwT/tg0Il9N/eZxuQXGAWsNmLhCbQOBOXoq9lsOf/U=;
        b=fFwJSKDtSiDiE8fjTbvaoKs8o1a658/uIbiIrmQvBDzpoLCE0CuDyCQKmDQnfLwVbI
         QNqce8uXMVPDfaxpaZAj3zyv5ixa/5X3UnhFdeEMaVIiIIR8xPmDQ28lLmmufyl98ChY
         OO3c6tmiCXOzf8iUAlfFwXqAyrL+U6hM1UjAJDotCLy1+2A/oOT6PvXbRkAWfavER3Xv
         65ioURFWFW6yOn1YjFSm+TTIB107q8ZLNvvx/cS4MZN/Sbu2yrLTEQ99/7ZXXl05sE8t
         3gT2U8gOfd4ja//D6vxgkcTV/VChjEK537P28eD3PCjJ8ZKTde1uIrfforQOrTbVsJkv
         kBNA==
X-Gm-Message-State: AAQBX9cZFAvJp4RAf+42d7xY1+Ok7Gr1hmHJ67CbqlH9ReNCl+xFGn+5
        VZGFREQ0C3fuRO3PrTZ/TsPorA==
X-Google-Smtp-Source: AKy350ZXTk4qisD5Dt7crpTUypd1u94LzlFsvk6oecu9nShltuKwhWFouDQ/FBGSmrfdK/RUJbOObw==
X-Received: by 2002:a05:600c:1991:b0:3f0:80fe:25be with SMTP id t17-20020a05600c199100b003f080fe25bemr6991447wmq.3.1681206923005;
        Tue, 11 Apr 2023 02:55:23 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id iv11-20020a05600c548b00b003ed29189777sm20723241wmb.47.2023.04.11.02.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 02:55:22 -0700 (PDT)
Date:   Tue, 11 Apr 2023 11:55:20 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Greg KH <greg@kroah.com>, Dave Airlie <airlied@redhat.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Subject: Re: linux-next: build failure after merge of the driver-core tree
Message-ID: <ZDUuiB+E1tIJ95LY@phenom.ffwll.local>
Mail-Followup-To: Stephen Rothwell <sfr@canb.auug.org.au>,
        Greg KH <greg@kroah.com>, Dave Airlie <airlied@redhat.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
References: <20230411143812.11a4b00d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411143812.11a4b00d@canb.auug.org.au>
X-Operating-System: Linux phenom 6.1.0-7-amd64 
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 02:38:12PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the driver-core tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> In file included from include/linux/linkage.h:7,
>                  from include/linux/kernel.h:17,
>                  from drivers/accel/qaic/mhi_qaic_ctrl.c:4:
> drivers/accel/qaic/mhi_qaic_ctrl.c: In function 'mhi_qaic_ctrl_init':
> include/linux/export.h:27:22: error: passing argument 1 of 'class_create' from incompatible pointer type [-Werror=incompatible-pointer-types]
>    27 | #define THIS_MODULE (&__this_module)
>       |                     ~^~~~~~~~~~~~~~~
>       |                      |
>       |                      struct module *
> drivers/accel/qaic/mhi_qaic_ctrl.c:544:38: note: in expansion of macro 'THIS_MODULE'
>   544 |         mqc_dev_class = class_create(THIS_MODULE, MHI_QAIC_CTRL_DRIVER_NAME);
>       |                                      ^~~~~~~~~~~
> In file included from include/linux/device.h:31,
>                  from include/linux/mhi.h:9,
>                  from drivers/accel/qaic/mhi_qaic_ctrl.c:5:
> include/linux/device/class.h:229:54: note: expected 'const char *' but argument is of type 'struct module *'
>   229 | struct class * __must_check class_create(const char *name);
>       |                                          ~~~~~~~~~~~~^~~~
> drivers/accel/qaic/mhi_qaic_ctrl.c:544:25: error: too many arguments to function 'class_create'
>   544 |         mqc_dev_class = class_create(THIS_MODULE, MHI_QAIC_CTRL_DRIVER_NAME);
>       |                         ^~~~~~~~~~~~
> include/linux/device/class.h:229:29: note: declared here
>   229 | struct class * __must_check class_create(const char *name);
>       |                             ^~~~~~~~~~~~
> 
> Caused by commit
> 
>   1aaba11da9aa ("driver core: class: remove module * from class_create()")
> 
> interacting with commit
> 
>   566fc96198b4 ("accel/qaic: Add mhi_qaic_cntl")
> 
> from the drm tree.
> 
> I have applied the following merge fix patch for today.
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Tue, 11 Apr 2023 14:16:57 +1000
> Subject: [PATCH] fixup for "driver core: class: remove module * from class_create()"
> 
> interacting with "accel/qaic: Add mhi_qaic_cntl"
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Thanks for the fixup. Since Dave is out I've made a note about this in my
handover mail so it won't get lost in the drm-next merge window pull. I
don't think we need any other coordination than mention it in each pull to
Linus, topic tree seems overkill for this. Plus there's no way I can
untangle the drm tree anyway :-).
-Daniel

> ---
>  drivers/accel/qaic/mhi_qaic_ctrl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/accel/qaic/mhi_qaic_ctrl.c b/drivers/accel/qaic/mhi_qaic_ctrl.c
> index 0c7e571f1f12..96db1580c72d 100644
> --- a/drivers/accel/qaic/mhi_qaic_ctrl.c
> +++ b/drivers/accel/qaic/mhi_qaic_ctrl.c
> @@ -541,7 +541,7 @@ int mhi_qaic_ctrl_init(void)
>  		return ret;
>  
>  	mqc_dev_major = ret;
> -	mqc_dev_class = class_create(THIS_MODULE, MHI_QAIC_CTRL_DRIVER_NAME);
> +	mqc_dev_class = class_create(MHI_QAIC_CTRL_DRIVER_NAME);
>  	if (IS_ERR(mqc_dev_class)) {
>  		ret = PTR_ERR(mqc_dev_class);
>  		goto unregister_chrdev;
> -- 
> 2.39.2
> 
> -- 
> Cheers,
> Stephen Rothwell



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
