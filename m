Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7902A6D1954
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 10:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbjCaIFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 04:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjCaIFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 04:05:12 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125B81C1D8;
        Fri, 31 Mar 2023 01:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680249891; x=1711785891;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+zuGcmKfpyODdLiaVNUb1v00AT76EZPQ8KflqNIY2OA=;
  b=i3AZfa7D6ksDAuKAQd0dlGhTqImP8RVMeqkTh+GGrQMTTzA9tSrM0cJQ
   W0TXeiohLSCJgu9TcjL4bMqgjp8dVmA13izbq6r0MpRHVWrOQXKy881af
   lii6NbWCfZ/jBLtg4kQe8vK+trczv57otsFe7r0eeIqcPs0mcaIn0y2+m
   QV300q2Lp9n9+30B+JTnFJee9XVUNDKjMbY6iZANlP4jycWR3/pHL25xr
   ywpzdGyg1FounvgEnorvFCZXz8nQmp88nDqlgt7AUqlSW4cMP3itgMDgv
   tEsAC+VbfiQGeJdNFVjzmVJLs7TR9z18u7Se//2P4BEoKW/Av5qY8evVF
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,307,1673884800"; 
   d="scan'208";a="331407581"
Received: from mail-bn7nam10lp2109.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.109])
  by ob1.hgst.iphmx.com with ESMTP; 31 Mar 2023 16:04:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HvNGxCs05UDvIm0lixDNbhb8KqnQ7y7rLuK3U7N//HJwKjS64lAJJ4ULIy3qsztxBoyC6y5BH2CkfpdYc1m8pxei5eh6uiEEDwn3xTk8Wk15gJ6m1UYZmfQYC9hSH6m8Tg0OrywyYv0SSRao/kjehQFvvsLL4RnjS+gIE4zAs8KO8XzxU7dqbF4j6flMy786uBUXsgKiQUGMYXRS3GlUYnkX8qdMmQcX8y0ZhGJiZ2PBZp5Z9a10XQVuLfoyMBfSuHVciLHMMv8+zSWgNQUM4OYvKY5/JUWOx+as3jzroMPVmVj3vDfeQEJYsfaU9vrbdkFvp7/0aKDl7qKzPhQvHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+zuGcmKfpyODdLiaVNUb1v00AT76EZPQ8KflqNIY2OA=;
 b=Fl8UrOM16bFnZfJT/JV8PF+JbrQqCGk3l09CICaqeakZXtDJ3XArTPBEF7q8bJnqSSEPTP+5AhYRTJ64sWMcSKxyayh0u7zroTnqkRyuexZ7F7XewdFgCr0Wbai+IPVRDfpj5eTED7oD/W3ez4BWfKHdPxGfDNXuEQzEYSatQrdWGd1zdnp5zjcEyUj6Q8gFElFvM0uovSbgpdG8SofQMeQsINWPs6fosD1m9NCUqt2cRv8BH3iZ896ta2rSQoE3z2KF9Td4p5DQfARbatsoT04eXzt32qdp/Z2WrZSJPNfEejJhfRZM8ppkdgjm41wAJuPImR+RBnf6PBBWJJEdZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+zuGcmKfpyODdLiaVNUb1v00AT76EZPQ8KflqNIY2OA=;
 b=muZm+JJracB5NKfx3yJZs84gQiJ83srhpgQz2TWKfQ4kDX+o6vjy5JnxL2p+wyyCuIGS2EqZT8/L58zpWLpJ9Zlr3Z0cqHe0pb6RuAj237sj3gulE48OP8h4p7r6iv/do8HlLGMsZ4Pb6+wmL7Ml2NUcqWjRmG92NIsOBqORpAg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6891.namprd04.prod.outlook.com (2603:10b6:5:248::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.21; Fri, 31 Mar
 2023 08:04:49 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%6]) with mapi id 15.20.6254.020; Fri, 31 Mar 2023
 08:04:49 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Avri Altman <Avri.Altman@wdc.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
CC:     Asutosh Das <quic_asutoshd@quicinc.com>,
        "quic_cang@quicinc.com" <quic_cang@quicinc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v2] scsi: ufs: mcq: Limit the amount of inflight requests
