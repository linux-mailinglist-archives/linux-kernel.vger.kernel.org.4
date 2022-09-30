Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08465F0300
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 04:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiI3CwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 22:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiI3CwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 22:52:03 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93D1E904B;
        Thu, 29 Sep 2022 19:52:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jvHNFZdROs9pkaT4YoG9eK2FIDL6VrBFXgv0c7wl0lJ+U8ICUDjQ1m4EVn2fjT2APx8LtX+V0lz7kz/fMW6ek5LMSvAegu4RR1p+mt72KqXwKa1ITGTUO/CwAHjO3p97Ctkg+J3USezJS78zwnY9X/a1smZhdxDoIb5Wy02HbEKCW5GOSm6sEFtANQ4KzfEvr1PGdxAqDvIDsp8RaJY/j1Qt1TPL9HMp6ipGQ/lxAv3qSb+H1AxwV87vS4/Kpvl6ISVd4cNpXvUlKzJ4BsLt1nONP07vGrqsYqnNzFuFTwh8I1QgMswUdONrZDlttr/ebkZ6ia2XPD0Roum0zui/ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qf+SUDv/Udo3tdSrGEj3woRGoy2kWOZNf44LJwO4wNo=;
 b=DWjkYaMR5zncMyWLK76T9Ipi3X0+vdJh+s41sHPqjbOTEHUXBPMUNpccprYqr8KrgE8wt8U1WSiLCs/kIEeK10sWuNPjkME/KECwosLkn1oaprBZB6UUSomBJSkea2YkLojEex4jgLn/6Ky1kkSztd+2KSw0kmX9flVioWPHNhUMd5bzRMPP96LXbU7kTHwiyOlpMcFyQMzJI9j6BZMxQRrJWVlDnJ6lcOhZ1ut1nzeSppT4X6cXEOcWAIKKsKcyYOQRe053FA8fmm97FakvttjZb7NjfCUHcKSYhJ5d+nrUUFw13YdkUQXEcTPBpRfolJm84jyP8LFMbf3mT1hxRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qf+SUDv/Udo3tdSrGEj3woRGoy2kWOZNf44LJwO4wNo=;
 b=pEx9YWeD92pELUWwUn9fdewKocyf3QADoUkjv5Yq954suggM7kjCcsYXYc1+W+ERikjys/zDvPCeZSRvBZqTvbIBi1d4anZ/jMEr0xH3byK462UN6N3tZapuiDTZM4tF7fdxSb4yoc4pGs8sYyvBbRJqgEQm5eN5/eWyaLFUp7LAcw7xifzeh6hvi44CAwM0ryAaBBD9bqpJICm4byvosW0c2q2OK7tiIYJJrpfDupBp1CdLIBv+v4vOHAV0Z1ZUEDkhiC+DQ3nLwWCKW0i40IKP/Gn5LoyUAS6QryPYweulj/86TIMiUdHgID7uIBbKNA5Nv+tGxPFP6FJTTbeohg==
Received: from PH0PR12MB5500.namprd12.prod.outlook.com (2603:10b6:510:ef::8)
 by DM4PR12MB6063.namprd12.prod.outlook.com (2603:10b6:8:b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Fri, 30 Sep
 2022 02:52:01 +0000
Received: from PH0PR12MB5500.namprd12.prod.outlook.com
 ([fe80::7940:4aca:1c44:40eb]) by PH0PR12MB5500.namprd12.prod.outlook.com
 ([fe80::7940:4aca:1c44:40eb%8]) with mapi id 15.20.5676.023; Fri, 30 Sep 2022
 02:52:01 +0000
From:   Wayne Chang <waynec@nvidia.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        Nagarjuna Kristam <nkristam@nvidia.com>,
        Jui Chang Kuo <jckuo@nvidia.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] dt-bindings: usb: tegra-xudc: Add Tegra234 XUSB
 controller support
Thread-Topic: [PATCH 1/1] dt-bindings: usb: tegra-xudc: Add Tegra234 XUSB
 controller support
Thread-Index: AQHY07WJCQQXs5FPEEaLH2T8XUC3Sg==
Date:   Fri, 30 Sep 2022 02:52:01 +0000
Message-ID: <PH0PR12MB5500E1CC960C8451D1B97E7CAF569@PH0PR12MB5500.namprd12.prod.outlook.com>
References: <20220929034221.3817058-1-waynec@nvidia.com>
 <efd42f94-1868-9189-d88e-f03b8c19f866@linaro.org>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5500:EE_|DM4PR12MB6063:EE_
