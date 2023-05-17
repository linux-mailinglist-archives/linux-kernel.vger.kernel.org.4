Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B284E705D51
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 04:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjEQCcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 22:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjEQCcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 22:32:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFB310E3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 19:32:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BB18640C7
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 02:32:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D72EC433EF;
        Wed, 17 May 2023 02:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684290722;
        bh=EGWWvTtIz/wefBtSbQjyXbGccmk7EVTm65ykgv4tinQ=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=JZH/SIc3l8kO4VCTPoT1GAbA53InelUdM05t7DUEP7A85TszHsbe2z7LoVUIPDMno
         sHQ+LsphgUkO0H1IavoQUOjYM4HYMj92ouwYS6ePPjqmYnZRxKWK+M/ApYZYyNp7Xr
         QygGe3TAOW1sCUUvW7uqwwfg8oW+k2cxqsfKPmDtJI0VR9SgQAJ2CyBxW+JPwYw0rQ
         JTlPLUBy1kk/or+3s3Wbge7A1GHgP3vIJwwqc8k3jyO59Pm5oW/hGc/NgF4ImQuXju
         HgJd/7hH0+aDobDheNoBDL6XauiiPKPpT41srRH0gqCQNWBjhvk3//HCNSrQa/RXlK
         tCqLXe+3f2ISg==
Message-ID: <ed4926d1-aba5-0234-7345-cc3290e8cc54@kernel.org>
Date:   Wed, 17 May 2023 10:32:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [f2fs-dev] Is compression available under direct-io mode?
Content-Language: en-US
To:     Sijie Lan <sijielan@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <CAGAHmYC8AR_iw=nXQc6s29T3SkSoz9Ajd0N39Nv87orJJHMLGQ@mail.gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <CAGAHmYC8AR_iw=nXQc6s29T3SkSoz9Ajd0N39Nv87orJJHMLGQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/5/12 9:10, Sijie Lan wrote:
> Hi, guys,
> 
> When I do some specific test scenarios, I want to do some direct write
> after data have been compressed in F2FS, but when I track the internal
> functions, it seems F2FS forces my direct-io request to buffer-io
> mode. Does it mean we can not do the write direct-io if we applied the

Yes, compression feature depends on page cache.

Thanks,

> compression feature? In other words, must f2fs use an inside buffer to
> provide compression functions?
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
