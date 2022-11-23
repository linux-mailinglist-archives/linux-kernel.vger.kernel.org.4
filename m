Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD21636537
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 17:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236362AbiKWQDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 11:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238811AbiKWQC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 11:02:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0551C1788F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 08:02:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4F77DB81EF2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 16:02:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 552D5C433D6;
        Wed, 23 Nov 2022 16:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669219359;
        bh=PAlObZjgFRk1NZDF+h7RDEPfusnyLpha3eX/AZC4GS4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=anYnysDzcW1g1IGi0q9JtmpieFdOgfRVgUab7GFcgCui+dbd5kHisjaDKDYbC4WFa
         YNQswMvD4jxfpdcxu9vE+Uls+KjjBBugpJbtyXTe1JJEwycST7ttvfn0l2Yz+Nn+BR
         RQdnMzLP6uzTuyAY3v+78H2B4WnTGVoPcMY2zQwkfiF5anSCqMU5/dLqlzLa+OTW0g
         b+qGSpbxj3CaSbYHDeF3yrP1mcCqYN4ueK1EZINqTHZY2fMGPlgjxHwHtONoD3/BR9
         epwY94L3QEMAduhpUgTTElgk8SNnmXFQCyMUga6u6YAdho/yspj+fkezeRAuLc6E8/
         wIHzolSMXAwvQ==
Message-ID: <ce1bf2fd-4080-4952-cf02-6d5b64da8b28@kernel.org>
Date:   Wed, 23 Nov 2022 17:02:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3 1/4] x86/of: Convert Intel's APIC bindings to YAML
 schema
Content-Language: en-US
To:     Rahul Tanwar <rtanwar@maxlinear.com>, bigeasy@linutronix.de,
        robh@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com
Cc:     andriy.shevchenko@linux.intel.com, dave.hansen@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-lgm-soc@maxlinear.com
References: <cover.1669100394.git.rtanwar@maxlinear.com>
 <0cf089495a422b945ac4fc9c980ddb5429a711c3.1669100394.git.rtanwar@maxlinear.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <0cf089495a422b945ac4fc9c980ddb5429a711c3.1669100394.git.rtanwar@maxlinear.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/2022 08:39, Rahul Tanwar wrote:
> Intel's APIC family of interrupt controllers support local APIC
> (lapic) & I/O APIC (ioapic). Convert existing bindings for lapic
> & ioapic from text to YAML schema. Separate lapic & ioapic schemas.
> Addditionally, add description which was missing in text file and
> add few more required standard properties which were also missing
> in text file.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Rahul Tanwar <rtanwar@maxlinear.com>
> ---
>  .../intel,ce4100-ioapic.txt                   | 26 --------
>  .../intel,ce4100-ioapic.yaml                  | 62 +++++++++++++++++++
>  .../intel,ce4100-lapic.yaml                   | 49 +++++++++++++++
>  3 files changed, 111 insertions(+), 26 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-ioapic.txt
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-ioapic.yaml
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-lapic.yaml
> 

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

You miss not only people but also lists, meaning this will not be
automatically tested.

So: No.

Best regards,
Krzysztof

