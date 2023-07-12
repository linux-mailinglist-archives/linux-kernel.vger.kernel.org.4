Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E991750985
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 15:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233251AbjGLNXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 09:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbjGLNWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 09:22:45 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0B91BD1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 06:22:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wrwl16wuggIrqom+Xoe+BetN9x8vEJ5Yqg35VnmBiHOOZFCT5vTK8ysXEvAvjnsR6SPXkK8hBy22cCaTrydEXH+wIoDzmZjGHijTkjBUHptmJ89E54XkBDK8nRIjh8NM9nouZHDsTWncj4dUiNTfKJ3OS/wSGTjy5lmWPpCDGeODF8ZTF1BqZsbvj7haJci3ajuQfnmWGbIkM0/v9FCAYBIXeqrTOPls0gUdEpAv7X0DsSJDqKj0v7T0H2BmVegzCnMbUvHQ2J+GG4dhxan+wM37UHWcUE52PU6mgv84zzJXFerxHVWVKNXkYcg4L5M45P+EreyiJsIxL/vGTHlAXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EPQ6NcBWL1rQz/cpxl99LJZ3X8nSpqvTOFw1IMDaRzY=;
 b=XN2M6+R1vK8D4veDWsv/1p91tO6vEbjvx4/NwFniTkxpYjvaZ1ukiB5nTorWrQv5Dc/ifSHD3AEIeJm7hjHXcBJ93Mt3QYu/7olW49MRVgs7Vgh25/5sJWH4uHo/OcyZkhtgjhc/4szT8zJ41/A32K0GM22sjAYcTLKIQtrjzOMX24S+OivMD4W8LTLP5OfxQhTezWc2/+LxWrUtskLpl+HmzLLx+t4DD/XfhGEdtyXg6rmCaULgpvSJL/4pAt6Y6ENo7gOX/0MD0ACY4pJzwzLcnl/gQhmISiUK4UDGSI9n7sr561ya3eBicZzYn5foRiKzQss67in5Rt31rg10Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPQ6NcBWL1rQz/cpxl99LJZ3X8nSpqvTOFw1IMDaRzY=;
 b=iCmh4+34RvGkB+q8N2nVQDyWTEsQ79++c34esrelou5fTlVfC3pR7QysHPQF+z3pLAxJ6fnFSewYr3C/QjkYiJBYSTBPKfJ/2eYcorj1rlUpyASFJxXnDdfyY9LnuDsQhM9t2AkdkSdrgQNJ86xKuvTdmr+GD0vEQq1+aWmMMcI=
