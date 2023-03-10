Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC416B33AB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 02:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjCJBdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 20:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjCJBdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 20:33:02 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075A8468E;
        Thu,  9 Mar 2023 17:32:56 -0800 (PST)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 329MbSi4031085;
        Thu, 9 Mar 2023 20:32:10 -0500
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3p6gvymw9n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Mar 2023 20:32:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JDtThmyjh+52bl0cMltDVfvIiiWqittdwFpmL1KAx0ydpBEsbaFlTnhFAPSBPvs5nwtoAD8ZuBtKbDX4gRJLCOFrwRyCcaqMT+7kSXSxtFh6jHnVw/aqHa/AsI5gbi+D8k+ejdUqEUORW4lLZUjL+vMfDSW7NN7NnnRlMONmpBRmJZs0n2SMfiKe2vims/3L7eMU8UbFtRXYw/dM8uefUzIuhKGRR/bgRG4H2p7QXYPHe9mUstuIa6eYr0EAGW1ZrLxU1l2/+oJtDWVAns6FFXYUXm1Eg/bJbRulOVwO4BLIMlYNgtGI0VXfw1ru//SC8kf/oDi+h7Og2cbWpwJbxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hD1IfpUInV5zsiDpofP+nh6zpbzf350pDHAIYmT9p3Q=;
 b=WFrd/14yyVJweDANecfi+k1duiA+5nQoJdnvgJKh6hFxnFr486oZ+a6qz6bg+NHHWUE6o0OuzwH/4vkv6KqYzVr1biRXSiRt8f5v5JiGFDfH1OWWsT1cb7JJ6Yhz4FGWsrXZrs8mTuvLkIVGcSabaKCMb+VQOjx/wk9uBmFFPKLUj4XI/0Vyor1z1GJWy83pXKUHq3Pit3zSX5H5bleqE+tvunOXcCjlvhIJUYZ/fRu/+Ck8eDDGqhgPy59/hK73k0nOYk69/BqNRBOfcTYAVpO24l3A8i+aYtHijKFx9OpqX79qMyjX879oD7svMBZZjzLena1Qg8QwzhNKOo3FyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hD1IfpUInV5zsiDpofP+nh6zpbzf350pDHAIYmT9p3Q=;
 b=cwkaGIYmKuFfJlp/Xpz5fZQT4pjJZ0MJEaeO5Mwb7p2eaFv0Bo7O91gA8CiEWvAyjW0969oxW/me8us4fFNWZZCuzPDgBtWFBFCALJcZQ4gOjqwYa3Ije56xjwn1iuyW++GdRNL4GgPG16QcVmsaxiLHa9aq6vdABQrr08BWu4g=
