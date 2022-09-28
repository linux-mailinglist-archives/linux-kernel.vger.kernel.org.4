Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917645EDCB9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 14:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbiI1Mbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 08:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233863AbiI1Mbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 08:31:43 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8D3925A2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 05:31:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J42eSAV57Yn4AeYCrY7JiH0UoLpsRjb3jSDcy8rG+vPZgvZe+0XpAIN5jhYRQcBfI3PGEMOBxdKYYfWe17ipP6N9B5eqFO9PV0htxDLofY1ZfgOSkQjRGBqtISudHwVsz3Lhw+fC410H2fmoUJOkDN5K8giqNUKCriS+IlJxizwHQBBwpRgMZp77/jfO9nuWrimq3LTAuA4XG7LlacbO2RUZHelr4MIGaUudl+90/7X3LG3wn0t40e2iMXbGmQ6TUyHKAvp40+fXUtFrwzESfXjNCI8Itzs8G/mX+aZUueQNOWfkkysVuro/b1URio8OkL0lnApBAkYt9jBHzvsYug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ahKhTt05aFYc16aquRgzpVTcUpcyA88nKM7Cg0GZaUk=;
 b=hJATKdDPcFkykN/ln3F5DfAxi+ThNgGj0dQPQH4BnqcsCOpn5KLfSSqRl4jfwiTmAf97pg+QB1bDwCYmZQXjcQrgeAwpJno+pzN31dZd9kp7r2NJrcGkrhK/vPh/JHWCBXPvlzqbfpCUiamX9YOsgZebILo8cQYG+gpgVeEAX2elW1pHB35nHGkVy2H7eRe7X/puQnhHyvt3XFUgjS+lkx8FQbBf6qxPgodZK58cmTzQT0TvENlYvDKXPYPw3MDHMlzebylI5Yoa5gs0Dc200hWss9jtRRk8BUlfvmEKSLrXVObbGLTRXKrolc3eQ7wjHZBYi874bEytB16wXvaqvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ahKhTt05aFYc16aquRgzpVTcUpcyA88nKM7Cg0GZaUk=;
 b=BTJamVvbQdoR3prgiBWBt+dat/f9qEaY45l2nl4LwVcqs0CKS7ovlmX5G6dMl0R7OAaTzMMFS1xlGod3h5CR8XoOA78+33mykV76SGphB2RPwutEXz0CPugQvhe+Ubvh9zMew9ReXOigNhT/Q4U5yTYo9XpCTS6rvIgt0BfPhHw=
