Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5CD6C6644
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 12:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbjCWLOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 07:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbjCWLN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 07:13:59 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C23303E6;
        Thu, 23 Mar 2023 04:13:38 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id r11so3219549wrr.12;
        Thu, 23 Mar 2023 04:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679570017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tVjjdfxKWJEPl9oz0aYLy6zRsnTQ4oFQj5M+MsLi4UU=;
        b=F38AvaBM+QVvhoEnXN/37RC/wbr5gxcg/xewMRi1HC7Qv7kCXalhuf833HvjJqKw4O
         zRgjZqyyxWkpJuAOW7Cn+gqdpYKYMReZZ9GlFT8rPDlxs14cxZG7fnotxyfLLZvPb171
         CZKxM8I79dR0DNCbyMh3WuH8XVvDxzL2oFlawTiz8A4Rj9HD6MXoaziEbdFPnK9J2ugL
         j0Viyah3LFtDb8sKolhlgbpcUWLtOdV+chIkJark5/JfkQ0dckXV+07w+mEHi5zum2+V
         osOl3HwKTp18tsPhwrWjMGzvWljZZpFuZ9GGVRs/uhh0TuYBBtealfYpe1LnGyl+4mrQ
         717g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679570017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tVjjdfxKWJEPl9oz0aYLy6zRsnTQ4oFQj5M+MsLi4UU=;
        b=fm4W/tADbnaDkBE6aZeThvfejFbk9Ls7iO0lAlMJDTJIFYFoPasMcbSmwR0zZTkddT
         1b8X7FF7XyOTdyywekZ1t7L/QvK1JzOtSnmAr/VHUwMkxvoW5jlMX860fr8mWBfrnACI
         zjQEPxkLzUPDusBx1BfyCEC4gbcYNbbwbdaIht6EIziT9AujnZVR1khVhXWX0sUPJ4YV
         p5hDHml25SDDmnXtfaKqnpL4/TL7vIlhpE2e0jRYiq5AOcOWChr5tPBfhSDQ55GOi1zn
         mIACVlKC5rRiwE31qYw0LmkB+mfkE/aRLJon9OsftAC9W66pkjCVJzkiLsigRs2TpcrQ
         J6fg==
X-Gm-Message-State: AAQBX9df4J4nonbP2gKq8NkMW6n18nJEb0cDCE0J67AeJQJKVF0tkDby
        cepB1cYRIW5AzU9LfxOKKoQ=
X-Google-Smtp-Source: AKy350aKrb8xl5DTuyk28zfuFFdjZVHpayeWp5XlGIfFI7LBg2xKwfNHJeZvj24SuK6d7LqD5X8SlQ==
X-Received: by 2002:adf:e690:0:b0:2d6:4e98:5f32 with SMTP id r16-20020adfe690000000b002d64e985f32mr2167688wrm.23.1679570017143;
        Thu, 23 Mar 2023 04:13:37 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id r6-20020a05600c458600b003ee9f396dcesm202370wmo.30.2023.03.23.04.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 04:13:36 -0700 (PDT)
Date:   Thu, 23 Mar 2023 14:13:33 +0300
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
Message-ID: <201fba22-f537-4d1f-bfc4-e4dc931707bc@kili.mountain>
References: <20230323095311.1266655-1-mx_xiang@hust.edu.cn>
 <129aec21-4997-6b8d-5bd2-8e013f575208@gmail.com>
 <73fd29ce-3072-dfce-ebf0-3e197230fa94@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73fd29ce-3072-dfce-ebf0-3e197230fa94@suse.com>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 11:54:24AM +0100, 'Oliver Neukum' via HUST OS Kernel Contribution wrote:
> 
> 
> On 23.03.23 11:29, Sergei Shtylyov wrote:
> > On 3/23/23 12:53 PM, Mingxuan Xiang wrote:
> > 
> > > platform_get_irq() no longer returns 0, so there is no
> > > need to check whether the return value is 0.
> > > 
> > > Signed-off-by: Mingxuan Xiang <mx_xiang@hust.edu.cn>
> > > ---
> > > v1->v2: remove redundant goto
> > >   drivers/usb/dwc3/host.c | 4 ----
> > >   1 file changed, 4 deletions(-)
> > > 
> > > diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
> > > index f6f13e7f1ba1..ca1e8294e835 100644
> > > --- a/drivers/usb/dwc3/host.c
> > > +++ b/drivers/usb/dwc3/host.c
> > > @@ -54,12 +54,8 @@ static int dwc3_host_get_irq(struct dwc3 *dwc)
> > >   	irq = platform_get_irq(dwc3_pdev, 0);
> > >   	if (irq > 0) {
> > >   		dwc3_host_fill_xhci_irq_res(dwc, irq, NULL);
> > > -		goto out;
> > >   	}
> > 
> >     Now drop {} please. :-)
> 
> Well, no, please drop the whole patch.
> If platform_get_irq() returns -EPROBE_DEFER you now give that
> as a return value.
> 
> This tiny bit of optimization is not worth changing semantics.

The v2 patch doesn't change the semantics.  Mine did though...

regards,
dan carpenter

