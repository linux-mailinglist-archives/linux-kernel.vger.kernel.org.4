Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E7C702AB8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 12:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238984AbjEOKjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 06:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjEOKjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 06:39:39 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2062.outbound.protection.outlook.com [40.107.249.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43441A4;
        Mon, 15 May 2023 03:39:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F/m1DkyyVwX7H0Xc8DoXqBvdnghDLyCzdMkJvEtdz8795IKh/LgYz6PGAlvpCx2TDmcH3Zx9+Kn1swpsATF2E8gQO9DpyGsDGEpfdz8tPsAwKVZ4a53pWtxauYnqb2efehTiqL7kaeBdJ91d/Et3f5+H2XZ2cBJAHy2W4eL/piJDH1Y0+y+uYj/eFBOfX8CYkDNRUxlCDvG3azJC6RpML8uOJRmlpSTL6XZtCKQuGq5pD9cryMMs0uk9rU7bxU1tTNkNroogTwm+LSuKHikZAyXB8QOCdxLO+8T/Jhax3K1yhDlxjZaPQUSHGKnTvkpiaomOuRcbUrdFkY8q+gNDJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BOPKUIVgYcSEsWbuL0nygWhEARJn0r6hmuKY9XfMPFc=;
 b=eRRH76YURYSuMfaDOPsJToo0MB6vLHVFeaDd3NHEwnDeLN55m4C9+G+337F7g2RCf7mvNFyxmpq5yeEzSR0PnJveEmRFnzEgP8JReytVzKw3WG4nlRJ/FfraxEayhUkL6Q6jdb3DWEM83RtrS2ixdr1sL/ZfBNlcR4EErGKz5aBpGslHa+4hfehQWMqVtO+VWq9i5BI3FZ0Qa/LFkXsBM65/mpkmhEvwOxYSf05te21f9snnMA3yzsq2Wc8i/N/ZU0BR5xDZH41PpnUgK0p4tLZgCXUfc+aNALuh175e4NhTfptYifnncSZh6IDV2mEIzYv7mXcYwKN1vagSPAGo9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOPKUIVgYcSEsWbuL0nygWhEARJn0r6hmuKY9XfMPFc=;
 b=Ema3ZoDN5iCPddWqn3iW78SGCoQ/Wh3Hxs57JFJmH9UStXlT5Xl64D0z0X1fwsAyglMTOohxYqnT9anPUzVnBFtpNzkXFZxEZBPk90hM7/Nsh41jP0rUzltunGceYI0he9E6avi4V5yM+HgF18OQgWt5/z6FzmH7IjkWeT5JrqmicpjteA1R025WHEnmGtzws51aC7jgVLRNO0wrEkRc0y2Mm19blHpQfx4Wc0d2EO55vcFvfeVxPVMPTO96hyhoTt4pdjH6KbKNwxZ+dFVA8v/ypk4waJC5KOLZeiEDSpUrg5KMM2oBl3wZ7gIqfNR6VcJQViNB7luhoF87IhKaiQ==
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:395::21)
 by PR3PR10MB4047.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 10:39:35 +0000
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d737:1f7c:45cd:b05e]) by DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d737:1f7c:45cd:b05e%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 10:39:35 +0000
From:   "Starke, Daniel" <daniel.starke@siemens.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 1/8] tty: n_gsm: add restart flag to DLC specific ioctl
 config
Thread-Topic: [PATCH v4 1/8] tty: n_gsm: add restart flag to DLC specific
 ioctl config
Thread-Index: AQHZhYYPo9fVByIlJ0uLpD0lsXq4IK9bKAiw
Date:   Mon, 15 May 2023 10:39:35 +0000
Message-ID: <DB9PR10MB5881B63FBBA7912DF5A7A6A8E0789@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
References: <20230426080315.7595-1-daniel.starke@siemens.com>
 <2023051316-flatly-spookily-5a0a@gregkh>
