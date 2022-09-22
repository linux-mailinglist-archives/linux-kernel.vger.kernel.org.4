Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9980A5E6688
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 17:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbiIVPMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 11:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbiIVPMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 11:12:32 -0400
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3651EC40
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 08:12:31 -0700 (PDT)
Received: from pps.filterd (m0209325.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28MErubK032327;
        Thu, 22 Sep 2022 15:12:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=A0vapuMCnzGCWZh5ICxOyWnRWV5etr4j2G6jpPAbOUI=;
 b=NptWxND4UmM9d35G7FZ0C2qHdwC+F2bdKb+BGJrzOn+nIfnciHhzsJMR6WxzuVj6KUKN
 tIaLpU6NDnR9xVPcgDX1NMKbSS04KloWSgd35Xu5Wy8/YPN0YExLhW8ovRjSk97HqKFK
 MvO5q4P0Z/b+XN2Dx98TFEX2JvYscDY5hz+Uo+EnLidGAS38n5v7GBjE+6SU/uH3JscP
 ObtWNry6yyw0J1w71//EhZsfABr1vQ7feDQyFLhRAkPmciYvBhQxIPOyyY7b0nneKpVc
 ch9jdSLxq6xH4JMfV5pdtLNvNqINu+FgWP05IlnCjar3XRAl3SxKvPckiPu7h3FagaqO Ww== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3jn685nf8a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Sep 2022 15:12:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bx2hrOd9vYX+jbFl/4k+TYTf46YRFW5uEMVjCLcxQzmzR1v6lxHNENjQNsHPxYTzwLPsHrcEd5GKPYUiF2k6XWPNAdnGrxf8lBGtrt0Ktw+ODSIMAwNCifFUA8/49IkJparZtxBlqeHM7vceBsCoX9jLJgNo2Vh6FvbJQFOj6dKrRLibuQs2ede0dw5S4cd+vCt0oJuumCMKreRvX2UZHV7p45NMJhUxbDNnEKmsf6R+07nDOAq91l905/Pz7GmA8dHS+ViC6ohyA03gRImifGJ2SpQAbK6ThEbvFp2ELXjI+kFEgodWAq5iZ5OQejWx7J+PP0IluNhtTpV7JJy+CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A0vapuMCnzGCWZh5ICxOyWnRWV5etr4j2G6jpPAbOUI=;
 b=VCRItwXmSRx4GYNSLWKXgYkRtB+mca0y0O1aesClhqTmBkG474PX9Vo4+Z/WDzsemekPQDok+0K/mMY21mzf4aDK4l20qZKs6ERKEI5qTJWH1Mfe+hyfoszBWi+iDrtpUX5B49U6rVt3JESaGodeoF+L07Hts2DbrL60sZeib2pUrsHcmvK+Lq7epiJgQcU+2Y/pR2A930gIkLlN1Q4vBRHUiqykS7/64DPcuHNtN6zU0q7qn2nk+81qzwsO11jYSmQvtDJEIobf4Pp0xQTUI7kNS8YF93ql+jg6d+01utHKPruOEqf/3ewz/EMvPGB5LkTVJD3J5aIIZkJBfP3lhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from BYAPR13MB2503.namprd13.prod.outlook.com (2603:10b6:a02:cd::33)
 by BN0PR13MB4727.namprd13.prod.outlook.com (2603:10b6:408:127::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.8; Thu, 22 Sep
 2022 15:12:08 +0000
Received: from BYAPR13MB2503.namprd13.prod.outlook.com
 ([fe80::41c:5c3b:bff:666f]) by BYAPR13MB2503.namprd13.prod.outlook.com
 ([fe80::41c:5c3b:bff:666f%2]) with mapi id 15.20.5676.007; Thu, 22 Sep 2022
 15:12:08 +0000
From:   "Bird, Tim" <Tim.Bird@sony.com>
To:     Jonathan Corbet <corbet@lwn.net>, Vlastimil Babka <vbabka@suse.cz>,
        Chris Mason <clm@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ksummit@lists.linux.dev" <ksummit@lists.linux.dev>
CC:     "tech-board@lists.linuxfoundation.org" 
        <tech-board@lists.linuxfoundation.org>,
        "tab-elections@lists.linuxfoundation.org" 
        <tab-elections@lists.linuxfoundation.org>
Subject: RE: [Tab-elections] Results from the 2022 LF TAB election
Thread-Topic: [Tab-elections] Results from the 2022 LF TAB election
Thread-Index: AQHYyNcXbFYz7K9z6EOtH5Y+LFxJqq3gI0MAgAWE+ICABd2qgIAAEfSQ
Date:   Thu, 22 Sep 2022 15:12:08 +0000
Message-ID: <BYAPR13MB250311B16398B6781E1810CBFD4E9@BYAPR13MB2503.namprd13.prod.outlook.com>
References: <87h71984jy.fsf@meer.lwn.net>
 <9755284e-6b57-8340-dbf5-1bb50f036da3@fb.com>
 <70136115-5e77-c00a-9c29-b06cb8fcef0d@suse.cz> <87leqbse34.fsf@meer.lwn.net>
In-Reply-To: <87leqbse34.fsf@meer.lwn.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR13MB2503:EE_|BN0PR13MB4727:EE_
x-ms-office365-filtering-correlation-id: 61890757-801f-4085-9ee3-08da9cacd145
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iGg1EW1bU+WgUSZHMxNnzl1F0nBnKrOxZS/fBoR/f0QiuACcBcp3fHznE/JdUWoIlQFz+0/xJ/VeiT8xIZxwYEALAdidKCoVgWvsFSkxYqxnZNGn3MXxtYdI8lniA9YbVsuFuccEAdpvdhnfaXM01gCBKw8VoNikMtxugEIMGLwvJTidiv/Vl3B7RTBi4+N4PrfVjDx0N7poybjI23/QvsqgmQI/ljxD3JIQiih+fbn+a3YUcmxgRPJShpctgLOdclrFKXRLpzTyrGbLWG8vfd23hoD1e5SRdJmuu5L9R1jTcK/NF9dvmcU20GyAzcuO+pcUFBJzvW0yKoWoQH9dKzFPseYZLF+G/+ANxQ1fGzTshCif55Ee9nqROGbWTmJb5AKBDESDH/zyanZ2y8Qu8MlXFbNTgbyvzSX+ISNEOSpyvNRroXXeOxNQ/Kjz8EuPVpEjzMBl0b1ERf+fRH8g7Yd++EDJbnFHv9jH1aDRF6KPFeaAqpJHBlZy7IVd8RiqMAjCsB+rAhu/pQpRzb3pDJKM+c0qoEBhyDD0PUtdV2zIK4cR4/uZAPpQUjo2iGlpjfkD6NMYmjtD8iDEqE3GLSc/uj3KeQa6JgMiKOJg4ajO19Uvr4lKLuyOdSz7Bax27JchYdwIyYMZDRDaHKgGnabQaeQ4c/ehXXoeYzzWyO4qE3fkAHSikCUBvoHHqStHwGyV+8ecqfZ1g0J3yfwJmiCQFQdFwemkSs8Ty8QvWMc9afk9Xih/r3/ddpfZlgZxtoTpIPkcVjvF5A8+pkIC7g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR13MB2503.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(396003)(366004)(346002)(136003)(451199015)(8676002)(186003)(66899012)(33656002)(71200400001)(86362001)(2906002)(122000001)(478600001)(38100700002)(82960400001)(5660300002)(41300700001)(52536014)(76116006)(9686003)(54906003)(55016003)(66946007)(4326008)(83380400001)(316002)(110136005)(6506007)(7696005)(26005)(66476007)(64756008)(66556008)(8936002)(66446008)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SwyDbAvNpI8DeKLQB1uzlJbuayIiRXMqW/wgpMfWbLYJyi7rTiDLwEKA2tDY?=
 =?us-ascii?Q?5akkeZDWE8iChlbur7paAKBksC0x1/aT2UeCic9m+uOWAd++goNjoPIU3dXA?=
 =?us-ascii?Q?ty0rdqouykfgGYeUQmg2kWUNSoTvAOr4M8Qwdf5gl0UL3vSn6pD4f0tXhrXG?=
 =?us-ascii?Q?jzj1BN99YaWb8NfZaC2LQAu7v8AsmnoYsXgYkh4dProI0z9d8HSTCOLhpEjq?=
 =?us-ascii?Q?/gLR+3fggkMsCJa1GjmQNV5ouFtCvmJB0PqADsUQfg9Sl7ISYvZI3mezFxm4?=
 =?us-ascii?Q?qXlbDYHO9/UlDahLqAKSG3XKpy0KmvtJkcRFuITeJlSSJEWQF+lr/+qNT23L?=
 =?us-ascii?Q?+j+wQJ6D1rArlN/0aCnBOMumgegjodGDxrjEd1GZS3qPgPBkirp+oFW09rhC?=
 =?us-ascii?Q?iQVChaMxQASF6AyUTvw+GRvT22VuQTGvm1VRwXo07lgyZe8TEGL2qn9TTTc4?=
 =?us-ascii?Q?TILc0xEfT4GWxAH6w3BwbbQnrN7Q7AhPuuCVuQydNl82oMoQv6reo8Ma2IEU?=
 =?us-ascii?Q?i/5VBJO/vk/02wXLDdOA2VMO+fCcpRwx4aF//wZv5wO7gDIOJb1z5zdndy5G?=
 =?us-ascii?Q?igAgFavU8k/I4V5xHPETOrH6n9Zqd7epnLJDIBZ9jJlW6LKXCjmXLf8Hz0xG?=
 =?us-ascii?Q?qsJaG3Zgt0MRQ5wr93mnt6BTPwtaPkSj4cm5URRyVIaz7R4qAVwSbYjl8TTK?=
 =?us-ascii?Q?743GMiZs9vjxoL074BYXDq9bPU78ke+SeG0pNbaC1OgZOZzkYlZU5wW4kpgS?=
 =?us-ascii?Q?5f0U+YJvmTE9TLzwTDgYYPDfLOjBvj5Kqo3T78ieThrHyi6jLv+cRi3i9iTF?=
 =?us-ascii?Q?ezrPPmdRBhWI9uZ8xvtAFX09mT7bFnXfVRNhTm6xGxVouBG1PWbJnneMhSra?=
 =?us-ascii?Q?WNCtkFTTTh4PHBh8Ufvkw5TtOUMjzB55UVBFfZE1rmZQmQ6TZW+htqgsqw8g?=
 =?us-ascii?Q?TLTOA2EApJUwwjmIgSQzdK2Sn8fcKVlrgUNPum+LhrFxu2kRUs+OpKnCIvEe?=
 =?us-ascii?Q?WU34bA4HYcHO5GS+awYmlsuk/QMmqw5UwSLq5uDY21x9IfY+aeUuGmigKAbn?=
 =?us-ascii?Q?v5ETbpCSM31CIZ+xc9RxuyAwWMxtbort72HLmCvayDGEVQBxIKj670eEloF1?=
 =?us-ascii?Q?d3n6dvGVUy8ZLaP7IKWXTgLhzvzzma2ryGWja4R9qpqM7ad1VTNH3exnRWVq?=
 =?us-ascii?Q?8Z5I9csz7a0WEV/ZIUSAZKW4VJ6PwebfwTaUhiuObYJJUDuHTlB4fXIEy2aU?=
 =?us-ascii?Q?BgJyVr0TojXQZNilU6j3ij40PPmx/v630gaZ+dQccxlqMLyfpnBYdS9nadx2?=
 =?us-ascii?Q?jQ0iXAfa4voM2ibglycp85gl1DxS/oHVKs4UB3l3GfS/8thaBz48p7E/3J/J?=
 =?us-ascii?Q?M3Kl/Tb+zrNQ/WvNjcxRhXTJVBYYDyLzuvfbOSs10I4Vg4ajWNRzkSHWPJqy?=
 =?us-ascii?Q?f1dBmF+KMHBoc7LLbUbJHbt3oNR+1B6UnfW/bTXBYXwLERL+1omDOBIlFSA+?=
 =?us-ascii?Q?AJP3lDq0LQRuxj94O/NMR15QUYnmmdaQxRj9vHuTOVmKlKvnyvQrQ+yEZR2s?=
 =?us-ascii?Q?inXcUhlxhopDM/51mwKdofO6QyZzjRVlKkEw8vQX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR13MB2503.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61890757-801f-4085-9ee3-08da9cacd145
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2022 15:12:08.5342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nvGqFIVTG8rt/pvEbZE4hU/4dButT1rLXAzWr19xTdUtIc+E7S955UdugqMHmIqElw/SM7MUnKxLE3CxP+6T7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR13MB4727
X-Proofpoint-GUID: kCud0nYH3iv7twACUWOpeWgYj1cYmLi3
X-Proofpoint-ORIG-GUID: kCud0nYH3iv7twACUWOpeWgYj1cYmLi3
X-Sony-Outbound-GUID: kCud0nYH3iv7twACUWOpeWgYj1cYmLi3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-22_08,2022-09-22_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Jonathan Corbet <corbet@lwn.net>
>=20
> Vlastimil Babka <vbabka@suse.cz> writes:
>=20
> > I was wondering, as the voting is fully online now, does it have to
> > still overlap LPC exactly? For example I happened to miss the most
> > important e-mail from CIVS in my inbox during the conference, and while
> > I tried to login there by the activation code, I could only see there I
> > was invited to 2021 poll but didn't see the 2022 one (nor I can see it
> > there now; I assume the link from the CIVS mail would have worked, but
> > too late now).
> >
> > Also, since it seems many of the nominations were last-minute [1] I onl=
y
> > saw two of them by Friday. So even if I didn't miss the CIVS e-mail, I
> > would have to read through the manifestos and rank the candidates
> > quickly during LPC, which wouldn't have been ideal.
> >
> > So maybe the vote could be scheduler for the week before LPC? And then
> > both the new and old TAB members that happen to travel there could meet
> > there knowing the results already.
>=20
> The current charter for the TAB ties the voting to the kernel summit; in
> the move online we interpreted that as running during LPC, where what
> remains of the kernel summit is held.
>=20
> I don't think it has to be that way; it might be better to pick a time
> of the year when things are relatively calm and just always do the
> election then.  It would require a charter change, but that should be
> doable.
>=20

I'd be in favor of this.  When we did in-person elections in the past, it
was good to tie it to some neutral, Linux-focused event.  But now that
we allow voting at a distance, it seems like it would be good to decouple
the voting from an event.  I was always a little bothered by the fact that
the in-person voting gave nominees who were present a substantial advantage
over those who were, for some reason or another, not in attendance.

Also, can we set the deadline for close of nominations a little bit earlier=
, relative
to the voting.  I think it would be good to give people at least a week to =
consider
the candidates and do some research.

Just my 2 cents.
 -- Tim

