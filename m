Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98746BBFF3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 23:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbjCOWmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 18:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbjCOWmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 18:42:02 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0C358C3E;
        Wed, 15 Mar 2023 15:41:53 -0700 (PDT)
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32FLc2hM032165;
        Wed, 15 Mar 2023 22:41:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=lCyOE6e1FFKtH4XTBkgDlMFR1aBI/F58taXRP3vxYTQ=;
 b=VpVZqwbLk2tLH9uwZoy+bhN/Ajs9RGSy0a8pzqRflC0JHX1EN1Ue9I8sooqAjgITFK5h
 Bzx1IFRNkKl3Y2gLBatsn+YRFaN+MwO3rAiVPN9Smy0q4jOGoxVhHs2ppbvlTGAxGiy8
 w6WvosQyL1luu/FQku+BYsPMVnhwTkmohWjmrs39y12lAF+tYg0YiV7NzxXPDenoCt70
 hmg7fn0UOti1gZAQROCyhYNQJPiCqCB/vQOXjBZjqec01EEE3dqe6vQcmocjeJcKA2jl
 Ug9M8b5rarUm+u3PLW6FJr3z+DBjG4o7qxRddZ3bxz7uniGE5YxjPD2UC9Ztqcwi19Od NA== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3pbp3x0b90-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 22:41:50 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 1FFDE1308E;
        Wed, 15 Mar 2023 22:41:39 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 15 Mar 2023 10:41:38 -1200
Received: from p1wg14926.americas.hpqcorp.net (10.119.18.115) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 15 Mar 2023 10:41:38 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36
 via Frontend Transport; Wed, 15 Mar 2023 10:41:38 -1200
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 15 Mar 2023 10:41:37 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UL8tJt8YfuelK3I6GrUZd/5CMRJv3EHrEUmw3GxgJ3yBpx5CnI4HYeT5DGydAgztPVE8JvPxpuQZxmuiILkMHz2oZFkfGb/2+fejmb7vqMbxh1dQvGLuPgY6oFnGf2jj427oJ0WiL4lz4cQl8BGurduzHJ7ZNA5OCMfecj5PY76eUN3tDUoeeBIHIDtx/I/WKSVk4jThYiPMTJdsseMFKJ701Jy68DRuWXozN6UVyoFV/498cuX1NSNoJzDsDxefmnF6u90uTYMFzasJDwoSLFgWm2tN1B0Jr+ziOZa8tE2rkCU7zMD6H98BsrjmYTHdo6kGMb42mUjNjknA6p4kGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCyOE6e1FFKtH4XTBkgDlMFR1aBI/F58taXRP3vxYTQ=;
 b=kLFHcv7x7YRCp6jzt7pHG4X9RM2v571MntaccaX5G4plmFt4VVxRdwCmBQ7RNsS2mSHUvQMgxUxbq71C2FiXx8BnPWm462q6nIt3Y5egBqcrHccwKYtfwYTiU2x1F51pZTgDu5t9HO0GRoagMI6tP1K7aFXBfOm2vdZ5bSygI6600DTynVMc20AwMkY7qydg2MHAx+PI2K3/7auhStm7O5KblrPWnJzIHo3f8W++37TqvJ4xAYQ3/RbwGOkQOHYlj4AulGDs4zru0nInvpdGcQ6hjwdxvzPrR1yrZxPkoc22ykBDmhM803e5PHkKncV4q21zSKCdjykOt/uKvUkErA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1373.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:48::7) by
 MW4PR84MB1659.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Wed, 15 Mar
 2023 22:41:28 +0000
Received: from DM4PR84MB1373.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::7040:7ebe:4715:31fe]) by DM4PR84MB1373.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::7040:7ebe:4715:31fe%7]) with mapi id 15.20.6178.026; Wed, 15 Mar 2023
 22:41:28 +0000
From:   "Seymour, Shane M" <shane.seymour@hpe.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: RE: [PATCH for-next] scsi: Implement host state statistics
Thread-Topic: [PATCH for-next] scsi: Implement host state statistics
Thread-Index: AdlW08zNHKI7PyClSKC1+KomWCdnWgANKaCAACDMkHA=
Date:   Wed, 15 Mar 2023 22:41:28 +0000
Message-ID: <DM4PR84MB13737BE099BF599DF83617DBFDBF9@DM4PR84MB1373.NAMPRD84.PROD.OUTLOOK.COM>
References: <DM4PR84MB1373DCD07EABD28D88129C50FDBF9@DM4PR84MB1373.NAMPRD84.PROD.OUTLOOK.COM>
 <ZBFnYwtr+2bfjvcY@kroah.com>
