Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 366EE6D4C02
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 17:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbjDCPfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 11:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232858AbjDCPfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 11:35:07 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E379B1BE1
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 08:35:05 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id c18so28378416ple.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 08:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680536105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fR2s9+JDNNa1uEdAtZHMM34i2EJ2xvvS10PJPUpk8Tw=;
        b=JeEDSZDdrhUuzUy391WQWKkkvpcdSBaOtDd6sAfXdgcQ0si3zVaG88tzCJbsDWfpqE
         /oiggCHPIWfK8U+lMtNOrAqJQgCDxFhVmkKjISMu9m3FeCArnhwiN58oCX0cd5ihNmVB
         dt5+py3or0hapeKq3ptfUgORdG6Ym8ZNkZbmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680536105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fR2s9+JDNNa1uEdAtZHMM34i2EJ2xvvS10PJPUpk8Tw=;
        b=sLacMPr/1Avi9JEtmpBmw13VGniyonCqcqqddeZhx/oPqkOOWswwC921ZzS1FkFyGF
         rksZMSsDDU+EJMcrFxglZnurKINj55QaVvvInpu+2PVxalw//vi+9l6s3SuYSx48nT9V
         ddIMbosKAZjYzcuY6DJjJEFDXFI3bE9JyWTBezONNSWC3DuKJUmoyRBpickBUSRejNl9
         r/ogYWIu2wHHZFko3vSqFUWVorWM7jLxQiASzvVRvpdjhyhK4gvsR+QgZGESO9WMRJ2n
         kzg8c3UFHzx95Q8WK4/nssxhArnfhazvD8Iq9LF6tJeNWAoZVmSHz3+QzbszYK1k8nLx
         Py2A==
X-Gm-Message-State: AAQBX9dwnvDjN9vZ9RevGNb/l+icncermgxT12NdTYwlYE2JG1HnHTc3
        PWB7tf9L5mYyP+AHVa/UehOMBw==
X-Google-Smtp-Source: AKy350bwl32I78BgAl9N4MzmN3dvEOxV4sQ+JOgKQSF9qprd8wneNSZznscrcTCeXOmUCL/RBqng+g==
X-Received: by 2002:a17:902:e847:b0:19e:d6f2:feea with SMTP id t7-20020a170902e84700b0019ed6f2feeamr46232340plg.9.1680536105355;
        Mon, 03 Apr 2023 08:35:05 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id t12-20020a170902bc4c00b001a1d4a985eesm6698057plz.228.2023.04.03.08.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 08:35:03 -0700 (PDT)
Date:   Tue, 4 Apr 2023 00:34:58 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Jaewon Kim <jaewon31.kim@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Jaewon Kim <jaewon31.kim@samsung.com>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        GyeongHwan Hong <gh21.hong@samsung.com>
Subject: Re: [RFC] vsprintf: compile error on %09pK
Message-ID: <20230403153458.GE12892@google.com>
References: <CGME20230403104617epcms1p383bacbca705c0d7e4fffca6833050e42@epcms1p3>
 <20230403104617epcms1p383bacbca705c0d7e4fffca6833050e42@epcms1p3>
 <ZCrMMQt2xnnZIyz6@alley>
 <CAJrd-Uvzy18SfjjqbqZCPHjw+ujQXsBpvov4b=bfAwZrj=bCAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJrd-Uvzy18SfjjqbqZCPHjw+ujQXsBpvov4b=bfAwZrj=bCAA@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/04/03 23:39), Jaewon Kim wrote:
[..]
> 
> Okay, then we can't use %09pK. I've just wondered because %9pK works.

This is not per printk / kernel, Wformat warnings come from the
compiler.

Per C11 (7.21.6 6):
 0  For d, i, o, u, x, X, a, A, e, E, f, F, g, and G conversions, leading zeros
    (following any indication of sign or base) are used to pad to the field width
    rather than performing space padding
    ...
    For other conversions, the behavior is undefined.

So using 0 for p should trigger an undefined behavior as far as the
standard C concerned. Unless I'm missing something.
