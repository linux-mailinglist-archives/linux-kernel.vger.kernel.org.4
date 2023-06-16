Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E143C732D76
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 12:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245746AbjFPKXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 06:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbjFPKX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 06:23:28 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005051732;
        Fri, 16 Jun 2023 03:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1686910924;
  x=1718446924;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SjpAoS7BWUZgwIBiM3IKEoKzirJ8eH1VmEyeQuZZAYg=;
  b=i0P4/AYnd50PhN+XmVEu7LF7ierSLRJmZGGxVBYTJ8vRdnOILrHFgysj
   Fm/0lD+bmG8rxjLgnVsHLBOFFMka/BBdHxbFr49D/6zAPVu2yS5g2uy06
   qDvh2mktYi8I4qwxH18J3rMjLCVORMzcXCW8dYjscBBjQzjBihdBhOj+O
   /Mgdb9ANktkSleJM4aJ7Y5396D8Kw9cGYY8jYgxUAXX5LHQGfbke+BN52
   E7T+SUckPqavPi2waJ2dm2/HK43snlJv3Y5bdjoPCFbDo5Q4OyYNM7LNx
   v9xCcDdvqVh4qUdRLFqDhJB6CiTgGaON48XtZpAgTpsFTtf/0Prl68/CN
   g==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OPPpQKWDUGpmp6BgGKgNJMYUzYy5SDuXpokoqzH1OgO8cIYDk/D4eCFvViCtz63rfR2Sa9CzQ2rWJQKUJnNmNf0uJKMaroNp19m65eJquKvuiMMTDpw79jQimC7RXty05L+QdpyxItLuBhUSk9NkXFZ5LmOe7FZRJ2uf9/xVNpZxJq3GM5ocSHyGRLXtSUjJP5cZn8HnMFM0Q800L7DHFQ4j/fdcptVc+z4rgHe46D5IxE+goTm7XzHVUQDxIdyXgV0T4Sm3xcdYUsG3oWws0JBm/FzCHIfaFiAmhIIrJH6Vopo8i/1w2k+yh8wG5UbqX2Ai09j7FUXTNpCKZWdnoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SjpAoS7BWUZgwIBiM3IKEoKzirJ8eH1VmEyeQuZZAYg=;
 b=Vn9ZdkY0u1wYgStI9qcneYy+DxMX6VpKmE6TCNXxi8wwnDZXyT5n8LyBjAwSWKsF95KWuzOCpa1gQisqtzbEKETe3thJfKnvQU4ELGA8PBt1BSWBUZOKAw/EcDD5E/0FDx4WweV1E4htyrX02Hn0ZSO6JH7T4foGhRoPfbD6jJXEu0zuT9h7Cm/tf/drqMN2yvFvrGP+z4nd1VmLD8TqlPRl8pMVulFDGQqg9j8MnTxlWtXQTCgimsgBnV78/rr5B9SFuu8pd+M9c+efZVD9HLxZxISUWIh/JQDzdg1a6WhVddgnEIFgalOxRVkZNMaI2qsp05qeLhgt+aFJEUgDWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis365.onmicrosoft.com; s=selector2-axis365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SjpAoS7BWUZgwIBiM3IKEoKzirJ8eH1VmEyeQuZZAYg=;
 b=kXr5vLzCI/WO2CiIqiMV/TJir9TGKYkCXzuswv1r0nmEO8iUPC8eQBfFdVg5SQaeuABH3+Ec9J5QH9mbnvPSg7XvVQTOWL3/vKJyV3lnCmhDn+6cotYhmpNM6m8j9Is18S/R7cdZDrrb9mrJSLoVkc68ZCcML+lrBrrI9ailDsY=
