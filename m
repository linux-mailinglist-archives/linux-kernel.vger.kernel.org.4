Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35D96D07B0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 16:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbjC3OH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 10:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232333AbjC3OHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 10:07:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DFBAD0C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 07:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680185149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R4zCvOc1mMH56XgSR/h8YQ6LP3eLzSrZLD7OODqShKc=;
        b=McFGJYodP73y6IottNzJ6yX0TZJrfAIN30PV3nYKswcSuRh/NON7F69iL9BsOFr5pSBpem
        g7zU2XzJAuafhVST54AZFgWIsaF/UoaahnMJt0hDnA7wQ5SQGpPy6FB2uIydS7OioMRapC
        OcH7PZRJzWgv8q31JCPTKMtGaje62ik=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-DJKpS5O_PjC4oCAJ9HoPVQ-1; Thu, 30 Mar 2023 10:05:42 -0400
X-MC-Unique: DJKpS5O_PjC4oCAJ9HoPVQ-1
Received: by mail-oi1-f200.google.com with SMTP id f18-20020a05680814d200b003877ce3bfb4so4449881oiw.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 07:05:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680185141;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R4zCvOc1mMH56XgSR/h8YQ6LP3eLzSrZLD7OODqShKc=;
        b=h+i4iraN33TcENOKx3tKTIIVMr0+5uBrOpihFsfVrRtZ2mJvv/xjOATHnoEgECFeWo
         lUL9rN+GJJ+LwH7UmawrCDc2WZ/lKC3JZN1Xt83cyxPggRx+cgy/Zu9WgwNh9tLa+ljl
         vKI9LvBu+cPuCGUnBlcaRAblnOwkINZAHsGiLjkrgsxmVOK1Wz1KSkwfkmcBDmDJ1ltF
         RD/PRl8pGuDG/nr041gWIcK0fbnGtoJ5IRKbcDMqFqxtV1EBX3jDc3wAqUq2wowzjjQG
         YuG/3XWyXtlvqY4q9oPes5CmeMpY3jRIh5X8oPR+smEmBCaJZTwGmHtRUDxwT+J2W7yg
         jyrw==
X-Gm-Message-State: AO0yUKUbyBjXonak+b/T/GtyMyrcMRjRig1VmTWjFoRGBbCnoIEvDJ1G
        GOQxDO5/FmKFG8bh+h0lYAbZ8wIkInnX1H2zXr3Z6/IDc126Fi0po6nhd7RbUQNQgzEQFbQbAiZ
        X4pkogxH2up4cWil4vxOuxotE
X-Received: by 2002:a9d:73c2:0:b0:68f:2134:9a3a with SMTP id m2-20020a9d73c2000000b0068f21349a3amr13731355otk.30.1680185141707;
        Thu, 30 Mar 2023 07:05:41 -0700 (PDT)
X-Google-Smtp-Source: AK7set/zNPcgN/WnTgj0au7XovwmrXUXk9Y34tj4Bl9Gf9AZeZXE4KpUqaqWU4dfJz20w/H+BfTr3A==
X-Received: by 2002:a9d:73c2:0:b0:68f:2134:9a3a with SMTP id m2-20020a9d73c2000000b0068f21349a3amr13731343otk.30.1680185141411;
        Thu, 30 Mar 2023 07:05:41 -0700 (PDT)
Received: from x1 ([2600:381:4303:f0c4:d889:8469:3106:3568])
        by smtp.gmail.com with ESMTPSA id a20-20020a9d74d4000000b006a11998d20esm7092278otl.45.2023.03.30.07.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 07:05:40 -0700 (PDT)
Date:   Thu, 30 Mar 2023 10:05:37 -0400
From:   Brian Masney <bmasney@redhat.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: add debug message showing which unused clocks are
 disabled on boot
Message-ID: <ZCWXMXdaLdBb9KzL@x1>
References: <20221117105829.256717-1-bmasney@redhat.com>
 <27ded6a4ebd67cef0d4b472a2aea442e.sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27ded6a4ebd67cef0d4b472a2aea442e.sboyd@kernel.org>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 02:49:50PM -0700, Stephen Boyd wrote:
> Quoting Brian Masney (2022-11-17 02:58:29)
> > The clk framework on bootup will automatically disable all unused clocks
> > on bootup unless the clk_ignore_unused kernel parameter is present.
> > Let's add a basic debugging log statement here that shows which clocks
> > are disabled. There is already tracepoint present here as well, but
> > there's nothing like a simple, good ol' fashioned printk for simplicity.
> > 
> > Signed-off-by: Brian Masney <bmasney@redhat.com>
> > ---
> 
> I'd like to see a documentation update instead that covers how to enable
> the tracepoint on the kernel commandline and have it print to the serial
> console.

Sure, I can do that. I see there's a section 'Disabling clock gating of
unused clocks' in Documentation/driver-api/clk.rst where I think this
would be appropriate.

Brian

