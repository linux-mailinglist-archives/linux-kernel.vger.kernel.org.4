Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC2D72CBAA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 18:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237272AbjFLQhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 12:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237213AbjFLQhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 12:37:13 -0400
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3182E47
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 09:37:10 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-30fc1514745so1155102f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 09:37:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686587829; x=1689179829;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tu7DO/hXRSRSUXZyjLgrJmCIjeq7tT0tIh+N/BVBMZQ=;
        b=jBarnKIloFbFtsc9YpGZVL7xqOnGAxm7OKmNlBl1PX6uPWbCjTtuXzwg+RfD4txnX/
         CG0UdmLshPH0bP/h4qHKba5MXlJoew18C+Td9V8foOMoLGtfNkW35rSJxG+9OZyZH20f
         lxQt+IhOncawg0Zz8l7RzAauS/ZAnH7U6lDUZj32cZVkRlMZa6uCQkd8NuSeq05wFXZZ
         eL5gNsMuAMmHMiV5vnw8+zRkJD7NVvvB0ehSV0kwxhax36MGD6IWaGwrbXpoJ2nceY/X
         UWwdpHCKalJhvkVHxFgFw5TUsmk17XyT03z+oX0nt5q8S1nMJHR7H8NysAUvJPZfTyWh
         2W9A==
X-Gm-Message-State: AC+VfDyybKRxaWuVzK9EF7oOUAGlwQrmazjmSWiRTrjHXCDuIaFBn/WU
        4CJiiNYQ06SxOnkBQ7kLBMg=
X-Google-Smtp-Source: ACHHUZ6CGq1fUYvV7SN2q5ntZ+gns7JxNbfC+R05U36yfRG2w9sczP0ccX/eZi0Ho54Uth3YOM2stA==
X-Received: by 2002:a5d:40c7:0:b0:30f:c758:3148 with SMTP id b7-20020a5d40c7000000b0030fc7583148mr974799wrq.64.1686587829247;
        Mon, 12 Jun 2023 09:37:09 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-025.fbsv.net. [2a03:2880:31ff:19::face:b00c])
        by smtp.gmail.com with ESMTPSA id c1-20020a5d5281000000b0030aded83385sm12968868wrv.27.2023.06.12.09.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 09:37:08 -0700 (PDT)
Date:   Mon, 12 Jun 2023 09:37:07 -0700
From:   Breno Leitao <leitao@debian.org>
To:     Borislav Petkov <bp@alien8.de>, pawan.kumar.gupta@linux.intel.com
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        pawan.kumar.gupta@linux.intel.com, paul@paul-moore.com,
        leit@meta.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpu/bugs: Disable CPU mitigations at compilation time
Message-ID: <ZIdJs0F8Ow4sV27r@gmail.com>
References: <20230203120615.1121272-1-leitao@debian.org>
 <87352z7xld.ffs@tglx>
 <ZIcVoIAQbRl1GTo5@gmail.com>
 <20230612133230.GJZIcebkHxd8QJs0Dv@fat_crate.local>
 <ZIchqLWousxkCqyB@gmail.com>
 <20230612135301.GKZIcjPY0xvbNsiVNd@fat_crate.local>
 <ZIcoss0r/898/CpH@gmail.com>
 <20230612160807.GNZIdC58KQ8IibZjrt@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612160807.GNZIdC58KQ8IibZjrt@fat_crate.local>
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

On Mon, Jun 12, 2023 at 06:08:07PM +0200, Borislav Petkov wrote:
> On Mon, Jun 12, 2023 at 07:16:18AM -0700, Breno Leitao wrote:
> > Sorry, to waht menu specifically?
> 
> CONFIG_SPECULATION_MITIGATIONS
> 
> It even has the proper text in there, warning people.
> 
> menuconfig SPECULATION_MITIGATIONS
>         bool "Mitigations for speculative execution vulnerabilities"
>         default y
>         help
>           Say Y here to enable options which enable mitigations for
>           speculative execution hardware vulnerabilities.

I am not sure if these bugs (MDS, TAA) are speculations related. Pawan
could help us here.
