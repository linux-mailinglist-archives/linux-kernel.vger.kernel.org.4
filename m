Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E169D600849
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 10:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiJQIDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 04:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbiJQIC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 04:02:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9C45B7BE
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 01:02:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AFA89201AB;
        Mon, 17 Oct 2022 08:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665993773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ycjdaftggo2cqyYiI1y6JhKzuwDu6ReGWlgIK8aFjrk=;
        b=r1DZCa9K8TzNKBGhH14smD1KIx1wZfUT0D3Pyns+hb5m1HSCzYAsXvEgzy7cT0UoGEieJr
        xwfz9o4/GmAcKvyes5SeQvesqrlleXwOvbZ9tXdVm+WPcMBM6smM6iHGm1bAOTgSl5KVfB
        8lyFzuiJ9UPrGR3TBvyiHZUEICts/o4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665993773;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ycjdaftggo2cqyYiI1y6JhKzuwDu6ReGWlgIK8aFjrk=;
        b=hPvjewTcFFuKnaMAdsfHtxjRQW7Ry4bJ4xOX3EP56rehbsBdxCQVWa1Hvpo0V326iI2S0n
        4LRHjcutTf86CiBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8A63D13ABE;
        Mon, 17 Oct 2022 08:02:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GUTXIC0MTWPbDQAAMHmgww
        (envelope-from <mliska@suse.cz>); Mon, 17 Oct 2022 08:02:53 +0000
Message-ID: <0a04e3ed-aeba-9df9-212e-03232f02da6e@suse.cz>
Date:   Mon, 17 Oct 2022 10:02:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] gcov: support GCC 12.1 and newer compilers
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org
References: <624bda92-f307-30e9-9aaa-8cc678b2dfb2@suse.cz>
 <581f6037-ff43-4f91-cabf-d9aa0d72bbe6@linux.ibm.com>
 <20221016174033.d33a998b4c91b7d18b3dc310@linux-foundation.org>
From:   =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
In-Reply-To: <20221016174033.d33a998b4c91b7d18b3dc310@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/22 02:40, Andrew Morton wrote:
> On Fri, 14 Oct 2022 11:30:51 +0200 Peter Oberparleiter <oberpar@linux.ibm.com> wrote:
> 
>> On 13.10.2022 09:40, Martin Liška wrote:
>>> Starting with GCC 12.1, there are 2 significant changes to the .gcda
>>> file format that needs to be supported:
>>>
>>> a) [gcov: Use system IO buffering] (23eb66d1d46a34cb28c4acbdf8a1deb80a7c5a05) changed
>>>    that all sizes in the format are in bytes and not in words (4B)
>>> b) [gcov: make profile merging smarter] (72e0c742bd01f8e7e6dcca64042b9ad7e75979de)
>>>    add a new checksum to the file header.
>>>
>>> Tested with GCC 7.5, 10.4, 12.2 and the current master.
>>>
>>> Signed-off-by: Martin Liska <mliska@suse.cz>
>>
>> Looks good, thanks! I successfully tested this patch on s390 using GCC
>> 12.2 and 11.2.
>>
>> Tested-by: Peter Oberparleiter <oberpar@linux.ibm.com>
>> Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
>>
>> Andrew, could you add this patch via your tree?
> 
> Sure.
> 
> The changelog doesn't tell us what the user-visible effects of this are
> (please, it should do so), but it sounds to me like those effects are
> "gcov is utterly busted".

Hi.

Sorry for the missing user-visible effect. You are correct, the created .gcda
format can't be read by gcov tool since GCC 12.1 release.

Thanks,
Martin

> 
> So I'll add a cc:stable to this, so that people can use new gcc
> versions to build older kernels.

