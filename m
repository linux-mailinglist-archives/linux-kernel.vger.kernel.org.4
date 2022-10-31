Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457B56132F0
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 10:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiJaJlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 05:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiJaJlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 05:41:13 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD75CCE24;
        Mon, 31 Oct 2022 02:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1667209272; x=1698745272;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ywYG627fhVC6rZGWwbWpmiXJBy/IKBlgmF+A1hJ1y3s=;
  b=y6i+giR9Ftp8WTkON06/6g1TzQN5LN6/7O5Q6NA6jbqaZws8pmUuqoaQ
   jxTQuI6bf6FaQul55ic+4cp/i6LWRii4Zkcwwq2EToaptyWIu/uGNx7yT
   anSfsdB2YSkJ8M6WjU7L0Covw/Yq7FTEr/XTxRJtZVd0frnk+Pdmcfugh
   FyAEkWX4S9loKZE0+uQQIhEWI/0iGSJwLTU3GlzQCnd+ia1CL9tW3bmUu
   eh/iLuW8TgEf3k6F5aiwKLjp9kLMPeZvlNYHQvzGoTSiNAt/Dh9zjkjYk
   qVbCqFrhdBlP8iLmejsQKoGFNKwyV0vv1PSIaY0Ccm+P8icKWzbWunaWT
   w==;
X-IronPort-AV: E=Sophos;i="5.95,227,1661842800"; 
   d="scan'208";a="187026610"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Oct 2022 02:41:11 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 31 Oct 2022 02:41:11 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Mon, 31 Oct 2022 02:41:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IWVmMTSK8hyGsGhprZOA0Y3VKNCtmeqq59IS1Qff/yjY0k1DxRgvp+C2UJb6/ITx7wDprUJgD0Ag871Y9/Ln3mZzsOS20UDlybYQw3gAkMKdm+r0VVARDUnVVeH4Kf3vaoMe2pG7J3wvwveJrBvJW5nE9k/niH1i/m9X/W2egzgwOpUmiXh9jPMj5Uhpi4X1TwFT1otnDwT/XLC3AzNJ13KjsV8XUWgdTMazrDprBaTu/HjO1CApLhpK3GheqCgFt3tVsK1T/hXKwGHEDQvV0tkMMLdtwyPdQc4sB0C4BFNMQt480e0B6Y4px6ulEV0BXC0NUztiEmBFH92JZLayPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ywYG627fhVC6rZGWwbWpmiXJBy/IKBlgmF+A1hJ1y3s=;
 b=SPuXgkMfiklE0I/s7fUkA1eaxxoQ6ESv8cJTEqWeEV7XTk6JhxL1T5ihyV+lKrsMRNIUMDrFmsQtO2V3LGzbUP0ZCRCA/o4oz9nfpa8cCcSJGMAZ0+K3rqz607nUfQny9pblPYTOYvxl10Ht6OXHKfSqlTb4iV/qv6JsxXYiseULLd57pkilwnKvSoAfrgYh01Lhlj/xtWG3zunaLAqAJKUVHwy+g+Un5fmMSLM0cvkxXqtLHzRNTh+PNYnIn2zCVRwHIq0uwhf3bYu7rRhDHukL2dXL0ZYDE+vjagi41cAkufBaSI5wnGRSgyII2IcswSwq7BXU4PprJ7ah6RyDZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywYG627fhVC6rZGWwbWpmiXJBy/IKBlgmF+A1hJ1y3s=;
 b=iHrPvQZkiChNa9/upwQHchi9PKG97hm4XhTh6p/oh7S1PhqC2r/IqsRVi2MPniGZ1FhjTr2c0HMzyM56Il+4AWbiyCig4upSS0C2OG/qhbAOr/nO35VbWO0tXg/wqGGnB6DSHDjXBsre2bun5WDecEwt7bgvaF9nUqKzeRKwxgQ=
Received: from PH0PR11MB5096.namprd11.prod.outlook.com (2603:10b6:510:3c::5)
 by MW4PR11MB5872.namprd11.prod.outlook.com (2603:10b6:303:169::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Mon, 31 Oct
 2022 09:41:01 +0000
Received: from PH0PR11MB5096.namprd11.prod.outlook.com
 ([fe80::1cfb:5030:3f7c:7add]) by PH0PR11MB5096.namprd11.prod.outlook.com
 ([fe80::1cfb:5030:3f7c:7add%7]) with mapi id 15.20.5769.019; Mon, 31 Oct 2022
 09:41:01 +0000
From:   <Tharunkumar.Pasumarthi@microchip.com>
To:     <andy.shevchenko@gmail.com>, <Kumaravel.Thiagarajan@microchip.com>
CC:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <ilpo.jarvinen@linux.intel.com>, <u.kleine-koenig@pengutronix.de>,
        <johan@kernel.org>, <wander@redhat.com>,
        <etremblay@distech-controls.com>, <macro@orcam.me.uk>,
        <geert+renesas@glider.be>, <jk@ozlabs.org>,
        <phil.edworthy@renesas.com>, <lukas@wunner.de>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH v2 tty-next 3/3] 8250: microchip: pci1xxxx: Add power
 management functions to quad-uart driver.
