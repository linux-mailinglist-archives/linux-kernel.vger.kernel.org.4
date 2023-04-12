Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB346DFF5F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 22:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjDLUGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 16:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjDLUGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 16:06:33 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E18D1B7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 13:06:30 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230412200627euoutp02837b88dcfce20bc5632a5c02deaa408e~VSLcV3oKG3029830298euoutp02S
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 20:06:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230412200627euoutp02837b88dcfce20bc5632a5c02deaa408e~VSLcV3oKG3029830298euoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681329987;
        bh=cDTpSr6yaesmoByZzLbeOs4uBrgU5JYI1gxT5JpD0IY=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=Or4uKRljsdPqDOoTzYgFOmwc9GNFXYHxccPDUK30txg4UFF53jdMPR39jpgPjQJGl
         WUhjmoT74zTLp0uEC5/YvoI5TgPs/6ZWt6WYq5rKUvLxQKYx0ud3cBj3CJS9dUN9Mt
         0u+tC6pijcJzIKoJqnh9NV9MQ07ZvJJwsR5k5FXg=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230412200625eucas1p194de814c6a39e794ef321dd4a0b15bc5~VSLbOjvn81127611276eucas1p1W;
        Wed, 12 Apr 2023 20:06:25 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 14.EF.09503.14F07346; Wed, 12
        Apr 2023 21:06:25 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230412200625eucas1p1b2d245470685f5720807cedc89f5cc33~VSLa8SiGk2591525915eucas1p1K;
        Wed, 12 Apr 2023 20:06:25 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230412200625eusmtrp1e655cbb364ef27c11448d6719af8b86d~VSLa7tSuO0435404354eusmtrp1k;
        Wed, 12 Apr 2023 20:06:25 +0000 (GMT)
X-AuditID: cbfec7f2-ea5ff7000000251f-0e-64370f41deb4
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 8A.F4.34412.14F07346; Wed, 12
        Apr 2023 21:06:25 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230412200625eusmtip1026dc2552ceb63f6431b5a611a61290a~VSLawnFxH2331123311eusmtip1i;
        Wed, 12 Apr 2023 20:06:25 +0000 (GMT)
Received: from [192.168.8.190] (106.210.248.243) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 12 Apr 2023 21:06:24 +0100
Message-ID: <60dc0eca-dc6c-0df4-548f-0cc55c5ef0f5@samsung.com>
Date:   Wed, 12 Apr 2023 22:06:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.9.0
Subject: Re: [PATCH] scripts/gdb: use mem instead of core_layout to get the
 module address
To:     Florian Fainelli <f.fainelli@gmail.com>, <jan.kiszka@siemens.com>,
        <kbingham@kernel.org>
CC:     <gost.dev@samsung.com>, <linux-kernel@vger.kernel.org>,
        <song@kernel.org>, <mcgrof@kernel.org>
