Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F5B6336D9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 09:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbiKVIPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 03:15:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbiKVIPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 03:15:41 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFD840443;
        Tue, 22 Nov 2022 00:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669104940; x=1700640940;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4PKP3WF4mtRjFcIFlO8eqD/BuFWuxZx3hcdGsGF+wUU=;
  b=OkwfEfKlEcABt0//oK4zRYcTxoiMErKH6MsZq8zO5y3UDopilWk0gUai
   dsqNZ/09jRKCItKB/s8f1ssQcCY6WpBe+vS0GGN20NPl2QqgN+ntOqEsc
   cXFWft3E67WdL5GwBHikXAbZjoIYJXU+3d0VFy1ELojYwSD9kWTD9R73f
   jeMfPglQ4sGWdbXCSFAZfVwM9fa+M/o1eVwnZFiZnqOemIAZltuPGllT4
   9A8xeNVxzGuUeYdhuEJTV6JNm+Q1qCvj/vgZ7qPDhFKBPCOoGUGZnBAUB
   nVGitJXMazuKXOYwIYWn83qNTaWjDPDW3GX89JzbaAz2bCCcESaXjxmXc
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,183,1665417600"; 
   d="scan'208";a="222030458"
Received: from mail-dm6nam12lp2177.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.177])
  by ob1.hgst.iphmx.com with ESMTP; 22 Nov 2022 16:15:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EkFGQX7HxuqcLcsmXTJLJsYrCZGoVlmtLscTHpn3Wnxd/OhObEtpbNkFMGiLcj3yNdx1YOvAPZpAMpThKxAkntGZTjsDle7jQd1j/voZirytbkeocZ/qt0UHdIuX7TtrowQFlEtuSeYIJSUXrtyv5uUxX1KKIVtzFW6oSSmWbosB8ZBPKVj926nKDLX0JstIf+AqcF0aIEL1tcdF9fY4FLS6URgUdcxCct03J8tNPj6caj+N048BgBY01DymPaBt0ozrRZQGQ94TrXDWqJp1QndpM8xR0qqTJtN/nodkfHPxXNF/okaTWJfiGGB6SL3VkB+5gGsnu3cl3wWhXzSFUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=53AHpwR7raHREju3SYaPq3iRUzQbrl4jzlmYI819ES8=;
 b=Xamggz98PEMhikwpN5r1bq44ZoCLKLvyPy5wVl9llo444XrZ7c4afmPwabrji51s9xgrutZrPmW1I3junGjtM7fmEFnkzu+ctpaBJaEvh8KXpvBhoSfX3VlvfEriuNlwNhCufO51Ovf3/a8hGyUvL4i+kLhT5UfgAuXRdc9Fudj8y7bg0nZXSJfmTIZlia5rHNRNLsCT632vJ4sIx8HmTtNGMo6yjvFmJnzKQWbiaXZMALuoDK3cZ+UpX99q1r6EdbZmDBnOh9eDqPPkCsXJTQf/WDo7W4em1nB3vb8Sg9k3XNe4OYgGlWXU22HLxNaBuAxL5L4Ku1uERq0pylqaKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53AHpwR7raHREju3SYaPq3iRUzQbrl4jzlmYI819ES8=;
 b=xZnZw36nugbbN8NjPRIYNMF8kLgI6BsBlQVTjnCZNZ2V3DKMQokAT3P5D+SUUG7PlVSxVHVyO5fJd9psGQQA6xL5LiDmEu//KdFx7JNKfFYWpc0MjYv6PjNJmTN5RLhjlmqbVtxG5i0JFTrMa5qtyHpsy1eldhJK811IlWYSbic=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 SN6PR04MB5229.namprd04.prod.outlook.com (2603:10b6:805:f7::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.18; Tue, 22 Nov 2022 08:15:36 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::1afa:ab74:ef51:1e72]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::1afa:ab74:ef51:1e72%3]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 08:15:36 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Bean Huo <beanhuo@iokpp.de>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "tomas.winkler@intel.com" <tomas.winkler@intel.com>,
        "daejun7.park@samsung.com" <daejun7.park@samsung.com>,
        "quic_cang@quicinc.com" <quic_cang@quicinc.com>,
        "quic_nguyenb@quicinc.com" <quic_nguyenb@quicinc.com>,
        "quic_xiaosenh@quicinc.com" <quic_xiaosenh@quicinc.com>,
        "quic_richardp@quicinc.com" <quic_richardp@quicinc.com>,
        "quic_asutoshd@quicinc.com" <quic_asutoshd@quicinc.com>,
        "hare@suse.de" <hare@suse.de>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/6] ufs: core: Split ufshcd_map_sg
