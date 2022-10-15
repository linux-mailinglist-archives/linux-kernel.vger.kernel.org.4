Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E195FF794
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 02:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiJOAT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 20:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiJOATz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 20:19:55 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B898C1C110;
        Fri, 14 Oct 2022 17:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=o85rBsRwFZ9TSTg6JmGn7UPiClsb/zWZjdP234qWiWk=; b=HNaWHeuvzCAdZCu33ffYgm+Opc
        Q5o7ioakGrcxElu/MmAhin48C+SEVwS9YwaOUsU+CbopQ5Kdq7VDP64SRRgeFczlLJ20u/wlYWejh
        Kch8UdZ6qiuz4tpbWvhwwybEvo44qV19v+mxMi9JuDFcwaHRYiQ9OOMNcJ1IIFigJGYHY5547vy7D
        QgLp1Lg8HZC6kHHPJ8v8OA4NxScwTuZICy8/6EC/TA04UcptoOVP1Ho7AkPrOkwg3uhwiTmJM/kSY
        qEFqdAhlzst+6vbDiQLT7f+k3wh2LhY21Hz66VuK7aEe2M2/GAqAk7TGuTBpJr7ENI64gJWlEje5C
        3dfJbBAg==;
Received: from [179.113.159.85] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1ojUtm-001iQo-Hq; Sat, 15 Oct 2022 02:19:31 +0200
Message-ID: <e08a08dd-6cfe-1550-5d13-b76eef38bb27@igalia.com>
Date:   Fri, 14 Oct 2022 21:19:11 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH V2] x86/split_lock: Add sysctl to control the misery mode
Content-Language: en-US
To:     "Luck, Tony" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "kernel-dev@igalia.com" <kernel-dev@igalia.com>,
        "kernel@gpiccoli.net" <kernel@gpiccoli.net>,
        Andre Almeida <andrealmeid@igalia.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Joshua Ashton <joshua@froggi.es>,
        Melissa Wen <mwen@igalia.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Pavel Machek <pavel@denx.de>,
        Pierre-Loup Griffais <pgriffais@valvesoftware.com>,
        Zebediah Figura <zfigura@codeweavers.com>
References: <20221014180506.211592-1-gpiccoli@igalia.com>
 <SJ1PR11MB60832858BA290E844F6C13E9FC249@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <SJ1PR11MB60832858BA290E844F6C13E9FC249@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/2022 15:26, Luck, Tony wrote:
> Looks reasonable.
> 
> Are these games multi-threaded with split locks happening on multiple CPUs in parallel?
> If they are, then skipping both the 10ms delay and the serialization is needed.
> 
> But if split locks are only from one CPU at a time, then possibly it would have
> been enough to just have this mitigation skip the:
> 
> +		if (msleep_interruptible(10) > 0)
> +			return;
> 
> Maybe best not to second guess. You have left the default as "mitigation on",
> so I'm happy.
> 
> -Tony

Hi Tony, thanks for your review!

Some games are indeed multi-threaded, so as you said, I think it's
better if we skip the whole thing when the sysctl is off - a kind of
fallback to the old "warn" mode before the misery was added heh

Cheers,


Guilherme

