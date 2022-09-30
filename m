Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D445F05A1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 09:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiI3HWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 03:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbiI3HWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 03:22:44 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1F21F0CF8;
        Fri, 30 Sep 2022 00:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1664522561; x=1696058561;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=bki88kqNK/Z3/Yugsvg7ccV5iSIjq/n3Z3pXm1abAus=;
  b=KSF600/c2UDEcn42m2sTRsGyBe5txAuABstADpTl9yEIyi4i+vvYQwKH
   6HCPPd+YjtrTHJGTjrG2rrzlMoM6OcnmKCakoAFQxdIj9Q0rjg5cLJJVB
   Dg4m3KL9Vm49ijojunlauCoMpn23rTjjKShNV9SNoWXTAK8x/tuxLHhZ/
   QICTnS88dXH4+BaYjmPCGBhVk+tjhdhZ4wJcabZzcGho/Psjk2Aovqs9m
   0D9aen6JZOBHB81AHMkC1GFRhhv1TbC4GmD4Z58Dob8Nk8QGPIHeLJoS4
   GVD6IaKXlXXae388REYe1oQJPH3JNrq4NKPJweJkEcJxWjgsSW2R4Epi0
   w==;
X-IronPort-AV: E=Sophos;i="5.93,357,1654585200"; 
   d="scan'208";a="176377894"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Sep 2022 00:22:40 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 30 Sep 2022 00:22:38 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Fri, 30 Sep 2022 00:22:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mv4WHCVCRVPk5UzyyHCdwbiQKSbFu8zZhQ76DUvwJIBiS77gsB0mnh3+2A5u7bKp59S3myP3LkOWMxLeKCBvcGUeyCM7t0fFhv7cLhAKwjBcChHPDxXy1XSHCX+POSK6B+iUx3RDLcz+nB0KeHYCjzICNX7PV4+b03pGDk02JgWHsyVvBN5Zz6KvXpwH1Ikd+aCaXGoo50CWxwWOCkB3PeS/vyt59yF2tpzigAecV/gkUr0uaN11HvAMI9bJYkyKsSqor/ydHDzziNd2exi8o05jCj53UkuwPxZVFylpit8tx75KO5F70sDL6HGEyPbEt/5tmgz553NTEyxRzOPuyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bki88kqNK/Z3/Yugsvg7ccV5iSIjq/n3Z3pXm1abAus=;
 b=F2tomzU2n3d62kpW4IuYqOYBksFeokjfpnADTuygzN+J8BlbIOvHfEMry6003sIXcSTCT0qiv0lHR+KSrxEOz08x3IWYMZOyvulfhfUb1Y5Cdp/j2MWrzfm3cMnhe/HOyHmHoPuWwSub0kOIMhCaRdO4VJT78m5CfYg6aHXnCDweZ7XiE0GYuDaTScHv9XELdKGbsTdche0sFovHkcx3Unyt5+o3d9OOuuifCZ3dg7ZqcWIHYJpqLAM2mqVhuTlg6nMblFWRXxmWTMzl5F01LZCDYZKX9CW1WnMaPOWTv4pi5f+N8epe0+Az2A8O0HTtN5SUeUr8jhusDCUAohYByA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bki88kqNK/Z3/Yugsvg7ccV5iSIjq/n3Z3pXm1abAus=;
 b=jiP8MarpGuRCkuAgflgw3wCs31cdD3Q0U0bQ3qDtXhRFVyhsxkuoyY1DdR2a3uQ864eeXccmY/mqJT4HS5FfhRLPTbvTdLeIV6D/LnZ+mZY+3uky0eJjtl5rndJsa+5OWJ5zGFRDIcvDBPuH1PLxU5YF+X3tNYmDBfmZ40SqCHo=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by PH7PR11MB6860.namprd11.prod.outlook.com (2603:10b6:510:200::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Fri, 30 Sep
 2022 07:22:36 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::51f:528c:5fde:40a2]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::51f:528c:5fde:40a2%3]) with mapi id 15.20.5676.023; Fri, 30 Sep 2022
 07:22:36 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Sergiu.Moga@microchip.com>, <lee@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <radu_nicolae.pirea@upb.ro>, <richard.genoud@gmail.com>,
        <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <Kavyasree.Kotagiri@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v5 6/9] tty: serial: atmel: Separate mode clearing between
 UART and USART
