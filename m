Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E67963379D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 09:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbiKVI5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 03:57:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233028AbiKVI44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 03:56:56 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2D540902
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 00:56:54 -0800 (PST)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20221122085650epoutp04d5b08bd16036f0417fd62ea681bf394d~p3FjCzkll1757817578epoutp04Y
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 08:56:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20221122085650epoutp04d5b08bd16036f0417fd62ea681bf394d~p3FjCzkll1757817578epoutp04Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1669107410;
        bh=YlAbJG6qiKsC2YLeq9EPpaG7fZfhJYIDuv/NKvM6Xvs=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=i9rXcHbNyZyMF3VCCTQ+I8dp3kpO9GZX3f9TjYk81nD8BL31d0tX191hq2dLPCaGs
         tm0zE/KN5o8r2i/cAoq7uDo9WkyGT0Z3wYUamKLvzXyYw2pcfL7Y5rcgzUBO4QaH0p
         4jZa1hQfPKA84CHgheLV+5FRUFuwnaXAoMwBoABE=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20221122085650epcas2p1cc86df78d2c3a1858c7420e8b41fbf33~p3FitfGub1771317713epcas2p1-;
        Tue, 22 Nov 2022 08:56:50 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.69]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4NGdRP6FvQz4x9Pp; Tue, 22 Nov
        2022 08:56:49 +0000 (GMT)
X-AuditID: b6c32a45-275f970000002b87-c6-637c8ed11974
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        3D.44.11143.1DE8C736; Tue, 22 Nov 2022 17:56:49 +0900 (KST)
Mime-Version: 1.0
Subject: RE:(2) [PATCH v1] f2fs: avoid victim selection from previous victim
 section
Reply-To: yonggil.song@samsung.com
Sender: Yonggil Song <yonggil.song@samsung.com>
From:   Yonggil Song <yonggil.song@samsung.com>
To:     Chao Yu <chao@kernel.org>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <af5ae747-5552-aeb0-885e-ddc9ab6f39c3@kernel.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20221122085649epcms2p5b72ef048e5ac93c02859611fd2233c3a@epcms2p5>
Date:   Tue, 22 Nov 2022 17:56:49 +0900
X-CMS-MailID: 20221122085649epcms2p5b72ef048e5ac93c02859611fd2233c3a
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNKsWRmVeSWpSXmKPExsWy7bCmme7Fvppkg76lBhanp55lsniyfhaz
        xaVF7haXd81hc2Dx2LSqk81j94LPTB6fN8kFMEdl22SkJqakFimk5iXnp2TmpdsqeQfHO8eb
        mhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYALVNSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2Cql
        FqTkFJgX6BUn5haX5qXr5aWWWBkaGBiZAhUmZGcsv7CAteA+X0XTB4sGxttcXYycHBICJhJH
        Ju5m7GLk4hAS2MEosfzHbCCHg4NXQFDi7w5hkBphgTCJTZffM4LYQgJKEtcO9LJAxPUlNi9e
        xg5iswnoSvzdsJwdZI6IwANGiSk39rJBLOCVmNH+lAXClpbYvnwr2HxOATuJTVsMIcIaEj+W
        9TJD2KISN1e/ZYex3x+bzwhhi0i03jsLVSMo8eDnbqi4pMSiQ+eZIOx8ib8rrkOtrZHY2tAG
        FdeXuNaxEewEXgFfieXrb4L1sgioShxZ/hRqjovE8e8nweqZBeQltr+dwwxyJrOApsT6Xfog
        poSAssSRWywQFXwSHYf/ssM8uGPeE6hNahKbN21mhbBlJC48boOa7iFx/8MtZkgonwSGzqHj
        jBMYFWYhAnoWksWzEBYvYGRexSiWWlCcm55abFRgCI/a5PzcTYzgVKfluoNx8tsPeocYmTgY
        DzFKcDArifDWe9YkC/GmJFZWpRblxxeV5qQWH2I0BXp5IrOUaHI+MNnmlcQbmlgamJiZGZob
        mRqYK4nzds3QShYSSE8sSc1OTS1ILYLpY+LglGpgqk7hKDnzxG2ndMbvlXbhzmvnZvjevSir
        6xB78G3Z2RtZh+9tC74kVeMczbGo5et1Qy+ebRovVedKXjvLu7rApnLVs0NVN3/OOvAm6iHX
        q5uXNuhoZ0f+c1a/edZfe7ZAa/e9et9rx7n6T/9mXa8cYbeWa4nknUU1Fb5fVRRWxnBndHOU
        193f8Zvt0a8zR3YsvHhQVSuz5fHZxzPmVAtLrv3j+j70p1/p7y9Hgi6E6UYJ7gtyl22+t8BK
        IOktg/0v8cdXVKRKwyL0j4UfMU19/0/dVtVX6iD/C76QR82119gEukvZevYkyFq9K4tlesAd
        t05CPffKodDz13iLNFYrlYnLFewwfxkT4rJBpN1JiaU4I9FQi7moOBEAu+HFEf4DAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221102100756epcms2p23dfabe90c467313ce094c5c81a99c6d7
References: <af5ae747-5552-aeb0-885e-ddc9ab6f39c3@kernel.org>
        <20221122023656epcms2p4468d4feb97711516206e19890dad09ac@epcms2p4>
        <CGME20221102100756epcms2p23dfabe90c467313ce094c5c81a99c6d7@epcms2p5>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

Thanks for your review.
I'll fix this and resend a mail.

Thanks

>Hi Yonggil,
>
>I guess your email client forces converting tab and space characters of
>patch, please check that.
>
>On 2022/11/22 10:36, Yonggil Song wrote:
>> When f2fs chooses GC victim in large section & LFS mode,
>> next_victim_seg[gc_type] is referenced first. After segment is freed,
>> next_victim_seg[gc_type] has the next segment number.
>> However, next_victim_seg[gc_type] still has the last segment number
>> even after the last segment of section is freed. In this case, when f2fs
>> chooses a victim for the next GC round, the last segment of previous victim
>> section is chosen as a victim.
>> 
>> Initialize next_victim_seg[gc_type] to NULL_SEGNO for the last segment in
>> large section.
>> 
>> Fixes: e3080b0120a1 ("f2fs: support subsectional garbage collection")
>
>Good catch, I'm fine with this fix.
>
>Thanks,
>
>> Signed-off-by: Yonggil Song <yonggil.song@samsung.com>
>> ---
>>   fs/f2fs/gc.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>> 
>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>> index 4546e01b2ee0..10677d53ef0e 100644
>> --- a/fs/f2fs/gc.c
>> +++ b/fs/f2fs/gc.c
>> @@ -1744,8 +1744,9 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
>>                                   get_valid_blocks(sbi, segno, false) == 0)
>>                           seg_freed++;
>>   
>> -                if (__is_large_section(sbi) && segno + 1 < end_segno)
>> -                        sbi->next_victim_seg[gc_type] = segno + 1;
>> +                if (__is_large_section(sbi))
>> +                        sbi->next_victim_seg[gc_type] =
>> +                                (segno + 1 < end_segno) ? segno + 1 : NULL_SEGNO;
>>   skip:
>>                   f2fs_put_page(sum_page, 0);
>>           }
>> -- 
>> 2.34.1
