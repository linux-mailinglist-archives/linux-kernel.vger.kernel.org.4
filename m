Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921A2637087
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 03:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiKXCib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 21:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiKXCi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 21:38:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91175E3D9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 18:38:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53174B82698
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 02:38:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 039B4C433C1;
        Thu, 24 Nov 2022 02:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669257505;
        bh=kqWpotENKxr+q1qoYeeXTTyZvtStzZg7ftMSFzg/1cg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CC505dBpTLU+XRjWvIr5EjVP6+gWE8fXNlarcdQd9/Hd7lUl4qFiOhJPiMUQQOH1t
         PXs6XFdBRS/9b2lSQIfiVD0xzhzX9KTL8QTwp6A6KH/GFEHqlChqX9B3W+tn3hDlga
         hb9EP7P9fSn8xGYJwSNqZ3xn670a7+BHjoP655Dmf30zqG5KoCfP8eR8yaAO7CtFF2
         9PNdixDwV2HPHlu5BLQFOlAH6utV6qInG3IA0rHIxVwOs7CccGHVHyzIZeiwKdmxK0
         kUy2G6JyBki75C725o0/GTZlRrBS9yMfzxjdWJLqqAJSGQrfLQsKIQN5SNtNB9V0Xf
         nfh2f9Sjl1BVg==
Message-ID: <63c416b9-b5cc-7c7d-1dad-ef00d0512d93@kernel.org>
Date:   Thu, 24 Nov 2022 10:38:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4] f2fs: fix to enable compress for newly created file if
 extension matches
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Sheng Yong <shengyong@oppo.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <f508dea8-5dc3-e29e-0d8b-4d64735817ac@kernel.org>
 <20221115160155.1037163-1-shengyong@oppo.com> <Y3WKmvpz61K9pwqO@google.com>
 <cc76bc01-b1c8-e52d-02f0-daaae81306f1@kernel.org>
 <Y36QoFTGTbAAJpdX@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <Y36QoFTGTbAAJpdX@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 2022/11/24 5:29, Jaegeuk Kim wrote:
>>> +	if (S_ISDIR(inode->i_mode))
>>> +		goto inherit_comp;
>>
>> Documentation/filesystems/f2fs.rst
>>
>> - Priority in between FS_COMPR_FL, FS_NOCOMP_FS, extensions:
>>
>>    * compress_extension=so; nocompress_extension=zip; chattr +c dir; touch
>>      dir/foo.so; touch dir/bar.zip; touch dir/baz.txt; then foo.so and baz.txt
>>      should be compresse, bar.zip should be non-compressed. chattr +c dir/bar.zip
>>      can enable compress on bar.zip.
>>
>> It looks nocompress_extension has higher priority than flag inheriting?
> 
> I think so.

Hi Sheng, Jaegeuk,

Yup, I guess I misunderstand the code. :)

Thanks,