Thread-Topic: [PATCH v5 6/9] tty: serial: atmel: Separate mode clearing
 between UART and USART
Thread-Index: AQHY1J1q2uILy6tjjEuqDtOm6kSOnA==
Date:   Fri, 30 Sep 2022 07:22:36 +0000
Message-ID: <4cff16af-e6f8-f6b6-37e7-e2d743d1022b@microchip.com>
References: <20220922113347.144383-1-sergiu.moga@microchip.com>
 <20220922113347.144383-7-sergiu.moga@microchip.com>
In-Reply-To: <20220922113347.144383-7-sergiu.moga@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|PH7PR11MB6860:EE_
x-ms-office365-filtering-correlation-id: 10b98a59-24e8-4643-96f4-08daa2b48c94
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1vHD8h5UwMTVoKy5fA6AnSHY+7GpA4YWy03BIiTkwjUS5uxyr85YK4ffM7BpGTRZTU4YD/bk0PMj04dZvtsZSy5C3ECu0p2QnKjmE0pzpDBoxOB3A5QNTCA6Lq42QIlEilQtwlArIf36WGOwb+BG1u4bOinhR7QXPRLqVIcOhqsD49R08E/mwJ0yQoT/TZcR1seH+NayqRe7KYceoX9sS8dGfiXbm0cF1m18IrLjKdZLMnJa1YLAq5pEwy6g9yr9P80DDcgdVhNCFCcXlAkqwH6u+feBWyeuP8XdgZJUCcpdI/1dZJUAjY6OQ0F3SlI1CkvsBGSHP617EbRN26ZPtpLXYHHvZG17wwf+11KTJzRSBdWmPwxHQ9Zz2Oj+VUsiYRLAmL8lCUF9B/w0fvB0mGXzShpyyBR7TNbRv1pLR9Jizg+plaizE+kvkejfdgjEGiRWywdFnHrA6k+KUaZTinyOOMOmFmwVSJ33yQJyP6/+2ytl7AAwUpkGi0igR/wjw1mje5S/fNlC9tqUNuRVl3/kK/h7MmyaQ6xthS7hPcAHE9ERSx39Gfak4KhiijFws3xTCkyEVaMSuYo17TxAV20Sidmpvx4SuXk2HT1dEeve2XPVSRv2Tno2Bnz3B8ulM3mtzRwXI88rjMvO8qzvnl+ezY08ZwpjaSzvxqjKrIieqK349q+PftRi3t5FVUqG2pg1TFIueKk2RhdI7GVc6nUYq3AIEfOlQwvRfP5sMkZVb/0C1kIZ5r2wfmqYEIfFs1QsSKEDqtVl2ZDfUot0scdi3G5n4JBDRARZRgkBCEBSdHhnh0YkvyEeTZ9zOHwkbGqt07uCs62UOtP0SibtriKgXMohtNCpXsaAzaJUp8Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(366004)(376002)(396003)(136003)(451199015)(66946007)(66476007)(316002)(6636002)(76116006)(91956017)(478600001)(66446008)(6486002)(66556008)(54906003)(110136005)(31696002)(122000001)(86362001)(36756003)(921005)(2906002)(38070700005)(64756008)(4326008)(8676002)(38100700002)(41300700001)(8936002)(7416002)(83380400001)(53546011)(186003)(2616005)(71200400001)(26005)(5660300002)(31686004)(6506007)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFBaOFN6QUhRQlp0M0I5clo2ZHBVaDZIREtySVJPTXpYOVY0YktjcWpCaXVl?=
 =?utf-8?B?aVd6cXo2OWhTdGZjdGEzSFg3cjdHNGoyaWNqcU44UUhWYUVGYnl2NkpnN3o1?=
 =?utf-8?B?S3ZUU2VmQVJxSjUrTUdEVkcxVXhQckFpSTZDUzJxUnVPZ05IeXpxb1lzYk03?=
 =?utf-8?B?QVAvQytGUHVNNXlkZ08zT3Y0Z3hpL2xDQU5hcUt4SVlhTEh5VGJZbHAyckh6?=
 =?utf-8?B?VlRKbDFvcFRNVnU0Z1RkcGN0UnFXeWtydVhCNlUwMzU3eGMwRGZQMnVUcHdN?=
 =?utf-8?B?ZlZ3cmFlK3lCREtQRVRWOFJpRWQ5dWhPdnEwZWtRK1gzTUtZbnpLeHVZdFMv?=
 =?utf-8?B?K0NmWjA1ZW50NzNOc1NOK0tPeUV0ZkNac00zalhZYjBFSkpBQzdpekpsN1FY?=
 =?utf-8?B?QmFEMzg5TnNGcm1LODVmcVo1S2pBVHBzWWt6SHQyQlRNZmdNMVlGTkl5OGI1?=
 =?utf-8?B?cGNmUUtLb2k4T041N1ZoNTNlWlNpK3JDMnlvSjRtaUozalV2UjE5QjdZYVN3?=
 =?utf-8?B?R2w1eFpJQTdaSlNNbldnTXUwcDYzQVpIYjZ6Ly9XZUxtUW40Sk9qUkJ4bWMx?=
 =?utf-8?B?OUNYcEpkdC92VUtmeUZiS1Z0VGFNUFNkZTk3Ni8vNGFIT2d0VWkrT3lCU25u?=
 =?utf-8?B?b3VqQkFqZUVsbVVYTm9iM1RMVXBSS0ZCRHdLOUdwTTFpWDVocDhZVnkzM3dh?=
 =?utf-8?B?SVhKMG9Sd1dwWnNwaStxeUNHbzVMTHBoM0t2S2Zad0lYV3RjSWNJeGNEdkc5?=
 =?utf-8?B?UUNESFBBdm1TOHFMcmRkV1BqR0x3TnBrb2orY3BhQitsUXBhMnJpby9Da1FP?=
 =?utf-8?B?UFBwUG1xcEYzRDRQdExZWGZQSkhKd2NheTY2dVBrcDF5OFJkWlFIMHdIK3hr?=
 =?utf-8?B?WHdmajJBeGlXNHJoaStuV3hOTC9YTno4aVljS2c3MHNKM1Z0cHplbHZjZGJ2?=
 =?utf-8?B?ZjJ3RG5wVy9kWGQ0Q0N1Ui9lVHNlZFJaMTBqQnN1bERySDR1WFE5cmhaMWor?=
 =?utf-8?B?UGMxaExYZFphbUQ3dVV1R3hPTDVoeHhxenZHVStObmd3VE42NEdMUVNTeGth?=
 =?utf-8?B?TEhVaExFNzFUMHVPZjVIVGVQQkZhZkNSdG40Z2VmczBqOFVqT2QxWjFZVW12?=
 =?utf-8?B?YTFIeHdEZTB4WHRDNEZJeGt5OE0xekRpWGRDb0dNeVlVV0UwMEJZSUdHYmla?=
 =?utf-8?B?cVVtTW9oTGI5RmY1RXNYbjRPTStXblVBRUR3ZktQZERHNVhpaHJqM3N5bXBR?=
 =?utf-8?B?ZVFuQ1VLZHVibUdIOXdOZVdqVDZmaW1UYTZmVDJxUkNwaGVLRk9VdXFMNy8w?=
 =?utf-8?B?QTJUL2pPZklHQ3NlZkg3M2s1V25odUk4bWxOUmJpU0dEcVhsVVdKYURoQ2x1?=
 =?utf-8?B?Nm9LTDFSVWVjNEFkWnNURnR1a0piNnc1Q01YRnYzUFRlRTBwaFlsMkRGdkVr?=
 =?utf-8?B?a2FtRG82Sk0yQUZmdUdIWkpweDR5ZnFMeUUvTUNJU014enFYdFExT0ZNclN4?=
 =?utf-8?B?ZUpvaU4zUk5uK1VGVno5QWdZSWllbU82OUVlamN6Z2R4MGRnRUc5ckRsSWo5?=
 =?utf-8?B?bnJrRVRmTm1vbE9UU0hJK0djU3dwRnl6TWxoZzhKR2ZHbnB3OXVGcWltL0RY?=
 =?utf-8?B?WkZTTDQ3S3YyQ2hWL0o3aWp4b3ZuOHk1YkRVQXk2NzJwWlNSb01LKzFPUzJ3?=
 =?utf-8?B?bFFzREQxM3Vjc0hXR3c3eU5CRHFTUG9XVkhLZHdQaEpoS1NhUjFJWG1WRzhG?=
 =?utf-8?B?andQNkN0UFlRc3FNeHBzVjdVRkcyckFydVBtUTFrR0lDeEsrWHpTRTh4eWRz?=
 =?utf-8?B?TDVwWm1VOVJxSnZlbnc1RlV5Z2FnaWZINGZZV1lKcTRFOGVmaGJLOXJNd3B4?=
 =?utf-8?B?ZndOTTV6eVdCeFJBRFl5MEtJTEI2UERpby9hZVcwek1xUGdCbUpNcHJIMytU?=
 =?utf-8?B?WjJna1VhY0xxL28wRTFFQmpSVmlEemEyaDh2UXFVYTBQSndQbkFncG1aaGpU?=
 =?utf-8?B?MDJFcXhuYTl2LzJMcnpyODQ0MlhqSXd5OUVzUXhYOWdSTm9OVU9JNERFRDJN?=
 =?utf-8?B?ekE0ZXV0VGsrdWJzM1dlZXk4ejlaNTh4U01mYnZ2S205SU1EdE9MTHoyVXVo?=
 =?utf-8?B?djBNWXJPMmswemQ3RFRMZThMZnRyYTBDY2RQSWxxa3BPeFMvb01zNGZlTjVQ?=
 =?utf-8?B?Y2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8CC3CB135BA71A42819BC87889D693E8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10b98a59-24e8-4643-96f4-08daa2b48c94
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2022 07:22:36.2238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qdmBmABWB2kbFkgh2IA2NcotOeQ8uSLNiveGc/E4iwNbMG/7cIR+cephcXDMP3e0clK+dg2mjuOLmyT/hR7CoXoyVnBy1KgNyTVDz4G4fR0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6860
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjIuMDkuMjAyMiAxNDozMywgU2VyZ2l1IE1vZ2Egd3JvdGU6DQo+IFdoZW4gY2xlYXJpbmcg
dGhlIG1vZGUgb2YgdGhlIHNlcmlhbCBJUCBpbnNpZGUgdGhlIGF0bWVsX3NldF90ZXJtaW9zKCkN
Cj4gbWV0aG9kLCBtYWtlIHN1cmUgdGhhdCB0aGUgZGlmZmVyZW5jZSBiZXR3ZWVuIHRoZSBiaXRm
aWVsZHMgcGxhY2VtZW50DQo+IG9mIHRoZSBVQVJUIElQJ3MgYW5kIFVTQVJUIElQJ3MgaXMgdGFr
ZW4gaW50byBhY2NvdW50LCBhcyBzb21lIG9mDQo+IHRoZW0gb3ZlcmxhcCB3aXRoIGVhY2ggb3Ro
ZXIuIEZvciBleGFtcGxlLCBBVE1FTF9VQV9CUlNSQ0NLIG92ZXJsYXBzDQo+IHdpdGggQVRNRUxf
VVNfTkJTVE9QIGFuZCBBVE1FTF9VU19VU0NMS1Mgb3ZlcmxhcHMgd2l0aCBBVE1FTF9VQV9GSUxU
RVIuDQo+IA0KPiBGdXJ0aGVybW9yZSwgYWRkIGRlZmluaXRpb25zIGZvciB0aGUgQmF1ZCBSYXRl
IFNvdXJjZSBDbG9jayBhbmQgdGhlDQo+IEZpbHRlciBiaXRmaWVsZHMgb2YgdGhlIE1vZGUgUmVn
aXN0ZXIgb2YgVUFSVCBJUCdzLCBzaW5jZSB0aGV5IHdlcmUNCj4gbWlzc2luZy4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IFNlcmdpdSBNb2dhIDxzZXJnaXUubW9nYUBtaWNyb2NoaXAuY29tPg0KDQpS
ZXZpZXdlZC1ieTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+
DQoNCg0KPiAtLS0NCj4gDQo+IA0KPiB2MSAtPiB2NToNCj4gLSBUaGlzIHBhdGNoIHdhcyBub3Qg
aGVyZSBiZWZvcmUgYnV0IGl0IGFsc28gaW5jbHVkZXMgdGhlIHByZXZpb3VzIHBhdGNoOg0KPiBg
W1BBVENIIHY0IDcvOV0gdHR5OiBzZXJpYWw6IGF0bWVsOiBEZWZpbmUgQlJTUkNDSyBiaXRtYXNr
IG9mIFVBUlQgSVAncyBNb2RlIFJlZ2lzdGVyYA0KPiBzcXVhc2hlZCBpbnRvIGl0IGFuZCBkZWZp
bmUgQlJTUkNDSyBhcyBhIGJpdGZpZWxkIGluc3RlYWQgb2YgYSBiaXRtYXNrLA0KPiBzaW5jZSBp
dCBpcyBvbmx5IDEgYml0Lg0KPiANCj4gDQo+IA0KPiAgZHJpdmVycy90dHkvc2VyaWFsL2F0bWVs
X3NlcmlhbC5jIHwgNyArKysrKy0tDQo+ICBkcml2ZXJzL3R0eS9zZXJpYWwvYXRtZWxfc2VyaWFs
LmggfCAyICsrDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwvYXRtZWxfc2VyaWFs
LmMgYi9kcml2ZXJzL3R0eS9zZXJpYWwvYXRtZWxfc2VyaWFsLmMNCj4gaW5kZXggYWI0YTlkZmFl
MDdkLi5lM2UxNGNiNzY2OGIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdHR5L3NlcmlhbC9hdG1l
bF9zZXJpYWwuYw0KPiArKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwvYXRtZWxfc2VyaWFsLmMNCj4g
QEAgLTIxMzQsOCArMjEzNCwxMSBAQCBzdGF0aWMgdm9pZCBhdG1lbF9zZXRfdGVybWlvcyhzdHJ1
Y3QgdWFydF9wb3J0ICpwb3J0LA0KPiAgCW1vZGUgPSBvbGRfbW9kZSA9IGF0bWVsX3VhcnRfcmVh
ZGwocG9ydCwgQVRNRUxfVVNfTVIpOw0KPiAgDQo+ICAJLyogcmVzZXQgdGhlIG1vZGUsIGNsb2Nr
IGRpdmlzb3IsIHBhcml0eSwgc3RvcCBiaXRzIGFuZCBkYXRhIHNpemUgKi8NCj4gLQltb2RlICY9
IH4oQVRNRUxfVVNfVVNDTEtTIHwgQVRNRUxfVVNfQ0hSTCB8IEFUTUVMX1VTX05CU1RPUCB8DQo+
IC0JCSAgQVRNRUxfVVNfUEFSIHwgQVRNRUxfVVNfVVNNT0RFKTsNCj4gKwlpZiAoYXRtZWxfcG9y
dC0+aXNfdXNhcnQpDQo+ICsJCW1vZGUgJj0gfihBVE1FTF9VU19OQlNUT1AgfCBBVE1FTF9VU19Q
QVIgfCBBVE1FTF9VU19DSFJMIHwNCj4gKwkJCSAgQVRNRUxfVVNfVVNDTEtTIHwgQVRNRUxfVVNf
VVNNT0RFKTsNCj4gKwllbHNlDQo+ICsJCW1vZGUgJj0gfihBVE1FTF9VQV9CUlNSQ0NLIHwgQVRN
RUxfVVNfUEFSIHwgQVRNRUxfVUFfRklMVEVSKTsNCj4gIA0KPiAgCWJhdWQgPSB1YXJ0X2dldF9i
YXVkX3JhdGUocG9ydCwgdGVybWlvcywgb2xkLCAwLCBwb3J0LT51YXJ0Y2xrIC8gMTYpOw0KPiAg
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwvYXRtZWxfc2VyaWFsLmggYi9kcml2
ZXJzL3R0eS9zZXJpYWwvYXRtZWxfc2VyaWFsLmgNCj4gaW5kZXggMGQ4YTBmOWNjNWMzLi4yYTUy
NWI1OGUxMWEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdHR5L3NlcmlhbC9hdG1lbF9zZXJpYWwu
aA0KPiArKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwvYXRtZWxfc2VyaWFsLmgNCj4gQEAgLTUwLDYg
KzUwLDcgQEANCj4gICNkZWZpbmUJCUFUTUVMX1VTX1VTQ0xLU19NQ0sJCSgwIDw8ICA0KQ0KPiAg
I2RlZmluZQkJQVRNRUxfVVNfVVNDTEtTX01DS19ESVY4CSgxIDw8ICA0KQ0KPiAgI2RlZmluZQkJ
QVRNRUxfVVNfVVNDTEtTX1NDSwkJKDMgPDwgIDQpDQo+ICsjZGVmaW5lCUFUTUVMX1VBX0ZJTFRF
UgkJQklUKDQpDQo+ICAjZGVmaW5lCUFUTUVMX1VTX0NIUkwJCUdFTk1BU0soNywgNikJLyogQ2hh
cmFjdGVyIExlbmd0aCAqLw0KPiAgI2RlZmluZQkJQVRNRUxfVVNfQ0hSTF81CQkJKDAgPDwgIDYp
DQo+ICAjZGVmaW5lCQlBVE1FTF9VU19DSFJMXzYJCQkoMSA8PCAgNikNCj4gQEAgLTY3LDYgKzY4
LDcgQEANCj4gICNkZWZpbmUJCUFUTUVMX1VTX05CU1RPUF8xCQkoMCA8PCAxMikNCj4gICNkZWZp
bmUJCUFUTUVMX1VTX05CU1RPUF8xXzUJCSgxIDw8IDEyKQ0KPiAgI2RlZmluZQkJQVRNRUxfVVNf
TkJTVE9QXzIJCSgyIDw8IDEyKQ0KPiArI2RlZmluZQlBVE1FTF9VQV9CUlNSQ0NLCUJJVCgxMikJ
LyogQ2xvY2sgU2VsZWN0aW9uIGZvciBVQVJUICovDQo+ICAjZGVmaW5lCUFUTUVMX1VTX0NITU9E
RQkJR0VOTUFTSygxNSwgMTQpCS8qIENoYW5uZWwgTW9kZSAqLw0KPiAgI2RlZmluZQkJQVRNRUxf
VVNfQ0hNT0RFX05PUk1BTAkJKDAgPDwgMTQpDQo+ICAjZGVmaW5lCQlBVE1FTF9VU19DSE1PREVf
RUNITwkJKDEgPDwgMTQpDQoNCg==
