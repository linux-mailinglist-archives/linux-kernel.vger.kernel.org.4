Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335CC73A1D2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 15:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjFVNWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 09:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjFVNWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 09:22:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EC810F8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 06:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687440075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CwNoD4npTXJHndQ39H5OyokG0A2tJC7uKm6DdKDHg0U=;
        b=SdX3YlHjQasr1CV0P9JWD0JQqc2IYDvHpTIoAZbeoftIxdzJS1Vc2nLMdxkJuYWZTHzQ12
        S3plx+seM2b40TQcfoHnVjxspQMP9Ghp2SUhW4bcc9yW85iTRSOlknRdo80X6+gdlztIxr
        Ev1fTXfd9cMR20htM9vj1/IQwpo7ycA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-VLgEFJ9yPxuUOdTGyX5A6A-1; Thu, 22 Jun 2023 09:15:04 -0400
X-MC-Unique: VLgEFJ9yPxuUOdTGyX5A6A-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f9b8c230f5so14533095e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 06:15:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687439703; x=1690031703;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CwNoD4npTXJHndQ39H5OyokG0A2tJC7uKm6DdKDHg0U=;
        b=PA2760awasE51YZx1GcCK4wtlvwKQxEH853MhKOEw6lqJkHQbTo9IjjlE5WF5Ous9e
         PLGhRuN2p25CH3rkRF9Yozdrgu890+YWWsCxIoFfKX3vUBVU96cVAEgo0ynz7dfp4emv
         GvqmFcuaIUdH++ahP36stPNArpqfYSyP/oXoPt1NZI/C7drv12mQH8SIL0X6XUZu9mXf
         B9LtqBRME3HFvVoGnULJt5ki+p82Gi6+maPuhLcjRxES57VOau+Q8gwmhxWyIVCVz3NL
         sMkbkreEAXE+QbKZAWLm72DvH3DUgbRFrMfNmrAEt6HHRe5yR9OGiRJuAY9s9+YvguDC
         g2Fw==
X-Gm-Message-State: AC+VfDzGFkEir2vIivtwcOkUyIr21AUzOvKAQN8BoXLWgyN92eIorvEg
        G5Zc6Z7fEDZh5jcW3cG6GMSFVVqBSo6x7uIdguYLIefCAsn7o3nlNOli4M4JlgbleRP8h6E+Sy6
        UXdwhevoUa1Fu2ITuGxNVefy4
X-Received: by 2002:adf:fa83:0:b0:30e:56ae:ccb7 with SMTP id h3-20020adffa83000000b0030e56aeccb7mr13129224wrr.52.1687439702994;
        Thu, 22 Jun 2023 06:15:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7wzrlESkKHfrkXueFgu575m1EZWaFeye+ZamuL5DG2JBkgkpwqxiajJqPMAdS7wlgFKQpT2g==
X-Received: by 2002:adf:fa83:0:b0:30e:56ae:ccb7 with SMTP id h3-20020adffa83000000b0030e56aeccb7mr13129176wrr.52.1687439702720;
        Thu, 22 Jun 2023 06:15:02 -0700 (PDT)
Received: from ypodemsk.tlv.csb (IGLD-84-229-250-192.inter.net.il. [84.229.250.192])
        by smtp.gmail.com with ESMTPSA id u6-20020adff886000000b0031130b9b173sm7014116wrp.34.2023.06.22.06.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 06:15:02 -0700 (PDT)
Message-ID: <79f29f99fa07c46dbaee7b802cdd7b477b2d8dd1.camel@redhat.com>
Subject: Re: [PATCH v2 2/2] mm/mmu_gather: send tlb_remove_table_smp_sync
 IPI only to MM CPUs
From:   ypodemsk@redhat.com
To:     Dave Hansen <dave.hansen@intel.com>, mtosatti@redhat.com,
        ppandit@redhat.com, david@redhat.com, linux@armlinux.org.uk,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        keescook@chromium.org, paulmck@kernel.org, frederic@kernel.org,
        will@kernel.org, peterz@infradead.org, ardb@kernel.org,
        samitolvanen@google.com, juerg.haefliger@canonical.com,
        arnd@arndb.de, rmk+kernel@armlinux.org.uk, geert+renesas@glider.be,
        linus.walleij@linaro.org, akpm@linux-foundation.org,
        sebastian.reichel@collabora.com, rppt@kernel.org,
        aneesh.kumar@linux.ibm.com, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Thu, 22 Jun 2023 16:14:58 +0300
In-Reply-To: <680fadba-9104-3914-5175-e207fd3d9246@intel.com>
References: <20230620144618.125703-1-ypodemsk@redhat.com>
         <20230620144618.125703-3-ypodemsk@redhat.com>
         <680fadba-9104-3914-5175-e207fd3d9246@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-06-21 at 10:42 -0700, Dave Hansen wrote:
> On 6/20/23 07:46, Yair Podemsky wrote:
> > -void tlb_remove_table_sync_one(void)
> > +#ifdef CONFIG_ARCH_HAS_CPUMASK_BITS
> > +#define REMOVE_TABLE_IPI_MASK mm_cpumask(mm)
> > +#else
> > +#define REMOVE_TABLE_IPI_MASK cpu_online_mask
> > +#endif /* CONFIG_ARCH_HAS_CPUMASK_BITS */
> > +
> > +void tlb_remove_table_sync_one(struct mm_struct *mm)
> >  {
> >  	/*
> >  	 * This isn't an RCU grace period and hence the page-tables
> > cannot be
> > @@ -200,7 +206,8 @@ void tlb_remove_table_sync_one(void)
> >  	 * It is however sufficient for software page-table walkers
> > that rely on
> >  	 * IRQ disabling.
> >  	 */
> > -	smp_call_function(tlb_remove_table_smp_sync, NULL, 1);
> > +	on_each_cpu_mask(REMOVE_TABLE_IPI_MASK,
> > tlb_remove_table_smp_sync,
> > +			NULL, true);
> >  }
> 
> That "REMOVE_TABLE_IPI_MASK" thing is pretty confusing.  It *looks*
> like
> a constant.  It does *NOT* look at all like it consumes 'mm'.  Worst
> case, just create a local variable:
> 
> 	if (IS_ENABLED(CONFIG_ARCH_HAS_CPUMASK_BITS))
> 		ipi_mask = mm_cpumask(mm);
> 	else
> 		ipi_mask = cpu_online_mask;
> 
> 	on_each_cpu_mask(ipi_mask, ...);
> 
> That's a billion times more clear and it'll compile down to the same
> thing.
> 
> I do think the CONFIG_ARCH_HAS_CPUMASK_BITS naming is also pretty
> confusing, but I don't have any better suggestions.  Maybe something
> with "MM_CPUMASK" in it?
> 

Hi Dave,
Thanks for your suggestions!
I will send a new version with the local variable as you suggested
soon.
As for the config name, what about CONFIG_ARCH_HAS_MM_CPUMASK?
Thanks,
Yair

