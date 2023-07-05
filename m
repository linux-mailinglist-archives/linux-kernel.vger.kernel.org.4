Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBD1748F6A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 22:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjGEUu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 16:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjGEUuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 16:50:55 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DCF1706
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 13:50:53 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-666e6ecb52dso70636b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 13:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688590253; x=1691182253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ATlsphHrvoXPAVcgiiWqGZL+5stGcmqJb7QaGx/TZTY=;
        b=1gi2QGerArOZcqyu8Kq4cOvg8zuziVGn35t26P9TQDCgI7LVvQLzLR3SrXe22/KhrP
         EWezBRP2oL8ktfFwpeG6WuO8igLI6lzBPblZInvrfFpCSRobEpSTk/d4Xq9GBPodT+na
         OlomtymSR32nWGj6shvUrMDfzZYE0meRpSdSqnIuO0y1stYLvYXMTie9SmmuSDf9D3mv
         9wRXi4e8TLS/O6UsyvZxO2WXY0zMb1PNSWyDCYNITe4fmiUf+JNTkBouSyHbVz2fsJ8u
         uPMCZVC8CkWRJ1YMiYIWuiUS7snbABrDkY3drTcOV27FokdQQ2hn6KQObjTeAROmHgAB
         SEVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688590253; x=1691182253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ATlsphHrvoXPAVcgiiWqGZL+5stGcmqJb7QaGx/TZTY=;
        b=exgY2HcgittRNw1mrOJNrh/IE57c7EfxkVQJMvGiWfkuLFw1AhqyeM/VrEqTX7s9k8
         Oi6P1AnTtZTukDaZ6m6PIHnyEwFSx/AJzxNDXZkN0oo20tAYeBDilif0MHy9PO+pW9Fd
         shaALpdS9KiJDzE+nNBdomdCEMLXIfpSQSwhxo788BCrsxVBEj0cQmT2eJMI59Yqkcgs
         rcGETWFmAoEceCE1zhqo6sIpYAzU6ALU9DPUs+EzO1xknpsB1GZHSawoYCEVJZyGMKef
         c15GP83GSyQxaJBxfSWXilLLSLR4rg7Ujw/gRUPs1V10GbAaKeDfCB89kgAGBIen3yXt
         nkUA==
X-Gm-Message-State: ABy/qLbF2/9f7xYoHU7od9DRJHtmqbgjjAqUO1lGk7TlGPi86eI2/VjJ
        PUDIS84RnNOGH+ubeJaXt4X3GA==
X-Google-Smtp-Source: APBJJlF93hFsbARecEfbdb3KDh0+O1N9izJjSFDbX+WwN+rT8t09OpkxZrl422GOlOmeM8zpscifTw==
X-Received: by 2002:a05:6a00:15c6:b0:679:bc89:e45 with SMTP id o6-20020a056a0015c600b00679bc890e45mr18660pfu.6.1688590253188;
        Wed, 05 Jul 2023 13:50:53 -0700 (PDT)
Received: from ghost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id n20-20020a62e514000000b00682b3d14005sm1752015pff.87.2023.07.05.13.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 13:50:52 -0700 (PDT)
Date:   Wed, 5 Jul 2023 13:50:50 -0700
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        paul.walmsley@sifive.com, palmer@rivosinc.com,
        aou@eecs.berkeley.edu, anup@brainfault.org,
        konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        mick@ics.forth.gr, jrtc27@jrtc27.com
Subject: Re: [RESEND PATCH v3 0/2] RISC-V: mm: Make SV48 the default address
 space
Message-ID: <ZKXXquCXkSdFD837@ghost>
References: <20230705190002.384799-1-charlie@rivosinc.com>
 <20230705-gloater-relation-29a6080ec87d@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705-gloater-relation-29a6080ec87d@spud>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 09:00:18PM +0100, Conor Dooley wrote:
> Hey Charlie,
> 
> On Wed, Jul 05, 2023 at 11:59:40AM -0700, Charlie Jenkins wrote:
> > Make sv48 the default address space for mmap as some applications
> > currently depend on this assumption. Also enable users to select
> > desired address space using a non-zero hint address to mmap. Previous
> > kernel changes caused Java and other applications to be broken on sv57
> > which this patch fixes.
> > 
> > Documentation is also added to the RISC-V virtual memory section to explain
> > these changes.
> 
> I can't find a changelog in any of these patches, nor an explanation for
> why this is v3 (or a RESEND). All I can find on the list is a v1. Could
> you explain and provide a changelog please?
> 
> Cheers,
> Conor.

I made a series of mistakes due to an incorrect email configuration. I
knew something was wrong but I didn't know what after I sent out v2. v2
bumped the default address space from sv39 to sv48. The purpose of v3
was to remove an erroneous .gitignore I had included in v2 and also
modify a testcase that was supposed to check the default was sv48 but it
was still checking for sv39. After sending out v3 I realized what was
wrong with my configuration, so I decided to mark it as a resend because
I believe some people did recieve the previous emails.

This is the only patch that made it through to everybody, and includes a
default address space of sv48 instead of sv39. I have tested that
OpenJDK 19 works on sv39, sv48, and sv57 in QEMU on this patch.
OpenJDK 19 failed to work on kernel v6.4 on sv57 but worked on sv39 and
sv48. Applications like Java and Go failing on sv57 were the motivation
of this patch. Setting a default of sv48 will allow applications that
don't explicitly support sv57 to work on sv57 hardware but still allow
applications to take advantage of sv57 by specifying a hint address to
mmap that is greater than or equal to 1<<56.

- Charlie

