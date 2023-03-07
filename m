Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF20F6AF6F5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 21:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjCGUwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 15:52:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjCGUwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 15:52:23 -0500
X-Greylist: delayed 3184 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 07 Mar 2023 12:52:20 PST
Received: from mx07lb.world4you.com (mx07lb.world4you.com [81.19.149.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926144740B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 12:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=U36lwBlxgIjpgF0QC643OH5pbbYkdV7o3GLoTtG1dK8=; b=lxJKFF1PJr5zBJdQOZGJURSwQJ
        59MLdTsF+oGOro9iuccCOyGb4v+JvWFiuY1MKVMG1VdgLXktgDXtIf0x+Xytt7PL9/oicupFNqQNK
        Iy48TPWTJW+auabERbJ84a0mzaUftnzOARIsggye+tcI5igT4Huo7JnfRoB28iNk1OXc=;
Received: from [88.117.63.48] (helo=[10.0.0.160])
        by mx07lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gerhard@engleder-embedded.com>)
        id 1pZdSi-0002o1-1c; Tue, 07 Mar 2023 20:59:04 +0100
Message-ID: <bfd215e7-fbf2-b579-0370-cff9f24a3dc9@engleder-embedded.com>
Date:   Tue, 7 Mar 2023 20:59:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] checkpatch: Ignore ETHTOOL_LINK_MODE_ enum values
To:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     apw@canonical.com, dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com
References: <20230104201524.28078-1-gerhard@engleder-embedded.com>
 <435e1e0fd256bc2e58f0abe1255d9f13a786ca11.camel@perches.com>
Content-Language: en-US
From:   Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <435e1e0fd256bc2e58f0abe1255d9f13a786ca11.camel@perches.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.01.23 23:24, Joe Perches wrote:
> On Wed, 2023-01-04 at 21:15 +0100, Gerhard Engleder wrote:
>> Since commit 4104a20646 enum values like
>> ETHTOOL_LINK_MODE_Asym_Pause_BIT are ignored. But there are other enums
>> like ETHTOOL_LINK_MODE_1000baseT_Full_BIT, which are not ignored
>> because of the not matching '1000baseT' substring.
>>
>> Add regex to match all ETHTOOL_LINK_MODE enums.
> []
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
>> @@ -5783,6 +5783,8 @@ sub process {
>>   			    $var !~ /^(?:[A-Z]+_){1,5}[A-Z]{1,3}[a-z]/ &&
>>   #Ignore Page<foo> variants
>>   			    $var !~ /^(?:Clear|Set|TestClear|TestSet|)Page[A-Z]/ &&
>> +#Ignore ETHTOOL_LINK_MODE_<foo> variants
>> +			    $var !~ /^ETHTOOL_LINK_MODE_/ &&
>>   #Ignore SI style variants like nS, mV and dB
>>   #(ie: max_uV, regulator_min_uA_show, RANGE_mA_VALUE)
>>   			    $var !~ /^(?:[a-z0-9_]*|[A-Z0-9_]*)?_?[a-z][A-Z](?:_[a-z0-9_]+|_[A-Z0-9_]+)?$/ &&
> 
> These ETHTOOL enums also exist but are caught by the SI style variants test
> 
> ETHTOOL_A_CABLE_PULSE_mV
> ETHTOOL_A_CABLE_AMPLITUDE_mV
> 
> So I guess it's OK.  Thanks.

Did I miss to do something to get this merged? Shall I post it again?

Gerhard
