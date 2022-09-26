Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3D35E98A7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 07:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbiIZFHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 01:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiIZFH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 01:07:29 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39E227DEA;
        Sun, 25 Sep 2022 22:07:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZENHNomRIstMnBmdn3BIuFtl6zGxVN+nGFEmm9FMiKKmAIRuvaECXjQYLpAErSIzft8cxrXpYwmHBtQC+NE2j0fqfhTlbRyMqI1yOWHkoSit/R5iXc3qsme4P+vw5IQAYEYJ9zqjnirVyRpbQestzE/C4xqRhdD3VkTInaNxbZGsJURnM0qu5grse5954tk+NuvwpP6LA5H/EPNMAk76uvw4C3jja5pD94fZUC+5p6aQu0O2mqQzDfw+CKjFb+56KXPTCepHaWz5ZBGcpSePUUNyTk/wlgK7WxJvnWC2o9BJJ8viOqQFfs2qPGJx19Forqa5dglW3VI+7RuUYv7Q6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XTLTtcZDAy/6ZM9NqiM2JAhP6v0MhaDWCL9UXNpvYrY=;
 b=koFx5dXZ+HRF4hyYwjOH7XKfp7T40+1nfiT3dDVqtWRjxaWhlrEhiffLM8IRdfUbxEf51CUmxnaBtFlGZ5ewyIOxTSNq6M2L3vmUL15z0TnbKv4ygTPX5BT2U0WoFzKt5bGINzMKLQJ1KbEoiCB7fPWttDxKl0RBcq7olHC6Z3axt03pCe9KiueYaEyjbI7zkuZv8zLBuFtTT1UFGNhoL2//9PXOZcTUJKfX7gdY4nhKKlrS+eUCrJd6SfvuF82yby9P8woSZd6BjMTWyw6MQPM7omta1zceKrlezlETsNF838fMDoq7Jv1oZZZKspW9rleQZGKJRuiqQ2wsZ7Nz/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTLTtcZDAy/6ZM9NqiM2JAhP6v0MhaDWCL9UXNpvYrY=;
 b=J/Dpsdrsv9ZmUu75kp4Ezqq2X5lM/P+k7k9p5W4z/xNZyCC3OPlc3O2KKezqP795M0b5+Lu8Np2nT2WPwxTNzNY2LuLla9HcVRzc8VpUzx+G6b9adFttVYLUudmcnsTZtruxywf4F9xljeXZbEqimSPub3ilKfUnz5bSClk+hUU=
Received: from BN7PR12MB2802.namprd12.prod.outlook.com (2603:10b6:408:25::33)
 by DS7PR12MB5840.namprd12.prod.outlook.com (2603:10b6:8:7b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 05:07:23 +0000
Received: from BN7PR12MB2802.namprd12.prod.outlook.com
 ([fe80::9157:1a8e:dbc8:3d0a]) by BN7PR12MB2802.namprd12.prod.outlook.com
 ([fe80::9157:1a8e:dbc8:3d0a%4]) with mapi id 15.20.5654.022; Mon, 26 Sep 2022
 05:07:23 +0000
From:   "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>
To:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "git (AMD-Xilinx)" <git@amd.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v3 0/7] spi: spi-zyqnmp-gqspi: Add tap delay and Versal
 platform support
Thread-Topic: [PATCH v3 0/7] spi: spi-zyqnmp-gqspi: Add tap delay and Versal
 platform support
