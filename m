Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B3B706431
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 11:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjEQJcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 05:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjEQJb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 05:31:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1256F272D;
        Wed, 17 May 2023 02:31:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BF49612B8;
        Wed, 17 May 2023 09:31:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DC22C433D2;
        Wed, 17 May 2023 09:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684315918;
        bh=6ilR6kXaGUcDpNmXNWUrWx5PShH6KgXKJXAAlwF5E+8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VlsSRUGGJA/ErJtfAJlkEQofGngLreLL8+5s1fjA3zR7T8uAqITgPiR6kFYsMH8rp
         0Ro1Cn/RrintJlFfLX2mwh2XYoz8eVSe47/Gky2ZLofZ8Dju03HuTbvdiyfzOv/nlk
         0xFPkxhDgknvXEyhjiHovGYrsWGHA9g2r2aW8h9/x9afutQ5lwRcTCobWZDVYuScPR
         0Ajoxre2w/ZB/yANp7IURfxF4cKwTIPnxKqTsnMJwGkGQQ3BcY1TDKcdRbjb9KU0Ef
         BwydLJPlsfe+LwOvFMfHK4lawHSytT/npjP5Pk6CcQzugoQFYB490/k/a24c81IYHM
         ZjX2kG8p/yALQ==
Message-ID: <344bfde9-5f7e-80a2-038f-3bfc387ea678@kernel.org>
Date:   Wed, 17 May 2023 18:31:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V1] block: Fix null pointer dereference issue on struct
 io_cq
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>,
        Pradeep P V K <quic_pragalla@quicinc.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230517084434.18932-1-quic_pragalla@quicinc.com>
 <07b8b870-a464-25a9-c0a6-c123fad05ff5@huaweicloud.com>
 <a2f86cd7-776c-d7ed-8815-62683a14ba36@kernel.org>
 <ZGScoCeOILHpc8c1@infradead.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ZGScoCeOILHpc8c1@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/23 18:21, Christoph Hellwig wrote:
> On Wed, May 17, 2023 at 06:20:19PM +0900, Damien Le Moal wrote:
>> twice for the same icq. The missing rcu lock in ioc_exit_icqs() already was in
>> itself a bug, and the missing flag check is another.
> 
> spinlocks imply a rcu critical section, no need to duplicate it.

Right. And I misread the code. As Yu said, given that ioc_exit_icqs() iterates
the list of icqs under ioc->lock and the ioc is removed from that list under the
same lock, ioc_exit_icqs() should never see an icq that went through
ioc_destroy_icq()...
Very weird.


-- 
Damien Le Moal
Western Digital Research