Thread-Topic: [PATCH v2 3/6] ufs: core: Split ufshcd_map_sg
Thread-Index: AQHY/S6bmPmPCTCtbEC2ZN34Ub/ena5KlgAw
Date:   Tue, 22 Nov 2022 08:15:36 +0000
Message-ID: <DM6PR04MB65756D4E5DEAAA95FCA24784FC0D9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20221120222217.108492-1-beanhuo@iokpp.de>
 <20221120222217.108492-4-beanhuo@iokpp.de>
In-Reply-To: <20221120222217.108492-4-beanhuo@iokpp.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|SN6PR04MB5229:EE_
x-ms-office365-filtering-correlation-id: 581ca989-b3db-44f5-6a02-08dacc61bbcb
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +JLVrIg+3T9s7G/PaZYXz3A9CG56dZvGgB5VPxhXJkOx3dPKQZmAkbxSz4/4Sft5w1qYOorh4c4HFcZ/w59bhVrawga3XPVTjrUCZdjs+bTaJmwAVK/POVovTcllWs/QgVrSm6HfxkgSLg43f/I5aJoNnAunoBSCYp9TBXMcXmx0TbOZCk7vv8Px6cnM1bD10EXvoMB8m+9MB4SZf/bht3vYITpisLLTjSrB/qy2Ahql+sYahAyFkd+TKRxk1dJ+mh9WdTxvH8QO/fraKFNV+/EoLLyIC8GUobEUQhYpZXOoe+gO6vzH4MY0g41jEyI96DYidJvhKYvTh8hx4FAsrDcFWxE9QWdnqdV52Ogwl31pCeZHXBEPfDksBdS4nigXVqKjcJdn0FSJZmy++OuY6udIl/ZP+3GWPIBnSHLGl+TNMPli1MmMTYY7EGf+GiUU1OcNVAMv4q8y1hxp2zhXFLbINpKDS6snj8VU8o0QNK2UkOgE3k/jHWOZjJnJuCaNx/XKYpb9DNlLAB6nzosMHQHWOZp3wcTtZRmLpOX0AioDnLOe6OWVt3L9FVEP+T1dVlJi8i4ZLCyCOZ4aoV7ILXyKb28b9aLv5p8oyi2P9NgIOy+GKsJzOqJgvE/A1kodxzBS0Gph/cfBJ+6x5/QlKcydmVJMco4Ydl9nuNezRPPdXAAARGI39Z8kVJnCSadmSUsCfBJKNlkDCfq3GpfdeQRBU1+r7RibcjXmAkBdU1E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(451199015)(33656002)(54906003)(38070700005)(86362001)(921005)(7696005)(6506007)(55016003)(7416002)(2906002)(83380400001)(82960400001)(5660300002)(52536014)(26005)(186003)(9686003)(38100700002)(122000001)(66946007)(41300700001)(64756008)(66556008)(71200400001)(76116006)(316002)(66476007)(66446008)(8936002)(478600001)(4326008)(8676002)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pQIBWTG+EMx8fU7W6gqCoP3zPj0Ig9X2SlMYs8GPk8s8n5CkUyC16w9kB/IP?=
 =?us-ascii?Q?NxiXipo2OjZaADg4In4DbNUne4q2dagldTxHwnWr7Qi1t+gbZYZnqvfYSz6z?=
 =?us-ascii?Q?PqDpYTgHwL1Rx+suIMByfzO/sP9+YMb3SyYPY9I0c8UTwcQ30ApVTwStcxEX?=
 =?us-ascii?Q?sdPYcjwv6ZMp43/+qoonJAfd1XjpO/l/VUj3z07uDuqV0Vjwl43kyKqd9rTP?=
 =?us-ascii?Q?Z0d1BBIi+UhO4xMQLk0fYXgMdvrBlC8F4sYCf/Mv9SKkLaBZWXImmBzdN6X1?=
 =?us-ascii?Q?+EgJQ2Nc3drnOBeJjq4mH36BuZx4+7ayarCN3Z87O6QjpjmJjc7tzky6N53G?=
 =?us-ascii?Q?+eFCoBo62UyoqfYa4H42xvlKHTOGWvZqbfvw2CGp4JHVXkIuGSvuKSUZ7Zzx?=
 =?us-ascii?Q?cljchh5xPXO3/MFtfEQi0mjzgCT4meuxL2/h++sNLsyDtpBmSNtA++deCuUA?=
 =?us-ascii?Q?yQ5417/hqmAvGnxEwG46jHt8WJoyW2PQAwVsbhpbABRYYOg54h5hyhiI3B/X?=
 =?us-ascii?Q?TKKY80FsKkwM7y6WuxXwKiHx45tBOnsMEMe3c5ufAU+cK5ILR7amFIuO4/B5?=
 =?us-ascii?Q?w0zhGwzTHlDphB5nJ3VzLESmENtrcZ5Bp+cRqAGcFrggZU7GXTVQ8rdgm6FU?=
 =?us-ascii?Q?kcs/ETLnrmJoDS0gFSJ0JveLUx6OpT43bMHC2X5v28NGLh0LRwNT/MrB9Ydv?=
 =?us-ascii?Q?rpCkPansqVULrmHHr9dhuiK1/KGEhg3mhFpGCaj7uFUnCr4df/70193NxXQl?=
 =?us-ascii?Q?OR1nxCOf4zlwuD+VypS4pRprvEvd06hujPR0818nhb3LccWMVaIUyqnQEkT9?=
 =?us-ascii?Q?Ty6GpgbU7F6+83exHwKTfX8/GZpoT2uKrSTeqQJAIVDDi5q3Jkq7xV6VDQ/2?=
 =?us-ascii?Q?5bboZ+l5jW76D9v9mMCUdk2vkhp6RNvUNR7GH/P6BLBHGXWneahp3ecxcmiT?=
 =?us-ascii?Q?VXe5V3CHo1cvGdSbVmJs6tbbAzswVkcXSHTlfD99AhA1pEjztzTf7V/621LV?=
 =?us-ascii?Q?OWRyAgZK5Ol77Elikfd3ydVQJkalL+Ze7CPX/nH0gKPhHKJQzvNz110q0ZI5?=
 =?us-ascii?Q?XoP/wDdGN3l+ImPy/y9+OYuqYl9FK0B4Cz19lcv8fnnHlCyPJX0gy4nzAEib?=
 =?us-ascii?Q?PduYQiMfGyuVhK6Vj57OwF0NnsSwe8x38EkmibTbcjtkCT6/o9QsbGcq7dvf?=
 =?us-ascii?Q?8DY/pCoZEpe4lTW6Ocg6D5M3f1x8GhHlLAdXRTosNJAbgI53OXm1/uWPm2C+?=
 =?us-ascii?Q?GfTMypS2crciKQL5LUTixLf/hUr6qZoDbmwahU4l/SJybB+33plqaKEZt0Ib?=
 =?us-ascii?Q?V59VIwO6F+05MMUWcQNz0PnJV0je21NFmOgchwPAxIKk8QbUrukeD4RhTHQH?=
 =?us-ascii?Q?JgMjzselFqfcg2byUrYoCJ1+A+InEB2QrHwJRCnC5XvnKBfSYzTRNw2ZSpmc?=
 =?us-ascii?Q?JVMhbvR/RLbSia+G2mC07Bz4zTni7XHsEIDdLjcD7eF7466cuggX1EVco8um?=
 =?us-ascii?Q?T3zR3PjbLlRMXNNzHh1yULWLen+wm3W2t2yix0jMu+RhOciHUQUJ8M3C4qrQ?=
 =?us-ascii?Q?TtMKsz83qEcETtkMJUVUpafyDiPEvTa4AdK863l8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Y5Y5YL7Av8I0sfhlHKWtIL184Vg7t4h+EITufpkDGsnqR/kouCKQr35r1+Zw?=
 =?us-ascii?Q?Gs4cyZglQhXPB4vCo8DvNARnUdfJOAcXqEqoAG/hb3ns8Ats+Llshc8dSqsa?=
 =?us-ascii?Q?5WpOZpB6MT0ZZScck6iEo3sb1ncBhNZ/mN9car6kBcje5bhD8EIVpHX1RNQz?=
 =?us-ascii?Q?Uo6aFm/Ot6e9obVmKSJGzKwcytHulftUXHJhvb08qFJhBr8+ujLBOxQ6BN04?=
 =?us-ascii?Q?rr01s028P9Z21QgjgUyHL0yFk0l+JLaMwc35TGDjvLPXfq2TZ0YFvenf0/Zc?=
 =?us-ascii?Q?qrrwGPmhG/nEGg0IWiYTgw05Rpb6TpE/RENw3Bx2QlxfVEHEwDWOIYuTY/5i?=
 =?us-ascii?Q?YBoe8j/TD7iDAdT8BpiLM17yhwaefOazR38eVZm/2ELZXv+XFM+Fgczc3KNy?=
 =?us-ascii?Q?f2qFN1/BYydUbWwz57Z9NLAjxGb1HJeD2gz/QIXNyuODyCLB8KggXes+/TJ6?=
 =?us-ascii?Q?MOwtT7bvj77R9Z2gNlyiTx3snud7D50a0qoF+DYFyoPhdZQcTxcWIb2R1Q9C?=
 =?us-ascii?Q?OHhHT6jPaSES7TpiOm0Tw6spYvaPrmic6Wux7RXUC1Y1iHajabEWZF6Yrf9U?=
 =?us-ascii?Q?1Gpulytn1ipMOypvIw6AaZ/0j0Jk5/NIi6jxjns635Qt+NiSSPP+hA8rIOqP?=
 =?us-ascii?Q?KJb0UL4h5OTH+g5cedkTHEiwml8QaHweLnn05AovNoCjUFikdIE8gxGiTnvK?=
 =?us-ascii?Q?flb4kJHwg7JOOr3KV5Tfn4lWdasn5JrU0QGuU4g5kS7kq+uwC69DLwZ7capK?=
 =?us-ascii?Q?wUb4O+4PSgHxAlPUsiCfKbyoooDQrco15OlIJvjZzaccU6zLlLpVmOk1xQIC?=
 =?us-ascii?Q?fJrzvv9MXXsI49DGFzIet6RcotTs8RAY+Uje2YmgUsjOOzL3Vwh/6O7aGrRv?=
 =?us-ascii?Q?2azDFgbg2oLh/Yu8wJr8p+ZsWA2AnexZKeXJ2CFFrtefDfOiThpdpgutfeYq?=
 =?us-ascii?Q?a2X8qgtNyl6N8LqZDOz7uankIUwLocz9tHnA2X9kxNGwUTs/PVUFfUBV66ll?=
 =?us-ascii?Q?ZlYVwbnqCpKaG5U/Dbyy64EWhok5xQezPyJUVg63lrtrPlBTK+FzCAk93JBU?=
 =?us-ascii?Q?7TjXTrGQJXi9DBdsTxEAvWOoRS6ob1lEw7PKFA+0HToUDbQCs/V6UJujhj+g?=
 =?us-ascii?Q?vk1OtkK0mCLlTgBaLwJWjzHbZI+sn7XN2fcG0v+4OZXY9Jw+xUFgKWKS49VK?=
 =?us-ascii?Q?3XykaHPf0nfFGvrv2inLjkAmvluzBH77yAiHtgQxL+8SDBcC6TUdZ7wLFyZo?=
 =?us-ascii?Q?S7FCAG/F7y03bjqnL8N2Xl8u1azj+uqsO/tXvSISnA=3D=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 581ca989-b3db-44f5-6a02-08dacc61bbcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2022 08:15:36.0441
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BLdyu6DeHImT6G2VCkGvBYaZL3alW1hLXgE81/J0S/T600Up1qH8R4/vDGT3m+guE7n7or/0lJL2gp3Livuxcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5229
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Bean Huo <beanhuo@micron.com>
>=20
> Take out the "map scatter-gather list to prdt" part of the code in
> ufshcd_map_sg and split it into a new function ufshcd_sgl_to_prdt.
>=20
> Signed-off-by: Bean Huo <beanhuo@micron.com>
A nit below.

