Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF26264CF86
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 19:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238863AbiLNSjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 13:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238843AbiLNSjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 13:39:04 -0500
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E4F2A727;
        Wed, 14 Dec 2022 10:39:01 -0800 (PST)
Received: from [192.168.192.83] (unknown [50.47.134.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 748EC435AA;
        Wed, 14 Dec 2022 18:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1671043140;
        bh=mn7RH9Ufp845DGISODvcJfPEAYPED21Nvkh3xrhQ8w8=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=uFQoT+m7osjRCGAF1wpbjEQR2NY71VIfimTF4a+zuVs5Z++dwc2XHtVySnWNAvGsw
         RkDcRG1ozPRtPIrcK/dxUwLAmczggIScYwJJcqvEo1q3YbPELu6WvJYM3lroIW4ARf
         NsbsdCROrdI+MB/iOG7uMOTvjYR48RMNimsvpuRo+zcJ0o/q8ABXeL+s06rDfdRLmi
         bLh/mNXWhfxU30cec8G5MaDn0EWFtjcRPAVnpV8wvTQrfmkyrLAU2rCWynfGdoQxgn
         eRsp0qY0ni021lDLJfqHYbmbAMGSQ3sdf2bV/5bobKqAvZUh+1/HpSSZakg67XE9CY
         s72cOOGinjgoA==
Message-ID: <1854ad9a-c31d-3fea-b9d3-b81ff6a29230@canonical.com>
Date:   Wed, 14 Dec 2022 10:38:57 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: linux-next: manual merge of the kunit-next tree with the apparmor
 tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Rae Moar <rmoar@google.com>
References: <20221208124653.71ba9491@canb.auug.org.au>
 <20221214105830.3bde0179@canb.auug.org.au>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20221214105830.3bde0179@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/22 15:58, Stephen Rothwell wrote:
> Hi all,
> 
> On Thu, 8 Dec 2022 12:46:53 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> Today's linux-next merge of the kunit-next tree got a conflict in:
>>
>>    security/apparmor/policy_unpack_test.c
>>
>> between commits:
>>
>>    371e50a0b19f ("apparmor: make unpack_array return a trianary value")
>>    32490541682b ("apparmor: Fix kunit test for out of bounds array")
>>
>> from the apparmor tree and commit:
>>
>>    2c92044683f5 ("apparmor: test: make static symbols visible during kunit testing")
>>
>> from the kunit-next tree.
>>
>> I fixed it up (see below) and can carry the fix as necessary. This
>> is now fixed as far as linux-next is concerned, but any non trivial
>> conflicts should be mentioned to your upstream maintainer when your tree
>> is submitted for merging.  You may also want to consider cooperating
>> with the maintainer of the conflicting tree to minimise any particularly
>> complex conflicts.
>>
>> -- 
>> Cheers,
>> Stephen Rothwell
>>
>> diff --cc security/apparmor/policy_unpack_test.c
>> index 7465da42492d,f25cf2a023d5..000000000000
>> --- a/security/apparmor/policy_unpack_test.c
>> +++ b/security/apparmor/policy_unpack_test.c
>> @@@ -144,8 -147,8 +147,8 @@@ static void policy_unpack_test_unpack_a
>>    
>>    	puf->e->pos += TEST_ARRAY_BUF_OFFSET;
>>    
>> - 	KUNIT_EXPECT_EQ(test, unpack_array(puf->e, NULL, &array_size),
>>   -	array_size = aa_unpack_array(puf->e, NULL);
>>   -
>> ++	KUNIT_EXPECT_EQ(test, aa_unpack_array(puf->e, NULL, &array_size),
>>   +			TRI_TRUE);
>>    	KUNIT_EXPECT_EQ(test, array_size, (u16)TEST_ARRAY_SIZE);
>>    	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos,
>>    		puf->e->start + TEST_ARRAY_BUF_OFFSET + sizeof(u16) + 1);
>> @@@ -159,8 -162,8 +162,8 @@@ static void policy_unpack_test_unpack_a
>>    
>>    	puf->e->pos += TEST_NAMED_ARRAY_BUF_OFFSET;
>>    
>> - 	KUNIT_EXPECT_EQ(test, unpack_array(puf->e, name, &array_size),
>>   -	array_size = aa_unpack_array(puf->e, name);
>>   -
>> ++	KUNIT_EXPECT_EQ(test, aa_unpack_array(puf->e, name, &array_size),
>>   +			TRI_TRUE);
>>    	KUNIT_EXPECT_EQ(test, array_size, (u16)TEST_ARRAY_SIZE);
>>    	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos,
>>    		puf->e->start + TEST_ARRAY_BUF_OFFSET + sizeof(u16) + 1);
>> @@@ -175,8 -178,9 +178,8 @@@ static void policy_unpack_test_unpack_a
>>    	puf->e->pos += TEST_NAMED_ARRAY_BUF_OFFSET;
>>    	puf->e->end = puf->e->start + TEST_ARRAY_BUF_OFFSET + sizeof(u16);
>>    
>> - 	KUNIT_EXPECT_EQ(test, unpack_array(puf->e, name, &array_size),
>>   -	array_size = aa_unpack_array(puf->e, name);
>>   -
>>   -	KUNIT_EXPECT_EQ(test, array_size, 0);
>> ++	KUNIT_EXPECT_EQ(test, aa_unpack_array(puf->e, name, &array_size),
>>   +			TRI_FALSE);
>>    	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos,
>>    		puf->e->start + TEST_NAMED_ARRAY_BUF_OFFSET);
>>    }
> 
> This is now a conflict between the apparmor tree and Linus' tree.
> 


sorry for the delay on this, build and regression testing took way
longer than they should have.

apparmor merge request is now sent


