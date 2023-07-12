Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC7275098A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 15:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbjGLNYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 09:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbjGLNXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 09:23:45 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552101BF0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 06:23:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oT07Syv188R5Fci/rK6NIWv/AgL8VFmucOWTGZe6HfCleq0FUlVVTJgNUwb7miL9bzQCpANUGbrSnMXi4egwJ9EHx+YMtKluiNAYTDLs4FRqsJrpoTrV5+lAN5VxOu/N7ywHMNQRir5K8G4aJKa85yhZ1OKIrfTE6s/FKNww8M2eSurSxpD8rsiKev6nu05BJ/NJObkDjyC5SwezgAOLbjw60KbliTk299K7tTIg1SFWozuAHWmDD1osxr6FYz5czvwC5WpUhFQmuu+oMrHaiNi4c/EQG5CW3yzI+/EC6TuCcm+s2wd+wzAstlqmWK/nxfU6Vc2spV2w+vmNAJOzQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tN6+S2235w2aFlmZxitHkv2YseJM8Aku5kxU5TYYg+U=;
 b=nExbnvtwXRMZYarCWk+uCnHiLRNRFxgxlJJHJR5f3513Fx8EW/AQljNjzxvYHyVoCukNdalh16bFs5PCJYlkh7fvTgFsTTzOXEE9anwzmyt5qojHwUzlkwnDePMAuZVJNCJuBuiQGP6+/pJFysvUzxpQwZz93P5Y2xuu89d2jSXOxSNZTrnokZ22VC3LKAlmY/EOoKy6UCmTyXv6bZN+/O1pytLNFzTXXWj4nmLdH4YRNYt6RqAfU1VAC29k4ffe/dn1Z01W7sZhWsJVaUP8O2xAM7VCtV+LSf+z09SLMUxy9TCBgpsRhIXK7mbC510dkfdSHySZN8uNNRJLopD1/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tN6+S2235w2aFlmZxitHkv2YseJM8Aku5kxU5TYYg+U=;
 b=gv6f7IjJG4eDJAQY4VZX8xY4bNuAzEcySCI1fYmkJ9SUYIwEPhn2V85El5Mstk++ZH3hCAWAyIjqP2w97GqGt8xrbD0Wt0UYrpyxAFtIrpnSRmicOqgbxVUEiD0rwW3qya3I3STgEscB9Agu2ez4fpix9dz1xYx58Xj+WzAi+k4=
