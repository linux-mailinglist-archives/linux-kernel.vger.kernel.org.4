Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39946C6A6D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 15:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjCWOHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 10:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbjCWOHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 10:07:36 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A8222793;
        Thu, 23 Mar 2023 07:06:23 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id j18-20020a05600c1c1200b003ee5157346cso1277887wms.1;
        Thu, 23 Mar 2023 07:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679580378;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z4BMiXjAP1ZDCS80RIcwxql2HNxRwPUInw3Q2X6diKU=;
        b=GPQuBpzB70pNVCwyNA98ZNN6PaiMrOOhDlHsXGsvfQ7Rk0AKwWgWIQR09P3q7tyxrW
         3zel+WM6jx5cSkf0wf7H4HZQC+RNr/ewq6fxF/RGDaZICvsTYKUCRWD50VT7z2N2j/cB
         EYYvpNwajjWjyYQAXdwiYuTxMeWChWl5THqn3vgb6PvSX2nizF1aVufdlUJ0IQrUyxUJ
         1z7GLmeDN5EseQPF5m9w0DddAqosd/9X26frWdbsH/nblx7vC1bAlv4uQ0IBEzuji011
         GuNpDqzgjcE9zPpkRS/s91mEJiubyJQCdqiEGUDg9rFbnOJmE24FMnOWzHxUZXD8tDJm
         TMVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679580378;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z4BMiXjAP1ZDCS80RIcwxql2HNxRwPUInw3Q2X6diKU=;
        b=MQvpw7sC05LBfNEK63EzII0Ga5X8hZmgW56khA6J2gKU+hYynWg4xFEW1755fA5y2u
         SNjxtEmzPKaysXaBVoPKU5ahOxEynrfKKiaxQ0umULV/o5JDhDmauGtQ935C3dgqKOOq
         SiSRGZF3f926t9Wg25SiYy+/2fHpF1fawlejT/jOOpB0sbIQXa82qq86BAOK++egyd2E
         n6wzrzDlookojo/pzj0rgWkJCbsYQuk4FHfo8U0CAPGgpDTiRjOCCe8XF0JxOcDdwov6
         A/0x23PDD4HvfB+3WE5sennVbleqECDU6RdmrRDlgrtIYjWVQUFRSi6AWlHfnq6dAP4e
         Lksw==
X-Gm-Message-State: AO0yUKXtbmALT5+vBGz0PTWiXx7KKOVLSSwShXXhCsCTVvZzqe8X+YAn
        tUeU2TvCvelF9aYuf7KwdTX94YCHJRQ=
X-Google-Smtp-Source: AK7set97LqRWSWhWWcYp/0nGzUtkX3dT5/Jw8lv/CcNhZdDP0IpK9zCEg5Uz7F/2N0vC8/CgOHMGXQ==
X-Received: by 2002:a05:600c:3795:b0:3ed:93de:49ff with SMTP id o21-20020a05600c379500b003ed93de49ffmr2390666wmr.0.1679580378202;
        Thu, 23 Mar 2023 07:06:18 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id i11-20020a05600c290b00b003ee20b4b2dasm1912223wmd.46.2023.03.23.07.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 07:06:17 -0700 (PDT)
Date:   Thu, 23 Mar 2023 17:06:14 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Oliver Neukum <oneukum@suse.com>
Cc:     Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Mingxuan Xiang <mx_xiang@hust.edu.cn>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        hust-os-kernel-patches@googlegroups.com,
        Dongliang Mu <dzm91@hust.edu.cn>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: dwc3: host: remove dead code in
 dwc3_host_get_irq()
Message-ID: <6677e2c6-b621-4c7e-9dd6-631a02ce5996@kili.mountain>
References: <20230323095311.1266655-1-mx_xiang@hust.edu.cn>
 <129aec21-4997-6b8d-5bd2-8e013f575208@gmail.com>
 <73fd29ce-3072-dfce-ebf0-3e197230fa94@suse.com>
 <201fba22-f537-4d1f-bfc4-e4dc931707bc@kili.mountain>
 <181feb34-c46d-cadb-ad20-46074a53b4c9@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <181feb34-c46d-cadb-ad20-46074a53b4c9@suse.com>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 02:48:56PM +0100, Oliver Neukum wrote:
> On 23.03.23 12:13, Dan Carpenter wrote:
> 
> > > > > v1->v2: remove redundant goto
> > > > >    drivers/usb/dwc3/host.c | 4 ----
> > > > >    1 file changed, 4 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
> > > > > index f6f13e7f1ba1..ca1e8294e835 100644
> > > > > --- a/drivers/usb/dwc3/host.c
> > > > > +++ b/drivers/usb/dwc3/host.c
> > > > > @@ -54,12 +54,8 @@ static int dwc3_host_get_irq(struct dwc3 *dwc)
> > > > >    	irq = platform_get_irq(dwc3_pdev, 0);
> > > > >    	if (irq > 0) {
> > > > >    		dwc3_host_fill_xhci_irq_res(dwc, irq, NULL);
> > > > > -		goto out;
> > > > >    	}
> > > > 
> > > >      Now drop {} please. :-)
> > > 
> > > Well, no, please drop the whole patch.
> > > If platform_get_irq() returns -EPROBE_DEFER you now give that
> > > as a return value.
> > > 
> > > This tiny bit of optimization is not worth changing semantics.
> > 
> > The v2 patch doesn't change the semantics.  Mine did though...
> 
> Now I may be dense, but let's look at the current code:
> 
>         irq = platform_get_irq(dwc3_pdev, 0);
> 
> assuming irq = -EPROBE_DEFER
> 
>         if (irq > 0) {
> 
> not taken
>                 dwc3_host_fill_xhci_irq_res(dwc, irq, NULL);
>                 goto out;
>         }
> 
>         if (!irq)
> 
> irq != 0

You've reversed this if statement in your head.  It says that if
platform_get_irq() returns zero, then return -EINVAL.

The problem that Mingxuan is trying to address is that checking for zero
is dead code and sometimes represents a bug when people check for zero
instead of negatives.

>                 irq = -EINVAL;
> 
> out:
>         return irq;
> 
> returning -EINVAL

We do *want* it to return -EPROBE_DEFER as the current code does.

regards,
dan carpenter

