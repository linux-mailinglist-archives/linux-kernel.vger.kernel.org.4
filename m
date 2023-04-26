Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF246EF4B1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 14:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240857AbjDZMv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 08:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240318AbjDZMv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 08:51:57 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A5FC5;
        Wed, 26 Apr 2023 05:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1682513516; x=1714049516;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=sG4QLDiJoDqIutb8IyTanGuVq7zV+Yaq1xy8IsiI6vE=;
  b=BQQFc8fP5NmiRf4oAIAy/7ZeXeSZ2YyzMf47TuTGe88P4m0MxmltCz3w
   U62EMcHdShzhWGR4OsSPjo/DdVQOqNU/ZAwu0aZgAHUZuTGTNpJniBI3E
   unNELPHqG2KVXkOTqotiKzFDWp9svvZaX6I1A6Kp4xvcRiAx2UClsytPb
   ZptMy1V3FUdpChn/5iaKPwyI0tQJSbNtzxWqKl04OM99faMRp0yg/UI2Z
   39BPWSHc37cYld7/m9Am1gUpFah40TbsT88ulU85fVjocubmsZ+4inL79
   K4q+FqdXpKgWa+ZT5QfaCUiKEpe5pRk1EpT7TIth9IUyCWmSF85rKFkh4
   A==;
X-IronPort-AV: E=Sophos;i="5.99,228,1677513600"; 
   d="scan'208";a="341373380"
Received: from mail-bn8nam12lp2177.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.177])
  by ob1.hgst.iphmx.com with ESMTP; 26 Apr 2023 20:51:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IN7XKvlLuLJLsnLwW0SVNgHVJtE3qQBQ8T6vULt671HcDC2TQTv9FOv4iTF7EvJ9qP8Oe7rgVyNSDJi1uRU5rWv92SqSQnsHulKva2gXyeBk4S47JNYKggKG9Jng0oVkIoH9cf3uQCTHf3Uwt6je8elZMV3rw+U5OCyQvBtdJPlBvGxp/sZb6eLe3ubbticXKxcMLCOSqBo6kdfslDM1uBILgO2g+aRA/26TYn0YK3rc5UNneHngSIbeftZpdhjrRymWnf9LnNNJKaUUgkIS7dUijICnZ2jdIwhfM7wvFQcHUW9t0foyYdSn0UpyMKOwDp4H4DjJ+OWYh4aJsmjlpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sG4QLDiJoDqIutb8IyTanGuVq7zV+Yaq1xy8IsiI6vE=;
 b=BPxRkhR8qpyV7B+gW1lhTGtkDWDIoLjW9QGtuCi7GWIgAMgxLccP8wxCqivL0EwqhfWU02kIS8HiZob8CRPdx8O59eLqESBtEwk9dnx4OW2FW4GWen8GD/OEFDzjRJf/upXtvjtHuX/TzZ5k2d+ek+5ZWCVOLx7is8+WpBkxRKnfK45ngnjJYkZYtEaSqyyIjIDZSrLnNZM8t/lg6z/D6p9FvT54QBCGxsJAUHvP9O2RIXkBhxI7mhz1nmdWfltAL4ghkt1P/fOr0F4TrffqEIME16rtMw1YTRfVuT7CeoGCR4xkd6wl2ylSNFoB/sEOD+OL6OYiXLCk6Fw8YrPejw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sG4QLDiJoDqIutb8IyTanGuVq7zV+Yaq1xy8IsiI6vE=;
 b=jX6CmkRDCHw/fuafg4AdjZ8i/cKMhZEgIBwmINg5+pKC+hLRZPBjyTESr9D9ZAoSL+5pvJDYpty5H2ofGW2iE3ArfdCOhc+Ct8KSSlOWho96FZ8odmRLj91661sw1be2laYfmbgfkAd9PN27vINDq4z31ksrREO1FrKWu3NG0Zc=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 CO6PR04MB8346.namprd04.prod.outlook.com (2603:10b6:303:135::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Wed, 26 Apr
 2023 12:51:53 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::188b:9005:b09b:81e2]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::188b:9005:b09b:81e2%6]) with mapi id 15.20.6340.021; Wed, 26 Apr 2023
 12:51:52 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     "keosung.park@samsung.com" <keosung.park@samsung.com>,
        ALIM AKHTAR <alim.akhtar@samsung.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "quic_asutoshd@quicinc.com" <quic_asutoshd@quicinc.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] scsi: ufs: core: Simplify param_set_mcq_mode()
