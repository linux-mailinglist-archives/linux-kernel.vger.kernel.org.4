Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7527F7414FA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 17:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbjF1P34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 11:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbjF1P3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:29:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C9F268E;
        Wed, 28 Jun 2023 08:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=qvuSyp7Pgubh7X2uYtTckk5E96WXw9yx8a7ad2phyoE=; b=d4gOg6G8/Yj2ZeR0Ny0H+Z4L+F
        rnUWrxAV2mn/anSVRM8tnDj9kb1rwAgTy4w7zIMKAE0Enx1h0c4XYwi22QzLHNvRP17aUqr9eazE/
        JKvhDe+wev1SUuwtSU3o444yiKG9AqufILPBPtAgabwIbii4HFcfjwMRjpg00A1oGM4Qly3TS7m59
        h+S4ajQRIKpJnfSUv5J4Xm5YbenM+l2r7OsjkcySshFBaZCqXHBYeIPyYn/YKJYeoXsc212RFtGWl
        ewOkZiiuKDGsXA7klj4l31xJf0c7wu9ru35gsv8I+U3OtPFcWhLwf2ygm8ahqHV6m4rQxpGb2tG/v
        ABGilttA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qEX74-00Fzrz-2c;
        Wed, 28 Jun 2023 15:29:46 +0000
Message-ID: <79116003-1c43-fedb-75ec-744e55a94660@infradead.org>
Date:   Wed, 28 Jun 2023 08:29:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] s390/net: lcs: fix build errors when FDDI is a loadable
 module
Content-Language: en-US
To:     Alexandra Winter <wintera@linux.ibm.com>,
        Simon Horman <simon.horman@corigine.com>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
References: <20230621213742.8245-1-rdunlap@infradead.org>
 <98375832-3d29-1f03-145f-8d6e763dd2d2@linux.ibm.com>
 <ZJP99hSRt5MakBXC@corigine.com>
 <3da03251-21ac-b41f-593d-cbc9ac9f86f6@linux.ibm.com>
 <7f585168-7296-58aa-7fdb-c2aa08f346f4@infradead.org>
 <510b6216-35e5-5ea1-525f-5fab35b901e0@infradead.org>
 <a05a7c3a-0f2f-c3be-3630-6774a26b994f@linux.ibm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <a05a7c3a-0f2f-c3be-3630-6774a26b994f@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/28/23 06:41, Alexandra Winter wrote:
> 
> 
> On 28.06.23 07:06, Randy Dunlap wrote:
>> Hi Alexandra, Simon, others,
>>
>> Here is v2 of this patch. I will send it formally after the merge window closes.
>>
>> Thanks for all of your help.
>> ---
> 
> Thank you for the patch, Randy.
> 
> As suggested by Christian Bornträger, I did some research, whether the FDDI part of the LCS driver
> could be removed. And actually there is no s390 machine above the minimum architecture level that
> can have an FDDI interface.
> I will send a patch to remove the FDDI option from the lcs driver.
> 
> I apologize that I was not aware of that earlier. And thank you again for pointing out the issue
> with FDDI as a module.

No problem. Thanks for the new patch.
I will trash all of my LCS patches. :)

-- 
~Randy
