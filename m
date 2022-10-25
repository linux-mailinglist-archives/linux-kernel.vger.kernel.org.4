Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1A860C1EF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 04:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbiJYCvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 22:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiJYCvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 22:51:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525E810CFA9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 19:51:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E25E761717
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 02:51:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C7D1C433C1;
        Tue, 25 Oct 2022 02:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666666298;
        bh=7DyQiRYGX5iB56h+VCaUyEKZGSQILTTmtLWCE7ekI1Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=O66ZC1UOs3IINrIKW1K/NMPMYa3qZ77OXjOYdQD1MJafjJTQqu2mkAzzpHlC3Qu0H
         aFxedUBT4fcW71hIHgNm0oGKhg7cDLfRTHlmjFhFox1G2FlmcW3zLQYObATzKbOSKR
         SsazqazQPPhjdkaCOqI33FBI/QBeO11GS0xqYE9tXbu39Osud66VVdrD0R1UNhaEJ4
         iRdSR2SCSMX5i2jityCRBRrl3EmEGm8wAVNNjt16mOppuM7/jpEUTGRWmcFC+hn9RZ
         cs/xkbNbY7qWcpOzIK42zzwZAfEHT2tJ9FJdAMxKwoc2rqx+3ld0ew2cle8flSfoVe
         I+NI0Cqcwl5Fw==
Message-ID: <429625d3-ca81-d067-deb7-e9d40725eaf0@kernel.org>
Date:   Tue, 25 Oct 2022 10:51:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [f2fs-dev] [PATCH] f2fs: make gc_idle sysfs node readable
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <dfc051bb-71ca-035c-b945-ad298aa5e1ae@kernel.org>
 <20221025023334.77096-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221025023334.77096-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/25 10:33, Yangtao Li wrote:
> Hi Chao,
> 
> What:       /sys/fs/f2fs/<disk>/gc_idle
> Date:       July 2013
> Contact:    "Namjae Jeon" <namjae.jeon@samsung.com>
> Description:    Controls the victim selection policy for garbage collection.
>          Setting gc_idle = 0(default) will disable this option. Setting:
> 
>          ===========  ===============================================
>          gc_idle = 1  will select the Cost Benefit approach & setting
>          gc_idle = 2  will select the greedy approach & setting
>          gc_idle = 3  will select the age-threshold based approach.
>          ===========  ===============================================
> 
>  From the kernel documentation, this node only describes the writing of
> the value, and does not describe the reading of the value.

  If the value is used by userspace program, after the change, it will break
userspace.

> 
> Actually, this modification does the same thing as commit e60aeb2dee1a
> ("f2fs: make gc_urgent and gc_segment_mode sysfs node readabl").
> I understand it is an addition to the omission of the patch above.
> 
> Why gc_urgent and gc_segment_mode can be modified to string, but gc_idle
> breaks forward compatibility?

Oops, I guess that patch may have caused a regression...if there is any
user..

> 
> Thanks,
