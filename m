Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B936CF9D8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 05:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjC3D5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 23:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjC3D5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 23:57:18 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADCF4C35
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 20:57:18 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id e15-20020a17090ac20f00b0023d1b009f52so20719786pjt.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 20:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680148637;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JU4IGRdim3hIJny1Nw0giZaiCBC5la4ha7AMB9sU7Io=;
        b=DBg2b/uSQNpLhJdikuT2Q7MxvBaOPzIKyMmykMFakq/IKwDwNyjyKoup6hDIbwl/9h
         fDq//W/z1hlz9HCUHHtY+h/jMLq8G4cWaydSHxV1rKpPhWWAWVCE7LO+yoiFOBOCYq7x
         2uO2S0Qvgp4xncykHKiGnLMM9Y7yeo9dkFLBewRikUDKwAhXw0NhRupCiiocaqvFl3LM
         /EY/HFqv64kBh3MigeqgiKojhADKnNVU1knmYYbGzWWzLSFQNCWPvCiJmoUEjGDyW+aQ
         uHDlcF4AGGc1fgqdMieZ/H1nUXmv0CENka3ouyMwUhQgDL9fXj+6N5SRjVCwEFDOlgjv
         kuRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680148637;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JU4IGRdim3hIJny1Nw0giZaiCBC5la4ha7AMB9sU7Io=;
        b=27DxUAh/rqywTp15XwN9lpc45/cQKCyfPJFZOwDy9pKTT728UOq255t6tknNkHXwPn
         qHQFKwZ13ZtFSYcTjCq7Wz/ul5hQwdZiipr4krMa3l50eITYU8ftIZnolFQGGFDHqsh+
         +a8gzgi2KYM5MTv2Q306BVZlvtvcLEjIVhLmWyKTFa2GM8zED+lbdu6SLEklG2fn7rkU
         eHhtCFLM5H/0n4JbBWFXXWtuRa/MA/QRhBA6yKlXYXPXrCeAoi2zYRayM3RWpxvNKxqY
         CL0xzT/ta2j0JBwYP8DKXiBhDZ6GtdQGNfzUL7c+von/u6WGQQlkAqOYIKiEQGCMlJQF
         uoaQ==
X-Gm-Message-State: AAQBX9cPdH3uRqhQTb2kaO9LLsHbwmWvPOAFzIBm924YNs6J2f9S1EXS
        wZUPrdBrc1dsY/rOQGQ9A9RsvQ==
X-Google-Smtp-Source: AKy350aGqES3kV09M5oeABshrTCIgAD2+dUCG2Zj7t8GUsCabfOQ2vOXD3ODafTfkRgSe5ku2r3E3w==
X-Received: by 2002:a17:90b:374b:b0:23d:1a32:56d5 with SMTP id ne11-20020a17090b374b00b0023d1a3256d5mr24891070pjb.27.1680148637518;
        Wed, 29 Mar 2023 20:57:17 -0700 (PDT)
Received: from localhost ([122.172.85.168])
        by smtp.gmail.com with ESMTPSA id b5-20020a17090a5a0500b0022be36be19asm2128616pjd.53.2023.03.29.20.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 20:57:17 -0700 (PDT)
Date:   Thu, 30 Mar 2023 09:27:15 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: Fix policy->freq_table is NULL in
 __cpufreq_driver_target()
Message-ID: <20230330035715.hckcbf4xpsi5cwhz@vireshk-i7>
References: <CAJZ5v0iWkJw3KP7sfyDOyYsEkdOxxPhkYiYZMvd78geofGEECQ@mail.gmail.com>
 <20230329133600.908723-1-yajun.deng@linux.dev>
 <b0e52380c54775073d44bc97f823ec4f@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0e52380c54775073d44bc97f823ec4f@linux.dev>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-03-23, 01:39, Yajun Deng wrote:
> March 29, 2023 10:21 PM, "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> 
> > On Wed, Mar 29, 2023 at 3:36 PM Yajun Deng <yajun.deng@linux.dev> wrote:
> > 
> >> __resolve_freq() may be return target_freq if policy->freq_table is
> >> NULL. In this case, it should return -EINVAL before __target_index().
> > 
> > Even so, __target_index() itself doesn't dereference freq_table
> > AFAICS, so arguably the driver should be prepared to deal with a NULL
> > freq_table which comes from it after all.
> > 
> 
> But there is a statement 'unsigned int newfreq = policy->freq_table[index].frequency;'
> in __target_index(), if driver doesn't provide freq_table, __target_index()
> will fault before the driver itself.

Driver must provide a freq table here.

-- 
viresh
