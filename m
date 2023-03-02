Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A916A7C1C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 08:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjCBHxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 02:53:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCBHxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 02:53:05 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F955C66A;
        Wed,  1 Mar 2023 23:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677743580; x=1709279580;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DLHWcsIqCGWKTlybs8vaKjLBtaFFyDnDpmw3pTjlfIk=;
  b=ebvKcxytT8dnFbZCceyVH4idT9wZCxhWWx2YeNlxZjeyYHxbHnmHrUgh
   ncIzTo0UTxx+DxrbdjiQqMws/lnhhUsFUkhhF+4VLC6kmAGzhBUi3ovhD
   VW8R37R1WvESslosJ0VO10VkJQSvLt5wet+vBBlngoeLWZVydAvnmqn1M
   uD7QF99p3pWRvMddX83XMz6EBrbtWiIWV+W70sk0C/fanCuth2RFbueLi
   RD7dZQ0esCwK4jCmd6le6Dmnjd1myjo1bdfsp/Oe6a2D+SyWUAB3NNvcb
   AFqcDl0im5Ob9Kq/2D9UxdUgLC1GZwM1i1LMYessgbtotSe0qr5Gh8qAV
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,227,1673884800"; 
   d="scan'208";a="328930811"
Received: from mail-mw2nam10lp2104.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.104])
  by ob1.hgst.iphmx.com with ESMTP; 02 Mar 2023 15:52:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cktyq4qhwxVFi+FnfN8Si4Z3DFl/F9hF3mqAdps514ojywFnwoWr2Y51eK+c9Z+LEzbZcveu7XEelftNu/0CVu4HHhfy1AYngxzwD22W88aCU9hRpkRqcVOdA93c0ggYbH62kY98MFPvA2f/k/pf4uXdNNqSSVD3WSLgf3zOxzpl4KXY9M09e8HAq+QXppRDtXv+32PKR8vq1DVaoMssBa1uMRBETjQUjwj1/EmmgxrtdcXoyYvlq2n1BFEFXQfHhEkG/WTEtWmjFlL7JbEBg0CgInKt8kVMS+Dp6rAu6Bv1HWzn9yf4+sGZGiIVPdthQJLd5bulOeppuJAk6d7kOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DLHWcsIqCGWKTlybs8vaKjLBtaFFyDnDpmw3pTjlfIk=;
 b=QbtJsZPJKdubWVhz5OqR5JKz/Qpu8F/kuq7lbby7vwedEZHXmG+2IBeh59luoC8lGCGey39EtAa9hZU3Yr6GTf8qwwUf+YDHAF3oAb2LnHl9zA+Gn6KAuAAp2yfjKsEG+OW6+/jmqfplQpid5ZhKkeBAP9vklXDtvrNEXIDosFtg33E1wjkH6tBs8+3StAaNRC0WYvizni1Gudt6ZJgYnvYlz5BWtQkldShb6WM18S143lPgFhb8qr/8KmqFJkb8QnrgoL8dagz75oCQs5UyuBNr0iuSSQJsORFJwFkf0n32Do3T0e8SB7/Aq49OXb5/ATXwFUQtc8aGRMfH2OeiHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLHWcsIqCGWKTlybs8vaKjLBtaFFyDnDpmw3pTjlfIk=;
 b=t4Ho7FIh2ANxajh7l9SRVTjP27wOAERKqPjHp6JIYeDT+6otK1RMu6TZnBfb4yfU8ruaqlpeQbdU9EamXoNr1pen4pHgoDyWIzhZtddOahONHCUFgTyGMHksTkKL7+WJKz04rap56XLmzAwd/2gp2dHz8T0uNsYVDTwrVcrvVdA=
