Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64A36B3EFC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 13:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjCJMRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 07:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjCJMRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 07:17:39 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B08DF8E6A;
        Fri, 10 Mar 2023 04:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1678450657; x=1709986657;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ekILDuMc5lq1tBKpJ1PvBZb+0TXPeGanG7kh7ACfW3s=;
  b=Bpay1/lCQ2LeiK+wMjEm1wVM1fTrA9Q6Qn4akpYPzA2Zzpv6KhPQLhOt
   TNYagy0PqjLWNyDqjUWdgea0VvBzFWVxQicn2cK4Y+AOikzqpysRkNhIk
   oNMlnj8+KSTB0HwhuJudU8u4hPWlZMOs1Kx6oqXhY3+un18JiuiGy8cE8
   x8fbOfsILRsBhGQj5Z0BfEDeZxtdQ5+maMuK7pc2kEFdh145/ucHsrxrB
   8ojqxNoJrwe5rkAguHgh7NRmR7cG31w3OZJJ/ElkEvT5CQYAvqJSSo3kK
   N0hFhmJGIfUV3OACr69InpbF5aamGyQLPalQOBtNWzsDccYlZc1ehQiQ+
   A==;
X-IronPort-AV: E=Sophos;i="5.98,249,1673938800"; 
   d="scan'208";a="141363782"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Mar 2023 05:17:36 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 10 Mar 2023 05:17:32 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 10 Mar 2023 05:17:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KKJfyYcCnWoXHrTYQCAhusu+ACXPPp2kGT3dbT57dS4xrgZfYhoozoZ0YrlN7uT578Q1K32HhrV0KvFygtKbuq0x9uIQZFfuRl937vQWx5GD+ZRX7+/9MyMyuHUgqqV71RhwBHLi2K5RVsV1iT4uiflZZmGDMDzfOPPb4gJcj1YWABWxW7H28xThl7dJsBJ/Jw8vjc0CeXFFB/+dhQX+q1GGx7n6Lrw1cuxdxO6kZq9iIo6bZUcZ0IWH4GNpZsgNgg/7kOCuQjQl9fGFs8YWHztLMifNH2dvXZE53PviZsGdCZoalTRanaHrUnL8oy57Jat/VRFbJ205P8rHTbkqmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ekILDuMc5lq1tBKpJ1PvBZb+0TXPeGanG7kh7ACfW3s=;
 b=e7v70RI8AMzl+K5KCtHywBOAtlq/nRtelGkD2ZRkOM9f2RpBHD3xHwHBMOwZpYEyU2NO2EdmC/QjXaAUZ865dlyCNJQUmY/YPMZ+1SkyTNPI8J7E0oBbNTMKQ6ZrzDsfuRmdYRMILQFVgWGgchHmbL2EJo+bQAVHAuSwAzK6AmTXOboayVX7NNPje2bgfkS0fXI/NCHfeL6rGPCo4Ru3G2q6JtH4HQ0BCRW3T3XYZRLsvRL7CfT00HZ6h0aLS6ZeHanqpc3R+7EouFaBDc9hLz8s2Ou+OjDiQFNIW3TzNn1CYC0F78G6NzCsMzaOOBW44+gxZO/aNGpHJyAQNQGhWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekILDuMc5lq1tBKpJ1PvBZb+0TXPeGanG7kh7ACfW3s=;
 b=pym7tToHWLqQg8rQ303JBBFJt0BtrX/fP9TutLDJsKTOOnb+oVnkrKybub4SaUfYbWmZlS/2aNgkD2OK2KU8z3fHU8NHYHFMfnPS0C1hqT4qPirLZq63AShNJDr7Il2GzZgbNfnqSHnaS7qrOV2A8/BcNZwWkesbqkhVoyXdGek=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by PH7PR11MB6978.namprd11.prod.outlook.com (2603:10b6:510:206::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 12:17:31 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32%5]) with mapi id 15.20.6178.020; Fri, 10 Mar 2023
 12:17:30 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <quic_wcheng@quicinc.com>, <srinivas.kandagatla@linaro.org>,
        <mathias.nyman@intel.com>, <perex@perex.cz>, <broonie@kernel.org>,
        <lgirdwood@gmail.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <agross@kernel.org>, <Thinh.Nguyen@synopsys.com>,
        <bgoswami@quicinc.com>, <andersson@kernel.org>,
        <robh+dt@kernel.org>, <gregkh@linuxfoundation.org>,
        <tiwai@suse.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <quic_jackp@quicinc.com>,
        <quic_plai@quicinc.com>
