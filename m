Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A206DE505
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 21:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjDKTbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 15:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjDKTbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 15:31:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4D4135
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 12:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681241423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XSiYd4vLNxCRpyGc8Q8nbzOyNKeYH8lsn9NGk8/RzXo=;
        b=T1MsIAF1Cz7fTIhH4Gty0x/GYYQtl6HPkrUH8B1YrIIgTVVvyyjBrmp32qOKcnQes5NZ0n
        /P/qVvJc5vvn9itVI7t41Jpzr9f8MgVgfBY26YDH/biDzLLj6eaFCaq8ttZ50OGg4dYGDI
        V0YfHwXmVvClsW5yftdv0CAFc5xNf9w=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-G94lIh3wN0OFpgZLffLjqw-1; Tue, 11 Apr 2023 15:30:22 -0400
X-MC-Unique: G94lIh3wN0OFpgZLffLjqw-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-54c23fab905so138465197b3.14
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 12:30:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681241422;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XSiYd4vLNxCRpyGc8Q8nbzOyNKeYH8lsn9NGk8/RzXo=;
        b=Z1YTkiqjZbD9cYNGBHjuy4UfHFLtyH8wxMeSFXEWUXYjtfcaUspjs7HPv5vas2k+s9
         ttnrKyJ5tN4PsZo+ioSmW5tKn4an74z/GHPGdqMCB8vy2r9+YbVFAmC/HQ55Yec2/6LO
         5l/gq34V1AQsLIRyYfdwX8M+MZYYccHA+TBleNkLKIZIiI7Qpw7cBQX5s529h8OqvEYV
         p9Lhc2Igo8dmLFE1hJzXCm5aZ8AXr0m7CMGntX/QhIpPoEEBLBDH7o81jZu2SfH3C0xC
         MGnemxesZM567sWhkuN0D3ly3Ca8DIyt92dVnMcpdq9THssymDcUYYnM/n3i6ltj6IOZ
         GjAA==
X-Gm-Message-State: AAQBX9fkOyL2+ZSadedfa82tRHow8CttiyLZ6kg8ayAX4DqvZQEedrRg
        kkyTKFFuxC30TZOvBFVfdaV4V8DPOEVpG+Aqd3j8yFvbSsoZsYaRuoQzJrH9gPTPtE1IW/GuwsB
        grHGNLHdplTrDrUZbYSAEVO7t
X-Received: by 2002:a0d:e214:0:b0:54f:32a:a26 with SMTP id l20-20020a0de214000000b0054f032a0a26mr3140016ywe.5.1681241421953;
        Tue, 11 Apr 2023 12:30:21 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZsC9iBX9a7B2k91coESrz+mo0Z//dKyhd31vgb3jSIzRwJ96yVRUdmYIaoWCJH5Q3fS8sEXA==
X-Received: by 2002:a0d:e214:0:b0:54f:32a:a26 with SMTP id l20-20020a0de214000000b0054f032a0a26mr3139998ywe.5.1681241421597;
        Tue, 11 Apr 2023 12:30:21 -0700 (PDT)
Received: from x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id 23-20020a810717000000b0054f6f2d291dsm693839ywh.34.2023.04.11.12.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 12:30:20 -0700 (PDT)
Date:   Tue, 11 Apr 2023 15:30:19 -0400
From:   Brian Masney <bmasney@redhat.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: add debug message showing which unused clocks are
 disabled on boot
Message-ID: <ZDW1S7OLRjHzNCB0@x1>
References: <20221117105829.256717-1-bmasney@redhat.com>
 <27ded6a4ebd67cef0d4b472a2aea442e.sboyd@kernel.org>
 <ZCWXMXdaLdBb9KzL@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCWXMXdaLdBb9KzL@x1>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 10:05:37AM -0400, Brian Masney wrote:
> On Wed, Mar 29, 2023 at 02:49:50PM -0700, Stephen Boyd wrote:
> > Quoting Brian Masney (2022-11-17 02:58:29)
> > > The clk framework on bootup will automatically disable all unused clocks
> > > on bootup unless the clk_ignore_unused kernel parameter is present.
> > > Let's add a basic debugging log statement here that shows which clocks
> > > are disabled. There is already tracepoint present here as well, but
> > > there's nothing like a simple, good ol' fashioned printk for simplicity.
> > > 
> > > Signed-off-by: Brian Masney <bmasney@redhat.com>
> > > ---
> > 
> > I'd like to see a documentation update instead that covers how to enable
> > the tracepoint on the kernel commandline and have it print to the serial
> > console.
> 
> Sure, I can do that. I see there's a section 'Disabling clock gating of
> unused clocks' in Documentation/driver-api/clk.rst where I think this
> would be appropriate.

Just to close out this thread, I submitted a patch to the docs tree.

https://lore.kernel.org/lkml/20230411192153.289688-1-bmasney@redhat.com/T/#u

Brian

