Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 503715FF38B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 20:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiJNSUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 14:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiJNSUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 14:20:51 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9C0EE8BC;
        Fri, 14 Oct 2022 11:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MdsoADCl9uFya5thCCynArSHrEXYEfVbUBWmIBsxmh4=; b=Eu29XZq2g/+1/BarUodckH0Ha9
        4Egja3WCFYqPkSH5tsTyeWoz4fj4SG7/Vzb9eqpfaJTPeBJJClLB+RRXM4+FL2TyiuZzI5RpKWmAe
        UrGc2dQni8fANKagQ/+cogLXnl+sqH+7Q9eYyjpNNQrny3m+D+n2Za1rdR2GFzasVDD2+tok7lMNR
        Ua6CtvrwQOyR8oe9aU5IZDvnhE8IxfX8+MRK0k+Q5Oyd5o3+CP5htczRlXr821ala2CSVjWWnibam
        vAWtLhRGagLiuFePbgcUExbXqr9CM1W+kNP5ntkYdozIOzL7Da6GNuuLio1CZBAQ1e1ZwKLA03Ihu
        xpfEJpow==;
Received: from [179.113.159.85] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1ojPIa-001YmN-7Z; Fri, 14 Oct 2022 20:20:44 +0200
Message-ID: <ca4b6a18-a44a-e248-f648-674e3805687a@igalia.com>
Date:   Fri, 14 Oct 2022 15:20:26 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH V2] x86/split_lock: Add sysctl to control the misery mode
Content-Language: en-US
To:     =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, linux-kernel@vger.kernel.org,
        x86@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, luto@kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, kernel-dev@igalia.com,
        kernel@gpiccoli.net, Fenghua Yu <fenghua.yu@intel.com>,
        Joshua Ashton <joshua@froggi.es>,
        Melissa Wen <mwen@igalia.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Pavel Machek <pavel@denx.de>,
        Pierre-Loup Griffais <pgriffais@valvesoftware.com>,
        Tony Luck <tony.luck@intel.com>,
        Zebediah Figura <zfigura@codeweavers.com>
References: <20221014180506.211592-1-gpiccoli@igalia.com>
 <9a606366-6ac7-3802-5c25-91057ad833cb@igalia.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <9a606366-6ac7-3802-5c25-91057ad833cb@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/2022 15:17, André Almeida wrote:
> [...]
> 
> Tested-by: André Almeida <andrealmeid@igalia.com>
> 
> Tested on an Intel i7-1165G7 using a small benchmarking script, the 
> behavior is effectively reverted when using the sysctl option.
> 
> Also, you might want to document this option somewhere? Maybe at 
> Documentation/admin-guide/sysctl/kernel.rst

Thanks André!

About documenting, it seems it's already done in the patch, right?
Cheers,


Guilherme
