Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561A169996E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 17:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjBPQE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 11:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjBPQEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 11:04:55 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2119.outbound.protection.outlook.com [40.107.101.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A2F8F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 08:04:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nihDnDI+pxx0eTZ9TAc2jN0OqHwGH66Xs2xDaoitcxgXw4begaxCUkoJjvFHFDWuXc1QQ250rYqCoA3gh12geOWiMxLCKT8q1/e4qa/UuTxIYcxyCc2RGRxGQLBO3g9g4CDE0j+W/vxH6u1l3uxGl/59YHd9JC60g+Hr40vf4W6zvrqoaUn9Da8e/2nDQH4/yg9LSlunNNYp+snkiZieb3PMhqTFPnF5tqKMNEN2WxktazrtDR0UKwygahZTGqVS8D39GLBK1iB5a5CjS4FemI2AiBzbxyWsB4rBcS7DD/TSfgHpwF2PEgM4ASijVRTGvuxe470FIGLjIkd+iWifPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B6P4ouvHI1pOOVYcvn8i5zY9jy86mloUqYConpo7CpQ=;
 b=kRz8LE4lKiLN9izrZLnby8VP6c36za/5fDSwZrJMV8rH/91RI7OtA6uyxHknaCgbU8KJPO2+dLt+LXER/rUHiDyytfbGairlAjqlr9At/pDqP5eYaAohkxAP9JkG4wbRCS0TKuI6KTUkrdSPvYQk3M8PULQfIENIaAr/iWeySVkIplsZ+rbTpF+orPLsTazjqRvCoAvNhbRovgEgF1kba8SK+8HySvxmZBR3cv+XmfWHA/uLZV8CHGprkUe4a68u0fQx4AIKr8stHerCxgQWPp25qWgepghHDJMh+M/Cpj8ofOt/3hHCm/lv4LNtMlQ2na9DwRPlki9qdjQIVQYhCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B6P4ouvHI1pOOVYcvn8i5zY9jy86mloUqYConpo7CpQ=;
 b=cHZkj9/PQKvVdT2yVoQf6U6+5B7ptSm2iItNgkleQ8RcK2XP7A9ZOrOvdkFpIffY11vfEaUFCPslN7xx3sJ3EzANAykbIl0lyqYk0MJFwisG8r0eGSlKIEg/uokr5Zm2McPIUtiuYSrtr5LhTPluOavKFtk4UIQ1jMlP5VwmSgY=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by CY5PR21MB3423.namprd21.prod.outlook.com (2603:10b6:930:d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.6; Thu, 16 Feb
 2023 16:04:50 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::629a:b75a:482e:2d4a]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::629a:b75a:482e:2d4a%7]) with mapi id 15.20.6134.006; Thu, 16 Feb 2023
 16:04:50 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Borislav Petkov <bp@alien8.de>, Juergen Gross <jgross@suse.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "lists@nerdbynature.de" <lists@nerdbynature.de>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: RE: [PATCH v2 2/8] x86/mtrr: support setting MTRR state for software
 defined MTRRs
Thread-Topic: [PATCH v2 2/8] x86/mtrr: support setting MTRR state for software
 defined MTRRs
Thread-Index: AQHZPFdKu6v3b+HaGE2yB6PHNlodO67MxwgAgASTdACAAB+TAIAADw8AgAACzgCAADpOgA==
Date:   Thu, 16 Feb 2023 16:04:50 +0000
Message-ID: <BYAPR21MB168807498B89953E54CDAE3ED7A09@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230209072220.6836-1-jgross@suse.com>
 <20230209072220.6836-3-jgross@suse.com> <Y+ohfE/wICFKO/93@zn.tnic>
 <cc6c58a8-b162-a6eb-37d4-40786f532837@suse.com> <Y+4SqDN2Hssau4fq@zn.tnic>
 <e5138aad-175e-d9bb-93f2-2fc563e09a41@suse.com> <Y+4hpAdn+JQEBqoG@zn.tnic>
