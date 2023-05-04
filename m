Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72566F692E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 12:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjEDKhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 06:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbjEDKhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 06:37:03 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED2146BF;
        Thu,  4 May 2023 03:37:02 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3449XJrr026650;
        Thu, 4 May 2023 06:36:53 -0400
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3qca678a4x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 May 2023 06:36:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VKQLkxyh6rypC7qTjvuj31u3uIM9pYZWl5SBLzXgyyHVK8t3eKZByimTuEt7boH/rtchnFG4sJqtD+qIqkIiHz8YPI97CHh2/61Waolar9WCT98LF9ej3YydfMWox/Gc2vyultRZc7eVH30ij8vjuFdar6Z7w4PiztjrPFHJqu0n1L3by+50uXQpArA9rnP7OqtI7qMiiqdZDH6ARp7Sm7M7rkvJhZftAjhCVRJd625jX1NXwD3Q+wCKb8/X1Lc8RT+5l1Et1oUde2t7uz/D/v5mZcE0/Oc2FnBkm1tgkbBt3R5nlLB9JhwJzfELy/QpLk/BEJZBuWZAEnV6yOMJMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G7uAdD9fty5U2kUWAcHLEDHBoUidp7340xW48ukZkl0=;
 b=lUqk3bMOQKkEiyOSDfmEfEnzEK3trFZBLJLnuoFRzu3c6gV6Z8EYOEST2bz0T14hFhre/D6slq5Ay+uDLUCV2UAisQsddJyaRYg0gP0Ipf/Q5/QkMhaAdW8vEVChRMsg6gcjvJEFyuqhXIuEdsaPh069DNY17JSRrv3rA7qXmzvPmeBK8LaCJfxmJwdLsj43boBEkEClPQEunNmrR6XJ9pxYIJwxterBan9S21uxfUSFZmKiZWZdmC5/dheI2hzmGR5lJIyql3dn6eAOYAuj2xN2UqFtGTl271GEIGad4+dlMHBR93dFvmPFrTmx/fKV30pAG259IuH/G/lbQ3APBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7uAdD9fty5U2kUWAcHLEDHBoUidp7340xW48ukZkl0=;
 b=f5goRLIPDojHIMCPxbwUKrCuPN+K9oVuXkFn3jHVvejEAvfh+4cDbvggck6xX4sTeiqk2e5i4q6s5JCt6PdWfKBRAYZDRBAucElGPUuBaFoCTzEBnuzPwwPaGvqKF9DXRIDXUFJvQM8LasJWboYIOEDAryjhfRbQL5cTShk3naU=
