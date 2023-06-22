Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5725A7397FD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 09:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjFVHQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 03:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbjFVHP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 03:15:56 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A371BD5;
        Thu, 22 Jun 2023 00:15:55 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35M74ppu019877;
        Thu, 22 Jun 2023 07:15:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=8KujPxOk+1rw2dRTOzNHOqqLzY1aSCU3afJ7kl6xJZc=;
 b=A4x/XZcSYv4lq9kcpiFNnUPCbmg16GlTB4GcZTBRYVbj1WFTH9Mt+5WRkf9EzSe4V5F5
 XQeBCT2SLP06RUGybsn1amPlYMJxP+TgTOa3vfubXB30TgZXR68rlyH1mDRWPdGcyGIt
 VXIHF10ymY/mSOPfQS5okMOjnONFFbaV7pwLXHmgFY1JqNaI1ix/azOhxssRMmOwF/d0
 CSmwonwvl8Jd9PuomGZnFBMYT35lvqlbBuLEX21+xzAzYIA5wwevLujDvoiUajre+u0I
 mYXBPWeICGWo+5a99uVWs7ytF1GeAhsj6WNRUmL11oOCkQ6Vl4fxGdoCeXiaj32yDpbm Pg== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rchcjrjmd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jun 2023 07:15:50 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35M11ErP002070;
        Thu, 22 Jun 2023 07:15:48 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3r94f5ba97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jun 2023 07:15:48 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35M7FjE363177180
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Jun 2023 07:15:45 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F21D920040;
        Thu, 22 Jun 2023 07:15:44 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B240620043;
        Thu, 22 Jun 2023 07:15:42 +0000 (GMT)
Received: from tarunpc (unknown [9.43.40.156])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu, 22 Jun 2023 07:15:42 +0000 (GMT)
From:   Tarun Sahu <tsahu@linux.ibm.com>
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>
Cc:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
        "jaypatel@linux.ibm.com" <jaypatel@linux.ibm.com>
Subject: Re: [PATCH] dax/kmem: Pass valid argument to
 memory_group_register_static
In-Reply-To: <b7e620efa0de6b9f7a8ae9ce51d8dd562f384cdc.camel@intel.com>
References: <20230620140332.30578-1-tsahu@linux.ibm.com>
 <ZJIz07hQiXr/MghO@aschofie-mobl2> <87cz1p1h8c.fsf@linux.ibm.com>
 <b7e620efa0de6b9f7a8ae9ce51d8dd562f384cdc.camel@intel.com>
Date:   Thu, 22 Jun 2023 12:45:40 +0530
Message-ID: <878rcc0xyb.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4rvSWEt4RNEs8YRe1pxUCY-BjViME5yX
X-Proofpoint-ORIG-GUID: 4rvSWEt4RNEs8YRe1pxUCY-BjViME5yX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_04,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 phishscore=0 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306220057
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Vishal,

"Verma, Vishal L" <vishal.l.verma@intel.com> writes:

> On Wed, 2023-06-21 at 11:36 +0530, Tarun Sahu wrote:
>> Hi Alison,
>>=20
>> Alison Schofield <alison.schofield@intel.com> writes:
>>=20
>> > On Tue, Jun 20, 2023 at 07:33:32PM +0530, Tarun Sahu wrote:
>> > > memory_group_register_static takes maximum number of pages as the ar=
gument
>> > > while dev_dax_kmem_probe passes total_len (in bytes) as the argument.
>> >=20
>> > This sounds like a fix. An explanation of the impact and a fixes tag
>> > may be needed. Also, wondering how you found it.
>> >=20
>> Yes, it is a fix, I found it during dry code walk-through.
>> There is not any impact as such. As,
>> memory_group_register_static just set the max_pages limit which
>> is used in auto_movable_zone_for_pfn to determine the zone.
>>=20
>> which might cause these condition to behave differently,
>>=20
>> This will be true always so jump will happen to kernel_zone
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!auto_movable_can_on=
line_movable(NUMA_NO_NODE, group, nr_pages))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0goto kernel_zone;
>> ---
>> kernel_zone:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return default_kernel_zo=
ne_for_pfn(nid, pfn, nr_pages);
>>=20
>> ---
>>=20
>> Here, In below, zone_intersects compare range will be larger as nr_pages
>> will be higher (derived from total_len passed in dev_dax_kmem_probe).
>>=20
>> static struct zone *default_kernel_zone_for_pfn(int nid, unsigned long s=
tart_pfn,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0unsigned long nr_pages)
>> {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct pglist_data *pgda=
t =3D NODE_DATA(nid);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int zid;
>>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for (zid =3D 0; zid < ZO=
NE_NORMAL; zid++) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0struct zone *zone =3D &pgdat->node_zones[zid];
>>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0if (zone_intersects(zone, start_pfn, nr_pages))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret=
urn zone;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return &pgdat->node_zone=
s[ZONE_NORMAL];
>> }
>>=20
>> In Mostly cases, ZONE_NORMAL will be returned. But there is no
>> crash/panic issues involved here, only decision making on selecting zone
>> is affected.
>>=20
>
> Hi Tarun,
>
> Good find! With a Fixes tag, and perhaps inclusion of a bit more of
> this detail described in the commit message, feel free to add:
>
Thanks for reviewing, sent the updated version.

> Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
