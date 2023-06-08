Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF677278AA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 09:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235138AbjFHHWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 03:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235409AbjFHHWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:22:31 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2100.outbound.protection.outlook.com [40.107.113.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9899219A4;
        Thu,  8 Jun 2023 00:22:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f1D4vC5VADxiCL0WU32iptD04iEq+BCMw82kteIklyjRi0/MwsnfP17snayatbTgHnOv5RCP1j5DNYzXEaAwT7zZ9HukitMolLiwVbKxnHpATRXtcp/wVbueRQDt/gXvtD8oGQSTzWwl0sHIV5rzhs/CrtGbEnU0vwwFtOMPTmbSQOrbEfOackvsVWnzQXuU5hlnCSfSSSqD79NWM3s0cibKashM30JS8UE5k6SKytzjZBZBz0x4khz7uhCOPsEmvv1pXjozFzKfiEtZxqCN+wx6sWkTZGWo8Fn9o6bmZbGJmADPdNip6hxPpGd6B6Mk4OkD4EpS1jSWOlutPIleVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJjkhWmOhMUf4umZSQkdSDcmbly2vnlvDKSldv4wR3w=;
 b=gO7ByEApMRN4dOYFof/NcUibNh1I2e3eyD7SxVI7Ckvg17BCaTisGmZ6A02717I6WcddJ543YfI9XwJrCAHFD4rx7kMrMLCK21b9pOsHOlyJ6Y4205Y2YxHG/f83UFJqF+jJRROzJh/ycx2XE7nICvHpZpg5jP5glnw/IIX6rAvKxKBUB3Y4Fl5X5HmcjIHWVu8khmOX+wWE9OTq2SIa+vcilAHJEctxsnE0YJEY4ct/Kt3YM6pPlpTljIlU+kJEOaa1QY0+PH+lV7z8KCjMLQvyD3Efd2EXeKPhSXNh7dhQhyNxJXg91fWvCsIkccvC08wv6cOAQKLdno0/qYRRSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJjkhWmOhMUf4umZSQkdSDcmbly2vnlvDKSldv4wR3w=;
 b=IaexP4uNXBzmlDBgrKPmMYMSMuH1L0k4gEDVoq9fCUM23JNM9hgx22mCpLHOuzSRK08/f1pEpzgy4TFepypu4MTchk7HGVNneh+spoDowhMa1uoT+c8XMs246HBD/6ItM9GyyMt0R9NH9fK9rNXfr1RaOGUewev0Nk6iOdXCSvw=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by TYWPR01MB9662.jpnprd01.prod.outlook.com (2603:1096:400:230::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19; Thu, 8 Jun
 2023 07:22:14 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3%3]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 07:22:12 +0000
From:   Chris Paterson <Chris.Paterson2@renesas.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "patches@kernelci.org" <patches@kernelci.org>,
        "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>,
        "pavel@denx.de" <pavel@denx.de>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "sudipm.mukherjee@gmail.com" <sudipm.mukherjee@gmail.com>,
        "srw@sladewatkins.net" <srw@sladewatkins.net>,
        "rwarsow@gmx.de" <rwarsow@gmx.de>
Subject: RE: [PATCH 4.19 00/88] 4.19.285-rc1 review
Thread-Topic: [PATCH 4.19 00/88] 4.19.285-rc1 review
Thread-Index: AQHZmX+Bz2YD9XNTqkGDN5VvxyH3ga+Aaa7A
Date:   Thu, 8 Jun 2023 07:22:12 +0000
Message-ID: <TY2PR01MB3788CA231433250A35C03FBDB750A@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20230607200854.030202132@linuxfoundation.org>
In-Reply-To: <20230607200854.030202132@linuxfoundation.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|TYWPR01MB9662:EE_
x-ms-office365-filtering-correlation-id: a48a4f4b-56c3-4642-390f-08db67f1143e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q2TzcJrIJ04kNAsZEauKU04zIu4dRbByXSgC7x5HchLDYXxWMNZ/rZQW3laXUXH4fKtsdAi3qu1H33Zq2+a4kjT6N79VH9fMfjSp7tyOT7XXhMyC4DlkL/bS6tFVjTkWjJvsoqpxq+Ul+wTqbSZrf2TzYweMjuipKESFX4vBmlruxlrg84WgrZrHN4heaYdwr2SpEJymHUAzDOvfR9bAlxsGnULxPXGbVaOg2LFDb9JKWnRwqzZvXHZIIoJ+Hm4ibcjji3xM9bAKCk+kw3G+2i5HsQGP3Nm6vpTGG4SZ0R2EYysuZ/xaxF+KJCKIZX3lgZUZrW6t2XAzloQhvfdh1eeIktd3Sc8WCyo3ydeYsTdC5xP56JchO5Oxsa8ZvvDZMMfwW9TUixH6nVNKhE7NPTITJYghqtPVamW9HOnyAEx0Cfv0rKN/U7UJfFoHwWobHR3HRcTuvBkJcayT5vN8zVDwI77JGxadUjd6YBjo2vTeQSmdYkT3ltrEvCJJoKhowYjvdid8XblXu0xqWs7I5e3Ki0Ue3hUJLiNX3kBjDa5V+BuPdlWIBZMU4DYBH1J8hnwi8dyRScvp0iTi0ka5z1Hid1vUuakMlm7185VPC7PGoEkHXO4dtRRXx+uu+9xSm7AvfWjUqdQDUqDzBmiCsA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(451199021)(186003)(478600001)(6506007)(26005)(316002)(966005)(9686003)(52536014)(7696005)(55016003)(8676002)(38070700005)(86362001)(41300700001)(38100700002)(71200400001)(8936002)(64756008)(66556008)(66946007)(66476007)(122000001)(76116006)(33656002)(54906003)(4744005)(4326008)(5660300002)(7416002)(2906002)(110136005)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?HDwjyAfAWQRw2UwM0APEO6IUSVwODPdJVTMhZuy/MzRUNzFKd1nYTKu6Nc?=
 =?iso-8859-2?Q?IaolcysdDZwjoyyY+EdH2lsd325cUkBcJUheMHNxiaOj5tgZnvO9Dq9l8c?=
 =?iso-8859-2?Q?0e5OHC+0Y+MiBYgie/p3782oUuSfQW6+qtkxhvTe+Vl3Anp1jt7v2J4/LK?=
 =?iso-8859-2?Q?Ks0B3lqccI3MumU+TX7O8P53GqHNGhHaHNlhGSNT9uUmWb/qyFkn99ZSgX?=
 =?iso-8859-2?Q?Kj9Ma8fXYZkvKayMrgfKW5WiyDMHb5uYbHFOF7Tbq2GEi5VpXSkyyuRtzU?=
 =?iso-8859-2?Q?xuq90VDkJtPJDWtUTWZoyubmsPdxJCLwJdB4IQRLcGmHj4UiW/4+NXO4zG?=
 =?iso-8859-2?Q?BZTepL/8c4hvtwAPlVyhjhgwmuUOIYpkPKvz172nq0j+mnkHL3d4OZWId3?=
 =?iso-8859-2?Q?chS9Rkg4+BdnyWktHwCobLEgynR1pEQetlyL/wvQ0StzvS0FwOA3SBcb8V?=
 =?iso-8859-2?Q?Hyg/J6+EsSphKOw2LD398vOdC5RIMQxTjwkgxAICKM4K92/DYYq5ASVno3?=
 =?iso-8859-2?Q?1aO6tXcBtmHX6s65Spdl75y7HW6cdJ+LyX51dGJrwakuYeOZ8KRRYdmycS?=
 =?iso-8859-2?Q?oaGuPkfiST0skX+/ItFvMMv7Y+W1OzGj1XIKCTh5CAUEvNT0sMtmfpr2Qh?=
 =?iso-8859-2?Q?8tW3+RTKuxNbe6Kc/eSR0PGShJolKr86kOoenBtrXtogZYMy6AvtHBEz43?=
 =?iso-8859-2?Q?3h+8xMW2XEH/DmgfP7qWToekP0Nd3YKS/+PqUd6wJzcu98GceNeClI0Oaq?=
 =?iso-8859-2?Q?A0sdRoWDjTqXL8SFwLb+7WU8FX71OSpGMhB4dkxgjFG3YAWaL6uSZCOscN?=
 =?iso-8859-2?Q?+b//uLwyf9mKRc2vBVPhoEW7tOxXAu8P1gkcKVPVOeXjWhiP9LFuXtZ+Uw?=
 =?iso-8859-2?Q?uZ5AH3JgaDlR3B3QQiAxWz0fvd0oAatGmAStTFr+Rc/cXTEMWR1vOjC6nW?=
 =?iso-8859-2?Q?JPTIdzxfECSGL/MWwRRUJ/sDrjMJsn9QKvrsNeNaVY/cCDZRmeoCcAmdnp?=
 =?iso-8859-2?Q?osEwmHWrXZ46UtW+3+Ch6p7YiEsv4KYafOjBscduXrkwRjuwjo1Ac1cqXf?=
 =?iso-8859-2?Q?D9E3lWX3SySYHhUQsiH4PhYaTWT1MYnbZeP5m7+V8Jz6VbygL/Tb6oIjrk?=
 =?iso-8859-2?Q?QjDf41tD7mHRBjjsBWQPCTNh547DyjgK5p6JIHz/7thuWfXZc+OYY1dAwW?=
 =?iso-8859-2?Q?bdZxXwzs1+siE6xJdgI3kW5N1w+Vx1mx+w7Y5KKgGqvPdbTLd85oqXO79h?=
 =?iso-8859-2?Q?v1YSs95Ga9w6bYDKtq9ZLtjP22r3/GffGiUqI5OUr2NSQ1SCSwkc8MrbkH?=
 =?iso-8859-2?Q?cOTXb+onjRuMZhHltPsI0vGgeLBUW/2Kxob4MtuPdeQvCpsLWvAcd4kt1W?=
 =?iso-8859-2?Q?syiRcMqpPSi4Dq2Al4iRNCHKk5k4sjPcccqWDHAHgQE+g3C4BeFqalAIeS?=
 =?iso-8859-2?Q?kJYp1jiaDyTuJeL/jpcud3mNLrb/uf5VOp12Q5jlGsz4mWXLA7LXCiTEXr?=
 =?iso-8859-2?Q?T1jt2xBOWod5AJ4VwB7hYchOFswW5SgurUH99WgiaSrRtmN4CblYRL7fVA?=
 =?iso-8859-2?Q?se6usXHj9zkD1S7M2iE/3K673P0Ql/y/peKE5OvozGNNXFd42LR2ckMVlb?=
 =?iso-8859-2?Q?ciXradQ4Ux3+rE0+LarE+88MVwzv2Z8MZ1Yt+o3e7ZHcMHQNA6CCnMOg?=
 =?iso-8859-2?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a48a4f4b-56c3-4642-390f-08db67f1143e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 07:22:12.7356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: axCwzVK/1p3EwhUBP+cAwoFKSEbguFpXp47JRbH1PCkrC6vQHA1Wewo0KPRoOedl2k9SbF3F8X4UhmaHSV/cyb/CQqNUtOiDRwU/2oyWi30=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9662
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Wednesday, June 7, 2023 9:15 PM
>=20
> This is the start of the stable review cycle for the 4.19.285 release.
> There are 88 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Fri, 09 Jun 2023 20:07:31 +0000.
> Anything received after that time might be too late.

CIP configurations built and booted okay with Linux 4.19.285-rc1 (a1cebe658=
474):
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/8=
93073911
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/commits/lin=
ux-4.19.y

Tested-by: Chris Paterson (CIP) <chris.paterson2@renesas.com>=09

Kind regards, Chris
