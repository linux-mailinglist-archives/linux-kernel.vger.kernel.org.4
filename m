Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8A76BD05A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 14:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjCPNBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 09:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjCPNBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 09:01:42 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7078B042;
        Thu, 16 Mar 2023 06:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fmU1+ghPDUpLHdu1qhAM4Pdh6VNfesNoUAyvXpreIY4=; b=KJdf11YRWGGA3AHBkCcBU8wMfe
        rwamCNzbsIOFyp6DxuocuuTZaArvhKzV53IAI91iGXRwSKsFbqGEAN/rrI0MaOt3ySdy0gDkZ5u+u
        KkwYkg6+gzzsb2E/FEEmd1abbq1WpjJ0lei3aEjjYE+XXJliYmTHF1QTFYuUPjWBgsnb0R1y2sFm9
        S4zuDTZgIRSi4jU3MQxG2zI9GeL1ZY54LcFyYjZjpwiVoYRU5unZtPxwwDurjTuJRah3YqynTsXRR
        NOCnpMGSBcuTq7JGyxakjdA76AIVgT46LG/dgMC7gtJzxv+nqsSQOk5iQkVTfgEi8XNh5QyvyYrfS
        d2gcc51A==;
Received: from [152.254.169.34] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1pcnEH-00DEyP-6l; Thu, 16 Mar 2023 14:01:13 +0100
Message-ID: <65ce7063-d966-efea-6a39-db81da6b05aa@igalia.com>
Date:   Thu, 16 Mar 2023 10:01:08 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] Documentation/x86: Update split lock documentation
Content-Language: en-US
To:     Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
References: <20230315225722.104607-1-tony.luck@intel.com>
 <c34372d8-8166-6be6-b3a3-5214a2bae37a@intel.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <c34372d8-8166-6be6-b3a3-5214a2bae37a@intel.com>
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

On 15/03/2023 20:13, Fenghua Yu wrote:
> Hi, Tony,
> 
> On 3/15/23 15:57, Tony Luck wrote:
>> commit b041b525dab9 ("x86/split_lock: Make life miserable for split
>> lockers") added a delay and serialization of cplit locks. Commit
>                                               s/cplit/split/
> 
>> 727209376f49 ("x86/split_lock: Add sysctl to control the misery mode")
>> provided a sysctl to turn off the misery.
>>
>> Update the split lock documentation to describe the current state of
>> the code.
>>
>> Signed-off-by: Tony Luck <tony.luck@intel.com>
>> ---
>>   Documentation/x86/buslock.rst | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/x86/buslock.rst b/Documentation/x86/buslock.rst
>> index 7c051e714943..31ec0ef78086 100644
>> --- a/Documentation/x86/buslock.rst
>> +++ b/Documentation/x86/buslock.rst
>> @@ -53,8 +53,14 @@ parameter "split_lock_detect". Here is a summary of different options:
>>   |off	  	   |Do nothing			|Do nothing		|
>>   +------------------+----------------------------+-----------------------+
>>   |warn		   |Kernel OOPs			|Warn once per task and |
>> -|(default)	   |Warn once per task and	|and continues to run.  |
>> -|		   |disable future checking	|			|
>> +|(default)	   |Warn once per task, add a	|and continues to run.  |
>> +|		   |delay, add synchronization	|			|
>> +|		   |to prevent more than one	|			|
>> +|		   |core from executing a	|			|
>> +|		   |split lock in parallel.	|			|
>> +|		   |sysctl split_lock_mitigate	|			|
>> +|		   |can be used to avoid the	|			|
>> +|		   |delay and synchronization	|			|
>>   |		   |When both features are	|			|
>>   |		   |supported, warn in #AC	|			|
>>   +------------------+----------------------------+-----------------------+
> 
> Other than the typo, looks good to me.
> 
> Thanks.
> 
> -Fenghua

Thanks for fixing the documentation Tony! Also looks great for me.
Cheers,


Guilherme
