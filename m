Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A2464DE41
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 17:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiLOQMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 11:12:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiLOQMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 11:12:16 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3C131EF7;
        Thu, 15 Dec 2022 08:12:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9n4ITIeETb6tXZc6NWzWyraHcmmZCqusVtm8A8ZoFlFsVtTb3k4jLNlwHYh3a0aPwklxmDQNUuPlNOCh1YNR1NmopbxUb2tZ9FjDDkv1TL9PXzlp8HMSksvjg4Oif3GHX+k+kRqOhWjFrSKWLF1rEouBW2Yk4lUYvTn2R8DBN9glc/xIPm4GS3scazjet+WJxJF/1u0Iecf/OCIXx1u/UgoZEQM+CV4JK7rh0BaSpwL6Mdfx1MGD7YFYzhIZGG/MXA+ZBAmkddP3G/sR61lK37ymVpvi7KyqTDp2TRp7EdKCdJO6dYe6JuO16su29kha3vyYZIuj8KcmW1a+g38pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SyueMjgF0JEs6y63t3DR/bJoFMbkBu+bI1LmBFwknNs=;
 b=JfYmHHraxL45BONnnzvaDa1/oSE6c1g7jIXxVz0g8SisHzzk1ZIQOQGgGpKHMniiZvZnlORCL8ch+KLhiz0AFMmbNxNixXxtmtBcqd0tFdh0Xy12SAwSPkmPm+exdCfKIA7JXRX/nFQezXjF3NHbUyDgbI6YruUmLcXMLXduK4cwi3OPAasNYCiSrCtAqBn8D6eopnSavCj4+J8W87w7jpVDblrFq+TPm6ANuUhLQ2v1CHbLwunS8NFRZ91GzFWZhfBvZ/J451AnomOP0Iw2lcjA7c5SQ1xk/3n76jIq0SPJr4NgKOGK/sB8psT0pyjOnC5xwMDcLDKVDELBOdncDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SyueMjgF0JEs6y63t3DR/bJoFMbkBu+bI1LmBFwknNs=;
 b=obfHZFx3pFv6vMNDpu+GikTj2JBv8sZ0JPx5F0ihfF7qVlwTXfJw74zF69/4pmkKU2jWhHEEJq3Q3pbYV10ucstnBxk8nHr1WEMLIYa1O1oqHXAcYwYdYHlkuQ3tiba73qL4ZuFb0FFKPJZ2n1avF6OjYLym5+R0544iRqJ029Y=
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MW4PR12MB5625.namprd12.prod.outlook.com (2603:10b6:303:168::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Thu, 15 Dec
 2022 16:12:09 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098%5]) with mapi id 15.20.5880.019; Thu, 15 Dec 2022
 16:12:09 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>
CC:     "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "chang.seok.bae@intel.com" <chang.seok.bae@intel.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
        "Das1, Sandipan" <Sandipan.Das@amd.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "eranian@google.com" <eranian@google.com>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "quic_jiles@quicinc.com" <quic_jiles@quicinc.com>,
        "peternewman@google.com" <peternewman@google.com>
Subject: RE: [PATCH v9 00/13] Support for AMD QoS new features
Thread-Topic: [PATCH v9 00/13] Support for AMD QoS new features
Thread-Index: AQHZBZqdPWUZgGQn2kuXVfR31D91jq5vIToAgAAJUwCAAAoMYA==
Date:   Thu, 15 Dec 2022 16:12:09 +0000
Message-ID: <MW3PR12MB455339028B2B444B5068650995E19@MW3PR12MB4553.namprd12.prod.outlook.com>
References: <166990882621.17806.16780480657453071426.stgit@bmoger-ubuntu>
 <MW3PR12MB455392E4A81DB52A9B6B0DB195E19@MW3PR12MB4553.namprd12.prod.outlook.com>
 <f44e1e4c-ef68-7818-d4e1-ffabc92087b3@intel.com>
