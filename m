Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFAF70F4CC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 13:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjEXLG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 07:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232955AbjEXLGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 07:06:51 -0400
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F68CC5
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 04:06:50 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VjNqYwK_1684926406;
Received: from 30.97.48.247(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VjNqYwK_1684926406)
          by smtp.aliyun-inc.com;
          Wed, 24 May 2023 19:06:47 +0800
Message-ID: <f9958544-e9e9-d0f0-ceff-30e73d119bad@linux.alibaba.com>
Date:   Wed, 24 May 2023 19:06:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: dm overlaybd: targets mapping OverlayBD image
To:     Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     Alexander Larsson <alexl@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Du Rui <durui@linux.alibaba.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, Alasdair Kergon <agk@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>
References: <9505927dabc3b6695d62dfe1be371b12f5bdebf7.1684491648.git.durui@linux.alibaba.com>
 <ZGz32yw7ecKhW+lj@redhat.com>
 <CAL7ro1FPEqXyOuX_WPMYdsT6rW-bD5EU=v=oWKsd6XscykLF6Q@mail.gmail.com>
 <fd4d0429-4da3-8217-6c13-14fd8a198920@linux.alibaba.com>
 <87r0r6ywri.fsf@redhat.com>
 <02524ece-956f-f5d8-fb21-adc4e5617dc6@linux.alibaba.com>
 <87mt1uyphw.fsf@redhat.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <87mt1uyphw.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/24 03:48, Giuseppe Scrivano wrote:
> Gao Xiang <hsiangkao@linux.alibaba.com> writes:
> 
>> Hi Giuseppe,
>>
>> On 2023/5/24 01:11, Giuseppe Scrivano wrote:
>>> Gao Xiang <hsiangkao@linux.alibaba.com> writes:
>>>
>>
>> ...
>>
>>>> Agreed, I hope you guys could actually sit down and evaluate a proper
>>>> solution on the next OCI v2, currently I know there are:
>>>>
>>>>    - Composefs
>>>>    - (e)stargz   https://github.com/containerd/stargz-snapshotter
>>>>    - Nydus       https://github.com/containerd/nydus-snapshotter
>>>>    - OverlayBD   https://github.com/containerd/accelerated-container-image
>>>>    - SOCI        https://github.com/awslabs/soci-snapshotter
>>>>    - Tarfs
>>>>    - (maybe even more..)
>>>>
>>>> Honestly, I do think OSTree/Composefs is the best approach for now for
>>>> deduplication and page cache sharing (due to kernel limitation of page
>>>> cache sharing and overlayfs copyup limitation).  I'm too tired of
>>>> container image stuffs honestly.  Too much unnecessary manpower waste.
>>> for a file-based storage model, I am not sure a new format would
>>> really
>>> buy us much or it can be significantly different.
>>> Without a proper support from the kernel, a new format would still
>>> need
>>> to create the layout overlay expects, so it won't be much different than
>>> what we have now.
>>
>> I've seen lot efforts on this, for example,
>> https://docs.google.com/presentation/d/1lBKVrYzm9JEYuw-gIEsrcePSK0jL1Boe/edit#slide=id.p22
>>
>> Merging the writable layer and read-only layers with overlayfs is
>> feasible. I mean, at least for composefs model on backing XFS/btrfs, we
>> could merge these layers with overlayfs so that I guess reflink could
>> be done to avoid full copyup as well?  I do think that's a net win.
>>
>>> The current OCI format, with some tweaks like (e)stargz or
>>> zstd:chunked,
>>> already make its content addressable and a client can retrieve only the
>>> subset of the files that are needed.  At the same time we maintain the
>>> simplicity of a tarball and it won't break existing clients.
>>
>> (e)stargz or zstd:chunked still needs to be converted by the publisher
>> and not all exist OCI images are stored in this way.  But apart from
>> detailed comparsion, disk mapping image approaches seems really a
>> drawback at least on my side.
> 
> these images can be treated as if all their files are missing and the
> checksum is calculated on the receiver side.  They will still be stored
> locally indexed by their checksum.  We lose the possibility to pull only
> the missing files but we maintain the other advantages at runtime.  In
> this way moving to a new format can be done incrementally without
> breaking what we have now.

Yeah, that is on-demand loading stuffs (another story) but my
opinion was that I could see a win of composefs model is that
you could use EROFS + overlayfs + XFS/btrfs to do partial copyup
by using clone_file_range() to copy up within the same fs (since
all layers including the writable layer are actually landed
in the same fs so overlayfs will just clone_file_range()).

In principle, we could do some hack to do clone_file_range()
across different fses which are actually backed by the same
fs for other approaches, but that approach cannot be not
easily landed upstream TBH.

Thanks,
Gao Xiang
