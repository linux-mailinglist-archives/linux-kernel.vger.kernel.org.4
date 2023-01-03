Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C0C65BC10
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 09:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236981AbjACIU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 03:20:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237144AbjACIUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 03:20:16 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164EBDF85
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 00:20:11 -0800 (PST)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230103082009epoutp01eade1e0ac9bd6d11bd39d21ab39dfaf4~2vrguJTkc0544405444epoutp01Q
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 08:20:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230103082009epoutp01eade1e0ac9bd6d11bd39d21ab39dfaf4~2vrguJTkc0544405444epoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1672734009;
        bh=1yWTky4TDMhNEiL+icVGFosUinkFfnqp9uEKyMxLLZc=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=Q0xz7NAoGSKsNxzJpDIcTm6yVGSbmMqi8WmOOOzCZjQi7TICHe3itRR+CHnrjV6Ml
         eSiuTCJloCheY4xovLRWN5Ba6bJiKbqi18tCFfBit8Qu4Udc2FILElyqjzIhJAT6xe
         L9OWfp045eAG0GNAkmR5yfa6aPvjFFpYOkvBen1k=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230103082009epcas1p19133d4ec3a342f915fa4e46b9ffc3290~2vrgU-d1P1730317303epcas1p1i;
        Tue,  3 Jan 2023 08:20:09 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.38.250]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4NmQdj0Qcgz4x9Q8; Tue,  3 Jan
        2023 08:20:09 +0000 (GMT)
X-AuditID: b6c32a36-46ffd700000095a1-59-63b3e5383f87
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        78.5B.38305.835E3B36; Tue,  3 Jan 2023 17:20:08 +0900 (KST)
Mime-Version: 1.0
Subject: RE:(2) [PATCH] page_alloc: avoid the negative free for meminfo
 available
Reply-To: jaewon31.kim@samsung.com
Sender: =?UTF-8?B?6rmA7J6s7JuQ?= <jaewon31.kim@samsung.com>
From:   =?UTF-8?B?6rmA7J6s7JuQ?= <jaewon31.kim@samsung.com>
To:     Michal Hocko <mhocko@suse.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <Y7PhVaqhIzs8e8mU@dhcp22.suse.cz>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230103082008epcms1p6f75b54cbfeba0a1ab9a8044dc650134b@epcms1p6>
Date:   Tue, 03 Jan 2023 17:20:08 +0900
X-CMS-MailID: 20230103082008epcms1p6f75b54cbfeba0a1ab9a8044dc650134b
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjk+LIzCtJLcpLzFFi42LZdljTQNfi6eZkg0+LrSzmrF/DZrF6k69F
        9+aZjBa9718xWVzeNYfN4t6a/6wW9/scHNg9Dr95z+yxc9Zddo9Nnyaxe5yY8ZvFo2/LKkaP
        9Vuusnh83iQXwB6VbZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+Ti
        E6DrlpkDdI6SQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8CsQK84Mbe4NC9dLy+1
        xMrQwMDIFKgwITvj/PftrAWbpComTr/H3sB4V7yLkZNDQsBEYtOk88xdjFwcQgI7GCXenVvO
        1sXIwcErICjxd4cwSI2wQLDE5VUn2EFsIQElibM/rrBDxK0l9i+awQRiswlYSmy/OZERxBYB
        qunavJMNxGYW6GaSeDzPBWIXr8SM9qcsELa0xPblW8HqOQX0JJY+XcUMEReVuLn6LTuM/f7Y
        fEYIW0Si9d5ZqBpBiQc/d0PFpSTOdR9nAjlZQiBC4sUedYhwjsT7nXNYIWxziWcbWsBG8gr4
        SlybuwEsziKgKvFyzg82iBoXiT0TTrBCnKwtsWzha2aQkcwCmhLrd+lDlChK7Pw9lxGihE/i
        3dceVpivdsx7wgRhq0m0PPsKFZeR+PvvGZTtITH5/BQWSCivZJSYf3cJ0wRGhVmIgJ6FZPMs
        hM0LGJlXMYqlFhTnpqcWGxYYweM2OT93EyM4YWqZ7WCc9PaD3iFGJg7GQ4wSHMxKIryTXmxK
        FuJNSaysSi3Kjy8qzUktPsRoCvTzRGYp0eR8YMrOK4k3NLE0MDEzMrEwtjQ2UxLntYlYlywk
        kJ5YkpqdmlqQWgTTx8TBKdXAJMFkute3xjiEtWfLzhJZfbU9Ek65y+eny56ssU33676RHqQZ
        f0FH/MCKSgOVXauqzykdfs0ibx4u9Or45113FxjyXc+WClTdr581NUL/8IFjZ/O21f3wi1ij
        r3D3m+z0X1rSZu219p5stz6c6pv8/YZx5OSfgYK8j81+Pg6a9eXe3PBtlU/XJpu/7zp84dvT
        6kOLSu9Ocl99KVqZ5ZHti5VM7sftt5vN9O+8EaLC/apk1+6FV34pvdhw/8CMnO36zq9zLFem
        Nxz9P41l8gyDiXIsrY98mQ3OGp0PXmvAtmtbnv6agHPP38xL6n+x9a2ozjHFqXn6XQvFnQ+F
        lhbd7vgaWLz0rf2NRDOxHK4l75RYijMSDbWYi4oTAe0rdy0hBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230103072834epcas1p3441ef50a6cc26ac48d184f1244b76a0e