Received: from DM4PR12MB7765.namprd12.prod.outlook.com (2603:10b6:8:102::7) by
 DM4PR12MB6303.namprd12.prod.outlook.com (2603:10b6:8:a3::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.32; Wed, 12 Jul 2023 13:23:29 +0000
Received: from DM4PR12MB7765.namprd12.prod.outlook.com
 ([fe80::8d98:f5c2:35b:e9ff]) by DM4PR12MB7765.namprd12.prod.outlook.com
 ([fe80::8d98:f5c2:35b:e9ff%6]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 13:23:28 +0000
From:   "Gangurde, Abhijit" <abhijit.gangurde@amd.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Gupta, Nipun" <Nipun.Gupta@amd.com>,
        "Agarwal, Nikhil" <nikhil.agarwal@amd.com>,
        "Gupta, Puneet (DCG-ENG)" <puneet.gupta@amd.com>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "Jansen Van Vuuren, Pieter" <pieter.jansen-van-vuuren@amd.com>
Subject: RE: [PATCH 3/4] cdx: create sysfs resource files
Thread-Topic: [PATCH 3/4] cdx: create sysfs resource files
Thread-Index: AQHZs/Eml7wv+9Hf8ECAZ85drm3xW6+0mECAgAF+O2A=
Date:   Wed, 12 Jul 2023 13:23:28 +0000
Message-ID: <DM4PR12MB776565FAF9F3797643C9AFA78F36A@DM4PR12MB7765.namprd12.prod.outlook.com>
References: <20230711121027.936487-1-abhijit.gangurde@amd.com>
 <20230711121027.936487-4-abhijit.gangurde@amd.com>
 <2023071148-grievance-gulf-0841@gregkh>
In-Reply-To: <2023071148-grievance-gulf-0841@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c9152233-dd55-4dba-8009-57cbf807ffc8;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-07-12T12:48:40Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB7765:EE_|DM4PR12MB6303:EE_
x-ms-office365-filtering-correlation-id: 736f7b57-29d4-4476-e43c-08db82db2df6
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ErUJMU5bu42vA7RaG9tVRO2z8F6W/K2WJSd29y3F0XLM3tA7wm3x/7t1ihC9YbZmLl1WhgZ++3o66Gs0rbS4OGAQB0SnaVL+8EIoyOb9cQ/FITLjXsRKybZJygl38w0inuuPbXmR1T2uo6JyFmOO+aWMIDE8pfL+CyyJA/NLRfTvqL3wZMDdDgjW2uMwG19pJbRzf+IUjjDjMm7v0MkRz4tDunFzThY+uel8U5DemnWrSs+xtAuQR6GgJmw8ubADtxXP6UjmJXENsMTqxkIv8Gr/OP+XPe5jl72B0mhI53ZNLjadNhLFLed0nd1QCmCAtbfLa1Zf9zahaEB+HTzlJOtJP9k+r7ZorQ3zEWRLkGchkKCNRM4Ox6U2Q+NCLyFTk3rrvaFDM+zTUiSfLKnvxNCBG5mjTXNhNZKsol/zaHFc/SwVJjYQnubjM0qouE2p6sSFxM3QxejMqGOfKSNicY4iizC9cwM42oau3VX3d+15NoxHn9reaYSV1UNjrXlHvUbZ4p6Ue3IQttuluBPeYTDnL62YjcFZLaehBu3Pyo+eMhNlHTOQwtHcrC6tWfwY8C8bYWhmO5KGoxBNhWat591erNq9yEdxZOouELCWuXbf4CqqO+HQWhJyN48ej/YT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7765.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(451199021)(71200400001)(186003)(9686003)(478600001)(316002)(54906003)(76116006)(66946007)(7696005)(66556008)(66476007)(64756008)(66446008)(4326008)(6916009)(41300700001)(8936002)(8676002)(55016003)(86362001)(6506007)(52536014)(5660300002)(33656002)(83380400001)(38070700005)(122000001)(38100700002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?puRAM9dKxhaWGbH9A3SOq84h/hb3UlInBpjXCmZePkU6n4uwb8a+viIv4SeA?=
 =?us-ascii?Q?W/OU6EBEexZobQSrh+gbXo2o0kiIlgLeweVrSRgBeoqj5FI9wBmYcGxn8oQg?=
 =?us-ascii?Q?FCe4tSHiduW5+cq+mSHQL4er786Xhd+p8IM/feZUt+N3el9wiPUa2/cuBzoa?=
 =?us-ascii?Q?UqqZVBL4FN0Od6UG5nIJcYxrs1klgiYZVAZeJ3O9CiuCSkSnwy0XGbYrfw8g?=
 =?us-ascii?Q?VhJDGXemaS2Bgw12ywtEHgbuIwJR8lusxNCmwhETRFAqWOKycyauo/jn1cZd?=
 =?us-ascii?Q?0KCgujrF5uACyLbhwH2zmH5tUYhfZ72GwQY3FJMiM0n5IucCUF9tyF2AIPX2?=
 =?us-ascii?Q?rKO91KniKqPUkkdvi5iGFtWp1nLD57DER7owOKFX7i6rw6YA06S5X/E24xw5?=
 =?us-ascii?Q?n3ISw1y/I/nKMwbdVLzFnUEykmJ2KeKEKGJirAtGtorRt+ahVGadJVKOVGSB?=
 =?us-ascii?Q?1k6DaeB1/Y9yddtz6yijuaDuIYqdiVsiNmJBWiwUeGLPTbT9gHRi6hTpdxY4?=
 =?us-ascii?Q?WJAQMawRs3dZM8FsDk2y4RzwClCKr/Kqg05V7DIT90E1UtY16tRkErW8jo1o?=
 =?us-ascii?Q?b3nqCI5HkefAwKcWKOsunS/E3lGtn9p5fiqZvRaXGHKq8WVqrmWGIjPICHkR?=
 =?us-ascii?Q?QPNTOZ1F5LHylTtkLvOrhtyhIOsRFzauNNCGLgdtWgfpUysXDuNwv38ZQPAL?=
 =?us-ascii?Q?jh2HVvsoQUPewg99wqfTRByASNwuiOekvWK+iYeo6pllywF6kU1KVkqaSplc?=
 =?us-ascii?Q?1ieJipTkL0trTH6KUf6qgG6f/ZOhMdVWjbS1+RXSTZH5+DAAw6YSpkmxbV8K?=
 =?us-ascii?Q?rQ8LLy3uigry9/5R9ifrkdMYWnaZqaUZMNU/poH+KRdZNrjTXIL9Aj1m6Vil?=
 =?us-ascii?Q?bxNn+5dwVReHRhwvR6m0B3FUF9plXV0lUdzKwnMv/h6EHfbdVv3OTPWBwBP/?=
 =?us-ascii?Q?odsQM8zQRCs6+zDyRTMRQAaty8TMqS9L5qVuyf5vSAlTpolXz8dAF79IKmHF?=
 =?us-ascii?Q?yxeVfWyJ5Hc86kte/z0MJhzzeStuf9xCKqfrzqAWYRkimtBpnjoeOKb2WRBV?=
 =?us-ascii?Q?YNRVUggbq1mk2khUhMijlmbLni9vUeGMhNaTR57jz52KMLxj5Ws7r6cnCpLR?=
 =?us-ascii?Q?kf6LsC7R8aantm70Vmkl0LeNSNJXQvc14bXWwzdvIhGLImfgM254Q9zM8JAD?=
 =?us-ascii?Q?fskTSq3VdzaU4GSKgx6o9r9eKOzCrZ4hn7oCrtq638mk4RGM22mW7/8d7YqJ?=
 =?us-ascii?Q?7v1SY3jsYwtc+85kw60c4Kvg7wH45I0tTsl7cCqooyzofLwB5mf7flsZZM98?=
 =?us-ascii?Q?R102pZ0ihbU4g3l/aAhVPQEDC5elfeDEPu8bcarqu12+tDqAbdElKqoMuL22?=
 =?us-ascii?Q?0xwINkSUY2PNsrvIYWBKfMfBIUf3Axj2saSmhrA8fu1pgsVxVqSj6X75byyK?=
 =?us-ascii?Q?mcztVaYe9nHyNzMM4/yc/ttKhPucuEiZ+vsk296ffnw7xVqJJhuiRxdcqKs5?=
 =?us-ascii?Q?U8yG/GhlRcROvqsSvhTqxyB7ZKORNHxYeCLbQ+c4GEky3cJfNZ1AjaGQrO9u?=
 =?us-ascii?Q?s+XyWrisQ659Z+Ma783hXa6CqK+ZITt/L3992dipXRywzrHbokeF/CmAovCs?=
 =?us-ascii?Q?b03gKXfaSBuNs00Sf/wK4Jo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7765.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 736f7b57-29d4-4476-e43c-08db82db2df6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2023 13:23:28.3630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fchpzEgIERi+fS5KlaOM01uipefBcqHm9UXz9cgQIweEWDrdlJbsq1ihhAVmrZvMO8b+YydztneIXKNEFKzRfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6303
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

> > Resource files provides the basic MMIO regions info to the
> > user-space. Also, resources<x> devices can be used to mmap the
> > MMIO regions in the user-space.
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
> >  Documentation/ABI/testing/sysfs-bus-cdx |  15 +++
> >  drivers/cdx/cdx.c                       | 139 +++++++++++++++++++++++-
> >  include/linux/cdx/cdx_bus.h             |  10 ++
> >  3 files changed, 163 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-cdx
> b/Documentation/ABI/testing/sysfs-bus-cdx
> > index d9e00058471d..6ca47b6442ce 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-cdx
> > +++ b/Documentation/ABI/testing/sysfs-bus-cdx
> > @@ -76,3 +76,18 @@ Description:
> >             For example::
> >
> >               # echo 1 > /sys/bus/cdx/devices/.../remove
> > +
> > +What:              /sys/bus/cdx/devices/.../resource
> > +Date:              July 2023
> > +Contact:   puneet.gupta@amd.com
> > +Description:
> > +           The resource file contains host addresses of CDX device
> > +           resources. Each line of the resource file describes a regio=
n
> > +           with start, end, and flag fields.
>
> If you documented what this file looked like here, it would be obvious
> that this is not an acceptable sysfs file in any sense of the word.
>
> Please do so, and then fix the patch to not do that at all.

Similar interface exist for pci and we intended to keep it same way. Could =
you please elaborate on this.

# cat /sys/bus/pci/devices/0000\:01\:00.0/resource
0x0000000092100000 0x00000000921fffff 0x000000000014220c
0x0000000000000000 0x0000000000000000 0x0000000000000000

Thanks,
Abhijit