Reviewed-by: Avri Altman <avri.altman@wdc.com>

> ---
>  drivers/ufs/core/ufshcd.c | 50 ++++++++++++++++++++++++---------------
>  1 file changed, 31 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c index
> 768cb49d269c..1b252e6cf93f 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -2399,38 +2399,30 @@ int ufshcd_send_uic_cmd(struct ufs_hba *hba,
> struct uic_command *uic_cmd)  }
>=20
>  /**
> - * ufshcd_map_sg - Map scatter-gather list to prdt
> - * @hba: per adapter instance
> - * @lrbp: pointer to local reference block
> - *
> - * Returns 0 in case of success, non-zero value in case of failure
> + * ufshcd_sgl_to_prdt - SG list to PRTD (Physical Region Description Tab=
le,
> 4DW format)
> + * @hba:       per-adapter instance
> + * @lrbp:      pointer to local reference block
> + * @sg_entries:        The number of sg lists actually used
> + * @sg_list:   Pointer to SG list
>   */
> -static int ufshcd_map_sg(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
> +static void ufshcd_sgl_to_prdt(struct ufs_hba *hba, struct ufshcd_lrb *l=
rbp,
> int sg_entries,
> +                              struct scatterlist *sg_list)
>  {
>         struct ufshcd_sg_entry *prd_table;
>         struct scatterlist *sg;
> -       struct scsi_cmnd *cmd;
> -       int sg_segments;
>         int i;
>=20
> -       cmd =3D lrbp->cmd;
> -       sg_segments =3D scsi_dma_map(cmd);
> -       if (sg_segments < 0)
> -               return sg_segments;
> -
> -       if (sg_segments) {
> +       if (sg_entries) {
>=20
>                 if (hba->quirks & UFSHCD_QUIRK_PRDT_BYTE_GRAN)
>                         lrbp->utr_descriptor_ptr->prd_table_length =3D
> -                               cpu_to_le16((sg_segments *
> -                                       sizeof(struct ufshcd_sg_entry)));
> +                               cpu_to_le16((sg_entries * sizeof(struct
> + ufshcd_sg_entry)));
>                 else
> -                       lrbp->utr_descriptor_ptr->prd_table_length =3D
> -                               cpu_to_le16(sg_segments);
> +                       lrbp->utr_descriptor_ptr->prd_table_length =3D
> + cpu_to_le16(sg_entries);
>=20
>                 prd_table =3D lrbp->ucd_prdt_ptr;
>=20
> -               scsi_for_each_sg(cmd, sg, sg_segments, i) {
> +               for_each_sg(sg_list, sg, sg_entries, i) {
>                         const unsigned int len =3D sg_dma_len(sg);
>=20
>                         /*
> @@ -2449,6 +2441,26 @@ static int ufshcd_map_sg(struct ufs_hba *hba,
> struct ufshcd_lrb *lrbp)
>         } else {
>                 lrbp->utr_descriptor_ptr->prd_table_length =3D 0;
>         }
> +}
> +
> +/**
> + * ufshcd_map_sg - Map scatter-gather list to prdt
> + * @hba: per adapter instance
> + * @lrbp: pointer to local reference block
> + *
> + * Returns 0 in case of success, non-zero value in case of failure  */
> +static int ufshcd_map_sg(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
> +{
> +       struct scsi_cmnd *cmd;
> +       int sg_segments;
> +
> +       cmd =3D lrbp->cmd;
> +       sg_segments =3D scsi_dma_map(cmd);
Maybe initialize in declaration?

> +       if (sg_segments < 0)
> +               return sg_segments;
> +
> +       ufshcd_sgl_to_prdt(hba, lrbp, sg_segments, scsi_sglist(cmd));
>=20
>         return 0;
>  }
> --
> 2.25.1