Received: from DM4PR12MB7765.namprd12.prod.outlook.com (2603:10b6:8:102::7) by
 PH0PR12MB8175.namprd12.prod.outlook.com (2603:10b6:510:291::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.31; Wed, 12 Jul 2023 13:22:40 +0000
Received: from DM4PR12MB7765.namprd12.prod.outlook.com
 ([fe80::8d98:f5c2:35b:e9ff]) by DM4PR12MB7765.namprd12.prod.outlook.com
 ([fe80::8d98:f5c2:35b:e9ff%6]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 13:22:40 +0000
From:   "Gangurde, Abhijit" <abhijit.gangurde@amd.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Gupta, Nipun" <Nipun.Gupta@amd.com>,
        "Agarwal, Nikhil" <nikhil.agarwal@amd.com>,
        "Gupta, Puneet (DCG-ENG)" <puneet.gupta@amd.com>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "Jansen Van Vuuren, Pieter" <pieter.jansen-van-vuuren@amd.com>
Subject: RE: [PATCH 2/4] cdx: add sysfs for reset_all
Thread-Topic: [PATCH 2/4] cdx: add sysfs for reset_all
Thread-Index: AQHZs/EUUy9Euq5qGkqDKEw5nDOPv6+0l/SAgAF9vjA=
Date:   Wed, 12 Jul 2023 13:22:39 +0000
Message-ID: <DM4PR12MB77654A9127AAFE17BAC021A58F36A@DM4PR12MB7765.namprd12.prod.outlook.com>
References: <20230711121027.936487-1-abhijit.gangurde@amd.com>
 <20230711121027.936487-3-abhijit.gangurde@amd.com>
 <2023071111-unreached-probation-45c5@gregkh>
In-Reply-To: <2023071111-unreached-probation-45c5@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=0a6ee296-dedd-40cd-9138-d5eb6ecdf1c9;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-07-12T12:45:51Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB7765:EE_|PH0PR12MB8175:EE_
x-ms-office365-filtering-correlation-id: a5b8d241-3da5-47fb-1d5e-08db82db1123
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9KNETHW3/a8TbIEepqelJpbI4UUM507kxJnOm5jjcjvi5l1ACa1DjSAuZDjjsHoP8Tdgx2Wdrl+F/ak7u2i+B3KiE5Fq+DpBMNEFB6lrBCkoiC65KoLSZACjHk9S7ZBmHipS15OkcxHDEvcvtNrkcXyScGxbNW3E3ptfoL3FE16MlAL9Bql7809f7YNJx9VBf9r/agyEp3WD1ZwbJ0ntKNAZHL9bnu3XB2YAArvEUKhZ65q4xQQ/nH6Ouat9PJYBidD4TeBcrOxqv+kll1AjkTo+gX9lofqGBg9T54tC+4CWXk2+ZAFCK3r5Oggdn/T4D8DjG3kqTEnA5Ijh4wh8g7Zh1xKiQgzohzB5kbrWGXlZ4Q4RjqMmZP1kMh0YyQVTD3gvvmgZ1ZPEHN70LcerqF98tHdKBSy2Bbea3H07ekiJs1P3dyo+ruvrFOL5PYuIeHa0hAHpC4NkMikgUyqnnmY27BHaXKyquzPectVP3j65T7o4NtZUXZCLwhteuhoqCrxE4k4CUotj+AT05h87G3J3GVnte1TY4M9YN90ZewbkgghVV26+Ud8QUgHMKqXc4s9j4sJ910jA98MgvokEgFHYh8Yo5ypirDryXv7yvzG5Fhs5cQUv/I3WVe+78vM3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7765.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(366004)(39860400002)(136003)(346002)(451199021)(6506007)(54906003)(122000001)(38100700002)(2906002)(9686003)(186003)(86362001)(5660300002)(64756008)(6916009)(66446008)(4326008)(66476007)(66556008)(66946007)(76116006)(38070700005)(478600001)(55016003)(33656002)(316002)(8676002)(52536014)(8936002)(83380400001)(7696005)(41300700001)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3+QOkqx0IY6vBCrXzpkIXWPWArF/Hy88hsEgsT0cBZ4gJ00ACERPrNNJUeA8?=
 =?us-ascii?Q?6JWxmVHtolRm/2QzdQ9uSb5uTo+rRXYt0WfAiJCs8aEGoUdvw4QNiPl/EqD6?=
 =?us-ascii?Q?Elz3dcoRKeLhfQ85oiFf4jISxYuFIU0A/fQusmBnCFwNv9qehNzmhs16FBcr?=
 =?us-ascii?Q?7rpCQEKG1ZxwDrXc6VkEDGViNDEH2VhWTtFplRUBdzxVKMn1y80bbD2EJNmV?=
 =?us-ascii?Q?qizcRGfQreQnhO745WBeLXjygE6BqLVcJ+dDfUWzD52KdZVFRdE9IgSDxNIO?=
 =?us-ascii?Q?s4b/VNJS9+CvzBSyMa1QcdaRrEe/TShwkhhAKnO0PAbzyqj5LVut/zlwLf9A?=
 =?us-ascii?Q?LKv8Iuvl2dWlY+oNOop0BiGiVHOQGlfpKaTJszXYtTy6GYxuvdgYA6n9yn8Y?=
 =?us-ascii?Q?I4kVtp3GNKQPE8lswjjjsAK9Ch/8amQFoTbNd15tTK9LmMFqAqlEIdGyz4XV?=
 =?us-ascii?Q?tTbt5O2nekdz8cVrlufAhkPzM6amKTHR6HR8G6OW+RPvMSoqaL+62DRkWSFY?=
 =?us-ascii?Q?ueY28zMvlAP4CZFeyFLyTCbsO/gD4P0iqQ/1daZPrgAtQanVT6La8vaOo55k?=
 =?us-ascii?Q?x/Z3XWvRTmKNFwgo+sG10SSXGte3nwd9UYuPw3UhIAvT0ncO8o3J5KM5Yinc?=
 =?us-ascii?Q?GrAo1cl6VOLlC1aOZs+1c+BtBfx6sJPArO5NvQ+vQfSaoZKmUAR4ZYyOjrQe?=
 =?us-ascii?Q?W3NEU0Vt3bZjflhHb35pjhhp0Y87D9ee5SQH294EQF8dkSKAQh4JYwVqCsno?=
 =?us-ascii?Q?qR7+Sp/MGY6HKdD0rAXgsnUh2rWUQjQYP/fB6E++xkBk73G2/Hsiiw6JGeZS?=
 =?us-ascii?Q?djtUrpxyxDFpVHONUiRCSblN6xau7F3mY/RYaQBvDCuc3f7bMIhC7APoHz6y?=
 =?us-ascii?Q?I4kOuELW48IcBTXQl55MyimNDWfvZEf/VUKsMezSkapc350AmlWmR1gstb39?=
 =?us-ascii?Q?eli5vgznxw//a8cZ846L4s5T0EUVlbrT6SKSnCxtQBL5g2eVoIKlkErSDHfr?=
 =?us-ascii?Q?aLhvuo6kTXsOujuqDNnW/k0Jmrth4Y9PY7Yp9gLfQuo1sIOCw49Q2rATMGH+?=
 =?us-ascii?Q?gYb8zZA5HcSO/Qbxd7Js36XH52ot/y8ospZ1Bd2DskCQgfgOnbC5d2uohGsd?=
 =?us-ascii?Q?qOtL8GX5ff1yekyRJez6EIx087n+0tp6ulkSaL+jxIsgdzJ6mMCjkdFkLXGF?=
 =?us-ascii?Q?UxztQfAzhJgCc9GJ/YxT5Rb5WN7TnAmWWNt4a+B47VmXN+MyLqPjjmKwQqlb?=
 =?us-ascii?Q?MiIm8xUX8o0oi+7BwvvthFVZSiIep/TRb1eaiZGAT+5P+iSLceSwAlFPrfRs?=
 =?us-ascii?Q?2j+IsRJ1vfHJO8QCqXpZ4s85gUYOrveVopwIIY/jP2vSCB4+TRSDAajd8qxY?=
 =?us-ascii?Q?XSZfOKwgBb7iJsk+aXtcapJ8jqww984uBOjo4Ss8uVOoCmnRg9QI5sfOeuOz?=
 =?us-ascii?Q?rYibmz88rSMDhjGYg/1Q8hvrjcCSiOIMyeOeh3rD6WEQ3inhFBgiy9gVDbPu?=
 =?us-ascii?Q?l1wroPyTmUmyZx21fy5Kp6JD3qEq5K5Yom+GhuqZ98FGyT3iVp428Eo1Et7J?=
 =?us-ascii?Q?5Fg0trjacKjpQM9IRI542FORgwFKwDNWeBCzcL3cDJycA7PcNPyr3TIJJ2Zq?=
 =?us-ascii?Q?n07iQsXU6ntebnFzs95uqK8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7765.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5b8d241-3da5-47fb-1d5e-08db82db1123
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2023 13:22:39.9718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4xLvis3AIxVMdRysZcP1b78pS7zdkrmN+xLH7Fzn/4e3xLhoqEpTUsq970RvI6sY05JcmFRUKCLQKdkWiofPBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8175
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - General]

> > Add sysfs for reset_all entry which resets all the
> > devices on the CDX bus.
>
> On all CDX busses, right?  Why all?  Why not per-bus?
>

This was on similar line to bus enable/disable. Would extend this to suppor=
t per bus in v2.

>
> >
> > Co-developed-by: Puneet Gupta <puneet.gupta@amd.com>
> > Signed-off-by: Puneet Gupta <puneet.gupta@amd.com>
> > Co-developed-by: Nipun Gupta <nipun.gupta@amd.com>
> > Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
> > Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
> > Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-
> vuuren@amd.com>
> > Tested-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-cdx | 11 ++++++++++
> >  drivers/cdx/cdx.c                       | 29 +++++++++++++++++++++++++
> >  2 files changed, 40 insertions(+)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-cdx
> b/Documentation/ABI/testing/sysfs-bus-cdx
> > index 0afa85b3c63b..d9e00058471d 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-cdx
> > +++ b/Documentation/ABI/testing/sysfs-bus-cdx
> > @@ -22,6 +22,17 @@ Description:
> >
> >               # echo 0 > /sys/bus/cdx/enable
> >
> > +What:              /sys/bus/cdx/reset_all
> > +Date:              July 2023
> > +Contact:   puneet.gupta@amd.com
> > +Description:
> > +           Writing y/1/on to this file resets all the devices
> > +           present on the CDX bus
> > +
> > +           For example::
> > +
> > +             # echo 1 > /sys/bus/cdx/reset_all
>
> What does resetting a device mean will happen?

It would be same of pcie flr to the device. Would add more description in v=
2.

>
> > +
> >  What:              /sys/bus/cdx/devices/.../vendor
> >  Date:              March 2023
> >  Contact:   nipun.gupta@amd.com
> > diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
> > index 48c493a43491..4d20047b55bb 100644
> > --- a/drivers/cdx/cdx.c
> > +++ b/drivers/cdx/cdx.c
> > @@ -106,6 +106,11 @@ int cdx_dev_reset(struct device *dev)
> >  }
> >  EXPORT_SYMBOL_GPL(cdx_dev_reset);
> >
> > +static int reset_cdx_device(struct device *dev, void *data)
> > +{
> > +   return cdx_dev_reset(dev);
> > +}
> > +
> >  /**
> >   * cdx_unregister_device - Unregister a CDX device
> >   * @dev: CDX device
> > @@ -433,9 +438,33 @@ static ssize_t rescan_store(const struct bus_type
> *bus,
> >  }
> >  static BUS_ATTR_WO(rescan);
> >
> > +static ssize_t reset_all_store(const struct bus_type *bus,
> > +                          const char *buf, size_t count)
> > +{
> > +   bool val;
> > +   int ret;
> > +
> > +   if (kstrtobool(buf, &val) < 0)
> > +           return -EINVAL;
> > +
> > +   if (!val)
> > +           return -EINVAL;
> > +
> > +   /* Reset all the devices attached to cdx bus */
> > +   ret =3D bus_for_each_dev(bus, NULL, NULL, reset_cdx_device);
>
> No locking needed?

Would protect this with  a lock.

>
> > +   if (ret) {
> > +           pr_err("error in CDX bus reset\n");
>
> What error?  For what device?  Put the error message in the reset
> callback, not here, as you have no idea what device failed.

Would correct in v2.

Thanks,
Abhijit