Thread-Topic: [PATCH v2 tty-next 3/3] 8250: microchip: pci1xxxx: Add power
 management functions to quad-uart driver.
Thread-Index: AQHY1V02yYultS77nEiXC6E78nq8Dq38ac+AgCwEkKA=
Date:   Mon, 31 Oct 2022 09:41:01 +0000
Message-ID: <PH0PR11MB5096A7794C7206C2F35685AB9B379@PH0PR11MB5096.namprd11.prod.outlook.com>
References: <20221001061507.3508603-1-kumaravel.thiagarajan@microchip.com>
 <20221001061507.3508603-4-kumaravel.thiagarajan@microchip.com>
 <CAHp75VdEJvG=BQvS2KVNY8BnjfHyOCO6ww0S4_gxVZNuhXaURg@mail.gmail.com>
In-Reply-To: <CAHp75VdEJvG=BQvS2KVNY8BnjfHyOCO6ww0S4_gxVZNuhXaURg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5096:EE_|MW4PR11MB5872:EE_
x-ms-office365-filtering-correlation-id: 969a0419-97e2-4c48-b287-08dabb240578
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5wbPUQpfeltSNTTYyiU3f9dOAUf22vBeDosIM+pD3Ca/M1duZQ3lXaiYf49MR4BSIQY1ytz6tutTqD2TmeGsOeiAwQhFp0Cd2HWJ0avcQ4FDYKZCfG8uPnVbVZ3pIFm09UPQno/0ngwijku+etDjbKPiDB1YIru+2ThzwTn8iZx68bd4hHiTkM27EXrnXFqKeDXiQIZnHIEII3pYhQsBjIV7/KVkEoCSe7yCkJ2nSKyTAq9GKRGtSu2SKYoMnmXOdQ3EAOicutahFpRyTQ6r+lr6dSNPlRN5cwJG5iAST5eOUiLPMJLLt2RLGoerj0P01QMuLfXmZDNSMayW4lLBZEs5Wpo+Kj391koUId/WXCxMXwvaQ1NVnBd6ntEcGh0zCr+gMn2yX9V4bFn/a3UXer5SUSnDuKOxDbccbRL/3WE2jHD3O01YevtxpWagegVxrSEpJBvrgHC6VmDcurDCcVj+75uLqfXr8gDispGEB3P8c7T4QY9pZa6EoRwtoJhY3eThb5hjOGjgrrH4GebuJKjHoJVbFug+qxQULklVcGZsd4G2nqVHBT+U/8YbOSQzvmgtC3R4W5So2XNCoDhKtLG4TFMTjfG+HhgIgyf/qivF6+RTO8VDsvQf00WUMd2vWMMh4lCr8Z38OITFevoR6qZg1rPopBE31vlzjxbVHW/3Ymj4erNAIr4vnkUdOZCaczL+Dxc65sZfQ4Q760/xxFwR1vCjlA4Y1M7xMMbjMV93Yk7ChQdiduyWwyTxxedfvHnjzPd/qKi7GiPVD3lLt5yJEObjwIMVpgp7qJrSXNEwBklugCqiiuKT06Sy+cmy9SipA/tILoIc/MAqj3i1myVoldmF86sS7tMUrSWCxZ8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5096.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(136003)(396003)(366004)(346002)(451199015)(53546011)(9686003)(107886003)(26005)(478600001)(71200400001)(6506007)(6636002)(110136005)(316002)(122000001)(86362001)(7696005)(38100700002)(54906003)(38070700005)(83380400001)(186003)(55016003)(33656002)(41300700001)(4744005)(8936002)(52536014)(5660300002)(2906002)(7416002)(66476007)(8676002)(66946007)(64756008)(4326008)(76116006)(66446008)(66556008)(32563001)(414714003)(473944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHBCMnhnTE0xb1ZaVjdPZkNCR2lxN25XUWJwMFkvbFpiejlmY0hRaEtVQTYx?=
 =?utf-8?B?ZnFCTEJjS0FncUUwME9JOUR5SThjd2RwYk8zWk1LMmdNSlpaV1o5WkFKNGkx?=
 =?utf-8?B?NTJDbXhmUndvOUJOZzNUdWtienBMQXYyNHduUjgvQUl6SkxwbEs1K3lJbHh5?=
 =?utf-8?B?cFpzVGoxdDVoWUpxN1VyNGpLV3FWaEpMdnZUekI4bFE2YWpYM0x4Sy9ITHd5?=
 =?utf-8?B?WDRsVTVhNkE1KzlJS1I2Wmk3cHBROHBuYkFkQjlUZ3lpU3NKN3ZnbUVmMThM?=
 =?utf-8?B?SDdVcTBFQ1A2d1kvcHVKSWNwcDFYcUVnei9KbUEyRTVwK1ArWGsvYk1yU1hY?=
 =?utf-8?B?MllCYis4YUFUWFkzb3FCdHdLd2tHckt5bWFBdlJrMDd1VDNyalhBUFAyTEtq?=
 =?utf-8?B?ZEdhWW9Rc1hCbGhQZTBNTEZ1eEl6WEdCS3NzYVpKMFRvMnZ1aHhQS0lwbFUx?=
 =?utf-8?B?TGY2SFB3OTBRZVZublhWZG1ydTkvRDByTG11OS9wU1pFeHEzbUNwY1NKcTRj?=
 =?utf-8?B?QjkvaG05U3JPQm9RTG1HTUhXK0tqUW1QdWY1QmxBazgwcHRVQW8vWThzMzRZ?=
 =?utf-8?B?WXVsbW9XdXVPa1FndnQ2MDM1MS9sM3VYUjYvQnBPQjhIV09rdm5BWW1XMmJw?=
 =?utf-8?B?dWpINk1PSlB1eldDVklURU5JZHY2NG05ZWRRVFNtbmVVcVNKc0ZhREF1S1FW?=
 =?utf-8?B?a20xNHYvVk1xRDljTElrV2g3SmtCazFIUTI3YzIvTkxBb2hLbmUrQW9tdFlI?=
 =?utf-8?B?VExEdFJJTGk4T3d5QkhpMUZPbTNNUnVSZDhiRUlaUXhCWTZ2eUp4d2lEK0lN?=
 =?utf-8?B?Z3ljZ2xsWlNRWGFIL3lEMWo5K3hwY3VwaEFTbThHOW5oNk8xdU1lWGJ2RDgr?=
 =?utf-8?B?OUM2cGQwSXkxTnh1bU41MnFKd1ZpUWtMdEpLOWc5NVBlczdBOHpOeVpDaE1F?=
 =?utf-8?B?ZThEWnJod1BiREc1cDNlSUJEM25zOXRNemM4RTIyTlRqakxBWHZaeFdZKzJD?=
 =?utf-8?B?OFBzcXBJNzYxNEpUL2dKK0cvV09TRDN2Z1RqR2ZSaGdUWlVMeVhoeERKSWhz?=
 =?utf-8?B?Z1ZkQjJKa1J6SmZHZC9KcmNHdHk1c05WS1l2RXVGZjNQelJXangzdWdIT3lY?=
 =?utf-8?B?UDBFR2d6RUhFSG5FbUcySTJYaTRpUDk0N3NlMnVSTFFkUTlzNkZzYVRISlp0?=
 =?utf-8?B?TjJoWXY5dGkzenZjdkZkaGgvaGRBWWRTUWNzdnQ3TG8rdDNRT0s3NTYvQURl?=
 =?utf-8?B?NkNVY3BDZnJtRzNVei9nbEFLVStZaXZraytUZlJieTYzc2ljOUxmUFdEbUNh?=
 =?utf-8?B?czRUck9zMXQ3SUxaQ2VrblVLMHRDb01JcjUzR2NjV2Z4SlF5ZDA4N3JPOCsv?=
 =?utf-8?B?OFIxeWxkMFlvR1hHcFZGNk5zSkhub1Y0UWhkTDJybnlpSzJrQzNrVVVSdjhV?=
 =?utf-8?B?Sktld0F5aW5yWWN1UURiOXg3RkozcWJVbDZycDJUWEloVHQ2bXNzNjA3NEg2?=
 =?utf-8?B?RkZHYkt5VGpwSHI1LzZYeXZqdUpHNUgxV1ZBaXI3aWY4S3RnN08xTERZTFRx?=
 =?utf-8?B?Z2Q1LzBPZnFCWXpHYzBqeTdxMFBuMS9nd2NXc29ma0c2SEdVak13YXpUNmJD?=
 =?utf-8?B?T0RkaDdKVmJRTk9zOEN4VWdsSjdyV0RjWmhYUWt3ZUt4VENLUk5ZR0VQVTQx?=
 =?utf-8?B?eHkrY0dWMkZXeEZ1WGJiVi9IbDVuNmdhbTY0cU5pMmlkMUhYT0NxdjB0ekVH?=
 =?utf-8?B?VDdhSnN4eW4zOHNoZG5NYmtUTzI4M2pWT0lzaS9PYUV3Nlk3aHZDbjQxbzhR?=
 =?utf-8?B?NzRFcTduZ2VpbXJOQWdna3Q2Z0U3cnJQL1I4b1dWZmw2eDBPWjV6VEJrRk9j?=
 =?utf-8?B?SnJCOEFCTWh3ZVdiQXovVFJVZGNsdHIwaEpFbUVuWXNaZDBRRUozSjB2dWNk?=
 =?utf-8?B?Wk1mQmQ1OG9BdEt6VFlrMDVRY2JkREJBV1BqQ0dYRTR0K0NQK2VURWxRSS81?=
 =?utf-8?B?UTkxYy9wUTdvcG83SkRKbWVDS2RSeGZ5amN2S2g2SDNtWGdKV0g1RUxXQ3pI?=
 =?utf-8?B?d0s2TXBoWkdlL3lCdWVIdlNPSDhpZHhyS0xRa3BGVG02QkorM0NlK1haN2tw?=
 =?utf-8?B?c2x3ZzZVaVVHcmx2ejFvazFxU3BqOWJQbFdzWU8xbVNVREJwaERXN3MyK3E4?=
 =?utf-8?Q?yvu1IkVelWKlquykAQqwB3E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5096.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 969a0419-97e2-4c48-b287-08dabb240578
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2022 09:41:01.0734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0kAgpM1oFscCJlntmhFzMnDRHAER8I+cniSyQBSZ5W2GCZbJoApYO41IoPdrj9er7CAi152oFdN1FvwTs2yVlPNc+2Fvtoz+V2caPB5pCPBN4V4as4NdS+NHXIpBLkWI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5872
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbmR5IFNoZXZjaGVua28gPGFu
ZHkuc2hldmNoZW5rb0BnbWFpbC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgT2N0b2JlciAzLCAyMDIy
IDI6NTcgUE0NCj4gVG86IEt1bWFyYXZlbCBUaGlhZ2FyYWphbiAtIEkyMTQxNw0KPiA8S3VtYXJh
dmVsLlRoaWFnYXJhamFuQG1pY3JvY2hpcC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIg
dHR5LW5leHQgMy8zXSA4MjUwOiBtaWNyb2NoaXA6IHBjaTF4eHh4OiBBZGQgcG93ZXINCj4gbWFu
YWdlbWVudCBmdW5jdGlvbnMgdG8gcXVhZC11YXJ0IGRyaXZlci4NCj4gDQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlDQo+IGNvbnRlbnQgaXMgc2FmZQ0KPiAgDQo+IElmIHlvdSBoYXZlIHNpbWlsYXJpdGll
cyB3aXRoIDgyNTBfcGNpLCBwcm9iYWJseSB5b3UgbmVlZCB0byBzcGxpdCBpdCB0bw0KPiA4MjUw
X3BjaWxpYi5jIGFuZCBzaGFyZS4gKFNlZSBob3cgODI1MF9kdyAvODI1MF9scHNzIGFyZSBkb25l
IGluIHRoYXQNCj4gc2Vuc2UuKQ0KDQpGdW5jdGlvbnMgcmVsYXRlZCB0byBzdXNwZW5kIGFuZCBy
ZXN1bWUgdXNlIHJlZ2lzdGVycyBzcGVjaWZpYyB0byBvdXIgSVAgd2hpY2ggb3RoZXIgZHJpdmVy
cyBjYW5ub3QgdXNlLiBJIHdpbGwgbW92ZSBmdW5jdGlvbnMgbGlrZSBwY2kxeHh4eF9zZXRfZGl2
aXNvciwgcGNpMXh4eHhfZ2V0X2Rpdmlzb3IsIHBjaTF4eHh4X3NldHVwX3BvcnQgYW5kIHBjaTF4
eHh4X3JzNDg1X2NvbmZpZyB0byBhIG5ldyBmaWxlLg0KDQpUaGFua3MsDQpUaGFydW4gS3VtYXIg
UA0K
