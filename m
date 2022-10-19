Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E530A6051EA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 23:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiJSVYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 17:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiJSVYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 17:24:18 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2041.outbound.protection.outlook.com [40.107.100.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1688C18F0FE
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 14:24:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S9lXa3qZyXedrIENFuQBwg1twuo3UX6eSwS8Qxj4wsnv95iOuFpEhHM3TkJdLDSLkrUFzB5eX0BKtbXanHBTfrAPAeu2IV0ygFnipRhefjLJcpkE8S05ASd/tcIQSauqDFF3STBNsoqrHrpgqEFsvFBLopacIIdd210/Wek4M3cgYF6ADw3DJnBp+8zp2ydEEQL3k/zuEgDRITHMVRsp6jZogo5VLbX9SaGQKRWTMtZM2wzjWxO/CG7m2SWmzE63RlqoUPfL+EOTGQXCGoiMhNbFsaJIlD4RyLj7ToNc5H2U68C/gzVYRC1E0FE20EOOZNLHYzb2WMRg+6trk2Hrgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0glBrb6prO87dCOnA2KJzbEkZKdJ8NC/lRG2YXG4wAw=;
 b=kumpPQ0IKpCqNbR91eZBJ6P1AQaM2fZpD4Tv00i8o4rxpYwagqaJA+TNKNQ6lOsW+L1G1Oq+cKxeDgZCtvtkj6LnmI55+78Pqo/pHZwDp8p9fq7qsYYGEFkDP7HHzPOi4Jq4FtiVP1m4C5CZ++g8ApaQNhEBPcNEk5Vla8DpSJ4fDfPajL1qoDlkiAGbiG4G+XaHewqmx9JPAB3XiagdWKS88Bdp4MyAiaGKCuwT0tK6emm4zG3s6EzGdxblGyXMK3ISQ+3A0Ndmzpm/7Y251cCViLo2/63gGdfCEp9ouGV44lGX7dlVzm2FezJSkbIoFxIDL96LKq3bbpn11o3mQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0glBrb6prO87dCOnA2KJzbEkZKdJ8NC/lRG2YXG4wAw=;
 b=QGuYVkoKMNTdBAV9j9Yb3+MDtgacdE1ymtAiav1GGwhfPCFxOERUdEjm6qZF0Fpfs/svJalwYn5UCXYNC2o3axzoFxQuY4LjLLulXXeMfx/0GjD1gomNtwRsdF3UKFNKfrx3WHhZe3q+T6He5NAYaJQXs216uq28EtQAQ2/Gi+8=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by MN2PR12MB4176.namprd12.prod.outlook.com (2603:10b6:208:1d5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Wed, 19 Oct
 2022 21:24:15 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::892:bccc:675a:6187]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::892:bccc:675a:6187%5]) with mapi id 15.20.5723.034; Wed, 19 Oct 2022
 21:24:15 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: Linux 6.1-rc1 drm/amdgpu regression
Thread-Topic: Linux 6.1-rc1 drm/amdgpu regression
Thread-Index: AQHY4/VoWVkvG/AH90aR3tf7Pd65a64WKGuggAALGICAAAaJMA==
Date:   Wed, 19 Oct 2022 21:24:15 +0000
Message-ID: <BL1PR12MB5144DF4E69621E99F99F1DA3F72B9@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <efe5a0a4-775e-bc6b-27c2-aa506f5613fa@linuxfoundation.org>
 <BL1PR12MB514408C626FE2D056C293693F72B9@BL1PR12MB5144.namprd12.prod.outlook.com>
 <07c574f3-f523-a677-3597-aad4d5546869@linuxfoundation.org>