In-Reply-To: <Y+4hpAdn+JQEBqoG@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f7118f86-4779-4cab-a3a7-462b80caa282;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-02-16T15:58:05Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|CY5PR21MB3423:EE_
x-ms-office365-filtering-correlation-id: ec17ab4c-8e65-4015-ae56-08db103788cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LKO09+ED63OSQE62EBRg9c0/BwDepCCeJ4EIVchoI8/rnW9osydfDJ8HgOIh0bUZTGdvxc9PFrDsU1xgNc6GJ4nZ/XW5NHAS0Z5voqAzoR9NkTJi7zqO3oXlWQQ7smUvyX82FUoxn5uRnwX/A5fNx8ROMv2MEI3Vgg8F7Mg+kbAf0Aq9UuAn6Ir6nGhOsq0IsbrgGJDuDyvz/sUNrnFFEuFUPeebRViKVrBjm8Zn0neJyCssLIuXLZb6d0g459mm21PgMhkCEy1zyHpEHBJwIWYf5HFqMCM39r+1i9S5biOE8bRj8l+2kJet/s4cVT034k5lDtlAud1WfypwAK2+VugS+tOYZf3SOaTQinHKD8EbmilnUAYHg3GFsUoFyfOaMYs3zOGvtnCvGqY2xqckohaPpaqhcfVqgQHD6rCTK6tHTe3OKEnK9PUkw45APTKrifXbOTr6iSBxY51LpAbmklIu6wlKUGdhoimQif7bZMlH7BOon1tlyLMNI+N0yJnjEKqe62ga1fOk8BZvpczrE/hGCFo5hxbztSu7/LQ2Vjlh+WtXZWEw2w+BS/QTDhWAMEX9zJ7lc2dDKWriYmwXZQo+KtoNlXi/JF4VPa1pFQwY74qcCZn4x44s4kT+G2ZUtQ9z2dQUtVdzFSHQLKwCFahGIuiUHCnglesC4JCZZ7wJmTLjxkWJj1DbQtqAm1c37BJXm6TTjNazSFNr3qWzk5pb2jwwXgJASaGHQvEy5Oc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(376002)(136003)(396003)(39860400002)(451199018)(4744005)(82960400001)(38100700002)(82950400001)(122000001)(55016003)(86362001)(38070700005)(33656002)(10290500003)(7416002)(71200400001)(2906002)(7696005)(66946007)(66476007)(66556008)(54906003)(8676002)(76116006)(52536014)(8936002)(110136005)(41300700001)(316002)(5660300002)(66446008)(64756008)(4326008)(478600001)(6506007)(8990500004)(186003)(966005)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Y6t6TXh42bKFSNrbgQySNlEPgFIPjHFKIkAnyHoFBp++KRFu2g9XQ+Qu8lzg?=
 =?us-ascii?Q?/AGsEsTa09mglJ/k1cwmP5zRFpiHGs2jv5FMgBv698IcKrb+Ed6p3o/qeUjK?=
 =?us-ascii?Q?ye0IEcMgG5v9rRXo1LtMJCHFvMFnlz/jcrMk2PE3FpvI4ugsrxbWaFQ+wi/u?=
 =?us-ascii?Q?7vC+xSB6IH4itDdjKkDbFmEUiSCiofwVLhjpTtlfTQxgFobWXats+OUi5vhL?=
 =?us-ascii?Q?vuw3K4hRC6aij14JANKVbzqvis1p+nR7BAmVCgwLrHLsrPniHzNWVgHDA5Qb?=
 =?us-ascii?Q?hMH7GOpfqlEFXIqFDFurbCpabwm9ixSRoO3oTykWa/OyoI/twYqZ4xoODWXK?=
 =?us-ascii?Q?hlQsg3ZH9ZbwGcJrirs1B+67DKTtZH/DS12Pho9m0q+UxVM/GOVtzrwfYS7n?=
 =?us-ascii?Q?wwc02keUrRqA/nwnoxE80I3Tj9fUZ2YagzYSHhDZA7UdRvNN5XJsMvC9uyk4?=
 =?us-ascii?Q?G3ARdDR0Ix/5j923dOObRTVUBL+u94RJ4shsMVKNDtxBKFVfFwW6OPgsOImd?=
 =?us-ascii?Q?fxJ30aVKA7Y3Xk71cMnzAVJr9JAsASEF/r3x0PypHJs8teY07DlKTWd9lUM5?=
 =?us-ascii?Q?x5GaGZr9Wbtth9YK45j9+8dX3g0noFGnSG1Bz7Odr/U4IdNXE+VrhuvbWKUS?=
 =?us-ascii?Q?LIZPaipQmUPIKHFn3tOxeTLI8OSOHWC2kv82aH/q9zEQPU/jlKFWpozm09eI?=
 =?us-ascii?Q?4ZmGOk9SaTgvFX4S66NZwS+AYkBt0pSW5BHtNbGpYK4L25oVZqbzo56U0TCI?=
 =?us-ascii?Q?B4pDmxul16XymjSq91+918H3+0ZU4ZmHM/cuvltwyijGSSE6OhSWrhmuXaYe?=
 =?us-ascii?Q?Qi1UlXMUCQxCapR9/WpTif9BDYDW2TK8a3tyYxpBQi10DblaCIIhzJ+mLk8N?=
 =?us-ascii?Q?4SvLJpYIXMXIUEsOX5QH8uIUKelbRtjaZEn/V3DVYlC57TMNlwzU1oTrH24m?=
 =?us-ascii?Q?iJX6yLXj3GW0oEqlGnMkxHe9wBMDzQxNNTWikHJg999JxQdnrTaKlwDJVwbx?=
 =?us-ascii?Q?l+pGWE/sw59VmtcDKmjy4+hsPW6naXPnoxr5+Z8yAGGJfvht76feiZKsLLcV?=
 =?us-ascii?Q?2X9wiTkp27/ZhzC282hv06RBaLaheJr+fE+aXYg/sXnvwMB0yz9iijZhq6IL?=
 =?us-ascii?Q?W9vLgXRjj0DrWKvWvVOaYsDOGgPHaotSuqUjYg7FO5KxCXqOy8BgutTTySRo?=
 =?us-ascii?Q?lUOh2O4AQ3mJmO64Pjx/fIwp3aUj3wXFMLWaIFGI9KTQAlRF88avlDhEeM9O?=
 =?us-ascii?Q?aKJXMS5TUMEwRcJHWM3IqlenHQ+BiQMeLULG7Gwm/DJ/ihyAebKR7CcDesTN?=
 =?us-ascii?Q?TUL80Ax/XL11qVAMHhfVhw1huA208SHV8njcQiZFfQF5oKqaIwXEu58dB7gm?=
 =?us-ascii?Q?h6OPp7HDihMxCc8aStr66OJRfAhAWTHFyQTuq+r/jcSe2HNK+oypPbf/dXot?=
 =?us-ascii?Q?+lfUCxXgEIyU6i6/kSd22+3O93HleUax3oTtq7NUzYMVJhBzKnFjAQWLOpUk?=
 =?us-ascii?Q?+WwK8CkquwlMjtd1ySYWMzUBv7sLA94il7qC9O9tkPqbnyLTuN0cOTP5vxyJ?=
 =?us-ascii?Q?A0A0zhI5ZswhCn6wIppRuBZpY6tXqoR3/uVL1LAqjUaqRIgvc+dK9Li13Ehx?=
 =?us-ascii?Q?B5L8AVS7YdwaS9Jwr1fGjwAbkN8ucOw+4pnbLtUc6qO4F9SwjHAk6rN5epKg?=
 =?us-ascii?Q?ZSQ/Xw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec17ab4c-8e65-4015-ae56-08db103788cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2023 16:04:50.7261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1EXfUY8MfiT9t/lt8lLmSzLGdwOsl/ZTfAqMd6wAS4V2SuBfMW2siIB2KrY2vk2aN4Eud/RFM04reW7epiL6/fcFg4RfJWisMxzzMHANHuI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR21MB3423
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@alien8.de> Sent: Thursday, February 16, 2023 4:29=
 AM
>
> On Thu, Feb 16, 2023 at 01:19:22PM +0100, Juergen Gross wrote:
> > Hmm, I must be blind. I can't spot it.
> >
> > I'm seeing only the feature bit #define and a call of
> > setup_clear_cpu_cap(X86_FEATURE_SEV_SNP) in this patch.
> >
> > Or is it done by hardware or the hypervisor?
>=20
> Correction - I meant CC_ATTR_GUEST_SEV_SNP not the CPUID feature flag.
>=20

In current upstream code, Hyper-V vTOM VMs aren't participating in
the CC_ATTR_* scheme at all, so CC_ATTR_GUEST_SEV_SNP won't be
set.   Getting Hyper-V vTOM VMs integrated into that scheme is a key
part of my big patch set[1] that we're separately trying to resolve the
last issues with.

Michael

[1] https://lore.kernel.org/linux-hyperv/1673559753-94403-1-git-send-email-=
mikelley@microsoft.com/
