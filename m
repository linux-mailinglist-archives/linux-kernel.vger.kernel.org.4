Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20846F79E3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 02:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjEEAEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 20:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjEEAET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 20:04:19 -0400
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020021.outbound.protection.outlook.com [52.101.56.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E349EA5D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 17:04:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OvSawUybx8W7SvksB1xlv+YKU96YFCKwRXAfNxI2cCX4l4cEOlrIZpgBW0QdePTVX+WqkXSSsSBop/iv+rwGOiEmD/K5isKW6W11xCs/5n2/3OjVUzUDGvS3k3OEWhKvQXiSkfU4x2VQlTlBDo1BTOv0w78DRMTVs86wfPuU9+lWOBGwuuhFdZaNOvfnd6ccD3c+t1K0ILjxIIfgJVE3STUnF3NgBBwWz6Wz1E9kkTQ2VzlyjgrzbGQThcKwqRI+B2kjYe9MI+TdgZdhrc03qYgDpEK9fF+N4WzYFyII23HQJ+FfPmjJPCzmH4MJp2i6pYBzSksVtLPekukBPmMwWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L4lq7OFCiulGh+0EHCrU8eEl+Df2tvkxJD2RFubtmsc=;
 b=Mrn2BkSqStdj78FrI0iEIY3XldrF5lg+QJJLMxY3292Q8b9Xn9zhA+kOzjllCIvASNKhSvEAW9+2E5sANtCC5TrASfh9yUdlPHSD5yOpsMBD6FiPQTTq913HOh+tKRn4V6MSZF5ONqg/BlFfh4wfL3QnLjKwfSKNRIcUaaU7mVs4G2KZHWT7Y84BCmIP1vtOJ5zIR92QPx9biD//sCkAO4KOSonEhmgmza/+aVXjjTyiETDdeSaOPrqyK66goOVIBwJ9z3l/fgqSvKzWxzRH+FDn4UTJqc2PjoDKYmZ65CwOnbTo6bmD73e91rcUo6BHeEmkOUnMmsBc973ycgBIEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L4lq7OFCiulGh+0EHCrU8eEl+Df2tvkxJD2RFubtmsc=;
 b=czvZVy6AUNw5jW6/0RQakF3fazHRJ7sxOc1VzjKimKR9LVOTTiW9hQ5c+KLeuaoJ3DDFoWLS6jEO/BwiDzG5y7vt9Ao5B6SEnBGbdjJqV9BZSo6i8pAICLGmlz5yzGALYs4rhTkuP4uETTGYDi2VV49naogMfniTfrCAMwjHpJs=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by DM4PR21MB3731.namprd21.prod.outlook.com (2603:10b6:8:a0::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.9; Fri, 5 May 2023 00:04:12 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::9a0f:a04d:69bd:e622]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::9a0f:a04d:69bd:e622%4]) with mapi id 15.20.6387.011; Fri, 5 May 2023
 00:04:11 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Ben Greear <greearb@candelatech.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: Hang loading initrd since last Friday.
Thread-Topic: Hang loading initrd since last Friday.
Thread-Index: AQHZfTr2qR4xve2R+0yhSMLHlSGWLq9H1EyAgAAlpYCAAT9/AIABJi8AgAAJFvCAAGIGgIAAAvTg
Date:   Fri, 5 May 2023 00:04:11 +0000
Message-ID: <BYAPR21MB1688E60DA4D61852125549BDD7729@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <9d87defc-5376-d690-b483-bc314e4f568b@candelatech.com>
 <ZFHHh/m0pkOYIzo7@debian.me>
 <ebb280e4-d381-0bf8-d134-0318c5cfdf83@leemhuis.info>
 <f12a8f23-5aac-b615-300c-38001b9583c2@candelatech.com>
 <a227583c-ef41-e954-fd4c-0cdb23c77222@candelatech.com>
 <BYAPR21MB168889708435D073352C4A46D76D9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <745e1e38-85ed-76dc-9cbb-2c3d71d70d97@candelatech.com>