Thread-Topic: [PATCH] scsi: ufs: core: Simplify param_set_mcq_mode()
Thread-Index: AQHZd/8IxGoJQ9LIDUCxoOUXW8/UEa89i5lQ
Date:   Wed, 26 Apr 2023 12:51:52 +0000
Message-ID: <DM6PR04MB657596E92FE57024D31E3A4BFC659@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <CGME20230426052153epcms2p27d64a865f15bfd452d564f77d63605db@epcms2p2>
 <20230426052153epcms2p27d64a865f15bfd452d564f77d63605db@epcms2p2>
In-Reply-To: <20230426052153epcms2p27d64a865f15bfd452d564f77d63605db@epcms2p2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|CO6PR04MB8346:EE_
x-ms-office365-filtering-correlation-id: b2797d7e-fa81-4cd8-9fb6-08db46550241
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I0msGHSrXj1MHiFedl3pQLNDf6yjKJVyyCjd1mmcVA5IS54m86THkXQNPiP8R5QtAsGTUizcP4YKh0P89HAcTFSmTNuOph4IOjc+GT8b4NVmcE/PmTdh7YmGqvg7dybQVyomAEEJRpdLra2TsJWgZZulftFvfTY8qeeR2V62eKWnfLG9gXJwuB5/8cBwpOyJBgJM28blRaMzreP2+sP9QY+GAL74+Xbt4OVPgYMI/ZZQFOqNAPCrXOkgewc70cbLuxlCo6xOwP06hgPI7pp9Q/vSyyeN0thN9Jqn77t9dZhYVqjM05QnAbyhQsjS2Vcp4VJ/22rMhPHo18YKZuEJxxtMbEbXlISHHTL4xWbH3Bt2KK6d3sILy2bw1EP9MnYKLrl7O/BMM4hV1gpyu7NUfaNpdiB64jcr54z7OCLmd+ZOICLR74XssUn8oCqZCgGHUM/r2iBNN77+l41uiGYYaWlKTqIL2mxoMUCz9InoRTpDfnf5DXwV6XBWGecBHpNAy5p3S3DAhNssxU3yeKEN9gi8um0wYy9n7jTHqeLmRfj8UaShNd4glpCToVZsccw6trJVBJg8D/I/y96iNdxiA7VmWFuTBi9PIU1+UfzF2x1Fewq5xs0trVqZ6jnudqHuOAQQmqElXj8jInfTHcVVCg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(366004)(136003)(451199021)(86362001)(33656002)(4744005)(2906002)(38070700005)(55016003)(7696005)(71200400001)(186003)(83380400001)(9686003)(6506007)(26005)(66446008)(76116006)(66946007)(66556008)(66476007)(64756008)(478600001)(41300700001)(316002)(82960400001)(122000001)(921005)(5660300002)(52536014)(38100700002)(110136005)(7416002)(8936002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MEpDNXhuK2Zic3lydjNQMDNWWUhlQmhPekszdzFJa2ZKS08wMWVlR1BmZmI3?=
 =?utf-8?B?azR6QUJQOUQvL0VXRFhMQmlPMFFDNUlSc3BRRlpnLytDR3hEWWtjUSszK0FY?=
 =?utf-8?B?MVNUT3JOWGlyLzhLdlJ4VVZOZStHajFkQ1RCTWFFdUt4Wm1iMWNpZmpEVW9m?=
 =?utf-8?B?L204RXJxZGM0VzZMTFU4SmxnRE1PdzZmMVFqQjNJR0FWdTVUVGFyeXNmYytD?=
 =?utf-8?B?UW5xWTQvdzNZVURWSE9hUlhBUjFvV1BleVJTMThoT2piQ0xkcEQrU0F4NUlL?=
 =?utf-8?B?VHROYk1STkUwNStLOUdPK3ZMdEE3cnlNQWh2Tmx6eHFVOXFSQkdGbXQ5WUEr?=
 =?utf-8?B?QzJPRHJRTzlPZHErZ0dGVnhBZ20yaG9DdGRKM29SSWdneTJ0c1dhWWRZdHRV?=
 =?utf-8?B?YWFWWk82OHduUTNaWlptQXg3K0hkQTdXMHhRSUdSUkNPczFvSm5PQ3dTeFBJ?=
 =?utf-8?B?TG5qaTB4QmJhOHByUllCY20yRldFRDhncWdtNUEyZXM2OWRlUXMrd3piK3Ji?=
 =?utf-8?B?ZmZYWVdWMFhlTUFjd05EbTVYZG8rVDVXTERVYmUvMVZZS1Z1WjlYNnhiWlBy?=
 =?utf-8?B?eWJ1dWhvNGxUcUg4WFkzUFZ4R0xRdWNMN3RRRi9wUUVpT3FvM0NKY3ZRajZB?=
 =?utf-8?B?ZldNNnpFaEF0ejBjUk12cXFhb1kxY3BvNEt5U2JZaHhwaG9KQ25nQXVyZVd6?=
 =?utf-8?B?WlFOWC81OUp0Unlab0N5bTc2QU0vRVZ5anNPK3VaR05ubGRkTjlVbXZNREVY?=
 =?utf-8?B?ZXJ3STlxeVQ5N0ZuSkJPVHB4YVFRRUNNakYzREdtL29KSUptMGFidFJXdUJI?=
 =?utf-8?B?L0paUXJiUDAxTkdGZ3o3dVk4UnpOZjdrVm1TanFmdkZKTTNPTnFPTEtMaHo1?=
 =?utf-8?B?aE4xYjdwUDExRlJkNmorQUFFYTNnTUpYREQ1WW1URkNwSURoakQ3OCtaRTRq?=
 =?utf-8?B?c3psK2ZQMEFkcXRkYnluQjVaMFZ0UFNYYWx1c3BaVWJWekNpMzJqNUY5QmQ4?=
 =?utf-8?B?Q0V3N3V5YWRvU3RVdFNJNUMzYmFzbDJiYW01cHQ5OHRIR2t3T3l5SHZTQy9l?=
 =?utf-8?B?c1dEV3J2ZXZhb1h6VHcrZXFwcEpBOWRKYzUxWTZPNDQxRlk0d2taQkppZkhD?=
 =?utf-8?B?WDFXYzhEOGJPR2xUTk1xNjJrTWZhOXBEZXNKUVdOb3MrY0FOSmpxVktSejA5?=
 =?utf-8?B?Y2JkRzdncU5FcE1aMDBiOXU1WTJ5RTlNSEo0SGJsSEw1RW96aTVQRXh4Y3Z1?=
 =?utf-8?B?M0EvUnhrSTdSejVQOTczd1h5RDQ4dzFTcFQ4Q3NkbHlud0RuNDhKbDYzRlM4?=
 =?utf-8?B?QkNGVEx4MVJ0bkpwajF3dTNjYzVpc3hZS1p6UEFBb1A4VUk1dGF1NE90V1cx?=
 =?utf-8?B?Rlg0M1B3MlRlNmE0S25ib3RnNkhxLzc1aDlyK3pFNzlyQzVwTUxrc01OMi9Y?=
 =?utf-8?B?UjdnTldMZEF0bzRtWWkyR0NQQ0pjR0tUcGZsamI3MktPUlA5R3VwNXVhbzhx?=
 =?utf-8?B?UlZoVzVWbHlBK1hoY2h5a3FOSUJ1dUJUREtXQS83OGNWUWtMOSszcU1FTng1?=
 =?utf-8?B?ZHc1MXh6RUZ0eG1hZWtDRDJTU3pqUUl0WHo5L0ZjVWhEUHRrc2ZoaExFUmZM?=
 =?utf-8?B?V3hoY2FySlMxL0xxMEFqUU92TjZMWS94SlNxMWhBRU45NlhCWFoxc3hON1Vu?=
 =?utf-8?B?a0pJUEhObFQ5a3paSnhjK1hiMkhGSHI1T05FY29TQ0dIbVZZMXJnSWh1TVBt?=
 =?utf-8?B?ZTBXYzJ5YURCK3dIMHpnK2J4MlhWejJTMldHSHJrVWJ1UFZQQmR3Ynd4TmFG?=
 =?utf-8?B?citVRUpYVllqbTVPVVVsbjNqTkRpQzduYkwvY04vbFhhaExhT0RENmIvemhN?=
 =?utf-8?B?SXEwMkJOcVlkWElHV2NGVEMxRytMOW1qVXF4Zk1kTk9jc2g3a3BxbFdleHgw?=
 =?utf-8?B?c0h2QklBclYyQWJOMnoyV01ReG1oY0owNU5EbkNqb25oZGxKRkdBTjdvVFF5?=
 =?utf-8?B?WFNLRVRtbVhCM1BnZmJFR1RUem1Vd2dsODVDMDBuTThRWnFsWERXaWFRUTZ6?=
 =?utf-8?B?QlhrNHB3SnoybXowM2pNUDZMSURvdHE2T0NQbHRkQ21sWUN1MjQ3ZVlEaUdv?=
 =?utf-8?Q?rY3EZW6CqY2gHT48tYhApZGhT?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?TmdJUm84c0JtN0lWeGpNaW1BU0lCMERHNS9RQ2h2WjByRTVoVjFFVC83MDJs?=
 =?utf-8?B?UGFBVFpVS2VVZ25hazhtY05DM0VwQk5MZGtTYUJnYzFXSVA1dzZybCtrWG43?=
 =?utf-8?B?MzhmMS9RZE9ldTgrWUQ4QTd0d3k1QTJlQnlESUZUbXBzNUtBR0MxWVVMTDFx?=
 =?utf-8?B?U3J0NlpZeUlFckNINVVLaG5ycmVsZlZnZ08vbjd2eHdmYlgvb1VWZ3VNaDRO?=
 =?utf-8?B?YTkzTm5jYWsrcjl2RHFwVUpuUHlpZVBYMktmTlQ0K2xwSFVkL1MydEZWTEQ0?=
 =?utf-8?B?YUdhdHRwVkVnRHVpSGpjM0h3emJBcGk2TlpibnN5WjVNWUkwQ3V4bUh0NHVK?=
 =?utf-8?B?aTJHeDhwTHVFMEw3V0xTNllwWW1nbU9DTnRNOFFVVHR0L1pBNVBMbi9tWGJ3?=
 =?utf-8?B?TEZLblIyb21xLzBvWkwrcVZnL0I4Ulg4RlNEajNkU0cya2tIczhVdytLYWdV?=
 =?utf-8?B?UnFCc3BoZ0xhNGJEUTNBSTFsdUVLeTVWZERDdW56SkNEa1pVaWY5Rk5DL25x?=
 =?utf-8?B?a0dpV0NuT2JCWkZrNjkwRmdrWWVGNHh0aE80akI1NnoyYm84bHM1UE1TUm1H?=
 =?utf-8?B?dmtHZmR5WVFzbGtabW5ldGpFcUhoZXVvaGtuVjNuVGZPa0R5QVN6U1A4RDQ4?=
 =?utf-8?B?TEl3SlJ3NlJXMnk0YW9uYkU1WUpKRmNVN2o0OG5rQmVFc2NtNUVHbEtvQzQ2?=
 =?utf-8?B?RkhENDZzQTdNKzVxNlAzejIvWEwxUVY3WDg1Z1ZIb3I2TUZsM0ZwZDVjOVU0?=
 =?utf-8?B?SGJaWXkzY2NEdmthS1UzRTB1bVZ1SmZDSmVwZE5ySWhMd0RTcVpGWkVMZUdp?=
 =?utf-8?B?cWJwV3dIaDNuN2pBaGpxd1FoNWszK1NabVhNdFpvZ1E5dXpxSzhseWxsVjV6?=
 =?utf-8?B?dmVjSUtueEhXWHREQ3NYaWNVOXlLUkptRjA3dDFDbVgxWlM2d05kUUFWOUc0?=
 =?utf-8?B?WlpqaUF4NitEUE1RU3c5UnpKeVNSQ0s5UC8zbDJrbnJXRk5COWlsZ0loK1JV?=
 =?utf-8?B?SWN4Q1o0cWlsOFNQT3dIcWRMYVhpdWZ1ZGxXcVJMeDlwVzBEellYL3cvV0sx?=
 =?utf-8?B?RC94Z3VhT1lnMFNCTVgya0NYUDIrQWxsNGlWK1lQT1ZEL2JiaTdjdlN2NEdX?=
 =?utf-8?B?MHJLNVRaTGt6ZU5qZTZJMTVSbDNBZWU2SmZBRmhOY3UveVM1NzlpSEx2cWJF?=
 =?utf-8?B?RU9VRkhaOGw5V1RWWFEza1dtUm5VWnM1bEZWbDdZSXlFS3pnRlNWL3krOVM5?=
 =?utf-8?B?WnB0eW0xekVXM2M4Z1pJSm5kOFdMdHRyZktXVU9QU256YzlHSWlzQ0FtcXFH?=
 =?utf-8?Q?lObGXGbqTyz5Bjzw+ptKsxhdmx8xHAu007?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2797d7e-fa81-4cd8-9fb6-08db46550241
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2023 12:51:52.6845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8IASy3ddA8t4Q3gGD/oaAfj9IhJw270yfpNc09KyJfecRaIKi1+whDGn6jHLbCRP+xvb3kRiGBbv9yIt7x5t0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB8346
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBUaGlzIGZ1bmN0aW9uIGRvZXMgbm90IHJlcXVpcmUgdGhlICJyZXQiIHZhcmlhYmxlIGJlY2F1
c2UgaXQgcmV0dXJucw0KPiBvbmx5IHRoZSByZXN1bHQgb2YgcGFyYW1fc2V0X2Jvb2woKS4NCj4g
DQo+IFJlbW92ZSB1bm5lY2Vzc2FyeSAicmV0IiB2YXJpYWJsZSBhbmQgc2ltcGxpZnkgdGhlIGNv
ZGUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLZW9zZW9uZyBQYXJrIDxrZW9zdW5nLnBhcmtAc2Ft
c3VuZy5jb20+DQpSZXZpZXdlZC1ieTogQXZyaSBBbHRtYW4gPGF2cmkuYWx0bWFuQHdkYy5jb20+
DQoNCj4gLS0tDQo+ICBkcml2ZXJzL3Vmcy9jb3JlL3Vmc2hjZC5jIHwgOCArLS0tLS0tLQ0KPiAg
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCA3IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdWZzL2NvcmUvdWZzaGNkLmMgYi9kcml2ZXJzL3Vmcy9jb3JlL3Vm
c2hjZC5jDQo+IGluZGV4IDk0MzQzMjhiYTMyMy4uNDZjNGVkNDc4YWQwIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL3Vmcy9jb3JlL3Vmc2hjZC5jDQo+ICsrKyBiL2RyaXZlcnMvdWZzL2NvcmUvdWZz
aGNkLmMNCj4gQEAgLTEwOCwxMyArMTA4LDcgQEAgc3RhdGljIGJvb2wgaXNfbWNxX3N1cHBvcnRl
ZChzdHJ1Y3QgdWZzX2hiYSAqaGJhKQ0KPiANCj4gIHN0YXRpYyBpbnQgcGFyYW1fc2V0X21jcV9t
b2RlKGNvbnN0IGNoYXIgKnZhbCwgY29uc3Qgc3RydWN0IGtlcm5lbF9wYXJhbQ0KPiAqa3ApDQo+
ICB7DQo+IC0gICAgICAgaW50IHJldDsNCj4gLQ0KPiAtICAgICAgIHJldCA9IHBhcmFtX3NldF9i
b29sKHZhbCwga3ApOw0KPiAtICAgICAgIGlmIChyZXQpDQo+IC0gICAgICAgICAgICAgICByZXR1
cm4gcmV0Ow0KPiAtDQo+IC0gICAgICAgcmV0dXJuIDA7DQo+ICsgICAgICAgcmV0dXJuIHBhcmFt
X3NldF9ib29sKHZhbCwga3ApOw0KPiAgfQ0KPiANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qga2Vy
bmVsX3BhcmFtX29wcyBtY3FfbW9kZV9vcHMgPSB7DQo+IC0tDQo+IDIuMTcuMQ0KDQo=
