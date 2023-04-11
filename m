Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC37D6DDD33
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 16:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjDKOEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 10:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjDKOEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:04:11 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A6830CA;
        Tue, 11 Apr 2023 07:04:03 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id z16so5135107oib.9;
        Tue, 11 Apr 2023 07:04:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681221843; x=1683813843;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aewvq7Qyi31VTr5PdaFcbjGaZV7Zh9U8Jss5DyPyZ6k=;
        b=N83P46YZqXyn2sFCjGzwLWiJes3CIoAf6dJvG+33Iftm/ry5R8pp/eK36aA5ddpIlQ
         Qj5sXKMympjasoB/Wwp0ARIjQR0H3Fmnj3wFMVGs5phRFFYuOzvyuGedXeQKzZ87I8EL
         iJgXOnk1kx3FrIc/+uHQvIQgcalEXR+N8y6AxL77g41CKwFB5e0uPOXMy0mVxHnwK+oy
         ghexeUOa13mdY/ldv0KnGM8bOoaPwnI4SAAtkwfg0fnK0w2pnmlIPoZx++OopcIOWHy7
         X7Mf/eOSFvn122dWmqvEc8U63QJAJqmgNMHttoeo5/ktjyRTK2xVGZJ1odKNB3ht2HPT
         uX5g==
X-Gm-Message-State: AAQBX9f2biSlQa05XczewTMPzqJYGUP6GPSEKzcHaJAtoPwInURDqzMp
        6HkWf07kHcqsUN7r1PEqbA==
X-Google-Smtp-Source: AKy350ZtVObD4H0kcB6Kxrdgy3xaGWSl03KtG/6TAmlqg3kjYEkbJgm/DeGs/e+KiMT4OJJnhxHjjg==
X-Received: by 2002:a05:6808:249:b0:387:1e71:e4d3 with SMTP id m9-20020a056808024900b003871e71e4d3mr5213892oie.11.1681221842953;
        Tue, 11 Apr 2023 07:04:02 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u10-20020a056808150a00b0037832f60518sm5550740oiw.14.2023.04.11.07.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 07:04:02 -0700 (PDT)
Received: (nullmailer pid 2981771 invoked by uid 1000);
        Tue, 11 Apr 2023 14:04:01 -0000
Date:   Tue, 11 Apr 2023 09:04:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH 2/3] clk: mvebu: Use of_get_cpu_hwid() to read CPU ID
Message-ID: <20230411140401.GA2963980-robh@kernel.org>
References: <20230327-mvebu-clk-fixes-v1-0-438de1026efd@kernel.org>
 <20230327-mvebu-clk-fixes-v1-2-438de1026efd@kernel.org>
 <216176104e507b860e24399bf020d836.sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <216176104e507b860e24399bf020d836.sboyd@kernel.org>
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 04:36:21PM -0700, Stephen Boyd wrote:
> Quoting Rob Herring (2023-03-27 11:43:19)
> > Use of_get_cpu_hwid() rather than the open coded reading of the CPU
> > nodes "reg" property. The existing code is in fact wrong as the "reg"
> > address cells size is 2 cells for arm64. The existing code happens to
> > work because the DTS files are wrong as well.
> > 
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> > Note this should be marked for stable so that if/when the DTS files are
> > fixed, then at least stable kernels will work. This is untested, so I
> > didn't mark for stable.
> 
> That makes it sound like it breaks for existing DTS files. Is that the
> case?

No, if the DTS files are fixed, then they will not work with the 
existing code. This change should work for both existing and fixed DTS 
files.

Rob
