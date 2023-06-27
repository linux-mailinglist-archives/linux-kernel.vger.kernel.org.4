Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38CC673FF10
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 16:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbjF0O4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 10:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbjF0O4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 10:56:01 -0400
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [IPv6:2620:100:9001:583::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3645230F0;
        Tue, 27 Jun 2023 07:56:00 -0700 (PDT)
Received: from pps.filterd (m0122333.ppops.net [127.0.0.1])
        by mx0a-00190b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35RDbN7m012316;
        Tue, 27 Jun 2023 15:55:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=U9yD2r7m486pPPXr8TytFnvnUt4T4S+pIiI6TFhFW8o=;
 b=Gy5uNzaHUbnacU0YYWNi+h8uICS6R//qgX+qQ7wMzMthmi2cdX0yuvzoXFMLwxUJTmHE
 o7VjojnC/jkPa2DmKsiTV7tdhUbdT8G+LKRyiabKoiz0TTH5zjPTI2Z8F/KveYkTwaGl
 NqOvSlifC+xBHSOrJS+YOBc+RE4+KxdQyqV1hYL4P5CzlURC26PJZWmBLVSrxyTGB5BV
 AEeeKNOO7lVybSl4wySId0xdndDmSeYhIg2EW0LsnWeFGNagF874rk3y3prnied/ZYld
 c6KBX04Tnn+1fxs/o/KA5k803okawOT1reehycX/mBvZL1ov0dxH+RIICKnjaMSWQgkV sQ== 
Received: from prod-mail-ppoint3 (a72-247-45-31.deploy.static.akamaitechnologies.com [72.247.45.31] (may be forged))
        by mx0a-00190b01.pphosted.com (PPS) with ESMTPS id 3rdqrb4u0e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jun 2023 15:55:48 +0100
Received: from pps.filterd (prod-mail-ppoint3.akamai.com [127.0.0.1])
        by prod-mail-ppoint3.akamai.com (8.17.1.19/8.17.1.19) with ESMTP id 35RCK9ZC023991;
        Tue, 27 Jun 2023 10:55:47 -0400
Received: from prod-mail-relay19.dfw02.corp.akamai.com ([172.27.165.173])
        by prod-mail-ppoint3.akamai.com (PPS) with ESMTP id 3rfv6fhpyd-1;
        Tue, 27 Jun 2023 10:55:47 -0400
Received: from [172.19.35.49] (bos-lpa4700a.bos01.corp.akamai.com [172.19.35.49])
        by prod-mail-relay19.dfw02.corp.akamai.com (Postfix) with ESMTP id D5B0261317;
        Tue, 27 Jun 2023 14:55:46 +0000 (GMT)
Message-ID: <fa47eda6-3b20-8e8a-b1ce-b335dd8895e8@akamai.com>
Date:   Tue, 27 Jun 2023 10:55:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] md/raid0: add discard support for the 'original' layout
To:     Song Liu <song@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        NeilBrown <neilb@suse.de>
References: <20230623180523.1901230-1-jbaron@akamai.com>
 <CAPhsuW4xyxS=oYmeaF2Jze76WC-e2p_dQNos+QDnFX6nr5AOCw@mail.gmail.com>
Content-Language: en-US
From:   Jason Baron <jbaron@akamai.com>
In-Reply-To: <CAPhsuW4xyxS=oYmeaF2Jze76WC-e2p_dQNos+QDnFX6nr5AOCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_10,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 adultscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306270137
X-Proofpoint-ORIG-GUID: PS1dAe-GoaPRQ72EcDgc36DaOO8dy9dH
X-Proofpoint-GUID: PS1dAe-GoaPRQ72EcDgc36DaOO8dy9dH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_10,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306270138
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/26/23 8:35 PM, Song Liu wrote:
> On Fri, Jun 23, 2023 at 11:05 AM Jason Baron <jbaron@akamai.com> wrote:
>>
>> We've found that using raid0 with the 'original' layout and discard
>> enabled with different disk sizes (such that at least two zones are
>> created) can result in data corruption. This is due to the fact that
>> the discard handling in 'raid0_handle_discard()' assumes the 'alternate'
>> layout. We've seen this corruption using ext4 but other filesystems are
>> likely susceptible as well.
>>
>> More specifically, while multiple zones are necessary to create the
>> corruption, the corruption may not occur with multiple zones if they
>> layout in such a way the layout matches what the 'alternate' layout
>> would have produced. Thus, not all raid0 devices with the 'original'
>> layout, different size disks and discard enabled will encounter this
>> corruption.
>>
>> The 3.14 kernel inadvertently changed the raid0 disk layout for different
>> size disks. Thus, running a pre-3.14 kernel and post-3.14 kernel on the
>> same raid0 array could corrupt data. This lead to the creation of the
>> 'original' layout (to match the pre-3.14 layout) and the 'alternate' layout
>> (to match the post 3.14 layout) in the 5.4 kernel time frame and an option
>> to tell the kernel which layout to use (since it couldn't be autodetected).
>> However, when the 'original' layout was added back to 5.4 discard support
>> for the 'original' layout was not added leading this issue.
>>
>> I've been able to reliably reproduce the corruption with the following
>> test case:
>>
>> 1. create raid0 array with different size disks using original layout
>> 2. mkfs
>> 3. mount -o discard
>> 4. create lots of files
>> 5. remove 1/2 the files
>> 6. fstrim -a (or just the mount point for the raid0 array)
>> 7. umount
>> 8. fsck -fn /dev/md0 (spews all sorts of corruptions)
>>
>> Let's fix this by adding proper discard support to the 'original' layout.
>> The fix 'maps' the 'original' layout disks to the order in which they are
>> read/written such that we can compare the disks in the same way that the
>> current 'alternate' layout does. A 'disk_shift' field is added to
>> 'struct strip_zone'. This could be computed on the fly in
>> raid0_handle_discard() but by adding this field, we save some computation
>> in the discard path.
>>
>> Note we could also potentially fix this by re-ordering the disks in the
>> zones that follow the first one, and then always read/writing them using
>> the 'alternate' layout. However, that is seen as a more substantial change,
>> and we are attempting the least invasive fix at this time to remedy the
>> corruption.
>>
>> I've verified the change using the reproducer mentioned above. Typically,
>> the corruption is seen after less than 3 iterations, while the patch has
>> run 500+ iterations.
>>
>> Cc: NeilBrown <neilb@suse.de>
>> Cc: Song Liu <song@kernel.org>
>> Fixes: c84a1372df92 ("md/raid0: avoid RAID0 data corruption due to layout confusion.")
>> Signed-off-by: Jason Baron <jbaron@akamai.com>
> 
>   Looks good to me! Applied to md-next.
> 
> Since this will be released with 6.6, we should have a smaller and safer fix
> before that. Would you mind create a patch that ignores all discards to
> orig_layout and not the first zone? We will roll that to 6.5 and back port to
> stable. Then this version will be shipped to 6.6+.
> 

Hi Song,

Ok, I mean the current patch was meant to be fairly conservative in that 
it attempts to only change codepaths where we are doing discards above 
the first zone. IE Changing only the codepaths that currently don't work.

But if we want to be more conservative (given this fixes corruption), I 
can post a patch to disable discard as you've suggested. I'm going to 
let the testing run for a while, so I'll post it in a bit.

Thanks,

-Jason