Received: from SJ0PR03MB6681.namprd03.prod.outlook.com (2603:10b6:a03:400::6)
 by SJ2PR03MB7041.namprd03.prod.outlook.com (2603:10b6:a03:4f9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Fri, 10 Mar
 2023 01:32:07 +0000
Received: from SJ0PR03MB6681.namprd03.prod.outlook.com
 ([fe80::546:72be:4164:dde7]) by SJ0PR03MB6681.namprd03.prod.outlook.com
 ([fe80::546:72be:4164:dde7%5]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 01:32:07 +0000
From:   "Lee, RyanS" <RyanS.Lee@analog.com>
To:     Rob Herring <robh@kernel.org>,
        =?utf-8?B?4oCcUnlhbg==?= <ryan.lee.analog@gmail.com>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "rf@opensource.cirrus.com" <rf@opensource.cirrus.com>,
        "wangweidong.a@awinic.com" <wangweidong.a@awinic.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "povik+lin@cutebit.org" <povik+lin@cutebit.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "james.schulman@cirrus.com" <james.schulman@cirrus.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "shumingf@realtek.com" <shumingf@realtek.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "ajye_huang@compal.corp-partner.google.com" 
        <ajye_huang@compal.corp-partner.google.com>,
        "ckeepax@opensource.cirrus.com" <ckeepax@opensource.cirrus.com>,
        "herve.codina@bootlin.com" <herve.codina@bootlin.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "flatmax@flatmax.com" <flatmax@flatmax.com>
Subject: RE: [PATCH 2/2] ASoC: dt-bindings: max98363: add soundwire amplifier
 driver
Thread-Topic: [PATCH 2/2] ASoC: dt-bindings: max98363: add soundwire amplifier
 driver
Thread-Index: AQHZR+yGFLq7yrKuk0GvO1rUahNLmq7dgYGAgBWJbbA=
Date:   Fri, 10 Mar 2023 01:32:06 +0000
Message-ID: <SJ0PR03MB6681DC4099DD6627F726A2258ABA9@SJ0PR03MB6681.namprd03.prod.outlook.com>
References: <20230224010814.504016-1-ryan.lee.analog@gmail.com>
 <20230224010814.504016-2-ryan.lee.analog@gmail.com>
 <167721259313.5904.2321260293669174372.robh@kernel.org>
In-Reply-To: <167721259313.5904.2321260293669174372.robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jY214bFpURXpYR0Z3Y0dSaGRHRmNjbTloYldsdVoxd3dPV1E0TkRsaU5p?=
 =?utf-8?B?MHpNbVF6TFRSaE5EQXRPRFZsWlMwMllqZzBZbUV5T1dVek5XSmNiWE5uYzF4?=
 =?utf-8?B?dGMyY3ROV001WVRNM01qY3RZbVZsTXkweE1XVmtMV0poWWpFdE56QXhZV0k0?=
 =?utf-8?B?TURkbFpHSTVYR0Z0WlMxMFpYTjBYRFZqT1dFek56STRMV0psWlRNdE1URmxa?=
 =?utf-8?B?QzFpWVdJeExUY3dNV0ZpT0RBM1pXUmlPV0p2WkhrdWRIaDBJaUJ6ZWowaU1q?=
 =?utf-8?B?azVOU0lnZEQwaU1UTXpNakk0T0RVMU1qVXhPVFkyTWpJM0lpQm9QU0pRTUN0?=
 =?utf-8?B?MFFuaHRNRVUxV1hrdlRrOVdMMEpJVUhoMUwzRktla1U5SWlCcFpEMGlJaUJp?=
 =?utf-8?B?YkQwaU1DSWdZbTg5SWpFaUlHTnBQU0pqUVVGQlFVVlNTRlV4VWxOU1ZVWk9R?=
 =?utf-8?B?MmRWUVVGRmIwTkJRVUZVUjFOQlpqaEdURnBCVmxnNWJWVTRRWFZZVW5sV1pq?=
 =?utf-8?B?SmFWSGRETldSSVNVUkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlNFRkJRVUZFWVVGUlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UlVGQlVVRkNRVUZCUVZGa2FXczFVVUZCUVVGQlFVRkJRVUZCUVVGQlFVbzBR?=
 =?utf-8?B?VUZCUW1oQlIxRkJZVkZDWmtGSVRVRmFVVUpxUVVoVlFXTm5RbXhCUmpoQlkw?=
 =?utf-8?B?RkNlVUZIT0VGaFowSnNRVWROUVdSQlFucEJSamhCV21kQ2FFRkhkMEZqZDBK?=
 =?utf-8?B?c1FVWTRRVnBuUW5aQlNFMUJZVkZDTUVGSGEwRmtaMEpzUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZGUVVGQlFVRkJRVUZCUVdk?=
 =?utf-8?B?QlFVRkJRVUZ1WjBGQlFVZEZRVnBCUW5CQlJqaEJZM2RDYkVGSFRVRmtVVUo1?=
 =?utf-8?B?UVVkVlFWaDNRbmRCU0VsQlluZENjVUZIVlVGWmQwSXdRVWhOUVZoM1FqQkJS?=
 =?utf-8?B?MnRCV2xGQ2VVRkVSVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlVVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVTkJRVUZCUVVGRFpVRkJRVUZaVVVKclFVZHJRVmgzUW5wQlIx?=
 =?utf-8?B?VkJXWGRDTVVGSVNVRmFVVUptUVVoQlFXTm5RblpCUjI5QldsRkNha0ZJVVVG?=
 =?utf-8?B?amQwSm1RVWhSUVdGUlFteEJTRWxCVFdkQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRa0ZCUVVGQlFVRkJRVUZKUVVGQlFVRkJRVDA5SWk4K1BDOXRaWFJo?=
 =?utf-8?B?UGc9PQ==?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6681:EE_|SJ2PR03MB7041:EE_
x-ms-office365-filtering-correlation-id: 8a8aa4e3-f04c-4562-4aa2-08db210742a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mF0QTCR6VptmRbKdVfitFzaOE8jbx4AuC53ryXepg00YCE3UHMslb0DXIzUj9o4uirwMw3nrXGYO3jwdm4Lke9/OcGOTg2yGTtabuY8byeFMoo4Ant1giw6qzthdNKp4wZMXSZrHuO+fJ44LTTRRFWA/LRcdzY0aIKuW+sk4t2JmPvl8dGLjafiffbiLYO6aGXOEPSkX26RPnfh5SLqAHVaonmwcstHQCQ76FJ2ikQQJAD+0jLCgBvJNYuBVnrzp7+Uio4ACLwMxc5qSysRGBnvYCfZTURChLPIALq2nizz1v/nAzatXY474zvKYBdsjZv+yEgUuo+EVhDmgDBJOcfXjk5meGtxpxnaQrHXcpoaELjpprJuqx8mkksdsOetWTN7jTmK6ij4u8c5Ltscc4nRixxe+LRm+Nfk360BBwGPZEXLlADO03YPj6BMrUE7XpCvpjCdZG7l8m7AM0WJ2IrVA6UTZSAtnC7BhgDkEJ04f8dQ9qtdm73vM0yKhFhPVW8rq5gfUxzZ2+RHo9j/EBtBjKGvIb3BzanYB/eGJOlDPloYMPOP5353yNKYi2OAQmsRSQgNQGzk2xaaLAQ7TqK1wI0XwLCVXnxAOYFu0YlC/u+HcjiAkmKDzifi/PaY60NUNUhchrubgdeRuCP1QJY117rwuM/75JkW4FTDFQ7b38WShH912kygtMl5YO7AV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6681.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(366004)(346002)(136003)(39860400002)(451199018)(64756008)(66476007)(38100700002)(66446008)(4326008)(8676002)(55016003)(66556008)(122000001)(66946007)(316002)(8936002)(54906003)(41300700001)(110136005)(38070700005)(52536014)(83380400001)(76116006)(5660300002)(7416002)(478600001)(86362001)(6506007)(9686003)(71200400001)(2906002)(186003)(26005)(966005)(33656002)(7696005)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T2NlWm80MUtvWEp0U2VpOG5qVVJVWEZnU2dIRXpnaFNsZkhFbmNSUE5IaXM2?=
 =?utf-8?B?Y2MvQzl6T1Bsa2JUU3FEdE5Gdm9qd3VxZm5UTXRTUEF4dElsVTBXbDdDKzdq?=
 =?utf-8?B?blAwTU9KVXd4NlI1eWVpQXZzd1pPTzRyTzZqSXA1OU9CeEtlNlo0M3pwK2pO?=
 =?utf-8?B?Z1A4MVBMNDF1Um5GbVVzWDJod201SFB1ajNZZ0ZEVStndU5CbkErWGl2c1Y4?=
 =?utf-8?B?S3RJMTN4UGRoRGRGT3lTRkllcWlGd2V2ZHF6L251OEwvK0JyaGZudU1FMDhQ?=
 =?utf-8?B?V2JtSkFUK3lXSXpRQU9seDdtbWxnZ1JZb01heUV1SHRIZm1qYU9ocVI3N2dq?=
 =?utf-8?B?ZG5PRzFoSHFTaUUxNGxmc2w1VnUrbUtZSU1hOFdtZzBaWW1ma3RaVjQ3SVpR?=
 =?utf-8?B?Mlo1Q3pJYTRBK3gvWXlEWHFvMGY2YXhQUENTblJMRkVIZGQzeTNwMHdaNFVP?=
 =?utf-8?B?NVBaVEgzNmhwL2creGdiM1ZzOFZiVFRCV2pSdkRDbFJxZmVWeVBTaGVaaTBm?=
 =?utf-8?B?KzlYd3A4bllGRUEyM0U0TXJaQVhZbkNxS0JvWUQwbTFmNlNDeUtxVThWTk5J?=
 =?utf-8?B?dVVwQUFIMkhwY2Rxek5jbThSNXJ4dXUrYWoxaFlFa3ZtZld4Rmc3Q2dxRHV5?=
 =?utf-8?B?UExpb1l0Tnh2TEowdkRmak9KMkRsUzVJOTd2UWJLTDEwNmZ4QXlIWVdPbFF0?=
 =?utf-8?B?RXQ0RXNNZlZzODBKcklpQW9NWElzMXZNdGV5NU5hcCtublRUcDU4c3NveFA0?=
 =?utf-8?B?cjYreGlQRGdGd2w0QU5WZllRNXF6MWtQZmc3dysrdXB2U3ZmckY3WHpQYzJC?=
 =?utf-8?B?RDZhaUswTVlaQnU1U21JWStjdHpJZ2tWUFdLYXNsVFRPTGpMNms4eGZnVnpj?=
 =?utf-8?B?TFIrb0hyVGZmNHZmR08yVkFQRGorcHU1Q2R1LzhrY1R0eWI0Y0FadFl1OWZt?=
 =?utf-8?B?T29xTlVYeG5VY29YSW1ROWdvMEhiMHVnL1hKMGFGMUJLaGJMdjBxd1lEbEUw?=
 =?utf-8?B?QU1GSFZ2SFFpKzNoVU5JUkdiUjN1MlZ2YmthSEkySkNKdW5uMFk1UWM3ZVRZ?=
 =?utf-8?B?b05hRXZjSDFkVk5JSXBIODFkRlpjb0FVdWxsN1FhNk9rSjhiUjFESmk2VTFz?=
 =?utf-8?B?MnMxMTIvOHdkK3Q0ajZLRytkQ3ZjOHFHa0loWC9Vakh4bGxQbW1kUjJxMFh4?=
 =?utf-8?B?enJYZkY3M2xPdHh4RUl2NFJKQ3Z2TVdUeTZrdHJ3aFI4L1hSaHNHRklaNE1a?=
 =?utf-8?B?QjY0cEU3UGxseHVucW5oaXRvcklPd0tORFh1eHFSTUUrWXBxTUlQUnRsQVdX?=
 =?utf-8?B?ck9IMFhoOXpBYkpHR0U3YVlmalRwYTZDWlMvd0Z1Z2N0U3ZueG1DSXBuVTMy?=
 =?utf-8?B?d3dzajMyVmE4ZjNuTzY2OHNURXFyZkdReWlyTEhlRTRvU1ZwTDNBajZqTXcr?=
 =?utf-8?B?NWpLWDlZekEwNzlUUFdmNjV0S0RUQnFPQmZsQSt4NWZ6TktHL3Vic0EwRFZG?=
 =?utf-8?B?Q3dicm9vbVA4eVJJZVFJUHZSZnRyRUJIdUc0NzR5WDNHNzVscHNpaXk1dFFn?=
 =?utf-8?B?U3h4VDd3MitDSXl6dGlGRS9QU3B3bEk5N2pnamdtSjlPNk5xeVlXTnQzditD?=
 =?utf-8?B?MmY2S2I0N3lwT3BUeXNpYmN1MGZSUnJnOFdZdFpNeHRVMG84SUJhSUhyQlhk?=
 =?utf-8?B?UlZaNW1sU1Z0MXNLZUxQRlZ0RHR4WXo2aDJDOWkrSEU3RlZYSWcvNDIxQ05B?=
 =?utf-8?B?NGJIaGNMeUFjVHpETnpKY0Q1UVhhY2d6LzBSYU5hZ3VvZVNNbTN1U0tkbTlJ?=
 =?utf-8?B?K0hpeGdYUm9SSHpuSXlxaFBiUUlFQVBwN2w2M0cwNWtiSlZKck1FZUM3TzNE?=
 =?utf-8?B?YWVRcndNeGl2aEloclBENFBtbUkrV1RPejlOcERFUHNDRktJS0tUaEEvUlVo?=
 =?utf-8?B?azJDQnZXb2FSUDJ3dm1JN091S3RCdmk4UU4wMkV2OUtFNkg1M2NCWm1YK2lP?=
 =?utf-8?B?ZXRTWkRuVU9BOTFYQTZuemdSa2FCM2lRRGlwUVBOdzdhRWYwczdEeU9MSG5s?=
 =?utf-8?B?L0VMdk93Uk9WZHZiYm92OHR1NSt4c0ozbGN3Ulp3OVhJMXNVSzA0Y3hCalY5?=
 =?utf-8?Q?pSqZuHI1QNOzLuUbtZSHQUi/i?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a8aa4e3-f04c-4562-4aa2-08db210742a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2023 01:32:06.9648
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Iv4aGWc+4VeFH8rTz7g6k6P1z+vaYv9Nh50Tr/YNYLPhci6j6jCi+GaZUC3mcQtkwonPSJyfTRQUcBw0EanxSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR03MB7041
X-Proofpoint-ORIG-GUID: xJusDcdqWGiE_W5icktIQR9ftxGHRZkb
X-Proofpoint-GUID: xJusDcdqWGiE_W5icktIQR9ftxGHRZkb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-09_14,2023-03-09_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 bulkscore=0 clxscore=1011 priorityscore=1501 phishscore=0 adultscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303100006
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSb2IgSGVycmluZyA8cm9iaEBr
ZXJuZWwub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgRmVicnVhcnkgMjMsIDIwMjMgODozMCBQTQ0K
PiBUbzog4oCcUnlhbiA8cnlhbi5sZWUuYW5hbG9nQGdtYWlsLmNvbT4NCj4gQ2M6IExlZSwgUnlh
blMgPFJ5YW5TLkxlZUBhbmFsb2cuY29tPjsgYWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnOw0K
PiBwaWVycmUtbG91aXMuYm9zc2FydEBsaW51eC5pbnRlbC5jb207IHJmQG9wZW5zb3VyY2UuY2ly
cnVzLmNvbTsNCj4gd2FuZ3dlaWRvbmcuYUBhd2luaWMuY29tOyBicm9vbmllQGtlcm5lbC5vcmc7
IHJvYmgrZHRAa2VybmVsLm9yZzsNCj4gcG92aWsrbGluQGN1dGViaXQub3JnOyBwZXJleEBwZXJl
eC5jejsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gamFtZXMuc2NodWxtYW5AY2ly
cnVzLmNvbTsgbGdpcmR3b29kQGdtYWlsLmNvbTsgc2h1bWluZ2ZAcmVhbHRlay5jb207DQo+IHRp
d2FpQHN1c2UuY29tOyBhanllX2h1YW5nQGNvbXBhbC5jb3JwLXBhcnRuZXIuZ29vZ2xlLmNvbTsN
Cj4gY2tlZXBheEBvcGVuc291cmNlLmNpcnJ1cy5jb207IGhlcnZlLmNvZGluYUBib290bGluLmNv
bTsNCj4ga3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnOyBkZXZpY2V0cmVlQHZnZXIua2Vy
bmVsLm9yZzsNCj4gZmxhdG1heEBmbGF0bWF4LmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDIv
Ml0gQVNvQzogZHQtYmluZGluZ3M6IG1heDk4MzYzOiBhZGQgc291bmR3aXJlDQo+IGFtcGxpZmll
ciBkcml2ZXINCj4gDQo+IFtFeHRlcm5hbF0NCj4gDQo+IA0KPiBPbiBUaHUsIDIzIEZlYiAyMDIz
IDE3OjA4OjE0IC0wODAwLCDigJxSeWFuIHdyb3RlOg0KPiA+IEZyb206IFJ5YW4gTGVlIDxyeWFu
cy5sZWVAYW5hbG9nLmNvbT4NCj4gPg0KPiA+IFRoaXMgcGF0Y2ggYWRkcyBkdC1iaW5kaW5ncyBp
bmZvcm1hdGlvbiBmb3IgQW5hbG9nIERldmljZXMgTUFYOTgzNjMNCj4gPiBTb3VuZFdpcmUgQW1w
bGlmaWVyLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUnlhbiBMZWUgPHJ5YW5zLmxlZUBhbmFs
b2cuY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vYmluZGluZ3Mvc291bmQvYWRpLG1heDk4MzYzLnlh
bWwgICAgICAgICAgfCA1MyArKysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2Vk
LCA1MyBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+IERvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9hZGksbWF4OTgzNjMueWFtbA0KPiA+DQo+
IA0KPiBNeSBib3QgZm91bmQgZXJyb3JzIHJ1bm5pbmcgJ21ha2UgRFRfQ0hFQ0tFUl9GTEFHUz0t
bQ0KPiBkdF9iaW5kaW5nX2NoZWNrJw0KPiBvbiB5b3VyIHBhdGNoIChEVF9DSEVDS0VSX0ZMQUdT
IGlzIG5ldyBpbiB2NS4xMyk6DQo+IA0KPiB5YW1sbGludCB3YXJuaW5ncy9lcnJvcnM6DQo+IA0K
PiBkdHNjaGVtYS9kdGMgd2FybmluZ3MvZXJyb3JzOg0KPiBFcnJvcjoNCj4gRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL2FkaSxtYXg5ODM2My5leGFtcGxlLmR0czoyOS4z
DQo+IC0zMC4xIHN5bnRheCBlcnJvciBGQVRBTCBFUlJPUjogVW5hYmxlIHRvIHBhcnNlIGlucHV0
IHRyZWUNCj4gbWFrZVsxXTogKioqIFtzY3JpcHRzL01ha2VmaWxlLmxpYjo0MzQ6DQo+IERvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9hZGksbWF4OTgzNjMuZXhhbXBsZS5k
dGJdDQo+IEVycm9yIDENCj4gbWFrZVsxXTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9i
cy4uLi4NCj4gbWFrZTogKioqIFtNYWtlZmlsZToxNTA4OiBkdF9iaW5kaW5nX2NoZWNrXSBFcnJv
ciAyDQo+IA0KPiBkb2MgcmVmZXJlbmNlIGVycm9ycyAobWFrZSByZWZjaGVja2RvY3MpOg0KPiAN
Cj4gU2VlDQo+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL3BhdGNod29yay5v
emxhYnMub3JnL3Byb2plY3QvZGV2aWNldA0KPiByZWUtYmluZGluZ3MvcGF0Y2gvMjAyMzAyMjQw
MTA4MTQuNTA0MDE2LTItDQo+IHJ5YW4ubGVlLmFuYWxvZ0BnbWFpbC5jb21fXzshIUEzTmk4Q1Mw
eTJZITdtVERxZG1IZGJ3YnA1RHhtNVJKNjBpDQo+IFRNbE02bWY2VzNaOVBRd1hNQjkyYUJjbkFr
d1pPRHc1b2xCYUZLdG1iaW1PUlVwWG1RMmoyJA0KPiANCj4gVGhlIGJhc2UgZm9yIHRoZSBzZXJp
ZXMgaXMgZ2VuZXJhbGx5IHRoZSBsYXRlc3QgcmMxLiBBIGRpZmZlcmVudCBkZXBlbmRlbmN5DQo+
IHNob3VsZCBiZSBub3RlZCBpbiAqdGhpcyogcGF0Y2guDQo+IA0KPiBJZiB5b3UgYWxyZWFkeSBy
YW4gJ21ha2UgZHRfYmluZGluZ19jaGVjaycgYW5kIGRpZG4ndCBzZWUgdGhlIGFib3ZlIGVycm9y
KHMpLA0KPiB0aGVuIG1ha2Ugc3VyZSAneWFtbGxpbnQnIGlzIGluc3RhbGxlZCBhbmQgZHQtc2No
ZW1hIGlzIHVwIHRvDQo+IGRhdGU6DQo+IA0KPiBwaXAzIGluc3RhbGwgZHRzY2hlbWEgLS11cGdy
YWRlDQoNClRoYW5rIHlvdS4gSSBkaWQgcnVuIHRoZSAnZHRfYmluZGluZ19jaGVjaycgYnVpbGQs
IGJ1dCBzb21lIG1vZHVsZSB3YXMgbm90IGluc3RhbGxlZC4NCkkgc2hhbGwgbW9kaWZ5IHRoZSBl
cnJvciBhbmQgc3VibWl0IGl0IGFnYWluLg0KDQo+IA0KPiBQbGVhc2UgY2hlY2sgYW5kIHJlLXN1
Ym1pdCBhZnRlciBydW5uaW5nIHRoZSBhYm92ZSBjb21tYW5kIHlvdXJzZWxmLiBOb3RlDQo+IHRo
YXQgRFRfU0NIRU1BX0ZJTEVTIGNhbiBiZSBzZXQgdG8geW91ciBzY2hlbWEgZmlsZSB0byBzcGVl
ZCB1cCBjaGVja2luZw0KPiB5b3VyIHNjaGVtYS4gSG93ZXZlciwgaXQgbXVzdCBiZSB1bnNldCB0
byB0ZXN0IGFsbCBleGFtcGxlcyB3aXRoIHlvdXINCj4gc2NoZW1hLg0KDQo=
