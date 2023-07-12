Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B483775097C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 15:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbjGLNVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 09:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbjGLNVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 09:21:18 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9159A1736
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 06:21:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SzV2DdQl2Hq2PHa8toVXElr+Cv3wAGrPGg4NGKkufv16kLjjCtTTRyVIn6H454lIsoe4lYMUgSzvC7YEYa/zYjbcvBpwgq5s5LPKkzNsoYQrDyWXd1BHFz0qbXu+PtTTKqJiZ0fmjXUKk4hDyIEpa6zkMl4tCzGaTsqD59XbCRe82cJjsFmlOWKfkmkH+m7vba06jY43ob1FE0vjfnHxOStc5stYEKtnbj3U/2DiKUMqaEtSyGc9X7lVxBkkz9E55hvI9gDdZVC+w2HIL5zjs5FqbY3Hox8/Ava+khCQVjt/99/NVMI51zLVjORT73sC0t/PuEnm3e2vZSouRm4g7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ix1M5tk8k2GWn3CQmSPUL69hBnj2XB3PEtcEZOhS4xY=;
 b=bcsjlfh62ILNOfXyqN7ktoO1h3T4OXOv2E5hPGNTSo5Owmy7Zy2vDlXlcfWqdPSLpD6g+LhFfT8IEbGpV+JC9yynIRdlUVhG1NJ0lIzif4GswHHXA3WN6eP7A4E0C22Rr9TlrTxF7IUBopBKB6NJLnhQlzfnHaSrgCn+JO+sYaV2IR5S5Bmln/r6wuxp8xqTMdRbhlHpOy9salHrMW1em7vdPUK0tUA6/U2kCCtQtF837MMZ9f5QwbEko4ByD+H14eWySpfasd8zRF0OC6MClzfog8nE+cE0yoJTSFvk0JHDVdBqChWxKcayT/eXvJB6+t/Xi+STVz8yga0SLwwJVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ix1M5tk8k2GWn3CQmSPUL69hBnj2XB3PEtcEZOhS4xY=;
 b=ZFBaLzk448e+k8+LoVd2pVvhxk10P7TRrFFCWvy/KhbTOGnCQVxeAGCE1tQD0ni+QjsyF/rwS9DqdhJsXsgPYUORF4J1ew93Hps2WN/FyxMxVqYg5HL9jGD9l2ICs7iMEdt/Nw087q14Kg/Nk9rmc2C/d2frVScEJ8qnE+ujaNM=