In-Reply-To: <f44e1e4c-ef68-7818-d4e1-ffabc92087b3@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-12-15T16:11:35Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=fc2c1442-9245-4225-ab01-e2b4e263b420;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-12-15T16:12:08Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: af2e729e-6bc5-47c5-8089-6d1e1331f906
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4553:EE_|MW4PR12MB5625:EE_
x-ms-office365-filtering-correlation-id: 605093a7-c116-44b0-33a6-08dadeb71e66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pDSmotPJF678Pzbf4AqB7T4Ud4xRKQgtR75w2bCB96HtuFnu/RjVYHrSl/43TIIiNnrLLtdPX21uTInfbDGo5njDT7Uf/bfoELVtRTQutqezBR4gLk/TIRwq5mEth50jTKyclelLvWIpgqnUwUy9fKBeutCVLoWKmyObvqLfrAnUKJG5NHsAHPankzM190bfhxClhgxiku7kFTqpkTNEFHDU20dk4NTwJsgqEif87RvySiuNnCgeElnmjIfj1mlHyHJxGgBfu7K6yZeYaqsxViP5iu1SkoCaqTQuZ4ez8x0PV6d7RqiGn+QaXid06GzA3UORklU2ipVOC/XyoNt9NIMIdf6E9F0jS+HO8cTEvIobtFTlfiFWY4rJMTCzySfuFT42cnzVFao4vVA7Xm2mpCKUk0tDGDWhoA7el7tRU+BMPceY2nKUizAfuo/o7R4nYI+FkybAH8BDCLpfA+qD7hzXxG0u3IWSReZT88eeQvKWYHNX/v6QWNanJbCGybZ/uXEjL+Wgrfx+SS/wEn1t37vy+yeQ3kv4xdjKy4pqI0IBV9lb49s585pCDxM+jZ8ePz3KBNgU8yqg+x3pIpdi18hdlYKqq4rSQ8FSc2ufm8WSn/M13dCd/Wi9rcL549oUNb3fE1Q1J2a9ngpHINtvG2+L2EnGeNedQ+VNeG2/W6pD/KSX3LhB2KSvOLwEKElBsvrfS/KqeY3L7nTWRPhasb0s4RuXNu+oF7eK1b9QhGc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(451199015)(7406005)(7416002)(2906002)(5660300002)(8936002)(52536014)(38070700005)(316002)(41300700001)(8676002)(4326008)(66946007)(66446008)(76116006)(66556008)(66476007)(64756008)(55016003)(54906003)(966005)(45080400002)(110136005)(33656002)(71200400001)(9686003)(478600001)(26005)(6506007)(122000001)(186003)(53546011)(7696005)(86362001)(38100700002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EOqu+VrRNnSdzoieyBr/JRT2eJ2pa0/A6uClVgZDdyUunKel5fAAqQC/889W?=
 =?us-ascii?Q?cz7SO8QVBlkSHbG7N2/RDrhsKRSr3nP3j+1MKBokwWlucavXMYwf7ops5xNn?=
 =?us-ascii?Q?sJSwWhnTnDxXsf1gVXa8gBDLFXEcneyXmZ4O5XDwDiEVuZ9rGfoMBuRnN3do?=
 =?us-ascii?Q?txlLRdKM2JCmWgl9zsDZtG2jb3pH6fK4WwlAZqvCXjdeyIig88kwVxXg5OHg?=
 =?us-ascii?Q?Pt11GzFVmGvZ3t+bUufLeXwvI0xgbiUfQ83oebEVf3WlPTEapI/FQiN5pTyA?=
 =?us-ascii?Q?NXAR2n1VdMXe1YjcNEowADbhAyvYMXl8U0cA0jg5YmsLKQce+rw56H+eYZ/j?=
 =?us-ascii?Q?HuPUSpljigI1/tZ37e3giQHzWAmYdtfCGQy6+JWksqd/0Ii7cN6AK8aRN85l?=
 =?us-ascii?Q?9goBiiBUV19HPd1w65Z63S4BAKHdWXmyEKmID/MZRBUqnkdKzX0Z1UawvKE6?=
 =?us-ascii?Q?iF2f+dg85iFo8QZ5ryZ/ePJWQY7YA2tgDun0DhUVSWGXvLVq0DkGt+g/Ypny?=
 =?us-ascii?Q?H6uj0DsGBk7KEi8NS0SooSIaFCODUiTW0PATMZUNfelJB1WwuoFwC1bI6Gbj?=
 =?us-ascii?Q?/4rGhzD0Zingklpm6muX30yQSMBf9Voc35umrUiGeoTG3fmalXhCwDA2laC4?=
 =?us-ascii?Q?8xX3YTbGSpKHSZBUIVpc4aDnpxkr04CSUj73+Af1Ucn7PAIdR7iEM/+MQd9k?=
 =?us-ascii?Q?JO4rU4Ma+QR63+ou0iWoQ7GUmpHnNKXBgyyNjtMu4ScSNVtsY/XtwPh00Fm/?=
 =?us-ascii?Q?uGClsu2GYDzaJU0wkHS3x1hnzBsohHOmFbMn5TBcy1QvKA09s3UgrW0Ts7iD?=
 =?us-ascii?Q?fOL3RcZQvCREYriSxfNZw7x8CHVvcgg4IOofxhejigOfjjFkWTnlQG5mqB2A?=
 =?us-ascii?Q?cf+DTK1cFyTYFvPPJ5Th4JNLyLlTzxGVWaQE7PeMD2o4PGIRzKncad8a4Cjn?=
 =?us-ascii?Q?pU9bhCMkJmLoYuaKU0JDLVH1d0+FKWiIs+IiRE4SziVWxj+4jLGCZHc0WDEI?=
 =?us-ascii?Q?7RiGXyd3Pd4l8z9qS218Bidx4j3GND2II/hgmVGKUNpl4vkW6mcb1DiR8n/2?=
 =?us-ascii?Q?rsRsfMiHOkbYAmAZH8WMttVCWqZC+FavajKhAARivBT2JzXnSKRgG9kDK/CI?=
 =?us-ascii?Q?2dqC00jv759shRWeu5eXilTMduy6Bl9VlT2ctgAsswQFx6iv9uPjGAUUUrJM?=
 =?us-ascii?Q?euE9heA3xU21SfTbKq21oS5gPTMp3b+DnsVVoauxDEbdNIsUK4QGMKE4GjtD?=
 =?us-ascii?Q?WwfVevDyTjqsa/FyBEsy9HWrBRuIiXJLhu7OZRyQG/cHwbulCfzmrdcFdTkj?=
 =?us-ascii?Q?lZUuJlrrLVFL9DMCfS0dgLOpxY2tB72X/X43X5USPPOQP4rnHmn+wPT/4uZi?=
 =?us-ascii?Q?sevQ/cdI5jPwYLiNEj0NBiSOfCDqb+sLjijkEh03bvwUyyQV1YXaWJrZOMSR?=
 =?us-ascii?Q?+bSHSNRg9+0O/F/KtJn7lPDDHkR3l8CloOCYZBbAV2Bnaj3Hzoa01JsDvmF7?=
 =?us-ascii?Q?P+IddwCMSgTMQUbrEzh+Kspg0BPj6KhVuRcAJqFTA00Je5418FN83+Qk1tR3?=
 =?us-ascii?Q?+NBtLoVpYJ10dJqiKW0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 605093a7-c116-44b0-33a6-08dadeb71e66
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2022 16:12:09.6273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BeTxiC+ytq4QtGM5E2eljLrX/JgMvSLd0v1Z6LjlVfT6h2pp1wQHsCbV4ZLDU1sF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5625
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



> -----Original Message-----
> From: Reinette Chatre <reinette.chatre@intel.com>
> Sent: Thursday, December 15, 2022 9:36 AM
> To: Moger, Babu <Babu.Moger@amd.com>; corbet@lwn.net;
> tglx@linutronix.de; mingo@redhat.com; bp@alien8.de
> Cc: fenghua.yu@intel.com; dave.hansen@linux.intel.com; x86@kernel.org;
> hpa@zytor.com; paulmck@kernel.org; akpm@linux-foundation.org;
> quic_neeraju@quicinc.com; rdunlap@infradead.org;
> damien.lemoal@opensource.wdc.com; songmuchun@bytedance.com;
> peterz@infradead.org; jpoimboe@kernel.org; pbonzini@redhat.com;
> chang.seok.bae@intel.com; pawan.kumar.gupta@linux.intel.com;
> jmattson@google.com; daniel.sneddon@linux.intel.com; Das1, Sandipan
> <Sandipan.Das@amd.com>; tony.luck@intel.com; james.morse@arm.com;
> linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org;
> bagasdotme@gmail.com; eranian@google.com; christophe.leroy@csgroup.eu;
> jarkko@kernel.org; adrian.hunter@intel.com; quic_jiles@quicinc.com;
> peternewman@google.com
> Subject: Re: [PATCH v9 00/13] Support for AMD QoS new features
>=20
> Hi Babu,
>=20
> On 12/15/2022 7:08 AM, Moger, Babu wrote:
> > [AMD Official Use Only - General]
> >
> > Hi Reinette,
> > I am planning refresh the series. I have couple of changes for patch 10=
.
> >
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
kern
> el.org%2Flkml%2FMW3PR12MB45538A17F57BF80C21BB46C4951D9%40MW3P
> R12MB4553.namprd12.prod.outlook.com%2F&amp;data=3D05%7C01%7CBabu.M
> oger%40amd.com%7C6d4c8dce8863452f553008dadeb20cd9%7C3dd8961fe488
> 4e608e11a82d994e183d%7C0%7C0%7C638067153551495498%7CUnknown%7
> CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLC
> JXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3D1IDojcQCCWrhxHldDhKsUm
> H41H3K4oU878bvSNhPh6Y%3D&amp;reserved=3D0
> >
> > Let me know if you have any other comments.
>=20
> Apologies for the delay. I have a few comments that I will post today.

No problem.. Thank you.