In-Reply-To: <2023051316-flatly-spookily-5a0a@gregkh>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2023-05-15T10:39:34Z;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Privileged;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=52ddf114-7147-4ee1-9406-2422f0cc31f6;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0
document_confidentiality: Restricted
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR10MB5881:EE_|PR3PR10MB4047:EE_
x-ms-office365-filtering-correlation-id: c22fce7c-d610-4cc7-3800-08db5530ad54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +KKRMDMwwWRCFu00R37+rhyhmHQtvcGxEeLWjvsCkIc+aZdcuaSyBXN8sd8rZgzSEfLur3RqggKfwo4oFxuQ5MJ2l/Dv0zwh0xUE7GY+Q5tzawZw0iN/ImxAgORksXJRp7U5JXXfoxTumBQKnbT56sJ6/I8VDFAvDYkth8MnCQZkNlB7fYkei/XR8svgQb8ALvvbWqpsc7kExjOqZha+5Do2TRu7UCCybLXZ6MlnOZANXmnsiHU9QC+Z30ZX/HmNlI3TSc9EHsJYTHOInfdu7Q9TOV3drVC9ybv9U6ZsrinTgYt1+bfX8Ikvr5amkX9/n/1GC5l/1smHbcMVC7WHqLJDRwRRypLupcCzfi8C4tu/5nRIbVepb1tZrSlGSmW0ZaxZrGUpL53jCMmQrUwaKvq+kBY36iY/2lnXEwD4/+Ro5od6T+BQYuhEbAxrUR4p+Cpq3kLQ0u8wztVaXZ7IZwo+e7B6JP/JK7iwrskzA4HcMuVWmKvnkdvfGeC75IEZitWY0af7DuFjqkSk8RwCoaNqaQolizaFVJrY9Me3dJUlY7fd95mAQZ2zO/4W8eb1LyqTOa9kKw1x0B+75rYMa2nnO4WIwKGB1B9bheh6G9i+rCixiM45tIkn+SJbZTLw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(376002)(39860400002)(366004)(451199021)(64756008)(66446008)(6916009)(4326008)(8936002)(71200400001)(8676002)(66476007)(82960400001)(66556008)(316002)(76116006)(41300700001)(55016003)(478600001)(66946007)(122000001)(54906003)(38100700002)(186003)(9686003)(38070700005)(6506007)(4744005)(2906002)(26005)(33656002)(86362001)(7696005)(5660300002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Gp7Pt9ogXbAKjG1kq47ES916D4+BnvuiJiZZXAWfJkgRsqpVi+Q4F8X8FTYc?=
 =?us-ascii?Q?egxYHDpaPXnqhdaTxpk9xrhbhE7RUVuhFwVMBCVad+1C7d/tGGjgdETCCD4k?=
 =?us-ascii?Q?gnfKz43uivn//djV5sJ2ZjvGGkSu1QvZAE67bqf4UHmlk0C0cHQ6/jpj/qLq?=
 =?us-ascii?Q?ukkR3JFrECd61TJT2x6+gnDss+1Zt6QskxGvKVi8NM1+ouHZLRaxVc3pTO+/?=
 =?us-ascii?Q?5wZNLhK0ncNjgKkByQQH3/wrvV1wXrrQihpQXXg4Sc2phES74BDYqUE8ip0l?=
 =?us-ascii?Q?eBfMffJrPlXwP06kXWKhh3/+leAQCByr328APOfMybM5CX6uq9ESZ4lcKiGb?=
 =?us-ascii?Q?393S3z3MeyiI94XJEYexEAOZ1HqYm80XCwoP69nzcUPcs+l4KWmKpacRXu7A?=
 =?us-ascii?Q?PmJvYH5c3Rl7VrHsctlEWxJQxcjx45Nf/oc7Uv0tHmRxZCALyIipcoDM72jK?=
 =?us-ascii?Q?pL/KB9Q4zRVOBmssw3pgCzY7oYYMXxrN4XDYJHhPRbnuTJEEmFQpT07tHfOB?=
 =?us-ascii?Q?3BsfvLr0V6Gt9//b5Ov7027WeyMM9NPcYn4hZaNDj/HBFCVwgXrbmM92WVx2?=
 =?us-ascii?Q?22++p74dbyWazKGZ5bPcsQBlUgZf2tH+FUbhYkrdK+ErJbPQfdkAKvvKl1R1?=
 =?us-ascii?Q?IjNEUrkZWjrVe0rg2yZSwEg6XQO6PPwQ49Za/G7PLXsCn4C+Ue3YbJYJmGhJ?=
 =?us-ascii?Q?pon88t9AH6ABvnT/GJFqqAx39hDrJn/MYu/NN7SAOKN6E66BjFd0iMROLHpE?=
 =?us-ascii?Q?TPSwmBPKwkHNP9geXJkv9GMG1njm86SrULpKrNT9PWXXQFHdvJA72m0XyoQM?=
 =?us-ascii?Q?uVgR9klcmR6MvCKqHBX8k1+f709U/lC97bPAuTBK1K21yAOyX72TjLm7vbOx?=
 =?us-ascii?Q?d34IKpEmEm0sF81GhhVblwtXZM4NuNUTRGzeErrsTt5/efsqT8JEqO5JBC+L?=
 =?us-ascii?Q?9aw7sN1jhjQIg9EbeWkXMJU6yBcUSH9buw2j/QbQivKfFMpl/5EKPBio7ZE/?=
 =?us-ascii?Q?AXn7V5J/2KSX83/7MoWn3pOcEb+Cv5dydZLrWjOvpL+dnVBssKD9CKdXdUa9?=
 =?us-ascii?Q?ROlZinzW7WDl1qllviQ+NtnYdVFv/DCeLCF8GdH8O+OJ8qRDHtr9PV4AqoMB?=
 =?us-ascii?Q?ABLgvetMpCMbuJDMtwDWD9rC3BJPRpiCzxmYjRSe+wXQPmo1hUoxIBeTcP5X?=
 =?us-ascii?Q?QZfTaOJ7RzEMd8U53PvdU084SjdqAV9MiTqFT1Fw98rYYZY5j/zV+VvlqE/K?=
 =?us-ascii?Q?jodDtxs/Y7GNJgrcf70HAiYlWHD9nyoNPOlAdRR5ZqGFcEi/QZK1Y5OJKZGy?=
 =?us-ascii?Q?LZw3q9RktvdOyvXJ+TUuv1n9DRHTdYRp0vYEowLG8u4+dmNaNTyH/Ng5zCQj?=
 =?us-ascii?Q?y3QPnZNG5fHAp8Gq96U2a/NQnuCHDjNb/2idNW+lFWXjS2kyLa1AKmRMGVbp?=
 =?us-ascii?Q?D4YQFabLnTGpUEwyAThNaK05vsdDqkJn4/UfM8TwVZiDcNt/bpkLmsIuKmeU?=
 =?us-ascii?Q?ZG3LOJzDUsIZllHY06EHp+fP7JspG0L755LZpFoXXKh+tLG4ytqXdOtNmhVx?=
 =?us-ascii?Q?MM3xYIgDE+wnMej1yZCSBa8iWm7Sp7Pxsunsp4xK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c22fce7c-d610-4cc7-3800-08db5530ad54
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 10:39:35.7327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X9UJCvNnx2kMrjnSxtdL+rsTAw8QgIYJPYBL17EqW9rVgBXboh5Ubgm1njVlwidhwVW/+lla/bTNqRfklXR8kJO7ecnWO/4CVa7wRgcgJaI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4047
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +/* Force DLCI channel reset? Always cleared on retrieval. */
>=20
> I do not understand this comment, sorry.  What question are you asking?
> What happens if it is set?  What happens if it is not set?  More
> documentation is always good, especially for new user/kernel apis that
> are not documented anywhere else.

Ok, I will rephrase it to be more explicit about it.

Best regards,
Daniel Starke
