Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09BF6FE466
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 21:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236208AbjEJTJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 15:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236162AbjEJTJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 15:09:22 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CEF5592;
        Wed, 10 May 2023 12:09:19 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1aaf2ede38fso74058975ad.2;
        Wed, 10 May 2023 12:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683745759; x=1686337759;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gNlkpGUaNqMczv5xZxW+63h+QrX9tPOqLyoTH2dL8ww=;
        b=OLJZdv6AmTISTbWYQwpUZyTXbqtTVJ1iAoDLVSKxVxHnPFITOpxlrD1BCq8k4uEtIm
         RQjkap2JnxktKZtG4g3eE/X45hhFoWMN1MhhmVNn6N9ij9eShf7FbL/rByZgeAil3kIz
         HstPNDCzD3E7YRa9GNYPM5b602h6IDo2pCPBRNjXT611b35ESKsmei9feY82yu3d2gqT
         mGYRKx3e7HhFmsjYyzTFoc+9kXkS+y/dBKCCGj6ADX/8Zf7dkFo/y0iCYnNLzsqMQpqi
         D+KlWrZNwoYhT4ADbI6D3WkRBj0PPoY4wsmQlJ+FQInP9Z1WAAGK4M9tKyw+qBLJ66iZ
         19Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683745759; x=1686337759;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gNlkpGUaNqMczv5xZxW+63h+QrX9tPOqLyoTH2dL8ww=;
        b=Fcftnhm8JGDiYeKWEDscRGSkgGnEEW3T8tGQwLLTn5jJUasRP9I4APtU3834CTYz/X
         BUUoq5gJiPL2TR1wqbV2/ScA5hNPNStHBAEbbq+e8T0AqVyQOViGCwzkaJ0NJtBwGx11
         FnQ+MIJlOiOxdjAHhp5PLtgGssin96bF1/aM2dgEEGuD5LRxhNTpFyiFrD9Le4+Tj1yg
         tENCmq/gqLa5fIdL9wg7Eht8VaKsFZlxsdhE+qXynshByCyBD+szi+nCQFP+ZIBKQh5s
         dUqJmiss43BMQlN1KfDXiBIulAW4ENqfXzjmp5kVpsIwY4pUG44EMOaLwWkKJH7F3b0J
         XSlg==
X-Gm-Message-State: AC+VfDxMag24mrWpYEtTxpM8hXF1zik3aFd8GD1+as6f7ED5wZ/fb/vx
        PmMPu1zDZzqvAemIxdLe+WE=
X-Google-Smtp-Source: ACHHUZ6zy911nNEAr8uwmueeH7bXhfdjScvRLeumyixtZTCvGmj873SmIL6BncZX/MFFk6be6JhYOg==
X-Received: by 2002:a17:902:c412:b0:1ab:25a6:a54b with SMTP id k18-20020a170902c41200b001ab25a6a54bmr25085985plk.4.1683745758847;
        Wed, 10 May 2023 12:09:18 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j6-20020a170902690600b001a072aedec7sm4154803plk.75.2023.05.10.12.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 12:09:18 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 10 May 2023 12:09:16 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 5.15 000/370] 5.15.111-rc2 review
Message-ID: <b92bf726-cf81-4516-95c4-5aa534662224@roeck-us.net>
References: <20230509030611.521807993@linuxfoundation.org>
 <863a112f-f4a4-d580-9687-f6214d555939@linaro.org>
 <2023051035-monitor-sandy-2a5b@gregkh>
 <CAEUSe79AViqsHimbYbFjkKAxcvROGhFKA2yKVuC3aP1Gm=jc1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEUSe79AViqsHimbYbFjkKAxcvROGhFKA2yKVuC3aP1Gm=jc1w@mail.gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 09:46:14AM -0600, Daniel Díaz wrote:
> Hello!
> 
> On Wed, 10 May 2023 at 01:43, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Tue, May 09, 2023 at 09:12:33AM -0600, Daniel Díaz wrote:
> > > Hello!
> > >
> > > On 08/05/23 21:26, Greg Kroah-Hartman wrote:
> > > > This is the start of the stable review cycle for the 5.15.111 release.
> > > > There are 370 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > >
> > > > Responses should be made by Thu, 11 May 2023 03:05:05 +0000.
> > > > Anything received after that time might be too late.
> > > >
> > > > The whole patch series can be found in one patch at:
> > > >     https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.111-rc2.gz
> > > > or in the git tree and branch at:
> > > >     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> > > > and the diffstat can be found below.
> > > >
> > > > thanks,
> > > >
> > > > greg k-h
> > >
> > > New warnings are introduced for Arm, PowerPC, RISC-V:
> > >
> > >   /builds/linux/kernel/sched/debug.c: In function 'print_cfs_group_stats':
> > >   /builds/linux/kernel/sched/debug.c:465:41: warning: unused variable 'stats' [-Wunused-variable]
> > >                   struct sched_statistics *stats =  __schedstats_from_se(se);
> > >                                            ^~~~~
> >
> > Odd, and this isn't on other kernels too?
> 
> Only on 5.15, not on the 6.x RC's. I'll share more info after my
> bisection is done.
> 

Upstream has

	struct sched_statistics *stats;
	stats = __schedstats_from_se(se);

which may trick the compiler into believing that 'stats' is used.

Guenter