In-Reply-To: <07c574f3-f523-a677-3597-aad4d5546869@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-10-19T21:23:14Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=8c9fe253-8634-48a2-9243-c473abc9e440;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-10-19T21:24:13Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: c92ca8f1-223a-4223-9b02-5afe3837bfbf
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|MN2PR12MB4176:EE_
x-ms-office365-filtering-correlation-id: 39bda5cd-10db-458a-77a7-08dab2184614
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y40dwn9awC1NFBjcLwPkQVtedZN/wDF5ITBUVBV2YwMVUajEDM2zN8p04bnn0R379f5jSrL4W/ZC1Fb0czyJny9KAYD+0rFgsaXjyHMpQC0s+Jl8UD3DZaK2f2mxezcYbQj7YDENsIdoykBDZCv3qSqwVMH/yKDrCvHNvLC3yfCuntkp/cT61KDju0eA3FKoNYmJFPZUEP8QjuqPdJExXos3DggktitIfiOShDrNf/BESF96CFaSZd6AJ198neD16PW8ZdnpRcpkBl48nsXNUSj8opLpLo4jnyVq5IMF3a/0S/TPWJyrJTWsZXcHilN3qZ+vRlINRgzzjq3O+m0HqdUC1cuo67BXbrgPwzdYe4DLb+YPCYgQLT7R5KT6OlcB0tKkY0miJUmoTEUhDpDK7AAZAguQcHUo6wF9KrIitMzUALwUe3Zsd+vGtyMkpoKZYcGekp6Zqpi6n57wGkY9mMz5GoGAAotQNYBgYg6oVqqow8dvLjOAfMs7NdyxZvRELo5F2JfNMnIYx/kxWZYyw3dTDL3606BY5e3RzPh9jN5ZsmIIAOr61VZ6n2CdvleLo70thIsAHsgahQt3WXg1+59Dx1oSxK3oMhzDdRMVnDMcy4tpopTyd7modpFpB8OjsQBiErUmDfmT2XAAoGIAOuMq3lNovWXNPJqYzWmjYTTWBaJzyjZs6/1jiFKMPIMeRhkVqk5WgHvmlrwDe3XKUTF2RJVn69/tjH3pGKRIv/zewMsIRVIWLEnkcHXHUeWCpgAkD6KzfVQP2q7sZfj9SE+/jmiplVRF3ylc39NdDJ8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5144.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(376002)(366004)(136003)(451199015)(86362001)(33656002)(38070700005)(38100700002)(99936003)(122000001)(2906002)(55016003)(5660300002)(7696005)(6506007)(26005)(9686003)(186003)(83380400001)(53546011)(71200400001)(66556008)(64756008)(45080400002)(478600001)(41300700001)(316002)(54906003)(6916009)(76116006)(66476007)(8676002)(4326008)(66446008)(8936002)(52536014)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0sLcO6mNHMr4fAMUbJOH7p/8uFSbQvjaGamgGgdg/xVUp7EYaGe3ig9GT4NM?=
 =?us-ascii?Q?VebgmZqIoevTLZAXuiXlOVG0m2WyNQovWjxdeXQNy+aGa1/n0bM+kuSfsj49?=
 =?us-ascii?Q?NsNhRicIz8xCB012OV7VPaTzipcb7+vGrElY5sF/gGRSUp0zuiWJfFmTMb0b?=
 =?us-ascii?Q?cLhFSrOFjZRh8ILTqucKQ9MBQSQgigcKeZgQK2k99zawVZL3bR5szqLzX/ZJ?=
 =?us-ascii?Q?9quGB3Ii+lFYtu+JzlgTVQnLDOm35foJnRkgiIVr34gwytJGqEVT2LocQRjs?=
 =?us-ascii?Q?dy1ZTj6jkrCc30WdpW/7CuTg2amyvDbP0ptFnqsPtDfASUi+ctmQkSI7slay?=
 =?us-ascii?Q?CffGa6OhU4/a5BOjoKQQSlINx7Dkjmpl+bPAd4XGoEBFf+cDU2ocq2Rr2yS5?=
 =?us-ascii?Q?m/F6loqgoeV4X+cLkXIPOF0USYG93cpcMt1dsqi6acfEQO5p9HHBI1STy00e?=
 =?us-ascii?Q?pAcRXQ2boyQIwDbujME9WH76ASh7J180S1PI3WgejUF/2Kr+maNfI3bPm5nq?=
 =?us-ascii?Q?Lec9jRgarbHTMjclK8NOB0YBu6dTsWHoqvGwm7N+P098B8zYv2eyXGGx42ND?=
 =?us-ascii?Q?5kAj0nUbAPgjg11547P/rOWOwUjD3N1Ar8y4T0wfSXqochsvLMYcA3dERwF+?=
 =?us-ascii?Q?SvHHCTVTWP4fhOJG2pSsq6Iz5OC0f0OV6BOwr9Fh7qBtuJTTGyQYZbqw2jd+?=
 =?us-ascii?Q?jSEIJkwW+xQ1kEuVaGdSQoZu1cDc8gCyaKR9YzlFUS9sEUu5uusBpVY4BL7T?=
 =?us-ascii?Q?mRpEGj+PMGIbzqWb8wxwH67su6VCP3HT8Ei9iHjC0x6feIpOWhgWLd07/yG+?=
 =?us-ascii?Q?6hA3gemnTc3kJ9LgA0niL9RzRSxD3ThpNciLW1rBldD8gbETnSfvNei9pR8s?=
 =?us-ascii?Q?RfufMD3EEHGEeKb4Up7WwHA288UvB9sCutVXWmJcRaCEsCYJy0D76TEmHeW1?=
 =?us-ascii?Q?KFDUZcDwD/BQa1iDs9PbElvAhMEqTRr4Y5Y+JDh/qE+nXhbgbsTCOx+u0Bjp?=
 =?us-ascii?Q?RhMi2ntRhMpoXblzIyonN7ddn62/AONF7rWhxXS98Cd+yjj4XdLST7CHxT+C?=
 =?us-ascii?Q?Gaq5/srrVOFspDrUhlHt+0xptWJUCdaknb52oKpeOVtPtaU6IiOUJRITsGgk?=
 =?us-ascii?Q?wl9lHJehkKc3huAPmAiAMCI0S+V4lNhwjI5oiABORJ2JjRA+6tyxbg+8h6zp?=
 =?us-ascii?Q?OtVcG0+Q+6C8StoBuwamvcoCCe0u8WalmKs6oDn9zdMFDLwAcKiIyswwcTgt?=
 =?us-ascii?Q?JwR7FMrECFGGZ566e+hAMd3wawcDXpZKmQRwQRD7gQq14/arB4tKRO35ZltE?=
 =?us-ascii?Q?MaMxKqlnj52nhKIv67fdOv1pLJxyaZcNN6IoReLY4EoDC48JNP1y0PA5qVqV?=
 =?us-ascii?Q?NhSWVCRqVzvdjwipSXvCDwH16i5M7c7oup9LrJ2C89zwbV+hZTQ9/bAGcO4i?=
 =?us-ascii?Q?0gGZHUWNPZdN/Y6MXk8q/no4VoUY0/yT4fohZtAKgkmKzn2ARrjxYVqEHmsN?=
 =?us-ascii?Q?HXdSxt3bE4Ej2gj/Wv83bb2+G3NiyTnlbC/ruj/AKVe3cwcB0t+NIKNqPg/2?=
 =?us-ascii?Q?fee5nCa4Il4EDNw7X4+yNlmv55uIXKZTVhZWoJoZ?=
