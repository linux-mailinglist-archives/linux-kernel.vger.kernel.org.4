Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD60639D29
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 22:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiK0VKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 16:10:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiK0VKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 16:10:39 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2118.outbound.protection.outlook.com [40.107.114.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57FC558C
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 13:10:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ctQQmXtBE/tRZgqX6WuPiq0So/of8eD/AQnLn2HyL1o+3H5fLSkkXV1qnbcihMhoB7C+mMHnZS+TJD3HMMZUL2+SEOjQxXGrubnigLIF//yHqJi7zSVYXia6aLFogftU68jEPzb5U/GX53eWwHMuHWvMNTn5ZpWR2o7MLxmW3FRBrfqPS5Psw4CviyNR1MVsH6TDaAZchnqKOHA6efJdI+JzR6Z4IylVknsHFYNttdRovARBw7ytN4Fd4V4D/3Ti/ntLVozIFpxYYAJrABKpOLjMm/nJQkut4uIPKQ3qcYbyePVQivlrQQYhrw9DHDpKib982rOCog4kjzzF+tRwZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q6t6K4S32i3yAU+A7sPANNQzJVcgEu7j2JvRIO5Es1o=;
 b=oXd7TPG6CMO6BW5JPO/NWRYDWxk7JcD9IDdvVKxdTLxuzdH5yT0AKmYYwqnCTwWCxKUGYMeEovk+TAwpWi7JtBkzuIUT+2M1WC9FNW5GNXHr6t3LsNJ1SL4mUjAHhuChrvBWtfrrbz3UJO1PzHwBmr1vDA/iZraJzKlQQxUO3NqPEcfz+xEgaxTq3bXqSzxvd/S/ITBTlouPKHycSaMyEP7tcu5W//4BU5/7i+nsSBIeTenAsOq+QYGaOqwnRZYOnP2cdB0rNrassTnpAHBPJIydPZzSRtNoLZmNeaT1h2mpBh3QFLcGsCey5FYcNbeozBFipeOwXycpZnWiqGI+IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dm.renesas.com; dmarc=pass action=none
 header.from=dm.renesas.com; dkim=pass header.d=dm.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dm.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6t6K4S32i3yAU+A7sPANNQzJVcgEu7j2JvRIO5Es1o=;
 b=g7IGFc1fZEe1vLhFCKZFeHkyjguzu0ANx42lhnGzUhFzChgYCLBWQ4+xLxapQ2rpEnRiJz3soS0HG6smkq/em0CsNDF36CpMebRJ6El6pQXc66NJTPaDY41o/BsE9kFwsbeQht/08Fjj6H2EKdOA91b+YtcV+3HwhFpQHhY2O4A=
Received: from OS3PR01MB8460.jpnprd01.prod.outlook.com (2603:1096:604:197::13)
 by TY3PR01MB9998.jpnprd01.prod.outlook.com (2603:1096:400:1dd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Sun, 27 Nov
 2022 21:10:35 +0000
Received: from OS3PR01MB8460.jpnprd01.prod.outlook.com
 ([fe80::bc4f:a066:427c:1723]) by OS3PR01MB8460.jpnprd01.prod.outlook.com
 ([fe80::bc4f:a066:427c:1723%4]) with mapi id 15.20.5857.021; Sun, 27 Nov 2022
 21:10:35 +0000
From:   DLG Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>
To:     Ricardo Ribalda <ribalda@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Mark Brown <broonie@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] regulator: da9211: Use irq handler when ready
Thread-Topic: [PATCH v2] regulator: da9211: Use irq handler when ready
Thread-Index: AQHZAqQb5p3xwi3GxUelKL2uyTiuda5TQ0AQ
Date:   Sun, 27 Nov 2022 21:10:35 +0000
Message-ID: <OS3PR01MB84602CE52981B9D03F847FF7C2109@OS3PR01MB8460.jpnprd01.prod.outlook.com>
References: <20221124-da9211-v2-0-1779e3c5d491@chromium.org>
In-Reply-To: <20221124-da9211-v2-0-1779e3c5d491@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dm.renesas.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB8460:EE_|TY3PR01MB9998:EE_
x-ms-office365-filtering-correlation-id: 5b96d71f-764a-4e7e-413e-08dad0bbd3ae
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QlKTbD4fC8iR166tSROv5E2wCk8HaVKwakpkx810pSREoe9H8f2EbTVb9jaR5X6bMQtEWo0x9Bx86JgWK34avmUnMutq/veXvt2pymjmcJo/tMDjYnGwb6B4CMgHRMQag8x/hqgLSPR/lnXu2+mRigzo/7ta7XRXkR69eonXswhMYxCGFcBRUzEyTGDMQOslWbp7PpjcFB5f/jNSu09Dc7flsLsgQIxX/HzTPY5g+f4p+Xjci9Tl5kNcsSbZhZPNsKBU9MCCA5ujKRjTsBVNZiQijvto53TT+l+6kdToFZkMLQWTb8Zz2OKhcy4d1HiTyGxmpoKdDvU4U5s8rle2JfMS7VM3LbywVO59m5z0sdcB0afLMIaNyfiBdHaTksZUADGbJ2/XQ8CGQs1psWw2LUMkPm7Uw+9jDqEtB9qxuDs4ECW2o3NSDdGHLh8R0EZTnB6w6bWyiBzwEdELsjjtqktRgo9fWTsMCNMOrYTZWaCMa0HkH67+lW5pLlnO4lkUuf80wj2LyuufGyIyI6FxeV5/vG6K6F2+zLxsugZq5E7l91WAy9KU/BmY3gUwTXyo442W2RvpXcgyfzCctl/GFBn070j0ngt4TsUFBbyCQPdQpT1rHuuZpfF7/OIC9K9jHU76FDdeobGmJ7RyxqQj7gUP1zg/KTb4emO1M1ZuTeT4usLtKJ9YzOxKscO3k9STJ4RqfanYkG+FUYXa6w0qBw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB8460.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(451199015)(53546011)(55236004)(71200400001)(122000001)(6506007)(7696005)(9686003)(478600001)(26005)(38100700002)(41300700001)(8676002)(64756008)(66446008)(76116006)(66946007)(66556008)(66476007)(33656002)(86362001)(4326008)(38070700005)(316002)(110136005)(55016003)(52536014)(5660300002)(558084003)(8936002)(186003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aUtkNzFsN0VrMzVXbi84QzFPeTk4eGFkYXA5c3FKNDFKZ0RGYzFTSDdwRmFI?=
 =?utf-8?B?U2xxUkxEUkRzbkRCV1l6Q3BRS0xsNnNpWTREZGVEYWthYWRkZ0QwSnhhTEF6?=
 =?utf-8?B?cUFRZFBTS0xwM2M5aGM5UzdYTElMamdONkJ6K0hJYWR1SDllZ3Q0U3NsQmEy?=
 =?utf-8?B?OEFiV0t3UnpsY1I2cmU4N0xXUEpxU1FEaGdFdjhJa29iRlBDVm9kN2dCbHF5?=
 =?utf-8?B?SFl6U25RT1hvcktXcGw1dVBaaDFiM0xHUGltMTVja3pLQnJVQ3R5TXJ2MmRX?=
 =?utf-8?B?bWV0MlpDeVMvL3hjS0MvRFp1clRFTHJaYzZ2OXhkSG9FME1xdlNFZXBsSlhQ?=
 =?utf-8?B?dUdZaW91STZhYW5SN0RKZTV0SEdmT1BRVkVWS2U2TmhLTUtMSm9LUmdtWHRu?=
 =?utf-8?B?OU5GcjFqSWQyanRHd0ZON3QzajM0SmNLa2lOQ3Z3ZVByRlJMcUpYTHI5UURu?=
 =?utf-8?B?TWVDb0FwWFlNeXlIS2U5RDd3bEpSUWcwc0pFYmZYQ0pISmRDOVlsR1ZnTnh6?=
 =?utf-8?B?VDY1L0kwSVJlam5zYnlUeVNzREFhY3daakg4eko0a0laczA4SExLa0l5aU5Q?=
 =?utf-8?B?RVVNczhPLzYzWDR1dmo5U1ZYYVdna1NXYnF1MW9iT0pwM0RndDVjYlhMdHhP?=
 =?utf-8?B?clNIZ2tDbU9udUtqTVpLUmkwNXY0UC9PbE81REtqcGlqbkdjakEyZGZtekdz?=
 =?utf-8?B?NnJUMGw1UHRyNjZJb3VUc0ZCNnZpMWRXQ25uRVltcTJjbmZoSzhoZldZQ05a?=
 =?utf-8?B?U1dPLzhBK21XQy9SMVJscnZTK09BcGVKWURlLzZESnBBcmJ3YjZZQ0lYa3pU?=
 =?utf-8?B?bHdjb08yZ2FRV09DazBHbjJtRjkzK0ZheUpnSkN3ckY0Q0N1RWN1RXI2MGlj?=
 =?utf-8?B?ckdPNVcrUnBNWUpyRHY4bmY3Vk9rcEFjRTYyOWNYKzlzODRVSnNqZk04Mmhj?=
 =?utf-8?B?UnUyd0NWUHFpc2MvT1pBMkxLdkU3UVhMVmZwTHNXMExVVWJIUlNkV2FrRHd2?=
 =?utf-8?B?UERpeDhCOWlCYkdyZU80ekpjOHlYenk4ZFRpeW9CZXJ3eEdHSGN0KzNYVUF2?=
 =?utf-8?B?d0E4RjFncHZETlF4ek1HY2VSZ21IWFJpYjNyOUFZZWhYcndITVNsWGZqb1Nv?=
 =?utf-8?B?RmZEZ0sySW82SGw0MzB2WlRLL0ZXVTJFcmFkSmJtSno3ZmFwZUxOd0ptL25q?=
 =?utf-8?B?cUhHUFhsTEUyZ0lQTnhubWUvQTFTN1ZyTnNob3RKZEpwWFJpeXRXL2wybTM5?=
 =?utf-8?B?WVNzR2JPZjJZalc0YW5qK2JKWEpVd3lvUzZJUmIvT3lKaldFbERzbUFicmV3?=
 =?utf-8?B?azRZU1p1VHJEKzhGNVJ3SmEzNldJUzlwMk5qdDE5R2dKM2pIVlhZN3JhaUlh?=
 =?utf-8?B?ZDBVUk1GYkJ2UEdjNTN3VHNOUkVQaGsrNDZpSUh5bUNqaFBXY0VXNGpSNFJK?=
 =?utf-8?B?WDZCdUorcStlbDFSSDNHcHgyMENoWk5WdUZ1Q1ZrNXZQR0dycUhSZnpUbVox?=
 =?utf-8?B?UElDS0RPSnNPKzdpeTV4aEhvR0ZWbzBzL0IwL0hjdnEwanBNU0pQWTg0WHUw?=
 =?utf-8?B?U1lDTFpJVzNzbmxNaDdhSXMzQ2N1RkxNaURkTTV5VUkyOVh6UUhjV1pNS2RG?=
 =?utf-8?B?MDdGaVdnTExJZ1FCRENoLzNQUkVZZWpCU3JUWmJRTklnQll0N2E1TlF0L1FF?=
 =?utf-8?B?MWwyNXpRQnMwZStSM3hVOXZjT2dNa1ZGQ2IzcUExV1hDeWcyNTRYaEtuNllh?=
 =?utf-8?B?RHRzTnZqK002bnAwWStpRXhIL2V3b21XOWFwK1pkVjdQN0tpQ2tUTC9qblov?=
 =?utf-8?B?ekFMUWFZai8vWVZrREpPTU5sMyt1dU8xTk9XNk1GWUIvRG1rdG53TkFTNExz?=
 =?utf-8?B?eW9IeC9ESVZmNnkrS2JwWGwxekc3dGhibk82OW5IbmRWc3FnN2llb28zd2FR?=
 =?utf-8?B?cU02WXF1UjNXMXRUbHpEY0tqOEJJZDUxYlJPSVJpU2dpMWFtQ2xFMURSK1lo?=
 =?utf-8?B?dVNNaWxLRGZURjg5MXFLY24rTXZwRHdjVXNHOUx6R1V3akVYOE5tSmJJcVhL?=
 =?utf-8?B?RXIrdE9nY00yQTNHZkx0SXhRNFF0YnhGczVhNUY2U005Z0J2RmhpdGxCSjdp?=
 =?utf-8?B?WXhBcXg1YUtyMmdQRUtrUjBsQ1pTVEFPTVhxV1ArVnpUcmVKbDVjdDYvOEEw?=
 =?utf-8?B?NkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: dm.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB8460.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b96d71f-764a-4e7e-413e-08dad0bbd3ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2022 21:10:35.4907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cGHeH2teES4fj6lP7Zi4w0wWH/dluAFVqRYwJmcvWcwIiRyDmqOervWBlgAg979V0C6SaDNAAjMxlP60Hh5PYBNqqKFtzk6/h6odic9hR20=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9998
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjcgTm92ZW1iZXIgMjAyMiAyMTowNiwgUmljYXJkbyBSaWJhbGRhIHdyb3RlOg0KDQo+IENo
YW5nZXMgaW4gdjI6DQoNClRoYXQgd2FzIHF1aWNrISBUaGFuayB5b3UgOi0pDQoNClJldmlld2Vk
LWJ5OiBBZGFtIFdhcmQgPERMRy1BZGFtLldhcmQub3BlbnNvdXJjZUBkbS5yZW5lc2FzLmNvbT4N
Cg0KUmVnYXJkcywNCkFkYW0NCg==
