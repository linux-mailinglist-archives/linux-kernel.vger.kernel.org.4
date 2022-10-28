Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D97610B73
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 09:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiJ1Hkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 03:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiJ1Hkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 03:40:42 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C371843E4A
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 00:40:40 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5so2499526wmo.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 00:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i2N6u0rpi5MSxrtESZE6Q60hmeXl2yrT4Q/yzn9seGQ=;
        b=AoCvpD2g8hOJXZ2R+h0TvZDHfaokVkjBrIgJhsnS+RetduEnMeG2bCCW5x/1wmwm7y
         tpBT95DdI7WubCuwdur/JGKGBJMJTmP2C+cDmuRV2EIc6vAsZ3DUgxOdepf3Ri0V5o/g
         s61UXLKKrJMPwJgSYbyvTnZ2kLiEieceMzgGWlWdWLree/oXrw+5/Cgog666CiUnyi5H
         iiuCQyE6pPGPEBhy4h9c2slAcvDIj2QVcAFikE7NBHa9TvAFyRkoKz9Xmr0z/0PG8Ue7
         mIV0FWee9ddQzPpFwF4bakArR7lyrUpkkh9KC8i6sE/VKS8eJ/p/NH5MjHPo/bG55EaI
         zcvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i2N6u0rpi5MSxrtESZE6Q60hmeXl2yrT4Q/yzn9seGQ=;
        b=dvgvxoyjW/C/agv7tfFgKqFm6gJusbYAHlE8mN3OydsnOLA35oE6kHq306L++bbtgu
         CGsQbQrk01kKyat1dSjPwyBMnaFSI/RASpDut0E0hY0WmWnun9jsbl08qw5ql9giZ6Jb
         YOI56KS7f5vQvskkZHEbiGWtUF68V2AiacGRQIu3H4E9nhxc5X+2jF0dVqUjDyA8ie+A
         n5FJxUqi5LKaIELXyU8UWH8W1+NqK9E4PscjEJ2jmfIRNxD4iXSN/uMXpMh/blfGWMPz
         ALo5chrIguzwXlmAnQ2byDRbqApnzHDO6SG/cxk839O3cTKizhN5oL1tfb+Oz0NCmd18
         o04A==
X-Gm-Message-State: ACrzQf1rt0aVtU5+m3uCkO3nkf6UQ3H8osgyR5lH0PE2Kcizc56c/RHe
        eVRTVo6c8H3zdLdAAsZZ3SBqJA==
X-Google-Smtp-Source: AMsMyM6b9ooO2YT2Bk853NHb7QqLyKbP8a68ufEkfEtecmJkMMeYnDPuL+24oxMQM0KqoQzia6z3ug==
X-Received: by 2002:a05:600c:3b88:b0:3c6:cef8:8465 with SMTP id n8-20020a05600c3b8800b003c6cef88465mr8354486wms.64.1666942839337;
        Fri, 28 Oct 2022 00:40:39 -0700 (PDT)
Received: from localhost (cst2-173-61.cust.vodafone.cz. [31.30.173.61])
        by smtp.gmail.com with ESMTPSA id j3-20020a05600c1c0300b003b4ff30e566sm12687932wms.3.2022.10.28.00.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 00:40:38 -0700 (PDT)
Date:   Fri, 28 Oct 2022 09:40:37 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     x86@kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, yury.norov@gmail.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        openrisc@lists.librecores.org, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Fix /proc/cpuinfo cpumask warning
Message-ID: <20221028074037.ksvtvzajyulm3oy2@kamzik>
References: <20221014155845.1986223-1-ajones@ventanamicro.com>
 <mhng-b3bcbdea-1572-44ba-9d9a-e35e55b8880f@palmer-ri-x1c9a>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-b3bcbdea-1572-44ba-9d9a-e35e55b8880f@palmer-ri-x1c9a>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 04:07:18PM -0700, Palmer Dabbelt wrote:
> On Fri, 14 Oct 2022 08:58:43 PDT (-0700), ajones@ventanamicro.com wrote:
> > Commit 78e5a3399421 ("cpumask: fix checking valid cpu range") has
> > started issuing warnings[*] when cpu indices equal to nr_cpu_ids - 1
> > are passed to cpumask_next* functions. seq_read_iter() and cpuinfo's
> > start and next seq operations implement a pattern like
> > 
> >   n = cpumask_next(n - 1, mask);
> >   show(n);
> >   while (1) {
> >       ++n;
> >       n = cpumask_next(n - 1, mask);
> >       if (n >= nr_cpu_ids)
> >           break;
> >       show(n);
> >   }
> > 
> > which will issue the warning when reading /proc/cpuinfo.
> > 
> > [*] Warnings will only appear with DEBUG_PER_CPU_MAPS enabled.
> > 
> > This series address the issue for x86 and riscv, but from a quick
> > grep of cpuinfo seq operations, I think at least openrisc, powerpc,
> > and s390 also need an equivalent patch. While the test is simple (see
> > next paragraph) I'm not equipped to test on each architecture.
> > 
> > To test, just build a kernel with DEBUG_PER_CPU_MAPS enabled, boot to
> > a shell, do 'cat /proc/cpuinfo', and look for a kernel warning.
> > 
> > While the patches are being posted together in a series since they're
> > for two different architectures they don't necessarily need to go
> > through the same tree.
> > 
> > v3:
> >   - Change condition from >= to == in order to still get a warning
> >     for > as that's unexpected. [Yury]
> >   - Picked up tags on the riscv patch
> > 
> > v2:
> >   - Added all the information I should have in the first place
> >     to the commit message [Boris]
> >   - Changed style of fix [Boris]
> > 
> > Andrew Jones (2):
> >   RISC-V: Fix /proc/cpuinfo cpumask warning
> 
> I just took the RISC-V fix, might be worth re-sending the x86 one alone as
> nobody's replied over there so it may be lost.

Thanks Palmer. I still believe this fix is a good idea, or at least
not wrong, but as the cpumask change which started the warnings was
reverted (commit 80493877d7d0 ("Revert "cpumask: fix checking valid
cpu range".")) it seems the urgency for fixes like this one was
reduced. I'll ping the x86 patch to see if it's still of interest
or not.

Thanks,
drew
