Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35C062074D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 04:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbiKHDJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 22:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbiKHDJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 22:09:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE752FFDC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 19:09:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 90D6EB817B7
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 03:09:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D04C433C1;
        Tue,  8 Nov 2022 03:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667876973;
        bh=ESaSA6P2k4Dk/Y5lWn22BcQjULKGCM7blKLusR3qWEs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Go9X8vIyiPTW7Rf0ol54sh23E+uekMG/Bf6R1kV95NsgAT1IbNOE3aXtlVsunGkZA
         C0icvDImDnBH5xu8cX3IK4Zs2iVJ0xgBb3LIkThRYFOl5sXETNz5w9EUaJB+I+uQ74
         +03aIE1yQTL+FkvrJs9UQhxiq+XMNQ7zl6SjoD1jKTP+671xikd/uMXni7ly4NSw0I
         EUVfFW2HtBWbh09klD4Fms6adjxRTqYWDZKM6VsVSsqeP3zFAjNBZGsT6esHqHVS3S
         U1vtqrK1PFptFCn246c5IUHk0Dm/ruhrPHh+uZb75Yte7k7OWEBvsWIzf2h54PeRbp
         akTxK9cv5Nc2w==
Message-ID: <e288944b-559c-e184-96c4-370a80cbb9a9@kernel.org>
Date:   Tue, 8 Nov 2022 11:09:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 2/2] erofs: get correct count for unmapped range in
 fscache mode
Content-Language: en-US
To:     Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
        huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Cc:     zhujia.zj@bytedance.com, yinxin.x@bytedance.com,
        linux-kernel@vger.kernel.org
References: <20221104054028.52208-1-jefflexu@linux.alibaba.com>
 <20221104054028.52208-3-jefflexu@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221104054028.52208-3-jefflexu@linux.alibaba.com>
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

On 2022/11/4 13:40, Jingbo Xu wrote:
> For unmapped range, the returned map.m_llen is zero, and thus the
> calculated count is unexpected zero.
> 
> Prior to the refactoring introduced by commit 1ae9470c3e14 ("erofs:
> clean up .read_folio() and .readahead() in fscache mode"), only the
> readahead routine suffers from this. With the refactoring of making
> .read_folio() and .readahead() calling one common routine, both
> read_folio and readahead have this issue now.
> 
> Fix this by calculating count separately in unmapped condition.
> 
> Fixes: c665b394b9e8 ("erofs: implement fscache-based data readahead")
> Fixes: 1ae9470c3e14 ("erofs: clean up .read_folio() and .readahead() in fscache mode")
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