Received: from DM4PR12MB7765.namprd12.prod.outlook.com (2603:10b6:8:102::7) by
 SA3PR12MB8048.namprd12.prod.outlook.com (2603:10b6:806:31e::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.20; Wed, 12 Jul 2023 13:21:13 +0000
Received: from DM4PR12MB7765.namprd12.prod.outlook.com
 ([fe80::8d98:f5c2:35b:e9ff]) by DM4PR12MB7765.namprd12.prod.outlook.com
 ([fe80::8d98:f5c2:35b:e9ff%6]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 13:21:13 +0000
From:   "Gangurde, Abhijit" <abhijit.gangurde@amd.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Gupta, Nipun" <Nipun.Gupta@amd.com>,
        "Agarwal, Nikhil" <nikhil.agarwal@amd.com>,
        "Gupta, Puneet (DCG-ENG)" <puneet.gupta@amd.com>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "Jansen Van Vuuren, Pieter" <pieter.jansen-van-vuuren@amd.com>
Subject: RE: [PATCH 1/4] cdx: add support for bus enable and disable
Thread-Topic: [PATCH 1/4] cdx: add support for bus enable and disable
Thread-Index: AQHZs/D3H2s+OZsVwU+ypM9eNkCN2a+0l4SAgAF8fgA=
Date:   Wed, 12 Jul 2023 13:21:13 +0000
Message-ID: <DM4PR12MB7765F182AAF927F780DEE8848F36A@DM4PR12MB7765.namprd12.prod.outlook.com>
References: <20230711121027.936487-1-abhijit.gangurde@amd.com>
 <20230711121027.936487-2-abhijit.gangurde@amd.com>
 <2023071109-saturate-purist-d854@gregkh>
In-Reply-To: <2023071109-saturate-purist-d854@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=87024cf1-345d-4a9a-9bb3-9b3734de87b7;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-07-12T12:39:48Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB7765:EE_|SA3PR12MB8048:EE_
x-ms-office365-filtering-correlation-id: 67ec8f9a-0f7f-435a-bcba-08db82daddb6
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kDq9GKvQOWToV16+9z1stffPU1yRqlTx7+3A/oHxJ58IlnvFjgxgWIIK8pbm5PbWrdLcuenZOPasg8JLBXA1/o8dSESh+DyOJL9LFS5hLM02gLwQQN7HdUTdI897tt/sTfpVN1sAQ3e82KNgm228zd2kho5fb+KHy74IWf1ne3gR4vbqwHo2se54hM6s9Xv1LSrzNvWw0xiGK3xr/dzhY+Y0a+72x3gBjCh2PpQEgiFPxc+zVxRqa1sYI2PvL+UxZHcABDobCIBhXi6zW37ozwjhxQTW+PDXi1jYpjEK9ri3MinoFXROARnGSHKDPuHjLLR8p5fQ48LVSoK0tPLWNMfRvF0hi9lLndbqPWBii1IAdUZtEaHe8HDJpAblMgeTv8N126c+W5/aTy9hoI4mbDjSGiUzz3nmUKxAcDXUBZ1D2pt3PIiKLvtT0TdT3sp/wlucCUi4mrrXYJhZ9cCkL/5Bsp37VtxZYabvcfrq051T+9g2uoKeCgZnMKo8xD2aohuvVur/7YgizWiQqtz7mgW1FeZfzwXTmalgKHtOSbiJOFwdCq//HeIYlpK+7Mzl4tCMjq30fp3X1TZF5I6i5EGe8z+Da7jXch89WCxWxUmMkidCTexcs2r+eJ5cQzgu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7765.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(451199021)(41300700001)(8936002)(8676002)(5660300002)(6506007)(9686003)(52536014)(38070700005)(316002)(6916009)(66556008)(66476007)(66446008)(66946007)(64756008)(76116006)(4326008)(2906002)(38100700002)(83380400001)(33656002)(54906003)(55016003)(7696005)(122000001)(186003)(478600001)(71200400001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2wiIq03+R6anhvW8N5uHw3CbrQED1Z6IHQQFLkY0/FQjehcnGxu37PkuDReq?=
 =?us-ascii?Q?tOWD1d7AWeJPsK5px76ziYrE/xZuVAAx3A6bma8l7E3jweyWt+/QmqGpkZYj?=
 =?us-ascii?Q?MfVwhlrjtbbIS7Xw0ZkcJMl6oEfnnAkp/i/MPEQ95gzMtP9PyvI1hRm/TL/m?=
 =?us-ascii?Q?VCPe3+9EYVrLDQWT3K3gPfp6vxtDKAdIw9wXXTZYfbl404qUVrQBZSloGvBC?=
 =?us-ascii?Q?nA6Y2xv7LkWYsBOubbdjfVNoBIzW1vVb3cITug2bEQiCg3Hvgsk5o38q/pJz?=
 =?us-ascii?Q?oVg6MObolJ1DA35buDL1sCKCFLezsJq/eUPu8/i715Zv4rp98+q51SwtL6NA?=
 =?us-ascii?Q?7tmDho0nSO/Oe71szo0CaRMA5y/fQB1Zk4/gPnwXAZkc49QHtloW4/q+Rnfv?=
 =?us-ascii?Q?2TbVL/HNOlRV6MRkpoM36G2Nknlhh4l7FTOJg98AaE1tF7T0UpwAKlj7hG+6?=
 =?us-ascii?Q?GpSk8pFvc7JvaRXGPBWLoy0o4W9bqRrEMgKRtO66rG6dt4lVRnBaDflcZYGe?=
 =?us-ascii?Q?StQNaiP2rfi5yUIyGwq1e59DdXTzfU0tWHw3a9bLc6j/8r0jxdX9Dd+AlV9A?=
 =?us-ascii?Q?sml6egmsgd3W2J48z/aBVV7yzTMeY9WX1g/yIqF9sarwIlhZ0AEEWSrFm077?=
 =?us-ascii?Q?loo+do/iDOVyPDOzCsRs3yF1UCj7nJ6J6dmbvmwpNnivB2Mp8WgvYzVRchDY?=
 =?us-ascii?Q?qhPOVW4dh9OMQ5Ks7cfv8UhjY6wnX1AijUwW1zMs03i8IKNHaWDUxrKpZRFL?=
 =?us-ascii?Q?lQj4TyEuduEfvQKNo8+uNIBejDSlv7r8DryHRlogYAbkhOhjoZV28SaQbVDB?=
 =?us-ascii?Q?RjLdyGUVnz/0HKBvuzMwnI8EbKP5SF6pQdCVHwe+BtqE6tlYSYzLX0yoEhE+?=
 =?us-ascii?Q?bqzWCojgdswh0y8J5z+l+f9aUMdu7ixlrl7KH668dertucf//fRs4ujwsJ/F?=
 =?us-ascii?Q?nRBrdeqNQSIU2sLpuARmQ4VFRDwhFYxQQUFKPTaDcmVtqlfX0qgo1q2AP0rY?=
 =?us-ascii?Q?UcZ3j0ewCO6QaFjqeK9nfzHDYOc5VXPEaFN0IkGQwIFZ7uBXd5GVIOSxJxLL?=
 =?us-ascii?Q?PdE7ycdtpk0EvHMt/qB1d9IFOR59JV8hdtpneVo+TGVMfyhfOUHusCu5oWNN?=
 =?us-ascii?Q?KwTdMcOufJNzRWOtnYTkdohG665bKtXjFAP9FmAa2O9A60dmuo/ZvObl1xr+?=
 =?us-ascii?Q?xpfkU4SfFsBHJLQIqPWfRyNp4hLznFfncQ8yg8w2SBH/eYJ1SqeeiMx6YqoV?=
 =?us-ascii?Q?k/tWNP2i/YpFs+U9kcaxMOckRJyGQGuAIrC+od8d76ddtgI/39dNBQv/Hnpe?=
 =?us-ascii?Q?ch+Sheck6Z18GZu4/AwGE/usgAYLW9D9FMGHphLbRFqG5Xbb8cj6OYVrONLl?=
 =?us-ascii?Q?1gy/GT1C0L57mAQwOOSL2GEd0h3IaQOs8gpCeMDO3cJABOlwqEBMSLI+U7rB?=
 =?us-ascii?Q?86KK8Jz8RambxKkv9iPgrVlVI02Xux00v541j7MgyE/0kSelwLcJVJE66l4k?=
 =?us-ascii?Q?3KC9B3meqldxuwCp0JuHno49V9BertNzDHM13EUbRVH16olePe+g8X0lF6oe?=
 =?us-ascii?Q?5ho4PHGg8OWkg5VXUPCtm9VQnpKaX1Vv+el614jzSw30EYg7nUJzNdpM+qnI?=
 =?us-ascii?Q?FAqV9Yy6dwE3fiZrHLH61kE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7765.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67ec8f9a-0f7f-435a-bcba-08db82daddb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2023 13:21:13.6914
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7FYVY2T2VXVu5IRckTmKEc9Ttc8HYQOwy0rdz0UOU9575szN30nEN7Rov05VLB0iaz+MbVSO8Ym3ad4LkjxWOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8048
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

> > CDX bus needs to be disabled before updating/writing devices
> > in the FPGA. Once the devices are written, the bus shall be
> > enabled. This change provides sysfs entry to enable/disable the
> > CDX bus.
> >
> > Co-developed-by: Nipun Gupta <nipun.gupta@amd.com>
> > Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
> > Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
> > Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-
> vuuren@amd.com>
> > Tested-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-cdx | 11 +++++
> >  drivers/cdx/cdx.c                       | 26 ++++++++++++
> >  drivers/cdx/controller/cdx_controller.c | 27 +++++++++++++
> >  drivers/cdx/controller/mc_cdx_pcol.h    | 54
> +++++++++++++++++++++++++
> >  drivers/cdx/controller/mcdi_functions.c | 24 +++++++++++
> >  drivers/cdx/controller/mcdi_functions.h | 16 ++++++++
> >  include/linux/cdx/cdx_bus.h             |  6 +++
> >  7 files changed, 164 insertions(+)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-cdx
> b/Documentation/ABI/testing/sysfs-bus-cdx
> > index 7af477f49998..0afa85b3c63b 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-cdx
> > +++ b/Documentation/ABI/testing/sysfs-bus-cdx
> > @@ -11,6 +11,17 @@ Description:
> >
> >               # echo 1 > /sys/bus/cdx/rescan
> >
> > +What:              /sys/bus/cdx/enable
> > +Date:              July 2023
> > +Contact:   nipun.gupta@amd.com
> > +Description:
> > +           Writing y/1/on to this file enables the CDX bus and
> > +           writing n/0/off disables the bus.
> > +
> > +           For example to disable CDX bus::
> > +
> > +             # echo 0 > /sys/bus/cdx/enable
>
> What could go wrong!  :)
>
> You don't say why disabling / enabling the bus is needed, this feels
> like a very huge stick, why is this for all busses, and not just an
> individual CDX bus?
>

As said in the description of the patch, disabling/enabling is needed when =
FPGA is being reprogrammed.
We would enhance this interface for handling multiple buses in v2.

> > +
> >  What:              /sys/bus/cdx/devices/.../vendor
> >  Date:              March 2023
> >  Contact:   nipun.gupta@amd.com
> > diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
> > index d2cad4c670a0..48c493a43491 100644
> > --- a/drivers/cdx/cdx.c
> > +++ b/drivers/cdx/cdx.c
> > @@ -380,6 +380,30 @@ static struct attribute *cdx_dev_attrs[] =3D {
> >  };
> >  ATTRIBUTE_GROUPS(cdx_dev);
> >
> > +static ssize_t enable_store(const struct bus_type *bus,
> > +                       const char *buf, size_t count)
> > +{
> > +   struct cdx_controller *cdx;
> > +   unsigned long index;
> > +   bool enable;
> > +   int ret;
> > +
> > +   if (kstrtobool(buf, &enable) < 0)
> > +           return -EINVAL;
> > +
> > +   xa_for_each(&cdx_controllers, index, cdx) {
> > +           if (cdx->enabled =3D=3D enable)
> > +                   continue;
> > +
> > +           ret =3D cdx->ops->enable(cdx, enable);
> > +           if (ret)
> > +                   dev_err(cdx->dev, "cdx bus enable/disable failed\n"=
);
>
> You can say if this was enabled or disabled to help figure things out.
>

Will correct in v2.

> > +   }
>
> No locking needed at all?  What happens if controllers are added or
> removed?

As of now we had only the controller but you are correct. We would add a lo=
ck to protect the controller list.

>
> > +
> > +   return count;
> > +}
> > +static BUS_ATTR_WO(enable);
> > +
> >  static ssize_t rescan_store(const struct bus_type *bus,
> >                         const char *buf, size_t count)
> >  {
> > @@ -410,6 +434,7 @@ static ssize_t rescan_store(const struct bus_type
> *bus,
> >  static BUS_ATTR_WO(rescan);
> >
> >  static struct attribute *cdx_bus_attrs[] =3D {
> > +   &bus_attr_enable.attr,
> >     &bus_attr_rescan.attr,
> >     NULL,
> >  };
> > @@ -541,6 +566,7 @@ void cdx_unregister_controller(struct cdx_controlle=
r
> *cdx)
> >     if (cdx->id >=3D MAX_CDX_CONTROLLERS)
> >             return;
> >
> > +   cdx->ops->enable(cdx, false);
> >     device_for_each_child(cdx->dev, NULL, cdx_unregister_device);
> >     xa_erase(&cdx_controllers, cdx->id);
> >  }
> > diff --git a/drivers/cdx/controller/cdx_controller.c
> b/drivers/cdx/controller/cdx_controller.c
> > index dc52f95f8978..ac8081f23cbe 100644
> > --- a/drivers/cdx/controller/cdx_controller.c
> > +++ b/drivers/cdx/controller/cdx_controller.c
> > @@ -45,6 +45,21 @@ void cdx_rpmsg_pre_remove(struct cdx_controller
> *cdx)
> >     cdx_mcdi_wait_for_quiescence(cdx->priv, MCDI_RPC_TIMEOUT);
> >  }
> >
> > +static int cdx_bus_enable(struct cdx_controller *cdx, bool enable)
>
> Why not just a disable and enable callback instead of being forced to
> always rembmer that "foo_enable(foo, false)" really is "foo_disable(foo)"=
?
>
> This is messy, please be explicit.

Will update in v2.

Thanks,
Abhijit
