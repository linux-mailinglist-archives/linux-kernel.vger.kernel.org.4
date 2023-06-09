Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D4472A639
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 00:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjFIWYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 18:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjFIWYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 18:24:42 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E27359D
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 15:24:41 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-53482b44007so909954a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 15:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20221208.gappssmtp.com; s=20221208; t=1686349481; x=1688941481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RjHkTs/1sQfg/6fnh81D5Wy2dtYUMRhDLSRX/atoCKk=;
        b=4aSt66Xzk8RP2IwTk8XYQptRViNK0Pw2YdcTi/NOH23vkJGP5DbX9+rjptyVjZiuNO
         qkSeFrkQDSB+kS8kCiqWd2XCdg3RId/UKPLl1p5h5QOX/8ej7DnQcvf3tLcNRDPzr7hO
         eNW3YMV40UpArd0xPdNZJrHqAOKIP+7B8PXfi9RS+QW63BFNwYJGkhMAsrPEdMbF7Ccu
         8cNv/HoD8vQTpKNDP1Ow3EGZ3SX6fQ2NUi37+q4nVlA8OodxJ/FGIEVjoQxCZKbcZBuQ
         EiIAJAVHyYppuFluD6vrWyReojtebjLo7MJ9VC55+NYnKzYYBtw+LeRzy+shAWmlFqMy
         NhnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686349481; x=1688941481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RjHkTs/1sQfg/6fnh81D5Wy2dtYUMRhDLSRX/atoCKk=;
        b=j1o/WwITTa3DucixCazXQFg8fC8gRDDTuBSsZssToiHBU/OEisHYOXKvctQncm4AS5
         pIKJe+VU5ywJ0CiG3GUoDjvn0z+5EhrSixFrr1YRMAiQxCkOdiE0k2uFLnnLnpWki7Bz
         n8xbkpqdkSzqhlBrkm01rttIEHN4wL7m5nCnAJnth6Ge+kUzel/XPNbCNJt1y+QxBZv3
         AW/ZfMz7L0YdZY2fsV35TWoDGxAE9Whne5vPHdpbPiaTszgIBRkOmvsPQzJVrF9M697z
         aPSFsr/HHpVzIvjzkktbWGTPhx2ofH5ACzNABoS3jbgz46QEiAcBHYYuGc1YlwzCR5J5
         QO+g==
X-Gm-Message-State: AC+VfDxPsIG3kTbnQnQaaMUu1lpBx0Z70GNBeTG7Pbfx98dkqvmHRM8d
        /VnorNmQjFjgatzj9E6CoNpwGA==
X-Google-Smtp-Source: ACHHUZ4bUs89h66eeeq5/ioNpudHmJZZFyvF3fKQ2X4WOyT1P+7YX4wbCFMI2qelHrTpEP6DZ16jvg==
X-Received: by 2002:a17:90a:1fc7:b0:258:de21:f237 with SMTP id z7-20020a17090a1fc700b00258de21f237mr1980381pjz.9.1686349480492;
        Fri, 09 Jun 2023 15:24:40 -0700 (PDT)
Received: from telecaster ([2620:10d:c090:400::5:eb84])
        by smtp.gmail.com with ESMTPSA id qa2-20020a17090b4fc200b002310ed024adsm5162082pjb.12.2023.06.09.15.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 15:24:40 -0700 (PDT)
Date:   Fri, 9 Jun 2023 15:24:38 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-debuggers@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] x86/unwind/orc: add ELF section with ORC version number
Message-ID: <ZIOmpuqLTJROYQt8@telecaster>
References: <5b70bc58ef70aab0a821111cd3201eeced8bab95.1686263379.git.osandov@osandov.com>
 <20230609220430.agw2rtswmjbquzom@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609220430.agw2rtswmjbquzom@treble>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 03:04:30PM -0700, Josh Poimboeuf wrote:
> On Thu, Jun 08, 2023 at 03:38:38PM -0700, Omar Sandoval wrote:
> > Hi,
> > 
> > As mentioned in the commit message, the motivation for this patch is
> > allowing drgn to continue to make use of ORC for kernel stack unwinding.
> > 
> > I want to make it clear that I don't want ORC to be stable ABI. The
> > kernel is free to change the format as much as needed, I just need a way
> > to detect the change. (drgn already pokes at many kernel internals and
> > needs updates for most kernel versions anyways. We have a big test suite
> > to catch changes we care about.)
> > 
> > I'm not at all married to (or proud of) this particular implementation;
> > I'd be happy to use anything that lets me detect the format version in
> > both cases mentioned in the commit message (ELF file or core dump +
> > symbol table).
> > 
> > It'd be great if we could get a solution in before 6.4 is released. I
> > would've reported this sooner, but I just got back from paternity leave
> > last week.
> 
> Hi Omar,
> 
> Peter and I agree this seems fine in principle.

Glad to hear that!

> Though, instead of
> using an incrementing version, Peter had the idea to hash the struct,
> like:
> 
>   awk '/^struct orc_entry {$/ { p=1 } p { print } /^}/ { p=0 }' arch/x86/include/asm/orc_types.h | sha1sum
> 
> That way we don't have to remember to bump the version number, and it
> would be more resilient to partial backports in distros.
> 
> Would something like that work for you?

Any sort of unique identifier works for me. One thing that the proposed
hash wouldn't catch is if ORC_REG_* or ORC_TYPE_* are ever renumbered
(i.e., the meanings of existing values change). It also wouldn't catch
if something about the .orc_unwind_ip section changed. But assuming
changes like that would be much rarer, it could be handled manually by
bumping a "salt" for the hash. E.g., by adding 'BEGIN { print <SALT> }'
to the awk script:

awk 'BEGIN { print 1 } /^struct orc_entry {$/ { p=1 } p { print } /^}/ { p=0 }' arch/x86/include/asm/orc_types.h | sha1sum

I'll defer to you guys whether it's easier to remember to bump a version
everytime or only in those rare cases.

Thanks,
Omar
