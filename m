Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F323747417
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 16:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbjGDO2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 10:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbjGDO1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 10:27:54 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8CDE75
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 07:27:51 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5703cb4bcb4so61422377b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 07:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688480871; x=1691072871;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N4R6luG93HjxPfObPcZTcu6qIcxDhgXDUA+lCxYcsSI=;
        b=C5JP2ukxDAPmAKA6NIKf6hEZ2C3gBylwmmANY0V3PeAYaHs8NwLe2Kt6LxT5NkLeRO
         RvBEySrUxHpc3hRW8zGFXbLOjOkSXQ4EhaviPHv37ev50/kXRW/rkGPFik/K+MGP5JQz
         S9ptD9hM4lR6FOplQUCW6CFDFr9gdPKP4BxtHJjDqrrEXqPmAsNrvMobkHKUpqcm8whu
         sA+X3JfZTQ4qMtj6Iuwou/XkpddH8UGLqqconQyMTehLTQxmqvEzrfv6XB6G0nb0xIrO
         1CZILVDyhyoDUi4/L5SzEHCBT6pUy0R5idmXd/ait83I/VdZcTZOjcxtQHSYGlYQIMB/
         KS8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688480871; x=1691072871;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N4R6luG93HjxPfObPcZTcu6qIcxDhgXDUA+lCxYcsSI=;
        b=AQCKify0DtSda+zTq+eZVSTU952/b+juPYAKmAKXl4Fh6QG0de4iySzEWCVEcP8wm6
         PRv1r/lDzQUxbtB7R95spezMcdO5v7BGggX0l/YcfLKI7hi/hJFMfctfEXTUsSRO0Ro1
         /QE+T/K8wo8L3Y0CREk1rcLsefQcE4TRMyEVpIxwmEdMhsyKvIQWI8RdJFISgfbnbInA
         P8nacNf6LkBpovXjHwzMgFZIFc03ReYtZjfCr6GFPQucodQfKU2n6CohUDexLqu2ZTr3
         jPmXDnwij8dZc0LxvzC3Z40fIomq30yniytmuYdeFDwWc8t5Cl9Tj4J/7x6gN2ER38LN
         0Y9g==
X-Gm-Message-State: ABy/qLbQRgNPgL2SXA095SMCGCiXqu2YuM1wgZSdnueei3aJsHP+Sy9R
        rfNYti1TGixoV2ggaDMN+lQlp89Rbg==
X-Google-Smtp-Source: APBJJlE+jL5PoQn1d0xQeDZ1IrjBRWFO0wQcaRBkAUFB7DmhbAdpa6gM9td1SbWpAOXIhz5atXQkEA==
X-Received: by 2002:a0d:d74e:0:b0:578:5e60:dcc9 with SMTP id z75-20020a0dd74e000000b005785e60dcc9mr10295115ywd.10.1688480870923;
        Tue, 04 Jul 2023 07:27:50 -0700 (PDT)
Received: from serve.minyard.net ([47.184.186.55])
        by smtp.gmail.com with ESMTPSA id x137-20020a0dd58f000000b00577374e8abasm2805974ywd.87.2023.07.04.07.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 07:27:50 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from mail.minyard.net (unknown [IPv6:2001:470:b8f6:1b::37a])
        by serve.minyard.net (Postfix) with ESMTPSA id 20FD91800E8;
        Tue,  4 Jul 2023 14:27:49 +0000 (UTC)
Date:   Tue, 4 Jul 2023 09:27:47 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chengfeng Ye <dg573847474@gmail.com>
Subject: Re: [PATCH] ipmi: fix potential deadlock on &kcs_bmc->lock
Message-ID: <ZKQsY3DXXDbxy0om@mail.minyard.net>
Reply-To: minyard@acm.org
References: <20230627152449.36093-1-dg573847474@gmail.com>
 <ZJwd0UDKYcK9AvSf@mail.minyard.net>
 <9691d898-22a9-4902-871d-73f5dafabf86@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9691d898-22a9-4902-871d-73f5dafabf86@app.fastmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 10:31:02AM +0930, Andrew Jeffery wrote:
> Hi Corey, Chengfeng,
> 
> On Wed, 28 Jun 2023, at 21:17, Corey Minyard wrote:
> > Indeed, this looks like an issue.
> >
> > Andrew, any opinions on this?  The attached patch will work, the other
> > option would be to disable interrupts when calling
> > kcs_bmc_handle_event() in the timer handler.  But then you have to worry
> > about RT.
> 
> Right, I think we'd do best to not over-complicate things.
> spin_lock_irq{save,restore}() are the intuitive choice to me.
> 
> I'll follow up with R-b/T-b tags once I've booted the patch
> and done some testing.

Thanks.  This is in my for-next tree, I'd like to get this in the merge
window, which I believe ends this Sunday.

> >> This flaw was found using an experimental static analysis tool we are
> >> developing for irq-related deadlock.

Will this tool be available for general use?  It's obviously quite
handy.

-corey