Received: from DM4PR12MB5133.namprd12.prod.outlook.com (2603:10b6:5:390::6) by
 BL1PR12MB5351.namprd12.prod.outlook.com (2603:10b6:208:317::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 12:31:37 +0000
Received: from DM4PR12MB5133.namprd12.prod.outlook.com
 ([fe80::d28d:d3db:4361:746d]) by DM4PR12MB5133.namprd12.prod.outlook.com
 ([fe80::d28d:d3db:4361:746d%3]) with mapi id 15.20.5676.017; Wed, 28 Sep 2022
 12:31:37 +0000
From:   "Shih, Jude" <Jude.Shih@amd.com>
To:     kernel test robot <lkp@intel.com>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>,
        "Wang, Yu (Charlie)" <Yu.Wang4@amd.com>,
        "Wang, Chao-kai (Stylon)" <Stylon.Wang@amd.com>,
        "Weng, Steven" <steven.weng@amd.com>
Subject: RE: [linux-stable-rc:linux-5.15.y 8185/9999]
 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:633: warning:
 expecting prototype for dmub_aux_setconfig_reply_callback(). Prototype was
 for dmub_aux_setconfig_callback() instead
Thread-Topic: [linux-stable-rc:linux-5.15.y 8185/9999]
 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:633: warning:
 expecting prototype for dmub_aux_setconfig_reply_callback(). Prototype was
 for dmub_aux_setconfig_callback() instead
Thread-Index: AQHY0YxX+l1m7RqNNEurdJCMnwVC9q30yOxg
Date:   Wed, 28 Sep 2022 12:31:37 +0000
Message-ID: <DM4PR12MB513391D6FA8408E6DD504B66F7549@DM4PR12MB5133.namprd12.prod.outlook.com>
References: <202209261725.GD2V8vRO-lkp@intel.com>
In-Reply-To: <202209261725.GD2V8vRO-lkp@intel.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=1830bf01-b201-464d-9038-7f9f5d2e60a9;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-28T12:29:53Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5133:EE_|BL1PR12MB5351:EE_
x-ms-office365-filtering-correlation-id: 1be5eea8-9923-4264-1480-08daa14d6331
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b57G6qm7Hrr+9/H63g9FR/eCaxYrx8lFhHCukGizkPYFp5fsJksiprN75SK7bv728skkEU7hnEr0PJ/WNN7ou2Z0u6oQUzt68dYabSRhJuI46VtcJGKuhH/xBm7CfNnuWmFdqtEUx6IjboWdzL2GkQTUoGQnJLgiGNw9Ofa/DLH9IU38vk8ObsMITcf67PGTGSYyRnfxXJpfVJbvh9Dx5K3UUpUwhMZO+xW4D7RkoYQa/MvbkkCihUjcvzMaIZN7iwU1SDXRoGAEg8vcDMfr11X1OGx2tlIQG9gpct/UWgjZqdpUwdmRXvlAIrMmvHOXJT/vP9zACtq5gLKgY/BatJDDZ4PBvqK+hdwJzvuF+jGFRs4P7StL/d/ENp0O2EZPstUAIoneFeqQmGVigMbjLaxbfpgKjTYOvGHNHsAqY8iDOZdXDCii2aopJhP+zXZCgv2ZgbG1tPZXHpc34Yzi+Wjmf5HUlhzKoMg7HjWca29Z/gRHpiwLLUyFEoki9ZAnq8Bj9tFEFAWjwPwCh6YIWApVsARiFjROPrwVCG+cOelWI5YdeuLsBtTE4VCUHpObOzml3JNHg79+zYObJDtKcoGKYYkcbfFu1P2npXgzchgugDdzJSJLGNaww21zX+TaV+VDkFctyds6Z0oCr9wopQFRW8RJ14Pk78KOlPFm/x/iETBq3QslgQT1mnrdYZaBHlcnBKqAEShuwmt79+/PzzPCFn58Jd+dFSH4ei6y1wWizysEOKCz6+DeuceLFIA83iCCXmF8+/2EMKdzILy2TwNlxH8HSesfDDmwaDGcgB6T6SpYQbo/w/7chR9BgEL8JTmWFPU16PtlXyRzvgvqOgsBVjslpIjT2+l7TrKQW/8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5133.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(451199015)(478600001)(71200400001)(966005)(53546011)(7696005)(6506007)(186003)(316002)(33656002)(6916009)(122000001)(2906002)(38100700002)(26005)(38070700005)(52536014)(54906003)(41300700001)(83380400001)(9686003)(45080400002)(66946007)(55016003)(8676002)(4326008)(8936002)(5660300002)(66556008)(66476007)(64756008)(86362001)(76116006)(66446008)(219693005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Jy4Zr+0UkttjcTbohvlnC5jQw6lemGD6jFRhmRtNhRjikpf54XKiBGXvRwnU?=
 =?us-ascii?Q?5d6Wm3SiGVH+BA6rYzaAGshRQJrUMbgdRhIPzPb8L4MSwCS6fInktxPIvW40?=
 =?us-ascii?Q?68k3a5K72fYDSWDIYzv/C+1qFj/W82jTH33I0EJfsc8iQuTcSjh3duojMVu+?=
 =?us-ascii?Q?uO+xDfizSdcVrQwRdx49XckQmVFawcambC8R0uAGiA5EHci23FzFksBOKP3v?=
 =?us-ascii?Q?aC+TEiQ8e3vh9ZpbsbaeT2yawFKiY/qSeR4TwbiqJYmKBjXrPMdADi/xpvWC?=
 =?us-ascii?Q?lr0KvDELnsXyvL+xRWotFS47E7Eu6gdUXMy1V7TgBDwS8hs6rMCZx8J522HX?=
 =?us-ascii?Q?HURQFzLyr64d5XwYq4iKadA4BZNyWPi2Yeoxp4EMHHPTyR4mPJ921/6rL0Ik?=
 =?us-ascii?Q?v/ayuMmRnwNElEn0W9BBq3RmTGoJHPrZgY/9OjAtYSWDXN1Ex+7DjMM2kAVI?=
 =?us-ascii?Q?DYe71jOxKxlhb9eaImlAySgGoBNk+tlJV7vPQnE9RQaeuSghVoi6m9PtPyPW?=
 =?us-ascii?Q?/k5LV52Y7B5MU4mU0ZePHBnIRvD8vzWhK4ViwAFbd9oGfjPqeEiiQ5vpyu8t?=
 =?us-ascii?Q?qEdHAGEvDhZiGzzrxPfjJJQl42O8GK+pM937BNBWR7mD/MLMdcjTLMi/hppb?=
 =?us-ascii?Q?UIApCOitCgYh5Rqm3HNuJzIEXNkYyX69L7QR7Joz1rMlrNpiAQGt8pyW1ZB7?=
 =?us-ascii?Q?H9IOEMQG9wtQ/sidnbXVECL9lTw8B364zJzrTeIVDGkFC0bq9jVCLeHCqN+t?=
 =?us-ascii?Q?LXb9x+8NX2W1ZT03JT/5z3w4CyQiSusAW4IccSwPeJTrfmE7Gc4DwC3DX9Jb?=
 =?us-ascii?Q?N0F2aKb92FamKudja2ts3J1reDXtRTeAXa5IxVvJQc3wsIOzL2hW8a6OjReH?=
 =?us-ascii?Q?yiJx8NWH9A9iCzPS/IzNGUXb9BJZWL3QNQ/HRODAs+oeA1v72xg+5QabQSNs?=
 =?us-ascii?Q?KRMQRwQBQSOFYyfrLxyBx8mDdxEx3WweUywFvEcKOAVhKFIJXGoXT3UyHedS?=
 =?us-ascii?Q?XVzAdxSKQaVKE1PAALZcZmX/NokeUUd73FrImk3eCxwt+BlUAY1m2lP0LPGN?=
 =?us-ascii?Q?mTNjwWw8ugVAVOny3W72/m7tvn5jUKwtosTrCXZ7KSzE/TSjRowIbOTEd6zI?=
 =?us-ascii?Q?2tzAXMNuMh3sTZ/iclRR1WmKn4WQ8laNOMb20UDbnU27+FScMuoNdrdUaCgQ?=
 =?us-ascii?Q?KOQ/MdyRnns6I/qZH3F91leWQxNc54CDQVDDBZqHT3A2IkqndtTJ3o0DjLOj?=
 =?us-ascii?Q?1yIvWClmFWmBn1y2nTqylMp9LDcMDnsfRQVJu0xaYQDGSuv7DaGPGn/Pb7Kg?=
 =?us-ascii?Q?PG/966dd8J5AGpU6qb7NA7e4bPNGhiU/hA/vZQp5sILwevmdQlI1z/K2osPe?=
 =?us-ascii?Q?kOI8Oo6hvB9kOtyGdlZ8xWvbImTS5BzAAQEzh4TqqINF0yhJAvN3CgnO8lhl?=
 =?us-ascii?Q?CDwl7G/YDBVb3bbW9IzZd0kThjHKoLnnmiw2mqpd5VstuWJ0BRjqtEpnfo7W?=
 =?us-ascii?Q?YqwffAnc9nPVQf9vP+eMzZDE1CTjiAoLg6+KUrq+m5o++Rjt5+UuakixBBUO?=
 =?us-ascii?Q?LAUD9zDOjROL2RVkIpg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1be5eea8-9923-4264-1480-08daa14d6331
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 12:31:37.4748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E+TYdnxjAROpnCUFFrjVZhzBEssnymfv6zN45LQrE9MTgW1OzaG/o9RjnHWj24UiQUlFvHhT4Z2FyfDDJ8mF7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5351
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - General]

Loop in more

-----Original Message-----
From: kernel test robot <lkp@intel.com>
Sent: Monday, September 26, 2022 5:42 PM
To: Shih, Jude <Jude.Shih@amd.com>
Cc: kbuild-all@lists.01.org; linux-kernel@vger.kernel.org; Greg Kroah-Hartm=
an <gregkh@linuxfoundation.org>; Kazlauskas, Nicholas <Nicholas.Kazlauskas@=
amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Sasha Levin <sash=
al@kernel.org>
Subject: [linux-stable-rc:linux-5.15.y 8185/9999] drivers/gpu/drm/amd/amdgp=
u/../display/amdgpu_dm/amdgpu_dm.c:633: warning: expecting prototype for dm=
ub_aux_setconfig_reply_callback(). Prototype was for dmub_aux_setconfig_cal=
lback() instead

Hi Jude,

FYI, the error/warning still remains.

tree:   https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fstable%2Flinux-stable-=
rc.git&amp;data=3D05%7C01%7CJude.Shih%40amd.com%7C7bd918cc9e924e619a7d08da9=
fa37821%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637997821699897778%7CU=
nknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLC=
JXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DXI%2BUuXksogcekVYVwP0186gMuUEApfZz=
AYsShHqQ6os%3D&amp;reserved=3D0 linux-5.15.y
head:   3e98e33d345e981800e03dd29f6f6343286d30b6
commit: 734d5ce02cb069cccedc993d8f1dc0ea41cfa3dd [8185/9999] drm/amd/displa=
y: Support for DMUB HPD interrupt handling
config: s390-allyesconfig
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce (this is a W=3D1 build):
        wget https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A=
%2F%2Fraw.githubusercontent.com%2Fintel%2Flkp-tests%2Fmaster%2Fsbin%2Fmake.=
cross&amp;data=3D05%7C01%7CJude.Shih%40amd.com%7C7bd918cc9e924e619a7d08da9f=
a37821%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637997821699897778%7CUn=
known%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJ=
XVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DUKOausOyi3bnIaEDtnlFFsv9qZSlJGFtvaK=
3CB2BbCw%3D&amp;reserved=3D0 -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F=
%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fstable%2Flinux-stabl=
e-rc.git%2Fcommit%2F%3Fid%3D734d5ce02cb069cccedc993d8f1dc0ea41cfa3dd&amp;da=
ta=3D05%7C01%7CJude.Shih%40amd.com%7C7bd918cc9e924e619a7d08da9fa37821%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637997821699897778%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C3000%7C%7C%7C&amp;sdata=3D1lN4exJsKSN9O5cto4%2Bm%2FgRriYAy3gRJRo4JXICc1rQ=
%3D&amp;reserved=3D0
        git remote add linux-stable-rc https://nam11.safelinks.protection.o=
utlook.com/?url=3Dhttps%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel=
%2Fgit%2Fstable%2Flinux-stable-rc.git&amp;data=3D05%7C01%7CJude.Shih%40amd.=
com%7C7bd918cc9e924e619a7d08da9fa37821%7C3dd8961fe4884e608e11a82d994e183d%7=
C0%7C0%7C637997821699897778%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJ=
QIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DXI%=
2BUuXksogcekVYVwP0186gMuUEApfZzAYsShHqQ6os%3D&amp;reserved=3D0
        git fetch --no-tags linux-stable-rc linux-5.15.y
        git checkout 734d5ce02cb069cccedc993d8f1dc0ea41cfa3dd
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0 make.cross=
 W=3D1 O=3Dbuild_dir ARCH=3Ds390 SHELL=3D/bin/bash drivers/gpu/drm/amd/amdg=
pu/ drivers/gpu/drm/amd/display/amdgpu_dm/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:633: warning=
: expecting prototype for dmub_aux_setconfig_reply_callback(). Prototype wa=
s for dmub_aux_setconfig_callback() instead


vim +633 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c

   622
   623  /**
   624   * dmub_aux_setconfig_reply_callback - Callback for AUX or SET_CONF=
IG command.
   625   * @adev: amdgpu_device pointer
   626   * @notify: dmub notification structure
   627   *
   628   * Dmub AUX or SET_CONFIG command completion processing callback
   629   * Copies dmub notification to DM which is to be read by AUX comman=
d.
   630   * issuing thread and also signals the event to wake up the thread.
   631   */
   632  void dmub_aux_setconfig_callback(struct amdgpu_device *adev, struct=
 dmub_notification *notify)
 > 633  {
   634          if (adev->dm.dmub_notify)
   635                  memcpy(adev->dm.dmub_notify, notify, sizeof(struct =
dmub_notification));
   636          if (notify->type =3D=3D DMUB_NOTIFICATION_AUX_REPLY)
   637                  complete(&adev->dm.dmub_aux_transfer_done);
   638  }
   639

--
0-DAY CI Kernel Test Service
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F01.org%=
2Flkp&amp;data=3D05%7C01%7CJude.Shih%40amd.com%7C7bd918cc9e924e619a7d08da9f=
a37821%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637997821699897778%7CUn=
known%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJ=
XVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3D8bhvvlSKfp%2BgckqTBRojdHdPulLM8bB2T=
FuQ14Ha%2FVo%3D&amp;reserved=3D0