Content-Type: multipart/mixed;
        boundary="_002_BL1PR12MB5144DF4E69621E99F99F1DA3F72B9BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39bda5cd-10db-458a-77a7-08dab2184614
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2022 21:24:15.0425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PpoKLrZ4S+ShwcxMAjsHULgnkQGRzSx2YnBhiLELo1cYOzmbHBIXSlBWm86u+Zq2Vao78A4jnmtsYXlg85N/uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4176
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--_002_BL1PR12MB5144DF4E69621E99F99F1DA3F72B9BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

> -----Original Message-----
> From: Shuah Khan <skhan@linuxfoundation.org>
> Sent: Wednesday, October 19, 2022 5:00 PM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>; linux-
> kernel@vger.kernel.org; Shuah Khan <skhan@linuxfoundation.org>
> Subject: Re: Linux 6.1-rc1 drm/amdgpu regression
>=20
> On 10/19/22 14:27, Deucher, Alexander wrote:
> > [AMD Official Use Only - General]
> >
> >> -----Original Message-----
> >> From: Shuah Khan <skhan@linuxfoundation.org>
> >> Sent: Wednesday, October 19, 2022 4:00 PM
> >> To: Deucher, Alexander <Alexander.Deucher@amd.com>
> >> Cc: Linus Torvalds <torvalds@linux-foundation.org>; Shuah Khan
> >> <skhan@linuxfoundation.org>; linux-kernel@vger.kernel.org
> >> Subject: Linux 6.1-rc1 drm/amdgpu regression
> >>
> >> Hi Alex,
> >>
> >> I am seeing the same problem I sent reverts for on 5.10.147 on Linux
> >> 6.1-rc1 on my laptop with AMD Ryzen 7 PRO 5850U with Radeon Graphics.
> >>
> >> commit e3163bc8ffdfdb405e10530b140135b2ee487f89
> >> Author: Alex Deucher <alexander.deucher@amd.com>
> >> Date:   Fri Sep 9 11:53:27 2022 -0400
> >>
> >>       drm/amdgpu: move nbio sdma_doorbell_range() into sdma code for
> >> vega
> >>
> >> I see that the following has been reverted in Linux 6.1-rc1
> >>
> >> commit 66f99628eb24409cb8feb5061f78283c8b65f820
> >> Author: Hamza Mahfooz <hamza.mahfooz@amd.com>
> >> Date:   Tue Sep 6 15:01:49 2022 -0400
> >>
> >>       drm/amdgpu: use dirty framebuffer helper
> >>
> >> However I still see the following filling dmesg and system is unusable=
.
> >> For now I switched back to Linux 6.0 as this is my primary system.
> >>
> >> [drm] Fence fallback timer expired on ring sdma0 [drm] Fence fallback
> >> timer expired on ring gfx [drm] Fence fallback timer expired on ring
> >> sdma0 [drm] Fence fallback timer expired on ring gfx [drm] Fence
> >> fallback timer expired on ring sdma0 [drm] Fence fallback timer
> >> expired on ring sdma0 [drm] Fence fallback timer expired on ring
> >> sdma0 [drm] Fence fallback timer expired on ring gfx
> >>
> >> Please let me know if I should send revert for this for the mainline a=
s well.
> >>
> >
> > Can you file a bug report
> (https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitl
> ab.freedesktop.org%2Fdrm%2Famd%2F-
> %2Fissues&amp;data=3D05%7C01%7CAlexander.Deucher%40amd.com%7C61b
> 64b1be7294b27eb2308dab214dbe2%7C3dd8961fe4884e608e11a82d994e183d
> %7C0%7C0%7C638018099904584274%7CUnknown%7CTWFpbGZsb3d8eyJWIj
> oiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3
> 000%7C%7C%7C&amp;sdata=3DZYA0bWZAGsxB91Bqcg1YAI704LhpISQX63bE67
> UVO%2Bs%3D&amp;reserved=3D0) and attach your dmesg output?  I'd like to
> try and repro the issue if I can and provide some patches to test.  I'd l=
ike to
> avoid reverting the patch as that will break the driver for users using v=
ega
> dGPUs.
>=20
> Makes sense. I will file the bug and aattach dmesg. Since this is my prim=
ary
> system, there will be some delay in getting this info. to you and testing=
 any