x-ms-office365-filtering-correlation-id: 4e31822c-7549-4395-a243-08daa28ebfa2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hnSVFXICGKPHQybPZZ1EBy4qHhFbJnJAsThIVfX04ifhQlxN5tsvSwoYnyVpc+8FCT2mFIRWb8eVMiIflNCWO9UAD15viM1+brMACbzXXqfF+amK74TiDQ6olJ5CBx9/fnheNyt5hh5d3PccOZh5awerYn4Oe41/uDaUcmbLvt2vT1xXMqxZ4YuylWiPrHSXwiEebniFXaLITGnE9siPSmmV3jrEQzlMou7hSFB4WGu5R5C1C5WWYg3FsD4u3H4c1YtauKkiMCKALXwqd35QIS+RKrtX9TV5dhiIQXN344F9RqMfsRerqIoxY8p2VYKIqEr0vSV4B6SNXL5HOP5HQMZPMajvKySJ0p8E6BJh1HLU+wM/85PDOEywNnJTL0bkwMOuSkmEaC6yRHdMcbmYGHIGeLbO/BE0wOopOocBOl9pdtrw3Cl/miLINoA9R60PrK/+1V5zJj/qRtukaYOl13cOrN+bdate2qsp74j1n3/OfWoC9Za4z7J+bvED9KnUH+5QxbbHcVIcZSAg8/UnjHxSmhmy/pZwb9rhE2PGCCvNpNWcU1nndWcM+vWU1lJGdVfZahGl/k3gGeXzw8KpMDJTc4f4h0hZanyhrRZZhP26gpaqJPoEbPnbqZaKozIrr6EdPi3DBBkT5VLRQ2NGxcSTq3iMs9/RxWDkQ50Ie/6kjd+zXNqxpMIjSH+/z+WsMEyQzYjl1p2550hEgX7DckZcLDIEtw8P8VXFl8d4WbLb1+KGhonOueiXhtjtDsfde5YZb3YeV4tUpzecy14JgA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(39860400002)(366004)(346002)(136003)(451199015)(26005)(9686003)(53546011)(71200400001)(316002)(6636002)(38100700002)(33656002)(122000001)(91956017)(38070700005)(55016003)(86362001)(478600001)(66446008)(6506007)(186003)(110136005)(54906003)(52536014)(8936002)(5660300002)(2906002)(64756008)(7696005)(66476007)(76116006)(41300700001)(4326008)(66946007)(66556008)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1ttKT5HmDpiElxLhW1QuLOqW0K9f5essWBzrvjDrJwpzVSD4vQ2dgziiNWXP?=
 =?us-ascii?Q?heTxDdpohNYuk7Fxrfm5EE8OU5EOJHqIuN/5xspw3kU/bjzNgRgTHLbtiVF/?=
 =?us-ascii?Q?C+UekeH3+pdl4icj01HitnSFQ9F6MlBnWPoddIL+wMieiVw0kyleqe0aLk7P?=
 =?us-ascii?Q?kEawkDjgIFbk9Xgcn3ah4+Gdmjv9GNMMufcEPupk1rq/2EpuciqlyI+Kgw9q?=
 =?us-ascii?Q?jaFrFUJQn6Q/q2IGTOubpPOqZGbEBObb3S8MzR9rXR/MiDEO3jlNjQT0qDZu?=
 =?us-ascii?Q?rNMfvG1A9mKuYdBndnbHWrhxxco5DDosPexdwY6/jIDCdiWiMyOln0+yGJJI?=
 =?us-ascii?Q?UUIY8EkTlM7eXJJJIKGqEpVNFNjzMC772u6Mnn+kDaUvdo17gFE3EXMIlp0n?=
 =?us-ascii?Q?1iy6UzwTtQQ06lU6TWYKJNb89Awh8oJP5BrULYBFR9PSqCEHY1bxMqGO3CMV?=
 =?us-ascii?Q?F6anPw5vlGNHmHLXLczeGasJyz2ZcGg+iHHHZgniXeA7ljzdvRBlkxLpUlj2?=
 =?us-ascii?Q?liusoP2r28HEwLix6vhlmNTfrinEDxAbMLMhYSP9Yo+Z/zjz2/RBp2TmNIEh?=
 =?us-ascii?Q?L08E2mTLm9wWwHi0PQG7IFV0EMm8HjhzrrnVnJvLzn1RpIDj+Zv2KC0hbtDU?=
 =?us-ascii?Q?AQtLpCnGx3JC0mZGL4tkTmQ6PDx8C08VqfQ0i/N9iRBD8kUKWVVXp3RyF2Ca?=
 =?us-ascii?Q?hy6LJ7zfspxSKUUtSSf6j1DQzqeyjlb9A/WhDaBC+rnbsQbhtBZXA588tVSb?=
 =?us-ascii?Q?GrabcUZez4/hMccPsQ8ZUw9WhKpUiQL9wHoXxCwG2pVSK45z62m23ABa15UU?=
 =?us-ascii?Q?w1Kj6gGcsXD/+enA69+C2q3usXuyQTrarIob6EUPPZ/Gbo0vfaM70onWGTJC?=
 =?us-ascii?Q?EvhSJNuPeVtrVsxS3l5JoOzuZx5JTWCsQDGgFbxyTdK5aCTmJ2f9C9WeIQPH?=
 =?us-ascii?Q?OMGimRZTIu8nWta3PmHAKhRk6qHeTuqGV3/29aEyrq+0atJzwM290PXAn6ST?=
 =?us-ascii?Q?aEZpnUsrosKNWQm41a1oTw1w9sLtFrUw5pxARw5JEkuw7VfO7EyoLsJ6M3rv?=
 =?us-ascii?Q?w5vF6VngOL+Ic5RQ1MZe8AKpamSoQ0ANnWSvetsxkCEnJ7a1ueNXdkZlbuAA?=
 =?us-ascii?Q?/T9p8N3go6M4NFZabPAF9wxklwmAa5DDTg6JtgI3PPLHAdAPzywkjBKzaOlL?=
 =?us-ascii?Q?2kzz86vTqlyzDgm5mFEVropdX73usKkoUFiSOP4Fe79t5xWm44qB3zeQgrDB?=
 =?us-ascii?Q?MAjhbJ2wtoNvaAmFmq8d9JPWkaSkKLiwecf9yjBL1TNymefR/zMY/K7WT5tb?=
 =?us-ascii?Q?kQ+ESvsqm1h9Y51D89ra2UcsDTMFdyLKvYjNUkEmI7snQs0bLpKkHea/nrAR?=
 =?us-ascii?Q?Tof5Oma0ICGCyx9N8j23Dki6DcPoBx00VsW3ASv3Bpkt/iaArP22FNT2bD64?=
 =?us-ascii?Q?SVgKCUEp9CGlroIoROeFK3AraRqdrt1cPuVVKBUgLmtoITJoutNVMIeuIv8u?=
 =?us-ascii?Q?DZ04+qBaxdj6AN6zgpwdQKmcz5bVm5hTo5bgg/XmlF60pau77cGKj7mHV44+?=
 =?us-ascii?Q?1WSHt4fUsDD/vm8+C8UhkXKJ1KBZCUQxX7c+11SH?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e31822c-7549-4395-a243-08daa28ebfa2
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2022 02:52:01.0196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Za1WLXe3M3WkiA6CjN9KtZ6iPDYNHgT/Ya7Q/QeklKL9mT0Q17iadl0mqUby2417hk6A0VH6l8boj4g4atCQJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6063
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzvsztof,=0A=
=0A=
Thanks for the review.=0A=
=0A=
On 9/29/22 15:01, Krzysztof Kozlowski wrote:=0A=
> External email: Use caution opening links or attachments=0A=
> =0A=
> =0A=
> On 29/09/2022 05:42, Wayne Chang wrote:=0A=
>> Extend the Tegra XUSB controller device tree binding with Tegra234=0A=
>> support.=0A=
>>=0A=
>> Signed-off-by: Wayne Chang <waynec@nvidia.com>=0A=
>> ---=0A=
>>   Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml | 2 ++=0A=
>>   1 file changed, 2 insertions(+)=0A=
>>=0A=
>> diff --git a/Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yam=
l b/Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml=0A=
>> index fd6e7c81426e..7e4eb379bcf4 100644=0A=
>> --- a/Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml=0A=
>> +++ b/Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml=0A=
>> @@ -22,6 +22,7 @@ properties:=0A=
>>             - nvidia,tegra210-xudc # For Tegra210=0A=
>>             - nvidia,tegra186-xudc # For Tegra186=0A=
>>             - nvidia,tegra194-xudc # For Tegra194=0A=
>> +          - nvidia,tegra234-xudc # For Tegra194=0A=
> =0A=
> Where is the driver change? Where is DTS?=0A=
The driver is sent to upstream while the dts is working now.=0A=
I'll send them out together with this change in a series when they all =0A=
got ready.=0A=
=0A=
> Best regards,=0A=
> Krzysztof=0A=
> =0A=
> =0A=
=0A=
thanks,=0A=
Wayne.=0A=
