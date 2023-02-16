Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B42698A46
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 03:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjBPCCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 21:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBPCCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 21:02:22 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C87829171
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 18:02:19 -0800 (PST)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230216020215epoutp01cf4f17afb3142b3e891ad96c19a372b4~EK6HrWqhh2617526175epoutp01Z
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:02:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230216020215epoutp01cf4f17afb3142b3e891ad96c19a372b4~EK6HrWqhh2617526175epoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676512935;
        bh=CSvqJjBL22C0lmgcM8zgoa8hVL77LICcIrvup4e0B1o=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=W55n6i4JpuqgbnUZhBDpWGQFqt+m9ugcBULO6ETKSLboUI6RXW9bk/TZWRpsq4JE2
         Nr1Z6WPQrNHCwvY9jCcZC3YU4mbf/mo7PvvvJBoKEjnsg4+GEZLQB4JcqmWp5i4yxf
         kL8XfliaAVouEdRmOCshbS+MjgNptZS8B6sxgfEg=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230216020215epcas2p3be5de9975ecdc1198c5f7395f1a3bb8a~EK6HVWvAW3106531065epcas2p3x;
        Thu, 16 Feb 2023 02:02:15 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.91]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4PHJ9M0FH3z4x9Py; Thu, 16 Feb
        2023 02:02:15 +0000 (GMT)
X-AuditID: b6c32a45-671ff7000001f1e7-aa-63ed8ea624d5
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        62.B3.61927.6AE8DE36; Thu, 16 Feb 2023 11:02:14 +0900 (KST)
Mime-Version: 1.0
Subject: RE:(2) [PATCH v1] f2fs: fix uninitialized skipped_gc_rwsem
Reply-To: yonggil.song@samsung.com
Sender: Yonggil Song <yonggil.song@samsung.com>
From:   Yonggil Song <yonggil.song@samsung.com>
To:     Chao Yu <chao@kernel.org>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Seokhwan Kim <sukka.kim@samsung.com>,
        Daejun Park <daejun7.park@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <cf7eae6b-61ea-accb-f981-023fb022919c@kernel.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230216020214epcms2p1dfa8562c1d33231856848bb0ec8ba1a7@epcms2p1>
Date:   Thu, 16 Feb 2023 11:02:14 +0900
X-CMS-MailID: 20230216020214epcms2p1dfa8562c1d33231856848bb0ec8ba1a7
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFKsWRmVeSWpSXmKPExsWy7bCmme6yvrfJBisem1mcnnqWyWLVg3CL
        J+tnMVtcWuRucXnXHDaLVR1zGR3YPDat6mTz2L3gM5NH35ZVjB6fN8kFsERl22SkJqakFimk
        5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYArVZSKEvMKQUKBSQWFyvp
        29kU5ZeWpCpk5BeX2CqlFqTkFJgX6BUn5haX5qXr5aWWWBkaGBiZAhUmZGc8uL+evaCHs+LD
        qZPMDYwr2bsYOTkkBEwkmk6dZ+pi5OIQEtjBKLFozj62LkYODl4BQYm/O4RBaoQFnCW+TXrK
        DGILCShJXDvQywIR15fYvHgZ2Bw2AV2JvxuWs4PMERF4wCgx5cZeNpAEs0CQxP0pD1ghlvFK
        zGh/ygJhS0tsX76VEcTmFLCTuLT5NVRcQ+LHsl5mCFtU4ubqt+ww9vtj8xkhbBGJ1ntnoWoE
        JR783A0Vl5RYdAjkGRA7X+LviutsEHaNxNaGNqi4vsS1jo1gu3gFfCUOdRwAu41FQFXi++PT
        UDNdJA4cvM0Mcb+8xPa3c5hBYcIsoCmxfpc+iCkhoCxx5BYLRAWfRMfhv+wwH+6Y9wRqk5rE
        5k2boT6XkbjwuA3qSg+JSVvvMU9gVJyFCOhZSHbNQti1gJF5FaNYakFxbnpqsVGBITxuk/Nz
        NzGCE6GW6w7GyW8/6B1iZOJgPMQowcGsJMK76eabZCHelMTKqtSi/Pii0pzU4kOMpkBfTmSW
        Ek3OB6bivJJ4QxNLAxMzM0NzI1MDcyVxXmnbk8lCAumJJanZqakFqUUwfUwcnFINTOueGe2J
        26Vb9Oz2lB3ZubuOMcatf/9K8baonILLE5fXXTYl9h9CBScsVM5dZ7zzX/C9PakzHmgySn/1
        vdHmHMdzzvMQhynDzacR6nsba8Kva/9V/tdSMevs/4fursXSpbO8c1oDHrFcCPvhp66zTWfz
        sW57pfn5ZpZRHdF3vmguOrxBcOmxWJejW/z7C0+p9Mfm/W9oD9nAJx4i4BJ14sTl4rQzOxYV
        Huj68IBb/VL0Go78ZsfHXsfclyy8duDV7voCt7WmE5sZbPr7pS1aH7TcWmA3+8Vbtp/KNU5q
        uV6WzKXTZjg+KLguldj5cNH3xZJzXGqnRObNuaNZvqvpp+HX7kjJDNcdTWkhey88U2Ipzkg0
        1GIuKk4EAK8lt+ENBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230215024850epcms2p22be2cc864d82b44f31c19a7ef28770b6
References: <cf7eae6b-61ea-accb-f981-023fb022919c@kernel.org>
        <20230215024850epcms2p22be2cc864d82b44f31c19a7ef28770b6@epcms2p2>
        <CGME20230215024850epcms2p22be2cc864d82b44f31c19a7ef28770b6@epcms2p1>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/2/15 10:48, Yonggil Song wrote:
>> When f2fs skipped a gc round during victim migration, there was a bug which
>> would skip all upcoming gc rounds unconditionally because skipped_gc_rwsem
>> was not initialized. It fixes the bug by correctly initializing the
>> skipped_gc_rwsem inside the gc loop.
>
>It makes sense to me.
>
>> 
>> Fixes: d147ea4adb96 ("f2fs: introduce f2fs_gc_control to consolidate f2fs_gc parameters")
>
>How does this commits introduce the bug?

Oh, sorry I've got wrong hash.
I'll send right hash on PATCH v2.

Thanks for your comment.

>
>Thanks,
>
>> Signed-off-by: Yonggil Song <yonggil.song@samsung.com>
>> 
>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>> index b22f49a6f128..81d326abaac1 100644
>> --- a/fs/f2fs/gc.c
>> +++ b/fs/f2fs/gc.c
>> @@ -1786,8 +1786,8 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
>>   				prefree_segments(sbi));
>>   
>>   	cpc.reason = __get_cp_reason(sbi);
>> -	sbi->skipped_gc_rwsem = 0;
>>   gc_more:
>> +	sbi->skipped_gc_rwsem = 0;
>>   	if (unlikely(!(sbi->sb->s_flags & SB_ACTIVE))) {
>>   		ret = -EINVAL;
>>   		goto stop;
