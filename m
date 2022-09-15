Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB305B92FC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 05:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiIODRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 23:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbiIODRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 23:17:12 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastusazon11011010.outbound.protection.outlook.com [52.101.52.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591F5923EB
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 20:17:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cZQHd0o0iHCPbSa6MptxS+S+tCvOgNu7S3Pbruj3g/xw6tRPXqgZ9osfNkmEhjtI+wkFuePwazOjYY2OGFiZuXNj+6mIVHvpbzIFw8fAXBHuNlfE6iGmispXOlgOc6EOkbWJOmzxFjhky0M8JXJFMxtnr6TwiM57tmu1OHecvRjr+AYieiBEYVVlYXx4yQ2NL+v0icwsjavdheGnix9kSYK2eN+iLxP7zm0owR7VSFh3Ox/Cxt/EvD1y8MB0JJvL6xSEedoRRdn7JK+38079sXP2S3ynUXLj4Wokwz1IJ3G8dRTtnIg57cbKwiY2hlELBnByIqONGI65ijXFLbO3dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JdiP4Xx4+71vLUZWUd35hsaboXzwLURBdd5ydQLT7ec=;
 b=K1PV2RxUxLYhjubgFLNfsf4jngggLdZ6YFoO8vPIb/f6OWfZX+cM+mr8w4S+WSdRFkKr3EiOu8mn45iz4+rmY+kmv+vdZgnefv9oazeBRMcqWTXdZx4XZ5uGeNjtIgDdzaC9o0qNsRP5YG6ybsDkQUPrJ2xRZkhRe8HZqZgTnY4dUtIpFAJonjwuKcIXHrLnhJfAvaFOl97IN1HYhN5pyB4Vf1HtWGe038GxcqFLWYC0Bo2j5EasWJYVI7rog1gTTH9MThwGe6juvP6kJn/D1iX/yBoCTM2m06buzEdHOzIp81YiJlb7pQqp3QgWiKFybXYQASMd91GZ0MKFPwTOjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JdiP4Xx4+71vLUZWUd35hsaboXzwLURBdd5ydQLT7ec=;
 b=SJyTph4EM7hfa1sM1sXCGMqHLg6BzZhWryCeD5ECYxY9/aaJUnYN7pR2TCNWqve+u0/8VCO4U99DiwETOLv+xemp8dkfz5K4YoSxBOFc0SxafRX8ol8egPtIgZeWerIQqyUGB+/r4fKJe2I/sLnvDbvbXKN3eEtdHqUnhIsrmpI=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by BYAPR05MB6023.namprd05.prod.outlook.com (2603:10b6:a03:d7::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.6; Thu, 15 Sep
 2022 03:16:57 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::e46:a7cf:acd:c835]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::e46:a7cf:acd:c835%2]) with mapi id 15.20.5632.012; Thu, 15 Sep 2022
 03:16:57 +0000
From:   Nadav Amit <namit@vmware.com>
To:     kernel test robot <lkp@intel.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Pv-drivers <Pv-drivers@vmware.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/3] vmw_balloon: open-code vmballoon_compaction_init()
Thread-Topic: [PATCH 3/3] vmw_balloon: open-code vmballoon_compaction_init()
Thread-Index: AQHYx5TLVyq0nPBSpkqswgx/xHaB5K3fnnUAgAA1mQA=
Date:   Thu, 15 Sep 2022 03:16:57 +0000
Message-ID: <BCFE7B8C-761E-4513-90BD-FCA0A2E64D13@vmware.com>
References: <20220913094306.317734-4-namit@vmware.com>
 <202209150729.vb9gopf2-lkp@intel.com>
