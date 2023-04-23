Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAAC16EC26F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 23:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjDWVRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 17:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjDWVRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 17:17:06 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E82DE4B;
        Sun, 23 Apr 2023 14:17:04 -0700 (PDT)
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33NF3W02030567;
        Sun, 23 Apr 2023 17:16:54 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3q49bbp9jb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 23 Apr 2023 17:16:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RE61TbawPXW8wQF0i9Z2RqfDgoBHU3RbrfkWC4GZlhORXr/zi1ekCAcM5X5bJEzcxluS6/5vQnox1Je0AtIz6Lwv5gflcWjdqGOY4aFIPVEOTpMhdODsyt8F81nK8fjpHj7Yp9n61T7l1C4jfNlvrUB63F3r9cKkcNBuzT5Yreo3TTWqj2H4fLXXHPD+/mH7cUbLCKj7+0Gn2pC4p34vi6rx/x4NNg+nt/Rn/uAQD+8/vpahkW/JWFi8GhLWtDHi4PjpzJAL3K9jxzCy+ffU5b/xNZDDzFoLCjnub/SliS10LVxG3vp41thuGNpw8C8Yk/cM73FgWN/vaCPxcXYGQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EopGcn520uOTzyolog8xsajq6P4mEBdmFP716STJpGk=;
 b=CQf0sXNbm8WAvXGMbpi38wC3nVGRH+D6PVM9RZBAhSpApalZgw53yxgipzQkttJ2Oydo1q/tEt79Du+kDbZoJxPFjRi86nH0xB4+ifWht6Fqi7c1wZbf6apfPP3eWQo2kogt0MouX+n5jkizr6N6aHMe0iOEiZadKZ7HnSBlDWcS14xvWXWceUu8UklyRQBs+bvbr5YHbY7D8SvRRrA0ysZHwecJELGEX1Ez1z9WP6nd5oR05GVV+X66wv/9c9ogU+EDurZT6yRImRv4cTCBtMGO77MDaTgTfW8uxI2nGNRBGiyrADimQ63nwX7hzzCaSqd+neiYf1dKFHq3EO3HhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EopGcn520uOTzyolog8xsajq6P4mEBdmFP716STJpGk=;
 b=JO4RBARDy1jKjA8rnUZ8sPMd5mLsTycbpB6/DVhh0U1CEs1Bxr/bOQoq/KyuO9iuSAwBOwTtghUDBN7RzQMHoPnsw08BeH3lVz9hnSINa2JvdYb4GBuc5FoA0JWhHuoBgbm0mALIPmbq6NUSb+9lhg7Vl1LeMnhlH2ZkfuZq2+Q=
Received: from DM6PR03MB5195.namprd03.prod.outlook.com (2603:10b6:5:240::17)
 by BL1PR03MB5992.namprd03.prod.outlook.com (2603:10b6:208:30a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Sun, 23 Apr
 2023 21:16:52 +0000
Received: from DM6PR03MB5195.namprd03.prod.outlook.com
 ([fe80::e501:a0cb:5b2e:11ec]) by DM6PR03MB5195.namprd03.prod.outlook.com
 ([fe80::e501:a0cb:5b2e:11ec%6]) with mapi id 15.20.6319.033; Sun, 23 Apr 2023
 21:16:51 +0000
From:   "Arslanbenzer, Zeynep" <Zeynep.Arslanbenzer@analog.com>
To:     Lee Jones <lee@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "sre@kernel.org" <sre@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH v2 8/8] mfd: max77658: Add ADI MAX77643/54/58/59 MFD
 Support
Thread-Topic: [PATCH v2 8/8] mfd: max77658: Add ADI MAX77643/54/58/59 MFD
 Support
Thread-Index: AQHZXINeEVIC3kkykUqcpgTtpflY8a8TThwAgCZDlXA=
Date:   Sun, 23 Apr 2023 21:16:51 +0000
Message-ID: <DM6PR03MB519577728975E086D8EB20F38B669@DM6PR03MB5195.namprd03.prod.outlook.com>
References: <20230322055628.4441-1-Zeynep.Arslanbenzer@analog.com>
 <20230322055628.4441-9-Zeynep.Arslanbenzer@analog.com>
 <20230330123136.GF434339@google.com>