Received: from MN2PR03MB5197.namprd03.prod.outlook.com (2603:10b6:208:1f0::18)
 by SJ0PR03MB6583.namprd03.prod.outlook.com (2603:10b6:a03:388::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Thu, 4 May
 2023 10:36:50 +0000
Received: from MN2PR03MB5197.namprd03.prod.outlook.com
 ([fe80::c8df:77bc:8e3c:f92b]) by MN2PR03MB5197.namprd03.prod.outlook.com
 ([fe80::c8df:77bc:8e3c:f92b%5]) with mapi id 15.20.6363.020; Thu, 4 May 2023
 10:36:49 +0000
From:   "Arslanbenzer, Zeynep" <Zeynep.Arslanbenzer@analog.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "lee@kernel.org" <lee@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "sre@kernel.org" <sre@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>
Subject: RE: [PATCH v2 2/8] regulator: max77658: Add ADI MAX77643/54/58/59
 Regulator Support
Thread-Topic: [PATCH v2 2/8] regulator: max77658: Add ADI MAX77643/54/58/59
 Regulator Support
Thread-Index: AQHZXIM8C51C6TXz5Ua0Sg7/OZuyM68Gdq+AgEBJ7aCAAAc2AIADEeNQ
Date:   Thu, 4 May 2023 10:36:49 +0000
Message-ID: <MN2PR03MB51973E709B85F83606D987038B6D9@MN2PR03MB5197.namprd03.prod.outlook.com>
References: <20230322055628.4441-1-Zeynep.Arslanbenzer@analog.com>
 <20230322055628.4441-3-Zeynep.Arslanbenzer@analog.com>
 <ce89857a-53b3-d63b-c1ad-5d28fd7d8f80@linaro.org>
 <MN2PR03MB5197DF4EEA50D6CB5DF311098B6F9@MN2PR03MB5197.namprd03.prod.outlook.com>
 <07c36d46-76c0-1bad-a124-55b96aff8347@linaro.org>
In-Reply-To: <07c36d46-76c0-1bad-a124-55b96aff8347@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jZW1WNWJtVndMbUZ5YzJ4aGJtSmxibnBsY2x4aGNIQmtZWFJoWEhKdllX?=
 =?utf-8?B?MXBibWRjTURsa09EUTVZall0TXpKa015MDBZVFF3TFRnMVpXVXRObUk0TkdK?=
 =?utf-8?B?aE1qbGxNelZpWEcxelozTmNiWE5uTFRoalkyVTRPV05sTFdWaE5qY3RNVEZs?=
 =?utf-8?B?WkMxaVpqVXhMVFpqT1RRMk5tUmpNRGt4T1Z4aGJXVXRkR1Z6ZEZ3NFkyTmxP?=
 =?utf-8?B?RGxrTUMxbFlUWTNMVEV4WldRdFltWTFNUzAyWXprME5qWmtZekE1TVRsaWIy?=
 =?utf-8?B?UjVMblI0ZENJZ2MzbzlJak0wTnpnaUlIUTlJakV6TXpJM05qY3dNVGs1TXpV?=
 =?utf-8?B?MU5URTVNU0lnYUQwaWNIRXdSbmxIUm5oelIycHdlRlJtVVZwNGVGbEdLelEw?=
 =?utf-8?B?Tld4WlBTSWdhV1E5SWlJZ1ltdzlJakFpSUdKdlBTSXhJaUJqYVQwaVkwRkJR?=
 =?utf-8?B?VUZGVWtoVk1WSlRVbFZHVGtOblZVRkJSVzlEUVVGRU0xWkRiRkJrU0RkYVFX?=
 =?utf-8?B?UktOVkJJUm1WWldrRTVNRzVyT0dOV05XaHJSREJFUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVWhCUVVGQlJHRkJVVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVVkJRVkZCUWtGQlFVRlRha1ZZZUhkQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZLTkVGQlFVSm9RVWRSUVdGUlFtWkJTRTFCV2xGQ2Fr?=
 =?utf-8?B?RklWVUZqWjBKc1FVWTRRV05CUW5sQlJ6aEJZV2RDYkVGSFRVRmtRVUo2UVVZ?=
 =?utf-8?B?NFFWcG5RbWhCUjNkQlkzZENiRUZHT0VGYVowSjJRVWhOUVdGUlFqQkJSMnRC?=
 =?utf-8?B?WkdkQ2JFRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlJVRkJRVUZCUVVGQlFVRm5RVUZCUVVGQmJtZEJRVUZIUlVGYVFVSndRVVk0?=
 =?utf-8?B?UVdOM1FteEJSMDFCWkZGQ2VVRkhWVUZZZDBKM1FVaEpRV0ozUW5GQlIxVkJX?=
 =?utf-8?B?WGRDTUVGSVRVRllkMEl3UVVkclFWcFJRbmxCUkVWQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVkZCUVVGQlFVRkJRVUZEUVVGQlFVRkJRMlZCUVVGQldW?=
 =?utf-8?B?RkNhMEZIYTBGWWQwSjZRVWRWUVZsM1FqRkJTRWxCV2xGQ1prRklRVUZqWjBK?=
 =?utf-8?B?MlFVZHZRVnBSUW1wQlNGRkJZM2RDWmtGSVVVRmhVVUpzUVVoSlFVMW5RVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVKQlFVRkJRVUZCUVVGQlNVRkJRVUZC?=
 =?utf-8?Q?QUE9PSIvPjwvbWV0YT4=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR03MB5197:EE_|SJ0PR03MB6583:EE_
x-ms-office365-filtering-correlation-id: 44119f4a-5957-423b-f644-08db4c8b77b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1MRhHFw5gvqOStN5bIO6Pv9Q6pT89ngTi2IzH/dy27IktpS5qoEUyJWzEgoyPSPKjDL4st88vVDWy5MnM7yt21cPADRVoIJ27FMKrBrMHL+po/AIrREr0zxbObGyYKHdY3M8w09AWVOS4xfaN2QKZO5YdnQdGr0HtM+8zqyNo/DfkJovZXdBlE792b3TQgtGWGd/4QWzaI8FpkYYo6NG8zyLeedmersgRT4KPgLo2JL/FD2wnj0JUiyLK/p4L6mdKewxU2bBWE8tT5vpKW0AXUyujhNv45EQ5aXlrM2A3XUaKllnc19lD1xSkC9jI7S36lldncNg9Ct41TeWv9XfgkmfqAZ6UMLo4uLqdjAys/zet6mXXaNYYg3tQd+5G2rujaRzG5rniLIjDyFWyS3IWSvn+QGw1yjgq1avV8leYxA7cvhEOW4jF8iKzg0mcMwmBAbWWbLgvYdntBPHrk/oB4/qMt6XSGWY7SA+O050oors4DKLxIBC9f67/z0Fif+OAlZ02NE+u0Kp5bJK4hlSzO50Pmq2i4bpqIGv4mV3Ixa+OfKC87YahihzXhJbBTEjLY4SHUMF5kU1n0BC2N9KP4zIypgg8XeREKKeunIO14y66DZI8Gi/DdIFcacZazqP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB5197.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(451199021)(86362001)(33656002)(7696005)(54906003)(316002)(6916009)(4326008)(66556008)(66446008)(64756008)(66946007)(66476007)(76116006)(71200400001)(478600001)(52536014)(55016003)(8676002)(8936002)(7416002)(41300700001)(2906002)(5660300002)(186003)(38100700002)(122000001)(38070700005)(53546011)(6506007)(9686003)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QnEzbWwzcnZUVHIzUFVzUndpTVVOQm1oVzBYYUhkTEZoL1djWjZ1MS9ycmJU?=
 =?utf-8?B?YzhUekZFTGhWYWpHNGduMTg0REpCQ1lkRy8vb01JT0JzNFJ6TW9SYjNuN2J2?=
 =?utf-8?B?MUV0SXRWeWc5WW8vQWt5d2tUUzNVWEg5bS9Sb1dra3lVclllbktXdEcxYmVh?=
 =?utf-8?B?emJhQ2F4TFdpZjJrWEUyZEFWN3FhdFJLNjI4ZzltVmMxSENOL0NFWXF0NGd0?=
 =?utf-8?B?c0p3TS95bVRld01ieTk0aWVqdDZOUy9FK3JvL1FFRFQ1RXJXQ0VneWpyNW5P?=
 =?utf-8?B?alc0dkM3dDZDVm52eE55Tk1QaXBIdGZPbnlSOVBod2R6ei9JMHhyV0lsWTR3?=
 =?utf-8?B?bzN4OWwyOVJTVWVIYUl4QnhjRDJ2eWQ4cU1UK2FudEJySmxnZFQ0Ny80Ym5t?=
 =?utf-8?B?SU1TRStzbWlVMVJMeE4rdldSRmNwMmdFMWJqdDRTRnRiN00xWWRVcERzNnBs?=
 =?utf-8?B?M0w5UC9FbjlqTzJVV28wT2pYVVVOQTc1ckViTk50U1pDVkt4czZ4S1JpWmVn?=
 =?utf-8?B?YTh4d2RuK1BhVk1BeVZERTlEeTBaUkV3QkdNTHlHL0JIN2VndWpYUys4R20z?=
 =?utf-8?B?RHNBTWpOTzlZVUl2ZmJ1ZFpuNm9rUTZSUmx1OUNwdEg3VnRhYXg1TUdURUVB?=
 =?utf-8?B?bnU5eUN6aHNyK21vWS9zZ1BFYUg5UjdHaXdBL3ZJYlNGTDVycWZGclg0d0lD?=
 =?utf-8?B?V1BMemdpSlZiMVozdUpFbHlRdjFlY3FZb2hDallERFlLdjdXalN5TkQrbjh0?=
 =?utf-8?B?RU5ZWjl6RmhrWW8wODZmVWNodXZyU0REK3E3Q29NcWRXRjltTyt3SDdIVXl1?=
 =?utf-8?B?OGlLcU1JUXhxcE03Q2lXMk8wVW45WktOVVgwcmg1c3lPTHhoQ2h2TmFjZmhk?=
 =?utf-8?B?ZHM1ZWdCSHc4RnBXajd1djJrYkJIYXFQek1QZFV5MXIzd2QySDVpbDU3SGU2?=
 =?utf-8?B?SmJlNnB0Ymk1QTd3aHFCM0lKbDlyUjNZWlNzcVB5WHFReWVTcDNPZzU0MU1W?=
 =?utf-8?B?Vjg2cUZuMi9jSXpOajYrYWtiK1BRREl6cFI0cis0OWREenJONi9CMWlydEk5?=
 =?utf-8?B?SlozbEJCWDZURHVxTnlXQmRoK3VDSWY2enFWMk12bzBJaTlkemZ4a09VMUE2?=
 =?utf-8?B?V0d5NStHdE9QWnVoUk1ia05iUkhJWjhSQ3ZYK01PNHJPNGlTaU0wc0NlWTNB?=
 =?utf-8?B?YVZPZ3JZSjcxRFNBUll5Zzc3QTZSYTA5STFaUS9maXpzMXBWRFUzTFFKcHNx?=
 =?utf-8?B?Zm5oSGpPb3ZPVWNma1pqcTVIL25IVHorTEsyODcwLzFldm8xRi9ST1Njck5t?=
 =?utf-8?B?VWtoVTA0L29VVWtMREJncVgxcEN1SDlVUjVtWVBTbk1uS0NQR1JEaVcxVFlE?=
 =?utf-8?B?b0R5TGtJaWZtZ3MwUHpxdnh6bkVEVU9rREhXUWdTL3VZL25wNWcwTjlESmp6?=
 =?utf-8?B?R080OHNlMW1rQ2NhWmxiZ1FSejhqaGs1VW9tWHZxbHZab3JGOHN6T1dvMlc4?=
 =?utf-8?B?WDFNRGhMcWZxVGdkN2Z2V05CaUdPSmgyU01sWjMweC96OWprdFRTVHZoUU9h?=
 =?utf-8?B?WXFQS2g5ZEhqYzFZcGZKM212NkZaMlNYK2w0M3R4NGhRcmpHOHlYaytCdXEv?=
 =?utf-8?B?Z1Q4RHQwVGJuS3g1dnhlMlVzaWJia0d6cUFzNyt0THNwajBLUVVtVThjTjhZ?=
 =?utf-8?B?MDdtMUZmcVVRSVBXNDhkZHY3OWs4RWpTL0VOaVZZV09hb2pDUXJsb2tXN0c2?=
 =?utf-8?B?ZkcvVE5ZZ2xKVzZlelB1Vm5jVDJUS1ZCK2xSTGJKWVpQaGIyTEszM2ZhaHZw?=
 =?utf-8?B?Tm9zMHI5ZlZNSEpzM0lXc3pwc250d0tvS20vOEJSc2UzcUVaODZ3M2pKYU1W?=
 =?utf-8?B?d29IdWFEYU9ySUE3VklQb0dFN2Z2VHRwRnBCNGtsbzZ0TFpqdytIMUk2UkU5?=
 =?utf-8?B?YkJyUk1wTUdSYVZBcnVsNmxVRWdMbTdkdkZONWtzcUlqNFF1dkVFVXhIOW51?=
 =?utf-8?B?MkE1amhxVHpsUXAvaWdXUUx1bVZwUURNYjFGNllrYmlSdFVUTktDUW1QcHIr?=
 =?utf-8?B?UjJoQ1hwa2VMNHhMV0Q4MHlLNkJIT0F3L3diZFJkV3dxbjBCMmN6N0JuaFlu?=
 =?utf-8?B?alIwekU4VFl0dDZMRGhvS29haG90RE5wUEZmdU5mVTk5SEwvckh0TnZLR08x?=
 =?utf-8?B?aUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB5197.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44119f4a-5957-423b-f644-08db4c8b77b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2023 10:36:49.5666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ik9vDA6qL+3H7c/r6MBT7I9EfDfN9ffyPkorVE+rA9fQTmmcL/VMWqf6lbjkPacMiPJAvv8+TzHFTGK+2+4nrKH8PzN14Iy/rmGgNWmHzMc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6583
X-Proofpoint-GUID: HPHFrYDGH9HH7-D9mKQ6QQB-ECw2QiI3
X-Proofpoint-ORIG-GUID: HPHFrYDGH9HH7-D9mKQ6QQB-ECw2QiI3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_06,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 suspectscore=0 impostorscore=0 adultscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 clxscore=1011 mlxlogscore=999 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305040086
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyIE1heSAyMDIzLCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPk9uIDAyLzA1
LzIwMjMgMDg6MzIsIEFyc2xhbmJlbnplciwgWmV5bmVwIHdyb3RlOg0KPj4gT24gV2VkLCAyMiBN
YXIgMjAyMywgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4+PiBPbiAyMi8wMy8yMDIzIDA2
OjU2LCBaZXluZXAgQXJzbGFuYmVuemVyIHdyb3RlOg0KPj4+PiBSZWd1bGF0b3IgZHJpdmVyIGZv
ciBBREkgTUFYNzc2NDMvTUFYNzc2NTQvTUFYNzc2NTgvTUFYNzc2NTkuDQo+Pj4+DQo+Pj4+IE1B
WDc3NjQzL01BWDc3NjU5IGhhcyAxIExETyByZWd1bGF0b3IuDQo+Pj4+IE1BWDc3NjU0L01BWDc3
NjU4IGhhcyB0d28gTERPIHJlZ3VsYXRvcnMuDQo+Pj4+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IE51
cmV0dGluIEJvbHVjdSA8TnVyZXR0aW4uQm9sdWN1QGFuYWxvZy5jb20+DQo+Pj4+IFNpZ25lZC1v
ZmYtYnk6IFpleW5lcCBBcnNsYW5iZW56ZXIgPFpleW5lcC5BcnNsYW5iZW56ZXJAYW5hbG9nLmNv
bT4NCj4+Pg0KPj4+DQo+Pj4NCj4+Pj4gKw0KPj4+PiArCXJldHVybiAwOw0KPj4+PiArfQ0KPj4+
PiArDQo+Pj4+ICtzdGF0aWMgY29uc3Qgc3RydWN0IHBsYXRmb3JtX2RldmljZV9pZCBtYXg3NzY1
OF9yZWd1bGF0b3JfaWRbXSA9IHsNCj4+Pj4gKwl7ICJtYXg3NzY0My1yZWd1bGF0b3IiIH0sDQo+
Pj4+ICsJeyAibWF4Nzc2NTQtcmVndWxhdG9yIiB9LA0KPj4+PiArCXsgIm1heDc3NjU4LXJlZ3Vs
YXRvciIgfSwNCj4+Pj4gKwl7ICJtYXg3NzY1OS1yZWd1bGF0b3IiIH0sDQo+Pj4NCj4+PiBXaHkg
ZG8geW91IG5lZWQgc28gbWFueSBlbnRyaWVzPyBUaGV5IGRvIG5vdCBkaWZmZXIuDQo+PiANCj4+
IFRoZXkgYXJlIHNsaWdodGx5IGRpZmZlcmVudC4gSnVzdCBNQVg3NzY1OSBhbmQgTUFYNzc2NDMg
cmVndWxhdG9ycyBoYXZlIA0KPj4gZXhhY3RseSB0aGUgc2FtZSBmZWF0dXJlcy4gTUFYNzc2NTkg
YW5kIE1BWDc3NjQzIGhhdmUgMSBMRE8gcmVndWxhdG9yIGJ1dCANCj4+IG90aGVycyBoYXZlIDIg
YW5kIHRoZSB2b2x0YWdlIGJhc2Ugb2YgdGhlIE1BWDc3NjU0IHJlZ3VsYXRvcnMgaXMgZGlmZmVy
ZW50IA0KPj4gZnJvbSBvdGhlcnMuIFNob3VsZCBJIHVzZSB0aGUgc2FtZSBlbnRyeSBmb3IgdGhl
IE1BWDc3NjQzIGFuZCBNQVg3NzY1OT8NCj4NCj5Zb3VyIGRyaXZlciBkb2VzIG5vdCBjaG9vc2Ug
cmVndWxhdG9ycyBiYXNlZCBvbiB0aGVzZSBjb21wYXRpYmxlcy4gWW91cg0KPm9mX2RldmljZV9p
ZCB0YWJsZSBjbGFpbXMgYWxsIGRldmljZXMgYXJlIGZ1bGx5IGNvbXBhdGlibGUgYW5kIGRvIG5v
dA0KPmRpZmZlciBmcm9tIHJlZ3VsYXRvcnMgcG9pbnQgb2Ygdmlldy4gSWYgdGhleSBhcmUgZGlm
ZmVyZW50LCB5b3Ugc2hvdWxkDQo+ZW5jb2RlIHRoZSBkaWZmZXJlbmNlLiBJZiBub3QsIHVzZSBv
bmx5IG9uZSBlbnRyeSBpbiBvZl9kZXZpY2VfaWQgKG9ubHkNCj5vZl9kZXZpY2VfaWQsIG5vdCBi
aW5kaW5ncykuDQoNCkkgdXNlZCBpZCB0YWJsZSBtYXRjaGluZyBhbmQgSSBkaWQgbm90IHVzZSBv
Zl9kZXZpY2VfaWQgdGFibGUuIFNob3VsZCBJIHVzZSANCk9GIHN0eWxlIG1hdGNoIGluc3RlYWQ/
DQoNCkJlc3QgcmVnYXJkcywNClpleW5lcA0K
