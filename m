Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2203670BF1D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 15:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234180AbjEVNFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 09:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234119AbjEVNEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 09:04:48 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B3CA9;
        Mon, 22 May 2023 06:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684760686; x=1716296686;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hjbGfLWHuNxptX1h07TE3+fYNa7t8JufO/Tt/YGuGaw=;
  b=H6+j5iOoULsbq+Y2HplOwXz76EazifqRKDXqQ3A/dyVTId8C4QW28uXv
   J0/5Bkos+7r5MwgPYClF0Ka2jQgrA+zZbBTzERXis/CrTDniV5LaNCbcH
   0p4m6K64FLnWPLOrbw6Z4lU3nMXH8d+pFoFka5Nag+imuJEd45ApGgs6F
   IFSUVFwSG/rUld8pgLOvXboGaSQuJHT/I6hnNhKd7Z+AxBGoKNKnYwtjx
   AsHG0vGQSHAnS5PMU90fRNpp6b6WSIMiiSJ5uZOmP435IoA3VuLOw0xhO
   tCK0zBI0lN8fCcR+m8Xf9WfxVN/NUhJfdzoq/st8sK42GJewlSfbkGUc+
   g==;
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="214327388"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 May 2023 06:04:38 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 22 May 2023 06:04:38 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 22 May 2023 06:04:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z4ineFnFkrTd2Y9fzquAQENUmkl52dS0pVYTxTs3j6wnvwIoys18A100lIoatult5VBXO/Kr6GP1XUQWTMTmic9Cl3b4iCZQu6+O92ClHqAgvUBwNsIVlrwAM0EpsEyB66VDKwhZpTF4PJljx9LFnE9ru0MEFN01U+pGTgHWEbZyuTrHvjA+sWwMu15ocanVAGH+p1qmc8+j31Fzrm12CvWlPCrYbgcqtOeHtwVxf+2MK47SxRLPqbOIDtBUuY+ckstgjTTDkR1Um9c4QZe/I75ZB4hcnd18LaABM5JC29c+GzqC3lgj6glfkzBiK0DtKb8qPsOu+hWSIXhi1e4wNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hjbGfLWHuNxptX1h07TE3+fYNa7t8JufO/Tt/YGuGaw=;
 b=XUtqmizQiBBr52Vmzlnr8nWros8K1JkXM2zd9qoXODT1oHUak266QN5g63U7PfJXImEdQFcUVwZwr3uHDiQKbZXUuWOQ21+ket4EudOZzi2LbDd5FZkpPZbkD5P4gqP1Xle5pB+SLadSWin8D+Yepa6NO/QMjQoEQq1bdIPUikzmsXZFaiJ9KVQQmqp6uIj+9/6OzlZ93YNea3NaCCh7lMEY7B6vHwV6FXA2SGD6FrKrD5eVASnwW9Tf70XWECZzxwpyPmXwwHoUt3zJ25vRn+hBMSeMdlbjPRlp2l1OB+4o9uflu1NXMRSLu166qADi7QZ2gYNyJ8mMBktB/QuBIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjbGfLWHuNxptX1h07TE3+fYNa7t8JufO/Tt/YGuGaw=;
 b=PQg5ezdjaCdizTq5APhYvUQXEIqeqV/qDU738ptquKKu983724h+EIPHS03NKzNesSkv9C9VYuODpuSvfdB792oG/uB8WRfy+7lT6MNzZEE+Qy49GZkvXw/zQ/T2KeaW96P17WhLdgqYJyostE31Kz605vXn14D/R7mIYEHqoYw=
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com (2603:10b6:a03:4c3::17)
 by MN0PR11MB6012.namprd11.prod.outlook.com (2603:10b6:208:373::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 13:04:36 +0000
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be]) by SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be%5]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 13:04:35 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Conor.Dooley@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 0/5] dt-bindings: clocks: at91: convert to yaml
Thread-Topic: [PATCH v5 0/5] dt-bindings: clocks: at91: convert to yaml
Thread-Index: AQHZjK31HvsP3TTEFU6GkZuIRmpVGA==
Date:   Mon, 22 May 2023 13:04:35 +0000
Message-ID: <5f910aee-63c2-1af0-290e-1ac1d68c3608@microchip.com>
References: <20230517094119.2894220-1-claudiu.beznea@microchip.com>
In-Reply-To: <20230517094119.2894220-1-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB7648:EE_|MN0PR11MB6012:EE_
x-ms-office365-filtering-correlation-id: 03935edd-5f5e-4fa0-8eec-08db5ac517ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KQp1CmyzcCWIvhk7ekkpj6JxfBg+fRH14PCXk/zstZSbVTRSr0lO9ApQdE37q8Cr+MrJDkDU/ciwo4WkbaPvYvLEWEN34IHpKwREAU7r2a4jhnKCmcTnQo9PuGJ7yWWgqAfSaRqn4o5Dkm598cdn7T3c50w4wqG9telv5OJKHkCXrQ5zg+AblDwIfA8k4u05zdljQ1ooltAp78f99tI6ynB3r+be3jVFhfPrm6VkCHSOmA7pxJflSrfhShDhncNxKqzLMcLivxsCOvPFfQYpNFKWGm3P8vW31ijr0qBZpun3wI7Q/Auf8D+VdbuhqiQswuJqdnY8A+5/iFmQeNQNKtq2JvDXghxYPlQHEDU0p+MmP2N1onQFFksYPFHnQkHnDCuR1n0Xdkl+JzpKY3UU6oq3amYiaXr8FzRPW2Cu45KjH5qXR9lN90YRP+xVtnJfEV1SGNtVvqF9hXb9icbJhZIT3eA/a6J8dtb9kUzsFmrcjc2kn7KUL3x/aMw51UCnh6g7ELwdsLP0PtdQ41TnoVMPu16LMA2Z1z7GhpfzXMI5iCK6VtIbKUqrwxgrA8tjjFU4QjjFUeWUMW28Z10HTuT295r+k1t8pqPwIwxfMQJf4WNiW4jg6KAWsI/8ZXQVqVEEUPONvCKePUvggbVL5+m83KNkMUQtVhJgJLuk4lux2ELhy5dqBy47FwzTXE7J
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7648.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(136003)(376002)(39840400004)(396003)(451199021)(5660300002)(8936002)(8676002)(38070700005)(36756003)(186003)(2906002)(4744005)(83380400001)(2616005)(31696002)(86362001)(122000001)(38100700002)(26005)(53546011)(6512007)(6506007)(316002)(31686004)(71200400001)(110136005)(478600001)(91956017)(76116006)(4326008)(66946007)(66556008)(66446008)(64756008)(66476007)(54906003)(41300700001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UDRFTHljWnZLZ1JrQnVGd1VlT2YrOVRMVENUYkhRSlZhRXZUQVViMDdkY3ZX?=
 =?utf-8?B?ZVdlQkJhc2kwNjQ2dUdyUXJjdHF4L0IrVm5aQ2RiKzd0VEczT05mdTJkSmtU?=
 =?utf-8?B?bWpEUjVCUlhNeE9abzBkQ2JYRDcxNjN5L0NIQU12UTNFK1JXdDFNNnAzNE5K?=
 =?utf-8?B?VUtHYzYyY2NrTVVVZU9OMlJBbWpNdnNQYXNORmw3aVVhY3U2S3RpeXdUT0Jh?=
 =?utf-8?B?YytpbGhBS0dWSmM2U01Ec1hTZWRNWlR1REw3Z1poVllIK25mS2VCRytFNm8x?=
 =?utf-8?B?bndFNlljaW5KcVRqZWZRMTlhbEJRd2hqaXc5TGQvRUpLVWozNmNwZ0t6aXgw?=
 =?utf-8?B?dFUxTDNQamgzY2l0bVFiTExaSlNMNWQ3cUJDdFVhbTB2Z2lMNG0vTmk3Tlh6?=
 =?utf-8?B?dTYxNml0Y2pNdCswdUhySGlhbG9ONk1xb0VOYlFGbmlKeEZoV1h0bDRyM3A5?=
 =?utf-8?B?VWN3Wmk3eitBWGVEZXpkUTJvUC91aWJIeWc2c204dUNrQ0phZTV2d0pFTzhq?=
 =?utf-8?B?azBtdjFvVG00ME02VndsQ0M4S2FzSjN4OHpFWHZKbmJ5bllsazZ1TzJvVTVF?=
 =?utf-8?B?T3dBbXdmdURRejNFTHN2WlU3LzN5RUhzZS81b1FEVkhxZHNCL3pvbTFEY2ht?=
 =?utf-8?B?L1hwZzVScWFqOGlIcGpZNi9manFNcHQzem9UTzBtSHMzRjl2dVBnN0VTYVNQ?=
 =?utf-8?B?QXBrcEF1cmFhT0ZyemVqdmRmT1V5TkpNekhSSm52dDMrTzNLTzBFM01vS3Rq?=
 =?utf-8?B?TE5HdGhNMm1UTGVrcmI3LzBwM0x0dWZPTXZHY1g5eTRVenMyM3lFMytkUS9w?=
 =?utf-8?B?c1NuNnhjS0Y1WmRoTmE2M2tJeTdXQ1EzTnFGdVFZWlphbVc1eEJ2cWVvRnFE?=
 =?utf-8?B?TTNrdU0zdVlpQUhwVmdERnQ1bEtMMFk0UWZZSnJDUFl1b2FaUHZ4blFRdVpx?=
 =?utf-8?B?OVVTVDJOdjFnTTlQK2s5Z2hmTGtoSFlBM2hXRTd3VCt2UVFlNmtPOTN2aUZw?=
 =?utf-8?B?WGFVYWdta3VsVUpKd0oyaklKcExERkF4RHV6aENiS2NsaFBFNWc3dVdzWjNy?=
 =?utf-8?B?NlZsRXlING5iVmxZdE55c3hLc0RUWC95ZjNmK3dxNFVBMGlZeFlGYzN4R2Fp?=
 =?utf-8?B?ZlB3RHhZZE5xcFBuODNLVDd0c09FZUhReUZ6cStpaFpNMGVERlNPQktuZGt0?=
 =?utf-8?B?Sm1Dd0NJWkZJZ01DUFNJUDNhQ0JQSkFkQlR0aUl5NVorZWJXWG5Od1Y1QVFL?=
 =?utf-8?B?V2c4Z1RoT0Y2ZGF6Rm1CNTlNcnd6a3FwYThId2ZXakdjQzJlRmtGLzhMaW1h?=
 =?utf-8?B?S0U2M213L1N2WmlhTDZPV0Mybm01UzFBNzFCODJtWE51WXVHUmJtOUVIY21m?=
 =?utf-8?B?bVkvbDhGaWZ5b0dpS0NUaS9mbWNjTU51VFVZSHIrQmFzVGU3UkNHQkhZUWFh?=
 =?utf-8?B?K1ZhMEJsbXBFbjIzdnBmUUV3Y3JRdEsyaUIwdVBwS1FBSk8zWHlua3RyWU4r?=
 =?utf-8?B?ajJtbW1PaTFsVHVuSGlGV1FURzV3ekxSaGEzNC9zbU90TGt3M2k1NlQ2bTEx?=
 =?utf-8?B?dmdFZFl5d1JDMTY5U2JjK21aUzFZR2hTU0JDS0dYRUlwWEpXSlkrb1lRM21E?=
 =?utf-8?B?OHd2TWVONEg3QTBWS1dSTFNiMXUxMlZHMVVZb2E2RkZaOFBEZ0JIeXNyMVpt?=
 =?utf-8?B?SnBBb2xXZzBCamtsTXRBM3VBaWVkYWliRGRxQXE4eW44TWdDQlBiZVdsbnkz?=
 =?utf-8?B?S2lxWlpYazducHNackZvZjBZR1M2c1BNMmFQMVYzemxkdjdFV3VMK0NXeHND?=
 =?utf-8?B?amtGbFA4VU0zUEQvK1NqakVrNW52MkE2SDRsOC9IZXQyNHBCNXlYUFNrNE54?=
 =?utf-8?B?L3cwMzc0TmRtdzB1QUZTVzlTTWdSZXN5OENoSG5mV0ozelROR1pIbEttUXNV?=
 =?utf-8?B?Vkg4RHJtMUE5NVlPYnAzY0tjN253cC9BWVJTKytUNThRaVZTVXNSZGRjMGxt?=
 =?utf-8?B?WnBha2tHbU5aNkJTdjljbjl0N0F1YitwMmFQRmlnVWY3UTF0UWpJdkNBZkcr?=
 =?utf-8?B?aGk1cXFSSHowcjB6ZFpNWjRUN051MGJzcXNNanJIZEN1R2Z5Y1hLeDdiV1hZ?=
 =?utf-8?Q?fmRS5t9qLAuHbei5ungVWU492?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <211C3B46B84EB54CA6578C713DD302E6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7648.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03935edd-5f5e-4fa0-8eec-08db5ac517ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2023 13:04:35.6177
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I3Zzh+FweFYNJpBlUJyi+2G34FSXoznzbrorqPwaFb/bLs2j6U3ciJ4k7ajnDIxkELcIZlHMwCpRhBP9f+bzoXt02YnNQlIEvqU2lEIdsa8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6012
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTcuMDUuMjAyMyAxMjo0MSwgQ2xhdWRpdSBCZXpuZWEgd3JvdGU6DQpbIC4uLiBdDQoNCj4g
DQo+IENsYXVkaXUgQmV6bmVhICg1KToNCj4gICBBUk06IGR0czogYXQ5MTogdXNlIGNsb2NrLWNv
bnRyb2xsZXIgbmFtZSBmb3IgUE1DIG5vZGVzDQo+ICAgQVJNOiBkdHM6IGF0OTE6IGF0OTFzYW05
bjEyOiB3aXRjaCBzY2tjIHRvIG5ldyBjbG9jayBiaW5kaW5ncw0KPiAgIEFSTTogZHRzOiBhdDkx
OiB1c2UgY2xvY2stY29udHJvbGxlciBuYW1lIGZvciBzY2tjIG5vZGVzDQoNCkFwcGxpZWQgdG8g
YXQ5MS1kdCwgdGhhbmtzIQ0KDQo+ICAgZHQtYmluZGluZ3M6IGNsb2NrczogYXRtZWwsYXQ5MXJt
OTIwMC1wbWM6IGNvbnZlcnQgdG8geWFtbA0KPiAgIGR0LWJpbmRpbmdzOiBjbG9ja3M6IGF0OTFz
YW05eDUtc2NrYzogY29udmVydCB0byB5YW1sDQoNCkFwcGxpZWQgdG8gY2xrLW1pY3JvY2hpcCwg
dGhhbmtzIQ0K
