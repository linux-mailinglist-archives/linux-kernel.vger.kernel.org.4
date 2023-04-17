Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793D26E540E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 23:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjDQVnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 17:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjDQVnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 17:43:10 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4131B4;
        Mon, 17 Apr 2023 14:43:08 -0700 (PDT)
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33HI2YZc032198;
        Mon, 17 Apr 2023 17:43:04 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3pynpb3t49-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 17:43:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gfI7V5SlHaath3uF7I5ygge43Z/bB7R+u1Gm6J6cD85OQ0ptcav6mGTCz8XTO6j9xUOJ2JnW/mCxaJzFgk9GTBQu5AF4huCcypH9x5KBMg3vYaQQJyoOQli/CWxwaD7fufN9irbk4n+zGViXzN4qM2fiG8xvTp5yCwLyzrR43VD8bmXQmWcoqYDKOlUyeTw+6gOffXE7W1Glf6oaez7Dxpw7oHgG/p8eWERedrHYQWRHcLfico1FTAEb6nJXu83MLotfdC0JGORasurNEIOlHmJAvUdk0GIftlHAczuoJEUNOvHc9ZpD1s9EEilpRi4AfRTk13ojFgKPHExcVbbUcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uxU2SSj0f0tJ85rcgeYcrlEnQaAFHQB8fq+qiQnxY5E=;
 b=jJNLibwsNRsKexEGPRI9IBQ9b8CbtTpJv1NVsLP+UNC/y3QJAxYV7lHvPLd4fp360GFVandKvJCsGJnFko3xjvd0wQW/s4P5jE2t3DHNbhcKu7erfmBc/eAlsH/4d7/AyBSBytzg175hytXQCV9c0AaEYKPGLcfKbPBVx8RRKwq4bQXarhrOh3pVetMF9MAsQQNsbsdFJLDCOZH88qXTSwVTi9VTGN9fGJwriWYt8tlhPWEnqB8+SWutUqipmHKD+tLRynpwfMI4R5+KIZtMy5MBRzz28pMJihvWllmwuxy/RhITpQAjRW8KQzGlBnIrhn5Q0pI/vkSJoTP6N0rzfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxU2SSj0f0tJ85rcgeYcrlEnQaAFHQB8fq+qiQnxY5E=;
 b=7jK3AifY8j24D4v2oKnCB9cL1eH6q3YsPwpFGX/lCEq/1tFFCExtDiB069lUrHDVH7+sj7LUdM4uKl7tjuAKxcen56JKtt4+D1seYAq319wxHKhJ1SnDlu2fDG7bmbT3WOVfvcQU9oUAUJUGF4AWzGf6YhrO+BHRHpaS6f8wAK4=