Thread-Topic: [PATCH v2] scsi: ufs: mcq: Limit the amount of inflight requests
Thread-Index: AQHZY6T/ZOVDMNKTqk+KmbUOm9tR568Uh6IA
Date:   Fri, 31 Mar 2023 08:04:49 +0000
Message-ID: <b61033dc-ac0c-7a65-661d-690156192c6b@wdc.com>
References: <20230331074650.75-1-avri.altman@wdc.com>
In-Reply-To: <20230331074650.75-1-avri.altman@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6891:EE_
x-ms-office365-filtering-correlation-id: a931e356-0cde-453f-254c-08db31be99a5
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C4WrKHLjlVkMP3VKvFCQ5RlvBfHPbYzWPdry6rEdHaf/X76ePE9DMidYbVMA1FcAHOI80WOPbyisJ8srgjWQejTjPCXtRLgIaLDt+NEO5AJsW3Qiwrumcx9wAh1hvRiS8SY5HfIoOcKdm9RjElro5sph4BafCZ1sHDWJ3Z3hzbEqTpm9RhLrtkOuaJsxDbuobbHQEOeTsr/ftgBkLc16AahlgSyUujaKufI5NX2mFv6tH1oEWbW1sc9VnnWWr1pIKmSBuAm0SjiHSwxj62eNkdtX/IDBhGTkeAM9TwDIAXWV2/y2Yt7TLtyRVZMzquLbpVUVGE7ASAH/o1aegiq0VJPebgAQ+IBAyjEBuXj716ckiSIkNjU4EnJV09AF/Dp8Hzfx35M7PAXgvx3p8abkLnEw482LmtL3M8QWvHjg+X2xbijhRznYmw+ezz7sRhArLmW3xqsqVi+3T2m1SuUIjKCmm4tOlNi2dRblVnFQ3crd1y4kuk8r0KKbX4bmiIbzxTQMAy71rnqmJSLBRbOPqQioZSqYX8uS4evoujQyLAFa+6ozoERek5kCHl16HZ6pu1/4ayd+ahKvfG2qqRlCp4YSYf+yW2xTICVA5Ls+h4qP8miwmauqkv4sypQ8UkUHeP+Wsq5KWqHDpfQVv4OCM/WA3GEIickwuWKMdq23e8R7PXvxO7/4CSDAsvmSSNQg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199021)(6486002)(54906003)(6512007)(478600001)(71200400001)(26005)(6506007)(8936002)(5660300002)(110136005)(316002)(31686004)(186003)(66946007)(8676002)(64756008)(66556008)(66446008)(66476007)(91956017)(76116006)(4326008)(41300700001)(122000001)(82960400001)(558084003)(2616005)(2906002)(38100700002)(31696002)(36756003)(86362001)(38070700005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SVZaSFZVdUZQaGZZbTBibzF1aTRLOVV2cmZpSDRBdXd4ZWpEOFFRbDAva0Vv?=
 =?utf-8?B?YTVHVTM2TnJscC9aZ3UxRzRmdjJ1WDd3Y3FSMjlDVzNRYVRpQlUwWGx6MVha?=
 =?utf-8?B?cnhsMk5FKzBuOHcxRmlIdGxYRGs4WFJzSHdtaGNGWElsWTlYUWJNWTlKOVli?=
 =?utf-8?B?RUF1Zm5iK1FpNVIyQ3lVNEd0NWM4MitqR1A4MGExYXZOZG5uSmdKZWJ5VDFj?=
 =?utf-8?B?ckptYmk1WTVyajZvZE9VeWRzQXpiSFN6Rzg4VGppNTFtRm56M0FwRGUyL2dm?=
 =?utf-8?B?N00xZXpta2ZSR1hVU3NGR3ZDQVVzTENsQUZxRTlSRHg2MElzUXMrd3dpa3VZ?=
 =?utf-8?B?SDNMQ0l6dm85TmFoMERZMjcvWjV0ZzhlVlhPRWc2SEhXS0xSU01TRlJOZ0pG?=
 =?utf-8?B?Q050MzN6eVc1QU1HVXRhZXRjNzZBTURFcFh0NGpFZGJhQm9ZelhEK3RXRS82?=
 =?utf-8?B?Nzc2MmUwcmMwQU5uRWNJdzBVQXhocUFKUkFCZzljTUJZUW5HT2ZYY3FobHdm?=
 =?utf-8?B?QlAxT2lwZDVYUUhiWWlCWk9nZ29YbUt3aHNVaVdUWHJMWERiOW1iMFhPVUs0?=
 =?utf-8?B?TS9lZURKSjJqbm1KL1NWWHNhZzRkcVBaOWROYmUwaXo0MVV3SktEUnZ6UG1x?=
 =?utf-8?B?TmUxS0JqdUoxTGhORk5kYWdJNTJkUXcraHV2YTJSb0dRRUhNK0NXa2ZDV1Nr?=
 =?utf-8?B?SmM4Q0ljblJKOW9QUHhzSStyRE5pS2NSSmlhWTE3K1BISzJEcTE2MUVQYWVG?=
 =?utf-8?B?ZWRtaTdqS01WQUNiaFU4eUhGN0NzS1MzQVVlM0hJRjRQb09XSC9ycGZ6M2hz?=
 =?utf-8?B?a094QWx6R3ZjTWIzTmVGTDk4ZHkvdTdhdkw0SFNUdHJCV0MrUlFBR1dTWmVC?=
 =?utf-8?B?SUdIODRBeCt5dzMycjRVS2ljcVIwRkNweCszM0dKUWE1c3dOWDIrZXhlZ0JX?=
 =?utf-8?B?UG43ZEladlNRTlFSakdkRXhyT0pyVXlFVWp0ZTd0RUhUL1Q2bkt1Sk1LcXd0?=
 =?utf-8?B?SEpmUEhIbSt0NFhCSFN1NzhiMm9Rdnh0TFNhSURPS2R3VE1jWCtpRDBreSt1?=
 =?utf-8?B?V2FDV1NBM2NWNnJYZnpleHdVNW1jZEovQkxHWUVWR2pWUXpFSFhlQ01sZWhM?=
 =?utf-8?B?NUNnYXRXeWtyRkJab2l5NkZUQjBvV3drNG9pSjlGb1MwMm5Tc05Ca24xTzhI?=
 =?utf-8?B?VXRyZklkNmFoMHU0QUY2Z2Q0Z0k1WXZ1aEtWZ05DN1dESVFBV2xCa2NnaHIx?=
 =?utf-8?B?VDVXVmNnbkVySzJodVRscjVEcjF0dFNtSzhEcWlCSm5KS1FiY0NHSHVVSjM5?=
 =?utf-8?B?OW1SNVlXYW1LK1ErT0FFTlZ1QUIxVEtHU291V0tsc0VEenVzUEF1eWI2ODVm?=
 =?utf-8?B?eUhJTWQxRGZLNXIwTUtLNjcyVjBHOWZkU0YzKzVvUUtKUExnd0xhM1RZSnZm?=
 =?utf-8?B?ODNremsxNkY2WFpoUWVYZzR1ckpTZUVJbDUwQ0o3a2s2TThEV1pDZVBUVzUz?=
 =?utf-8?B?Q3A3bWw0WUNFTzBDS0x5Sm52MU4yeVdWdlZyVHpZMlJNUUl6VjROdEQyVXYr?=
 =?utf-8?B?SFF4ZVM4cTBvZnYwSmp6c2txU1YvZW5oRUZxUmJkeEpISXdadlMrc1FKMCsx?=
 =?utf-8?B?STR2TDlFUVdxNnR2Qkt5SVg5V3lyQyswZGNjelkvR0xHNHVqUHdMNUpiZzhN?=
 =?utf-8?B?RW0vM0t5ZzRNNklVNXhOZXI0UC9ycDU3cXJ2WGRsaHJjckRlU1JyK2g0aDFj?=
 =?utf-8?B?NDNkVnZlcnpFZmc0d1FvSUFPQVlxUnNZeWx4S29FbXZqdjcyalJiVitWUlRB?=
 =?utf-8?B?aFdtWlU3VlN0Znp0YW1sbUNkOXpKd2JnYU5DSitPSVRaZzd3dXhtVk5UWmVX?=
 =?utf-8?B?UWFuRkQ3bkwzcDNTYjhMMnkzSll6Rm9pWkpmczIvZHFiRWlYaDZWdDlpY0RR?=
 =?utf-8?B?NjdQZkkva0tHZG9tdWNjOWQ1OU1BeVk1WnJqbFcxR3YzbWNyUGpBQisrOHI4?=
 =?utf-8?B?NmVlR1NJM0xmajBoU0pjOUV2SU9GS1VQcTV2QUtsYXlvMmdGamF5SWhhNTlr?=
 =?utf-8?B?VndWZUx6dkovUTgyTEt2Snd6eHFmSzY5UXZ6UkUvN1NCK3EvWWVCYWlidkVE?=
 =?utf-8?B?azhoZlBURUtxN0ZjTzRxZy9jL0E0bC9Gelo0aCtYajBOMGNLNEkxQWpRc25H?=
 =?utf-8?B?aEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <80C99B13A34589409666466046356A0E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dhtc54znnc+k5wJocLYls50uEmnOHFRybWjwClvyiw7ad3lVlmz31p79Jn4ObT+p3HLiCBLUM9tdKg+uis6+asVVEQv8v2boPgjrTanf5IpCI0kE20NNZ6NQMPAN7uHhs6306SxO8l2JgATaShW820KPKjKq/Sg2Nhy4Qmh3nmuL0Mg4eKvTA2X++I89BHS2XIFVUYwrJK8VvoDe/HSx2TTetbFEsidR3FYaBN9Ubu/jL1ASiL80MCYZsxpYdQ/TrDZ6QTOpWHBhpvejFTVqFncYdk5mBnPn/PwUMeKf/D+FBIzi3s1Js7tKpKNrCKvmh1/vnU+6Y9UMEV9iNyN59GYihS25BO0XUAVH97/c//Csj9kEVNcnAJRjcd0IRdqjrgFuunZWiy8KBUXYgYLlEOWW74Zk/Qd0fM2Ix4OOyBHvxEGuypbEaxqhTz2t8Yy+3ekSr95AZcJqM7oW4vDNDMvtwrxhFdZrnZxnX4npPlfdOmwwqcWmnAbL+IqgFi7UlmqEAIf3k3JBOpuNVGoBIPYcMhhJpN3wgx4TrGHCZiXjZDBaQz6TLlTy/Hjg3xs9FtxIQlnTseIxtJkApHINGJXVLtK8+1JC2aSSQ+KASM9/jdiQFTDjJZKt8aZmnTtmKTYtyuIRbIRzFutFm6DGT58J7iTCYDeY13JfccTcQ7UTRpfDT9TMtROshgIqAZBAPC53IaONKDF60s4rLU1G86SctldhJGq0AW0yeVfBrDPmyAgVqnoPDkZBpVYFMaZoNwQryEWQthmSh4yG8oBjANYdVG0CM7SEpPWZU5xkxkffL8BcpOXm0HqetqIXGdwhcRAlJ8IAnSYI3n7YBJCD4IwNTy8RWC2BGYKq5Cf4stoUb6sVXCPOM8WEKKAqlev7W9re23+HSXv6vSmWbcgVhcXhGvZ5vTyCrBZTIxQuk3E=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a931e356-0cde-453f-254c-08db31be99a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2023 08:04:49.3789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3/EJIchWeAVMfTxre3Crnhq/nvpt5iRh1s84iMuS/jgI4DWOJd2qUqbqgpRiIsMnyInVuSbtbU38RbIuyX34AMRol2TkP6FF1MM4lGjJjpI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6891
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TG9va3MgZ29vZCBjb2RlIHdpc2UsIHRob3VnaCBJIGhhdmUgMCBjbHVlIG9mIFVGUy4NCg0KUmV2
aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+
DQo=
