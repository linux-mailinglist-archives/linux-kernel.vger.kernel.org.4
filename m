Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA2A658AE5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 10:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbiL2JVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 04:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233024AbiL2JVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 04:21:37 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA24DEC9;
        Thu, 29 Dec 2022 01:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1672305695; x=1703841695;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rDAKCj/+nJPt4wrLI3njDht8uBuM9vKRyQnvWjCxJg4=;
  b=rT9OkNh/t04l1ucqzPLv+jCcmwRprtNFhX+9DRCslNVwBbNZOhJBkO3X
   2XbXEvBkZrD6JZcV6Ium43vm66YvbKNcbkjjdCYpRepOLrIDIj7xzfE5W
   +2o52i4U8VUrBI91ihAmbGUoXMuA+XmU6CeKehBwF9+i4ESffmVfeTNtD
   CImKTcYNBW32O8Yp0fp8OJKlzPUWWyKa12XclMFPM+M93Zih7ou5rr/bL
   koESYHj+p2Ey6NiZsBhnsxP4aUI/ZqCWXS9o+3XxaFIsdYiYOENWZxyZK
   BJaKhh/JqEbe6ZqUNji0ePDuNr/tWnJjX+14ZDcxJxdJNNAsdpGQAhkIT
   A==;
X-IronPort-AV: E=Sophos;i="5.96,283,1665417600"; 
   d="scan'208";a="219816182"
Received: from mail-mw2nam04lp2168.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.168])
  by ob1.hgst.iphmx.com with ESMTP; 29 Dec 2022 17:21:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=agNVaswsQkt/apsfG/WA0mpe3etNpSr4OaNBP7MfF47gob01wF9eFqkyG+Yz8lgteifGX66ZVeVgH1QuxOO/cvpJjxvVUgCqUaXbUiZUAjp/SZ1UBbISQGY96mFZkeFwPPchM4WsrjiEFpmROnfvj6lU0+fRyaY/I/knxpJ5/0h1p/ucBr9v5lg7E7x8PIRCLAVypsRAKbMEBmoK+RiAbLmEq5BI790BsGu054djnfJtERoFRfgCFDWDDZObHGVGrymxQlJGPXJXgP2jBzRVrCRqclVBAZsq287OoPdr6bcjJuB4P21sIi0rrnKPk3v/p7rDsMtAP0qnd2sCEj9elQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ijBdbRRRE+r7QfJpkgRJGUs35Mmu53LUjBlOOg0U0XY=;
 b=mfTauq/AiGskFmP7eQE71RGG2fU9QFG8kx6FEtgdPB32q6ObmfqxWxc7aCvdWnQryJCdmvNoEQ/FfmPTP5O57aVTaxHzW9GvDW4GBu7vPzeOjv0ft60opKXQAYvxCzQLYDElzU4v9W/tUmjEJqw1wMfB638di0+RjES2ahC1RrYhlrN2WVm+EZ1wEKj5ZQ9Skc1jnpYGChFEILCbjfXCgFmb5XpxNHFPgKcnOJJ9tZn/yiLQYZKNkEjCh45efeqOc2kv5EBPmXutR2HZmiSKFLoqgXI5HWcu8mBrZWLpfYUwKkgnnf0fL+XmEjpQX8OU7kLVm32O/C9XJLcJk8nFbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijBdbRRRE+r7QfJpkgRJGUs35Mmu53LUjBlOOg0U0XY=;
 b=OGHfyOy/AMVAVbf2a5GBDuIRnPUG8enUL0x2LpTrlvpU/57/xItHMmS+9qdrkB9AhFVJa64udGG+aMbdpSETDgn44ZlXlV0HDsZWXUiibiLEybhLAmIQpQI4sKCxNHYbkUJwWkJ+gNorMco1zvJzUfOSLY7nT3wMhiGu3CsrQd8=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by DM5PR04MB0861.namprd04.prod.outlook.com (2603:10b6:3:fa::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.16; Thu, 29 Dec 2022 09:21:32 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::a65a:f2ad:4c7b:3164]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::a65a:f2ad:4c7b:3164%4]) with mapi id 15.20.5944.016; Thu, 29 Dec 2022
 09:21:32 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Wu Bo <wubo40@huawei.com>
CC:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "qiuchangqi.qiu@huawei.com" <qiuchangqi.qiu@huawei.com>,
        Wenchao Hao <haowenchao@huawei.com>,
        "chenchunxiao@huawei.com" <chenchunxiao@huawei.com>
Subject: Re: [RFC PATCH] ata: libata-eh: Retry the cmnd when normal complete
 occurrd after scsi timeout
Thread-Topic: [RFC PATCH] ata: libata-eh: Retry the cmnd when normal complete
 occurrd after scsi timeout
Thread-Index: AQHZGuYWLF0ErbPJak+5UhizCm3L1q6EMmCAgABls4A=
Date:   Thu, 29 Dec 2022 09:21:32 +0000
Message-ID: <Y61cG14nVB8j8Yax@x1-carbon>
References: <1672220216-46938-1-git-send-email-wubo40@huawei.com>
 <Y6yD7Jy0vNr2ZAmE@x1-carbon>
 <703686f3-19aa-eb15-dd54-00f463e6e620@huawei.com>
