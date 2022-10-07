Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2020B5F736D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 05:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiJGDuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 23:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiJGDuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 23:50:06 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3128B1FCD4
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 20:50:01 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id e11-20020a17090a77cb00b00205edbfd646so6137017pjs.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 20:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QJV+qm5YFFiznBqhy0lPgYnioHuBBK2LI/jJC4Wt6/0=;
        b=K7FtXe2lgnfARccniRXk8NU9SjejL3DLeQ9TGBThaSeXN+j8P0jRiZ2Z4vExivTKii
         fB8kLmh6BDHs78+SLNoP+ZT7uyZn7VwYUSg3uDOV+Ccsa9LPSK7LKchYu3q082wfTXTc
         kAXeY7Ck3lM8pqsfGwSVYssedBc8P4uZb4dXvdlSwOGpF7GtBypu74pobADDkbDQJfS9
         pbr3NQMEzoD+4vhQc2AmoPeiYvJcjnhsTcnCxevdNlXlrjrpeHeuFnoG1fkO3UxaCMr4
         1OKknIlOqRIPrgp8V/ddnBpD9dTcNduOMnWd7AzmxTCeDcSbw5ncZNubkXyFQvydxg/7
         se/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJV+qm5YFFiznBqhy0lPgYnioHuBBK2LI/jJC4Wt6/0=;
        b=CLjYDfIeIXPWSD4XB/NVtdUtdukhZOIfNEyMPce46SzcSUsQCUf/fFlBO4+iYqDSnA
         kpQM/nTsoDEa9+VfQmN5WATexXVbVZmvT8JRoBHCh0lTQd1rIXdUEHOITup+qhdAQXb1
         js57fIIBPfcwdgECjIFa/T8f8BgMVTkmmIczGyNX23njYEpN1WG5LudPuh1M2/Ve0gok
         SFoqgqR9HvvabteU8wqAR4bpxhBCPAB18Mrj9Q6/hWH+GOdw8dThOhMgZL4AwM0T3CoU
         L7OVjTaPeClv65Z8tPAXHFoX2J6SlrSn89ksy3AYbMEzHkKdg+359IrWW+JygfdzEZ6T
         Rrhg==
X-Gm-Message-State: ACrzQf331IYbF6iVAUmEY2tWZCjeCD6YTt647ywuDZkmFgdOP2wXyZqM
        ylr2+r7QSOQYlMcTuztqKCKeSA==
X-Google-Smtp-Source: AMsMyM7ZwrpwCHd+5QHfW0XpJ3EKIi7cgd1qJwnX9OVy1i3qhA0wrZklq7ArKdAyv0wtkVlNeFasnw==
X-Received: by 2002:a17:90b:4d05:b0:202:ec78:9d73 with SMTP id mw5-20020a17090b4d0500b00202ec789d73mr3115970pjb.103.1665114601298;
        Thu, 06 Oct 2022 20:50:01 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902f7cc00b001781a7c28b9sm380109plw.240.2022.10.06.20.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 20:50:00 -0700 (PDT)
Date:   Thu, 06 Oct 2022 20:50:00 -0700 (PDT)
X-Google-Original-Date: Thu, 06 Oct 2022 20:49:53 PDT (-0700)
Subject:     Re: [PATCH v2 1/4] RISC-V: Fix ioremap_cache() and ioremap_wc() for systems with Svpbmt
In-Reply-To: <YzQ6pqykLhJVeD2p@infradead.org>
CC:     apatel@ventanamicro.com, Paul Walmsley <paul.walmsley@sifive.com>,
        atishp@atishpatra.org, heiko@sntech.de, anup@brainfault.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        mchitale@ventanamicro.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Christoph Hellwig <hch@infradead.org>
Message-ID: <mhng-96bfb7a5-6579-4ebc-9517-db2e62d2f82b@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Sep 2022 05:14:30 PDT (-0700), Christoph Hellwig wrote:
> On Thu, Sep 22, 2022 at 09:35:56AM -0700, Palmer Dabbelt wrote:
>> Sorry I missed this, I thought it was just part of the rest of this patch
>> set.  That said, I'm not actually sure this is a critical fix: sure it's a
>> performance problem, and if some driver is expecting ioremap_cache() to go
>> fast then possibly a pretty big one, but the only Svpmbt hardware that
>
> More importantly nothing should be using ioremap_cache at all.  It is
> an API that has long been deprecated in favor of memremap.

There's a few uses of it, I just send along a patch to make it 
arch-specific and make the users depend on it.  That should let us stop 
adding this to ports just to get the drivers building.
