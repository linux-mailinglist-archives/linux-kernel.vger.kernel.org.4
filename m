Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A37F6D355A
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 05:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjDBDQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 23:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjDBDQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 23:16:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148421B7EE
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 20:16:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9624A61029
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 03:16:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E289C433D2;
        Sun,  2 Apr 2023 03:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680405394;
        bh=qTfnW+hzUh0eokuwDPYcMC56YPJnM7DJQY7FXrup0kc=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=mYpRaUWp+vWs72+6eTZ4LS9+AE68dgqikTQhVbo8EzInQAXjS0MeQU3E/A9qYh+hY
         26RY4GbvkgjRqZPCfG2glURFROv4V8S3RKu+wFTmp9gZk/Kx6W5Mc+dgpz0DuD0K1/
         jzz7WHqMyyVs0Dr5eJcdbnbsWQcJmQrzN4c++mgdNwV9UudEcIbjdFJxedEJvwutqu
         1Wkgz+Dcj0icmieG4lsUX5MRRtYH6QX3DZPv46LQiNpcqsozJsinYBynx2D1tuCPjI
         Rjm5ekZE2XBbT1ECVfFDzOT/IjWGSkuMf9zeqfqTcw4GadOvJTUNRf4O2Fvqgw/Vcj
         AJ3sxDHyAvyzg==
Message-ID: <e896c7ba-defe-6448-5bf2-e7c6c952970d@kernel.org>
Date:   Sun, 2 Apr 2023 11:16:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Yangtao Li <frank.li@vivo.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230223073222.81702-1-frank.li@vivo.com>
 <ZAZUHQz1GIpPG4jf@google.com>
From:   Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: fix to check quota inums
In-Reply-To: <ZAZUHQz1GIpPG4jf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/7 4:59, Jaegeuk Kim wrote:
> On 02/23, Yangtao Li wrote:
>> +static inline bool f2fs_check_quota_inum(int type, unsigned long qf_inum)
>> +{
>> +	switch (type) {
>> +	case USRQUOTA:
>> +		return qf_inum == 4;
>> +	case GRPQUOTA:
>> +		return qf_inum == 5;
>> +	case PRJQUOTA:
>> +		return qf_inum == 6;
> 
> I don't want to make this dependency of the inode numbers.

Actually, mkfs.f2fs allocates qf_inum dynamically, above sanity check
may fail mount()...

Thanks,