In-Reply-To: <20230330123136.GF434339@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jZW1WNWJtVndMbUZ5YzJ4aGJtSmxibnBsY2x4aGNIQmtZWFJoWEhKdllX?=
 =?utf-8?B?MXBibWRjTURsa09EUTVZall0TXpKa015MDBZVFF3TFRnMVpXVXRObUk0TkdK?=
 =?utf-8?B?aE1qbGxNelZpWEcxelozTmNiWE5uTFRJMk1UYzNaVGd4TFdVeU1XTXRNVEZs?=
 =?utf-8?B?WkMxaVpqUXpMVFpqT1RRMk5tUmpNRGt4T1Z4aGJXVXRkR1Z6ZEZ3eU5qRTNO?=
 =?utf-8?B?MlU0TXkxbE1qRmpMVEV4WldRdFltWTBNeTAyWXprME5qWmtZekE1TVRsaWIy?=
 =?utf-8?B?UjVMblI0ZENJZ2MzbzlJamMwTmpZaUlIUTlJakV6TXpJMk56VTRNakExTkRV?=
 =?utf-8?B?NU9UUTJOeUlnYUQwaVpWVXZSbTFUZVZRdk4yaFJWbk5QVDNoaVUybEpTa0p0?=
 =?utf-8?B?YkhRNFBTSWdhV1E5SWlJZ1ltdzlJakFpSUdKdlBTSXhJaUJqYVQwaVkwRkJR?=
 =?utf-8?B?VUZGVWtoVk1WSlRVbFZHVGtOblZVRkJSVzlEUVVGQmNta3pSRzlMU0dKYVFW?=
 =?utf-8?B?RkNZMmhzTkVsbmVGQm1RVVo1UjFobmFVUkZPVGhFUVVGQlFVRkJRVUZCUVVG?=
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
x-ms-traffictypediagnostic: DM6PR03MB5195:EE_|BL1PR03MB5992:EE_
x-ms-office365-filtering-correlation-id: d713a97e-4d37-4474-f298-08db44400e54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vM7OZKcwvzC8sY2D0Qkp+GCwp1PWa8OVQgslC7k31L5FMZTQQOX7Gi54BymtkCOR5xlxCYQQ1aDzzGoJOsCQAmSOPX49nRncl3WNivJk0/8jGkh9kuF3kEBa2Nf6EsUJqi9AumaYMW3rgXkOxyyhuRmrQbUlxcpsDhROAtcooXXk9Kk3e818/rLio8wCTayx/4I70T+zWboX1u++prpi7sSlI4blXt9eamTOoDDB+YbiTB+ugtRT6Gdxs5ACfdKj/AnnxlfddcZeB5aYJ8TWRRuau1KDBTl5RMRqsXlnj3jhwMb0/SOb+jiPrcb6wA0G+1HaQOMFTfOy3veAYQKMX02onmTXA/8WXYuzAMJa35r+0417Vcwrmx7wF9l+UsKPokK7EURG4vYUQaw+ygjbQaVL5qAurPG7owpYxQoVWTCRYpPc8L5kqz9XHbJTZ7wtriol374cttkZJBFN1byq1IANzpIFMMleNUP0/bpwhgMmpJj9tpaGUlS8wO13MXj1P2H/BguqB7JT5id1oMmwuqwiHkvT7HvA5fmye/xXTMoqBTP2+Cv9naKdNXOf4Ygj/Y1yd5duh1GFG92oz9faVRJdoPTdjd3k0M/7HGBsOsKf6FWCL6ncUU+RzJS6QUky
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5195.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(366004)(451199021)(2906002)(7696005)(71200400001)(55016003)(9686003)(6506007)(26005)(186003)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(8676002)(8936002)(316002)(41300700001)(6916009)(4326008)(478600001)(5660300002)(52536014)(54906003)(38070700005)(38100700002)(122000001)(86362001)(33656002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWRHdmtkYldTbXllTFFkVGRlVGVXbXVYVjQ0eVg5cnBFckE0K2R6K1JyRHpl?=
 =?utf-8?B?K3NuM3AvcXM0OStGUlNTaktIcENmM3lBL0xSQ3ZzOVFNNVl3NGdUNmFBVjlO?=
 =?utf-8?B?a3M4QWwrTHRSWVAzM2JVcDFseDRqbDNkSTNFaG9KNVNvNGpEblNVSEd5VjRv?=
 =?utf-8?B?UERhdVNLbDZONGJWa0VDQXBZbXUweW8yK2laLzRDN3FLS1E1SzJlMXVYeDlL?=
 =?utf-8?B?VENjV1lqWVNHck1wOEx0K0tUWVFKZHozVXZheFdyY0dNVXE5cUYzb0dibzZx?=
 =?utf-8?B?d2RKQnZ5WmhHenBIUDg1MUlHc0tCVG12MXl3TXpaeDRVaElpWFJjNFJyL2Ru?=
 =?utf-8?B?LzVuNE14ZHJkNEVoNHpWLy9CbVRabFVidWdHdjRBdEtueWx2dUl0ZXh5ZGZY?=
 =?utf-8?B?cHRzME8xYU1oSlhEeW0yRFdWaEpZbDBGNDlUaHJJTFhHcUgzeXJ6NnJ4ME9p?=
 =?utf-8?B?eFkvUkJ4VGYrWjBLTnkxcmdmRjd0ajJ1cmdvS3R1eTdiL0VTeVZQbjJYTm5V?=
 =?utf-8?B?SU1tZHIzMG0wVXkrYkFSWmgxbXNrK2ZmdDh4TGRLTHZWVFAwc2tnWVc4ZUc0?=
 =?utf-8?B?cWRPUjE5dDA1aXdlai9wYVhLVVFlRlpXb2F1VTFJSC9RZUdxb3p0RTcxUWl3?=
 =?utf-8?B?cEs0MGVUR3VuZTJKeW50dVV1emdQaFdMaXBmS1Q0d0c2WUpJU2MxalhUR1dX?=
 =?utf-8?B?ZDl4aDNCeFNaZWpkTytCblRoaGNDaGJORXdLK0FJZUp5d1kvSytabnU0eVJJ?=
 =?utf-8?B?UDJJZnI2eW81VEVRY0xsYXhHRnZVVGFqeCtCZWZlL0wrVVhGMjdLSEtuNFFS?=
 =?utf-8?B?VWxEZFYzanhINWZNZ3hlaythbTBhUGJLZ3hhSzlDZ1RkNk9FWE10WHpWVjhw?=
 =?utf-8?B?a2R0NWNtaE1WQmNERUZTc3NCZjZjQngrWG5valJFZERUbngzRjNwNDJ5VGdB?=
 =?utf-8?B?VGpPSEVhSHNOMzBCZ2xJWHFQb0c4Q0xEVnZHSWNxcTNuME1tUERYbkVJZFIx?=
 =?utf-8?B?ZzdHR0FtK1c4TE1hMldnanBtZ0U2UFR0SUtXc05QV2VFS045V1AzMUFFbnE3?=
 =?utf-8?B?ZzE1enNsVGY0SWlzWFEwSlJ3OFZzNktwUTk5Ujc0UUdNSkNxcGZ6R1dWS2JM?=
 =?utf-8?B?YiszZGNYTU9yYmJYTjRmV0VXYWFMTXpPcmhjbjBDMkdqRXprUnV2c2xycXI3?=
 =?utf-8?B?ZXl6S2lyeENKL3c3dUVVQ3RvUXc3Q2sxeEROeks4T1Y0MVBzblkzZ0VEazRY?=
 =?utf-8?B?ZGpYZVdOaDRPR21aVUJOSU9OeFdwWUpmQWxqV1BmMms0MnhJaWdmOFBMSk9Q?=
 =?utf-8?B?eHZsTGtpQnNwdk5xaEtMUGVDd0wySGxuS2pjNFZOcmlkVEdlSnFscW9IVEJY?=
 =?utf-8?B?MTdZL0toQkp4QmlGTDhRUlhPbUpYSUhBZ3cxTmRjTVhJWWVLUzdQV1Bqb0Vz?=
 =?utf-8?B?Z3FTTmF0bzhmWEhvTTkwRkJpSFp4d0VGSWdKSTN6Skx5MGVEZkkxOXdXcnJs?=
 =?utf-8?B?T1NmeFVIYjE5aTRma284cVlsY1BremZWMjg3OUYzeE94OExUVXN2TE54elNU?=
 =?utf-8?B?TU01L2RYWGZkWEYvUys4RDlVY2p2MnI1TmwrWTdtN1B0aVFmMVlwV3pKMXNV?=
 =?utf-8?B?dDMwNWF6NzVTWGsvZDk3SzZrOXgvSlRBVUVRcXFlcm5SbkN4ZVhFZWtURU1t?=
 =?utf-8?B?R3E3UFovdkc2NndKeHJMKzhNSTZJeWdPbXNmRU5wZXVQY2JLQWhoZW0xV0lS?=
 =?utf-8?B?SllMTUdydzNBT043SG1EcXlXa2MwSzV6b3pUOG9yREcyT01BQzJFZmNvRTh5?=
 =?utf-8?B?WElwNjh6VG1VeWJCbWMyYnhzanAwSGxnTGRkaEVsdDF6NndRaGNEWTc4bC83?=
 =?utf-8?B?K3ByK21KRlRpR1I1TTZ4ejYzN3RPK0VyQVFwQ216MGdibUxUVHRYL1gyN002?=
 =?utf-8?B?U3hnMG8xMGRDNVFDNGxTZU1JZGltSUFiUmVlVURqTmJmOCtyVGxla01LSUVH?=
 =?utf-8?B?dXV5bS9udEtWdkpPMWIvSmZ0T1p1UlUwa2I3RzVrM1hvblo3bTNIcWlwcjRm?=
 =?utf-8?B?TGxaYzNLaStwT3RqRFRqL2lHUEJ1eFZaeDZGMDFrTVZxYXhEUkZ1Vk1UcGFt?=
 =?utf-8?B?ajNvN1FvcDFDWTVWN252K014SXU1ajBMSTl3WHZ2WFhLVXU0blQrV0owbWNw?=
 =?utf-8?B?Y2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5195.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d713a97e-4d37-4474-f298-08db44400e54
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2023 21:16:51.1745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ngjxeZaBWP+S8EuDRsD1p7iyzX3+YdwF9sHThErB3vUPD7G4VmP4UbSrd6ZH/NN3WPDSs/8KskoxHsdtGIG0mG9K/4eliYTPZMMPtvoF0U0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR03MB5992
X-Proofpoint-GUID: nLoazfyJliIbIgKJ-mg3-FDWTV9Bp4m_
X-Proofpoint-ORIG-GUID: nLoazfyJliIbIgKJ-mg3-FDWTV9Bp4m_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-23_14,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 mlxscore=0 phishscore=0 malwarescore=0 clxscore=1015 adultscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=631
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304230201
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAzMCBNYXIgMjAyMywgTGVlIEpvbmVzIHdyb3RlOg0KDQo+T24gV2VkLCAyMiBNYXIg
MjAyMywgWmV5bmVwIEFyc2xhbmJlbnplciB3cm90ZToNCj4NCj4+IE1GRCBkcml2ZXIgZm9yIE1B
WDc3NjQzL01BWDc3NjU0L01BWDc3NjU4L01BWDc3NjU5IHRvIGVuYWJsZSBpdHMgc3ViDQo+DQo+
UGxlYXNlIGRyb3AgYWxsIHJlZmVyZW5jZXMgdG8gJ01GRCcuDQo+DQo+V2hhdCBhcmUgdGhlc2Ug
ZGV2aWNlcywgcmVhbGx5PyAgSSBzdXNwZWN0IHRoZXkgYXJlIFBNSUNzPw0KPg0KPj4gZGV2aWNl
cy4NCj4+DQo+PiBUaGUgTUFYNzc2NDMgaXMgYSBtdWx0aS1mdW5jdGlvbiBkZXZpY2VzLiBJdCBp
bmNsdWRlcyByZWd1bGF0b3IuDQo+Pg0KPj4gVGhlIE1BWDc3NjU0IGlzIGEgbXVsdGktZnVuY3Rp
b24gZGV2aWNlcy4gSXQgaW5jbHVkZXMgcmVndWxhdG9yIGFuZCANCj4+IGNoYXJnZXIuDQo+Pg0K
Pj4gVGhlIE1BWDc3NjU4IGlzIGEgbXVsdGktZnVuY3Rpb24gZGV2aWNlcy4gSXQgaW5jbHVkZXMg
cmVndWxhdG9yLCANCj4+IGNoYXJnZXIgYW5kIGJhdHRlcnkuDQo+Pg0KPj4gVGhlIE1BWDc3NjU5
IGlzIGEgbXVsdGktZnVuY3Rpb24gZGV2aWNlcy4gSXQgaW5jbHVkZXMgcmVndWxhdG9yIGFuZCAN
Cj4+IGNoYXJnZXIuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogTnVyZXR0aW4gQm9sdWN1IDxOdXJl
dHRpbi5Cb2x1Y3VAYW5hbG9nLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFpleW5lcCBBcnNsYW5i
ZW56ZXIgPFpleW5lcC5BcnNsYW5iZW56ZXJAYW5hbG9nLmNvbT4NCj4+IC0tLQ0KPj4gIGRyaXZl
cnMvbWZkL0tjb25maWcgICAgICAgICAgfCAgMTUgKysNCj4+ICBkcml2ZXJzL21mZC9NYWtlZmls
ZSAgICAgICAgIHwgICAxICsNCj4+ICBkcml2ZXJzL21mZC9tYXg3NzY1OC5jICAgICAgIHwgNDQ4
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+PiAgaW5jbHVkZS9saW51eC9t
ZmQvbWF4Nzc2NTguaCB8ICA4OCArKysrKysrDQo+PiAgNCBmaWxlcyBjaGFuZ2VkLCA1NTIgaW5z
ZXJ0aW9ucygrKQ0KPj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL21mZC9tYXg3NzY1OC5j
ICBjcmVhdGUgbW9kZSAxMDA2NDQgDQo+PiBpbmNsdWRlL2xpbnV4L21mZC9tYXg3NzY1OC5oDQo+
Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWZkL0tjb25maWcgYi9kcml2ZXJzL21mZC9LY29u
ZmlnIGluZGV4IA0KPj4gOGI5Mzg1NmRlNDMyLi43YjRiZTdmYjg2NjIgMTAwNjQ0DQo+PiAtLS0g
YS9kcml2ZXJzL21mZC9LY29uZmlnDQo+PiArKysgYi9kcml2ZXJzL21mZC9LY29uZmlnDQo+PiBA
QCAtODIxLDYgKzgyMSwyMSBAQCBjb25maWcgTUZEX01BWDc3NjUwDQo+PiAgCSAgdGhlIGZvbGxv
d2luZyBmdW5jdGlvbmFsaXRpZXMgb2YgdGhlIGRldmljZTogR1BJTywgcmVndWxhdG9yLA0KPj4g
IAkgIGNoYXJnZXIsIExFRCwgb25rZXkuDQo+Pg0KPj4gK2NvbmZpZyBNRkRfTUFYNzc2NTgNCj4+
ICsJdHJpc3RhdGUgIkFuYWxvZyBEZXZpY2VzIE1BWDc3NjQzL01BWDc3NjU0L01BWDc3NjU4L01B
WDc3NjU5IFBNSUMgU3VwcG9ydCINCj4+ICsJZGVwZW5kcyBvbiBJMkMNCj4+ICsJZGVwZW5kcyBv
biBPRg0KPj4gKwlzZWxlY3QgTUZEX0NPUkUNCj4+ICsJc2VsZWN0IFJFR01BUF9JMkMNCj4+ICsJ
c2VsZWN0IFJFR01BUF9JUlENCj4+ICsJaGVscA0KPj4gKwkgIFNheSBZIGhlcmUgdG8gYWRkIHN1
cHBvcnQgZm9yIEFuYWxvZyBEZXZpY2VzDQo+PiArCSAgTUFYNzc2NDMvTUFYNzc2NTQvTUFYNzc2
NTgvTUFYNzc2NTkgUG93ZXIgTWFuYWdlbWVudCBJQy4NCj4NCj4iTUFYNzc2eHggc2VyaWVzIj8N
Cg0KQXMgSSByZWFsaXplZCBsYXRlciwgbWF4Nzc2MjAsIG1heDc3NjUwLCBtYXg3NzY4NiwgYW5k
IG1heDc3NjkzIGRyaXZlcnMgd2VyZSBtZXJnZWQgdG8gTGludXggYmVmb3JlIG91ciBwYXRjaC4g
VGhleSBhcmUgYWxzbyBQTUlDIGRldmljZXMgYW5kIG91ciBwYXRjaCBkb2VzIG5vdCBjb3ZlciB0
aGVtLiBUaGVyZWZvcmUsIEkgdGhpbmsgaXQgd291bGQgbm90IGJlIGFwcHJvcHJpYXRlIHRvIHVz
ZSBNQVg3NzZ4eC4NCg0KPg0KPj4gKwkgIFRoaXMgaXMgdGhlIGNvcmUgbXVsdGlmdW5jdGlvbg0K
Pg0KPkp1c3QgImNvcmUgZHJpdmVyIiBpcyBmaW5lLg0KPg0KPk9kZCBwbGFjZSB0byBsaW5lIHdy
YXA/DQo+DQo+PiArCSAgZHJpdmVyIGZvciBpbnRlcmFjdGluZyB3aXRoIHRoZSBkZXZpY2UuIEFk
ZGl0aW9uYWwgZHJpdmVycyBjYW4gYmUNCj4NCj4iY2FuIGJlIj8gIEl0J3MgcHJvYmFibHkgcHJl
dHR5IHVzZWxlc3MgaWYgeW91IGRvbid0LCBubz8NCj4NCj4+ICsJICBlbmFibGVkIGluIG9yZGVy
IHRvIHVzZSB0aGUgZm9sbG93aW5nIGZ1bmN0aW9uYWxpdGllcyBvZiB0aGUgZGV2aWNlOg0KPj4g
KwkgIHJlZ3VsYXRvciwgY2hhcmdlci4NCj4NCj4iLi4uIGluIG9yZGVyIHRvIHVzZSB0aGUgcmVn
dWxhciBhbmQgY2hhcmdlciBmdW5jdGlvbmFsaXR5IG9mIHRoZSBkZXZpY2UiLg0KPg0KPj4gIGNv
bmZpZyBNRkRfTUFYNzc2ODYNCj4+ICAJdHJpc3RhdGUgIk1heGltIFNlbWljb25kdWN0b3IgTUFY
Nzc2ODYvODAyIFBNSUMgU3VwcG9ydCINCj4+ICAJZGVwZW5kcyBvbiBJMkMNCj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL21mZC9NYWtlZmlsZSBiL2RyaXZlcnMvbWZkL01ha2VmaWxlIGluZGV4IA0K
Pj4gN2VkM2VmNGE2OThjLi5mNTJhZmY0NTg3OGYgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL21m
ZC9NYWtlZmlsZQ0KPj4gKysrIGIvZHJpdmVycy9tZmQvTWFrZWZpbGUNCj4+IEBAIC0xNjMsNiAr
MTYzLDcgQEAgb2JqLSQoQ09ORklHX01GRF9EQTkxNTApCSs9IGRhOTE1MC1jb3JlLm8NCj4+ICBv
YmotJChDT05GSUdfTUZEX01BWDE0NTc3KQkrPSBtYXgxNDU3Ny5vDQo+PiAgb2JqLSQoQ09ORklH
X01GRF9NQVg3NzYyMCkJKz0gbWF4Nzc2MjAubw0KPj4gIG9iai0kKENPTkZJR19NRkRfTUFYNzc2
NTApCSs9IG1heDc3NjUwLm8NCj4+ICtvYmotJChDT05GSUdfTUZEX01BWDc3NjU4KQkrPSBtYXg3
NzY1OC5vDQo+PiAgb2JqLSQoQ09ORklHX01GRF9NQVg3NzY4NikJKz0gbWF4Nzc2ODYubw0KPj4g
IG9iai0kKENPTkZJR19NRkRfTUFYNzc2OTMpCSs9IG1heDc3NjkzLm8NCj4+ICBvYmotJChDT05G
SUdfTUZEX01BWDc3NzE0KQkrPSBtYXg3NzcxNC5vDQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9t
ZmQvbWF4Nzc2NTguYyBiL2RyaXZlcnMvbWZkL21heDc3NjU4LmMgbmV3IGZpbGUgDQo+PiBtb2Rl
IDEwMDY0NCBpbmRleCAwMDAwMDAwMDAwMDAuLmExYzZkYjQ4ZWIwOA0KPj4gLS0tIC9kZXYvbnVs
bA0KPj4gKysrIGIvZHJpdmVycy9tZmQvbWF4Nzc2NTguYw0KPj4gQEAgLTAsMCArMSw0NDggQEAN
Cj4+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcg0KPj4gKy8q
DQo+PiArICogQ29weXJpZ2h0IChjKSAyMDIzIEFuYWxvZyBEZXZpY2VzLCBJbmMuDQo+PiArICog
QURJIGRyaXZlciBmb3IgdGhlIE1BWDc3NjQzL01BWDc3NjU0L01BWDc3NjU4L01BWDc3NjU5DQo+
PiArICovDQo+DQo+Tm8gbmVlZCB0byBsaXN0IGV2ZXJ5IGRldmljZS4NCj4NCj4iTUFYNzc2eHgg
c2VyaWVzIj8NCj4NCg0KQmVzdCByZWdhcmRzLA0KWmV5bmVwDQo=
