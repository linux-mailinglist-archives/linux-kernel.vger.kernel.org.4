Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEBAC602D26
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 15:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbiJRNi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 09:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiJRNi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:38:28 -0400
Received: from p3plsmtp22-06.prod.phx3.secureserver.net (p3plsmtp22-06-2.prod.phx3.secureserver.net [68.178.252.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3643BCC81B
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 06:38:27 -0700 (PDT)
Received: from mailex.mailcore.me ([94.136.40.145])
        by :WBEOUT: with ESMTP
        id kmnZoWNBp4Fm0kmnao13QQ; Tue, 18 Oct 2022 06:38:26 -0700
X-CMAE-Analysis: v=2.4 cv=eaX4w5IH c=1 sm=1 tr=0 ts=634eac52
 a=7e6w4QD8YWtpVJ/7+iiidw==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=ggZhUymU-5wA:10 a=IkcTkHD0fZMA:10 a=Qawa6l4ZSaYA:10
 a=66p2IBj6BIMJ5QbZfZUA:9 a=QEXdDO2ut3YA:10
X-SECURESERVER-ACCT: phillip@squashfs.org.uk  
X-SID:  kmnZoWNBp4Fm0
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175] helo=[192.168.178.33])
        by smtp05.mailcore.me with esmtpa (Exim 4.94.2)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1okmnZ-0001Fb-3Q; Tue, 18 Oct 2022 14:38:25 +0100
Message-ID: <51a33dc0-424f-171c-3347-75eee598b6b8@squashfs.org.uk>
Date:   Tue, 18 Oct 2022 14:38:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: BISECT result: 6.0.0-RC kernels trigger Firefox snap bug with
 6.0.0-rc3 through 6.0.0-rc7
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Jintao Yin <nicememory@gmail.com>,
        linux-kernel@vger.kernel.org, marcmiltenberger@gmail.com,
        regressions@leemhuis.info, regressions@lists.linux.dev,
        srw@sladewatkins.net
References: <20221015205936.5735-1-phillip@squashfs.org.uk>
 <20221018021507.612-1-nicememory@gmail.com>
 <41c05ece-2e63-391a-e1ba-fc1acb235559@alu.unizg.hr>
 <CAJMQK-hgQEkhgpO9VFOCgn-cKtVsr7Hb_58pAYiGoDi5SzGZtA@mail.gmail.com>
 <Y06jNzD92Tv5TKxI@debian.me>
From:   Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <Y06jNzD92Tv5TKxI@debian.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailcore-Auth: 439999529
X-Mailcore-Domain: 1394945
X-123-reg-Authenticated:  phillip@squashfs.org.uk  
X-Originating-IP: 82.69.79.175
X-CMAE-Envelope: MS4xfJgQC0NAL9E+BJYtT21vZj8XFjR1J2SmjAdM0zXAszXAUshsri7XwUnzfi1YUsVLuvwF+FrBdThrlySdXRTMpW6xTsCAYdAdeEszboHX3RJvQw73phIV
 Hye5r1We9rYUjKzKofvQngrD+P19an4I5L/Y1s5r8fvQDPFPkW1OM80h5DVSzYMTfdgAXzL9k6myix4KpM1Cq/iR7tB9MkSSC2c=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/10/2022 13:59, Bagas Sanjaya wrote:
> On Tue, Oct 18, 2022 at 04:24:46PM +0800, Hsin-Yi Wang wrote:
>> Hi Jintao,
>>
>> Thanks for pointing out and sorry for missing this. Does the following
>> diff improve the issue?
>>
>> diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
>> index e56510964b229..7759bd70dfbf2 100644
>> --- a/fs/squashfs/file.c
>> +++ b/fs/squashfs/file.c
>> @@ -600,7 +600,7 @@ static void squashfs_readahead(struct
>> readahead_control *ractl)
>>
>>                          /* Last page (if present) may have trailing
>> bytes not filled */
>>                          bytes = res % PAGE_SIZE;
>> -                       if (pages[nr_pages - 1]->index == file_end && bytes)
>> +                       if ((pages[nr_pages - 1]->index >> shift) ==
>> file_end && bytes)
>>                                  memzero_page(pages[nr_pages - 1], bytes,
>>                                               PAGE_SIZE - bytes);
>>
>>
>> readahead only handles the case that the first page and the last page
>> have the same block index:
>>      index = pages[0]->index >> shift;
>>      if ((pages[nr_pages - 1]->index >> shift) != index)
>>          goto skip_pages;
>>
>> The diff above makes a difference to SQUASHFS_INVALID_BLK case, which
>> will not be handled by squashfs_readahead_fragment() if
>> index==file_end.
>> With the above diff, it will now be memzero_page().
> 
> Hi Hsin-Yi Wang, thanks for the proposed diff. However, it was wrapped,
> so I have to manually type the changes.
> 
> I compiled 6.1-rc1 with your diff applied. For testing, I have both
> hello-world and lxd snaps installed. No problems on running the former.
> On the latter, I got coredump when trying to start lxd services with
> `snap start lxd`. The coredump for lxd processes are attached.
> 
>  From above, I think b09a7a036d2035 ("squashfs: support reading fragments in readahead call") should be reverted until we come up with proper solution.
> 
> Thanks.
> 

I am currently working with the snap developers to identify the issue.

When there is progress, I will post.

Phillip