In-Reply-To: <745e1e38-85ed-76dc-9cbb-2c3d71d70d97@candelatech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d8372d20-9424-4fc2-be0d-9b74472d7f2c;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-05-04T23:56:41Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|DM4PR21MB3731:EE_
x-ms-office365-filtering-correlation-id: f730df15-3c9c-4f4a-4346-08db4cfc4117
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xL73j6ltNXfUhqnBC1e2SQSRpJcT7dubYDkG7slzuCTcwd64uOzlJ2pnxBT24mYvhF02OfCQb1kUoW57PNC39+72S86PyZg58s1LKoFgm7EmlBL9avw21DS5JqTAT3wvaupmQzIczM/na4RCcOzyRPkTnPY1Wl1qnL8mo5xy1J+5YavkE3hVDRxpT88RjubWo5OlwSjbNA/R1fKx1dNiHSZtLqFqFf/S8ntX5TjhMGFlpVQNCEjaNIw4BxOyQEmqWNAm2SgWIPLwNGQNilT1aYdvrcdckw194W0DzOV8wguw3hpIUIqyG1kixJP4PR+UrSqKNMOQ3Dul3xrlXQETW7qBaJKVkcWxq8GSyTdxtqsgw+TRdhffhDVw+Wwt2nIPSfKsuCZvfLLYWEIrT4w1OpHngND/iUIdkTZsVejvg+nfMwcr2WhHQn0nPLLXkwBAqAy6Zc45hcjPJaWaTE1GtiHUfaeJ6Peh+6GD0BOZKK1qPICuBQM+fIl/LxzxGD73q+oI0KR4w3UgD9Vo4hzuyqT8fn0d21oPWj3J016Wn3cU6sY8dgqJY07Wvy767m+1P8zF461VAUIbXHzGmG9wLeivSVdgNtEBTXbEGgu/lFkuMQI89c30bx2wgvx4grFTCKh1AUKQGEJUKZhOzWBogzY/qx2mQ38F++g9t0dwqKU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(136003)(376002)(346002)(451199021)(82960400001)(33656002)(122000001)(38100700002)(52536014)(2906002)(55016003)(86362001)(8676002)(38070700005)(8936002)(316002)(786003)(41300700001)(66476007)(66946007)(66556008)(5660300002)(66446008)(64756008)(82950400001)(83380400001)(76116006)(26005)(8990500004)(186003)(9686003)(53546011)(7696005)(6506007)(110136005)(10290500003)(478600001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fO+fPA99eR1aMUF0LKLh/7Q5zEwAR9nHv2Ri3qLW6PzmAQqxBpxRVW7+dG?=
 =?iso-8859-1?Q?c0I9321kc+PELTsjnRbgWPM7/1E1/adMHY9wW/CH+MeAvb5bmKcI849wKS?=
 =?iso-8859-1?Q?3UxHeA2uG7k4wRDystr7dzSEfjIINjyzK/urWtKEak8epfca2N2Cym1kMe?=
 =?iso-8859-1?Q?RVhsW6W/LyYdEoBQBJdikEoZEU03kpkfpqx36h7WD9YvTpHukavxiYq4q8?=
 =?iso-8859-1?Q?jeBJr7gVSJ66dPpS2/T5EsJoWohV3tydGfCtkdkE4YGoZDqTLQimzN9cTj?=
 =?iso-8859-1?Q?MHi1NBlUa/Y9dkZHKnIuJMFgBM3bca7NUtVrv9OZFosIF/Hg67+o1bALZG?=
 =?iso-8859-1?Q?XVoYQJZeTquZWecckg679lVuEnDT2WfQkkMVee5cHjR6BpdX/A3Y/ZgkVK?=
 =?iso-8859-1?Q?5LWgym0AZX9uxenhc71jVw0WuonTm/xVUARql7rzDfVxjWx3grNfZMhMnK?=
 =?iso-8859-1?Q?74/JPHstOotgGmCguaJR3ZG5moWAUZHZL9nSXVk2tjucXqhp1MDDxRM835?=
 =?iso-8859-1?Q?9/MMholN1bhemMUIAF2mHg838G4NuQRvHFx7qDlZZnrXcKRTz0UrGr8hk5?=
 =?iso-8859-1?Q?lxoWdqpx+tCRWXcOEPK+0LR6m4PO9qGXaExL9SGnMbrA0SdOVGHwWnxurU?=
 =?iso-8859-1?Q?IZ9bJ8Iuia73bdW6YJI4mQGwEzGw+xFt7skqErPpntCySLAlE4GvQ7pTmJ?=
 =?iso-8859-1?Q?x26Nbd+46R5k9HVo8ft8GF9z3CqIECqcsc8qQ7FgJNEhNpvnOUTzqBQz9C?=
 =?iso-8859-1?Q?6xN9h/zLPcA1cj5UT8k8Nfk/yNKG+z1NJkIL6hPyFlIuU8wa6W8ajy08SW?=
 =?iso-8859-1?Q?pGRzOsnXS8t3iC/4hKaNvjYndCG9jwRwX0KC5kGkPMdA47KTHZxWnTjKFU?=
 =?iso-8859-1?Q?arIlb0PrktGZ6vmFWvQia8tZm8oBA6hJUE5B3rLe7spaO1jKL17kEuz+fs?=
 =?iso-8859-1?Q?oW8WQBw5d8y7P8Z9TijPtij7duqs8QcYPwR9huIvX2XyomJHlE4Z0isunX?=
 =?iso-8859-1?Q?Wcn0mxFwYaud3X+cxQT8GsF8BPtWMsd+H8noa+2F2+W7jT7jHQ7qEHeHHV?=
 =?iso-8859-1?Q?cugwynnpvkso1iKUXteWkdMewUq6LZes6eI0Ndk3Yr7njvBd+elqFX0DZD?=
 =?iso-8859-1?Q?kA0PKsfdXZx/2rGeJyeMcvDJuSEpWefdf4PMDezDhBKa1uZlZ5IOD6h0tn?=
 =?iso-8859-1?Q?R60h+CESJ/HDzghbMRclSQ59EKHz55T1AfusXOuIAGkUJ3qKhVHGVVO+k7?=
 =?iso-8859-1?Q?9mfqBO6OqJ589ZEDIYsn1CElVHsEeEuvRwbfOmLKLfQeyQ/GgZKY+Vz01t?=
 =?iso-8859-1?Q?X8DxqXy49hPTdbJuk8paLxgV019+/ii0OoLQNMzmQvN53564wi5WXVknUp?=
 =?iso-8859-1?Q?4Y2YHh4Jn5OfCrDRF7SSj2RPWzXzYDg/W1Zn74f2jhzeU8J2Bo+EpjGBVM?=
 =?iso-8859-1?Q?2lm7BdN8V8uptzAA9TiTIE7RMwqyY5z9VVXXEtTtU2WpEW6zcOdYiN1Hjo?=
 =?iso-8859-1?Q?caHaY7eg6pnQoLQ8cQpSur4hWRm84nGO+t3/IWbK2s92jywqdknGuK4bqg?=
 =?iso-8859-1?Q?ocP668ZYHF/s80BKewT+Fs/psmGnhBb7VfWy8EV5o+wiUhG7Q3lLeD2o5b?=
 =?iso-8859-1?Q?0RDdC1Y5HnPP5j1jI5Lq+tjl/397bVlE8bNp3VAnNlRReU6TJVUAE5cQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f730df15-3c9c-4f4a-4346-08db4cfc4117
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2023 00:04:11.0534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ilS7WK5118Xq/yMoAN4nGrRZwdn9m13PAla0Qb7yRZVItdoiz5LeUomZspfTg09rPPc3SU8OgB2vaLy0LzbFAGfKr2CSH/pFIu4oUkSUc2c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3731
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Greear <greearb@candelatech.com> Sent: Thursday, May 4, 2023 4:46=
 PM
>=20
> On 5/4/23 10:59, Michael Kelley (LINUX) wrote:
> > From: Ben Greear <greearb@candelatech.com> Sent: Thursday, May 4, 2023 =
10:23 AM
> >>
> >> On 5/3/23 16:49, Ben Greear wrote:
> >>> On 5/2/23 21:46, Linux regression tracking (Thorsten Leemhuis) wrote:
> >>>> On 03.05.23 04:31, Bagas Sanjaya wrote:
> >>>>> On Tue, May 02, 2023 at 02:03:33PM -0700, Ben Greear wrote:
> >>>>>>
> >>>>>> Pulling today's upstream 6.3+ tree, my system now hangs loading in=
itrd.
> >>>>
> >>>> Just to understand this properly: you mean after the boot loader sai=
d it
> >>>> loaded the initramfs, not when the kernel starts using it?
> >>>
> >>> I am bisecting...it appears to be .config related.=A0 If I skip enabl=
ing things
> >>> during bisect, then I do not see the problem.=A0 But I copied my orig=
inal buggy .config
> >>> into an otherwise good kernel commit, and now it fails.=A0 I'm manual=
ly bisecting
> >>> the .config settings....
> >>
> >> I had enabled this option:  CONFIG_HYPERV_VTL_MODE
> >>
> >> And that makes it not boot.  Not sure that is expected or not, but
> >> I will simply un-select it and continue on, as I do not actually need =
that feature.
> >>
> >
> > What you observed is expected when CONFIG_HYPERV_VTL_MODE is selected,
> > which is why it defaults to N.  The comment for that option in the Kcon=
fig file says:
> >
> > 	  Select this option to build a Linux kernel to run at a VTL other tha=
n
> > 	  the normal VTL0, which currently is only VTL2.  This option
> > 	  initializes the x86 platform for VTL2, and adds the ability to boot
> > 	  secondary CPUs directly into 64-bit context as required for VTLs oth=
er
> > 	  than 0.  A kernel built with this option must run at VTL2, and will
> > 	  not run as a normal guest.
>=20
> I didn't read it close enough, but that is my fault.
>=20

No problem. :-)   Just FYI, in the future if you are come across issues
specifically related to running Linux as a guest on Hyper-V, feel free
to copy the linux-hyperv@vger.kernel.org mailing list.  That may
elicit faster help from someone with Hyper-V expertise and potentially
save you some trouble.

Michael