In-Reply-To: <703686f3-19aa-eb15-dd54-00f463e6e620@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|DM5PR04MB0861:EE_
x-ms-office365-filtering-correlation-id: d485c34d-f2f3-4add-a7c0-08dae97e1343
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BncWAZLOX2Zm8QRZlTR5WWap+vzVtGmNlN3AMsmsJKVjjIjpwFANzB114uL0ZlgM2AYa5JltM5IcIWKRO8bMQuVsEd6h2N+U5jm560u3H2FnKn6MGAMuE3C2Z805fpIt+m9tdD7k3IM/JfPCAouFCYULfxoO3WQX6lAOSkIeOSgg1D1L5hVi7fc8drhsggdOUQlHm+/FU4wQtW8fcqWMeTSSqJCx6ywXtAju2oxN8jbg7MsWw+qSkWWPDXVPxytqEvdyZua7+fzhObiK1X21meTrNgLfnt/0czgUrU8UIgOWm8gx6TfvXpydU5TXXxHvAuxkET4fAYlhyhusnaOBH0CGK0p5VSij/6C0ekrJJKIk8YmkiPSUxWAalO4QywlYlMwWySfT2O5LEjErGpASo7J0CIopQOHbiPNG4CK0fP2zQLPpVys4qH5/kFPY6yfy68NNGERBVMTb+KVmLjWul6QxTP3CPqDzZ4ZHLCWand4qE7LAYgm8ZS6TuXcSEPP2yGpnLtXoQ2RCh07ehN8Q5s9kapN3N7mRScmvypnOYEhrcLEaFTI1ER0B7ovBXZPehF4PdPbyGpXvJiy3Fw9TkKkzmkQTEca76GP8EbIhwJDvxuO5GiocoNm4+qTWZPeEh+lsDLDFbf84Sv/bhJnnjfjOchJjSleidIze5TAfx9aDaxrFroKdDZO+3fWUPtql27w8oLXvVlfK226QBXBWZQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(39860400002)(376002)(366004)(396003)(346002)(136003)(451199015)(6916009)(83380400001)(54906003)(71200400001)(316002)(2906002)(38070700005)(478600001)(38100700002)(122000001)(82960400001)(9686003)(6512007)(6506007)(186003)(26005)(6486002)(33716001)(4326008)(76116006)(8676002)(66476007)(64756008)(66556008)(66446008)(66946007)(86362001)(41300700001)(8936002)(5660300002)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DDY29k4XDB1vwCaCI5/eh0QzQCtnzVHo3eKYq/HyyU+nY/10bYWGgD1IteBP?=
 =?us-ascii?Q?XSZ887eNIxvfA/zs2zpb7h9eqpkI1W3Cs9tVbkVxDK4YIKXgI0rFjGPivsFY?=
 =?us-ascii?Q?lhqbYsFj1zJa9PEWPLuq5wuJ/JW/5ti/xdzhO59DKhmZvc9PjAV7jw+K9fPk?=
 =?us-ascii?Q?PjDRJXE1kfsyeR2lzV0+RAQvEZQ26jyvgeJL4AhWStPBW+BQq7vkN2FIXMdA?=
 =?us-ascii?Q?JOMv2PbNxfKi9hcmNZztk1i4Kxm3YPDwvOCZJgqVUQtyT5yjrUh/93FtSv5N?=
 =?us-ascii?Q?f5jdd+fh7ulBaUM2DztpkbWmx5kUQVkMxIn9yqzhKXovk8nWKirH/3lnaVy3?=
 =?us-ascii?Q?rHD33Ch5vGnEEga6v5qpYxTmFkOUbZwrUd+mui22eGUIwdxMcQ9nlY94nJP6?=
 =?us-ascii?Q?QQOOYHHX3TxPbRl12WFOKbnHFJCBCgF2o6xbQGRiUQHGXr7lhSWc4whMk+/X?=
 =?us-ascii?Q?m/cBnzlPKGaftH9bZBAOUOOAJVZN+zPOfLOXRx5DQnKl4F9OcOwQzUYH3P6z?=
 =?us-ascii?Q?UIaPQhe6mDdlfdWz62YXrFJZSKx2NnAWiPUOgsucvgWHvg4ujTK8IAjdjUAk?=
 =?us-ascii?Q?D7f2vLYMEtLE/4X3kQRRyJNIzwuMYIFlKXVTd3aAgkUC+f3QPkHtrejGz4Gc?=
 =?us-ascii?Q?SNBrNsPl1OS2Vorjv2U07pmGGAwGFm16zTY4z3YrbBtUkTafeh764bzp26bq?=
 =?us-ascii?Q?rcxJ7/p4M4um/aBt6gMb2r+UJZ7DpFRfdPkNs2XdNmiuzwj2b20Oh0jROfLj?=
 =?us-ascii?Q?ULU/ge5FKWGGknCQ/tBDtqQ3bHKi0Z+EcLqDu8sai+UJ3nqCTCp4JdTUVq7q?=
 =?us-ascii?Q?vNnFB9hCHH43OEx9Tzecm7Q5HO5i80GAYp9IRVD4i6oIuis1YxMNaXEUtG1A?=
 =?us-ascii?Q?mvyRcHTG8VXqlzrnU4hwAA8s4at/YHrQSUqLkZtUkq5LuQM0YmZo/pZciM0w?=
 =?us-ascii?Q?pZH6H81uR8jQqhM1mQVH5+ZuBiSlwaG+IfhaW1oaBV4BXlFfU8JaZSc4/mCs?=
 =?us-ascii?Q?VLhkMgcNKsU2darcaECDUxbhZaXrsPmZIc9ZKrQtZ6AQnIFjblNZHWkdggBr?=
 =?us-ascii?Q?OcJfb4W7Wb2SHrIuBYfwJZ6sb8tkhQDVZ1AqzgSwIu1kJe7DR/sXIhHNfR1X?=
 =?us-ascii?Q?wySxFt79OXL/H4MZ7shf+C101a+0PLiYdqEzjulBnfI3HaeoYydEu4LV4DZR?=
 =?us-ascii?Q?pyOQMnD+6roeJChLKTi3ZnB8B44rdBtkzm0LQE6FjcDQawVMOQQp1l9981mO?=
 =?us-ascii?Q?zlxignWigJKumG2UBOZ6k+Tk0LiFTq/VoFKT4rTfCqf0Kk4dzI+dGS/sOIhe?=
 =?us-ascii?Q?wk20vhX6d8A2ynGGx7ycHCmFF6WNA/4X7czgFWK7oOajrqp6wu91iiuXwmNW?=
 =?us-ascii?Q?3W8uOxMQSyUMp39qzg89ar20eCFPwntcTCAKTMN3aXCWuWn+3EqLmGuLAvyu?=
 =?us-ascii?Q?3NiLBrOC8lUll3L60ekD2/yjujJVNlByCMjpRIQxMCaVKtcTbPzwUXzluy8Y?=
 =?us-ascii?Q?OQ93CWgFHlDjx0jOfFW9QlkF9gdZ8Ik5L47Ytd2k3IP84GGZiMGe6atibK0W?=
 =?us-ascii?Q?1Qc366OJ0woigp0WdntGHctLvs/+/uGA9mur+KK0pVpzD7tJ05t7qiTVbeJw?=
 =?us-ascii?Q?7g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7040D0AB4B63FC4FA84CC1FBE8CCBC65@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d485c34d-f2f3-4add-a7c0-08dae97e1343
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2022 09:21:32.4073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4105Bf0vUvlSo31CL+aOdKh9IthRsfb9zg7R7c30IFFZ9goivUzjbA/TDfifiCWMdnCZjR4BmmwiDExZ5R2OrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0861
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2022 at 11:17:31AM +0800, Wu Bo wrote:
>=20
> Hi Niklas,
>=20
> Thanks for your detailed reply.
>=20
> The case where SCSI timeout wins,
> but there came a normal completion occurred after the SCSI timeout.
> in this scenario, The EH process cannot get the command status
> from the IRQ handler process.
>=20
> If the command is not retried, it can only be returned to the upper layer
> with timeout state.