Subject: Re: [PATCH v3 02/28] usb: xhci: Add XHCI APIs to support USB
 offloading
Thread-Topic: [PATCH v3 02/28] usb: xhci: Add XHCI APIs to support USB
 offloading
Thread-Index: AQHZU0pIZcW1CR8sdkSXUeaGfY1iGg==
Date:   Fri, 10 Mar 2023 12:17:30 +0000
Message-ID: <378f29b3-6e8c-ba20-9dff-8bd47fe59f40@microchip.com>
References: <20230308235751.495-1-quic_wcheng@quicinc.com>
 <20230308235751.495-3-quic_wcheng@quicinc.com>
In-Reply-To: <20230308235751.495-3-quic_wcheng@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|PH7PR11MB6978:EE_
x-ms-office365-filtering-correlation-id: 9b066adc-2990-4850-433b-08db21616bd0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oZew8hqOvnG2o0XNZW1BgwthdKbvHob/8P5rkGYpLrdfFHABz+kuGkp5RlpXtkfr+gzbgRZW4GI5TgnN5N4dqmoCyH19vXMici5CeZ1RxcfBkI3/l6aLblZNrMSjC0LuO6G8otCOp9mXVCzw0WHkSIEg2F8jY0N/t7CxAPOClUKPAcQ0qz//Bsu+LWkTMvKly8+D+nSiZRm5a5I/VI/RlmTl18ah1tvbSMlsJC9mULXnNL0sgCBw1KLKBdx1T8Y2rhtnZmq5wmP53DvDm2Uk9sPh8pI0rZSm8XPj0D0rktVpiQAIUAcBUD3zZdKCwXfiqtwWwPitp/o0wu7FvfA8QA/vbi9mIqub70ItBUiUz5DMpPjyxrtKdtRKipNhMzbzGTY9ZJbEoVNehYHa0bL2c5Peodx6iGKOv+8CjMjA2vbgf03f4eecmIRR6WwfKCfAZWG4RpNjG7HhcG/OBgjIjQmAeyZK+vry3GqA5MbqeW+twIiqkkK5L025YBEMT4VWhv0qAYmOffZlE7mSfGJWCIC11hF+rQ9U6r/U8Q6YIYyuiYxJe9Ej2HT51uoONhaV+M3qyS/IQ1JQ/FO3L4ve7ml17PCENGsVWvAKy1+OrPI9+NICaWwR7/gzTRu4xhRFsxNQ2zU+RlvQM7UD3LXy3odlz+5+JB2n0Z8Wu0Dtpvm7nHTNJI2qTnbjAxC+pINefF+yjRKJqFEXXWPQQyx/rX9ZoOllpw82t6LBbS9nf7BIgEC5b0dCXYHJhnyyYPlVR9+AeE0zLNNpIkRHicKFigygrdmHJCVVUyxk6tMXTc0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(136003)(396003)(346002)(39860400002)(366004)(451199018)(31686004)(186003)(110136005)(54906003)(36756003)(38070700005)(38100700002)(86362001)(31696002)(26005)(122000001)(6506007)(6512007)(53546011)(83380400001)(478600001)(2616005)(316002)(7416002)(5660300002)(2906002)(6486002)(71200400001)(4326008)(921005)(64756008)(8936002)(41300700001)(91956017)(66476007)(66446008)(66556008)(76116006)(8676002)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aTdick1GeEZCTTVLQ1BRd295TTFXS3k2b1lCVkFrT3FJS2dIQXdTZDZVRXkv?=
 =?utf-8?B?YWZBN3oxTjVKL2JPU3NmcVA0elFmWkY3Z1hGL0pOSjNOcEk2UlFrRnhWSERD?=
 =?utf-8?B?ai82MXBhMllkNmFrdUNlRU43ZDBKN1lNUDBRMFF6YU9QVkYzSTIxcERISENy?=
 =?utf-8?B?akhQQmJ5dnQzTmlUU1ZiUmdsM2pZSi9tVFBZNHVQcWhuSE1yTUNjaE1Da3hW?=
 =?utf-8?B?L2lQQU1YNkFLVVBmU2JKb1ZCc0FxRlNGU0U3QmdOa2FyRVV5alU3eldBL1dV?=
 =?utf-8?B?WG9OcDN6V0hyMHlqMmlvdDAwZWxVNUxYeXJybXYwaXNsMGp4d3FCVThPN3p0?=
 =?utf-8?B?bk5kQ3ZoVXNLYlBGanFKYWUyTjMrczNBei9SVjd0cFZUL2l6eFIvVzRWU1Iz?=
 =?utf-8?B?M2YzOS9Yb2Y5ak1YMWxHLzdMaldzN2hMdjV2Uk5DbUhhb2tVWUwvN1lSYmVy?=
 =?utf-8?B?ZXp1U1pyZTFncGVMbWpHY1NFcUQ4ZkoxWWc5S3RURGZoRTdRNnB0NVkyWjBW?=
 =?utf-8?B?NEdCTy9vM0czM3lLK0EzUG5VbjJ1dDM5MUN1TjR5UHJWNjM4Tmk0L1dtZ3do?=
 =?utf-8?B?d2JHSVNkaWJPRlprOE5zdzJQYjF1UkJmaTV5b1I0NHlWRVVibjMyc0NyTkYv?=
 =?utf-8?B?VTlJRUFYcWhaRUU2ZUZnNkhMeURjdHBwdzBKb2lJQmJlZlhaVEplREFWTDVH?=
 =?utf-8?B?Y0swU0ZvZXlhY0NZYWlHZ084aTh4cHR2SGRDbWp1VDVDNWhoU1lucWhKWVU1?=
 =?utf-8?B?cVZMa2RqZnl2YmNDVDI3aUxDNjBOK2JSYkFqWXQ3azZuS0JVY1lhSWlxTTc1?=
 =?utf-8?B?RmlvRUZYMGVwWWVXdkIyZ2szeUJlNGpjQlEzVG9IOEVDYUtnL3VJWHFzT3I1?=
 =?utf-8?B?bVlBSUt2RFFPRkpsM3pidE5DQkVpM2c5d2NIRjE4Y2svNjl4S3RJU2p6ZDNl?=
 =?utf-8?B?Z2t1YStxRk1LZ0JZOGtVWXpZZ2VITkZqbWNsR2V0alNWUFplRm4yM2JYOThu?=
 =?utf-8?B?dnRSSi9iQjNjVzRoUDU5Q2dtZis4TURVaXJHWGM4V3A2QTVNemg3bUNwMGcx?=
 =?utf-8?B?NzJuOXV4Q0dnTG9HYVBhY3NJRFJMUkJiRGpCN3lST2x3REtEODNmUFNRZnJN?=
 =?utf-8?B?amVleFU3VTV0U0JLTVVuVlA2dzExYlhHZGhONU03dmxsUEthbmQ2WE1PZTEv?=
 =?utf-8?B?eUpvUHZLS3ZVWDQ3d2FENzFPYVRSOTM3ZEVmU3FOM3pYY1RPUitXWjRxaHA3?=
 =?utf-8?B?UEg5WGRQUGk5cXM5bm5zMVM4VG5jUkxTNzBiT1hKZ0VXcmt0ZFZ6d2poa2NE?=
 =?utf-8?B?L3FnelMyV2VxOTJPc3R4V1hLaGdNVmlaUjNaNFpWZVZCdlZVcXRSbFJOREJX?=
 =?utf-8?B?WUIwQ09vN3VFYXRDbUY5YThpd0JKSmcyaWE5WmJaNU1vY1RiQXVOdUNkZmZ0?=
 =?utf-8?B?OHRUYURJR3J1b2ExR0l6a2V0UllHSkNlNm5ETGdBKzB0ajRaVitEVWlYYlph?=
 =?utf-8?B?dnpMcFEyaWFyYldCNzN4MW5WYVBBSmRwdVZXRXhSdDZrYThZZVVUMG50UGVx?=
 =?utf-8?B?d3Z0djU0dkM3amhFV3BzNFF4QUdSU1dXbDY4TkhiaCtLMDl6eGM5RGNScGQ1?=
 =?utf-8?B?SUV5MEc2bC9JSGgzYmdqQlBGcnBCdFZ2TkdKUTNBMENWQWs5MGpsalp5OGcy?=
 =?utf-8?B?eFhsZ01WS2ZlOEY2bld0ZmhXY25IWEJsWkpQNjY0RXhVWEF3MkxlbUZ1bTdw?=
 =?utf-8?B?V1dyUS93Y2VYVjBrS01GVEpPYTgzeUlEdU5YaTgwelkwYSt2VFkrM3Z6dktF?=
 =?utf-8?B?REo4S25LMmREczExcDk0T2lwbGpvWHoxY3lCMm8rMVo1eVMwZWx0YmNWODR4?=
 =?utf-8?B?MmgweTVTMDIya0dwdDhLOU45REtEQVdHL2NCdWlLNlJ4N2I2VjFEUVNVNVdE?=
 =?utf-8?B?M3BvYzhsVUJDaEN5dTZLdi9iQ1l2Qm5ubVhqaTJidnpPY1lKcy8vUnlRUGVI?=
 =?utf-8?B?VHFWLzRmYXNkK2FOMFMzNFl4M2toUG1Jc1BRWGlKVG1jSjdQbTVTUnE1T1lt?=
 =?utf-8?B?Z3MrV2Q3SHRXbG1QMmFJVjUzdUtrLzAzRXg0dmZNYTdSUXRXZmhZWURqQzdh?=
 =?utf-8?B?eU96TXB5aWlYSzFmTDcySExNbWVGaWVaUFluSEhLSGtJL2Nvcjk1blkxcndP?=
 =?utf-8?B?M1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C581FD7EBDE93B48B202541E9D3B015B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b066adc-2990-4850-433b-08db21616bd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2023 12:17:30.6631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I2Kpi6F74+nMox26deRhVtNIUBIOeKL88s9ioXhS/67gfh0ujZ/kYI/TK6EnS0frQQC2qEMwOzLfa+B5dDTIe2Prr9cqWhD/GpIv+QthDZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6978
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDkuMDMuMjAyMyAwMTo1NywgV2VzbGV5IENoZW5nIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IFNvbWUgdXNlIGNhc2VzLCBzdWNoIGFzIFVTQiBh
dWRpbyBvZmZsb2FkaW5nLCB3aWxsIGFsbG93IGZvciBhIERTUCB0byB0YWtlDQo+IG92ZXIgaXNz
dWluZyBVU0IgdHJhbnNmZXJzIHRvIHRoZSBob3N0IGNvbnRyb2xsZXIuICBJbiBvcmRlciBmb3Ig
dGhlIERTUCB0bw0KPiBzdWJtaXQgdHJhbnNmZXJzIGZvciBhIHBhcnRpY3VsYXIgZW5kcG9pbnQs
IGFuZCB0byBoYW5kbGUgaXRzIGV2ZW50cywgdGhlDQo+IGNsaWVudCBkcml2ZXIgd2lsbCBuZWVk
IHRvIHF1ZXJ5IGZvciBzb21lIHBhcmFtZXRlcnMgYWxsb2NhdGVkIGJ5IFhIQ0kuDQo+IA0KPiAt
IFhIQ0kgc2Vjb25kYXJ5IGludGVycnVwdGVyIGV2ZW50IHJpbmcgYWRkcmVzcw0KPiAtIFhIQ0kg
dHJhbnNmZXIgcmluZyBhZGRyZXNzIChmb3IgYSBwYXJ0aWN1bGFyIEVQKQ0KPiAtIFN0b3AgZW5k
cG9pbnQgY29tbWFuZCBBUEkNCj4gDQo+IE9uY2UgdGhlIHJlc291cmNlcyBhcmUgaGFuZGVkIG9m
ZiB0byB0aGUgRFNQLCB0aGUgb2ZmbG9hZCBiZWdpbnMsIGFuZCB0aGUNCj4gbWFpbiBwcm9jZXNz
b3IgY2FuIGVudGVyIGlkbGUuICBXaGVuIHN0b3BwZWQsIHNpbmNlIHRoZXJlIGFyZSBubyBVUkJz
DQo+IHN1Ym1pdHRlZCBmcm9tIHRoZSBtYWluIHByb2Nlc3NvciwgdGhlIGNsaWVudCB3aWxsIGp1
c3QgaXNzdWUgYSBzdG9wDQo+IGVuZHBvaW50IGNvbW1hbmQgdG8gaGFsdCBhbnkgcGVuZGluZyB0
cmFuc2ZlcnMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBXZXNsZXkgQ2hlbmcgPHF1aWNfd2NoZW5n
QHF1aWNpbmMuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvdXNiL2hvc3QveGhjaS5jICAgICAgIHwg
MTMwICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIGluY2x1ZGUvbGludXgv
dXNiL3hoY2ktaW50ci5oIHwgICA4ICsrKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAxMzggaW5zZXJ0
aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2hvc3QveGhjaS5jIGIvZHJp
dmVycy91c2IvaG9zdC94aGNpLmMNCj4gaW5kZXggODg0MzViOWNkNjZlLi41YzZiM2Q4ZjgzNGMg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2hvc3QveGhjaS5jDQo+ICsrKyBiL2RyaXZlcnMv
dXNiL2hvc3QveGhjaS5jDQo+IEBAIC0xNjAzLDYgKzE2MDMsMTM2IEBAIHN0YXRpYyBpbnQgeGhj
aV9jaGVja19hcmdzKHN0cnVjdCB1c2JfaGNkICpoY2QsIHN0cnVjdCB1c2JfZGV2aWNlICp1ZGV2
LA0KPiAgICAgICAgIHJldHVybiAxOw0KPiAgfQ0KPiANCj4gK2ludCB4aGNpX3N0b3BfZW5kcG9p
bnQoc3RydWN0IHVzYl9kZXZpY2UgKnVkZXYsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHN0
cnVjdCB1c2JfaG9zdF9lbmRwb2ludCAqZXApDQo+ICt7DQo+ICsgICAgICAgc3RydWN0IHVzYl9o
Y2QgKmhjZCA9IGJ1c190b19oY2QodWRldi0+YnVzKTsNCj4gKyAgICAgICBzdHJ1Y3QgeGhjaV9o
Y2QgKnhoY2kgPSBoY2RfdG9feGhjaShoY2QpOw0KPiArICAgICAgIHVuc2lnbmVkIGludCBlcF9p
bmRleDsNCj4gKyAgICAgICBzdHJ1Y3QgeGhjaV92aXJ0X2RldmljZSAqdmlydF9kZXY7DQo+ICsg
ICAgICAgc3RydWN0IHhoY2lfY29tbWFuZCAqY21kOw0KPiArICAgICAgIHVuc2lnbmVkIGxvbmcg
ZmxhZ3M7DQo+ICsgICAgICAgaW50IHJldCA9IDA7DQoNCk5vIG5lZWQgdG8gaW5pdGlhbGl6ZSBp
dC4NCg0KPiArDQo+ICsgICAgICAgcmV0ID0geGhjaV9jaGVja19hcmdzKGhjZCwgdWRldiwgZXAs
IDEsIHRydWUsIF9fZnVuY19fKTsNCj4gKyAgICAgICBpZiAocmV0IDw9IDApDQo+ICsgICAgICAg
ICAgICAgICByZXR1cm4gcmV0Ow0KPiArDQo+ICsgICAgICAgY21kID0geGhjaV9hbGxvY19jb21t
YW5kKHhoY2ksIHRydWUsIEdGUF9OT0lPKTsNCj4gKyAgICAgICBpZiAoIWNtZCkNCj4gKyAgICAg
ICAgICAgICAgIHJldHVybiAtRU5PTUVNOw0KPiArDQo+ICsgICAgICAgc3Bpbl9sb2NrX2lycXNh
dmUoJnhoY2ktPmxvY2ssIGZsYWdzKTsNCj4gKyAgICAgICB2aXJ0X2RldiA9IHhoY2ktPmRldnNb
dWRldi0+c2xvdF9pZF07DQo+ICsgICAgICAgaWYgKCF2aXJ0X2Rldikgew0KPiArICAgICAgICAg
ICAgICAgcmV0ID0gLUVOT0RFVjsNCj4gKyAgICAgICAgICAgICAgIGdvdG8gZXJyOw0KPiArICAg
ICAgIH0NCj4gKw0KPiArICAgICAgIGVwX2luZGV4ID0geGhjaV9nZXRfZW5kcG9pbnRfaW5kZXgo
JmVwLT5kZXNjKTsNCj4gKyAgICAgICBpZiAodmlydF9kZXYtPmVwc1tlcF9pbmRleF0ucmluZyAm
Jg0KPiArICAgICAgICAgICAgICAgICAgICAgICB2aXJ0X2Rldi0+ZXBzW2VwX2luZGV4XS5yaW5n
LT5kZXF1ZXVlKSB7DQo+ICsgICAgICAgICAgICAgICByZXQgPSB4aGNpX3F1ZXVlX3N0b3BfZW5k
cG9pbnQoeGhjaSwgY21kLCB1ZGV2LT5zbG90X2lkLA0KPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGVwX2luZGV4LCAwKTsNCj4gKyAgICAgICAgICAgICAgIGlmIChyZXQpDQo+ICsg
ICAgICAgICAgICAgICAgICAgICAgIGdvdG8gZXJyOw0KPiArDQo+ICsgICAgICAgICAgICAgICB4
aGNpX3JpbmdfY21kX2RiKHhoY2kpOw0KPiArICAgICAgICAgICAgICAgc3Bpbl91bmxvY2tfaXJx
cmVzdG9yZSgmeGhjaS0+bG9jaywgZmxhZ3MpOw0KPiArDQo+ICsgICAgICAgICAgICAgICAvKiBX
YWl0IGZvciBzdG9wIGVuZHBvaW50IGNvbW1hbmQgdG8gZmluaXNoICovDQo+ICsgICAgICAgICAg
ICAgICB3YWl0X2Zvcl9jb21wbGV0aW9uKGNtZC0+Y29tcGxldGlvbik7DQo+ICsNCj4gKyAgICAg
ICAgICAgICAgIGlmIChjbWQtPnN0YXR1cyA9PSBDT01QX0NPTU1BTkRfQUJPUlRFRCB8fA0KPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNtZC0+c3RhdHVzID09IENPTVBfU1RPUFBF
RCkgew0KDQogICAgICAgICAgICAgICAgICAgICAgXiB1c3VhbGx5IGhlcmUgZ28gMm5kIGNvbmRp
dGlvbg0KDQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHhoY2lfd2Fybih4aGNpLA0KPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICJzdG9wIGVuZHBvaW50IGNvbW1hbmQgdGltZW91
dCBmb3IgZXAlZCVzXG4iLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVzYl9l
bmRwb2ludF9udW0oJmVwLT5kZXNjKSwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB1c2JfZW5kcG9pbnRfZGlyX2luKCZlcC0+ZGVzYykgPyAiaW4iIDogIm91dCIpOw0KPiArICAg
ICAgICAgICAgICAgICAgICAgICByZXQgPSAtRVRJTUU7DQo+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfQ0KDQp9IHNob3VsZCBiZSBhbGlnbmVkIHdpdGggaWYNCg0KWyAuLi4gXQ0K
DQo=
