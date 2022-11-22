Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75CE6633D5E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 14:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233760AbiKVNRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 08:17:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233714AbiKVNQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 08:16:58 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56FBE43;
        Tue, 22 Nov 2022 05:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5YKddbVH+BPkPtVxrSUx3wA/jy8L3/XYxRl/IOTGxlk=; b=oJOoz2DfzxaiKweE3bwmPSkfvo
        zr4WGycVik6FM1VQKYwEF8sYkdE9ZEpIyaLdqfyq7ME8DBpd1qEZgABtbYyjhWiKsVvj/Tw/wrN2V
        pf0mIPqbfz4st/D4FDN6hBo7P7duphvCzcejlAvKykrsIcW6Ngegr1LBQQfxk8duVsh3IgIU8EERM
        j28zcIlspf1e9pxe9UgkP84wM3cMAj9hHxyJor7YpZOS2mN5ewtSNG82hRV4RgoGvRqawcFmFJOOA
        rwpf7ApQg2k/RJ2VHSvAhke21xulK4q0dfNlmBFn6tOBXoI9vdl7Y66FxVtNF5pnjzt5FfIZctA6u
        BI4bkHog==;
Received: from [177.102.6.147] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1oxT8q-006x5N-8b; Tue, 22 Nov 2022 14:16:48 +0100
Message-ID: <d32e7b3d-31f3-9699-1eee-c1e3b2839fe2@igalia.com>
Date:   Tue, 22 Nov 2022 10:16:41 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH] ftrace: Prevent RCU stall on PREEMPT_VOLUNTARY kernels
Content-Language: en-US
To:     rostedt@goodmis.org
Cc:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        kernel-dev@igalia.com, kernel@gpiccoli.net,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20221115204847.593616-1-gpiccoli@igalia.com>
 <20221116153620.353819e9c6acb1bf39adeca2@kernel.org>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20221116153620.353819e9c6acb1bf39adeca2@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/2022 03:36, Masami Hiramatsu (Google) wrote:
> On Tue, 15 Nov 2022 17:48:47 -0300
> "Guilherme G. Piccoli" <gpiccoli@igalia.com> wrote:
> 
>> The function match_records() may take a while due to a large
>> number of string comparisons, so when in PREEMPT_VOLUNTARY
>> kernels we could face RCU stalls due to that.
>>
>> Add a cond_resched() to prevent that.
>>
>> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
>> Acked-by: Paul E. McKenney <paulmck@kernel.org> # from RCU CPU stall warning perspective
>> Cc: Masami Hiramatsu <mhiramat@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> 
> This looks good to me.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Thanks!
> 

Hi Steve, apologies for the ping, just want to ask you if you plan to
take this one or should I change something? Thanks in advance,


Guilherme