References: <Y7PhVaqhIzs8e8mU@dhcp22.suse.cz>
        <20230103072807.19578-1-jaewon31.kim@samsung.com>
        <CGME20230103072834epcas1p3441ef50a6cc26ac48d184f1244b76a0e@epcms1p6>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Tue 03-01-23 16:28:07, Jaewon Kim wrote:
>> The totalreserve_pages could be higher than the free because of
>> watermark high or watermark boost. Handle this situation and fix it to 0
>> free size.
>
>What is the actual problem you are trying to address by this change?

Hello

As described on the original commit,
  34e431b0ae39 /proc/meminfo: provide estimated available memory
mm is tring to provide the avaiable memory to user space.

But if free is negative, the available memory shown to userspace
would be shown smaller thatn the actual available size. The userspace
may do unwanted memory shrinking actions like process kills.

I think the logic sholud account the positive size only.

BR

>
>> Signed-off-by: Jaewon Kim <jaewon31.kim=40samsung.com>
>> ---
>>  mm/page_alloc.c =7C 2 ++
>>  1 file changed, 2 insertions(+)
>>=20
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 218b28ee49ed..e510ae83d5f3 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> =40=40 -5948,6 +5948,8 =40=40 long si_mem_available(void)
>>  	 * without causing swapping or OOM.
>>  	 */
>>  	available =3D global_zone_page_state(NR_FREE_PAGES) - totalreserve_pag=
es;
>> +	if (available < 0)
>> +		available =3D 0;
>> =20
>>  	/*
>>  	 * Not all the page cache can be freed, otherwise the system will
>> --=20
>> 2.17.1
>
>--=20
>Michal Hocko
>SUSE Labs



=C2=A0=0D=0A---------=20Original=20Message=20---------=0D=0ASender=20:=20Mi=
chal=20Hocko=C2=A0<mhocko=40suse.com>=0D=0ADate=20:=202023-01-03=2017:03=20=
(GMT+9)=0D=0ATitle=20:=20Re:=20=5BPATCH=5D=20page_alloc:=20avoid=20the=20ne=
gative=20free=20for=20meminfo=20available=0D=0A=C2=A0=0D=0AOn=20Tue=2003-01=
-23=2016:28:07,=20Jaewon=20Kim=20wrote:=0D=0A>=20The=20totalreserve_pages=
=20could=20be=20higher=20than=20the=20free=20because=20of=0D=0A>=20watermar=
k=20high=20or=20watermark=20boost.=20Handle=20this=20situation=20and=20fix=
=20it=20to=200=0D=0A>=20free=20size.=0D=0A=0D=0AWhat=20is=20the=20actual=20=
problem=20you=20are=20trying=20to=20address=20by=20this=20change?=0D=0A=0D=
=0A>=20Signed-off-by:=20Jaewon=20Kim=20<jaewon31.kim=40samsung.com>=0D=0A>=
=20---=0D=0A>=20=C2=A0mm/page_alloc.c=20=7C=202=20++=0D=0A>=20=C2=A01=20fil=
e=20changed,=202=20insertions(+)=0D=0A>=20=0D=0A>=20diff=20--git=20a/mm/pag=
e_alloc.c=20b/mm/page_alloc.c=0D=0A>=20index=20218b28ee49ed..e510ae83d5f3=
=20100644=0D=0A>=20---=20a/mm/page_alloc.c=0D=0A>=20+++=20b/mm/page_alloc.c=
=0D=0A>=20=40=40=20-5948,6=20+5948,8=20=40=40=20long=20si_mem_available(voi=
d)=0D=0A>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20*=20without=20caus=
ing=20swapping=20or=20OOM.=0D=0A>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20*/=0D=0A>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0available=20=3D=
=20global_zone_page_state(NR_FREE_PAGES)=20-=20totalreserve_pages;=0D=0A>=
=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20(available=20<=200)=0D=0A>=20+=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0ava=
ilable=20=3D=200;=0D=0A>=20=C2=A0=0D=0A>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0/*=0D=0A>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20*=20No=
t=20all=20the=20page=20cache=20can=20be=20freed,=20otherwise=20the=20system=
=20will=0D=0A>=20--=20=0D=0A>=202.17.1=0D=0A=0D=0A--=20=0D=0AMichal=20Hocko=
=0D=0ASUSE=20Labs=0D=0A
