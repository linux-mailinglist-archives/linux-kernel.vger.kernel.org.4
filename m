Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E415772C529
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 14:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236077AbjFLM43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 08:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236874AbjFLM4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 08:56:10 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3D71FC9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 05:55:06 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-30fa23e106bso1882772f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 05:55:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686574498; x=1689166498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JI38F6kc7Cl9oBDIHBZUEUTirCnCfKvB5Sv3x2W1g9s=;
        b=JifMR3Bvz8UDpDybvNCAtUwX2LsBHjZ0nQWb+W+y1r4oD00+2wr0PjpQ1KgCKU14KR
         n9GFGrQNVDJb+VXSF3GXd2vUr48dltgo/cHbf34DKnKCiyW6kD/NuSczHNPo0kxFx+CF
         NqQIu8Uucn4cYzSofX2rfO6Akkz1RQDOmZ7WWE5f1qU98i/DyIozn1NgYL05TRDnC0pY
         Vwyxwo9vkoKymah2OPoqaandPcfpjwcO8Mnc5PciONJK4k4sLindKz6Dl2bdrKwDgWLa
         yW6bqzjRYJ8raYGaaGDpeRajrhpBCqGgUV9ZGLIIUWvrlqcZsVz2r0kPqq1qII4JRaEv
         8jnw==
X-Gm-Message-State: AC+VfDzQ5qS1EfOdfYsN08ZmoSkWusiyLwQs2jRF00fyjMhgYhj/zTMe
        nYiItmEW+Z1habQyLdU42tM=
X-Google-Smtp-Source: ACHHUZ4xlXSJiEjZPV67Da+LR39mSbQjtRw9SQdGdn5NiHi0cLADU7S8nJkvvK1jEeOQJymT29XEBg==
X-Received: by 2002:a5d:4911:0:b0:30e:5b7c:de1c with SMTP id x17-20020a5d4911000000b0030e5b7cde1cmr3901549wrq.11.1686574498215;
        Mon, 12 Jun 2023 05:54:58 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-007.fbsv.net. [2a03:2880:31ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id a8-20020a5d5088000000b0030f9c3219aasm10259601wrt.47.2023.06.12.05.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 05:54:57 -0700 (PDT)
Date:   Mon, 12 Jun 2023 05:54:56 -0700
From:   Breno Leitao <leitao@debian.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     bp@alien8.de, pawan.kumar.gupta@linux.intel.com,
        paul@paul-moore.com, leit@meta.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpu/bugs: Disable CPU mitigations at compilation time
Message-ID: <ZIcVoIAQbRl1GTo5@gmail.com>
References: <20230203120615.1121272-1-leitao@debian.org>
 <87352z7xld.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87352z7xld.ffs@tglx>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 11, 2023 at 12:37:34AM +0200, Thomas Gleixner wrote:
> On Fri, Feb 03 2023 at 04:06, Breno Leitao wrote:
> > Right now it is not possible to disable CPU vulnerabilities mitigations
> > at build time. Mitigation needs to be disabled passing kernel
> > parameters, such as 'mitigations=off'.
> >
> > Create a new config option (CONFIG_CPU_MITIGATIONS_DEFAULT_OFF) that
> > sets the global variable `cpu_mitigations` to OFF, instead of AUTO. This
> > allows the creation of kernel binaries that boots with the CPU
> > mitigations turned off by default, and does not require dealing kernel
> > parameters.
> 
> Why? What's the justification

There are two major justification from my point of view:

1) We keep consistency with other CONFIG options. Linux already has a
CONFIG option to enable/disable mitigations for speculations
(CONFIG_SPECULATION_MITIGATIONS), so, this will be a similar one.

2) There are companies that have different kernel flavours (different
CONFIG options basically), for different type of workloads, and a
machine can change their kernel flavors a few times a day.  I.e, for
a specifically workload, boots in flavor X since it works the best.
Mitigation enabled/disabled is key to some of these flavors.

I would like to see a flavor as self-contained in a binary that I can
mix and match. Right not they are not, since for some kernel
flavours, you need to add kernel command lines (mitigations=off), which
requires some hard logic, mainly when you are dealing with kexec and
grub.