So the possible scenarios are:
1) command completed normally via IRQ handler
2) command completed with error via the IRQ hander

3) SCSI timeout, which is by default 30 seconds. No IRQ came for this speci=
fic
   QC for 30 seconds. You should always get a completion for a command
   even if it is error. If the HBA did not send an IRQ for this specific QC
   for 30 seconds, it is obviously misbehaving. libata will reset the HBA,
   and outstanding QCs will be retried.
4) SCSI timeout, so no IRQ came for this specific QC for 30 seconds, so EH =
gets
   scheduled for this QC, however it takes some milliseconds before the EH
   thread starts running, and then it needs to call the EH ->eh_strategy_ha=
ndler()
   (ata_scsi_error()) which takes the ap->lock.
   Between the time EH gets scheduled and the ap->lock gets acquired,
   there comes a completion via the IRQ handler that completes the
   command normally.
5) Same as 4) but the IRQ handler completes the command with error.

Note that 4) and 5) are very rare cases.
3) is way more common than 4) and 5).

>=20
> Log as fllows:
> sd 1:0:0:0: [sda] tag#30 scsi_eh_1: flush retry cmd, scmd->retries:3,
> scmd->allowed:2
> sd 1:0:0:0: [sda] tag#30 FAILED Result: hostbyte=3DDID_OK
> driverbyte=3DDRIVER_TIMEOUT
> sd 1:0:0:0: [sda] tag#30 CDB: Read(10) 28 00 07 5e e6 7b 00 00 01 00
> print_req_error: I/O error, dev sda, sector 123659899

How do you know that this is for scenario 4) ?
You have no prints of the IRQ handler, and the QCs it completed.

To me, it actually looks like scenario 3),
especially since you have "flush retry cmd".

In scenario 3), timed out commands will be retried after the HBA is reset.
Do you see that the HBA gets reset in your log?

If it was scenario 4) or 5) I would have expected a "flush finish cmd"
print instead of a "flush retry cmd" print.


Kind regards,
Niklas=