From:   Vincent Whitchurch <Vincent.Whitchurch@axis.com>
To:     "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>
CC:     "jolsa@kernel.org" <jolsa@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        kernel <kernel@axis.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf annotate: Work with vmlinux outside symfs
Thread-Topic: [PATCH] perf annotate: Work with vmlinux outside symfs
Thread-Index: AQHZAML4roCOCeZ6W0GpL9358qtbR6+OdzSA
Date:   Fri, 16 Jun 2023 10:21:52 +0000
Message-ID: <28e5680b86806cb97f832f5646a0e2e9d8ee68f7.camel@axis.com>
References: <20221125114210.2353820-1-vincent.whitchurch@axis.com>
In-Reply-To: <20221125114210.2353820-1-vincent.whitchurch@axis.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.3-1+deb11u1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAWPR02MB10280:EE_|PA4PR02MB6703:EE_
x-ms-office365-filtering-correlation-id: fea53c0f-f4cb-48c0-2987-08db6e5380a9
x-ld-processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0+V3GbbOymEalEy8eyQOxXOHpeRQO+J4CEZUXWl56d0S1U6Gc2pE27QXaXsmPZk3pr2+GuiNVzlTuY8S7ll2ukXPnduJ0qAXrCEfyKrcj3fA5iL3DNuyKFgtuHkJhhpVQM+rAQU/YZ1z+h1V/+ztdDjVx0gUkohoEHY67jlCgUSRrf7H2s01ME8hrU3ZzVUjZrwABWERk5ZzgNaDlxDRsiVBjAFJUfzMByRuuwE3EDDPaqW+9TQZolgRtiB7l2s0JKt8ui7W/kcv583sg2sraWs9FMymiHDFsHE0F/u0AiEV3Iorp1LRcbyHutmSD7kMI8lCBwA/COfXML7I+nsPhjOTWblxDt7EQRG3od8CnHonSBDlUgRHdh0S9UKG0Vd3tPb+QJZASUZM0KAJ1yBhHg5f8qoidDgs99w1iiFjGh/74i40bPsmJq4WBvzG4qeDT6nw7992OEfBOgfpJsxsef4DrECN3o5KjAjsHHUkhnT7CPFRPh+cC1f2PdzgMD2fts3xTH0O5cxAzPvroc9cJXwYRa6oWbHwNe9VVt6pz3Y/Wp7BClhNNkcoPiAt0AwIeYe8JO7cI6zP93oNYjAEs653xiqDyCsnKBAegy06GKM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR02MB10280.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(39860400002)(366004)(136003)(451199021)(26005)(6506007)(6512007)(36756003)(478600001)(186003)(71200400001)(6486002)(4001150100001)(4744005)(2906002)(316002)(5660300002)(41300700001)(38070700005)(86362001)(8936002)(122000001)(8676002)(38100700002)(54906003)(2616005)(110136005)(64756008)(66476007)(66446008)(66556008)(91956017)(4326008)(76116006)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cU1QZTBCZkNuUE00ZXV6NFRNbndSWkx3R29Zc1NqOWg1djd1eXNsZTROYjU2?=
 =?utf-8?B?Nkc0RU9JaFB0UmVZT01xWkZQR0ozUmtqQU0vb09EOHAyNDNhK0RzQ1B5MldJ?=
 =?utf-8?B?N2NoOURKdjFZcjlmdFdNVDRaUFVzemNmcElidEUzVFVnSEVDdWFUdUJLdGNO?=
 =?utf-8?B?VDY0UmxyWWhwcWIrQjdiWGYrWlM2QWc0d2IyaDZ5VmJQRmo1WGwzZmhMTTV6?=
 =?utf-8?B?SHk1QUxWYkp3VG1yTUtPUi9qTWExc2ZOaWFkWGZGTitvNktMc1F6QW5VWUhl?=
 =?utf-8?B?ZFQwN3BJbGh6M2hPZXlOZEFSL2o3ZzY2TmVZcTJUZEx6WEVSVC8vbHZ5WHFq?=
 =?utf-8?B?RDFnNC9oNmhBbTBFbVUxVVFhYnd4bHc4YUtkWklqYlhSb0lLOHZYR1B6YWE4?=
 =?utf-8?B?VnZPNWwwRk5maHBSanc5bytUUDgxM3J5VTlwa1Roc0VmVGRaaHNXbnU3L0lK?=
 =?utf-8?B?eG5lODdVWWI5alhrd1JaUm9vMGVNK2lRcllVYUNiNHZnQ1NLcjczUmxaODVN?=
 =?utf-8?B?YTlzSStaUG5Nak5QN1EraTFITlltOVFNTTJrYnhpdjNlVWtnWmdRcm52VGQ0?=
 =?utf-8?B?ek8zQ3FIbFJMUEtXR09TekQxWmpXaDR5R2MxTmYrRGFhdERDWTlpQmR5Z1Ry?=
 =?utf-8?B?QTNHTGZjSkJOUGJiUFlNMTErbVE1SXVpVjhVQm5YNkRLSG54eWZLTTl0d21C?=
 =?utf-8?B?NEwyVGpRT3B2ZGtSZmRWTXhud2ZVaGd4V1JrVGwvYWpobWc3dE5OdUp5NUh4?=
 =?utf-8?B?dXdoM2NvNDQ4R3NDN0d1QmtubTZNanNVd0JGWWtKQklhNnNIbDJzMTZ2ejI4?=
 =?utf-8?B?SUs0Z004OGsvcFV4YVBocnc1em04dzF1V1BJYUs5dm9saSsxTUN4Rm1VM1Ey?=
 =?utf-8?B?ZkUrQldISVh0d0tPM2ZRREhna3RJSmhKK1AvSlg4TXgwSVZmMjA4T1BCWjlP?=
 =?utf-8?B?b2IxM3V5VkY2NC9STUgrNmVZZG5nOW1aMForQmlkMHY0cXMrZnh6Z1BhTGhI?=
 =?utf-8?B?UWVtQ3l3ZE5PQmZOeEZFT3E0SUp3QiswczlrYWlqR0FkclVXd0JjUWNvOHgy?=
 =?utf-8?B?S3hKMWlBQ2VvaFZrNWZHczlJYldwMHBoZ1I4YW9mT1pDZFBGNnZCamY0MEk3?=
 =?utf-8?B?QzdXNVUwdVM3aEpOdFllV0dyQ3hzQ3pGSnVzdE1ON0crUys5UEpNbjJ0TTd2?=
 =?utf-8?B?OWlibGovM2g1R2prUy9FZGQ5eXAwTmdlUE1KM2gveFl5VlVkT1I3a1l4ZUVF?=
 =?utf-8?B?TmVWVVhWQllWeTU3WXI4RTFodUtSRWRDUUtIQi9vcmZmSVh2WFhFUDZuZ3lX?=
 =?utf-8?B?KzVkcSt2QXE4YTl1UGJtR2VsdDl2WUdaMWErbHJ1ODlEYlFQOUR4eGZ2ZVE4?=
 =?utf-8?B?emZWOU5MRDBnNUhFWnFYYmxROVVQNVJYMFBaNFRJRlZ1anU1WGdsVmhYRWt3?=
 =?utf-8?B?aFlQM1RqZkVNMUVzWmZWNkhLdlZ3MG5sQ2xtS1c5VFFudG9xL2MyQ25Lcmhq?=
 =?utf-8?B?d0czazFYbFJpNldnVXRDZnFueUdhWUhuY2lQRUFGMllQamZHWTBkYmY3ZFU1?=
 =?utf-8?B?TVJXNm9jY3J3UlJUdVBwTS92TWxXanBLalJDNUQreGRzWFQrenRmK2pEQWtp?=
 =?utf-8?B?TSsrRlZ1L2M1ZGYvSGd3WG1wS3hqSElPSlRLZVhMMDgwRE02L3BTOTR0clJl?=
 =?utf-8?B?eGExOUJPeTRWMmFJYVB3YmhTaUZBNzdnbzJuOGU1WTZvbS95aWxmc2I2T1Mv?=
 =?utf-8?B?dDZoNkhGYklMSVZuQTVvOW8zak9IUEpZZktYeER5UGJsWnk2MlZaQzBFTjNw?=
 =?utf-8?B?Q1g0MDJmbFMxVFU2RWowOWFnVkFlQ2FOSEllYnhUdVdIT1ZFeVNzcldCMU1H?=
 =?utf-8?B?cXRwc2NJK2FJZ2ZXTmlkY0J2K1Y1VUdacGliVW04eHRkZVlHc3lTUW41Q0p6?=
 =?utf-8?B?NTRiVEFJZGhadk9TQVNSeFdKMGxsVk9NS1BvNEV2UW1KZ2N5WEJHc0VnaVNN?=
 =?utf-8?B?eHMweVYvUUtxVTN1elFmOWEyOG9EeVFJTGpUNTZiVkY4Z3Y1VU1JaTIxVDBM?=
 =?utf-8?B?M3o1SGRKU2k5OXhLY21Wd2YyU3NsajBtVXRSN08zSjRoM25kUFpyd1d5SVM0?=
 =?utf-8?Q?CD4DK8rJ6E/f4jHbI/Pw9WNoq?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CCD33F6122F6FE4E902024E660FD7D6E@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAWPR02MB10280.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fea53c0f-f4cb-48c0-2987-08db6e5380a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2023 10:21:52.2737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EBbZIQlgohXIzSV+OU4THejsoBui+plQmQ8Ru0gzkKVwsr8K/vDbmvgwBulKwxpm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR02MB6703
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIyLTExLTI1IGF0IDEyOjQyICswMTAwLCBWaW5jZW50IFdoaXRjaHVyY2ggd3Jv
dGU6DQo+IEl0IGlzIGN1cnJlbnRseSBwb3NzaWJsZSB0byB1c2UgLS1zeW1mcyBhbG9uZyB3aXRo
IGEgdm1saW51eCB3aGljaCBsaWVzDQo+IG91dHNpZGUgb2YgdGhlIHN5bWZzIGJ5IHBhc3Npbmcg
YW4gYWJzb2x1dGUgcGF0aCB0byAtLXZtbGludXgsIHRoYW5rcyB0bw0KPiB0aGUgY2hlY2sgaW4g
ZHNvX19sb2FkX3ZtbGludXgoKSB3aGljaCBoYW5kbGVzIHRoaXMgZXhwbGljaXRseS4NCj4gDQo+
IEhvd2V2ZXIsIHRoZSBhbm5vdGF0ZSBjb2RlIGxhY2tzIHRoaXMgY2hlY2sgYW5kIHRodXMgcGVy
ZiBhbm5vdGF0ZSBkb2VzDQo+IG5vdCB3b3JrICgiSW50ZXJuYWwgZXJyb3I6IEludmFsaWQgLTEg
ZXJyb3IgY29kZSIpIGZvciBrZXJuZWwgZnVuY3Rpb25zDQo+IHdpdGggdGhpcyBjb21iaW5hdGlv
bi4gIEFkZCB0aGUgbWlzc2luZyBoYW5kbGluZy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFZpbmNl
bnQgV2hpdGNodXJjaCA8dmluY2VudC53aGl0Y2h1cmNoQGF4aXMuY29tPg0KDQpUaGlzIHBhdGNo
IHdhcyBub3QgbWVyZ2VkIGFuZCBJIGRpZCBub3QgcmVjZWl2ZSBhbnkgY29tbWVudHMgb24gaXQN
CmVpdGhlci4gIFNob3VsZCBJIHJlc2VuZCBpdD8gIEl0IHN0aWxsIGFwcGxpZXMgY2xlYW5seSB0
byBjdXJyZW50DQptYWlubGluZS4gIFRoYW5rcy4NCg0K
