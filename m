Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820F25B5AE3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 15:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiILNJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 09:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiILNJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 09:09:51 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C632F5;
        Mon, 12 Sep 2022 06:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662988189; x=1694524189;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wHqNWo2IDrCxEJkoSsGfPIlVpzNgG44Eu+YcI5zllqM=;
  b=q4SlhIhI+v4ZcvWzfTx89WuqSIfP1+0n/0eMDJyZjYUNrChz6ayGtwpm
   DjSOQGFMDnJRWW9WH0H87Xy27KrJF977FXZ1Jl7Mf5pd83hZdRxZ+NJUe
   cfgMSncIVTFHO7gvAn4WMdumbIj/+qm5UasTv6fy2ybwQD7/HXHDz5oFB
   MbNFcP/NFuoYRGOwkLc0+eqdxF9xaiW6kUAhqhXvJokrjswbei+Jhbt5F
   UtDPKfxKHJulcK/9/glPns9c+Zy887omRPmvYr4ZDTVWy8bU+f8Tv9GgE
   1E4WyTFU0uY6dIg1JFkDtlrWPAJm8lAP+1gGGRL3uthpUGQuAmEV4J+LF
   w==;
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="190448267"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Sep 2022 06:09:47 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 12 Sep 2022 06:09:47 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Mon, 12 Sep 2022 06:09:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E/2RC0mbPJaOmAtWk9l9iUiiETQw9AfFOnO/9B5nSdb+8asMUJfU9VZc+zDfBHib59O0e6nXvQxI2SzTjsEnrWv5ZYqlSVJhg1aXWFZIiMjBwFZtJ0Sqpcp1XiPb9PRJLdFoTFsf8Z5vkP9SGMhseCEVL1TG0ZTu+OAS9UraUtNd1WrQtzMNTxApPKk6+KOdEKWwdki8IYd47qJhI3qeUCgIaiix4Z5JBpvsuFx08VImYAbvyfjzkdYAGD/nK4uB9yw178FxmZJIvRQoA+deUOONnf+gqclOadOpdP+HKnwo1Ls47of0KrroflCS7ev1rNN2/grrY+pBqVLqAm9iJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wHqNWo2IDrCxEJkoSsGfPIlVpzNgG44Eu+YcI5zllqM=;
 b=NYZw08IJIsGtOlROBXQIyYTSiMypD460+itz64pbgEXPSTyFkfpslu70T/T9Z+WXvxhhr4FkO0CgQaFWCZo5LzpsHzrqWx25JRbYgk944aAoxxuD4aTeS778S7FHJg92M1kuzpgJ+pcZht2dNgLDfBgL8iS19DKZmiqQ3cMVzsgT6VsUJFKVqM3BvTgfAB+TCwOp/fo5gS8DFF3SSz7BAJ9mBaCq7bp143paA408NtFnMMiNeCHemR8yWp7VXhD2Bytu/o4EtZP7GTlaLzaHJg13cRt4FBw+Y6sanXJC/Qizh52dnYpgu879GyExSG0/eXn2novy2m8NxHrmISZ4ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHqNWo2IDrCxEJkoSsGfPIlVpzNgG44Eu+YcI5zllqM=;
 b=Zb07Moph6059DD9Qy9avv+9iOV19BjUJ9GPfR35aMa+LBYojMge6ZMUINimbBcXLfII+nJG0IqaePGugFcVnwlaBu439GwFFONHPbZUTfQl+cahzBJzVNz2jgMnpfmvgMcIYWbn27h3FVKF9bAxhB8aRjIYMRimCrKSthayuI5w=