Content-Language: en-US
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <9954a532-871a-e747-908f-bc5a3e32a55f@gmail.com>
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.243]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+c45nh0Hq+PUfCsrm9pFyy4UjtqswGpJQRIE3RvtZOrcdNOy
        LHAxqmno0vIyUsMizVJhijkzU0uXVtq9bZIYOSGHl3JW6948Rv73O+/zPN/3vIePwvl6j1lU
        rCKZUSmkcgHJJeraXV1LN0wPly1vurtS+G34AUfYa7Xiws7MGkz4ouEyKbTo7UhoLvtJricl
        JsNbjsRYoSMltztyMMmYce52YjdXJGPksUcZ1bKIg9wjjSOqxD48tacvG0tHZ/AM5EkBvQqe
        Zn3wyEBcik+XI6joG0dugU87EWhrtrE8hqBxKOpfoMronAyUISjQNpHsx19T7eubk8odBN26
        a6Q7wqMjoM/gINxM0MHQ1f+aYOde0FHYP8G+9G7I6jF6uNmb3guF5a6JGj70fui+/n5ijtMy
        aGmvQyz7ga2/BMtAFEXSIaDRcdxjT1oMJtePSfs8uD10GXdbgA6Es80B7AKnoLPWhrlrAj1K
        QamzCmOFSMgb/kyy7A2D5loOy/7wKPc8wXIa2C3fcTasRZBtqibZC9ZC1mO5G3F6MVQ3LGPt
        G+D+m/TJCtPAMuTFNpsGOXX5uB4FG6b8B8OUvQxTFjD8P/QKIiqQH5OiTohh1CsUzLEwtTRB
        naKICTukTDCiv4/m0S/zp3pUNPgxrBVhFGpFQOECH97XyNUyPk8mPX6CUSkPqFLkjLoVzaYI
        gR8vVNxxiE/HSJOZeIZJZFT/VIzynJWO5Z80mZlBcaxFnfVLb9vhOnXO+7evrbjQnrnzcIs+
        YuOZ4QKuNO7Z+tKbnGJBV8PL02J+/dy0PP/oNckXFo86pKMJq6xtlYb4hZZLLd2y8U9KoiA8
        RBkdzwsdezeoMe9b8vDenJwvVynF+7BuebHsFn/dxfBFdxJ/ZsLzV/VlAZ1J35JEuhEvh5fv
        gEC/FLnyGmf0lNrHizTVcW1Jhrfi0kjXzKq2eRAQZe2VoxidqMQpEh1tv+WvFzp65zenBazT
        5I71DNlR4WbCcuPHvoFR2564LZ72wCdBzftrPsjyR1I3KZcvGK9PFW7NdWY3Bm0cMFU6+rVk
        1S6rVrNFLCDUR6QrQnCVWvoH6mQrsaMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsVy+t/xu7qO/OYpBq9nyFr8eneE3eLezZvM
        Fqe6NzNZXN41h83ixoSnjBbHl/9lc2Dz2DnrLrvHplWdbB7bT05i8vi8SS6AJUrPpii/tCRV
        ISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEvY8/7ooIHzBW3H/Qz
        NTC2MXcxcnJICJhIrNv0hbWLkYtDSGApo8SdJetYIRIyEhu/XIWyhSX+XOtigyj6yCgxcf0m
        FpCEkMBuRomFm5NAbF4BO4kHs16DxVkEVCXOPbnGAhEXlDg58wmYLSoQJfH5QAs7iC0sECMx
        c8VPRhBbRCBO4vyyx0DLODiYBVIkWv7pQOz6xijx7uJXsCOYBcQlbj2ZzwRSwyagJdHYCTaG
        U8BWYufPP1AlmhKt23+zQ9jyEtvfzmEGKZcQUJZoP6AA8UqtxOe/zxgnMIrOQnLcLCQLZiGZ
        NAvJpAWMLKsYRVJLi3PTc4uN9IoTc4tL89L1kvNzNzECY3TbsZ9bdjCufPVR7xAjEwfjIUYJ
        DmYlEd4fLqYpQrwpiZVVqUX58UWlOanFhxhNgSE0kVlKNDkfmCTySuINzQxMDU3MLA1MLc2M
        lcR5PQs6EoUE0hNLUrNTUwtSi2D6mDg4pRqYtGKYFaeVnwv/sGa31xlxkeKShLLFv560VIhr
        3bxgmP15U39T8IxJGxL4luu94e77ysRr8m3G4erNez7P7FyyTNmug72y/nOSnI02kzzTMia+
        5V6Sv3/UNz9+mbHhfbmYf4zZ+UrxnTf+HNLbciuAS+z8idkFm6qMVtfWPLTS+d/h7bSEl3/H
        VYWQinKXGxoLJdrDqqbtS+dlO6D/cGL61tW/J7yWqtsgvDD44g63r8K3n80KZDj1hUPZY66i
        1cqFy41OnD6bf6Di0FwXQbFtSxZZSxclGj57Vt11+f/KBeJXlq496B+p1fR1w4SoJedi3rvZ
        u4vNPmr3/vTHxd7d7QJuM55tXq7I4f1JcLr+GSWW4oxEQy3mouJEAMqIlc1aAwAA
X-CMS-MailID: 20230412200625eucas1p1b2d245470685f5720807cedc89f5cc33
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230412112608eucas1p2e8aa819cf92ccc2bacfe0ff9bfcd7a6f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230412112608eucas1p2e8aa819cf92ccc2bacfe0ff9bfcd7a6f
References: <20230412111508.892296-1-p.raghav@samsung.com>
        <CGME20230412112608eucas1p2e8aa819cf92ccc2bacfe0ff9bfcd7a6f@eucas1p2.samsung.com>
        <ffc82a81-c212-7990-53fb-2f95eb7af2ad@samsung.com>
        <9954a532-871a-e747-908f-bc5a3e32a55f@gmail.com>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> Replace core_layout with its new counterpart mem[MOD_TEXT].
>>>
>>> Fixes: ac3b43283923 ("module: replace module_layout with module_memory")
>>> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
>>> ---
>>
>> I had one question:
>> - Is there a way to import enum? I currently hard code 0 but it will better if we can
>> use the MOD_TEXT enum instead.
> 
> You should be able to with updating constants.py.in and using LX_GDBPARSED()

Thanks a lot. This helps.
