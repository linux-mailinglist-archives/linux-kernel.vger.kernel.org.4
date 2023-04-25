Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 825396EE949
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 22:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236300AbjDYU4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 16:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236297AbjDYU4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 16:56:34 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33861146D3;
        Tue, 25 Apr 2023 13:56:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HEqBCbmb+sSeQqcTOvbrd9Y8dFo8L8nHvWG+raAAGMOVdOlVyMCZ4P06uPwxNF3M+sAVms5jzTdoW/WMB3CuvgKNAKuBlqFdY0Im+A3KFTEiCuW8GLOAhvAnpywFX13b3Fk2dsU4frGzVPOPFdfnguDceIM5iE5W4GwcRqjz0SsmKQJeLCXCZHDzs04xAqKjHaNpMJgf+7q7JzarZNTQalBQiu1MtREa5EduV/+XdGvAM7WyFb4nX2Mc8KAHq5j7InlooogwDOY47lQRhiGNt6IYNaoBg+NmgxbyNA0rxKzXbaVN9h5NbWQB+bkrqx+ZxoRsrDYJtCL7coYbtgHzrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FTZWYwF+v0aVhsajPhtycJAWEccoALy29yCOUeeryiI=;
 b=IzlABcknXecb9TuNiU3WN3Sy23ejR2oyYr3fMpR7EjO5p0rIvdTKrPFJVqhI52+vMuGpL4xj96+ktsxs+HbZ9K2R4ZzNU9QPxnoG3p1WmKW14hmr6SUwQE7IaXvq8HXL4LjuvogkZvGhhyfB7NOV1LrGhuFvv/q2WZF5OJTKfrV5pHBQXju6sageIiRer+AR4C1/87XtpGeg2FAZ0ZG9Oe067AEwuZTcJbXdoDHFeg7Spf3l4xGkhhT6XtZZIFFm4vUkFO7R8/mQA7YByYMHV+OJuLgbs6Pe9DSpCztl8dAz6Ly4jfJw6uprSt9B16xpkpEkQXL3VH4tkVaN9/383w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTZWYwF+v0aVhsajPhtycJAWEccoALy29yCOUeeryiI=;
 b=Rv9a5Pn7HTMygbrXnf8yccieu4rsLepULPUUchysxhIjsyTkpfav0z0htWTDvrR5H5wxRxzSQgyY4e7O/y7oj92yfPhjPtHX+gInxzmDQr86ox6M9eD2Dqq3E3lE4FbB4AFGyIT7axjROE5Z+d9QDZkLN8DxOgTm9eMG1mK08q8=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BY5PR12MB4305.namprd12.prod.outlook.com (2603:10b6:a03:213::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Tue, 25 Apr
 2023 20:56:26 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5%3]) with mapi id 15.20.6319.033; Tue, 25 Apr 2023
 20:56:26 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Jonathan Singer <jes965@nyu.edu>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
CC:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Jorge Lopez <jorge.lopez2@hp.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Rishit Bansal <rishitbansal0@gmail.com>,
        =?iso-8859-2?Q?Barnab=E1s_P=F5cze?= <pobrn@protonmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] platform/x86: hp-wmi: Add camera toggle switch to HP
 WMI
Thread-Topic: [PATCH 1/2] platform/x86: hp-wmi: Add camera toggle switch to HP
 WMI