Received: from MN2PR03MB5197.namprd03.prod.outlook.com (2603:10b6:208:1f0::18)
 by SJ0PR03MB6343.namprd03.prod.outlook.com (2603:10b6:a03:399::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 21:43:01 +0000
Received: from MN2PR03MB5197.namprd03.prod.outlook.com
 ([fe80::c9df:9ae8:8919:f81b]) by MN2PR03MB5197.namprd03.prod.outlook.com
 ([fe80::c9df:9ae8:8919:f81b%4]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 21:43:01 +0000
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
Subject: RE: [PATCH 4/6] dt-bindings: power: supply: add MAX77659 charger
 binding
Thread-Topic: [PATCH 4/6] dt-bindings: power: supply: add MAX77659 charger
 binding
Thread-Index: AQHZFHafezZFG2rId0CSeK7xJHHTP6523OgAgLncwxA=
Date:   Mon, 17 Apr 2023 21:43:01 +0000
Message-ID: <MN2PR03MB5197E655DE2EAACAEA2316578B9C9@MN2PR03MB5197.namprd03.prod.outlook.com>
References: <20221220132250.19383-1-Zeynep.Arslanbenzer@analog.com>
 <20221220132250.19383-5-Zeynep.Arslanbenzer@analog.com>
 <5ba4295f-1197-913c-b1eb-a23798c3badf@linaro.org>
In-Reply-To: <5ba4295f-1197-913c-b1eb-a23798c3badf@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jZW1WNWJtVndMbUZ5YzJ4aGJtSmxibnBsY2x4aGNIQmtZWFJoWEhKdllX?=
 =?utf-8?B?MXBibWRjTURsa09EUTVZall0TXpKa015MDBZVFF3TFRnMVpXVXRObUk0TkdK?=
 =?utf-8?B?aE1qbGxNelZpWEcxelozTmNiWE5uTFdObVptVTRNVFZrTFdSa05qZ3RNVEZs?=
 =?utf-8?B?WkMxaVpqUXhMVFpqT1RRMk5tUmpNRGt4T1Z4aGJXVXRkR1Z6ZEZ4alptWmxP?=
 =?utf-8?B?REUxWmkxa1pEWTRMVEV4WldRdFltWTBNUzAyWXprME5qWmtZekE1TVRsaWIy?=
 =?utf-8?B?UjVMblI0ZENJZ2MzbzlJamN5TnpZaUlIUTlJakV6TXpJMk1qUXhNemMyTkRV?=
 =?utf-8?B?eU5qTTRPQ0lnYUQwaVdIVmhZUzl6SzNORWFtWm9SREl6TWl0cE1Yb3daekFy?=
 =?utf-8?B?VlZNd1BTSWdhV1E5SWlJZ1ltdzlJakFpSUdKdlBTSXhJaUJqYVQwaVkwRkJR?=
 =?utf-8?B?VUZGVWtoVk1WSlRVbFZHVGtOblZVRkJSVzlEUVVGQk1HZFdhVk5rV0VoYVFW?=
 =?utf-8?B?cFNSbkZHUVhabE5YUlliRVZYYjFWRE9UZHRNV05FUVVGQlFVRkJRVUZCUVVG?=
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
x-ms-traffictypediagnostic: MN2PR03MB5197:EE_|SJ0PR03MB6343:EE_
x-ms-office365-filtering-correlation-id: 11b579f4-c303-47e4-4562-08db3f8cb792
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L5MBZsqaM5w4dBigKVLJYDiAzkQC93mMtwd3h4UdEgrZEwmDROk8Iz9R06tRTkte6+35Q3UPv3+KJ3U9xVsbMsvCXIOu9nghHGZLjHkyfKMLGxgKNzrYnDaK7a/EDBe33oQbYS+bosHxQGg3t7vBtSkIO5dogRfyW7CYk5k3SA9V6VDlttr8wX2EjBfXyWGrOQaXTQXfq6I+Eya+9opPkeKB+M907Ghen4ljlYFn7n0PPhgQu3QqfI+tDhVk0wGzGI3p744+9niK2xOZivfSoMKT6NOWAXMG+l8kn99//WaQlTDiep2Ot6APUhFZoFEGteAySTeDEbG4HJkQSoXqPx1hfT5Abqz8z42m8qm4n3/Dnfk6SvlWQzAS4xULfVwqciYpmCwl/PGsV6ewcEBHNCq04hukgwFZiM2AzfOJlMqMWZf9mkotK4Lzp5GCpp5bkKRqMlbAnT5tVJFa+/yIKffgJD62gZ91YQeTNd5HmNOmLMAWeqofgUBLwkvNeYjRBQaLsmh110Y/StbucP1TOU+mL5szDQfzNn+4sYIDMUCNy5KrfJ2qN5GyraxhPz7CXfZ3IM+BZLBzdy7oo+suP89F98sCKXiLxfOYgVEMF/sQ56oUR3DSvlq7dcSecD9spZLVoxyV03OyA5xJh4VYeg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB5197.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(451199021)(7416002)(52536014)(5660300002)(9686003)(83380400001)(122000001)(86362001)(186003)(26005)(6506007)(38100700002)(38070700005)(8936002)(8676002)(54906003)(478600001)(33656002)(7696005)(71200400001)(41300700001)(316002)(55016003)(76116006)(4326008)(66556008)(64756008)(66476007)(66946007)(66446008)(6916009)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QnNwd1A1UXBMQnBrQ0V6eTY2eDdHYWx5WGtxN1VwVGRjY09TOTlLeEVQZUIx?=
 =?utf-8?B?azZWeS84ekJnVTVGcENkc21vN1NyajNmYW5tVUttckpYQjdoalpRZGIzVTFJ?=
 =?utf-8?B?enZWTE1EVGpnYTJPWW1NVEZzV2JhT2owSzBZZENWRFg4ZUdMUEc3OVdsTzRO?=
 =?utf-8?B?N1g4Z0tsSWR2OEwwQXRvTEZ6Vkx3YS80OVpUSHY2RFlieXVERE5CZWR5MDhh?=
 =?utf-8?B?L0xMK2N6U1d3b1lHNTZ1bkZseEovWkF3NW9nNUdjamtZTFNWZEM0ZnJvV0ww?=
 =?utf-8?B?WHZXb1RpRHk0ZENUb3o5MCtNM1J0czUzV2tMZkp6aVpmTkNCSHBoUkpyTTRS?=
 =?utf-8?B?c01iS1B6TUdZQjlxSEljSzVaSWNtTDRmbkpRM09YOUFpVFNJL2s2UnhzdTls?=
 =?utf-8?B?YmtGS3pIWlpxZGN1RFIrWTQzcjRWeGlrMURMY2hzM1RybFhmdVVFTXJhTUQv?=
 =?utf-8?B?MFQ2T2lROEwxaWQ5OHpKQXdPcVozTEJPRG9DaDE3RFRkYURHbjhFV0o0RlZG?=
 =?utf-8?B?UVhiUEIxalZoRW02dG1SUWN0OGVES1ZyRFhFSHdHbWQwT2pnSzFXQkNZNUNa?=
 =?utf-8?B?N0JJcjV1bEV0L1FMT0ZWYjRybENXTFFDTXcvZS9GR2Zjd1M1VzFXM01OaWJE?=
 =?utf-8?B?S2s1Vm5nUm8ra204NDhMTHJKZEFYWHROWGpCWG1qbXNMVlhRZ0lDbm92V20z?=
 =?utf-8?B?d1Ywbnk4bk1oaVIzUnJDWlBqWEFvMTJhZ0NMcUcxUVR0WjhmaTR3NTU5K0V4?=
 =?utf-8?B?Wk5WME9uM2Ixek0yMVcraWhNYzNxQ0NvNjI5bE9naU8ySWYxd1FGb3pWSGtO?=
 =?utf-8?B?QzJ6amg2YVljVHFWZ3hBKytSSUh1bUtRKzVDTEp2SEc2dW9oUlVNc2xsNzZV?=
 =?utf-8?B?d2tIRGZwWXBpamFzZlRqNG95L1BHd1pEQ3QzcSswQzdRN0lLU0RlR1ZyeGdn?=
 =?utf-8?B?d2piemJsYmFINGtaQ0Iya2hVMWxySkJ3cDhhK3kxQkJJbThZQUs1aDVnUW5P?=
 =?utf-8?B?Y01YTk1FS2NxckZlMFA0MHg3Zk4zbURXY0dMUCtsWW9tblFHRUlNVXY2Tktk?=
 =?utf-8?B?L0R0enZyL0JpdXFrRFhoK1VuaGRiWWhtdHRxWk9ZdjRxUEV6cUdlSGM1TEEx?=
 =?utf-8?B?MmxIZTB3bEp3VXBMR1dlVSt3SEJyblorczJ6OGRLdEtCay9OVnJXUlk1Smly?=
 =?utf-8?B?VnE0M0V1OHgzTVpXbkh2Mjl6bjV5WmduMzhucGRjVnBSdzFodUdEK0FnOG0w?=
 =?utf-8?B?RWVJZjAzSXgzdzczV1JTZHkwOG5IaDJLckhBS0IwSlRrbDlvK1ZLSDhERkdN?=
 =?utf-8?B?RjhDOHlIMVpZa09zTldEVzdGZVpBZHN5Yk13NnAzdGY2ZFdhSG03T0tZdzhp?=
 =?utf-8?B?VFJqeWRuN0M0UnREVTVZVmZpVkdseTRmVklVeXNobUJNeWQrMWlxZDZ3MTUx?=
 =?utf-8?B?SnJpVGhUaC9BK3JhNG43NWhHRXJLNjBYYU01clRIdHRKNzgwTzBMUklQSkFl?=
 =?utf-8?B?SWZKZ1pNWCtGd2tOQXJuS2RSUDFqcU1INmhsdFA2TnRxdTN1Nks0MVo0Ny9N?=
 =?utf-8?B?Y1FNa2lzRjY4T2p0THZnMFVyWmE4ampQbk5JazlyRDZhclBzZjJKelRPUW1r?=
 =?utf-8?B?aTVUd0NrcjVvTTduUWJoQ0JUY3p3QUF5bzlUTXQwSnJKYmtpZVpTSDdjM1NE?=
 =?utf-8?B?Q3Z3ZGRqL0pLVVVEaUZaVGVVNzRNeUU5dkdNMWpWNzdrbjFNbisrdDVtOUJx?=
 =?utf-8?B?Z3RJUlhEMXlYOHBETEYyYjdzQWVyQWw1NzAxL0VlMHM2VlUrZWloU1hHWjdU?=
 =?utf-8?B?a3I1QzhZc0YvNFNLcGpUamx3VXJEL0pOblFkNVBPNk9JYkU3R3ltVmQwSEMv?=
 =?utf-8?B?RXBOZlY2MXB0ZERsa3BtVmFpblpjanBsaDFaa1MrT29GL0dvWmdCY0tNKzNm?=
 =?utf-8?B?Q2hXVG9uanpKbWVPdVVjanJvQjdvNnowREVORHBMTG9teWd4TStpcDlSejJl?=
 =?utf-8?B?VVduRTFlNXhiNThQamhCSGpIcXlUbEZnbHBJMWZWN2ZWUTludzVCK1E1N0lv?=
 =?utf-8?B?em5qRzZMb0VUSFZKWi9odnhzNjI1L3E1UzB1L1dtOHFmaTIzQjB3NW9BYUpl?=
 =?utf-8?B?N2lMUXhrQTJSekZVN1ZtT0d4WEdYd1V3djllTEtrVlFvb3hnTEQrWE1mbW9N?=
 =?utf-8?B?SFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB5197.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b579f4-c303-47e4-4562-08db3f8cb792
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2023 21:43:01.0738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JnNPZkKKLMihi+bfhoGYZyH3ztve9CBFzO9UDuqguAH6+/DjykPM196S7poLjmx5PPVBPGuUtuurEg7yrzMdP/EhQ+82DSWS+fHHI3YIpY8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6343
X-Proofpoint-ORIG-GUID: vtobK22eFOpmLce7uTnNmCdH4vZYa3Oi
X-Proofpoint-GUID: vtobK22eFOpmLce7uTnNmCdH4vZYa3Oi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_14,2023-04-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 mlxscore=0 adultscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304170191
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pk9uIDIwLzEyLzIwMjIgMTQ6MjIsIFpleW5lcCBBcnNsYW5iZW56ZXIgd3JvdGU6DQo+PiBUaGlz
IHBhdGNoIGFkZHMgZGV2aWNlIHRyZWUgYmluZGluZyBkb2N1bWVudGF0aW9uIGZvciBNQVg3NzY1
OSBjaGFyZ2VyLg0KPg0KPkRvIG5vdCB1c2UgIlRoaXMgY29tbWl0L3BhdGNoIi4NCj5odHRwczov
L3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjUu
MTcuMS9zb3VyY2UvRG9jdW1lbnRhdGlvbi9wcm9jZXNzL3N1Ym1pdHRpbmctcGF0Y2hlcy5yc3Qq
TDk1X187Pkl3ISFBM05pOENTMHkyWSEtQW5IbUlUaGJCNVE4OF9kRmR2ZUVtc1hsc2ZmbFJYRGFi
ZjZSVkU1eVNSdXNNeFAyNE5FZkFyOFJDc3UyNkxUdm9hSUlNdkVEcjJZeERFQ3JHbE13UjgteXd2
b1I2MnJYQjBXJCANCj4NCj4+IA0KPj4gU2lnbmVkLW9mZi1ieTogTnVyZXR0aW4gQm9sdWN1IDxO
dXJldHRpbi5Cb2x1Y3VAYW5hbG9nLmNvbT4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBaZXluZXAgQXJz
bGFuYmVuemVyIDxaZXluZXAuQXJzbGFuYmVuemVyQGFuYWxvZy5jb20+Pg0KPj4gLS0tDQo+PiAg
Li4uL3Bvd2VyL3N1cHBseS9hZGksbWF4Nzc2NTktY2hhcmdlci55YW1sICAgIHwgNDIgKysrKysr
KysrKysrKysrKysrKw0KPj4gIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB8ICAxICsNCj4+ICAyIGZpbGVzIGNoYW5nZWQsIDQzIGluc2VydGlvbnMoKykNCj4+
ICBjcmVhdGUgbW9kZSAxMDA2NDQgDQo+PiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvcG93ZXIvc3VwcGx5L2FkaSxtYXg3NzY1OS1jaGFyZ2VyLnlhDQo+PiBtbA0KPj4gDQo+PiBk
aWZmIC0tZ2l0IA0KPj4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcG93ZXIv
c3VwcGx5L2FkaSxtYXg3NzY1OS1jaGFyZ2VyLg0KPj4geWFtbCANCj4+IGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Bvd2VyL3N1cHBseS9hZGksbWF4Nzc2NTktY2hhcmdlci4N
Cj4+IHlhbWwNCj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+PiBpbmRleCAwMDAwMDAwMDAwMDAu
LjI0ZjhiNWEyYmQ4NA0KPj4gLS0tIC9kZXYvbnVsbA0KPj4gKysrIGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3Bvd2VyL3N1cHBseS9hZGksbWF4Nzc2NTktY2hhcg0KPj4gKysr
IGdlci55YW1sDQo+PiBAQCAtMCwwICsxLDQyIEBADQo+PiArIyBTUERYLUxpY2Vuc2UtSWRlbnRp
ZmllcjogR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSAlWUFNTCAxLjINCj4+ICstLS0NCj4+
ICskaWQ6IA0KPj4gK2h0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwOi8vZGV2aWNldHJl
ZS5vcmcvc2NoZW1hcy9wb3dlci9zdXBwbA0KPj4gK3kvYWRpLG1heDc3NjU5LWNoYXJnZXIueWFt
bCpfXztJdyEhQTNOaThDUzB5MlkhLUFuSG1JVGhiQjVRODhfZEZkdmVFbQ0KPj4gK3NYbHNmZmxS
WERhYmY2UlZFNXlTUnVzTXhQMjRORWZBcjhSQ3N1MjZMVHZvYUlJTXZFRHIyWXhERUNyR2xNd1I4
LXl3dg0KPj4gK29SNXJLVVIxMSQNCj4+ICskc2NoZW1hOiANCj4+ICtodHRwczovL3VybGRlZmVu
c2UuY29tL3YzL19faHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnkNCj4+
ICthbWwqX187SXchIUEzTmk4Q1MweTJZIS1BbkhtSVRoYkI1UTg4X2RGZHZlRW1zWGxzZmZsUlhE
YWJmNlJWRTV5U1J1c00NCj4+ICt4UDI0TkVmQXI4UkNzdTI2TFR2b2FJSU12RURyMll4REVDckds
TXdSOC15d3ZvUnlfeVdXQlMkDQo+PiArDQo+PiArdGl0bGU6IEJhdHRlcnkgY2hhcmdlciBmb3Ig
TUFYNzc2NTkgUE1JQyBmcm9tIEFESS4NCj4NCj5Ecm9wIGZ1bGwgc3RvcC4NCj4NCj4+ICsNCj4+
ICttYWludGFpbmVyczoNCj4+ICsgIC0gTnVyZXR0aW4gQm9sdWN1IDxOdXJldHRpbi5Cb2x1Y3VA
YW5hbG9nLmNvbT4+DQo+PiArICAtIFpleW5lcCBBcnNsYW5iZW56ZXIgPFpleW5lcC5BcnNsYW5i
ZW56ZXJAYW5hbG9nLmNvbT4+DQo+PiArDQo+PiArZGVzY3JpcHRpb246IHwNCj4+ICsgIFRoaXMg
bW9kdWxlIGlzIHBhcnQgb2YgdGhlIE1BWDc3NjU5IE1GRCBkZXZpY2UuIEZvciBtb3JlIGRldGFp
bHMNCj4+ICsgIHNlZSBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL2FkaSxt
YXg3NzY1OS55YW1sLg0KPj4gKw0KPj4gKyAgVGhlIGNoYXJnZXIgaXMgcmVwcmVzZW50ZWQgYXMg
YSBzdWItbm9kZSBvZiB0aGUgUE1JQyBub2RlIG9uIHRoZSBkZXZpY2UgdHJlZS4NCj4+ICsNCj4+
ICtwcm9wZXJ0aWVzOg0KPj4gKyAgY29tcGF0aWJsZToNCj4+ICsgICAgY29uc3Q6IGFkaSxtYXg3
NzY1OS1jaGFyZ2VyDQo+PiArDQo+PiArICByZWc6DQo+PiArICAgIG1heEl0ZW1zOiAxDQo+PiAr
DQo+PiArICBhZGksZmFzdC1jaGFyZ2UtdGltZXI6DQo+PiArICAgICRyZWY6IC9zY2hlbWFzL3R5
cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQzMg0KPj4gKyAgICBkZXNjcmlwdGlvbjogRmFzdC1j
aGFyZ2Ugc2FmZXR5IHRpbWVyIHZhbHVlIChpbiBob3VycykuDQo+DQo+Tm8sIHVzZSBzdWZmaXhl
cyBmb3IgY29tbW9uIHVuaXRzLg0KDQpIaSBLcnp5c3p0b2YsDQoNClRoYW5rIHlvdSBmb3IgeW91
ciByZXZpZXcuIFRoZSBwb3NzaWJsZSByZWdpc3RlciB2YWx1ZXMgb2YgdGhlIGZhc3QgY2hhcmdl
IHNhZmV0eSB0aW1lciBhcmUgZGVzY3JpYmVkIGluIHRoZSBkYXRhc2hlZXQgYXMgZm9sbG93cy4g
SSB3YXMgdW5kZWNpZGVkIGFib3V0IHVzaW5nIHRoZSBjb21tb24gdW5pdCwgc2Vjb25kLCBhcyBp
dCBtYXkgYWZmZWN0IHRoZSBjb21wcmVoZW5zaWJpbGl0eSBvZiB0aGUgY29kZS4gT2YgY291cnNl
LCBJIGNhbiB1c2Ugc2Vjb25kIGFzIHRoZSBjb21tb24gdW5pdCBpZiB5b3UgdGhpbmsgaXQncyBt
b3JlIGFwcHJvcHJpYXRlLg0KDQowYjAwID0gVGltZXIgZGlzYWJsZWQgDQowYjAxID0gMyBob3Vy
cyANCjBiMTAgPSA1IGhvdXJzIA0KMGIxMSA9IDcgaG91cnMNCg0KPg0KPj4gKw0KPj4gKyAgYWRp
LGZhc3QtY2hhcmdlLW1pY3JvYW1wOg0KPj4gKyAgICBkZXNjcmlwdGlvbjogRmFzdC1jaGFyZ2Ug
Y29uc3RhbnQgY3VycmVudCB2YWx1ZS4NCj4NCj4+ICsNCj4+ICsgIGFkaSx0b3BvZmYtdGltZXI6
DQo+PiArICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQzMg0K
Pj4gKyAgICBkZXNjcmlwdGlvbjogVG9wLU9mZiB0aW1lciB2YWx1ZSAoaW4gbWludXRlcykuDQo+
DQo+Tm8sIHVzZSBzdWZmaXhlcyBmb3IgY29tbW9uIHVuaXRzLg0KDQpTaW1pbGFyIGNhc2U6DQoN
CjBiMDAwID0gMCBtaW51dGVzIA0KMGIwMDEgPSA1IG1pbnV0ZXMgDQowYjAxMCA9IDEwIG1pbnV0
ZXMgDQowYjAxMSA9IDE1IG1pbnV0ZXMgDQowYjEwMCA9IDIwIG1pbnV0ZXMgDQowYjEwMSA9IDI1
IG1pbnV0ZXMgDQowYjExMCA9IDMwIG1pbnV0ZXMgDQowYjExMSA9IDM1IG1pbnV0ZXMNCg0KPg0K
Pg0KPkJlc3QgcmVnYXJkcywNCj5Lcnp5c3p0b2YNCg0KQmVzdCByZWdhcmRzLA0KWmV5bmVwDQo=
