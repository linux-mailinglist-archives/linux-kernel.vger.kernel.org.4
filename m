Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0AC6639D6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 08:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbjAJHWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 02:22:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjAJHWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 02:22:52 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41CF41D7C
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 23:22:49 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id o15so8058302wmr.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 23:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1yzQ3j4TmqF8Cm/sfXHUUAfEUTHBzXvGd1lVdd2sPyA=;
        b=bBcjHXfK5dT9Iu4HkcOAUovMpWYLht1OfdbnlhWDvHZA/+azWYiOpzZFtbpcuH3Jei
         R/uvEC1DxwCZzmJFIqwAdDbC0UY/MGTt6Sj6laZJBsBd7PbO0IBcRVjd5ulk1zSp6BnA
         30xAsWAVt5H9a+j3FSn9KOBqAM6fxAocoxDR3zymeV5welDJue/WhJuAk80n7htsZoWA
         hkpIxlzLknNZ3jP5HsSy3ZU4bQcVpAHF9Ei2xlX8P990kcitL4Q641Magx69Znr7DIK/
         QwphxanaE2Cgzixrga8dtFEloZiUa2I/GA3SM8pbpveI2SIFrwikqvDxTD1O7mPoNI5D
         OeKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1yzQ3j4TmqF8Cm/sfXHUUAfEUTHBzXvGd1lVdd2sPyA=;
        b=G5cnNEwv0sS+3+cGegfg3hTLocWP+3nMNDz772of0SRnteOYGMaNHqaLwfSxeok0oY
         K3mdZHpFJ+FOS8nPJMKs/J7OErpIvSqEN7EkkwVmouXGDH8781GLLdb/g4eU4BGgtQmP
         cdX0GhMP5oqaejZzUXOcJ/DTYH4apsQrkNPCa29r1/wOthcuv4iaRDcQoRpTCH9hjTUN
         p1T8CGBVjDmi0+h+Mj+S8JIrst3em8Vfcf/wJwZ+mbPusjn8tn2Uz10LLCum7RtPkC+f
         HiZy3DaeTZkUzglqAlyIZ5WxkrWQvTTkF94WmjqpERMo/U50xKJfHYiCW8o+GZKmqElT
         lhYg==
X-Gm-Message-State: AFqh2kpo8PDOzZeTIHIEzF5WnW6ffpyNYYqlR7Yle8CwQfv6faBJRYLr
        LXzhTrZNlzRi7yxpgW2mrxjSYVchIQXXV3a+
X-Google-Smtp-Source: AMrXdXuNeeP7o90r06Zmki9dKcq5KHqdu3zDOlKt8N7T1bhug9L3jZ7kKeejVOsoBrZ1Tt+kye7CmQ==
X-Received: by 2002:a05:600c:3506:b0:3cf:803b:d7cc with SMTP id h6-20020a05600c350600b003cf803bd7ccmr51526311wmq.33.1673335368347;
        Mon, 09 Jan 2023 23:22:48 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id hg9-20020a05600c538900b003cfa622a18asm18081219wmb.3.2023.01.09.23.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 23:22:48 -0800 (PST)
Date:   Tue, 10 Jan 2023 08:22:47 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     JeeHeng Sia <jeeheng.sia@starfivetech.com>
Cc:     Conor Dooley <conor@kernel.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Mason Huo <mason.huo@starfivetech.com>
Subject: Re: [PATCH v2 3/3] RISC-V: Add arch functions to support
 hibernation/suspend-to-disk
Message-ID: <20230110072247.xtptnodxjshbfh5s@orel>
References: <20230109062407.3235-1-jeeheng.sia@starfivetech.com>
 <20230109062407.3235-4-jeeheng.sia@starfivetech.com>
 <20230109193624.iiuguwgimpn7zbyw@orel>
 <Y7xu/Oj07F7/e8F1@spud>
 <d03e4bf7832f48d7aabd07dfd13a3e92@EXMBX066.cuchost.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d03e4bf7832f48d7aabd07dfd13a3e92@EXMBX066.cuchost.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 07:00:38AM +0000, JeeHeng Sia wrote:
> 
> 
> > -----Original Message-----
> > From: Conor Dooley <conor@kernel.org>
> > Sent: Tuesday, 10 January, 2023 3:46 AM
> > To: Andrew Jones <ajones@ventanamicro.com>
> > Cc: JeeHeng Sia <jeeheng.sia@starfivetech.com>; paul.walmsley@sifive.com;
> > palmer@dabbelt.com; aou@eecs.berkeley.edu; linux-
> > riscv@lists.infradead.org; linux-kernel@vger.kernel.org; Leyfoon Tan
> > <leyfoon.tan@starfivetech.com>; Mason Huo
> > <mason.huo@starfivetech.com>
> > Subject: Re: [PATCH v2 3/3] RISC-V: Add arch functions to support
> > hibernation/suspend-to-disk
> > 
> > On Mon, Jan 09, 2023 at 08:36:24PM +0100, Andrew Jones wrote:
> > > On Mon, Jan 09, 2023 at 02:24:07PM +0800, Sia Jee Heng wrote:
> > 
> > > > To enable hibernation/suspend to disk into RISCV, the below config
> > > > need to be enabled:
> > > > - CONFIG_ARCH_HIBERNATION_HEADER
> > > > - CONFIG_ARCH_HIBERNATION_POSSIBLE
> > > > - CONFIG_ARCH_RV64I
> > > > - CONFIG_64BIT
> > 
> > > What's blocking this for being for both 32-bit and 64-bit?
> > 
> > Just from checking with b4 diff, it's because I told them they broke the
> > rv32 build with their v1 implementation.
> > 
> > I'd rather they fixed whatever the issue was with rv32 than ignored it.
> The main reason is because I don't have a rv32 system to verify the rv32 hibernation.

QEMU?

Thanks,
drew