In-Reply-To: <202209150729.vb9gopf2-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8531:EE_|BYAPR05MB6023:EE_
x-ms-office365-filtering-correlation-id: 1b612ee8-6324-4231-3638-08da96c8bf35
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D9po3+bfXVyh/q5RWqcm/+DXcKTM91rLiefelSiGpleSv0j0Ps+o0ehXPy2woqtSzXKqg3IzD1+34A0ZIb/flmpv/L0bio6nNzn/FjkI/TUjji5KnjBGZjzfvC4Znt4YgjGkOCWjATAxSxRB6FAUczSubnmf3Dh+piuXQPws5gV0Gw0cXh8tj1ChXwaOQW5hw6e0tCrtSbDgRCI/HWZxWqtc5iUlqpHxZfq0iHbvDelogSXwIzHJcqWczVzW+6jh+oBgo1w9Bzi+E1I0jP9cWTrL9u/bqmbwTVK/J0CwVhYve4ot+XdPUSGg2ExNHCfqFBHZ+VNafNQvGKc197Lut9VXiz595xEXLoc5fyiGGJmBi/TPugA/TrpI08Fwce9jKhWMCWFNxuJpcJ9uTwI4YEDLM56NAaGhlqGa+Mr58ujL/rXcHfZWSyhuSw+poPakDRnCM1Dd+JqWTMghBLmtuifLsIYU9Yg0DkV5ycvIegH7BQX3R8emZiGFa2mGzffKWXkYNWoQ5IjgYoaMGgGxy9q62V86OikNguhBry5hp/V+wxcOjsLnQTiv4uVXYXrrnmlECULBp4FJI3UXoVlCpQ1wO67elxVCICmppbg6/dD/0sW8shZzw0OH7RUEF4dXM0/xjgF5maZqlNpm/ZHVs8P2jlRFJJNVTvvM7qYklNF7bEBHJNJAGoJT+if1Jh+q37WFHzUnHxwcEoLS4Y1Rqnv+lWeQ8JWIG6xyu3rGersxfOGNa1DbFp8yrqZ2LSjGG+f8dViKaCfVf0fPHrNOSm5NBCRu9YN7u+BdUspu/WNvIAguvWtUozafgdnGs4NZH4ZNZtYbF8ecapcgUJRjsi+nEwuPZUE7zeU15IW5q+E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199015)(6486002)(8936002)(6512007)(36756003)(66946007)(5660300002)(558084003)(186003)(478600001)(38100700002)(26005)(122000001)(6506007)(66446008)(41300700001)(71200400001)(2616005)(4326008)(8676002)(86362001)(64756008)(66556008)(33656002)(54906003)(316002)(6916009)(38070700005)(76116006)(66476007)(2906002)(53546011)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWRGdmxoSXVEUXNmTEtIL3N0ZzRGcnplQlhaT1pyM1pURGU5Z0ltOUROR0pV?=
 =?utf-8?B?bnZTZ3NSZ242Z0MrTGZIYnY0U0xwcGNwYThEckdZc3JUVGVnRldsaENpN0I1?=
 =?utf-8?B?blBndWNLbnJTU3djVUxORVZHNzFmeVV2SWU2QlBqV1dicXZQRHZOT0tSTmxa?=
 =?utf-8?B?TmFPRy9PQmp3Y0N0anZJZzB6RWwzLzlTaFZlZEJsVU1RTk5FajEwa09SdHg3?=
 =?utf-8?B?YXNXWjZWZDBsZDNkZGFrN1Y1bHNZNTkrd0s5ZWpKL0o3QW1VWDd6Z05PczBJ?=
 =?utf-8?B?QTQ0NzdJSXdMczMyNkpCUUxSRmI5US9uNTc4Ym9PU3p4T3VvQ1paZkYrTUY1?=
 =?utf-8?B?MlF3L201TVFaRmVkWXRkUm5RREF1QjhWZ3hjblVDYzJRaGpXOTFqWm9xNjZU?=
 =?utf-8?B?VmI0byt6TEk3YS82UzhmRzN3TWgzY21vUE1MblcxSDRhZWJja0E5SGJIQ01R?=
 =?utf-8?B?U3VZbTlWQkRuZzBxYk9ycy9GMHc5WmtnMnI1YXRybFpaTDFXTlJEUHREWjY2?=
 =?utf-8?B?YUdlY3k1WkxBRXFJU05sK1NWaUU5bU8yNmdyTENqcndHbndOSTZndWFwNita?=
 =?utf-8?B?dzNhdUtLRHVMRnRGaE5FZjBoOW5WekdKTFc2UUpGNmRISU8xK0o2eXMrQmJx?=
 =?utf-8?B?S3d5YXR3TzF1cHlHbXVGT3Q0c241SzNzM0psRkpSS2RTUnJNQ3h1a3BZNW4x?=
 =?utf-8?B?NFQ0SGl3QklOZ1RUK0dldTNzaytvZW9sZ1JrM0JheWRjb05QTkJMallUTnNn?=
 =?utf-8?B?UVNlOWRiZXpDbngrSlB3WXlOVW1zTjFYZnZmZGNHSExwMVZwUGNLOU9IbGhy?=
 =?utf-8?B?U1lBQW45Z29NZnNyRnl6VlljZTI2M2dvSmhOS2xyU1prY0lPb1paeW56cjBs?=
 =?utf-8?B?a3Rka0Yvc0k4dHR1dW93OVJzdWN3WVFZSUZZZnNucHp1TkU4dTlkWFpkQWhF?=
 =?utf-8?B?dVFienpEd2kzVkdaaFVpSkZ1YWJOL1JLa3BWbkp6akQzOGdNbmlPRjF2ZFZh?=
 =?utf-8?B?TVo3NTRIRVJmWVJ2Lytla2oyYVFPNHFmLzNNNS91Z2dyTlZKZUFENytwcWZk?=
 =?utf-8?B?ZGNycEtiUG9IMktmUVZpMHBkbklzdGM3MzBsbC9NTSs5dTZ5eFprWkFSYlYx?=
 =?utf-8?B?TGtSMXRoYTB5cytZSk5JTjdrZlpCKzN1ZGlnOStnY043dEt5VExMd3hhbDJx?=
 =?utf-8?B?TkVjVGhDWHh6QmxwUko0SFhud3UrL1U2eW8wL2VhYnJtZkQ0TUdraEN1R3pt?=
 =?utf-8?B?ZzZoaFJPZlUyNTJGMU51Q011akp0TUxRTEdDandTbitpcC9sY3ZWNnl3SHc4?=
 =?utf-8?B?SGNmZWdYc1htMnlUb2lySGxOanc0ZG1oY2RoU0FQdTI0Rk5IRkhTQjg5RzZa?=
 =?utf-8?B?K1BmQWNRMVE3eEF4V213NkhGenBhRXFWRWVZa2l4aHdWb3dmUlZyUjdSa2NU?=
 =?utf-8?B?c3JKR0E0eVllVnNkQTd5U2FhNzlyc2lRelVXcUY1K2daNlV0MjQvL1FHY0x5?=
 =?utf-8?B?cTBVaFAwaW9NQnFDaWFFY3ZQN0xYTi9Ibzgwbm8rYkJvR3B2ZG5KT3VZZmUw?=
 =?utf-8?B?RE5qcXZuWWNEbjdRcklXcGNPby96RGNWUDlJbzQ4VjFaNTVrV25KY2lVT3BX?=
 =?utf-8?B?VXFIUTQ0TUtBeDl1N1dXVlpwcGdpb1BCMElORjMyY1ZTcDJiVGsveWVZZDAv?=
 =?utf-8?B?aVF1QU5xYmJBMDhvRVdhQms5TVloby92YWFEZWpuSGtEQzN3L3ZiZWlxT2Zr?=
 =?utf-8?B?dkpNemJDQ2IxZzRqakhTRHFyYTN0K0RBZTlYeVNBVkREUUp5Z3NYNzFEMkxz?=
 =?utf-8?B?TjZ2NGxQM0FzL2J6NXNoMjBzUHpnSW1QdlkrNW53MThZNFkxYzFFNUhISC9h?=
 =?utf-8?B?YU9EOE4yQityMVRrRlU1WTlWY2N6WExOMEQ4QmJMQjUzTXhPUDA3cXE1WXZH?=
 =?utf-8?B?RDN3b0oxZFlRMENYWVBkeEZPY3hyNHZZYlM5MUtkTWp0NExWejMreVdoVGQ0?=
 =?utf-8?B?UXR4SU5MeXBHc0tXRW9XODk1c05xTlhTdk10cGVhZkZpQXRGWDh0ZnBnbzYz?=
 =?utf-8?B?UHhNNWJ2dzVMRWg2R2MwNHZuTkVMY0tsV2JkWFVGbGdMcmhFWTE3bmNic1hU?=
 =?utf-8?Q?I6SS/WHJq/ALdt5xjmTlCr2XF?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C79AE1DC0C6F524BB18F01186382DDB5@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6023
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2VwIDE0LCAyMDIyLCBhdCA1OjA1IFBNLCBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVs
LmNvbT4gd3JvdGU6DQoNCj4g4pqgIEV4dGVybmFsIEVtYWlsDQo+IA0KPiBIaSBOYWRhdiwNCj4g
DQo+IEkgbG92ZSB5b3VyIHBhdGNoISBZZXQgc29tZXRoaW5nIHRvIGltcHJvdmU6DQoNClVnaC4g
TGFzdCBtaW51dGUgY2hhbmdlIGFuZCBteSBidWlsZCB3YXMgZG9uZSB3aXRob3V0IFZNV19CQUxM
T09OLg0KDQpTb3JyeS4gV2lsbCBzZW5kIHYyLg0KDQpSZWdhcmRzLA0KTmFkYXY=