In-Reply-To: <ZBFnYwtr+2bfjvcY@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR84MB1373:EE_|MW4PR84MB1659:EE_
x-ms-office365-filtering-correlation-id: 06c6e308-3bd4-4109-9ae2-08db25a66a74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fiBwaWfnIlDNWg5tJOJ+itUpHvuu8D5wpnGKEAjszyDXmh+tz9jt4MTWkWr3qAxaMZk/CSE2Ld4DQLQeCfm4LR+QUVKVPgIZySiB+8kAmBSvlDZlu+a0gVw3aQwxypXzWUCDVHFvjb5KHG+WeOy2oEUrljPscJl+pwOgkL93ADKjNP++wJI5Enzx8QDmOH+UlKQI8UeXrPa8vDE9moTf9jK9fTsv8A4F0FJksT6Rb/afdPDPWc7qeRGhQDPgm+BX5lxyFDfyb9TEeh37zve5Owpqvi8Eo2cK/GqBhCXuYkdymTpUm0mgf6IX3InsvioehDkibVdTu15dy3zEbFW1fM0qSWXClbSPcRlgplQ0T3MFVd4WqOE56tbFYLIrxvQo0olkKYR1ypBjtFpuiXkhOFfjqzBGne6O4iFzt7/2DDAICZhRmCzQRG5H0IgmoJIpG6268aUO6BRPptsyVTRgvR1xx/LfoLW3mTy6Lc/Nn/a5N3TuNPomUt3HqtbgCrkD0GasIwj73NLeUqySFG9b4+aXKq17uasLRFeEL8VIqtMwA02O1R+BPaXVF3q/aIvQH/A2aWaK+BjVUWCM13CS5pJh18R3WHHHpSrjwkpKZpiYgZiScD9gTbO3A5Ag9wKtk0qsBLctyKytsENN5d5oC4YTCV5jCAmDM54bTdy2SjTnvOTovhOSv9Gs/QplLmFH/U53ZbQykIoAA0heYeU6eQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1373.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199018)(7696005)(26005)(6506007)(5660300002)(82960400001)(38100700002)(66476007)(66556008)(66946007)(6916009)(66446008)(478600001)(76116006)(122000001)(64756008)(9686003)(316002)(33656002)(8676002)(54906003)(186003)(4326008)(41300700001)(8936002)(38070700005)(71200400001)(86362001)(83380400001)(52536014)(2906002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YoU3D+EQlTZRw+GeTcEbKMtoWMFVCjUsloos6y+WACzgZ8bYMkSpi95R+kW0?=
 =?us-ascii?Q?XRZABEUy7B6B325Y1vPOKzvqHXRQAsJNqqDwM9oqoVq3ABNAN32TcC2dyL9i?=
 =?us-ascii?Q?UtyyH0HOzi0jLKTAOxG5V9AYE3aSmsla/Rknxqhr3Wn7k1u7oWvXUnRUjNfx?=
 =?us-ascii?Q?TANntG2t1aWHgmGpLWejlJPFg1zgTzRsT/TmpB4S5zklsNY2pJ8S8mBOSuoB?=
 =?us-ascii?Q?bKPdJc+LH5ICAS0i357O50bLlOva/vtnFqAzRAWObFGcd8W/w+SchGxVrgmK?=
 =?us-ascii?Q?QDsnkHlrWxNeWqrXp0q9buWZ3Ja6jkL7KJnvz7qlacIE1aG1z6AsHh1uVaba?=
 =?us-ascii?Q?WS51GtPC4sFBW7oZrUtRIDysXQTAO29Pk13l0HdIeDvnlilTcxtOX/8wtYpC?=
 =?us-ascii?Q?JF1s0C+oEP1Ka0koMu+hbxkYgjUtRN50JNoJEuOEPZO+c4+P5rOHUstfWxeA?=
 =?us-ascii?Q?yGgbMARfNUwv0FK9nig61JSzOSTAsJxR+sAU5x3e99fmBgflNdmQIQm6qV/3?=
 =?us-ascii?Q?8348UnaRGsoRNv9QoTPHr2t/8FeRpjTrzGkum74EObqd4U4iv28u1eNkx1Za?=
 =?us-ascii?Q?FLBkM4JatynUZPF9vFmtvPFa0DVjKd3ekDKr580zuUhuQJPB6ezzEMn7gWNW?=
 =?us-ascii?Q?RiFJVDQRzeTkgk48EBwn5KpBeKVMlFJd9/aw0uIAzWXGAO1+h3fD9MQNp9qv?=
 =?us-ascii?Q?hp/F2OB3V5vjQf65NmvsPY6AUEwMPOHls/qDQTgK8xzYkUBL2mGq2GMQ3EG6?=
 =?us-ascii?Q?T5zBZkuu9oMMGRL+DLNBZN7Whgm2AhWideE019LOSsvyLjSW+GjDwDgeBcsv?=
 =?us-ascii?Q?oy9urrhlfpOkFKWlYVGqmQLiVYnIt0qQnM/GhhT9my3msnqEQaS7KvGZ0pcY?=
 =?us-ascii?Q?B65QZum3drLw5zgsaM6noJgsb/pS1gzLpu1Rx7xvlo6l0HHu8rvZzOmwrJQz?=
 =?us-ascii?Q?Ub3SwAwCcaztKh9zTMOVVZzpkqHtEEXDF3lco8Npbh6aA+zQKoUKZhqxUcuY?=
 =?us-ascii?Q?DtscQmufi2ACF/qj/y4P4uyTnEPNHac0Ao3gAtWTkYJsK0ji+vzmzrp9iOBP?=
 =?us-ascii?Q?WB86kkuYLBWlq9Syz9MP5cx8ZQFc8j7NsJA0Td2OSdDcY6c7zL6WxjbHA7B/?=
 =?us-ascii?Q?PcyLXbBgX/StxBpp7Uoyr0IvnP/UhYBROKxwf8MVi0UvXxl18jmCH7i526Kz?=
 =?us-ascii?Q?M3HBw/QH+VGEqFuLJCHKD5ExbGryL6/PzyeQblmvq5XNWt4hgHs4r7SlRz1G?=
 =?us-ascii?Q?4CI1URm85DHxH+GUFdlM8W9OUzQinD5CHqbhMpnQ8TPRN/R3U/Fi140x/HXg?=
 =?us-ascii?Q?UVgpyKo/093drWhcq0+rJJ838tFitFKmv7pE3ZnWEfKk4Rq2d2XhWYAMcdRx?=
 =?us-ascii?Q?3bC3umot0RjeMq6AY3cL0Mq+jTpWPnoZIIctexepNXqClL/Qu0aZWkDGpJKq?=
 =?us-ascii?Q?syxd9i0OptdHr8uV4EYG9tLRNHsDNRVS7iUysV+TzI4lAAfHCQ7HfjhVYER0?=
 =?us-ascii?Q?UkznLN8h4hSGH+n8PO28eRJgDcJSf0V+0CfZU4WW0y2puYLP2uWXdv3l06eR?=
 =?us-ascii?Q?hWCg62QA2j9/ovu+iALG5VnHjx6AfATR9DSLnY/v?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1373.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 06c6e308-3bd4-4109-9ae2-08db25a66a74
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2023 22:41:28.3257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P96b7sLCfGzyLER9p2zM+YH5PVTPGbBrjCbTRkDeQocMsmEQvphuRAnNf8b5p6Q+zcQwYYAiMovV4FbdWAcOVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR84MB1659
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: MxvndzKBbCT9GMbkUm8sIHeAeGGdowR-
X-Proofpoint-ORIG-GUID: MxvndzKBbCT9GMbkUm8sIHeAeGGdowR-
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-15_12,2023-03-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=651
 suspectscore=0 bulkscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 spamscore=0 clxscore=1011 adultscore=0 impostorscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150001 definitions=main-2303150185
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Mar 15, 2023 at 06:08:19AM +0000, Seymour, Shane M wrote:
> > The following patch implements host state statistics via sysfs. The int=
ent
> > is to allow user space to see the state changes and be able to report w=
hen
> > a host changes state. The files do not separate out the time spent into
> > each state but only into three:
>=20
> Why does userspace care about these things at all?  What tool needs them
> and what can userspace do with the information?
>=20

In enterprise setups you may a significant number of LUNs presented to a
system (100s to 1000s) via a single HBA (usually via FC). Having a HBA goin=
g
into error handling causes issues. Every time a host goes into SCSI EH all
I/O to that host is blocked until SCSI EH completes. That means waiting for
every I/O to either complete or timeout before starting any recovery
processing.

At this time there is no way for anything outside of the kernel to know if =
a
HBA is having any issues. The cause of those issues can vary significantly,
just two examples:

1) Storage end point issues
2) SAN issues (e.g. laser transmit power at any point in the SAN)

My experience with downstream distros is that nobody seems to notice the
noise that SCSI EH produces (LUN, device, bus, host resets) and we see it
when we get a vmcore and have to try and work out what caused an I/O hang.

I wanted to be more proactive in warning users that you've got a potential
storage issue you need to look at. It won't help when you have a sudden
massive issue but if you have an issue that is slowly getting worse over
a period of time you will at least get some warning.

> >
> > A (GPLv2) program called hostmond will be released in a few months that
> > will monitor these interfaces and report (local host only via syslog(3C=
))
> > when hosts change state.
>=20
> We kind of need to see this before the kernel changes can be accepted
> for obvious reasons, what is preventing that from happening now?

If you don't mind I'll answer this in my reply to James' email soon since
he commented about this.

>=20
> Please always use sysfs_emit() instead of the crazy scnprintf() for
> sysfs entries.

No problem I can make that change.

>=20
> u32 is a kernel type, not uint32_t please, but I don't know what the
> scsi layer is used to.

No problem I can make that change.

>=20
> thanks,
>=20
> greg k-h

Thank you for your willingness to provide feedback.

Shane