Thread-Index: AQHY0Qm9uDGxxF6lV0O33XRtQtbI1K3xJVwQ
Date:   Mon, 26 Sep 2022 05:07:23 +0000
Message-ID: <BN7PR12MB2802A04F223A3911A180A196DC529@BN7PR12MB2802.namprd12.prod.outlook.com>
References: <20220925180739.21612-1-amit.kumar-mahapatra@xilinx.com>
In-Reply-To: <20220925180739.21612-1-amit.kumar-mahapatra@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR12MB2802:EE_|DS7PR12MB5840:EE_
x-ms-office365-filtering-correlation-id: 49fe7bd8-9ca6-478d-b5f2-08da9f7cff5f
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TD0HEXDhTScfMEckLa6gI5C8HMegzHGsel1AOJNqFExYgmixqLb0c6AF+iKgoZ3f7ip2HZdzRg7uzgOu/2uzTafLei1ktTpjIXGQpu14Tlla5jRS0Ui1ABBkdk6jzhzQnjv8DEUfsqEr9cs8E22VASQ88z2zpLzVKpwoSMf1hzqNaFMoSh/oMmY+wh3P7aLewbGZBbzTbhrXmkIl8ODxo04+W2Pu9Lr0qYIrpOobl0OSSTLVQ6LI7w9Y6PSLV7EMgtOtXeQ5fqTyhsKIU0NthIUOQFwzBp0jmF0JABNMouelCv5/idmdRRmeYHyGkvbEWULYplFRKKoURE24Vm+CIG0ri0I39IrBLfCKVwPG2FzUm3snb0d8vSUrYhjxXMyhf4ncLr8SMARRflcpVoIlovXVieL6N39oRFUfS9yf3+ebbIAatrRPChR+4iDfN+r9JPSyhPRdZcQg1H6g0gg7BOh6U7C1bq/hMLN9y9plP6kvAdxQaXk5GqFQozmHFcpfBS/RCQ8An1Bw6ZPHSg3ysrnhtmlt75UEDeYywQKyqxaHVHVh0UhuMPa9KXFeDnmdIhaFz1J2SlLyZulInBJ/71Db/z57I67yk7f3ZF4vW27TtelwX9l2lmraie3Qdwb10CPgwPb9WkFhN0dv+MSBEd6oU5Iy8yi/RilBbynYchlERRYxSouuyviiTKvbfivUjjfdHAI2raUh5aeLguE+aL0Ovmiyg4aHa4BoZPkzlTzouB39zDwAtU2wt7PzAP9z5rdXursJN0YamjLbCmVcEg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR12MB2802.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(366004)(346002)(396003)(451199015)(55016003)(86362001)(316002)(478600001)(110136005)(54906003)(41300700001)(66476007)(33656002)(66946007)(76116006)(66556008)(4326008)(66446008)(64756008)(8676002)(122000001)(38100700002)(26005)(83380400001)(9686003)(4744005)(7696005)(53546011)(6506007)(52536014)(8936002)(2906002)(186003)(38070700005)(71200400001)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?f5ScM82UPlvxwkWlGUbWou5yfRQ19Qb9A5eT10sByFCdxDQMG0LvfIeEGXLv?=
 =?us-ascii?Q?iLiaOtp+/nEGG55FL/IO/+zKh/lLtLv9sERrdIGyiNy5rKCqmeVeecD2yDda?=
 =?us-ascii?Q?kS/WYk0vxMGhbcIkufed+vvE38n72ZGK9ai82QeglNo8K+F8bMZtMlOtT6tk?=
 =?us-ascii?Q?RSbdo7WSgoCgeIl8KaggSkuQ5E6HHHTgxG7koGhKBa91Ze943XoqKd3ZscOE?=
 =?us-ascii?Q?s7eW6dtQZISitp4gm/r2LEciXQwPT+CgopbaKCEILyvlnKR1mrC2xPUGGh1Z?=
 =?us-ascii?Q?t/IZCYPpHvBpCA5xfIX6imjRxgPCOQItEi6cuFoag4IH3IVVMS3KdA1F0yZc?=
 =?us-ascii?Q?iM045nBuIrNBW6pQs7WpxROcnZ6XsPipVXZt8gqHY8dapy3orAvoDLee9AMJ?=
 =?us-ascii?Q?otgHEI/6v1NCY7BsMF8o+zoj0IiF6x/hzNJ/BlUOkRlsJzNbi8R/s+nEtaEB?=
 =?us-ascii?Q?KsuKww55y75J+dFijCfrcwbt6zG4WNRQV/Auclpp52aiKRoyY+cU6vUUhaKh?=
 =?us-ascii?Q?i1mWEDsQ6CMuBrWZ0+ZkixMbziXNWLTBzO0rD7pmfg3AWCem/5Is1VVlp0I1?=
 =?us-ascii?Q?uOUfybmWs8yDPI113iABPZ1firBOxcDmmLeWa829kAckugzkM+DmXwZ/3Zct?=
 =?us-ascii?Q?DuUdWEU7wVI4NdHZtJ21CB0ZOLRz7M5VwOX5SgTGLWWam24uCLMtI/yAfGWq?=
 =?us-ascii?Q?HxggyP3yvRS+fGYxXtO2UcRCUxYpIr4VAFALHIhtPOlVBVe0hzBKi1RdarCL?=
 =?us-ascii?Q?9bpzAKsBw2cZBfnemnlo5bo5su6+mSO3Cznds0rp03oE6xf5j5ZozHXu/3FJ?=
 =?us-ascii?Q?yxOeWIS1vPzWdq2/MI0oplT0+NOBR3cZx0fDQrd39dJdEBQ4o8+8tjfety68?=
 =?us-ascii?Q?DgMtMGYB6PDx52eSy4CTvw8AYxMadA3KLwOTaVakCX8WgE03UzUNA/QBaJkA?=
 =?us-ascii?Q?4b1NRMzxOCgm+9QKPwDiF0+VuX01sr4kcmgTqiXtcBRnwSBmS9ZJkcmq/LGe?=
 =?us-ascii?Q?lc116vzotIlCRQ9P6+QKQKzSycQB+bucLsdrDUaaq2UEcNTwWzm0doMypG7y?=
 =?us-ascii?Q?kX9qs2AWIebIz5GTNXTUdIUXOxqzPEH2CR4RbsM8id0xLRb0Aj9/KewRXTTr?=
 =?us-ascii?Q?Y1ZspNLM9FM+bSsy51BLEJKp9J45OECyFq9+6HUh96Oi1OH3i9/ASwEnQVti?=
 =?us-ascii?Q?r1JaQ9aaDv1XYqlsd0Ak3Pv4ITFs/GBtS69t4Fu68/E8kn6bL3NbMPxi4EYw?=
 =?us-ascii?Q?HRYscJf5OYBzLYBjbgeQyUcOKsJODpWRQFFYo6/G32Fj1eXckUIuvyk35/TA?=
 =?us-ascii?Q?2KPo6c8rEohgeSbJKBsipXSFWxdsp8Eci2f8eMKqvR+DMuZjzPPZu4/KI5fZ?=
 =?us-ascii?Q?0BW91XlnaPv+KqhUPoH4vpG5TvlGANnNdgbiEyRz4tdFetUp/RxGNRZJbRVQ?=
 =?us-ascii?Q?614puHmtV269KfHsEcNY72Jf2R4JL1yFtVfBcjnOOsS/qJgR0XcWXMtIgGN0?=
 =?us-ascii?Q?csYbIhxM7nkmndT0q9Xyb/QM2pZuTAFyUNsb6QOk3IdhJwrTiXds+PebeSJL?=
 =?us-ascii?Q?ZrZsI8BI2inZM34f99M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR12MB2802.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49fe7bd8-9ca6-478d-b5f2-08da9f7cff5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2022 05:07:23.5570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sEtbwrqf+p8H0/PrwwT6afMScMc/d68xhRgWR6+5+gZoamCorHBWxAuZ7KEljRNiO8+sWwuP3/wdEwe5YO5LQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5840
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> -----Original Message-----
> From: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
> Sent: Sunday, September 25, 2022 11:38 PM
> To: broonie@kernel.org; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org
> Cc: Mahapatra, Amit Kumar <amit.kumar-mahapatra@amd.com>; git (AMD-
> Xilinx) <git@amd.com>; michal.simek@xilinx.com; linux-spi@vger.kernel.org=
;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; Mahapatra, Amit Kumar <amit.kumar-
> mahapatra@amd.com>; Amit Kumar Mahapatra <amit.kumar-
> mahapatra@xilinx.com>
> Subject: [PATCH v3 0/7] spi: spi-zyqnmp-gqspi: Add tap delay and Versal
> platform support

Please ignore this series, due to some issue at my end some of the patches =
in=20
this series could not be delivered. Once the issue is resolved I will resen=
d this=20
series.

Regards,
Amit