Thread-Index: AQHZd7dtSIK+JoMqcEusuCewP91jka88gQNw
Date:   Tue, 25 Apr 2023 20:56:26 +0000
Message-ID: <MN0PR12MB6101D9688E7904FF52634520E2649@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230425204643.11582-1-jes965@nyu.edu>
In-Reply-To: <20230425204643.11582-1-jes965@nyu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-04-25T20:56:24Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=b7e11b16-8729-4c90-9633-1fcfdad699e6;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-04-25T20:56:24Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 6d46e776-a875-42e1-94b0-fca9f79e9bd8
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|BY5PR12MB4305:EE_
x-ms-office365-filtering-correlation-id: 7d696b19-9ca7-41fa-451d-08db45cf8901
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T4dVV0Yf/xIy4zWaCZ+9+6B86Fwz5juTQzIhAlfndYjv6ZXbMxoBcIcwVdJzGqDipQt3y1ZnT+4RA7XEz01lXSyI07xNch2ul8RNlz5vRsEshLU9XD2QKAiESxzOcke3WKPqni9L9f8BoWjSCfod9hdMAAUbU+1EJfA1wJvRBZ709OqIaGx1x2x9RFoxVUIZx8me+PuCOb3sCbg+rN8oohF4FeCxETBW+9TU/fOjOuf0wettp3r25ZfcJ1J2gJsGsKQNzStcSCIugi/Xh5mDucZfTUByK9xoLvZgZqsOPyj0Mw8okfwXzOsjl3jkci1hXWp9LI8AnVEC+fxQSwlPjwdJw8z3kFi1bXtDH0qWXw/gcKAL6T2wyMHt48IZTv3PB9nAhxKQtDnFHwrpLQXJ9MABUcvqSCFbnFEnRjNFoecb5EX6p2j8BBYEcxciOVhW4BnTuxkLky/DQSIIqMaprHPuFQbdCsJVLzLjtuCfR2BirKZiNjBDgigIyhFCioOEu3QRHxq3N8dE5cNflJBTrcola/bPYXm50eF6RLPwPNev43bm6VBjtYqoIhFG27iu1YVImvxowtrS/BHYbv1W8ZEgg6pJJUZjw1smTZ1nYKWcX2EIHPWujZRqH39S5wPY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(451199021)(2906002)(86362001)(26005)(186003)(6506007)(9686003)(83380400001)(66556008)(66476007)(110136005)(66946007)(478600001)(76116006)(66446008)(7696005)(64756008)(71200400001)(33656002)(54906003)(38100700002)(53546011)(55016003)(122000001)(8936002)(316002)(4326008)(5660300002)(8676002)(41300700001)(38070700005)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?sZUZieXq/ZHup8Q+PAPtxRJoT2pbsQUTclWRh4OYT7VzIN7qcDHq/V05KK?=
 =?iso-8859-2?Q?/2HcerWt9Q3sjh/pq1v6c2DhKLBRXqWpmdxUTEIbLvVxYpGnhxYiv8AZS/?=
 =?iso-8859-2?Q?UCcScU4yIBbDh4Qy3Q1hz2N0ejADqoiOoNn7d3/cs9VSGxGMFcsy++d327?=
 =?iso-8859-2?Q?foNFdADCIMiQ5R0/1kUvObBL3MCBZ0TKyv9ek26vbKjJPxPShwyQI2Ktji?=
 =?iso-8859-2?Q?quCa921mUtpTGZc0xjHhbhc9D+zFBJgLD9L0PFGQ4w2j3uKf12BbUqdImN?=
 =?iso-8859-2?Q?L5GJzmHzTzb6XRWEKTC3cdvZ7EzfPlNkgj9REoey93KS/BWlAofyC4071t?=
 =?iso-8859-2?Q?Uf8fRSB/60l4eB+0CK5ut7E1Vt909s4Zp2DcHiMcdLbKHThHkoMg+83+Yn?=
 =?iso-8859-2?Q?uQMvuAOxsKUNIzQeccLW7MMFu+nGl/avEIzTvzKNNBfm87PaXrGD8xTn5u?=
 =?iso-8859-2?Q?I4brtuHbmEHT0m4Fzz71kedWT+Cbnk4MEkFdRRAK0z66mfMvq3gMItfV0w?=
 =?iso-8859-2?Q?tsYeVbHXGivmuxkjfq7VTGenvMmPmZygMZ1fxWI4PO+aaiD2pa54RKz/YB?=
 =?iso-8859-2?Q?fAWjodIlsrxbaahFfuwho8lf/HA6s2AG+Re7fZtS08UnhmgbeqB1UjbH5g?=
 =?iso-8859-2?Q?eVQn2F3awOrsFwkj5qnB003+46YifWOyi/6PCATyZ4DMWOlaOu2wQJ6zUO?=
 =?iso-8859-2?Q?nc+NuO89Cq1WVzRPTO3vp96QRzhnVVoZzmNH3Tbr27icdaMn2PosMnibho?=
 =?iso-8859-2?Q?pCHHL/NUE71mcYhmr3i0FasKisv3AyUp8hGW0LhofLNIDmhwkkAGBuUviP?=
 =?iso-8859-2?Q?gZj1qNAdZPbid86j7ZF+0+BnQtwDI+l/7l6eMK3I01g0hp+/nQjSb11WxY?=
 =?iso-8859-2?Q?AFSRxHd16uH74naL0R1vZm9s9dYEK52Sahrb8f9VKKSel14xTiYz0mGJZI?=
 =?iso-8859-2?Q?5VkEwb8ChkpiHLL8Tu4bJNLLLt1iqYtV2XLnHL1mE8uDmjAagtZXfbQ3Bv?=
 =?iso-8859-2?Q?oIZJzyBC6WSy1kaIJ0N/KzwyBpylXwnQUnmYVlHzH49Lp+vU0boDByq5K8?=
 =?iso-8859-2?Q?7V8aQ+U4dj7clymRVTnaKmb5l72Na331zB6lmHj1CeD9u0Q17mxnYJM4CM?=
 =?iso-8859-2?Q?kSSGn3R9pchBlCSa/L13aUtGrgxdJhfOTamchrznCuJ+xZ0L9pt0xsLiJl?=
 =?iso-8859-2?Q?Rh7xdOIuntIWRIV3v9iu/k+8XORw2aO+Z3YqLn0sP/Y7QRxAj6jP36/jrL?=
 =?iso-8859-2?Q?h3DqR1v51UluokJkuTh2GuGOnHSmmlBtONarrXt3c+3pC8tzQ3kf9bvoLQ?=
 =?iso-8859-2?Q?TDhgIfWyGyNO3O4R9wfIEO/8C4ZQanraCZvsAhaCeQ1bVtlgmA+4nvgqMF?=
 =?iso-8859-2?Q?1YPAayq/0FCVWI9VtmN5jiHPaqW7ZB8jy2nXYpouFfWozhq0h7Ytir5Vo2?=
 =?iso-8859-2?Q?xEOze3ExFaGQ1k3xJ2wY4NBIY3wXcn5og0IdimCqGdRrvoQq3vp4KGlk0q?=
 =?iso-8859-2?Q?KGaKw//q0x30z7tXxaURJaiU8fZf5W7tYBwjT+5oGO/tmvyaZL9uI3rsvR?=
 =?iso-8859-2?Q?lt0TMJpKVHJL34cYOm8WoUAMt3saF/0FTj63V9+x91xOmhbosjTe//goHR?=
 =?iso-8859-2?Q?bRWYFGVQHXPik=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d696b19-9ca7-41fa-451d-08db45cf8901
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2023 20:56:26.2152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N5un/DjVoLgpb8v7XqOG6PmtFbwj1dCuIYXPeOldYBc75Myi5xjMykgvkQKLW5oEyYNh56nvfO2HwW+h67ex+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4305
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Public]