Received: from BY5PR04MB6327.namprd04.prod.outlook.com (2603:10b6:a03:1e8::20)
 by SJ0PR04MB7472.namprd04.prod.outlook.com (2603:10b6:a03:294::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Thu, 2 Mar
 2023 07:52:57 +0000
Received: from BY5PR04MB6327.namprd04.prod.outlook.com
 ([fe80::d4d7:5772:65c9:e4d1]) by BY5PR04MB6327.namprd04.prod.outlook.com
 ([fe80::d4d7:5772:65c9:e4d1%2]) with mapi id 15.20.6156.018; Thu, 2 Mar 2023
 07:52:57 +0000
From:   Arthur Simchaev <Arthur.Simchaev@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "beanhuo@micron.com" <beanhuo@micron.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] include: uapi: scsi: Change utp_upiu_query struct
Thread-Topic: [PATCH 1/2] include: uapi: scsi: Change utp_upiu_query struct
Thread-Index: AQHZRtAnEVxdCbOh6UqEvS4KnyORTa7bFjkAgAfhZ3CAABSDgIACqcwQgACYCgCAANxAoA==
Date:   Thu, 2 Mar 2023 07:52:56 +0000
Message-ID: <BY5PR04MB6327A013D41E595F7A21A4F7EDB29@BY5PR04MB6327.namprd04.prod.outlook.com>
References: <1677078770-30994-1-git-send-email-Arthur.Simchaev@wdc.com>
 <1677078770-30994-2-git-send-email-Arthur.Simchaev@wdc.com>
 <b1f0ed44-d707-5593-7449-8a6bd23c9902@acm.org>
 <BY5PR04MB632717453EB0D403388B4F1EEDAF9@BY5PR04MB6327.namprd04.prod.outlook.com>
 <21f73bfd-1d91-106f-d3a8-eb4674c517e6@acm.org>
 <BY5PR04MB632701F87296BEE554D3F055EDAD9@BY5PR04MB6327.namprd04.prod.outlook.com>
 <e6518637-4e78-3935-133d-79afea67cf80@acm.org>