> patches you provide for testing.
>=20

Actually I think I see what's wrong.  Can you try the attached patch?

Alex

--_002_BL1PR12MB5144DF4E69621E99F99F1DA3F72B9BL1PR12MB5144namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-fix-sdma-doorbell-init-ordering-on-APUs.patch"
Content-Description:
 0001-drm-amdgpu-fix-sdma-doorbell-init-ordering-on-APUs.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-fix-sdma-doorbell-init-ordering-on-APUs.patch";
	size=3328; creation-date="Wed, 19 Oct 2022 21:21:40 GMT";
	modification-date="Wed, 19 Oct 2022 21:24:14 GMT"
Content-Transfer-Encoding: base64

RnJvbSA2MmZkYTNhOGNiYzkzZDUwOTc0YmIzMjBjMGU5NWUyYjYzMDhmNGI5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IFdlZCwgMTkgT2N0IDIwMjIgMTY6NTc6NDIgLTA0MDAKU3ViamVjdDogW1BBVENI
XSBkcm0vYW1kZ3B1OiBmaXggc2RtYSBkb29yYmVsbCBpbml0IG9yZGVyaW5nIG9uIEFQVXMKCkNv
bW1pdCA4Nzk1ZTE4MmIwMmQgKCJQQ0kvcG9ydGRydjogRG9uJ3QgZGlzYWJsZSBBRVIgcmVwb3J0
aW5nIGluIGdldF9wb3J0X2RldmljZV9jYXBhYmlsaXR5KCkiKQp1bmNvdmVyZWQgYSBidWcgaW4g
YW1kZ3B1IHRoYXQgcmVxdWlyZWQgYSByZW9yZGVyaW5nIG9mIHRoZSBkcml2ZXIKaW5pdCBzZXF1
ZW5jZSB0byBhdm9pZCBhY2Nlc3NpbmcgYSBzcGVjaWFsIHJlZ2lzdGVyIG9uIHRoZSBHUFUKYmVm
b3JlIGl0IHdhcyBwcm9wZXJseSBzZXQgdXAgbGVhZGluZyB0byBhbiBQQ0kgQUVSIGVycm9yLiAg
VGhpcwpyZW9yZGVyaW5nIHVuY292ZXJlZCBhIGRpZmZlcmVudCBodyBwcm9ncmFtbWluZyBvcmRl
cmluZyBkZXBlbmRlbmN5CmluIHNvbWUgQVBVcyB3aGVyZSB0aGUgU0RNQSBkb29yYmVsbHMgbmVl
ZCB0byBiZSBwcm9ncmFtbWVkIGJlZm9yZQp0aGUgR0ZYIGRvb3JiZWxscy4gVG8gZml4IHRoaXMs
IG1vdmUgdGhlIFNETUEgZG9vcmJlbGwgcHJvZ3JhbW1pbmcKYmFjayBpbnRvIHRoZSBzb2MxNSBj
b21tb24gY29kZSwgYnV0IHVzZSB0aGUgYWN0dWFsIGRvb3JiZWxsIHJhbmdlCnZhbHVlcyBkaXJl
Y3RseSByYXRoZXIgdGhhbiB0aGUgdmFsdWVzIHN0b3JlZCBpbiB0aGUgcmluZyBzdHJ1Y3R1cmUK
c2luY2UgdGhvc2Ugd2lsbCBub3QgYmUgaW5pdGlhbGl6ZWQgYXQgdGhpcyBwb2ludC4KClRoaXMg
aXMgYSBwYXJ0aWFsIHJldmVydCwgYnV0IHdpdGggdGhlIGRvb3JiZWxsIGFzc2lnbm1lbnQKZml4
ZWQgc28gdGhlIHByb3BlciBkb29yYmVsbCBpbmRleCBpcyBzZXQgYmVmb3JlIGl0J3MgdXNlZC4K
CkZpeGVzOiBlMzE2M2JjOGZmZGZkYiAoImRybS9hbWRncHU6IG1vdmUgbmJpbyBzZG1hX2Rvb3Ji
ZWxsX3JhbmdlKCkgaW50byBzZG1hIGNvZGUgZm9yIHZlZ2EiKQpTaWduZWQtb2ZmLWJ5OiBBbGV4
IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CkNjOiBza2hhbkBsaW51eGZvdW5k
YXRpb24ub3JnCi0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NF8wLmMgfCAg
NSAtLS0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYyAgICAgfCAyMSArKysr
KysrKysrKysrKysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgNSBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1h
X3Y0XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjRfMC5jCmluZGV4IDI5
OGZhMTE3MDJlNy4uMTEyMmJkNGVhZTk4IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9zZG1hX3Y0XzAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1h
X3Y0XzAuYwpAQCAtMTQxNywxMSArMTQxNyw2IEBAIHN0YXRpYyBpbnQgc2RtYV92NF8wX3N0YXJ0
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCQlXUkVHMzJfU0RNQShpLCBtbVNETUEwX0NO
VEwsIHRlbXApOwogCiAJCWlmICghYW1kZ3B1X3NyaW92X3ZmKGFkZXYpKSB7Ci0JCQlyaW5nID0g
JmFkZXYtPnNkbWEuaW5zdGFuY2VbaV0ucmluZzsKLQkJCWFkZXYtPm5iaW8uZnVuY3MtPnNkbWFf
ZG9vcmJlbGxfcmFuZ2UoYWRldiwgaSwKLQkJCQlyaW5nLT51c2VfZG9vcmJlbGwsIHJpbmctPmRv
b3JiZWxsX2luZGV4LAotCQkJCWFkZXYtPmRvb3JiZWxsX2luZGV4LnNkbWFfZG9vcmJlbGxfcmFu
Z2UpOwotCiAJCQkvKiB1bmhhbHQgZW5naW5lICovCiAJCQl0ZW1wID0gUlJFRzMyX1NETUEoaSwg
bW1TRE1BMF9GMzJfQ05UTCk7CiAJCQl0ZW1wID0gUkVHX1NFVF9GSUVMRCh0ZW1wLCBTRE1BMF9G
MzJfQ05UTCwgSEFMVCwgMCk7CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9zb2MxNS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYwppbmRleCAxODMw
MjRkN2MxODQuLmUzYjJiNmI0ZjFhNiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvc29jMTUuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5jCkBA
IC0xMjExLDYgKzEyMTEsMjAgQEAgc3RhdGljIGludCBzb2MxNV9jb21tb25fc3dfZmluaSh2b2lk
ICpoYW5kbGUpCiAJcmV0dXJuIDA7CiB9CiAKK3N0YXRpYyB2b2lkIHNvYzE1X3NkbWFfZG9vcmJl
bGxfcmFuZ2VfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKK3sKKwlpbnQgaTsKKwor
CS8qIHNkbWEgZG9vcmJlbGwgcmFuZ2UgaXMgcHJvZ3JhbWVkIGJ5IGh5cGVydmlzb3IgKi8KKwlp
ZiAoIWFtZGdwdV9zcmlvdl92ZihhZGV2KSkgeworCQlmb3IgKGkgPSAwOyBpIDwgYWRldi0+c2Rt
YS5udW1faW5zdGFuY2VzOyBpKyspIHsKKwkJCWFkZXYtPm5iaW8uZnVuY3MtPnNkbWFfZG9vcmJl
bGxfcmFuZ2UoYWRldiwgaSwKKwkJCQl0cnVlLCBhZGV2LT5kb29yYmVsbF9pbmRleC5zZG1hX2Vu
Z2luZVtpXSA8PCAxLAorCQkJCWFkZXYtPmRvb3JiZWxsX2luZGV4LnNkbWFfZG9vcmJlbGxfcmFu
Z2UpOworCQl9CisJfQorfQorCiBzdGF0aWMgaW50IHNvYzE1X2NvbW1vbl9od19pbml0KHZvaWQg
KmhhbmRsZSkKIHsKIAlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IChzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqKWhhbmRsZTsKQEAgLTEyMzAsNiArMTI0NCwxMyBAQCBzdGF0aWMgaW50IHNvYzE1
X2NvbW1vbl9od19pbml0KHZvaWQgKmhhbmRsZSkKIAogCS8qIGVuYWJsZSB0aGUgZG9vcmJlbGwg
YXBlcnR1cmUgKi8KIAlzb2MxNV9lbmFibGVfZG9vcmJlbGxfYXBlcnR1cmUoYWRldiwgdHJ1ZSk7
CisJLyogSFcgZG9vcmJlbGwgcm91dGluZyBwb2xpY3k6IGRvb3JiZWxsIHdyaXRpbmcgbm90CisJ
ICogaW4gU0RNQS9JSC9NTS9BQ1YgcmFuZ2Ugd2lsbCBiZSByb3V0ZWQgdG8gQ1AuIFNvCisJICog
d2UgbmVlZCB0byBpbml0IFNETUEgZG9vcmJlbGwgcmFuZ2UgcHJpb3IKKwkgKiB0byBDUCBpcCBi
bG9jayBpbml0IGFuZCByaW5nIHRlc3QuICBJSCBhbHJlYWR5CisJICogaGFwcGVucyBiZWZvcmUg
Q1AuCisJICovCisJc29jMTVfc2RtYV9kb29yYmVsbF9yYW5nZV9pbml0KGFkZXYpOwogCiAJcmV0
dXJuIDA7CiB9Ci0tIAoyLjM3LjMKCg==

--_002_BL1PR12MB5144DF4E69621E99F99F1DA3F72B9BL1PR12MB5144namp_--
