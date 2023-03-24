Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C2E6C768F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 05:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjCXEaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 00:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjCXEaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 00:30:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8A019F16;
        Thu, 23 Mar 2023 21:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=tFSxKzdCHt/dcQq+NfQ6l0WFyAWV4COX8pFL7v6wAJY=; b=imM1RetqpzJF3NRW6J896U5GTY
        iGGxojVa1Au/xl2iWHCwGIx0zmCN6rzLjt2nboBP1xBqxxgo1LaIXOHjEkb7s+JpHSM8hzH+GfrY1
        BqzryrindmJweu1J+BBCUmy8ykFcOtlrBIvDW0V0ozaedY+7vUghYXrutH5ZJGDC3VUPPqQRisZi9
        8QTVOX1/VrVHxiQRTH03jddKFEMrOvihtOIIGuDrcSKocHLf1ChUkwzlysHxszxFjkTe1yNroy0SE
        bMHjA7NHVHoWjYvWqdnjxw6VgRY/quGOeEWHyf7bZdCjre11hbea4KytZsKOrJIYMtz7uKuBKS10t
        hgaBzwYA==;
Received: from [2601:1c2:980:9ec0::21b4]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pfZ4D-003W5h-0b;
        Fri, 24 Mar 2023 04:30:17 +0000
Message-ID: <d0032404-e627-2d51-9c7b-42f5cdf29929@infradead.org>
Date:   Thu, 23 Mar 2023 21:30:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH RFC] Documentation: Add document for false sharing
Content-Language: en-US
To:     Feng Tang <feng.tang@intel.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Joe Mario <jmario@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Eric Dumazet <edumazet@google.com>,
        Shakeel Butt <shakeelb@google.com>, dave.hansen@intel.com,
        ying.huang@intel.com, tim.c.chen@intel.com, andi.kleen@intel.com
References: <20230323082626.100718-1-feng.tang@intel.com>
 <dcb0c139-e40e-f448-ad99-245020025862@infradead.org>
 <ZB0S/gfCLGP44HME@feng-clx>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ZB0S/gfCLGP44HME@feng-clx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 3/23/23 20:03, Feng Tang wrote:
> Hi Randy,
> 
> Thank you for the thorough reviews!
> 
> On Thu, Mar 23, 2023 at 09:49:02AM -0700, Randy Dunlap wrote:
>> Hi,
>>
>> Lots of good/interesting info here.
>>
>> On 3/23/23 01:26, Feng Tang wrote:
>>> From: "Tang, Feng" <feng.tang@intel.com>


>>> +
>>> +'refcount' is modified frequently, but 'name' is set once at object
>>> +creation time and is never modified.  When many CPUs access 'foo' at
>>> +the same time, and 'refcount' is only bumped by one CPU frequently,
>>> +while 'name' is read by all other CPUs, which have to reload the whole
>>> +cache line over and over, even though the 'name' is never changed.
>>
>> That last "sentence" is not a sentence.
> 
> How about:
> 
> "
> When many CPUs access 'foo' at the same time, with 'refcount' being only
> bumped by one CPU frequently and 'name' being read by other CPUs, all
> those reading CPUs have to reload the whole cache line over and over
> due to the 'sharing', even though 'name' is never changed.
> "
> ?

Yes, that's good. Thanks.

-- 
~Randy