In-Reply-To: <e6518637-4e78-3935-133d-79afea67cf80@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR04MB6327:EE_|SJ0PR04MB7472:EE_
x-ms-office365-filtering-correlation-id: 26416ee9-1c46-4f6d-8bd3-08db1af322f6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9zstEJ0Cj4sCbJVxGUiHPHA985Igp2qwQnLNqcGAcn2FGiO9LCxUoGbkZsAeuYaqqq/L2cD23IAhLzxqFn3l35uyDX4ORM8DC6sXC1gosUzbifWURs2pDhhjBd4YRjlBWro+/tEooZHu0LqnZmfNdBOZAoFaSKsiHBeJaA3Ybddxjvh2Uuk0IK94Kt8XjGLOjDbsJjRgJBj77jNyz9rz3qeKcvRXihTR1P51EaGMJEWoB0igfXXQ9J+JdUOdOAdODluKzPn41UdUAcG99jT/mQoSmymsNlhB1mteHgGF6sUgQITShWhfaPWmWviZTlne3EgYtF5WRoKe4e7bzfXj2po7zFonFpPuQ/bRDB+K9CeNW7oZ1pjex+SM2RS1PSm6C5tVAe1rJ8OI62/s45Ww9YRaf/m0eyl1Pd8Q3lBo+LyZKav47yjTRTqx5ktpULJHIt53NqwMclwxI+hC21eXluUaCFGhozhu3dlROkixC9gAXNA6/HyBk9E2Alvke47dM89ldl1yrYbxuvekpCEI0B3Zuj0Uf8GtfpDZ8pKRzcP8TEuqRTb5N++IHqq/eyCv0O5wc4CmBX1mM2Djr4IciyzrJt796UOU4pPFjEKMp7IVP8BzukIFUKs8n2Ypw1Fvlnry3pw6tOZgO1REgiEHli+AHymjfGKCBwJ/AhJvTUYaeXhf0wDQsr+nL9w4YfMaVkWz8kaqj0jICsxhKJ5Acg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6327.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(346002)(366004)(39860400002)(396003)(451199018)(53546011)(6506007)(26005)(9686003)(186003)(316002)(41300700001)(110136005)(54906003)(4326008)(76116006)(66946007)(64756008)(66446008)(66476007)(66556008)(8676002)(7696005)(2906002)(71200400001)(52536014)(8936002)(5660300002)(478600001)(82960400001)(122000001)(38100700002)(86362001)(55016003)(33656002)(38070700005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VGN3YS8wNFdiOEJ4TXArVllsVEdkV2U0VXUzZm9EYmtWcGt6RmVtbkR2Wlln?=
 =?utf-8?B?RDljVmNLQldDWE1sTmNzYVNKUC9BOHRPTC9EUm1wckk3Y2ZWSHZqalZUSlBI?=
 =?utf-8?B?dVMzaDBMamZQSERKKzgrcC9TdjVYY25tNHk5aFNFaEhBTjVtUEJaamFiTVJr?=
 =?utf-8?B?ZnF2N1crQ2NmR3QxMnptWlhuYWUrbXFpcTFFZGRWOEJ1b0k4M2IyeEFXbmQ5?=
 =?utf-8?B?TWZDMG55ZzR0UlpmUlFENnFKT0lZRTEvV3VvVUxZR0ZuUkoxejEvbVlmTzZB?=
 =?utf-8?B?cENBaXlTVzVEaXN3cEViUy9Uc1FrczM0Zk1TNkFES0dpOUJRTlU0Vk1mVEkw?=
 =?utf-8?B?T3dJWGp6YzJ2cFdrZmF2NVZpN2hmdDJKcHZ0dXd3bWVIT2x2alppZGJmOHl4?=
 =?utf-8?B?dGtYZFM2c0ZveFBYS2Rxa3R6eUhNR1pLNUUyNDNwczNRV3N0WVJpN1RBV1hC?=
 =?utf-8?B?dWNEWUtHaGxzc2UxOTlpUmhuWXBtazlTK21RazZYUE9mSFlzWDBPZFNpVHpR?=
 =?utf-8?B?T1pRVy9sakJzb2hyUVpNOVUzZ1QvdmdKN0FkMjkwOGptaGR5aXNUOWRwS3Rp?=
 =?utf-8?B?ZU8wa1ZJc05mQVcrdG9jbWpUdUxiakRaRmJXeGZaaDJITUN3SnQ0ZHlObkY5?=
 =?utf-8?B?aEhrNWpxTTBsbW42MWJNNklUdGlUc1UweWlTVkptTGozR3VXVW1Nalk1QUg0?=
 =?utf-8?B?WjRwRS9ESDM2eFBLMVhDZzhwbzVwdE9MTWhtdVI4WEpHY2RKRDJzdFdiRDBr?=
 =?utf-8?B?TUh2R3A1NVNGV0M5R2N0OXZIclRqWmt3WmV0UTFnM0lsTEpzQ3Bwc1lJV2lI?=
 =?utf-8?B?SmhVbTZzNndQYlc5UTh2VElyQmUrb28rZW1qV0tDYlBtWE5YNVpEc2Jnb3FG?=
 =?utf-8?B?a0pEekNWUUVVZVlVSnE0VkpGYVprM0E3ek1DQWc5RERPOXV0M21veU9aN1Ry?=
 =?utf-8?B?dFlYcnJFdXdFVUpkVTFvandsMkh2ekN4RnJndDJxcVJFSXd2cnFkYmhYc2E1?=
 =?utf-8?B?WnpJZTBLaVR5U2hyVG1lMFh4a2pxRTZrdjRqZWpaUmdxUXRMQ3JOd25hZXRr?=
 =?utf-8?B?MDdPK2M0S3NMNytFTjYrMmU4dzFiUkV0Sk1FOUF4YnMxM1kzMmhUYkgxUE9t?=
 =?utf-8?B?blkyR3pjWW9Ccy9SR0I2RDdKS251SGtDTFVRMjdndHhKaEtYd1hXakthT3Ex?=
 =?utf-8?B?RlNmeFhKK1lpWjE2aCtkcHE0dWphVDBvUEl2VW5BMlFLMDJsWXdTSDZoVDE0?=
 =?utf-8?B?ZHVkZm9HN3lCeXFjK1R2alh6Sk42ZE80V25SOFhLL2JlQk5pRHB6MDgvMHpi?=
 =?utf-8?B?TitKdkttLzZDd2pleG5kRi9PVlJXc0Z0UUkwTEFaWk1ZVHVpY092WmdYZTBO?=
 =?utf-8?B?cTU3WFhiSlR0bE5pNm5GNXoydGY0WWlibFYyTTlPZGh5QXFNditYd01WeTlt?=
 =?utf-8?B?VldMN3ZIa0ZGclcxWDNaL3lnWkMzQkNiWTFlb1NhazJvbm9qdnhrZFBJd0RJ?=
 =?utf-8?B?bnVsRnJuSjE0Si9LY3dHN3lpVGdGQW9oOFRsZVd4OU02dnU3cTFmb21CUWhH?=
 =?utf-8?B?WUIrcHgveTZYQ0RZYXhkTzJyanNLejllb2s2SXZYaDB6VmF4YlhwelNuK0Nt?=
 =?utf-8?B?UUxoS3dIcWRHM3FKbEQrV3ozdnJVSFIzYVRBbjgwMXBqQmFmUXgxV3AyNy9I?=
 =?utf-8?B?emdMcldnWmdORXJIelVzaE9ydld6TXFLSDRselI3UXhPZDk1YjlJRjJpMHJk?=
 =?utf-8?B?SXg2ZTlMdUpGZzh6TzFBamxyOXZRM1FPSUdDaUprR2habzhpeDFTaXBUOXM5?=
 =?utf-8?B?RXlTOWswNjJmYkI4UFJUMlVkT0E4MExxMHRqd0ZjdjBCemtnZHVWbjJMVS9R?=
 =?utf-8?B?S2RpMFhHVS9EVVVVMEExWVF3OGkyMk9TUjN4SXg4dGl2cXhwa2NRRDEwYjlh?=
 =?utf-8?B?UkZYVEkxSHJQdjRrODZsOU1OTldaSEZYcUpsMHpjbHhLMnBaeFBLbEhHVTFj?=
 =?utf-8?B?QjJKNWpmdzVLb3RYMDZ6OU5peWRkZm5vOHAzOGt4dDhQeWtsZE50N0ovYWZo?=
 =?utf-8?B?VTZlOXQ0a1BWcWYzVldJT1g1eWY5WjhvbWdvSzdibUkwTHB1Ykc3ZHJKVWlT?=
 =?utf-8?Q?pKUBDJuOHF0PI7jQ7nzRWm/Li?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vJIALCdlvLJQX/VB3UN9Ql5ZjrMY891gobdYkRXc+Stmn/NLBkYaE6F/+UpVYLpxoGxkd9gttomGs9lE5yKQQHhhx38JTWeFSiR4UpmNfxCL/HXA8ut2e5JVxDOjgtWjzNg7VSrfFirKR0Vmd0/i+PJwphYQsht81sEzy8lDPAIOFQLfM3nniDAvX8NnFdrHcNXI9l4UmJh5VAaIj7p+rnZKD5JIn87Zg8PkWcsrMW5bUutuuFOPsNpX9bVK9nxrfkxZpkPh91JIbjsQpliFg1TnUQXrgz6/KsdQ5TTnxrOPvtTENEoriWU0+Tya1QFJ24mgALvxg0TukTQTEEk5Zv5C8WIqKXBRGkgVYwEoPyCypPO7afcBS2sdeucPAN8uRAHImcDb4cJQoWunMURQFDPGa8HUSnls00k3z/gcilQ/Viyav8Kv59L9bNA+IHzhzefPE7DssZ2XxbkaZ9/nhtEaiYpEHiZSehOUhz0PL/QyuxPoxNYXe5hTIOqxAJjaDZAnYbg9iuuzNaVd5w5tITXtmO9VgLbY273ZEvd5W+wKGMyaOSpDZ2Q5SfZOEM70KuuoDl+1lBLJyPRH20G2zb3RIP5QBmDrX/vbK3yGB0c7uoYRvFN+7nU2rTlI7n89rKPir7pGLxQ82Tz/DOBg/T4DPtEyyH2CrNKaDbwWiZdyTWdVtrdWvFKHbxmn4tbtYPV8JoeZodn6NCKeFQVN5X0EwUWRs7vk1Q1hZ6w14+PWTF3+E3F9lGFv8kMd4YjvP1uQHOijyxi1sx9tBOWHra4w9Fr+ebg1ifaWdO02JHBk1k+Iah70qOZOoF+HIec5wqPyLP7y7QcG+2H67lYII7U4GC+MldVIfoY7ovpTDpA=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6327.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26416ee9-1c46-4f6d-8bd3-08db1af322f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 07:52:56.8390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N/zS+W+oXd+Qk1H/zG8BFgoZfkOVMeHDaQC0pLwDMsAneeqtLIUn7kBF0T1eITsxRpxw//D97+abjPoyKmdDBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7472
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBIaSBBcnRodXIsDQo+IA0KPiBJIGRvdWJ0IHRoYXQgcmVuYW1pbmcgc3RydWN0dXJlIG1lbWJl
cnMgaXMgYWNjZXB0YWJsZSBmb3IgVUFQSSBoZWFkZXJzLg0KPiBIb3cgYWJvdXQgaW50cm9kdWNp
bmcgYSBzZWNvbmQgc3RydWN0IG5leHQgdG8gdGhlIHV0cF91cGl1X3F1ZXJ5IHN0cnVjdD8NCj4g
DQo+IFRoYW5rcywNCj4gDQo+IEJhcnQuDQoNCkRvbmUNCg0KUmVnYXJkcw0KQXJ0aHVyDQoNCj4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmFydCBWYW4gQXNzY2hlIDxidmFu
YXNzY2hlQGFjbS5vcmc+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTWFyY2ggMSwgMjAyMyA4OjQ0IFBN
DQo+IFRvOiBBcnRodXIgU2ltY2hhZXYgPEFydGh1ci5TaW1jaGFldkB3ZGMuY29tPjsNCj4gbWFy
dGluLnBldGVyc2VuQG9yYWNsZS5jb20NCj4gQ2M6IGJlYW5odW9AbWljcm9uLmNvbTsgbGludXgt
c2NzaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8yXSBpbmNsdWRlOiB1YXBpOiBzY3NpOiBDaGFuZ2UgdXRw
X3VwaXVfcXVlcnkgc3RydWN0DQo+IA0KPiBDQVVUSU9OOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQg
ZnJvbSBvdXRzaWRlIG9mIFdlc3Rlcm4gRGlnaXRhbC4gRG8gbm90IGNsaWNrDQo+IG9uIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSByZWNvZ25pemUgdGhlIHNlbmRlciBhbmQg
a25vdyB0aGF0DQo+IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+IA0KPiANCj4gT24gMy8xLzIzIDAx
OjQ2LCBBcnRodXIgU2ltY2hhZXYgd3JvdGU6DQo+ID4+Pj4+ICAgIHN0cnVjdCB1dHBfdXBpdV9x
dWVyeSB7DQo+ID4+Pj4+ICAgICAgX191OCBvcGNvZGU7DQo+ID4+Pj4+ICAgICAgX191OCBpZG47
DQo+ID4+Pj4+ICAgICAgX191OCBpbmRleDsNCj4gPj4+Pj4gICAgICBfX3U4IHNlbGVjdG9yOw0K
PiA+Pj4+PiAtICAgX19iZTE2IHJlc2VydmVkX29zZjsNCj4gPj4+Pj4gLSAgIF9fYmUxNiBsZW5n
dGg7DQo+ID4+Pj4+IC0gICBfX2JlMzIgdmFsdWU7DQo+ID4+Pj4+IC0gICBfX2JlMzIgcmVzZXJ2
ZWRbMl07DQo+ID4+Pj4+ICsgICBfX3U4IG9zZjM7DQo+ID4+Pj4+ICsgICBfX3U4IG9zZjQ7DQo+
ID4+Pj4+ICsgICBfX2JlMTYgb3NmNTsNCj4gPj4+Pj4gKyAgIF9fYmUzMiBvc2Y2Ow0KPiA+Pj4+
PiArICAgX19iZTMyIG9zZjc7DQo+ID4+Pj4+ICAgIH07DQo+ID4+Pj4gQWxsIGNoYW5nZXMgaW4g
VUFQSSBoZWFkZXJzIG11c3QgYmUgYmFja3dhcmRzIGNvbXBhdGlibGUuIFRoZSBhYm92ZQ0KPiA+
PiBkb2Vzbid0IGxvb2sgbGlrZSBhIGJhY2t3YXJkcyBjb21wYXRpYmxlIGNoYW5nZSB0byBtZS4N
Cj4gPj4+DQo+ID4+PiBUaGlzIEFQSSB3YXMgb3JpZ2luYWxseSBpbnZlbnRlZCB0byBzdXBwb3J0
IHVmcy1ic2cuDQo+ID4+PiBBRkFJSywgdWZzLXV0aWxzIGlzIHRoZSBvbmx5IGFwcCB0aGF0IG1h
a2VzIHVzZSBvZiB0aGlzIEFQSSwNCj4gPj4+IGFuZCBpdCBkb2Vzbid0IGRpZyBpbnRvIHN0cnVj
dCB1dHBfdXBpdV9xdWVyeSBpbm5lciBmaWVsZHMuDQo+ID4+DQo+ID4+IFRoYXQgZG9lcyBub3Qg
bWF0Y2ggd2hhdCBJIHNlZS4gSSBzZWUgdGhhdCBjb2RlIGluIHVmcy11dGlscyBhY2Nlc3Nlcw0K
PiA+PiB0aGUgJ2xlbmd0aCcgYW5kICd2YWx1ZScgbWVtYmVycyBvZiB0aGUgYWJvdmUgZGF0YSBz
dHJ1Y3R1cmUuDQo+ID4+DQo+ID4+IFBsZWFzZSBmb2xsb3cgdGhlIHJ1bGVzIGZvciBVQVBJIGhl
YWRlciBmaWxlcy4NCj4gPj4NCj4gPj4gVGhhbmtzLA0KPiA+Pg0KPiA+PiBCYXJ0Lg0KPiA+DQo+
ID4gWW91IGFyZSByaWdodCAsIG15IGZhdWx0Lg0KPiA+IEFueXdheSwgSXQganVzdCByZXR1cm4g
cmVzZXJ2ZWQgZmllbGQgdG8gdGhlIHN0cnVjdC4NCj4gPiBBbHNvIEkgY2FuIHVwZGF0ZSB0aGUg
dG9vbCBhY2NvcmRpbmdseS4gSW5zdGVhZCBsZW5ndGggYW5kIHZhbHVlIGZpZWxkcywNCj4gPiB1
c2luZyBvc2Y1IGFuZCBvc2Y2Lg0KPiA+IEluIHRoaXMgY2FzZSB3ZSB3aWxsIGtlZXAgaXQgYmFj
a3dhcmQgY29tcGF0aWJsZS4NCj4gPiBJcyBpdCBPSz8NCj4gDQo+IEhpIEFydGh1ciwNCj4gDQo+
IEkgZG91YnQgdGhhdCByZW5hbWluZyBzdHJ1Y3R1cmUgbWVtYmVycyBpcyBhY2NlcHRhYmxlIGZv
ciBVQVBJIGhlYWRlcnMuDQo+IEhvdyBhYm91dCBpbnRyb2R1Y2luZyBhIHNlY29uZCBzdHJ1Y3Qg
bmV4dCB0byB0aGUgdXRwX3VwaXVfcXVlcnkgc3RydWN0Pw0KPiANCj4gVGhhbmtzLA0KPiANCj4g
QmFydC4NCg0K