> -----Original Message-----
> From: Jonathan Singer <jes965@nyu.edu>
> Sent: Tuesday, April 25, 2023 15:47
> To: platform-driver-x86@vger.kernel.org
> Cc: Jonathan Singer <jes965@nyu.edu>; Hans de Goede
> <hdegoede@redhat.com>; Mark Gross <markgross@kernel.org>; Jorge
> Lopez <jorge.lopez2@hp.com>; Kai-Heng Feng
> <kai.heng.feng@canonical.com>; Rishit Bansal <rishitbansal0@gmail.com>;
> Limonciello, Mario <Mario.Limonciello@amd.com>; Barnab=E1s P=F5cze
> <pobrn@protonmail.com>; linux-kernel@vger.kernel.org
> Subject: [PATCH 1/2] platform/x86: hp-wmi: Add camera toggle switch to HP
> WMI
>=20
> Previously, when the camera toggle switch was hit, the hp-wmi driver
> would report an invalid event code. By adding a case for that in the
> event handling switch statement we can eliminate that error code and
> enable a framework for potential further kernel handling of that key.
> This change was tested on my HP Envy x360 15-ey0023dx laptop, but it
> would likely work for any HP laptop with a camera toggle button.
>=20

Any idea what does the key actually do on Windows?  Is it just for software
to show a message?  Or some software respond to it?

The reason I'm asking is I wonder if you want this to be emitting KEY_CAMER=
A
instead perhaps.

Then desktop environments that support it can respond to KEY_CAMERA.

> Signed-off-by: Jonathan Singer <jes965@nyu.edu>
> ---
>  drivers/platform/x86/hp/hp-wmi.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/platform/x86/hp/hp-wmi.c
> b/drivers/platform/x86/hp/hp-wmi.c
> index 873f59c3e280..b27362209b04 100644
> --- a/drivers/platform/x86/hp/hp-wmi.c
> +++ b/drivers/platform/x86/hp/hp-wmi.c
> @@ -90,6 +90,7 @@ enum hp_wmi_event_ids {
>  	HPWMI_PEAKSHIFT_PERIOD		=3D 0x0F,
>  	HPWMI_BATTERY_CHARGE_PERIOD	=3D 0x10,
>  	HPWMI_SANITIZATION_MODE		=3D 0x17,
> +	HPWMI_CAMERA_TOGGLE		=3D 0x1A,
>  	HPWMI_OMEN_KEY			=3D 0x1D,
>  	HPWMI_SMART_EXPERIENCE_APP	=3D 0x21,
>  };
> @@ -866,6 +867,8 @@ static void hp_wmi_notify(u32 value, void *context)
>  		break;
>  	case HPWMI_SANITIZATION_MODE:
>  		break;
> +	case HPWMI_CAMERA_TOGGLE:
> +		break;
>  	case HPWMI_SMART_EXPERIENCE_APP:
>  		break;
>  	default:
> --
> 2.40.0
