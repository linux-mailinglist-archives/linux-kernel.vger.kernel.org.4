Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F607285FC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 19:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbjFHRJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 13:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFHRJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 13:09:28 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2061.outbound.protection.outlook.com [40.107.212.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD5F2136;
        Thu,  8 Jun 2023 10:09:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XIKgaFk0ygF/tRzqBo10ozSr+3MN4QTDrQ2FZ0xJDcuN57PItcehCP9i2KIrusLPA4L0Sk5TSNbFC0V7uICgwd6kvmjodEIxRU+/HvYiCRDPucPtwT3w9dwQzgwUXnbiW9BW9gxIM5SmkEBGp+hGhiEgGGuYtcFID4On0U8yA8SiPHNSMdUQp6im0Bm/4USk4V8aw0Sh5goxjb+0dTf+XD5ib4jcdh+/9KJcQxpqVd5QPRSdKcnZOitJlGN3Vnx75g1ZLV5inqo2YWsElMfHgVWMScrDVle9DL6oe/V9Z5f8ZAh7Y/0qDZdzyfR7oHVx38fivATy8GZyxpkpAcRIwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BSZp1ZVyZlm/AKoz4sN0OHg9nBPIB4zIpiGlpS78rI8=;
 b=EJ8CaiVWhnYWeZtVfwFmaU7rrhk8CaYd7P1Gsl/dsbiAZENiPTSnll4WeiYSRWoGQmQR70OvkXUOfH6OSv17BtGNEz96VJwmlHelzLo5S3/d8Pa1JBjHP9dvSMNSqsWCyG7zkASUGT1taGs+fVYRKimswc9rBfvuR4xImhcSmo5BDBxZBFsJb9pGGatZCKvxjQdCvgDoMehWAV8ysNtbb8sQL+fybA9KDBVcwCohjs/QZwfyNIL474B70fJZKuaRSta60Jq2CD+gub9Og3b2feVIPTnSiv57PxPNW5wd7RpXkDlmUdUQRcJdhHIPgm+FUNtuvrGyjUqlphyUmhkiLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSZp1ZVyZlm/AKoz4sN0OHg9nBPIB4zIpiGlpS78rI8=;
 b=S3gaMKhYTnpr1hlHPvkz+01rsDIhKH3wSSAzhicmJfDrqGUN9OWjO737yJElwnY1LqdZRXmpc3Sj8j0rmbvRamd1NFDu09rYsS6toFPWz3BMRWKY3ZjN8DIqWenfp7gZPr0KlgSzE8LNzqPE2wGL/mwOIl3V8Kgn6cCjiAd9EOM=
Received: from CY5PR12MB6432.namprd12.prod.outlook.com (2603:10b6:930:38::8)
 by IA1PR12MB6386.namprd12.prod.outlook.com (2603:10b6:208:38a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.31; Thu, 8 Jun
 2023 17:09:23 +0000
Received: from CY5PR12MB6432.namprd12.prod.outlook.com
 ([fe80::1747:b643:24a6:1030]) by CY5PR12MB6432.namprd12.prod.outlook.com
 ([fe80::1747:b643:24a6:1030%7]) with mapi id 15.20.6455.039; Thu, 8 Jun 2023
 17:09:22 +0000
From:   "Kannan, Baski" <Baski.Kannan@amd.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     "Moger, Babu" <Babu.Moger@amd.com>,
        "clemens@ladisch.de" <clemens@ladisch.de>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Ramayanam, Pavan" <Pavan.Ramayanam@amd.com>
Subject: RE: [PATCH] hwmon: (k10temp) Report negative temperatures
Thread-Topic: [PATCH] hwmon: (k10temp) Report negative temperatures
Thread-Index: AQHZjbgeStd3Ox1FN0ak11gIaKMq1q9oZLCAgBigoICAABOSYA==
Date:   Thu, 8 Jun 2023 17:09:22 +0000
Message-ID: <CY5PR12MB64326FB8A8E84A2698FEBB4D8450A@CY5PR12MB6432.namprd12.prod.outlook.com>
References: <20230523204932.2679-1-Baski.Kannan@amd.com>
 <68c53a76-efd5-42da-af98-442bd80c7300@roeck-us.net>
 <64e6164a-c874-403e-b899-45f741db2130@roeck-us.net>
In-Reply-To: <64e6164a-c874-403e-b899-45f741db2130@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b5efa730-d9b2-4ec4-a844-49217a0ddc38;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-08T15:01:53Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6432:EE_|IA1PR12MB6386:EE_
x-ms-office365-filtering-correlation-id: 96945b18-17a4-4ecc-d7e1-08db68431b03
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YOdSB4u9f4ppGkah04560KqF6FfgHVYAsWo96WQ7zTFRb6cvYL4Ll8QfSkf1VVa7BoSfUEt+i3Im237uvodIm+2FbkBYmaAafb9p8kfDOFdBHUbnLI6vpvdGCYcREOAbhMZfq7PlaNwuowIjcOAX8k4fpPVq9up381Q8Dcovq+poY+lNQxHvgGKZ7R7V6Hz4t63kLQkmdNwbTNt2SwV8ijnaw8lt4+oIQ+TI3K9YSkXk7ketOnnP9VfW5TW4zJDMOj5BfOqYF+xrj2tlF8AMMKs+abXKxfMXnR3fG5IXCTDBZxV6GV6cDs4hT6mmbn1n9KdtMFuZhl67W04WxFrtlIaoKhIcNUh8vhJ9wHoqS3ubYg3YpDyjJBKqJN9RO93F6RLyr+kH7A4InMC9dibNL0SUv1huPqtQg3TC/2XOUIFqNEUagi+M2yWFDDSfxfI06PJB4aKIbo6XDXETs/zGF/VrLJ1rOU26M2QRVlynyHYHxicZNhS+O1UHJjG5ANPBskv2bLiwJbuoUdmlcq44Tg5x5zRGfknrO94QKGewbRsbQzwxyMMtPKlQDTdHmK+FLHFspkymmSd/qoAsDjR09m9qlYIjViM5M5tLGsa/gfU9H2UipRqsEwpism4d8iDs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(366004)(136003)(396003)(376002)(451199021)(55016003)(7696005)(83380400001)(316002)(54906003)(66556008)(76116006)(478600001)(122000001)(8676002)(4326008)(8936002)(38100700002)(66946007)(41300700001)(64756008)(66446008)(66476007)(186003)(26005)(71200400001)(9686003)(6506007)(6916009)(53546011)(33656002)(5660300002)(52536014)(38070700005)(2906002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EDZjdlm5/cJNz83jI5yD74W39pfpKXOFk2U9b6U4kCMwLK2GrZIKAxTQNilb?=
 =?us-ascii?Q?5VjdHOZrGRZjITnXBwshaSlvhlsuXxuCuy6r9jmwQ0+0WkTzSA0Xf9Cvul6v?=
 =?us-ascii?Q?OUszivZK0yXcJdTTfIZzZdDZv7xARFIQBXM3u9zxJT2H/FoJ+TXHzhsCv30D?=
 =?us-ascii?Q?/dgNDlbsKJ+yFsHd5r2AWkIRvrc04r/2cFupVYXcR+BHNPAqhNCzmpuJkrDl?=
 =?us-ascii?Q?krGLR42ryxNU5wKlQhCq+k5nbMRI4a4AErCdJiVJKD0oY0hUoipONww3NV+7?=
 =?us-ascii?Q?JzZxsTQJKRiFPGbKyVl+v6PM80pu9guZ1GAhp/afhNQ10qJuOLWf3G+vRq8z?=
 =?us-ascii?Q?863Tsxgn4v03hrPrt7m+PmGZHcD6IHu4XRr9YTYw5o6WTKVxBYBRZnEoqgNS?=
 =?us-ascii?Q?K+RZmuBJSgZQZq//OUn+MSZxeUaYdJRLp2Rde7lWwIktE51CcrNhzKmQIYaG?=
 =?us-ascii?Q?qrob3QvmNI5Mz8GgxyDySFbGRly/Cu7/Xd8mJcZWJylMokQC/XmHRndzMT0d?=
 =?us-ascii?Q?a/4YT7g75CCGYwYhTbd2FBZ1zk76J7493KJ8lVxV3grj/mo8cC52JD4Go6Oe?=
 =?us-ascii?Q?WY1rjXt3QIhhblkN5Ufe8du0qFJHtM2dvV3s52Mdx0IVHmAso7Ie2zaS8Caq?=
 =?us-ascii?Q?LSRhcvuTLrIFqmCTsxfAFCMN+qajjK16r1mfTO5oM3sqvWTs2rvXFhSW5Lug?=
 =?us-ascii?Q?FZemCQUff7RQ7uuX4AyQ7x8PWanl4LsE0G/XzlhfW9bXce6vraetmLgFyELI?=
 =?us-ascii?Q?UCI2rkQK9FR6qw5pNywf+QzpGq4D5Lbw5tcPEeNq20K5OL7F1M7hSIyE7Li9?=
 =?us-ascii?Q?7p3xnlHaVBMM+wVd753s5Rf/WXaqjUb1DipKNeEVKt6rTGxQVefW75CS8lNv?=
 =?us-ascii?Q?xUHaIu3sVtuTKPehdhbkMRScx7WrOpAiJUgGz1kIlfTJkZgj3ZtExIyaxJsr?=
 =?us-ascii?Q?f+x5L+7wZ3wPB1qmcVOJujpx4sFeiA+saL2UpjBbsykYXOSUBYTn0wPnPj02?=
 =?us-ascii?Q?piN4j5z97+BGtz1L7GVDwCJDBDjDJXK2EII209wktxX1CHUL3JuBFSahHmtF?=
 =?us-ascii?Q?lzj3rBIMwbNvZ8IXsIXN5nAG/oMMglTrKfugyw7rUi6QdxBXur/VDwpAAkwG?=
 =?us-ascii?Q?ibyaqahbYNQZomxetsUkd/cp4275XPQU8/SQScTVoQkT2RUl5JHBIKlyXynS?=
 =?us-ascii?Q?76GmGgi9Ma6VXm18wof3pQOYRgR/QaNJ+yF2jsXE2bDC4uG5IYaZubjHyWwu?=
 =?us-ascii?Q?UV3awo1qlCfLe+lnjx6pe9IENB6Pu69VLH3RcHqJ3fuK/90Uem1SrxzRCF7y?=
 =?us-ascii?Q?lmMX3ei64+ubYQcOgaRcmO6WY0qIxjJcRAAcmW4LW/6QFxVYiE0GmkUDwmd6?=
 =?us-ascii?Q?5sWSdLXoa5YQpW6JDHSxQNtb3O5BPKPBKDhI72+xVtzAZn1L4H6tXMFc4IC+?=
 =?us-ascii?Q?klb/N2yQR9rDkav2iVDYPnbx3g1i+t7peMGiDzDQbUymXrNJYz0HDjPniKLb?=
 =?us-ascii?Q?RXK5QeIrCUDjaeL2I4e1V9zQN44Fns08gWML8Ed4duH9sr5m2EC5pAseL/dO?=
 =?us-ascii?Q?MvjgVb50rQ5UH+Usd1U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6432.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96945b18-17a4-4ecc-d7e1-08db68431b03
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 17:09:22.8319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iceukqqK3So59ymrTp4KFoeE7zG5fMRYZYg0IecNi9p8Kq3uf7TKdPJeP6okfniBNbah+Y6MoqTK7bOcUrZPBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6386
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - General]

The patch you have mentioned, aef17ca12719, sounds like a work-around for a=
 problem found in some Ryzen Threadripper processors.
If I understand correctly, this work-around (aef17ca12719) has been provide=
d as a blanket fix for all the processors.

The Industrial Processor in question is the Epyc3k i3255.
AMD Family 17h (boot_cpu_data.x86)
AMD model 00h - 0fh (boot_cpu_data.x86_model)
Model Name - contains string "3255"

It supports temperature ranging from -40 degree Celsius to 105 deg Celsius.
We have customers' machines running at -20 deg Celsius. They require that t=
he correct temperature be passed to their tools.

-----Original Message-----
From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
Sent: Thursday, June 8, 2023 8:52 AM
To: Kannan, Baski <Baski.Kannan@amd.com>
Cc: Moger, Babu <Babu.Moger@amd.com>; clemens@ladisch.de; jdelvare@suse.com=
; linux-hwmon@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (k10temp) Report negative temperatures

Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.


On Tue, May 23, 2023 at 02:46:46PM -0700, Guenter Roeck wrote:
> On Tue, May 23, 2023 at 03:49:32PM -0500, Baskaran Kannan wrote:
> > Currently, the tctl and die temperatures are rounded off to zero if
> > they are less than 0. There are industrial processors which work
> > below zero.
>
> This was introduced with commit aef17ca12719 ("hwmon: (k10temp) Only
> apply temperature offset if result is positive"). This patch would
> effecively revert that change. Given the reason for introducing it I
> am not convinced that it is a good idea to unconditionally revert it.
>

Any comments ? I am not inclined to accept this patch as-is. What are the i=
ndustrial processors ? Is there a means to detect them ?

Guenter

> Guenter
>
> >
> > To display the correct temperature remove the rounding off.
> >
> > Signed-off-by: Baskaran Kannan <Baski.Kannan@amd.com>
> > ---
> >  drivers/hwmon/k10temp.c | 4 ----
> >  1 file changed, 4 deletions(-)
> >
> > diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c index
> > 7b177b9fbb09..489ad0b1bc74 100644
> > --- a/drivers/hwmon/k10temp.c
> > +++ b/drivers/hwmon/k10temp.c
> > @@ -204,13 +204,9 @@ static int k10temp_read_temp(struct device *dev, u=
32 attr, int channel,
> >             switch (channel) {
> >             case 0:         /* Tctl */
> >                     *val =3D get_raw_temp(data);
> > -                   if (*val < 0)
> > -                           *val =3D 0;
> >                     break;
> >             case 1:         /* Tdie */
> >                     *val =3D get_raw_temp(data) - data->temp_offset;
> > -                   if (*val < 0)
> > -                           *val =3D 0;
> >                     break;
> >             case 2 ... 13:          /* Tccd{1-12} */
> >                     amd_smn_read(amd_pci_dev_to_node_id(data->pdev),
> > --
> > 2.25.1
> >