Received: from BYAPR11MB2758.namprd11.prod.outlook.com (2603:10b6:a02:c9::11)
 by CO1PR11MB5092.namprd11.prod.outlook.com (2603:10b6:303:6e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Mon, 12 Sep
 2022 13:09:44 +0000
Received: from BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::e8ff:82ac:b76d:c61c]) by BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::e8ff:82ac:b76d:c61c%4]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 13:09:44 +0000
From:   <Sergiu.Moga@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <robh@kernel.org>
CC:     <lee@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Claudiu.Beznea@microchip.com>, <richard.genoud@gmail.com>,
        <radu_nicolae.pirea@upb.ro>, <gregkh@linuxfoundation.org>,
        <broonie@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <jirislaby@kernel.org>, <admin@hifiphile.com>,
        <Kavyasree.Kotagiri@microchip.com>, <Tudor.Ambarus@microchip.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v2 06/13] dt-bindings: serial: atmel,at91-usart: Add
 SAM9260 compatibles to SAM9x60
Thread-Topic: [PATCH v2 06/13] dt-bindings: serial: atmel,at91-usart: Add
 SAM9260 compatibles to SAM9x60
Thread-Index: AQHYwfjCQbG755VmlEGUqK2TrhMH7a3VeaSAgAAuKICAAK1+AIAFHfCAgAAyC4CAACijAA==
Date:   Mon, 12 Sep 2022 13:09:44 +0000
Message-ID: <77d38e3f-6d8c-dbb1-2e66-c768d95b5e35@microchip.com>
References: <20220906135511.144725-1-sergiu.moga@microchip.com>
 <20220906135511.144725-7-sergiu.moga@microchip.com>
 <9aa29d74-b1fc-d00e-dee4-57f277a366ab@linaro.org>
 <c30cc112-0fb8-01e6-1bb8-eed7db0b9049@microchip.com>
 <20220909013644.GA3731620-robh@kernel.org>
 <b6b044f6-de87-e85b-0b51-e957b90622ab@microchip.com>
 <aa6d8c7d-1723-7674-2142-a5aafe30e570@linaro.org>
