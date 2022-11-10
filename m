Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64CBD624B49
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 21:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbiKJULY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 15:11:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiKJULH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 15:11:07 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58F34AF34
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 12:11:01 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id q1-20020a17090a750100b002139ec1e999so2821091pjk.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 12:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3OUcSWJEZLnHwI/2i7UhzfxeGDRoywtd2IZZ5uGorfo=;
        b=aWgzAS9F+Dz/242G6aqUeaTsUasKuJ5+ePJbq5FZDfX7aG4MFsBeSc94K5VA7IOd1y
         rALOvxYwXq4z7VW+Mr80G1VSqDw1u6CjMjYmHub6kQiRqq5iVQVhtQj7Xsaxhjn8Hq83
         0IC0CR/8RvHsdSOtYRCRfe+bq+51QAH6Z4nN4KHFoTtqfx+sPqXefCY8w0WlaGbuPZ1B
         CYsR8L1qEkFl74FKJ6PiCQxOaj29RfN7epFCAohwZoCR1+g2wTsk1c7w0nUoOEpGhbYh
         jCDR4I6sQGTiHP+/STOJp2cVsDlIfjH19obtKfl4TWzYi8y6qaABEa/ToEc5OSyW7f4d
         IXtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3OUcSWJEZLnHwI/2i7UhzfxeGDRoywtd2IZZ5uGorfo=;
        b=zpRqixyPbm7O0Iurh7eNxGumdHelaD+CaZX7wmJXBN3lZ9IHdgF5BJWgPeFNkVgVI7
         FT4wC1dKv5N0TQgmpZ7M4xA0Peoi7b7iPLdCnW75/g+QGGAbzJf9UdsP9LG0CsnVnp7j
         Mg6tHf8fNn7hFBzo/UPoeISVe4SLBIRIWbZdhB9xl1kC2ZgT9cBCWHpTYDs4rsI3E8tr
         UOHuT5XEfuY7kSIt74RRj8z55zPbDy+3fN5B2lai1sA3yAu7UfxsFdd14BsfT+dSqBbQ
         3TUpc9NDv0cLgEKSDHyI3kcpTeKArcvxhcFLUAw01LFM+YdmJy6CyZ3nU2Y3PYueAgwJ
         +eew==
X-Gm-Message-State: ACrzQf3jSDNe75GywWvxhlqlbvtw47lf5z7hbvJWEp5TDwF+SNNFOLyK
        G0umkSTEgyyYCiI1H9+dOabgMQ==
X-Google-Smtp-Source: AMsMyM5ygA5X9Qc2XcDiJDE1Z8P6WbyBruAnzjdH0Z136Zt0H78w6ELt9FURWQGHmpZLmsBmj1MLvg==
X-Received: by 2002:a17:90a:dc18:b0:209:853d:ec6 with SMTP id i24-20020a17090adc1800b00209853d0ec6mr1938330pjv.29.1668111061014;
        Thu, 10 Nov 2022 12:11:01 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id b16-20020a170902d51000b00186b9196cbesm64369plg.249.2022.11.10.12.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 12:11:00 -0800 (PST)
Date:   Thu, 10 Nov 2022 20:10:57 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Li, Xin3" <xin3.li@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [RESEND PATCH 4/6] x86/traps: add external_interrupt() to
 dispatch external interrupts
Message-ID: <Y21a0f8V5rxkJiXQ@google.com>
References: <20221110061545.1531-1-xin3.li@intel.com>
 <20221110061545.1531-5-xin3.li@intel.com>
 <Y20lyBl67GDZVOeB@google.com>
 <BN6PR1101MB2161BDB955216695E1951C2EA8019@BN6PR1101MB2161.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN6PR1101MB2161BDB955216695E1951C2EA8019@BN6PR1101MB2161.namprd11.prod.outlook.com>
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

On Thu, Nov 10, 2022, Li, Xin3 wrote:
> > > +__visible noinstr void external_interrupt(struct pt_regs *regs,
> > > +					  unsigned int vector)
> > > +{
> > > +	unsigned int sysvec = vector - FIRST_SYSTEM_VECTOR;
> > > +
> > > +	BUG_ON(vector < FIRST_EXTERNAL_VECTOR);
> > 
> > Why not return an error up the stack?  KVM and/or CPU bugs aren't unheard
> > of.
> > Dropping an IRQ obviously isn't ideal, but there's a non-zero chance that letting
> > KVM WARN and kill the VM will keep the host alive and thus other VMs
> > running.  A somewhat sophisticated setup might even react to the VM being
> > killed by migrating other VMs off the system and initiating host maintenance.
> 
> Make sense.
> 
> What about having it return a signed integer?

Ya, the standard 0/-errno will do nicely.
