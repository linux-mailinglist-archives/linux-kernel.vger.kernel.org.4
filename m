Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10DE7614C55
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 15:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiKAOPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 10:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiKAOPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 10:15:44 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC8D1A816
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 07:15:43 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so18921340pjc.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 07:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XkA3q4ZuYl8WiWjg1RJTxK24EJUWKrEDxDZgf18Lv6A=;
        b=b/KiuyXkMDrP74iJHD1F+5nOCMt6Gveh9+Sk5OxebU0UKGU7ZEzYtOFsI3W5xrmNnI
         pCli7OWNBjLug7ILxkoq1MdCU2f8nn65pWDKhBuHFuHWa72NM57O50h+akMf0gn48QGG
         uvjhAJvrrlXUQhSLIleGv48oBY3KD4+VnVn49izrRLEp9WkujXocGri8YpGhSvFkgY8H
         F63q/vGDN7+Zpvy9q5EH0U0f/Fk6IAMPtbg5PTcZ2KUbh54eASJSULRExAE+ZCP78ZAD
         Z3JB4FCZR3O8Zf8ZgXhbrs+1JPKB7aFUxuG5GP8v7mOHSJscnEHsll0aQcdhSZONSLP6
         Mhfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XkA3q4ZuYl8WiWjg1RJTxK24EJUWKrEDxDZgf18Lv6A=;
        b=I29rDC26ScINxesxPN8nw/WSHFXaTHsLKrTieNKzVnMOdRszmfwa7TiENpA5u89WqV
         Gs762ouGOPRSv+7udtgzVFZurGPH+azKGZPiRix+azrDQEozdDuMjk9Uyk5EQ5V/rv5X
         ix6Rq0KRtQFKMkKvq9ks/uZzcqNMtlPH+w5JPWx9RpCOUryDiTt17OnjLD3NDh4vlPV4
         UuiBpfJuvcgjKUBENy0ZE/F6ay6ESb/PmD8+bme7qdAqtPXyeAP9WKPmy5xn7nozCps9
         f2s07j+gFvA7vsvXKhyzPaiDNbUQTgMCw1mNndMsIihZb7y4bS6C2T1HLOeVSCGjOPaV
         Ycsw==
X-Gm-Message-State: ACrzQf2n/6dnFDk2dOFt1w+d2tt7sVDFCGgA4YU83Zsc0cUxlTifeCeD
        HezR30sFFm/HVcHmaxDXZyOv
X-Google-Smtp-Source: AMsMyM6lks+3B06ka5KdmDad2xCg7POxi4cgFqCw2zcizKT4Jh9muVX6PZOthfI6nJR/FxfK79eQ7Q==
X-Received: by 2002:a17:90b:1950:b0:212:de19:b3ce with SMTP id nk16-20020a17090b195000b00212de19b3cemr20040323pjb.16.1667312142940;
        Tue, 01 Nov 2022 07:15:42 -0700 (PDT)
Received: from thinkpad ([117.193.209.178])
        by smtp.gmail.com with ESMTPSA id d14-20020a170902654e00b0018157b415dbsm6429387pln.63.2022.11.01.07.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 07:15:41 -0700 (PDT)
Date:   Tue, 1 Nov 2022 19:45:34 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     kishon@ti.com, lpieralisi@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mie@igel.co.jp, kw@linux.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v2 2/5] tools: PCI: Fix parsing the return value of IOCTLs
Message-ID: <20221101141534.GQ54667@thinkpad>
References: <20220824123010.51763-1-manivannan.sadhasivam@linaro.org>
 <20220824123010.51763-3-manivannan.sadhasivam@linaro.org>
 <YwYdFt6sc7lZGRcg@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YwYdFt6sc7lZGRcg@kroah.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 02:44:06PM +0200, Greg KH wrote:
> On Wed, Aug 24, 2022 at 06:00:07PM +0530, Manivannan Sadhasivam wrote:
> > "pci_endpoint_test" driver now returns 0 for success and negative error
> > code for failure. So adapt to the change by reporting FAILURE if the
> > return value is < 0, and SUCCESS otherwise.
> > 
> > Cc: stable@vger.kernel.org #5.10
> > Fixes: 3f2ed8134834 ("tools: PCI: Add a userspace tool to test PCI endpoint")
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  tools/pci/pcitest.c | 41 +++++++++++++++++++++--------------------
> >  1 file changed, 21 insertions(+), 20 deletions(-)
> > 
> > diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
> > index 441b54234635..a4e5b17cc3b5 100644
> > --- a/tools/pci/pcitest.c
> > +++ b/tools/pci/pcitest.c
> > @@ -18,7 +18,6 @@
> >  
> >  #define BILLION 1E9
> >  
> > -static char *result[] = { "NOT OKAY", "OKAY" };
> >  static char *irq[] = { "LEGACY", "MSI", "MSI-X" };
> >  
> >  struct pci_test {
> > @@ -54,9 +53,9 @@ static int run_test(struct pci_test *test)
> >  		ret = ioctl(fd, PCITEST_BAR, test->barnum);
> >  		fprintf(stdout, "BAR%d:\t\t", test->barnum);
> >  		if (ret < 0)
> > -			fprintf(stdout, "TEST FAILED\n");
> > +			fprintf(stdout, "FAILED\n");
> >  		else
> > -			fprintf(stdout, "%s\n", result[ret]);
> > +			fprintf(stdout, "SUCCESS\n");
> 
> Is this following the kernel TAP output rules?  If not, why not?  If so,
> say that you are fixing that issue up in the changelog text.
> 

Sorry to revive this two months old thread. Adapting to TAP output rules
requires this test to be moved to KUnit which is strictly not necessary and can
be done later.

Moreover, I do not have the hardware to run this testcase and I don't feel
comfortable moving this to KUnit without doing functional testing.

So for now, I will fix the return value of IOCTLs which is the real motive
behind this series.

Thanks,
Mani

> thanks,
> 
> greg k-h

-- 
மணிவண்ணன் சதாசிவம்