In-Reply-To: <aa6d8c7d-1723-7674-2142-a5aafe30e570@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB2758:EE_|CO1PR11MB5092:EE_
x-ms-office365-filtering-correlation-id: 5b1c7ac2-baa8-4e15-9a2a-08da94c00fc0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +bfcjxEOXSo9mHv9qpfZufWyVdioIqKYTEq7pD5fNhCWQgixNDU2C9gPzs81mwsiwHDSgK+ka1hrpicbdCleovZ5IzZiQsurD8uBHb66R5qfz/kfwB0Sti0gI2RIHAx2jt1DezxxPCTH9Fz0CdHcqE/exm/frVleAMgACGq3x20odawgDeGS4z8b9hd0PUseSZynNQQ22wyFv1LEPMN/BKeLP4qDpHs4Nf96IdDDJQZ8uZ4rAqECFwLbxbNZnhG3AfeQC0InM4d3gYoBQUt2o4unx5O65mKTWt6as1QejHGZ0MVgGsTKk97T/4RkamqVg2gyF1QNGd6IuUMHJs5Ad6uz4IWywEEbe0HTD5PIPwx06kMTcMJpZCw7WdgWIwJW5nQB91MTLHAcK6mZyw6fOWox3X+pCc8k/1fP3IJ/4CNHtrFYpjOFjCrRr9bOW4vFFBCs0J2nqtEiPQw9RWnpqBddvodHWcxaBLhtR9bvcK8Dcw4I3HgRdfee0rqKBgV6gBrduifTeCko7Y9KrRaMYSg5OVwwsfSzSc06yyTT+25MUECekmAw9lgd0P+wTgIhISVu98NZQi9iZEs+eEE+zZQ+DyLkaFypinS0bDoVqTFW0DC7gPekrgPnIVjedhjh+tPkStmxVtCttkD8rwUdVV5JmHQFz/4jL6Ha9YnxKYH+o4PEWb/sKBYtEgDNEQ0fJ5S4lXVsEIXuHs1so5bh5GzDuGt+a2/U6dal3bjOhM12SRNd04rc6Rhxqn/0JL/S62dT1XUReXtfLsuyK7FhiSEio4BqhjOaigMxuYTX99U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2758.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(376002)(39860400002)(396003)(366004)(6506007)(186003)(2616005)(7416002)(2906002)(5660300002)(8936002)(76116006)(91956017)(4326008)(8676002)(64756008)(66446008)(66556008)(66476007)(66946007)(53546011)(86362001)(36756003)(31686004)(83380400001)(41300700001)(26005)(478600001)(6486002)(6512007)(54906003)(38070700005)(122000001)(31696002)(110136005)(38100700002)(71200400001)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SXBGaEs4UnV6bWRtU3M1TFEyUWUweTBUc1lNRnBCMy9sRWVNOS9LWUFyS24v?=
 =?utf-8?B?cDI0SnQveldSRUFsZlZodFNtRU8xeTBRSkVOb2pZcC9XSGRnblB2bDlBME95?=
 =?utf-8?B?OHl6eFNFWFBFQ29PTWR5NnUxSTk1TVVzNU0wSnI5ckhVTEpIUno5dHJOSkNS?=
 =?utf-8?B?NFRZODVZTXdUUW1LV1k5dlYzY3d2alJKbkNkZWtJYnZLbVBDckxqeWNUWjNw?=
 =?utf-8?B?YVRRK0MxbkVzNkxmeG9rMC9OamtjYmdUMmh2RFIvdFNoaWdWeVV5YnQ1ZXFr?=
 =?utf-8?B?NlRNclovY3ZuV3c4azZYK2hHemZuMEl6SlJQTHRHYTQ1SlE1YnExcUw2cStq?=
 =?utf-8?B?aWQ0WVA5ckZ1Y1dmVXRxc291TWZoTi80eWNRNzZXNit0OE5qc0t4ODlHRW1Q?=
 =?utf-8?B?Tk9TU05qV2pJRForYm4yUEd6cXkwRnZKK3p4VUpHNmZoaUZ4MUwwUlcvQUtq?=
 =?utf-8?B?UHNZOEk5WU16YUlUUVFNOGExRFlqRHhvMWJTZ2ZjWno4Z2twSWFRYXlJM05V?=
 =?utf-8?B?RHNWM2N3VHZBK1A0endhT0k3ZXNxL05xbVVOcHFnbkV1S01vMWNpdXkzNFBO?=
 =?utf-8?B?cGFVQ1FxZ3BIWHRDcnhUNGlqWUFpS1d5MG1CM29hRW9YT0Mra091aVlkbWZr?=
 =?utf-8?B?MVRtWSt2SWRlNTlPcVJsbnhkYldyWm01VTBlZ1hPVko0bmt6dUg3a2FIcHhD?=
 =?utf-8?B?TTM2dytLbTc1SHg5dGZSblppRWtEOTNsdi9ZV2NLV3hTZjc2dW9VcUZES09t?=
 =?utf-8?B?OFdGbU9yUGxMY3MwK3VUYkVBOVloYjZtQVU2NFV6L2QxV1N3WHNyM2Zjenoy?=
 =?utf-8?B?UXBXZnlZNW9MOU5LalplVmlQOVdNcmdQamJSWFRzTFJqK2VHYzNPK011TUNr?=
 =?utf-8?B?c21OUXZxT3ZCaGJIN0JtYk5LS2JEZ2pGZEJDSnFmcjRLQnpScnlIWkhNalJK?=
 =?utf-8?B?dWI1SnZRekx1WlF2SElRekhsQyt2bTFQLy9LaUh1ZEFRY2l5THp1VGRqLzhO?=
 =?utf-8?B?M0c4Qy8wMkdTWkdtWXQvc1R3eU1oTlhxMUppdUlhNytCZVYzZjBKSU9FV2Rk?=
 =?utf-8?B?MjJUczFJYmxvZUkvUG5UNnk5Mk96dVprSndVMGp3UGFrZ1Z3NGtKNkg1YmEx?=
 =?utf-8?B?elB3SWozcVNuWlVYRU5sVnZsenpMTkIvSVl1aTNWMWVQakNyMUxIZHRRcHJs?=
 =?utf-8?B?Zk9ZNjVLVVQ4N2lhdFdidGM1d1Juc2hqMzRMR2hKRUdhK3RsUC9adFhBaGdQ?=
 =?utf-8?B?L1QxNHlPNVdSZ3kxWkRkYUF3a3VJKzZGR28rZDRVcTFpTC9FenhSREoyK1RD?=
 =?utf-8?B?b3RwcFUvK052azRJWTRDd29VYUpQSEFXSmNJdDN0SFd6d1JwZzNPOXVRS2tM?=
 =?utf-8?B?bHpaL2pDOW9TMm9BMTZsc3MxaHdRODhneVBkWk5nL090dEhrWlZlUXhBNzBu?=
 =?utf-8?B?aDd5anYzRkhnOXAxNHJzeDRWcEwwOEN6VmI3V1g5TG9XM201TitHV3h6LzdS?=
 =?utf-8?B?aHN2VUZwTHFTMEpzWm5uek1Bd3R2Z1d1VkQ3dWpnTVBZT2ZwNTRiTTMvT2pG?=
 =?utf-8?B?YkdVRDQ5dGVZOThHVWdYU1NXR2d5WmxWK3Zkbnh2OUFIcmlCRkowanZxSG1Q?=
 =?utf-8?B?NFY1ZSt1ODJxQUtROWFwUWFmVGZLRW9jN01oZGtsWitxWFBsUkNITU5mUFJ4?=
 =?utf-8?B?NldyUzVvempOQTlETjZBWnFIOXdhaDBwQTVQRk56RTV6T25RL1dFbDdYY1VN?=
 =?utf-8?B?RmVKM3hLQ0IySm9VVEducUIrOFhaYjZ5MzV3VWNoMDVuNWd6a1EzTjhqQWlH?=
 =?utf-8?B?OG5QVlIxcFRVZXErSmJNa0F1Q204OExzRlkwMVdDZmdYZWdwK3JnWmxsbXlm?=
 =?utf-8?B?a01YTnh2emJ0c3VaeExTaWh1UUtKUE85dzRFTGpMZEZXblZBaDRVUWdSeXdi?=
 =?utf-8?B?QTVKbkQ4WTlVR2oyZCtsK2F5R3JiMFlROEl3dnFzM21TM1VJYm9QK3dZamM1?=
 =?utf-8?B?SmNGL3ZRSmQ1NzlsUGJ0eGtEdnkrUGg4Rm1sYnRzYlhDdnJwRUJSbCtZd3VJ?=
 =?utf-8?B?MjZxVTc0SmVKY2Q4YUJMU3NMUXJKTC9GQjVvanRZMThzUi96eUhoNmwreVBr?=
 =?utf-8?Q?booU5CPbK3x3TM2hJbu/O/Xvx?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A2A5CB7DE2E2EC4D87C993422056F923@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2758.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b1c7ac2-baa8-4e15-9a2a-08da94c00fc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2022 13:09:44.5102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LsSH7eEYs8LQUyGBwQYbVHonKClCn4qnsFshoOqYjM9/vbdvpjNorwUntmv75PjIm0leLoz2AtIm4fwY0U2Cn21HUOPHdUhswcaM6tngaVg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5092
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIuMDkuMjAyMiAxMzo0NCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gT24gMTIv
MDkvMjAyMiAwOTo0NSwgU2VyZ2l1Lk1vZ2FAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+IE9uIDA5
LjA5LjIwMjIgMDQ6MzYsIFJvYiBIZXJyaW5nIHdyb3RlOg0KPj4+IE9uIFRodSwgU2VwIDA4LCAy
MDIyIGF0IDAzOjE1OjQ0UE0gKzAwMDAsIFNlcmdpdS5Nb2dhQG1pY3JvY2hpcC5jb20gd3JvdGU6
DQo+Pj4+IE9uIDA4LjA5LjIwMjIgMTU6MzAsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+
Pj4+PiBPbiAwNi8wOS8yMDIyIDE1OjU1LCBTZXJnaXUgTW9nYSB3cm90ZToNCj4+Pj4+PiBBZGQg
dGhlIEFUOTFTQU05MjYwIHNlcmlhbCBjb21wYXRpYmxlcyB0byB0aGUgbGlzdCBvZiBTQU05WDYw
IGNvbXBhdGlibGVzDQo+Pj4+Pj4gaW4gb3JkZXIgdG8gaGlnaGxpZ2h0IHRoZSBpbmNyZW1lbnRh
bCBjaGFyYWN0ZXJpc3RpY3Mgb2YgdGhlIFNBTTlYNjANCj4+Pj4+PiBzZXJpYWwgSVAuDQo+Pj4+
Pj4NCj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBTZXJnaXUgTW9nYSA8c2VyZ2l1Lm1vZ2FAbWljcm9j
aGlwLmNvbT4NCj4+Pj4+PiAtLS0NCj4+Pj4+Pg0KPj4+Pj4+DQo+Pj4+Pj4gdjEgLT4gdjI6DQo+
Pj4+Pj4gLSBOb3RoaW5nLCB0aGlzIHBhdGNoIHdhcyBub3QgaGVyZSBiZWZvcmUNCj4+Pj4+Pg0K
Pj4+Pj4+DQo+Pj4+Pj4gICAgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zZXJp
YWwvYXRtZWwsYXQ5MS11c2FydC55YW1sIHwgMiArKw0KPj4+Pj4+ICAgICAxIGZpbGUgY2hhbmdl
ZCwgMiBpbnNlcnRpb25zKCspDQo+Pj4+Pj4NCj4+Pj4+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NlcmlhbC9hdG1lbCxhdDkxLXVzYXJ0LnlhbWwgYi9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc2VyaWFsL2F0bWVsLGF0OTEtdXNhcnQu
eWFtbA0KPj4+Pj4+IGluZGV4IGIyNTUzNWI3YTRkMi4uNGQ4MDAwNjk2M2M3IDEwMDY0NA0KPj4+
Pj4+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zZXJpYWwvYXRtZWws
YXQ5MS11c2FydC55YW1sDQo+Pj4+Pj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3NlcmlhbC9hdG1lbCxhdDkxLXVzYXJ0LnlhbWwNCj4+Pj4+PiBAQCAtMjYsNiArMjYs
OCBAQCBwcm9wZXJ0aWVzOg0KPj4+Pj4+ICAgICAgICAgICAtIGl0ZW1zOg0KPj4+Pj4+ICAgICAg
ICAgICAgICAgLSBjb25zdDogbWljcm9jaGlwLHNhbTl4NjAtZGJndQ0KPj4+Pj4+ICAgICAgICAg
ICAgICAgLSBjb25zdDogbWljcm9jaGlwLHNhbTl4NjAtdXNhcnQNCj4+Pj4+PiArICAgICAgICAg
IC0gY29uc3Q6IGF0bWVsLGF0OTFzYW05MjYwLWRiZ3UNCj4+Pj4+PiArICAgICAgICAgIC0gY29u
c3Q6IGF0bWVsLGF0OTFzYW05MjYwLXVzYXJ0DQo+Pj4+Pg0KPj4+Pj4gVGhpcyBpcyB3ZWlyZC4g
WW91IHNheSBpbiBjb21taXQgbXNnIHRvICJoaWdobGlnaHQgdGhlIGluY3JlbWVudGFsDQo+Pj4+
PiBjaGFyYWN0ZXJpc3RpY3MiIGJ1dCB5b3UgYmFzaWNhbGx5IGNoYW5nZSBoZXJlIGV4aXN0aW5n
IGNvbXBhdGlibGVzLg0KPj4+Pg0KPj4+Pg0KPj4+PiBEb2VzICJzaG93IHRoYXQgdGhleSBhcmUg
aW5jcmVtZW50YWwgSVAncyIgc291bmQgYmV0dGVyIHRoZW4/DQo+Pj4+DQo+Pj4+DQo+Pj4+PiBU
aGlzIGlzIG5vdCBlbnVtLCBidXQgYSBsaXN0Lg0KPj4+Pj4NCj4+Pj4NCj4+Pj4NCj4+Pj4gV2hh
dCBkbyB5b3UgbWVhbiBieSB0aGlzPyBJIGtub3cgaXQgaXMgYSBsaXN0LCBJIHNwZWNpZmllZCBz
byBpbiB0aGUNCj4+Pj4gY29tbWl0IG1lc3NhZ2UuDQo+Pj4NCj4+PiBZb3UgYXJlIHNheWluZyB0
aGF0IGNvbXBhdGlibGUgbXVzdCBiZSBleGFjdGx5IHRoZSA0IHN0cmluZ3MgYWJvdmUgaW4NCj4+
PiB0aGUgb3JkZXIgbGlzdGVkLiBZb3UgbmVlZCBhbm90aGVyIGVudHJ5IHdpdGggYW5vdGhlciAn
aXRlbXMnIGxpc3QuDQo+Pj4NCj4+PiBSb2INCj4+DQo+Pg0KPj4gVGhhdCBpcyB3aGF0IHdhcyBp
bnRlbmRlZCB0aG91Z2g6IGEgbGlzdCBvZiB0aGUgNCBjb21wYXRpYmxlcyBpbiB0aGF0DQo+PiBl
eGFjdCBvcmRlci4gVGhlIDR0aCBwYXRjaCBvZiB0aGlzIHNlcmllcyBhbHNvIGVuc3VyZXMgdGhh
dCBhbGwgOXg2MA0KPj4gbm9kZXMgaGF2ZSB0aGF0IGV4YWN0IGxpc3Qgb2YgNCBjb21wYXRpYmxl
cy4NCj4gDQo+IFRoZSBjb21taXQgbXNnIHN1Z2dlc3Qgb3RoZXJ3aXNlIC0gdHdvIG9wdGlvbnMs
IGJlY2F1c2UgaXQgaXMNCj4gaW5jcmVtZW50YWwuLi4gQnV0IHRoaXMgb25lIGlzIG5vdCByZWFs
bHkgaW5jcmVtZW50YWwgLSB5b3UgcmVxdWlyZSB0aGlzDQo+IG9uZSwgb25seSBvbmUsIGNvbmZp
Z3VyYXRpb24uIEl0J3MgaW4gZ2VuZXJhbCBmaW5lLCBidXQgY29tbWl0IG1zZw0KPiBzaG91bGQg
cmVmbGVjdCB3aGF0IHlvdSBhcmUgcmVhbGx5IGludGVuZCB0byBkbyBoZXJlIGFuZCB3aHkgeW91
IGFyZQ0KPiBkb2luZyBpdC4NCj4gDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0K
DQoNCk15IGFwb2xvZ2llcywgSSBzdGlsbCBkbyBub3QgdW5kZXJzdGFuZCB3aGF0IGlzIHdyb25n
IHdpdGggdGhlIGNvbW1pdCANCm1lc3NhZ2UuIE15IGludGVudGlvbiB3YXMgdG8gZW5zdXJlIHRo
YXQgZXZlcnkgOXg2MCB1c2FydCBjb21wYXRpYmxlIGlzIA0KZm9sbG93ZWQgYnkgdGhlIDkyNjAg
Y29tcGF0aWJsZXMgYmVjYXVzZSB0aGUgOXg2MCBzZXJpYWwgSVAgaXMgYW4gDQppbXByb3ZlbWVu
dCBvdmVyIHRoZSA5MjYwIG9uZS4gV291bGQgeW91IHByZWZlciBpdCB0byBiZSBqdXN0IHRoZSBm
aXJzdCANCnBhcnQgb2YgdGhlIGNvbW1pdCBtZXNzYWdlOiBgQWRkIHRoZSBBVDkxU0FNOTI2MCBz
ZXJpYWwgY29tcGF0aWJsZXMgdG8gDQp0aGUgbGlzdCBvZiBTQU05WDYwIGNvbXBhdGlibGVzYD8g
VGhhdCB3YXkgaXQgd291bGQgcmVhbGx5IG9ubHkgYmUgd2hhdCANCnRoZSBjb21taXQgZG9lcy4N
Cg0KVGhhbmsgeW91LA0KCVNlcmdpdQ0K
