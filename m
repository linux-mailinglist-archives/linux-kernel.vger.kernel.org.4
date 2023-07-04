Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEDC746CFA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 11:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbjGDJPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 05:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjGDJPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 05:15:23 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4E7B6
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 02:15:21 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VmcHuwv_1688462115;
Received: from 30.97.48.245(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VmcHuwv_1688462115)
          by smtp.aliyun-inc.com;
          Tue, 04 Jul 2023 17:15:16 +0800
Message-ID: <c630bb18-2a50-13ed-f100-c4e40860e04b@linux.alibaba.com>
Date:   Tue, 4 Jul 2023 17:15:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [RFC 0/2] erofs: introduce bloom filter for xattr
To:     Alexander Larsson <alexl@redhat.com>,
        Jingbo Xu <jefflexu@linux.alibaba.com>
Cc:     chao@kernel.org, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20230621083209.116024-1-jefflexu@linux.alibaba.com>
 <c316bc55-cc4d-f05a-8936-2cde217b8dd2@linux.alibaba.com>
 <CAL7ro1FjnO52tawLeu-wNtk+upN1ShxeFYE1AiFUh1JN2oo0hA@mail.gmail.com>
 <74a8a369-c3b0-b338-fa8f-fdd7c252efaf@linux.alibaba.com>
 <CAL7ro1Hhiq=qofFLgxjMDZnrwJ6E=tvcECqqbP8vQ_CeJLtSKQ@mail.gmail.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAL7ro1Hhiq=qofFLgxjMDZnrwJ6E=tvcECqqbP8vQ_CeJLtSKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/7/4 16:05, Alexander Larsson wrote:
> On Tue, Jul 4, 2023 at 7:56 AM Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>>
>>

...

>> ```
>> seed: 25bbe08f
>> bit 31: trusted.overlay.metacopy, user.overlay.metacopy,
>>
>> seed: cc922efd
>> bit  3: trusted.overlay.opaque, user.overlay.opaque,
>>
>> seed: cd478c17
>> bit  6: trusted.overlay.metacopy, user.overlay.metacopy,
>> ```
>>
>>
>> Any other idea?
> 
> Any of these three is good to me. I don't have any ideas directly
> related to this. However,  semi-related, it would be really cool if
> fuse supported the same approach for xattr lookup. I.e. if lookup
> could add a bloom filter value as part of the inode data, then we
> could avoid a kernel<->fusefs-d transition for negative xattrs
> lookups.

I think we could just use a hardcoded magic number (e.g. 25bbe08f)
as a start first, since it seems already fulfill our requirement
and it's a compatible feature (and the implementation is also not
complex.)  So I'm not quite worried about this.

Thanks,
Gao Xiang

> 
